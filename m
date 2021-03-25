Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7D0C433DB
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 00:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD4C961A12
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 00:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239203AbhCYAg6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 20:36:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:48242 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232494AbhCYAgg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 20:36:36 -0400
Received: (qmail 16805 invoked by uid 109); 25 Mar 2021 00:36:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 25 Mar 2021 00:36:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24206 invoked by uid 111); 25 Mar 2021 00:36:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 24 Mar 2021 20:36:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 24 Mar 2021 20:36:35 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config.c: remove last remnant of GIT_TEST_GETTEXT_POISON
Message-ID: <YFvbE1K2tZ5ych7z@coredump.intra.peff.net>
References: <20210111144740.6092-3-avarab@gmail.com>
 <patch-1.1-ea968affa8c-20210324T233254Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-ea968affa8c-20210324T233254Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 25, 2021 at 12:36:09AM +0100, Ævar Arnfjörð Bjarmason wrote:

> Remove a use of GIT_TEST_GETTEXT_POISON added in f276e2a4694 (config:
> improve error message for boolean config, 2021-02-11).
> 
> This was simultaneously in-flight with my d162b25f956 (tests: remove
> support for GIT_TEST_GETTEXT_POISON, 2021-01-20) which removed the
> rest of the GIT_TEST_GETTEXT_POISON code.

Yay. :)

> diff --git a/config.c b/config.c
> index 6428393a414..870d9534def 100644
> --- a/config.c
> +++ b/config.c
> @@ -1180,20 +1180,6 @@ static void die_bad_number(const char *name, const char *value)
>  	}
>  }
>  
> -NORETURN
> -static void die_bad_bool(const char *name, const char *value)
> -{
> -	if (!strcmp(name, "GIT_TEST_GETTEXT_POISON"))
> -		/*
> -		 * We explicitly *don't* use _() here since it would
> -		 * cause an infinite loop with _() needing to call
> -		 * use_gettext_poison().
> -		 */
> -		die("bad boolean config value '%s' for '%s'", value, name);
> -	else
> -		die(_("bad boolean config value '%s' for '%s'"), value, name);
> -}
> -
>  int git_config_int(const char *name, const char *value)
>  {
>  	int ret;
> @@ -1268,7 +1254,7 @@ int git_config_bool(const char *name, const char *value)
>  {
>  	int v = git_parse_maybe_bool(value);
>  	if (v < 0)
> -		die_bad_bool(name, value);
> +		die(_("bad boolean config value '%s' for '%s'"), value, name);
>  	return v;
>  }

This code change looks good, but...

> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index e0dd5d65ced..2280c2504ac 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -679,7 +679,7 @@ test_expect_success 'invalid unit boolean' '
>  	git config commit.gpgsign "1true" &&
>  	test_cmp_config 1true commit.gpgsign &&
>  	test_must_fail git config --bool --get commit.gpgsign 2>actual &&
> -	test_i18ngrep "bad boolean config value .1true. for .commit.gpgsign." actual
> +	grep "bad boolean config value .1true. for .commit.gpgsign." actual
>  '

why are we losing test_i18ngrep here? The message is still marked for
translation. I know we've discussed dropping all of the test_i18n
helpers, but that seems unrelated to the rest of the patch.

-Peff
