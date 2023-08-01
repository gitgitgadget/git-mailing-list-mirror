Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD39C00528
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 17:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbjHARX3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 13:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235111AbjHARXI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 13:23:08 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125D130F7
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 10:22:43 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B39461AF015;
        Tue,  1 Aug 2023 13:22:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jPPMciO6R04k7B/fTNXsKw9ZIYw79PPdz48ADc
        kQPR0=; b=UUVRaiu4hEvCLxJx1Ggr7uwuG73ILKrPVNFqJlOOZt/K8ceX/DcYG8
        RT3ujhoocEjS58iIZzhzfkb+g07GDrcYW0Q5Zj0agEvQ2oyrwSJswGhOdesDvct9
        wP5nILBxYzlSFsaAtTrNNrd8yVVX3BK/KozopI7iIk2F4SVjDqINE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AAF301AF014;
        Tue,  1 Aug 2023 13:22:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1728B1AF011;
        Tue,  1 Aug 2023 13:22:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 1/7] rebase -i: move unlink() calls
References: <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
        <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com>
        <1ab1ad2ef07687c25c1d346b5b7b26f38bafe5b9.1690903412.git.gitgitgadget@gmail.com>
Date:   Tue, 01 Aug 2023 10:22:37 -0700
In-Reply-To: <1ab1ad2ef07687c25c1d346b5b7b26f38bafe5b9.1690903412.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Tue, 01 Aug 2023 15:23:26
        +0000")
Message-ID: <xmqqa5vad6ea.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 03BBFE14-3090-11EE-8BBA-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> At the start of each iteration the loop that picks commits removes
> state files from the previous pick. However some of these are only
> written if there are conflicts and so we break out of the loop after
> writing them. Therefore they only need to be removed when the rebase
> continues, not in each iteration.

"They only need to be removed before the loop" assumes that the SOLE
purpose of the removal is to give the next iteration a clean slate
to work with, but is that really the case?  The original unlink's is
followed by "if TODO_BREAK, break out of the loop", presumably to
give control back to the end-user.  So three files that were not
available to the user after "break" are now suddenly visible to
them.

Perhaps that is the effect the series wanted to have.  Or it could
be an unintended side effect that may be a regression.  Or perhaps
the visibility of these three files (but not others?) is considered
an implementation detail no users should ever depend on.

It is hard to tell from the above description and the patch text
which is the case.  Care to enlighten?

Thanks.


> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  sequencer.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index cc9821ece2c..de66bda9d5b 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4656,6 +4656,10 @@ static int pick_commits(struct repository *r,
>  	if (read_and_refresh_cache(r, opts))
>  		return -1;
>  
> +	unlink(rebase_path_message());
> +	unlink(rebase_path_stopped_sha());
> +	unlink(rebase_path_amend());
> +
>  	while (todo_list->current < todo_list->nr) {
>  		struct todo_item *item = todo_list->items + todo_list->current;
>  		const char *arg = todo_item_get_arg(todo_list, item);
> @@ -4679,10 +4683,7 @@ static int pick_commits(struct repository *r,
>  						todo_list->total_nr,
>  						opts->verbose ? "\n" : "\r");
>  			}
> -			unlink(rebase_path_message());
>  			unlink(rebase_path_author_script());
> -			unlink(rebase_path_stopped_sha());
> -			unlink(rebase_path_amend());
>  			unlink(git_path_merge_head(r));
>  			unlink(git_path_auto_merge(r));
>  			delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
