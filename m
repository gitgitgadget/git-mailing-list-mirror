From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] format-patch --signature-file <file>
Date: Mon, 19 May 2014 06:48:11 -0400
Message-ID: <20140519104810.GA17492@sigill.intra.peff.net>
References: <1400444522-15523-1-git-send-email-jmmahler@gmail.com>
 <1400444522-15523-2-git-send-email-jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 19 12:48:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmL7H-0007Df-7L
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 12:48:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753562AbaESKsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 06:48:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:54931 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751317AbaESKsO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 06:48:14 -0400
Received: (qmail 4275 invoked by uid 102); 19 May 2014 10:48:14 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 19 May 2014 05:48:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 May 2014 06:48:11 -0400
Content-Disposition: inline
In-Reply-To: <1400444522-15523-2-git-send-email-jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249574>

On Sun, May 18, 2014 at 01:22:02PM -0700, Jeremiah Mahler wrote:

> @@ -742,6 +743,8 @@ static int git_format_config(const char *var, const char *value, void *cb)
>  	}
>  	if (!strcmp(var, "format.signature"))
>  		return git_config_string(&signature, var, value);
> +	if (!strcmp(var, "format.signaturefile"))
> +		return git_config_string(&signature_file, var, value);

Should this be git_config_pathname? That would handle tilde-expansion.

> +test_expect_success 'format-patch --signature-file=file' '
> +	git format-patch --stdout --signature-file=expect -1 >output &&
> +	check_patch output &&
> +	sed -n "/^-- $/,\$p" <output | head --lines=-2 | tail --lines=+2 >output2 &&
> +	test_cmp expect output2
> +'

I don't think --lines is portable (it's not even POSIX), nor is a
negative value for head (but a "+" form for tail is). You can replace
the "head" call with a "$d" sed command, and tail should be fine with
"-n +2". Like:

  sed -n '$d; /^-- $/,$p' | tail -n +2

You can also do it in one sed like:

  sed -n '$d; /^-- $/,${//!p}'

but that is starting to look a bit like line-noise. ;)

> +test_expect_success 'format-patch with format.signaturefile config' '
> +	git config format.signaturefile expect &&
> +	git format-patch --stdout -1 >output &&
> +	check_patch output &&
> +	sed -n "/^-- $/,\$p" <output | head --lines=-2 | tail --lines=+2 >output2 &&
> +	test_cmp expect output2 &&
> +	git config --unset-all format.signaturefile
> +'

You might want to use "test_config format.signaturefile expect" here,
which handles unsetting after the test. Besides being one line shorter,
it also cleans up when the middle part of the test fails.

You could also use "git -c", but I think setting the actual config in a
file is a more realistic test.

-Peff
