Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D84C433F5
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 16:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiJJQXi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 12:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiJJQXc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 12:23:32 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FE57539E
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 09:23:24 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 31273CA1252;
        Mon, 10 Oct 2022 12:23:23 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 00353CC8328;
        Mon, 10 Oct 2022 12:23:22 -0400 (EDT)
Subject: Re: [PATCH 07/12] fsmonitor: prepare to share code between Mac OS and
 Linux
To:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Eric DeCosta <edecosta@mathworks.com>
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
 <c085fc15b314abcb5e5ca6b4ee5ac54a28327cab.1665326258.git.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <75f92394-b800-3404-3f3f-20fc4725fb13@jeffhostetler.com>
Date:   Mon, 10 Oct 2022 12:23:22 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.0; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <c085fc15b314abcb5e5ca6b4ee5ac54a28327cab.1665326258.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.09 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/9/22 10:37 AM, Eric DeCosta via GitGitGadget wrote:
> From: Eric DeCosta <edecosta@mathworks.com>
> 
> Linux and Mac OS can share some of the code originally developed for Mac OS.
> Rename the shared code from compat/fsmonitor/fsm-*-dawrin.c to
> compat/fsmonitor/fsm-*-unix.c
> 
> Update the build to enable sharing of the fsm-*-unix.c files.
> 
> Minor update to compat/fsmonitor/fsm-ipc-unix.c to make it cross-platform.

