Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5569ECAAD2
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 21:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbiIAVWD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 17:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiIAVWB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 17:22:01 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866B3915C2
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 14:22:00 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id AF27DCA1254;
        Thu,  1 Sep 2022 17:21:59 -0400 (EDT)
Received: from jeffhost-mbp.local (unknown [IPv6:2600:1015:b110:392b:419c:9e3f:5ae7:8840])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 42259CC82F4;
        Thu,  1 Sep 2022 17:21:59 -0400 (EDT)
Subject: Re: [PATCH v4 1/4] fsmonitor: add two new config options, allowRemote
 and socketDir
To:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Eric DeCosta <edecosta@mathworks.com>
References: <pull.1326.v3.git.1661280941.gitgitgadget@gmail.com>
 <pull.1326.v4.git.1661962145.gitgitgadget@gmail.com>
 <836a791e6b7fd4490674254ce03105a8ca2175cb.1661962145.git.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <791b3386-501b-d69d-3f4e-1401aa0c4865@jeffhostetler.com>
Date:   Thu, 1 Sep 2022 17:21:54 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <836a791e6b7fd4490674254ce03105a8ca2175cb.1661962145.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.09 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/31/22 12:09 PM, Eric DeCosta via GitGitGadget wrote:
> From: Eric DeCosta <edecosta@mathworks.com>
> 
> Introduce two new configuration options
> 
>     fsmonitor.allowRemote - setting this to true overrides fsmonitor's
>     default behavior of erroring out when enountering network file
>     systems. Additionly, when true, the Unix domain socket (UDS) file
>     used for IPC is located in $HOME rather than in the .git directory.
> 
>     fsmonitor.socketDir - allows for the UDS file to be located
>     anywhere the user chooses rather $HOME.
> 
> Signed-off-by: Eric DeCosta <edecosta@mathworks.com>

I hate to say it, but I think I'd like to start over on this
patch.  I think it adds too much to the upper layers.

Could we:

1. Move the GIT_PATH_FUNC() down into compat/fsmonitor/fsm-settings-*.c
    so that we don't need the ifdef-ing because we only really need to
    change the path on MacOS.

    Change it from this macro trick to be an actual function
    that computes the path and sticks it in a static buffer
    and returns it on future calls.  (We call it from several
    different places.)

    On MacOS have it always compute a $HOME or fsmonitor.socketDir
    based path.

    (This is called early, so we don't know anything about the
     r->settings.fsmonitor data yet (like whether we'll have an
     ipc or hook), so we don't know whether to worry about whether
     the socket-directory is local/remote yet.)

