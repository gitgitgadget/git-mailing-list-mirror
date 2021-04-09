Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA346C433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 15:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 858BC60FE8
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 15:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbhDIPVc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 11:21:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:46268 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234076AbhDIPVc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 11:21:32 -0400
Received: (qmail 31630 invoked by uid 109); 9 Apr 2021 15:21:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 09 Apr 2021 15:21:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12384 invoked by uid 111); 9 Apr 2021 15:21:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 09 Apr 2021 11:21:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 9 Apr 2021 11:21:16 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/3] config: unify code paths to get global config
 paths
Message-ID: <YHBw7D/fEUdCckc8@coredump.intra.peff.net>
References: <a23382059bb57022dd1e40d1c2c9a11307b0ff3b.1617891426.git.ps@pks.im>
 <cover.1617975637.git.ps@pks.im>
 <dddc85bcf54e9b19f1612cf2a5be928dcb2bad7d.1617975637.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dddc85bcf54e9b19f1612cf2a5be928dcb2bad7d.1617975637.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 09, 2021 at 03:43:25PM +0200, Patrick Steinhardt wrote:

> There's two callsites which assemble global config paths, once in the
> config loading code and once in the git-config(1) builtin. We're about
> to implement a way to override global config paths via an environment
> variable which would require us to adjust both sites.
> 
> Unify both code paths into a single `git_global_config()` function which
> returns both paths for `~/.gitconfig` and the XDG config file. This will
> make the subsequent patch which introduces the new envvar easier to
> implement.

Seems like a good step forward. There is one minor issue with the
implementation, though.

> diff --git a/builtin/config.c b/builtin/config.c
> index 02ed0b3fe7..604a0973a5 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -671,9 +671,9 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>  	}
>  
>  	if (use_global_config) {
> -		char *user_config = expand_user_path("~/.gitconfig", 0);
> -		char *xdg_config = xdg_config_home("config");
> +		const char *user_config, *xdg_config;
>  
> +		git_global_config(&user_config, &xdg_config);

The pointer out-parameters make sense here, since we need to return two
values. I notice they became const, so the function will hold on to
ownership of the memory.

> @@ -688,10 +688,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>  		if (access_or_warn(user_config, R_OK, 0) &&
>  		    xdg_config && !access_or_warn(xdg_config, R_OK, 0)) {
>  			given_config_source.file = xdg_config;
> -			free(user_config);
>  		} else {
>  			given_config_source.file = user_config;
> -			free(xdg_config);
>  		}

...which is why we drop these free() calls. So far so good.

> +void git_global_config(const char **user, const char **xdg)
> +{
> +	static const char *user_config, *xdg_config;
> +
> +	if (!user_config) {
> +		user_config = expand_user_path("~/.gitconfig", 0);
> +		xdg_config = xdg_config_home("config");
> +	}
> +
> +	*user = user_config;
> +	*xdg = xdg_config;
> +}

And here in the implementation we hold on to the static values forever.

I think your "did we initialize already" check isn't robust, though.
expand_user_path() can return NULL, in which case every call would
trigger a re-initialization (even leaking xdg_config if it was set in
the last round).

So I think you'd need a separate "static int initialized" variable.

That said, I wonder if we should just pass ownership of the memory to
the caller. It is a minor inconvenience that they will have to free()
the result, but we're already doing that. And it removes any possibility
of thread unsafety.

I guess it doesn't match git_system_config() as well, then. But arguably
it should also just pass ownership (it also has only a handful of
callers, and freeing the result would not be a big deal).

I'm OK with either solution, though.

-Peff
