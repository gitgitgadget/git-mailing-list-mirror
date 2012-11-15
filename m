From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2 8/8] send-email: do not prompt for explicit repo ident
Date: Thu, 15 Nov 2012 00:23:16 -0800
Message-ID: <20121115082316.GG8429@elie.Belkin>
References: <20121115003029.GA17550@sigill.intra.peff.net>
 <20121115003640.GH17819@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 15 09:23:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYujX-0004FD-Cr
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 09:23:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754683Ab2KOIXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 03:23:22 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:39531 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754028Ab2KOIXV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 03:23:21 -0500
Received: by mail-da0-f46.google.com with SMTP id n41so569381dak.19
        for <git@vger.kernel.org>; Thu, 15 Nov 2012 00:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=mMwtUHdL6Ui8eudNwcJwYg+bDp//7ZACZT5RmWAI2O4=;
        b=GHIpltr2QtkXI1iXsk68iPOZNYeeIuQObnFXzsk38MfdWOpU3TPamQCvestAh+PSsE
         SzV+Czr6ZJ8PhTCNsyd9I6SYXV8niaox+kw9SxSX3xzIS9pwC2yAR18WjCU+5HOLyDd/
         LU97bFXWx/8UL6LQE6AcmGxrqytn3pvcfvBAzIQqkDfFwNYzb+n1gmrux6G02DtobXJf
         w8lXvuiSKQkRffMM7/DxcaKut3gnqQ47dk4kJaS8tXeChUjSyVBKpBiD4cWuxzfqcxru
         x+7MCjozrm01hztEY5LZojbK34NZQP0mqf1Y91EhMjVbdKhkQrREPKtw6rkuNzbogHh0
         CQGg==
Received: by 10.68.227.230 with SMTP id sd6mr2507069pbc.41.1352967800924;
        Thu, 15 Nov 2012 00:23:20 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id x6sm9362676pav.29.2012.11.15.00.23.19
        (version=SSLv3 cipher=OTHER);
        Thu, 15 Nov 2012 00:23:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20121115003640.GH17819@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209809>

Jeff King wrote:

> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -191,15 +191,47 @@ test_expect_success $PREREQ 'Show all headers' '
>  
>  test_expect_success $PREREQ 'Prompting works' '
>  	clean_fake_sendmail &&
> -	(echo "Example <from@example.com>"
> -	 echo "to@example.com"
> +	(echo "to@example.com"
>  	 echo ""
>  	) | GIT_SEND_EMAIL_NOTTY=1 git send-email \
>  		--smtp-server="$(pwd)/fake.sendmail" \
>  		$patches \
>  		2>errors &&
> +		grep "^From: A U Thor <author@example.com>\$" msgtxt1 &&
> +		grep "^To: to@example.com\$" msgtxt1
> +'

The indentation seems strange here --- are the new "grep" lines
continuations of the git send-email line?

It's probably easier to change the structure completely:

	clean_fake_sendmail &&
	echo to@examples.com >prompt.input &&
	echo >>prompt.input &&
	GIT_SEND_EMAIL_NOTTY=1 \
		git send-email --smtp-server=... $patches <prompt.input &&
	grep "^From: A U Thor <authorident@example.com>\$" msgtxt1 &&
	grep "^To: to@example.com\$" msgtxt1

> +test_expect_success $PREREQ,AUTOIDENT 'implicit ident prompts for sender' '
> +	clean_fake_sendmail &&
> +	(echo "Example <from@example.com>" &&
> +	 echo "to@example.com" &&
> +	 echo ""
> +	) |
> +	(sane_unset GIT_AUTHOR_NAME &&
> +	 sane_unset GIT_AUTHOR_EMAIL &&
> +	 sane_unset GIT_COMMITTER_NAME &&
> +	 sane_unset GIT_COMMITTER_EMAIL &&
> +	 GIT_SEND_EMAIL_NOTTY=1 git send-email \
> +		--smtp-server="$(pwd)/fake.sendmail" \
> +		$patches \
> +		2>errors &&
>  		grep "^From: Example <from@example.com>\$" msgtxt1 &&
>  		grep "^To: to@example.com\$" msgtxt1
> +	)
> +'

Likewise:

	clean_fake_sendmail &&
	echo "Example <from@example.com>" >prompt.in &&
	echo to@example.com >>prompt.in
	echo >>prompt.in &&
	(
		sane_unset GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL &&
		sane_unset GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL &&
		GIT_SEND_EMAIL_NOTTY=1 \
			git send-email --smtp-server=... $patches <prompt.in
	) &&
	grep "^From: Example <from@example.com>\$" msgtxt1 &&
	grep "^To: to@example.com\$" msgtxt1

> +test_expect_success $PREREQ,!AUTOIDENT 'broken implicit ident aborts send-email' '
> +	clean_fake_sendmail &&
> +	(sane_unset GIT_AUTHOR_NAME &&
> +	 sane_unset GIT_AUTHOR_EMAIL &&
> +	 sane_unset GIT_COMMITTER_NAME &&
> +	 sane_unset GIT_COMMITTER_EMAIL &&
> +	 GIT_SEND_EMAIL_NOTTY=1 && export GIT_SEND_EMAIL_NOTTY &&
> +	 test_must_fail git send-email \
> +		--smtp-server="$(pwd)/fake.sendmail" \
> +		$patches </dev/null 2>errors.out &&
> +		test_i18ngrep "tell me who you are" errors.out
> +	)
>  '

Likewise:

	clean_fake_sendmail &&
	(
		sane_unset GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL &&
		sane_unset GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL &&
		GIT_SEND_EMAIL_NOTTY=1 \
			git send-email --smtp-server=... $patches </dev/null 2>err
	) &&
	test_i18ngrep "[Tt]ell me who you are" err

For what it's worth, with or without such changes,
Acked-by: Jonathan Nieder <jrnieder@gmail.com>
