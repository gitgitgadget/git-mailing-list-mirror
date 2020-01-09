Return-Path: <SRS0=y4cH=26=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EADC282DD
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 19:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 079C52077B
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 19:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uE0rRa1/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388713AbgAITGj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jan 2020 14:06:39 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53763 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388667AbgAITGj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jan 2020 14:06:39 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BD89140BD8;
        Thu,  9 Jan 2020 14:06:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=I1fztNKFh7ira9lZiaNqcM3tCfQ=; b=uE0rRa
        1/nH8gkUJfnWAKLY5wg8MaN9JAPBwonCd+W/bmYmYqC9B4OBLVcnEew9jB/3onlD
        A873LYMezQdiAaYA5s5dpNS60t4wr2BrojKaeRaIJctJrMGijYr47oaTKXQy6Zx9
        jPu5tD95l98RScNTRvT8QRge92503ezzbme94=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K/Cs6rdDO8lBAIV4imDzpFIYNEHKVf8G
        uZZrUY6wT1Px5xXjuQUMwMewjq40JxmpuNab9o1+UDXMBeyoJVY5apM64UYBE5Lf
        R5CgI5mdyzUEJhYJ8J4yCkl+GJ4xZ+1oEP4ybwylIFDY00tZWKP+dvA2Zwa/15/B
        udihKpcdpZo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B5EC140BD7;
        Thu,  9 Jan 2020 14:06:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 24CF240BD4;
        Thu,  9 Jan 2020 14:06:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Matthew Rogers <mattr94@gmail.com>
Subject: Re: [PATCH v2 2/4] config: fix config scope enum
References: <pull.478.git.1576631464.gitgitgadget@gmail.com>
        <pull.478.v2.git.1578565001.gitgitgadget@gmail.com>
        <e8e05f39407365a1bf5008820267d362e0cbffd6.1578565001.git.gitgitgadget@gmail.com>
Date:   Thu, 09 Jan 2020 11:06:30 -0800
In-Reply-To: <e8e05f39407365a1bf5008820267d362e0cbffd6.1578565001.git.gitgitgadget@gmail.com>
        (Matthew Rogers via GitGitGadget's message of "Thu, 09 Jan 2020
        10:16:39 +0000")
Message-ID: <xmqqpnfszbyh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 25508834-3313-11EA-9E76-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
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
> two cases.

Hmph, then "fix" on the title is a bit misleading, no?  

The enum may not have been as fine grained as you would have liked,
but if there was nothing broken, then we are doing this not to "fix"
anything.  

A more important thing to explain would probably be why we
(i.e. those who propose this change, those who give favoriable
reviews to it, and those who accept it change to the system) would
want to see finer-grained classification.  What do we expect to be
able to do with the resulting finer-grained set that we wouldn't be
able to with the original, and why is it a good thing?  That is what
readers of the proposed log message of this change would want to
see, I would think.

> Additionally we rename what was CONFIG_SCOPE_REPO to CONFIG_SCOPE_LOCAL
> to reflect its new, more specific meaning.
>
> The clients of 'current_config_scope()' who cared about
> CONFIG_SCOPE_REPO are also modified to similarly care about
> CONFIG_SCOPE_WORKTREE and CONFIG_SCOPE_LOCAL to preserve previous behavior.
>
> Signed-off-by: Matthew Rogers <mattr94@gmail.com>
> ---
>  config.c               | 7 ++-----
>  config.h               | 3 ++-
>  remote.c               | 3 ++-
>  t/helper/test-config.c | 4 +++-
>  upload-pack.c          | 3 ++-
>  5 files changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/config.c b/config.c
> index d75f88ca0c..447a013a15 100644
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
> diff --git a/config.h b/config.h
> index 91fd4c5e96..284d92fb0e 100644
> --- a/config.h
> +++ b/config.h
> @@ -298,7 +298,8 @@ enum config_scope {
>  	CONFIG_SCOPE_UNKNOWN = 0,
>  	CONFIG_SCOPE_SYSTEM,
>  	CONFIG_SCOPE_GLOBAL,
> -	CONFIG_SCOPE_REPO,
> +	CONFIG_SCOPE_LOCAL,
> +	CONFIG_SCOPE_WORKTREE,
>  	CONFIG_SCOPE_CMDLINE,
>  };
>  
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
> diff --git a/t/helper/test-config.c b/t/helper/test-config.c
> index 214003d5b2..6695e463eb 100644
> --- a/t/helper/test-config.c
> +++ b/t/helper/test-config.c
> @@ -44,8 +44,10 @@ static const char *scope_name(enum config_scope scope)
>  		return "system";
>  	case CONFIG_SCOPE_GLOBAL:
>  		return "global";
> -	case CONFIG_SCOPE_REPO:
> +	case CONFIG_SCOPE_LOCAL:
>  		return "repo";
> +	case CONFIG_SCOPE_WORKTREE:
> +		return "worktree";
>  	case CONFIG_SCOPE_CMDLINE:
>  		return "cmdline";
>  	default:
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
