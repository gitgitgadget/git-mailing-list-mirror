Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C083CC4332F
	for <git@archiver.kernel.org>; Sun,  9 Oct 2022 23:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbiJIXkA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Oct 2022 19:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbiJIXjd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2022 19:39:33 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F43C564EE
        for <git@vger.kernel.org>; Sun,  9 Oct 2022 16:12:12 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8246A1C61F6;
        Sun,  9 Oct 2022 18:36:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wmdR/o392QqhHF+mLsbY9jPBvtAsJD/NIVNrzt
        pnZQU=; b=Q3nQqxhHslC/PH5SbT/dWwpxUu/gxGXDn4o5kVnaYv9/UJOIUeDD2M
        vF1Ig84z2OflKCA2vvZJE8TiCzfvZJ+dOJi2MHfhmlttN2erJPikOspcAkpPgRZT
        T7hW+XEOWrzSpaP3IPiolycVOqjv2qM5M60E8/KXzCaTOgPTB3uuc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7B2211C61F5;
        Sun,  9 Oct 2022 18:36:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A1AB11C61F4;
        Sun,  9 Oct 2022 18:36:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH 07/12] fsmonitor: prepare to share code between Mac OS
 and Linux
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
        <c085fc15b314abcb5e5ca6b4ee5ac54a28327cab.1665326258.git.gitgitgadget@gmail.com>
Date:   Sun, 09 Oct 2022 15:36:15 -0700
In-Reply-To: <c085fc15b314abcb5e5ca6b4ee5ac54a28327cab.1665326258.git.gitgitgadget@gmail.com>
        (Eric DeCosta via GitGitGadget's message of "Sun, 09 Oct 2022 14:37:33
        +0000")
Message-ID: <xmqqh70c62w0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C99A485E-4822-11ED-BB67-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Makefile b/Makefile
> index feb675a6959..31dd6ab2734 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2038,13 +2038,13 @@ endif
>  ifdef FSMONITOR_DAEMON_BACKEND
>  	COMPAT_CFLAGS += -DHAVE_FSMONITOR_DAEMON_BACKEND
>  	COMPAT_OBJS += compat/fsmonitor/fsm-listen-$(FSMONITOR_DAEMON_BACKEND).o
> -	COMPAT_OBJS += compat/fsmonitor/fsm-health-$(FSMONITOR_DAEMON_BACKEND).o
> -	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-$(FSMONITOR_DAEMON_BACKEND).o
> +	COMPAT_OBJS += compat/fsmonitor/fsm-health-$(FSMONITOR_DAEMON_COMMON).o
> +	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-$(FSMONITOR_DAEMON_COMMON).o
>  endif
>  
>  ifdef FSMONITOR_OS_SETTINGS
>  	COMPAT_CFLAGS += -DHAVE_FSMONITOR_OS_SETTINGS
> -	COMPAT_OBJS += compat/fsmonitor/fsm-settings-$(FSMONITOR_OS_SETTINGS).o
> +	COMPAT_OBJS += compat/fsmonitor/fsm-settings-$(FSMONITOR_DAEMON_COMMON).o
>  	COMPAT_OBJS += compat/fsmonitor/fsm-path-utils-$(FSMONITOR_OS_SETTINGS).o
>  endif

These two look sloppier than the existing "if we have DAEMON_BACKEND
defined, then add $(DAEMON_BACKEND).o to the set of objects used".
$(DAEMON_COMMON).o should be used after the same kind of check, i.e.

+ifdef FSMONITOR_DAEMON_COMMON
+	COMPAT_OBJS += compat/fsmonitor/fsm-health-$(FSMONITOR_DAEMON_COMMON).o
+	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-$(FSMONITOR_DAEMON_COMMON).o
+	COMPAT_OBJS += compat/fsmonitor/fsm-settings-$(FSMONITOR_DAEMON_COMMON).o
+endif

as a separate if/endif block, without touching the above two, perhaps?

> --- a/compat/fsmonitor/fsm-ipc-darwin.c
> +++ b/compat/fsmonitor/fsm-ipc-unix.c
> @@ -10,7 +10,7 @@ static GIT_PATH_FUNC(fsmonitor_ipc__get_default_path, "fsmonitor--daemon.ipc")
>  const char *fsmonitor_ipc__get_path(struct repository *r)
>  {
>  	static const char *ipc_path = NULL;
> -	SHA_CTX sha1ctx;
> +	git_SHA_CTX sha1ctx;
>  	char *sock_dir = NULL;
>  	struct strbuf ipc_file = STRBUF_INIT;
>  	unsigned char hash[SHA_DIGEST_LENGTH];
> @@ -28,9 +28,9 @@ const char *fsmonitor_ipc__get_path(struct repository *r)
>  		return ipc_path;
>  	}
>  
> -	SHA1_Init(&sha1ctx);
> -	SHA1_Update(&sha1ctx, r->worktree, strlen(r->worktree));
> -	SHA1_Final(hash, &sha1ctx);
> +	git_SHA1_Init(&sha1ctx);
> +	git_SHA1_Update(&sha1ctx, r->worktree, strlen(r->worktree));
> +	git_SHA1_Final(hash, &sha1ctx);
>  
>  	repo_config_get_string(r, "fsmonitor.socketdir", &sock_dir);

Interesting.  The result of course is good, but I wonder how we have
been happy to queue the original code that lack git_ prefix in the
first place X-<.


> diff --git a/config.mak.uname b/config.mak.uname
> index d63629fe807..d454cec47c4 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -68,6 +68,7 @@ ifeq ($(uname_S),Linux)
>  	ifneq ($(findstring .el7.,$(uname_R)),)
>  		BASIC_CFLAGS += -std=c99
>  	endif
> +
>  endif
>  ifeq ($(uname_S),GNU/kFreeBSD)
>  	HAVE_ALLOCA_H = YesPlease

That's a new blank line in an unexpected place.  Did you mean to add
it after the outer endif?
