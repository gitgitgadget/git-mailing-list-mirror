Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FFD91F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 14:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbfHMOom (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 10:44:42 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:35878 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728681AbfHMOom (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 10:44:42 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id B45AA1F45A;
        Tue, 13 Aug 2019 14:44:41 +0000 (UTC)
Date:   Tue, 13 Aug 2019 14:44:41 +0000
From:   Eric Wong <e@80x24.org>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     git@vger.kernel.org, peff@peff.net, chriscool@tuxfamily.org,
        gitster@pobox.com, jonathantanmy@google.com, tboegi@web.de,
        bwilliams.eng@gmail.com, jeffhost@microsoft.com
Subject: Re: [PATCH v2 2/5] fetch: Add the "--fetch-jobs" option
Message-ID: <20190813144441.qw5i3zbrvebz5o7z@dcvr>
References: <20190812213448.2649-1-palmer@sifive.com>
 <20190812213448.2649-3-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190812213448.2649-3-palmer@sifive.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Palmer Dabbelt <palmer@sifive.com> wrote:
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 8aa6a0caf1ab..fa12ad44e7d9 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c

<snip>

> +static int next_remote_to_fetch(struct child_process *cp,
> +				struct strbuf *out,
> +				void *state_uncast,
> +				void **task_state_out)
> +{
> +	int i;
> +	struct fetch_remote *state = state_uncast;
> +	struct fetch_remote_task *task_state = NULL;
> +	const char *remote_name;
> +
> +	if (state->next_remote_index >= state->all_remotes->nr)
> +		return 0;
> +
> +	remote_name = state->all_remotes->items[state->next_remote_index].string;
> +	state->next_remote_index++;
> +
> +	/*
> +	 * Finds somewhere to store the state for a task.  This is guarnteed to
> +	 * succeed because there are always enough tasks allocated to cover the
> +	 * number that have been requested to run in parallel.  Rather than
> +	 * bothering with some sort of free list, this just brute force
> +	 * searches for a free task.  The assumption is that there aren't that
> +	 * many tasks to look through.
> +	 */
> +	for (i = 0; i < state->task_count; ++i) {
> +		if (!state->all_tasks[i].in_use) {
> +			task_state = state->all_tasks + i;
> +			break;
> +		}
> +	}

Fwiw, I added list.h, the linked-list derived from the Linux
kernel to simplify usage of free lists, queues, etc...

I think it could improve readability, too; but I'm not really
a C programmer and prefer high-level scripting languages.
