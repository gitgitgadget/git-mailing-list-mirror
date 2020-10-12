Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E6AC433DF
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 17:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7D0320776
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 17:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aVg8XW81"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403838AbgJLRan (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 13:30:43 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60050 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389613AbgJLRam (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 13:30:42 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 05216F73C1;
        Mon, 12 Oct 2020 13:30:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1p/0XemaMXdVo8PpO/Q92kfGB+c=; b=aVg8XW
        81uchwejxUhBJ0kuT2Eno2ibgAdMFd4rAO2tQi5M0plk6BYvy4XQrIUJXSaW3jhK
        jpUWo2ADLKnkbDnBlEZpPPMTJ97m7kPnsk9HgZrJfZ8gjKVXNTLWUe8Uuurk++R7
        uLz6z9z0UKggXTx/B7+q0WFpdMDrospfoPdBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LcyBY9/VKweVCMPOzrR0QC2dAP8BXmXF
        GQiRhE5gU8ZTnyw1vDn8Q6EAStEYGW2Wv0PEN5VDuS09SSfgd0PWgyblVkP40Elf
        KIA2LW3QdiGBNucYaxFzW3CYzl0yhPi/v49OcgeHbvFfzGf4Qos8TmlXtpRigt2O
        HoOwjWJUe2c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F1DBFF73C0;
        Mon, 12 Oct 2020 13:30:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3CA07F73BF;
        Mon, 12 Oct 2020 13:30:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] maintenance: core.commitGraph=false prevents writes
References: <pull.749.git.1602509314545.gitgitgadget@gmail.com>
Date:   Mon, 12 Oct 2020 10:30:33 -0700
In-Reply-To: <pull.749.git.1602509314545.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Mon, 12 Oct 2020 13:28:34
        +0000")
Message-ID: <xmqqwnzvpd1i.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A2F40E7E-0CB0-11EB-B8B9-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> Recently, a user had an issue due to combining
> fetch.writeCommitGraph=true with core.commitGraph=false. The root bug
> has been resolved by preventing commit-graph writes when
> core.commitGraph is disabled. This happens inside the 'git commit-graph
> write' command, but we can be more aware of this situation and prevent
> that process from ever starting in the 'commit-graph' maintenance task.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>     maintenance: core.commitGraph=false prevents writes
>     
>     As requested [1], this prevents the extra process when core.commitGraph
>     is disabled.

That's not a request.  I was just wondering aloud.

If you took inspiration from my thinking aloud, that is wonderful,
but the actual work to ensure it is not an idea that horribly breaks
some underlying assumption I didn't know about in the code and
deciding it is a good idea to do so is all done by you, so please
take the credit due.

>     This is based on ds/maintenance-commit-graph-auto-fix.
>     
>     [1] https://lore.kernel.org/git/xmqqft6nrtlw.fsf@gitster.c.googlers.com/
>     
>     Thanks, -Stolee

Hmph.  

There is a call to prepare_repo_settings() in cmd_gc().

I have to wonder if it should be done much earlier and in a more
central place, perhaps in cmd_maintenance() before anything else
happens.  Even though commit-graph may feel somewhat special only
because it is relatively new, it is not hard to imagine that other
maintenance tasks (both older ones and future ones) would eventually
want to have similar access to the feature settings.

It is OK to keep "the maintenance command works only in the single
repository", and not passing a "repo" that cmd_maintenance() would
prepare by calling prepare_repo_settings() down in the callchain, at
least right now, but we might want to consider doing so in the
future.

Thanks.


> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-749%2Fderrickstolee%2Fmaintenance-core-commit-graph-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-749/derrickstolee/maintenance-core-commit-graph-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/749
>
>  builtin/gc.c           | 4 ++++
>  t/t7900-maintenance.sh | 8 ++++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 12ddb68bba..e80331c4e2 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -813,6 +813,10 @@ static int run_write_commit_graph(struct maintenance_run_opts *opts)
>  
>  static int maintenance_task_commit_graph(struct maintenance_run_opts *opts)
>  {
> +	prepare_repo_settings(the_repository);
> +	if (!the_repository->settings.core_commit_graph)
> +		return 0;
> +
>  	close_object_store(the_repository->objects);
>  	if (run_write_commit_graph(opts)) {
>  		error(_("failed to write commit-graph"));
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index ee1f4a7ae4..9776154a2a 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -52,6 +52,14 @@ test_expect_success 'run --task=<task>' '
>  	test_subcommand git commit-graph write --split --reachable --no-progress <run-both.txt
>  '
>  
> +test_expect_success 'core.commitGraph=false prevents write process' '
> +	GIT_TRACE2_EVENT="$(pwd)/no-commit-graph.txt" \
> +		git -c core.commitGraph=false maintenance run \
> +		--task=commit-graph 2>/dev/null &&
> +	test_subcommand ! git commit-graph write --split --reachable --no-progress \
> +		<no-commit-graph.txt
> +'
> +
>  test_expect_success 'commit-graph auto condition' '
>  	COMMAND="maintenance run --task=commit-graph --auto --quiet" &&
>  
>
> base-commit: 8f801804befa12a9c4ddff91275cf03612f1895d
