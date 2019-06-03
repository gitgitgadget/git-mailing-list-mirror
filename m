Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 980661F462
	for <e@80x24.org>; Mon,  3 Jun 2019 21:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfFCV6w (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 17:58:52 -0400
Received: from siwi.pair.com ([209.68.5.199]:50888 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbfFCV6v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 17:58:51 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 5B6D33F4051;
        Mon,  3 Jun 2019 16:42:37 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:59ab:b3d9:a0d9:493a] (unknown [IPv6:2001:4898:a800:1012:adf:b3d9:a0d9:493a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 0E4283F400D;
        Mon,  3 Jun 2019 16:42:37 -0400 (EDT)
Subject: Re: [PATCH 01/11] repo-settings: create repo.size=large setting
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.254.git.gitgitgadget@gmail.com>
 <704613f4480e3b9aacab91d2241247791f34ce22.1559593097.git.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <9a41f574-c476-1c70-ae11-577cbe1ec00b@jeffhostetler.com>
Date:   Mon, 3 Jun 2019 16:42:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <704613f4480e3b9aacab91d2241247791f34ce22.1559593097.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/3/2019 4:18 PM, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> Several advanced config settings are highly recommended for clients
> using large repositories. Power users learn these one-by-one and
> enable them as they see fit. This could be made simpler, to allow
> more users to have access to these almost-always beneficial features
> (and more beneficial in larger repos).
> 
> Create a 'repo.size' config setting whose only accepted value is
> 'large'. When a repo.size=large is given, change the default values
> of some config settings. If the setting is given explicitly, then
> take the explicit value.
> 
> This change adds these two defaults to the repo.size=large setting:
> 
>   * core.commitGraph=true
>   * gc.writeCommitGraph=true
> 
> To centralize these config options and properly set the defaults,
> create a repo_settings that contains chars for each config variable.
> Use -1 as "unset", with 0 for false and 1 for true.
> 
> The prepare_repo_settings() method ensures that this settings
> struct has been initialized, and avoids double-scanning the config
> settings.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
[...]
> diff --git a/repo-settings.c b/repo-settings.c
> new file mode 100644
> index 0000000000..6f5e18d92e
> --- /dev/null
> +++ b/repo-settings.c
> @@ -0,0 +1,44 @@
> +#include "cache.h"
> +#include "repository.h"
> +#include "config.h"
> +#include "repo-settings.h"
> +
> +
> +#define UPDATE_DEFAULT(s,v) if (s != -1) { s = v; }

We should guard this with a "do { ... } while (0)"

> +
> +static int git_repo_config(const char *key, const char *value, void *cb)
> +{
> +	struct repo_settings *rs = (struct repo_settings *)cb;
> +
> +	if (!strcmp(key, "core.size")) {
> +		if (!strcmp(value, "large")) {
> +			UPDATE_DEFAULT(rs->core_commit_graph, 1);
> +			UPDATE_DEFAULT(rs->gc_write_commit_graph, 1);
> +		}
> +		return 0;
> +	}
> +	if (!strcmp(key, "core.commitgraph")) {
> +		rs->core_commit_graph = git_config_bool(key, value);
> +		return 0;
> +	}
> +	if (!strcmp(key, "gc.writecommitgraph")) {
> +		rs->gc_write_commit_graph = git_config_bool(key, value);
> +		return 0;
> +	}
> +
> +	return 1;
> +}
[...]

Jeff
