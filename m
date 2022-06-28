Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DFAC43334
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 21:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiF1VPZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 17:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiF1VPY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 17:15:24 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC4630561
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 14:15:23 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0A143146065;
        Tue, 28 Jun 2022 17:15:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iIEJmA3DyO/naxqNDzvAz0pRGq/m3w6j0Odk4n
        ZKPVM=; b=nBoHUJKgWs+mV1r+DS6ValA4XmurTVr0mdqw+8U2mXOeySKJZxiAI7
        MK4LVCkVjj8vqNkGjy2EpVmOirvA1EMNARA08F1ukZ/Gbx8KDZoWz5uyp5+nx4oH
        Z4EOlRVVAkUXlZvtWON0DnwwHrWbFdwZj3HC/hU72cIa5VbmqckJI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F1F51146064;
        Tue, 28 Jun 2022 17:15:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 55A4E146063;
        Tue, 28 Jun 2022 17:15:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 7/8] rebase: update refs from 'update-ref' commands
References: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
        <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
        <72e0481b643e98c5670eee0bf5c199c4fb693b16.1656422759.git.gitgitgadget@gmail.com>
Date:   Tue, 28 Jun 2022 14:15:20 -0700
In-Reply-To: <72e0481b643e98c5670eee0bf5c199c4fb693b16.1656422759.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 28 Jun 2022
        13:25:58 +0000")
Message-ID: <xmqq7d50ij6f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6B111D72-F727-11EC-AAD6-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> The previous change introduced the 'git rebase --update-refs' option
> which added 'update-ref <ref>' commands to the todo list of an
> interactive rebase.
>
> Teach Git to record the HEAD position when reaching these 'update-ref'
> commands. The ref/OID pair is stored in the
> $GIT_DIR/rebase-merge/update-refs file. A previous change parsed this
> file to avoid having other processes updating the refs in that file
> while the rebase is in progress.
>
> Not only do we update the file when the sequencer reaches these
> 'update-ref' commands, we then update the refs themselves at the end of
> the rebase sequence. If the rebase is aborted before this final step,
> then the refs are not updated.

So, in general, we would

 * first scan the range of commits being rebased
 * compute what should happen and write the "todo" thing
 * write also "update-refs" to lick the branches to repel others
 * execute the "todo" insns one by one, possibly giving control back

And this order is important---update-refs file is written fairly
early, and the branches potentially involved in the rebase are all
protected during the time-consuming (due to possibility of manual
conflict resolution) execution step.

Makes sense.

> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 3cd20733bc8..63a69bc073e 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1813,6 +1813,29 @@ test_expect_success '--update-refs adds commands with --rebase-merges' '
>  	)
>  '
>  
> +compare_two_refs () {
> +	git rev-parse $1 >expect &&
> +	git rev-parse $2 >actual &&
> +	test_cmp expect actual
> +}
> +
> +test_expect_success '--update-refs updates refs correctly' '
> +	git checkout -B update-refs no-conflict-branch &&
> +	git branch -f base HEAD~4 &&
> +	git branch -f first HEAD~3 &&
> +	git branch -f second HEAD~3 &&
> +	git branch -f third HEAD~1 &&
> +	test_commit extra2 fileX &&
> +	git commit --amend --fixup=L &&
> +
> +	git rebase -i --autosquash --update-refs primary &&
> +
> +	compare_two_refs HEAD~3 refs/heads/first &&
> +	compare_two_refs HEAD~3 refs/heads/second &&
> +	compare_two_refs HEAD~1 refs/heads/third &&
> +	compare_two_refs HEAD refs/heads/no-conflict-branch
> +'
> +
>  # This must be the last test in this file
>  test_expect_success '$EDITOR and friends are unchanged' '
>  	test_editor_unchanged

It would be nice to also have a test that makes sure that other
people will be prevented from checking out a branch whose tips may
be updated at the end.

Thanks.
