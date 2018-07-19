Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 117071F597
	for <e@80x24.org>; Thu, 19 Jul 2018 12:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731557AbeGSM64 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 08:58:56 -0400
Received: from david.siemens.de ([192.35.17.14]:40707 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731531AbeGSM64 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 08:58:56 -0400
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by david.siemens.de (8.15.2/8.15.2) with ESMTPS id w6JCFkw2002259
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jul 2018 14:15:46 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id w6JCFkmC025145;
        Thu, 19 Jul 2018 14:15:46 +0200
Date:   Thu, 19 Jul 2018 14:15:45 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Martin =?UTF-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] t/t5534: do not unset GIT_COMMITTER_EMAIL for other
 tests
Message-ID: <20180719141545.48358a26@md1pvb1c.ad001.siemens.net>
In-Reply-To: <20180719121409.6143-1-henning.schild@siemens.com>
References: <xmqqbmb4lbhh.fsf@gitster-ct.c.googlers.com>
        <20180719121409.6143-1-henning.schild@siemens.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Looking at "what is cooking" i assume i should not add/fold this to/in
the serien anymore. So it comes as a separate patch on top.

Henning

Am Thu, 19 Jul 2018 14:14:09 +0200
schrieb Henning Schild <henning.schild@siemens.com>:

> Unsetting the varibale for good can have unwanted effects for new
> tests added in the future It also meant we needed to hardcode the
> value for "user.signingkey".
> Move the unset into a subshell, get rid of the hardcoded
> "committer@example.com", and switch the GPG variant to using
> test_config just like GPGSM.
> 
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  t/t5534-push-signed.sh | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
> index 0cb88aa6f..f6d674156 100755
> --- a/t/t5534-push-signed.sh
> +++ b/t/t5534-push-signed.sh
> @@ -194,10 +194,12 @@ test_expect_success GPG 'fail without key and
> heed user.signingkey' ' 
>  	EOF
>  
> -	unset GIT_COMMITTER_EMAIL &&
> -	git config user.email hasnokey@nowhere.com &&
> -	test_must_fail git push --signed dst noop ff +noff &&
> -	git config user.signingkey committer@example.com &&
> +	test_config user.email hasnokey@nowhere.com &&
> +	(
> +		unset GIT_COMMITTER_EMAIL &&
> +		test_must_fail git push --signed dst noop ff +noff
> +	) &&
> +	test_config user.signingkey $GIT_COMMITTER_EMAIL &&
>  	git push --signed dst noop ff +noff &&
>  
>  	(
> @@ -241,11 +243,14 @@ test_expect_success GPGSM 'fail without key and
> heed user.signingkey x509' ' E_O_F
>  
>  	EOF
> -	unset GIT_COMMITTER_EMAIL &&
> +
>  	test_config user.email hasnokey@nowhere.com &&
>  	test_config user.signingkey "" &&
> -	test_must_fail git push --signed dst noop ff +noff &&
> -	test_config user.signingkey committer@example.com &&
> +	(
> +		unset GIT_COMMITTER_EMAIL &&
> +		test_must_fail git push --signed dst noop ff +noff
> +	) &&
> +	test_config user.signingkey $GIT_COMMITTER_EMAIL &&
>  	git push --signed dst noop ff +noff &&
>  
>  	(

