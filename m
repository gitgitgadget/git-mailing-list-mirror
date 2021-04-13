Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1833C433ED
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 07:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF1BE61221
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 07:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhDMHZ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 03:25:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:50800 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229641AbhDMHZ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 03:25:26 -0400
Received: (qmail 28594 invoked by uid 109); 13 Apr 2021 07:25:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Apr 2021 07:25:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23119 invoked by uid 111); 13 Apr 2021 07:25:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Apr 2021 03:25:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 13 Apr 2021 03:25:05 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 1/3] config: rename `git_etc_config()`
Message-ID: <YHVHUef1sEtDNcy2@coredump.intra.peff.net>
References: <cover.1618238567.git.ps@pks.im>
 <cover.1618297711.git.ps@pks.im>
 <34bdbc27d618d7467d2caf6844d8c06bdcb8545b.1618297711.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <34bdbc27d618d7467d2caf6844d8c06bdcb8545b.1618297711.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 13, 2021 at 09:11:44AM +0200, Patrick Steinhardt wrote:

> While at it, the function is also refactored to pass memory ownership to
> the caller. This is done to better match semantics of
> `git_global_config()`, which is going to be introduced in the next
> commit.

I think this turned out nicely. There are only two callers, one of which
is already handling freeing the global config. In the other:

> diff --git a/builtin/config.c b/builtin/config.c
> index f71fa39b38..02ed0b3fe7 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -695,7 +695,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>  		}
>  	}
>  	else if (use_system_config) {
> -		given_config_source.file = git_etc_gitconfig();
> +		given_config_source.file = git_system_config();
>  		given_config_source.scope = CONFIG_SCOPE_SYSTEM;
>  	} else if (use_local_config) {
>  		given_config_source.file = git_pathdup("config");

We "leak" the result, but I think it is actually an improvement. As you
can see in the context, we are sometimes allocating the field in other
code paths, so this is takes us closer to a world where we can actually
call free(given_config_source.file) to fix the leak in all of the other
code paths. :)

(I don't think any of that needs to be dealt with in this series, of
course).

-Peff
