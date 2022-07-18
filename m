Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15C7C43334
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 20:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbiGRUN1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 16:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234810AbiGRUN0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 16:13:26 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9648C29C9D
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 13:13:25 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id C7EF43F481D;
        Mon, 18 Jul 2022 16:13:24 -0400 (EDT)
Received: from jeffhost-mbp.lan (unknown [74.205.145.90])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 5139C3F4818;
        Mon, 18 Jul 2022 16:13:24 -0400 (EDT)
Subject: Re: [PATCH v7 7/7] tr2: dump names if config exist in multiple scopes
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, tenglong.tl@alibaba-inc.com
References: <cover.1658159745.git.dyroneteng@gmail.com>
 <a01ae8478d3a8545241c5b064b6d369a330ee59f.1658159746.git.dyroneteng@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <d66f6bc7-4cd0-f585-83e9-9f7e2ee94d68@jeffhostetler.com>
Date:   Mon, 18 Jul 2022 16:13:23 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <a01ae8478d3a8545241c5b064b6d369a330ee59f.1658159746.git.dyroneteng@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.09 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/18/22 12:46 PM, Teng Long wrote:
> When we specify GIT_TRACE2_CONFIG_PARAMS or trace2.configparams,
> trace2 will prints "interesting" config values to log. Sometimes,
> when a config set in multiple scope files, the following output
> looks like (the irrelevant fields are omitted here as "..."):
> 
> ...| def_param    |  ...  | core.multipackindex:false
> ...| def_param    |  ...  | core.multipackindex:false
> ...| def_param    |  ...  | core.multipackindex:false
> 
> As the log shows, even each config in different scope is dumped, but
> we don't know which scope it comes from. Therefore, it's better to
> add the scope names as well to make them be more recognizable. For
> example, when execute:
> 
>      $ GIT_TRACE2_PERF=1 \
>      > GIT_TRACE2_CONFIG_PARAMS=core.multipackIndex \
>      > git rev-list --test-bitmap HEAD"
> 
> The following is the ouput (the irrelevant fields are omitted here
> as "..."):
> 
> Format normal:
> ... git.c:461 ... def_param scope:system core.multipackindex=false
> ... git.c:461 ... def_param scope:global core.multipackindex=false
> ... git.c:461 ... def_param scope:local core.multipackindex=false
> 
> Format perf:
> 
> ... | def_param    | ... | scope:system | core.multipackindex:false
> ... | def_param    | ... | scope:global | core.multipackindex:false
> ... | def_param    | ... | scope:local  | core.multipackindex:false
> 
> Format event:
> 
> {"event":"def_param", ... ,"scope":"system","param":"core.multipackindex","value":"false"}
> {"event":"def_param", ... ,"scope":"global","param":"core.multipackindex","value":"false"}
> {"event":"def_param", ... ,"scope":"local","param":"core.multipackindex","value":"false"}
> 
> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>   Documentation/technical/api-trace2.txt | 45 ++++++++++++++++++++++++++
>   trace2/tr2_tgt_event.c                 |  3 ++
>   trace2/tr2_tgt_normal.c                |  5 ++-
>   trace2/tr2_tgt_perf.c                  |  9 ++++--
>   4 files changed, 59 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
> index bb13ca3db8..48205a5ac5 100644
> --- a/Documentation/technical/api-trace2.txt
> +++ b/Documentation/technical/api-trace2.txt
> @@ -1207,6 +1207,51 @@ at offset 508.
>   This example also shows that thread names are assigned in a racy manner
>   as each thread starts and allocates TLS storage.
>   
> +Print Configs::
> +
> +	  Dump "interesting" config values to trace2 log.
> ++
> +The environment variable `GIT_TRACE2_CONFIG_PARAMS` and configuration
> +`trace2.configparams` can be used to output config values which you care
> +about. For example, assume that we want to config different `color.ui`
> +values in multiple scopes, such as:
> ++
> +----------------
> +$ git config --system color.ui never
> +$ git config --global color.ui always
> +$ git config --local color.ui auto
> +$ git config --list --show-scope | grep 'color.ui'
> +system  color.ui=never
> +global  color.ui=always
> +local   color.ui=auto
> +----------------
> ++
> +Then, mark the config `color.ui` as "interesting" config with
> +`GIT_TRACE2_CONFIG_PARAMS`:
> ++
> +----------------
> +$ export GIT_TRACE2_PERF_BRIEF=1
> +$ export GIT_TRACE2_PERF=~/log.perf
> +$ export GIT_TRACE2_CONFIG_PARAMS=color.ui
> +$ git version
> +...
> +$ cat ~/log.perf
> +d0 | main                     | version      |     |           |           |              | ...
> +d0 | main                     | start        |     |  0.000284 |           |              | /opt/git/master/bin/git version
> +d0 | main                     | cmd_ancestry |     |           |           |              | ancestry:[bash sshd sshd sshd systemd]
> +d0 | main                     | cmd_name     |     |           |           |              | version (version)
> +d0 | main                     | exit         |     |  0.000419 |           |              | code:0
> +d0 | main                     | atexit       |     |  0.000426 |           |              | code:0
> +d0 | main                     | version      |     |           |           |              | ...
> +d0 | main                     | start        |     |  0.000275 |           |              | /opt/git/master/bin/git version
> +d0 | main                     | cmd_ancestry |     |           |           |              | ancestry:[bash sshd sshd sshd systemd]
> +d0 | main                     | cmd_name     |     |           |           |              | version (version)
> +d0 | main                     | def_param    |     |           |           |              | color.ui:never
> +d0 | main                     | def_param    |     |           |           |              | color.ui:always
> +d0 | main                     | def_param    |     |           |           |              | color.ui:auto

shouldn't this example in the docs have the scope value in the
next to last column as you noted in the cover letter ?


> +d0 | main                     | exit         |     |  0.000543 |           |              | code:0
> +d0 | main                     | atexit       |     |  0.000549 |           |              | code:0
> +----------------
>   == Future Work
...

Otherwise, this all LGTM.
Thanks
Jeff
