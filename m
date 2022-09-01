Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83074ECAAD3
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 17:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbiIARxO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 13:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbiIARxL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 13:53:11 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8652680356
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 10:53:10 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id A99A8CA124E;
        Thu,  1 Sep 2022 13:53:09 -0400 (EDT)
Received: from jeffhost-mbp.local (unknown [IPv6:2600:1015:b110:392b:419c:9e3f:5ae7:8840])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 45A25CC83F1;
        Thu,  1 Sep 2022 13:53:09 -0400 (EDT)
Subject: Re: [PATCH v4 1/4] fsmonitor: add two new config options, allowRemote
 and socketDir
To:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Eric DeCosta <edecosta@mathworks.com>
References: <pull.1326.v3.git.1661280941.gitgitgadget@gmail.com>
 <pull.1326.v4.git.1661962145.gitgitgadget@gmail.com>
 <836a791e6b7fd4490674254ce03105a8ca2175cb.1661962145.git.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <8acf1e78-bac4-7f59-11a4-996aa160bbdc@jeffhostetler.com>
Date:   Thu, 1 Sep 2022 13:53:08 -0400
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

When we use the hook interface (to talk to a third-party
app like Watchman) we do not use the unix domain socket.
(We talk to the hook child using a normal pipe.)

FWIW, I added code in my series to limit the use of hook-based
fsmonitors to local filesystems for the paranoia-based
reasons I've described before.  It wasn't because of the UDS.

So we don't need to set the socket directory in this case.

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
