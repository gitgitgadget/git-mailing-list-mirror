From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] format-patch --signature-file <file>
Date: Sun, 18 May 2014 07:20:20 -0400
Message-ID: <20140518112020.GA2153@sigill.intra.peff.net>
References: <1400342542-11256-1-git-send-email-jmmahler@gmail.com>
 <1400342542-11256-2-git-send-email-jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 18 13:20:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wlz8u-0007lb-B4
	for gcvg-git-2@plane.gmane.org; Sun, 18 May 2014 13:20:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbaERLU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 07:20:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:54334 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750866AbaERLUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 07:20:25 -0400
Received: (qmail 1183 invoked by uid 102); 18 May 2014 11:20:25 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 18 May 2014 06:20:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 18 May 2014 07:20:20 -0400
Content-Disposition: inline
In-Reply-To: <1400342542-11256-2-git-send-email-jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249501>

On Sat, May 17, 2014 at 09:02:22AM -0700, Jeremiah Mahler wrote:

> Added feature that allows a signature file to be used with format-patch.
> 
>   $ git format-patch --signature-file ~/.signature -1
> 
> Now signatures with newlines and other special characters can be
> easily included.
> 
> Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>

This is looking much better. I have a few comments still, inline below.

By the way, did you want to add a format.signaturefile config, too? I do
not care myself, but I would imagine most workflows would end up
specifying it every time.

> @@ -1447,6 +1450,16 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  			cover_letter = (config_cover_letter == COVER_ON);
>  	}
>  
> +	if (signature_file) {
> +		if (signature && signature != git_version_string)
> +			die(_("--signature and --signature-file are mutually exclusive"));

Technically "signature" might have come from config, not "--signature"
on the command-line.  But I don't know if that's even worth worrying
about; presumably the user can figure it out if they set the config.

> +		struct strbuf buf = STRBUF_INIT;
> +
> +		strbuf_read_file(&buf, signature_file, 128);
> +		signature = strbuf_detach(&buf, NULL);

Your cover letter mentioned generating an error here. Did you want:

  if (strbuf_read_file(&buf, signature_file, 128) < 0)
	die_errno("unable to read signature file '%s'", signature_file);

or similar?

> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index 9c80633..fb3dc1b 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -762,6 +762,34 @@ test_expect_success 'format-patch --signature="" suppresses signatures' '
>  	! grep "^-- \$" output
>  '
>  
> +cat > expect << EOF

Minor style nits, but we usually omit the whitespace between redirection
operations, and we always quote our here-doc endings unless they
explicitly want to interpolate. So:

  cat >expect <<\EOF

(we also tend to use "<<-\EOF" to drop leading tabs, and then include
them inside the test_expect_success properly indented, but as this
expectation is used in multiple places, it's not unreasonable to keep it
separate).

> +test_expect_success 'format-patch --signature-file file' '
> +	git format-patch --stdout --signature-file expect -1 >output &&
> +	check_patch output &&
> +	fgrep -x -f output expect >output2 &&

Both of these fgrep options are in POSIX, but it looks like this will be
the first use for either of them. I'm not sure if they will give us any
portability problems.

We could probably do something like:

  sed -n '/^-- $/,$p'

if we have to.

> +	diff expect output2

Please use test_cmp here, which adjusts automatically for less-abled
systems where diff is not available.

> +test_expect_success 'format-patch --signature-file=file' '
> +	git format-patch --stdout --signature-file=expect -1 >output &&
> +	check_patch output &&
> +	fgrep -x -f output expect >output2 &&
> +	diff expect output2
> +'

Same comments as above; I note that this is just checking "--foo=bar"
rather than "--foo bar". I don't mind being thorough, but for the most
part we just assume this is tested as part of the parse-options tests,
and don't check it explicitly for each option.

> +test_expect_success 'format-patch --signature and --signature-file die' '
> +	! git format-patch --stdout --signature="foo" --signature-file=expect -1 >output
> +'

Please use test_must_fail instead of "!" here; it is more thorough in
checking that we exited with a non-zero error code (and didn't die from
signal death, for example).

-Peff
