Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F6BC35254
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 18:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 815EB2082F
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 18:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="onN0KCW9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgBJSHO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 13:07:14 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52233 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbgBJSHO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 13:07:14 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C47E1B868A;
        Mon, 10 Feb 2020 13:07:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HTVFqOnP7gKg4PznPIAuKqXxUgE=; b=onN0KC
        W9e7REn+VZ5VMYpT+UAN2bPnpRQyDGneScwMfVxh+tQueqvSdDXiotHn0FTq5Df9
        GU+9PvQD+Mxg6bItC3g0IFrvpjWC0XXkRAgdb/5JY9Lv+WamoRDh89573ne/oNw2
        SVR9zhuTkLE8Ydc9oRFy9rEz7f2T+H8SPNs6g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nSg2+dGVDg/tbIqODcAn2GvMCnncJzjn
        i8MrFyp4K/F/ZzM9+ot6ftdn4eKBCpYmY1NiH37mGby27veIkN4D+GBEdvqtcCjX
        EOKjrWi4I8/X11+6RF83EeyLE6xkezzw8sx6NNWQab/488wwAE8XfXO4AwQGToFj
        czu9cngZCGQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BD148B8689;
        Mon, 10 Feb 2020 13:07:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DF3A6B8688;
        Mon, 10 Feb 2020 13:07:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Matthew Rogers <mattr94@gmail.com>
Subject: Re: [PATCH v7 05/10] config: split repo scope to local and worktree
References: <pull.478.v6.git.1580268865.gitgitgadget@gmail.com>
        <pull.478.v7.git.1581294660.gitgitgadget@gmail.com>
        <1af0237b8e76f0fd84ccac1e29d0cdc326303d7e.1581294660.git.gitgitgadget@gmail.com>
Date:   Mon, 10 Feb 2020 10:07:01 -0800
In-Reply-To: <1af0237b8e76f0fd84ccac1e29d0cdc326303d7e.1581294660.git.gitgitgadget@gmail.com>
        (Matthew Rogers via GitGitGadget's message of "Mon, 10 Feb 2020
        00:30:54 +0000")
Message-ID: <xmqq8sla1flm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 244C019E-4C30-11EA-B8DE-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Matthew Rogers <mattr94@gmail.com>
>
> Previously when iterating through git config variables, worktree config
> and local config were both considered "CONFIG_SCOPE_REPO".  This was
> never a problem before as no one had needed to differentiate between the
> two cases, but future functionality may care whether or not the config
> options come from a worktree or from the repository's actual local
> config file.  For example, the planned feature to add a '--show-scope'
> to config to allow a user to see which scope listed config options come
> from would confuse users if it just printed 'repo' rather than 'local'
> or 'worktree' as the documentation would lead them to expect.  As well
> as the additional benefit of making the implementation look more like
> how the documentation describes the interface.
>
> To accomplish this we split out what was previously considered repo
> scope to be local and worktree.
>
> The clients of 'current_config_scope()' who cared about
> CONFIG_SCOPE_REPO are also modified to similarly care about
> CONFIG_SCOPE_WORKTREE and CONFIG_SCOPE_LOCAL to preserve previous behavior.
>
> Signed-off-by: Matthew Rogers <mattr94@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  config.c              | 13 ++++++-------
>  config.h              |  3 ++-
>  remote.c              |  3 ++-
>  t/t1308-config-set.sh |  2 +-
>  upload-pack.c         |  3 ++-
>  5 files changed, 13 insertions(+), 11 deletions(-)

Makes sense.  And this step does exactly what it claims to do and
nothing else, which is very good ;-)  

