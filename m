From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 2/2] checkout: proper error message on 'git checkout
 foo bar --'
Date: Wed, 25 Sep 2013 15:43:06 -0700
Message-ID: <20130925224306.GC9464@google.com>
References: <1380137471-26972-1-git-send-email-Matthieu.Moy@imag.fr>
 <1380137471-26972-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
	jc@sahnwaldt.de
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Sep 26 00:43:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOxng-00016g-GS
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 00:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755178Ab3IYWnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Sep 2013 18:43:12 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:59713 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754819Ab3IYWnL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 18:43:11 -0400
Received: by mail-pa0-f51.google.com with SMTP id kp14so438375pab.24
        for <git@vger.kernel.org>; Wed, 25 Sep 2013 15:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=BLjI1HT8WdY+bt7uEEEbTOj5vs2tkTwnmvv7IpkD0BI=;
        b=yK52YO8Tj1SyVk34Ni0vCyzRK3nAaHmXDIKr/UWiE+7hkrwuLeSPkE76/Tv9N7bSyC
         I90rb07NqLfFuEZvDiH2U7zzX7KdfDKvNrBjAWxa1QWycgRfDHgKrGG+ZeXe0w87MwEg
         SlxR6Qiekn6L/Hn9JhxOxCXN2gCHIWvGpHmSb1V+3C10pI2swo5B8W2Bmh0itHjqcrjy
         DnK6hxQ+xBm1ef8MxxdRcrSwBePreFD543amybd1lqonx/5MU9PbwcOBhOwuZgSPT+EB
         bAUK9H5syzZ8bWCRHfaCg+mP7bTX78QdQdU4n/C8RyOavHGQk0WDPf6rz2LwrPtrjiPe
         POqA==
X-Received: by 10.66.118.71 with SMTP id kk7mr1833820pab.14.1380148989999;
        Wed, 25 Sep 2013 15:43:09 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id oh2sm50072404pbb.3.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 25 Sep 2013 15:43:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1380137471-26972-2-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235377>

Hi,

Matthieu Moy wrote:

> error: pathspec 'foo' did not match any file(s) known to git.
> error: pathspec 'bar' did not match any file(s) known to git.
> error: pathspec '--' did not match any file(s) known to git.
>
> This patch fixes it by walking through the argument list to find the
> "--", and now complains about the number of references given.

Good catch.  Just some nits below.

[...]
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -882,6 +882,7 @@ static int parse_branchname_arg(int argc, const char **argv,
>  	unsigned char branch_rev[20];
>  	const char *arg;
>  	int has_dash_dash;
> +	int i;
>  
>  	/*
>  	 * case 1: git checkout <ref> -- [<paths>]
> @@ -925,7 +926,15 @@ static int parse_branchname_arg(int argc, const char **argv,
>  		return 1;
>  
>  	arg = argv[0];
> -	has_dash_dash = (argc > 1) && !strcmp(argv[1], "--");
> +	has_dash_dash = 0;
> +	for (i = 0; i < argc; i++) {
> +		if (!strcmp(argv[i], "--")) {
> +			has_dash_dash = i;
> +			break;
> +		}
> +	}
> +	if (has_dash_dash >= 2)
> +		die(_("only one reference expected, %d given."), has_dash_dash);

(The argv[0] == "--" case is handled a few lines above.)

At first I skipped the loop and read this as "if (there are two or more
'--' arguments)".  How about doing one of the following to make it
easier to read quickly?

 (a) rename has_dash_dash here to dash_dash_pos, or
 (b) put the check in the loop, like so:

	has_dash_dash = 0;
	for (i = 0; i < ...) {
		if (strcmp(argv[i], "--"))
			continue;
		if (i == 0)	/* case (2) */
			return 1;
		if (i > 1)
			die(_("only one reference expected ...);

		has_dash_dash = 1;
		break;
	}

[...]
> --- a/t/t2010-checkout-ambiguous.sh
> +++ b/t/t2010-checkout-ambiguous.sh
> @@ -47,4 +47,10 @@ test_expect_success 'disambiguate checking out from a tree-ish' '
>  	git diff --exit-code --quiet
>  '
>  
> +test_expect_success C_LOCALE_OUTPUT 'accurate error message with more than one ref' '
> +	test_must_fail git checkout HEAD master -- 2>actual &&
> +	echo "fatal: only one reference expected, 2 given." >expect &&
> +	test_cmp expect actual

Nits:

 - if we change this from 'fatal' to 'error' or reword the message as
   part of a libification some day, it would be a nuisance to have to
   update this test.  Maybe a 'grep' could make it more flexible.

 - most of the test (though not the interesting part) can run in the
   !C_LOCALE_OUTPUT case if you use test_i18ncmp or test_i18ngrep

 - even the check for "2" can run in the !C_LOCALE_OUTPUT case. :)
   e.g. something like

	test_must_fail ... 2>actual &&
	grep 2 actual &&
	test_i18ngrep "one reference expected, 2 given" actual

Thanks,
Jonathan
