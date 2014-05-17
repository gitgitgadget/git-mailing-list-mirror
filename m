From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v2] format-patch --signature-file <file>
Date: Sat, 17 May 2014 00:25:48 -0700
Message-ID: <20140517072548.GA18239@hudson.localdomain>
References: <1400203881-2794-1-git-send-email-jmmahler@gmail.com>
 <1400203881-2794-2-git-send-email-jmmahler@gmail.com>
 <20140516081445.GA21468@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 17 09:25:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlZ0H-0007Kb-Mz
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 09:25:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757123AbaEQHZy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2014 03:25:54 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:36308 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757047AbaEQHZx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2014 03:25:53 -0400
Received: by mail-pb0-f51.google.com with SMTP id ma3so3591479pbc.10
        for <git@vger.kernel.org>; Sat, 17 May 2014 00:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=SZGxyNHtnwP+uzEpHwOwDQE/2mnMNnQQTdzxWL7K7Fc=;
        b=zfZcTWU2b59ZlvjYZO+ro1yq4hN9l/0GproY6gX4pAHUnoy4uXwlt9dEmKpk5WKzLS
         u8uMTMhPBOaUVm9KGCopxuZw88GS8ygT3014NCLcl0gK24yBSJ7YV7AHBtDH/tNeDSXq
         /n8VWZEHZMEtoEoCkmi9Nirxkbvjc9TaYev2w+BXxqNBe9lzsvxnNt79YJIIf2zYsx1j
         35gL46b72SeOKxrK/FSggOPDRnuRqJhWpcQxekA+KtRErDfwiN8TTZs63x3KsKRThYxW
         B4LEVj/Gt89yPQvsq2K7N8aak9C1a6LFMQqd+5Au8Oy+Y+o3/FWn3PfcKkOzN36BM+Jr
         OU+w==
X-Received: by 10.68.254.70 with SMTP id ag6mr26696580pbd.33.1400311553063;
        Sat, 17 May 2014 00:25:53 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id id10sm18299591pbc.35.2014.05.17.00.25.49
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 17 May 2014 00:25:51 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Sat, 17 May 2014 00:25:48 -0700
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20140516081445.GA21468@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249458>


On Fri, May 16, 2014 at 04:14:45AM -0400, Jeff King wrote:
> On Thu, May 15, 2014 at 06:31:21PM -0700, Jeremiah Mahler wrote:
...
> 
> A few questions/comments:
> 
> > +static int signature_file_callback(const struct option *opt, const char *arg,
> > +							int unset)
> > +{
> > +	const char **signature = opt->value;
> > +	static char buf[1024];
> > +	size_t sz;
> > +	FILE *fd;
> > +
> > +	fd = fopen(arg, "r");
> > +	if (fd) {
> > +		sz = sizeof(buf);
> > +		sz = fread(buf, 1, sz - 1, fd);
> > +		if (sz) {
> > +			buf[sz] = '\0';
> > +			*signature = buf;
> > +		}
> > +		fclose(fd);
> > +	}
> > +	return 0;
> > +}
> 
> We have routines for reading directly into a strbuf, which eliminates
> the need for this 1024-byte limit. We even have a wrapper that can make
> this much shorter:
> 
>   struct strbuf buf = STRBUF_INIT;
> 
>   strbuf_read_file(&buf, arg, 128);
>   *signature = strbuf_detach(&buf, NULL);
> 

Yes, that is much cleaner.
The memory returned by strbuf_detach() will have to be freed as well.

> I notice that you ignore any errors. Is that intentional (so that we
> silently ignore missing --signature files)? If so, should we actually
> treat it as an empty file (e.g., in my code above, we always set
> *signature, even if the file was missing)?
> 
> Finally, I suspect that:
> 
>   cd path/in/repo &&
>   git format-patch --signature-file=foo
> 
> will not work, as we chdir() to the toplevel before evaluating the
> arguments. You can fix that either by using parse-option's OPT_FILENAME
> to save the filename, followed by opening the file after all arguments
> are processed; or by manually fixing up the filename.
> 

Yes, it wouldn't have worked.
Using OPT_FILENAME is a much better solution.

> Since parse-options already knows how to do this fixup (it does it for
> OPT_FILENAME), it would be nice if it were a flag rather than a full
> type, so you could specify at as an option to your callback here:
> 
> > +		{ OPTION_CALLBACK, 0, "signature-file", &signature, N_("signature-file"),
> > +				N_("add a signature from contents of a file"),
> > +			    PARSE_OPT_NONEG, signature_file_callback },
> 
> Noticing your OPT_NONEG, though, I wonder if you should simply use an
> OPT_FILENAME. I would expect --no-signature-file to countermand any
> earlier --signature-file on the command-line (or if we eventually grow a
> config option, which seems sensible, it would tell git to ignore the
> option). The usual ordering for that is:
> 

Another case is when both --signature="foo" and --no-signature-file are used.
Currently this would only negate the file option which would allow
the --signature option to be used.

>   1. Read config and store format.signatureFile as a string
>      "signature_file".
> 
>   2. Parse arguments. --signature-file=... sets signature_file, and
>      --no-signature-file sets it to NULL.
> 
>   3. If signature_file is non-NULL, load it.
> 
> And I believe OPT_FILENAME will implement (2) for you.
> 
> One downside of doing it this way is that you need to specify what will
> happen when both "--signature" (or format.signature) and
> "--signature-file" are set. With your current code, I think
> "--signature=foo --signature-file=bar" will take the second one. I think
> it would be fine to prefer one to the other, or to just notice that both
> are set and complain.
> 
> -Peff

Having --signature-file override --signature seems simpler to implement.
The signature variable has a default value which complicates
determining whether it was set or not.

Thanks for the great suggestions.

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