2. Get rid of the fsm_settings__get_allow_remote() and
    __get_socket_dir() functions in fsmonitor-settings.c.

    Besides, having it at this layer says that "allow-remote"
    is an all-or-nothing flag (that the platform-independent
    layer doesn't know anything about).  We may eventually find
    that we want the platform code to be smarter about that,
    such as allow remote from NFSv4 but not NFSv3.  We don't
    want to litter the platform-independent code with that.

    And it says that we always use a UDS.  We might change
    that later on MacOS.  And we don't need them at all on Windows.

3. Get rid of the fsm_settings__set_allow_remote() and
    __set_socket_dir().  The FSMonitor code only needs to access
    them once down in the fsm_os__incompatible() code, so we
    could just inline the relevant parts down there.

4. Leave the 'reason = check_for_incompatible()' as it was
    in fsm_setttings__set_ipc() and __set_hook().

    But you might pass a boolean "is-ipc" or "is-hook" to
    check_for_incompatible() that it could pass down to
    fsm_os__incompatible().  That might save the need to the
    fsmonitor.socketDir stuff when they want to use Watchman.

5. In fsm-settings-darwin.c:fsm_os__incompatible()
    complain if the socket path is remote (when is-ipc is set).

    This probably ought to be a new _REASON_ type for non-local
    UDS.  And this is independent of whether the actual worktree
    is remote or whether remote worktrees are allowed.

6. In fsm-settings-darwin.c:check_volume()

All that should be necessary is to:

     if (!(fs.f_flags & MNT_LOCAL))
+   {
+       // ... repo_config_get_bool(... "fsmonitor.allowremote" ...)
         return FSMONITOR_REASON_REMOTE;
+   }


Alternatively, for 5 & 6, we could pass a pathname to check_volume()
so that fsm_os__incompatible() calls it twice:  once for the worktree
and once for the socketdir.

The ntfs and msdos restrictions were for UDS reasons, so you might
want pass some flags to check_volume() too.

Sorry for the redesign and I hope this all makes sense,
Jeff


> ---
>   fsmonitor-settings.c | 67 ++++++++++++++++++++++++++++++++++++++++++--
>   fsmonitor-settings.h |  4 +++
>   2 files changed, 69 insertions(+), 2 deletions(-)
> 
> diff --git a/fsmonitor-settings.c b/fsmonitor-settings.c
> index 464424a1e92..a15eeecebf4 100644
> --- a/fsmonitor-settings.c
> +++ b/fsmonitor-settings.c
> @@ -10,7 +10,9 @@
>   struct fsmonitor_settings {
>   	enum fsmonitor_mode mode;
>   	enum fsmonitor_reason reason;
> +	int allow_remote;
>   	char *hook_path;
> +	char *sock_dir;
>   };
>   
>   static enum fsmonitor_reason check_for_incompatible(struct repository *r)
> @@ -43,6 +45,7 @@ static struct fsmonitor_settings *alloc_settings(void)
>   	CALLOC_ARRAY(s, 1);
>   	s->mode = FSMONITOR_MODE_DISABLED;
>   	s->reason = FSMONITOR_REASON_UNTESTED;
> +	s->allow_remote = -1;
>   
>   	return s;
>   }
> @@ -90,6 +93,26 @@ static void lookup_fsmonitor_settings(struct repository *r)
>   		fsm_settings__set_disabled(r);
>   }
>   
> +int fsm_settings__get_allow_remote(struct repository *r)
> +{
> +	if (!r)
> +		r = the_repository;
> +	if (!r->settings.fsmonitor)
> +		lookup_fsmonitor_settings(r);
> +
> +	return r->settings.fsmonitor->allow_remote;
> +}
> +
> +const char *fsm_settings__get_socket_dir(struct repository *r)
> +{
> +	if (!r)
> +		r = the_repository;
> +	if (!r->settings.fsmonitor)
> +		lookup_fsmonitor_settings(r);
> +
> +	return r->settings.fsmonitor->sock_dir;
> +}
> +
>   enum fsmonitor_mode fsm_settings__get_mode(struct repository *r)
>   {
>   	if (!r)
> @@ -100,6 +123,7 @@ enum fsmonitor_mode fsm_settings__get_mode(struct repository *r)
>   	return r->settings.fsmonitor->mode;
>   }
>   
> +
>   const char *fsm_settings__get_hook_path(struct repository *r)
>   {
>   	if (!r)
> @@ -110,9 +134,44 @@ const char *fsm_settings__get_hook_path(struct repository *r)
>   	return r->settings.fsmonitor->hook_path;
>   }
>   
> +void fsm_settings__set_allow_remote(struct repository *r)
> +{
> +	int allow;
> +
> +	if (!r)
> +		r = the_repository;
> +	if (!r->settings.fsmonitor)
> +		r->settings.fsmonitor = alloc_settings();
> +	if (!repo_config_get_bool(r, "fsmonitor.allowremote", &allow))
> +		r->settings.fsmonitor->allow_remote = allow;
> +
> +	return;
> +}
> +
> +void fsm_settings__set_socket_dir(struct repository *r)
> +{
> +	const char *path;
> +
> +	if (!r)
> +		r = the_repository;
> +	if (!r->settings.fsmonitor)
> +		r->settings.fsmonitor = alloc_settings();
> +
> +	if (!repo_config_get_pathname(r, "fsmonitor.socketdir", &path)) {
> +		FREE_AND_NULL(r->settings.fsmonitor->sock_dir);
> +		r->settings.fsmonitor->sock_dir = strdup(path);
> +	}
> +
> +	return;
> +}
> +
>   void fsm_settings__set_ipc(struct repository *r)
>   {
> -	enum fsmonitor_reason reason = check_for_incompatible(r);
> +	enum fsmonitor_reason reason;
> +
> +	fsm_settings__set_allow_remote(r);
> +	fsm_settings__set_socket_dir(r);
> +	reason = check_for_incompatible(r);
>   
>   	if (reason != FSMONITOR_REASON_OK) {
>   		fsm_settings__set_incompatible(r, reason);
> @@ -135,7 +194,11 @@ void fsm_settings__set_ipc(struct repository *r)
>   
>   void fsm_settings__set_hook(struct repository *r, const char *path)
>   {
> -	enum fsmonitor_reason reason = check_for_incompatible(r);
> +	enum fsmonitor_reason reason;
> +
> +	fsm_settings__set_allow_remote(r);
> +	fsm_settings__set_socket_dir(r);
> +	reason = check_for_incompatible(r);
>   
>   	if (reason != FSMONITOR_REASON_OK) {
>   		fsm_settings__set_incompatible(r, reason);
> diff --git a/fsmonitor-settings.h b/fsmonitor-settings.h
> index d9c2605197f..2de54c85e94 100644
> --- a/fsmonitor-settings.h
> +++ b/fsmonitor-settings.h
> @@ -23,12 +23,16 @@ enum fsmonitor_reason {
>   	FSMONITOR_REASON_NOSOCKETS, /* NTFS,FAT32 do not support Unix sockets */
>   };
>   
> +void fsm_settings__set_allow_remote(struct repository *r);
> +void fsm_settings__set_socket_dir(struct repository *r);
>   void fsm_settings__set_ipc(struct repository *r);
>   void fsm_settings__set_hook(struct repository *r, const char *path);
>   void fsm_settings__set_disabled(struct repository *r);
>   void fsm_settings__set_incompatible(struct repository *r,
>   				    enum fsmonitor_reason reason);
>   
> +int fsm_settings__get_allow_remote(struct repository *r);
> +const char *fsm_settings__get_socket_dir(struct repository *r);
>   enum fsmonitor_mode fsm_settings__get_mode(struct repository *r);
>   const char *fsm_settings__get_hook_path(struct repository *r);
>   
> 
