Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E24E8FDC3
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 01:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjJDBKz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 21:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjJDBKz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 21:10:55 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C851AAF
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 18:10:49 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 364762DF27;
        Tue,  3 Oct 2023 21:10:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=gq6bzIbIBShGyQU1/f7tJUymq3apHNISM+JoQ0
        EYQf8=; b=tKkSibJunLEPOor3INGQz/nA0xVZ2Oyj8zY1Sk7g9DNKNRIrho4/gA
        aO3dA/ZNJtI89Clw+xTmcqzDqc5GY7CrVtjJR7IWjJbIZoMJCILkcxgyHkoVm02o
        AIL+rHyYLkEwjJ14+QHRLGUHG6M6pA5HCl5FlIZm9w8VvylHOmWsE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 21AFB2DF26;
        Tue,  3 Oct 2023 21:10:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9BD9D2DF25;
        Tue,  3 Oct 2023 21:10:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/6] submodule--helper: use submodule_from_path in
 set-{url,branch}
In-Reply-To: <20231003185047.2697995-1-heftig@archlinux.org> (Jan Alexander
        Steffens's message of "Tue, 3 Oct 2023 20:50:42 +0200")
References: <0a0a157f88321d25fdb0be771a454b3410a449f3.camel@archlinux.org>
        <20231003185047.2697995-1-heftig@archlinux.org>
Date:   Tue, 03 Oct 2023 18:10:43 -0700
Message-ID: <xmqqmswztcoc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D80B5FE0-6252-11EE-B223-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jan Alexander Steffens (heftig)" <heftig@archlinux.org> writes:

> The commands need a path to a submodule but treated it as the name when
> modifying the .gitmodules file, leading to confusion when a submodule's
> name does not match its path.

Thanks for noticing and fixing this common mix-up.

> Because calling submodule_from_path initializes the submodule cache, we
> need to manually trigger a reread before syncing, as the cache is
> missing the config change we just made.

> Signed-off-by: Jan Alexander Steffens (heftig) <heftig@archlinux.org>

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index f6871efd95..f376466a5e 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2902,19 +2902,26 @@ static int module_set_url(int argc, const char **argv, const char *prefix)
>  		N_("git submodule set-url [--quiet] <path> <newurl>"),
>  		NULL
>  	};
> +	const struct submodule *sub;
>  
>  	argc = parse_options(argc, argv, prefix, options, usage, 0);
>  
>  	if (argc != 2 || !(path = argv[0]) || !(newurl = argv[1]))
>  		usage_with_options(usage, options);
>  
> -	config_name = xstrfmt("submodule.%s.url", path);
> +	sub = submodule_from_path(the_repository, null_oid(), path);
>  
> +	if (!sub)
> +		die(_("no submodule mapping found in .gitmodules for path '%s'"),
> +		    path);
> +
> +	config_name = xstrfmt("submodule.%s.url", sub->name);

Looks correct.

>  	config_set_in_gitmodules_file_gently(config_name, newurl);
> -	sync_submodule(path, prefix, NULL, quiet ? OPT_QUIET : 0);
> +
> +	repo_read_gitmodules (the_repository, 0);

Style.  No extra space between function name and "(".

But more importantly, is this sufficient?  repo_read_gitmodules()
does not seem to clear the cache and build its contents from scratch
(as submodule_cache_check_init() bypasses itself upon second call).

The code is correct because submodule-config.c::config_from() does
set .overwrite to true, so submodule.name.url would be overwritten
to the new value, I think, but somebody else who is more familiar
with the recent submodule code may want to sanity check my analysis.

> +	sync_submodule(sub->path, prefix, NULL, quiet ? OPT_QUIET : 0);

Is the use of "sub" still safe here?  

I think it is safe as repo_read_gitmodules() did not rebuild the
in-core cache from scratch but did selective overwrite, so the
in-core instance "sub" is still valid, but again somebody else who
is more familiar with the recent submodule code may want to sanity
check.

> @@ -2942,19 +2949,26 @@ static int module_set_branch(int argc, const char **argv, const char *prefix)
>  		N_("git submodule set-branch [-q|--quiet] (-b|--branch) <branch> <path>"),
>  		NULL
>  	};
> +	const struct submodule *sub;
>  
>  	argc = parse_options(argc, argv, prefix, options, usage, 0);
>  
>  	if (!opt_branch && !opt_default)
>  		die(_("--branch or --default required"));
>  
>  	if (opt_branch && opt_default)
>  		die(_("options '%s' and '%s' cannot be used together"), "--branch", "--default");
>  
>  	if (argc != 1 || !(path = argv[0]))
>  		usage_with_options(usage, options);
>  
> -	config_name = xstrfmt("submodule.%s.branch", path);
> +	sub = submodule_from_path(the_repository, null_oid(), path);
> +
> +	if (!sub)
> +		die(_("no submodule mapping found in .gitmodules for path '%s'"),
> +		    path);
> +
> +	config_name = xstrfmt("submodule.%s.branch", sub->name);
>  	ret = config_set_in_gitmodules_file_gently(config_name, opt_branch);

This side happens not to require re-reading of gitmodules file,
because, unlike the URL helper, we do not care what we have in the
in-core cache is stale.  It is correct but feels a bit brittle.

