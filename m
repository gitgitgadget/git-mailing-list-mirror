Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FB0C433E6
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 19:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54736652AD
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 19:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhCHT3p (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 14:29:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:55942 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230173AbhCHT3L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 14:29:11 -0500
Received: (qmail 26777 invoked by uid 109); 8 Mar 2021 19:29:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 Mar 2021 19:29:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21169 invoked by uid 111); 8 Mar 2021 19:29:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Mar 2021 14:29:11 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 8 Mar 2021 14:29:10 -0500
From:   Jeff King <peff@peff.net>
To:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Subject: Re: [PATCH 5/7] init: remove git_init_db_config() while fixing leaks
Message-ID: <YEZ7Bl2nCcY1gAtf@coredump.intra.peff.net>
References: <pull.899.git.1615228580.gitgitgadget@gmail.com>
 <d30365d967651c6090635ec564d2ed2d051e8aec.1615228580.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d30365d967651c6090635ec564d2ed2d051e8aec.1615228580.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 08, 2021 at 06:36:18PM +0000, Andrzej Hunt via GitGitGadget wrote:

> @@ -212,10 +200,7 @@ static int create_default_files(const char *template_path,
>  	int reinit;
>  	int filemode;
>  	struct strbuf err = STRBUF_INIT;
> -
> -	/* Just look for `init.templatedir` */
> -	init_db_template_dir = NULL; /* re-set in case it was set before */
> -	git_config(git_init_db_config, NULL);
> +	const char *init_template_dir = NULL;
>  
>  	/*
>  	 * First copy the templates -- we might have the default
> @@ -226,7 +211,8 @@ static int create_default_files(const char *template_path,
>  	 * values (since we've just potentially changed what's available on
>  	 * disk).
>  	 */
> -	copy_templates(template_path);
> +	git_config_get_value("init.templatedir", &init_template_dir);
> +	copy_templates(template_path, init_template_dir);
>  	git_config_clear();
>  	reset_shared_repository();
>  	git_config(git_default_config, NULL);
> @@ -422,8 +408,8 @@ int init_db(const char *git_dir, const char *real_git_dir,
>  	}
>  	startup_info->have_repository = 1;
>  
> -	/* Just look for `core.hidedotfiles` */
> -	git_config(git_init_db_config, NULL);
> +	/* Ensure `core.hidedotfiles` is processed */
> +	git_config(platform_core_config, NULL);

There are some subtle ordering dependencies in init_db(), because it may
start in one git repository, but then create and shift into another.

It's hard to see the ordering just from the diff. I think this change is
OK. The platform_core_config bits are loaded at the same moment, and
it's only the extra git_config() call in create_default_files() that
goes away. That _could_ be overwriting the platform bits with something
else, but I think that was not the intent of the code. And I think it's
impossible, because the intervening calls are not moving from one repo
to the other.

-Peff
