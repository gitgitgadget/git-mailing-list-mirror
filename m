Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AF7ECAAD2
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 20:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbiIAUFk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 16:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234510AbiIAUFg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 16:05:36 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3D15FAC8
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 13:05:34 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id B2E44CA1253;
        Thu,  1 Sep 2022 16:05:33 -0400 (EDT)
Received: from jeffhost-mbp.local (unknown [IPv6:2600:1015:b110:392b:419c:9e3f:5ae7:8840])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 55199CC82ED;
        Thu,  1 Sep 2022 16:05:33 -0400 (EDT)
Subject: Re: [PATCH v4 4/4] fsmonitor: normalize FSEvents event paths to the
 real path
To:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Eric DeCosta <edecosta@mathworks.com>
References: <pull.1326.v3.git.1661280941.gitgitgadget@gmail.com>
 <pull.1326.v4.git.1661962145.gitgitgadget@gmail.com>
 <56cabf3be3b9e228bc948da372db4c9d11fd3926.1661962145.git.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <bdf26d53-7068-87a6-484b-aeef99be35bd@jeffhostetler.com>
Date:   Thu, 1 Sep 2022 16:05:32 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <56cabf3be3b9e228bc948da372db4c9d11fd3926.1661962145.git.gitgitgadget@gmail.com>
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
> Consider the following network working directory that is mounted under
> /System/Volumes/Data:
> 
> /network/working/directory
> 
> The git working directory path is:
> 
> /System/Volumes/Data/network/working/directory
> 
> The paths reported by FSEvents always start with /network. fsmonitor
> expects paths to be under the working directory; therefore it
> fails to match /network/... and ignores the change.

I'm not sure I understand what's going on here.
Are you saying that FSEvents reports network mounted
directories with a path relative to the mount-point
rather than an absolute path?

In your example, is "/network/working/directory" a
valid path on your system (that also happens to be the
same directory as "/System/Volumes/...")

That is, do you have some aliasing going on where both paths
are valid -- like a pair of hard-linked directories?
Or, is there something special about a network mount point?


Did you have to "cd /System/Volumes/..." to get Git to have
the absolute path be this?  Or were you doing a "cd /network/..."?
(Sorry to ask so many questions but I don't have a pair of
systems to test any of this on right now.)

> 
> Change things such that if fsmonitor.allowRemote is true that the
> paths reported via FSEevents are normalized to the real path.
> 
> Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
> ---
>   compat/fsmonitor/fsm-listen-darwin.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
> index 8e208e8289e..2ed828649ff 100644
> --- a/compat/fsmonitor/fsm-listen-darwin.c
> +++ b/compat/fsmonitor/fsm-listen-darwin.c
> @@ -26,6 +26,7 @@
>   #include "fsmonitor.h"
>   #include "fsm-listen.h"
>   #include "fsmonitor--daemon.h"
> +#include "fsmonitor-settings.h"
>   
>   struct fsm_listen_data
>   {
> @@ -183,7 +184,6 @@ static void my_add_path(struct fsmonitor_batch *batch, const char *path)
>   	free(composed);
>   }
>   
> -
>   static void fsevent_callback(ConstFSEventStreamRef streamRef,
>   			     void *ctx,
>   			     size_t num_of_events,
> @@ -209,7 +209,12 @@ static void fsevent_callback(ConstFSEventStreamRef streamRef,
>   		/*
>   		 * On Mac, we receive an array of absolute paths.
>   		 */
> -		path_k = paths[k];
> +		if (fsm_settings__get_allow_remote(the_repository) > 0) {
> +			strbuf_reset(&tmp);
> +			strbuf_realpath_forgiving(&tmp, paths[k], 0);
> +			path_k = tmp.buf;
> +		} else
> +			path_k = paths[k];

This feels wrong.

It is not that fsmonitor.allowRemote is true, but whether or not
this particular file system *IS* remote, right?

>   
>   		/*
>   		 * If you want to debug FSEvents, log them to GIT_TRACE_FSMONITOR.
> @@ -237,6 +242,7 @@ static void fsevent_callback(ConstFSEventStreamRef streamRef,
>   
>   			fsmonitor_force_resync(state);
>   			fsmonitor_batch__free_list(batch);
> +			batch = NULL;
>   			string_list_clear(&cookie_list, 0);
>   
>   			/*
> @@ -313,7 +319,6 @@ static void fsevent_callback(ConstFSEventStreamRef streamRef,
>   
>   		case IS_WORKDIR_PATH:
>   			/* try to queue normal pathnames */
> -
>   			if (trace_pass_fl(&trace_fsmonitor))
>   				log_flags_set(path_k, event_flags[k]);
>   
> 
