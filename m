From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] format-patch --signature-file <file>
Date: Fri, 16 May 2014 04:14:45 -0400
Message-ID: <20140516081445.GA21468@sigill.intra.peff.net>
References: <1400203881-2794-1-git-send-email-jmmahler@gmail.com>
 <1400203881-2794-2-git-send-email-jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 10:15:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlDIX-0005D4-FG
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 10:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756780AbaEPIPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 04:15:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:52859 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756469AbaEPIOs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 04:14:48 -0400
Received: (qmail 3574 invoked by uid 102); 16 May 2014 08:14:48 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 16 May 2014 03:14:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 May 2014 04:14:45 -0400
Content-Disposition: inline
In-Reply-To: <1400203881-2794-2-git-send-email-jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249274>

On Thu, May 15, 2014 at 06:31:21PM -0700, Jeremiah Mahler wrote:

> Added feature that allows a signature file to be used with format-patch.
> 
>   $ git format-patch --signature-file ~/.signature -1
> 
> Now signatures with newlines and other special characters can be
> easily included.

I think this version looks nicer than the original.

A few questions/comments:

> +static int signature_file_callback(const struct option *opt, const char *arg,
> +							int unset)
> +{
> +	const char **signature = opt->value;
> +	static char buf[1024];
> +	size_t sz;
> +	FILE *fd;
> +
> +	fd = fopen(arg, "r");
> +	if (fd) {
> +		sz = sizeof(buf);
> +		sz = fread(buf, 1, sz - 1, fd);
> +		if (sz) {
> +			buf[sz] = '\0';
> +			*signature = buf;
> +		}
> +		fclose(fd);
> +	}
> +	return 0;
> +}

We have routines for reading directly into a strbuf, which eliminates
the need for this 1024-byte limit. We even have a wrapper that can make
this much shorter:

  struct strbuf buf = STRBUF_INIT;

  strbuf_read_file(&buf, arg, 128);
  *signature = strbuf_detach(&buf, NULL);

I notice that you ignore any errors. Is that intentional (so that we
silently ignore missing --signature files)? If so, should we actually
treat it as an empty file (e.g., in my code above, we always set
*signature, even if the file was missing)?

Finally, I suspect that:

  cd path/in/repo &&
  git format-patch --signature-file=foo

will not work, as we chdir() to the toplevel before evaluating the
arguments. You can fix that either by using parse-option's OPT_FILENAME
to save the filename, followed by opening the file after all arguments
are processed; or by manually fixing up the filename.

Since parse-options already knows how to do this fixup (it does it for
OPT_FILENAME), it would be nice if it were a flag rather than a full
type, so you could specify at as an option to your callback here:

> +		{ OPTION_CALLBACK, 0, "signature-file", &signature, N_("signature-file"),
> +				N_("add a signature from contents of a file"),
> +			    PARSE_OPT_NONEG, signature_file_callback },

Noticing your OPT_NONEG, though, I wonder if you should simply use an
OPT_FILENAME. I would expect --no-signature-file to countermand any
earlier --signature-file on the command-line (or if we eventually grow a
config option, which seems sensible, it would tell git to ignore the
option). The usual ordering for that is:

  1. Read config and store format.signatureFile as a string
     "signature_file".

  2. Parse arguments. --signature-file=... sets signature_file, and
     --no-signature-file sets it to NULL.

  3. If signature_file is non-NULL, load it.

And I believe OPT_FILENAME will implement (2) for you.

One downside of doing it this way is that you need to specify what will
happen when both "--signature" (or format.signature) and
"--signature-file" are set. With your current code, I think
"--signature=foo --signature-file=bar" will take the second one. I think
it would be fine to prefer one to the other, or to just notice that both
are set and complain.

-Peff