I fear that it may be too early to claim that the platform-specific
code can truly be shared (at least without some amount of future
ifdef'ing).  Yes, there are some commonalities, such as our use of
Unix domain sockets on Mac and *nix, but there may be other things
that are not.

So maybe do the rename for the IPC code, but not for the health, for
example.  Or, keep the platform-named files and add new -unix-common.c
files that can be called from the other (or vice versa).


> 
> Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
> ---
>   Makefile                                                  | 6 +++---
>   .../fsmonitor/{fsm-health-darwin.c => fsm-health-unix.c}  | 0
>   compat/fsmonitor/{fsm-ipc-darwin.c => fsm-ipc-unix.c}     | 8 ++++----
>   .../{fsm-settings-darwin.c => fsm-settings-unix.c}        | 0
>   config.mak.uname                                          | 4 ++++
>   contrib/buildsystems/CMakeLists.txt                       | 6 +++---
>   6 files changed, 14 insertions(+), 10 deletions(-)
>   rename compat/fsmonitor/{fsm-health-darwin.c => fsm-health-unix.c} (100%)
>   rename compat/fsmonitor/{fsm-ipc-darwin.c => fsm-ipc-unix.c} (89%)
>   rename compat/fsmonitor/{fsm-settings-darwin.c => fsm-settings-unix.c} (100%)
> 
> diff --git a/Makefile b/Makefile
> index feb675a6959..31dd6ab2734 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2038,13 +2038,13 @@ endif
>   ifdef FSMONITOR_DAEMON_BACKEND
>   	COMPAT_CFLAGS += -DHAVE_FSMONITOR_DAEMON_BACKEND
>   	COMPAT_OBJS += compat/fsmonitor/fsm-listen-$(FSMONITOR_DAEMON_BACKEND).o
> -	COMPAT_OBJS += compat/fsmonitor/fsm-health-$(FSMONITOR_DAEMON_BACKEND).o
> -	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-$(FSMONITOR_DAEMON_BACKEND).o
> +	COMPAT_OBJS += compat/fsmonitor/fsm-health-$(FSMONITOR_DAEMON_COMMON).o
> +	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-$(FSMONITOR_DAEMON_COMMON).o
>   endif
>   
>   ifdef FSMONITOR_OS_SETTINGS
>   	COMPAT_CFLAGS += -DHAVE_FSMONITOR_OS_SETTINGS
> -	COMPAT_OBJS += compat/fsmonitor/fsm-settings-$(FSMONITOR_OS_SETTINGS).o
> +	COMPAT_OBJS += compat/fsmonitor/fsm-settings-$(FSMONITOR_DAEMON_COMMON).o

This is wrong.  you're mixing the usage of the FSMONITOR_OS_SETTINGS
definition and the usage of your new _COMMON definition.

And I agree with Junio's comment about grouping the _COMMON ones in
their own block and leaving the original COMPAT_OBJS lines as they were.


But really, I think the use of that "common" definition is going to
cause us problems later on.  I mean, you're using it to smash together
the ipc, health, and settings code -- because they cluster around the
unix sockets and how on unix to tell if something is remote.  That
grouping may break if a platform needs something else, such as how to
behave when running under inetd vs launchctl vs <whatever>, for example.


>   	COMPAT_OBJS += compat/fsmonitor/fsm-path-utils-$(FSMONITOR_OS_SETTINGS).o
>   endif
>   
> diff --git a/compat/fsmonitor/fsm-health-darwin.c b/compat/fsmonitor/fsm-health-unix.c
> similarity index 100%
> rename from compat/fsmonitor/fsm-health-darwin.c
> rename to compat/fsmonitor/fsm-health-unix.c
> diff --git a/compat/fsmonitor/fsm-ipc-darwin.c b/compat/fsmonitor/fsm-ipc-unix.c
> similarity index 89%
> rename from compat/fsmonitor/fsm-ipc-darwin.c
> rename to compat/fsmonitor/fsm-ipc-unix.c
> index ce843d63348..3ba3b9e17ed 100644
> --- a/compat/fsmonitor/fsm-ipc-darwin.c
> +++ b/compat/fsmonitor/fsm-ipc-unix.c
> @@ -10,7 +10,7 @@ static GIT_PATH_FUNC(fsmonitor_ipc__get_default_path, "fsmonitor--daemon.ipc")
>   const char *fsmonitor_ipc__get_path(struct repository *r)
>   {
>   	static const char *ipc_path = NULL;
> -	SHA_CTX sha1ctx;
> +	git_SHA_CTX sha1ctx;

Could we put these in a separate commit.  They're not related
to the file renaming focus of this commit.

>   	char *sock_dir = NULL;
>   	struct strbuf ipc_file = STRBUF_INIT;
>   	unsigned char hash[SHA_DIGEST_LENGTH];
> @@ -28,9 +28,9 @@ const char *fsmonitor_ipc__get_path(struct repository *r)
>   		return ipc_path;
>   	}
>   
> -	SHA1_Init(&sha1ctx);
> -	SHA1_Update(&sha1ctx, r->worktree, strlen(r->worktree));
> -	SHA1_Final(hash, &sha1ctx);
> +	git_SHA1_Init(&sha1ctx);
> +	git_SHA1_Update(&sha1ctx, r->worktree, strlen(r->worktree));
> +	git_SHA1_Final(hash, &sha1ctx);
>   
>   	repo_config_get_string(r, "fsmonitor.socketdir", &sock_dir);
>   
> diff --git a/compat/fsmonitor/fsm-settings-darwin.c b/compat/fsmonitor/fsm-settings-unix.c
> similarity index 100%
> rename from compat/fsmonitor/fsm-settings-darwin.c
> rename to compat/fsmonitor/fsm-settings-unix.c
> diff --git a/config.mak.uname b/config.mak.uname
> index d63629fe807..d454cec47c4 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -68,6 +68,7 @@ ifeq ($(uname_S),Linux)
>   	ifneq ($(findstring .el7.,$(uname_R)),)
>   		BASIC_CFLAGS += -std=c99
>   	endif
> +
>   endif
>   ifeq ($(uname_S),GNU/kFreeBSD)
>   	HAVE_ALLOCA_H = YesPlease
> @@ -165,6 +166,7 @@ ifeq ($(uname_S),Darwin)
>   	ifndef NO_UNIX_SOCKETS
>   	FSMONITOR_DAEMON_BACKEND = darwin
>   	FSMONITOR_OS_SETTINGS = darwin
> +	FSMONITOR_DAEMON_COMMON = unix
>   	endif
>   	endif
>   
> @@ -453,6 +455,7 @@ ifeq ($(uname_S),Windows)
>   	# support it.
>   	FSMONITOR_DAEMON_BACKEND = win32
>   	FSMONITOR_OS_SETTINGS = win32
> +	FSMONITOR_DAEMON_COMMON = win32
>   
>   	NO_SVN_TESTS = YesPlease
>   	RUNTIME_PREFIX = YesPlease
> @@ -645,6 +648,7 @@ ifeq ($(uname_S),MINGW)
>   	# support it.
>   	FSMONITOR_DAEMON_BACKEND = win32
>   	FSMONITOR_OS_SETTINGS = win32
> +	FSMONITOR_DAEMON_COMMON = win32
>   
>   	RUNTIME_PREFIX = YesPlease
>   	HAVE_WPGMPTR = YesWeDo
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index 787738e6fa3..0b26a1a36e3 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -315,13 +315,13 @@ if(SUPPORTS_SIMPLE_IPC)
>   		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-win32.c)
>   	elseif(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
>   		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
> +		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-unix.c)
> +		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-unix.c)
>   		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-darwin.c)
> -		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-darwin.c)
> -		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-darwin.c)
>   		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-darwin.c)
>   
>   		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
> -		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-darwin.c)
> +		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-unix.c)
>   	endif()
>   endif()
>   
> 