> diff --git a/config.c b/config.c
> index 83bb98d65e..7422bdebb1 100644
> --- a/config.c
> +++ b/config.c
> @@ -1724,15 +1724,12 @@ static int do_git_config_sequence(const struct config_options *opts,
>  	if (user_config && !access_or_die(user_config, R_OK, ACCESS_EACCES_OK))
>  		ret += git_config_from_file(fn, user_config, data);
>  
> -	current_parsing_scope = CONFIG_SCOPE_REPO;
> +	current_parsing_scope = CONFIG_SCOPE_LOCAL;
>  	if (!opts->ignore_repo && repo_config &&
>  	    !access_or_die(repo_config, R_OK, 0))
>  		ret += git_config_from_file(fn, repo_config, data);
>  
> -	/*
> -	 * Note: this should have a new scope, CONFIG_SCOPE_WORKTREE.
> -	 * But let's not complicate things before it's actually needed.
> -	 */
> +	current_parsing_scope = CONFIG_SCOPE_WORKTREE;
>  	if (!opts->ignore_worktree && repository_format_worktree_config) {
>  		char *path = git_pathdup("config.worktree");
>  		if (!access_or_die(path, R_OK, 0))
> @@ -3304,8 +3301,10 @@ const char *config_scope_name(enum config_scope scope)
>  		return "system";
>  	case CONFIG_SCOPE_GLOBAL:
>  		return "global";
> -	case CONFIG_SCOPE_REPO:
> -		return "repo";
> +	case CONFIG_SCOPE_LOCAL:
> +		return "local";
> +	case CONFIG_SCOPE_WORKTREE:
> +		return "worktree";
>  	case CONFIG_SCOPE_CMDLINE:
>  		return "command line";
>  	default:
> diff --git a/config.h b/config.h
> index dcb8c274d4..d3ed41ef8e 100644
> --- a/config.h
> +++ b/config.h
> @@ -299,7 +299,8 @@ enum config_scope {
>  	CONFIG_SCOPE_UNKNOWN = 0,
>  	CONFIG_SCOPE_SYSTEM,
>  	CONFIG_SCOPE_GLOBAL,
> -	CONFIG_SCOPE_REPO,
> +	CONFIG_SCOPE_LOCAL,
> +	CONFIG_SCOPE_WORKTREE,
>  	CONFIG_SCOPE_CMDLINE,
>  };
>  const char *config_scope_name(enum config_scope scope);
> diff --git a/remote.c b/remote.c
> index 5c4666b53a..593ce297ed 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -369,7 +369,8 @@ static int handle_config(const char *key, const char *value, void *cb)
>  	}
>  	remote = make_remote(name, namelen);
>  	remote->origin = REMOTE_CONFIG;
> -	if (current_config_scope() == CONFIG_SCOPE_REPO)
> +	if (current_config_scope() == CONFIG_SCOPE_LOCAL ||
> +	current_config_scope() == CONFIG_SCOPE_WORKTREE)
>  		remote->configured_in_repo = 1;
>  	if (!strcmp(subkey, "mirror"))
>  		remote->mirror = git_config_bool(key, value);
> diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
> index 5f3e71a160..728a2b87ce 100755
> --- a/t/t1308-config-set.sh
> +++ b/t/t1308-config-set.sh
> @@ -259,7 +259,7 @@ test_expect_success 'iteration shows correct origins' '
>  	value=from-repo
>  	origin=file
>  	name=.git/config
> -	scope=repo
> +	scope=local
>  
>  	key=foo.bar
>  	value=from-cmdline
> diff --git a/upload-pack.c b/upload-pack.c
> index a00d7ece6b..c53249cac1 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -1073,7 +1073,8 @@ static int upload_pack_config(const char *var, const char *value, void *unused)
>  		precomposed_unicode = git_config_bool(var, value);
>  	}
>  
> -	if (current_config_scope() != CONFIG_SCOPE_REPO) {
> +	if (current_config_scope() != CONFIG_SCOPE_LOCAL &&
> +	current_config_scope() != CONFIG_SCOPE_WORKTREE) {
>  		if (!strcmp("uploadpack.packobjectshook", var))
>  			return git_config_string(&pack_objects_hook, var, value);
>  	}
