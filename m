Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10594C433EF
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 20:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382061AbiDTUUB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 16:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240148AbiDTUTz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 16:19:55 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC753EB8A
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:17:08 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 783DD186180;
        Wed, 20 Apr 2022 16:17:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9AVMljk46vodusGf9PY4JtOTtgxULJ6Mnu0M+H
        /3zCU=; b=cVI/xdvRyy2FY+8nz4JxY2ROFv2YAmQFRLCCxzgtLqpGHITeJAjKi9
        F9fW1r0FsbMT2dgx1t0RsVMCjXeq1CyZm4GS3/vdGcArR5twQlYOrIHRAe/wqCLL
        62QqBvtxsThByjxfggvktkIIochU+OGAsRlzHLoX/Wd/zlmebhBAQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6F2A918617F;
        Wed, 20 Apr 2022 16:17:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CAC6918617C;
        Wed, 20 Apr 2022 16:17:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 2/8] t3406: rework rebase reflog tests
References: <pull.1150.git.1645441854.gitgitgadget@gmail.com>
        <pull.1150.v2.git.1650448612.gitgitgadget@gmail.com>
        <0904b50a377ce3ac242f9594a635f9ae7cffc687.1650448612.git.gitgitgadget@gmail.com>
Date:   Wed, 20 Apr 2022 13:17:01 -0700
In-Reply-To: <0904b50a377ce3ac242f9594a635f9ae7cffc687.1650448612.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Wed, 20 Apr 2022 09:56:45
        +0000")
Message-ID: <xmqqzgkfo6gy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D748381C-C0E6-11EC-8FDE-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Refactor the tests in preparation for adding more tests in the next
> few commits. The reworked tests use the same function for testing both
> the "merge" and "apply" backends. The test coverage for the "apply"
> backend now includes setting GIT_REFLOG_ACTION.
>
> Note that rebasing the "conflicts" branch does not create any
> conflicts yet. A commit to do that will be added in the next commit
> and the diff ends up smaller if we have don't rename the branch when
> it is added.

"if we have don't rename"?  Ecannotparse.

>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  t/t3406-rebase-message.sh | 115 +++++++++++++++++++++++++-------------
>  1 file changed, 76 insertions(+), 39 deletions(-)
>
> diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
> index d17b450e811..5253dd1551d 100755
> --- a/t/t3406-rebase-message.sh
> +++ b/t/t3406-rebase-message.sh
> @@ -10,10 +10,15 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  test_expect_success 'setup' '
>  	test_commit O fileO &&
>  	test_commit X fileX &&
> +	git branch fast-forward &&
>  	test_commit A fileA &&
>  	test_commit B fileB &&
>  	test_commit Y fileY &&
>  
> +	git checkout -b conflicts O &&
> +	test_commit P &&
> +	test_commit Q &&
> +
>  	git checkout -b topic O &&
>  	git cherry-pick A B &&
>  	test_commit Z fileZ &&

So, we'd create

	O---X---A---B---Y (main)
        |\
        | P---Q (conflicts)
        \
         A'--B'--Z (topic)

with the above.  The "fast-forward" branch is not yet used.

Without reading the rest of this patch (or the series), especially
because you said you'll test multiple rebase strategies (and
presumably make sure they result in the same state), my gut says
that it may not buy us much to create such an unused branch.  If we
successfully run a fast-forward test on the branch for one strategy,
we have to rewind the result before testing another strategy anyway,
so forking a branch to be tested at X when we start testing each
rebase strategy would be fine.  But we'll see.

> @@ -79,54 +84,86 @@ test_expect_success 'error out early upon -C<n> or --whitespace=<bad>' '
>  	test_i18ngrep "Invalid whitespace option" err
>  '
>  
> -test_expect_success 'GIT_REFLOG_ACTION' '
> -	git checkout start &&
> -	test_commit reflog-onto &&
> -	git checkout -b reflog-topic start &&
> -	test_commit reflog-to-rebase &&
> -
> -	git rebase reflog-onto &&
> -	git log -g --format=%gs -3 >actual &&
> -	cat >expect <<-\EOF &&
> -	rebase (finish): returning to refs/heads/reflog-topic
> -	rebase (pick): reflog-to-rebase
> -	rebase (start): checkout reflog-onto
> +write_reflog_expect () {
> +	if test $mode = --apply
> +	then
> +		sed 's/.*(finish)/rebase finished/; s/ ([^)]*)//'
> +	else
> +		cat
> +	fi >expect
> +}
> +
> +test_reflog () {
> +	mode=$1
> +	reflog_action="$2"

$1 being left unquoted while $2 being quoted makes them look
incoherent.  It is not wrong to enclose $2 in double quotes, but it
is not necessary.

> +	test_expect_success "rebase $mode reflog${reflog_action:+ GIT_REFLOG_ACTION=$reflog_action}" '
> +	git checkout conflicts &&
> +	test_when_finished "git reset --hard Q" &&
> +
> +	(
> +		if test -n "$reflog_action"
> +		then
> +			GIT_REFLOG_ACTION="$reflog_action" &&
> +			export GIT_REFLOG_ACTION
> +		fi &&
> +		git rebase $mode main
> +	) &&

Is the subshell because you may want to export the envirohnment, or
is there anything more subtle going on?

> +	git log -g --format=%gs -4 >actual &&
> +	write_reflog_expect <<-EOF &&
> +	${reflog_action:-rebase} (finish): returning to refs/heads/conflicts
> +	${reflog_action:-rebase} (pick): Q
> +	${reflog_action:-rebase} (pick): P
> +	${reflog_action:-rebase} (start): checkout main
>  	EOF
>  	test_cmp expect actual &&

We reset to Q and rebase it onto main, which would mean that we'd
replay P and then Q on top of Y.  The 4 most recent events on HEAD
are that we start at 'main', picking P and Q and then updating the
conflicts branch with the result.  OK.

It is not what we used to test, but with reference to Q that was
established at the beginning, though.

> -	git checkout -b reflog-prefix reflog-to-rebase &&
> -	GIT_REFLOG_ACTION=change-the-reflog git rebase reflog-onto &&
> -	git log -g --format=%gs -3 >actual &&
> -	cat >expect <<-\EOF &&
> -	change-the-reflog (finish): returning to refs/heads/reflog-prefix
> -	change-the-reflog (pick): reflog-to-rebase
> -	change-the-reflog (start): checkout reflog-onto
> +	git log -g --format=%gs -1 conflicts >actual &&
> +	write_reflog_expect <<-EOF &&
> +	${reflog_action:-rebase} (finish): refs/heads/conflicts onto $(git rev-parse main)
>  	EOF

And after doing that, there only is one reflog entry for the
conflicts branch itself, i.e. record of finishing to rebase.

For both of the above two tests, I wonder if we want to make sure
these four and one entries are the ONLY entries added by the
operation.  I.e. take the topmost reflog entry _before_ starting to
run rebase for both conflicts branch and HEAD, grab five and two
reflog entries after the operation from conflicts and HEAD and make
sure the four and one are the truly new entries added by the
operation, or something like that.  Even easier would be to merely
count the number of reflog entries of HEAD and conflicts before
rebasing, and count them after.  We can do subtraction in the shell
just fine.

> +	test_cmp expect actual &&
>  
> +	# check there is only one new entry in the branch reflog

It is a valid thing to try verifying, but ...

> +	test_cmp_rev conflicts@{1} Q

... it is unclear how this can count the new reflog entries.  If we
added two reflog entries, one pointing at Y (i.e. tip of main),
another that points at Q (i.e. tip of conflicts before the rebasing),
conflicts@{1} would be the same as Q.

> +	'
> +
> +	test_expect_success "rebase $mode fast-forward reflog${reflog_action:+ GIT_REFLOG_ACTION=$reflog_action}" '
> +	git checkout fast-forward &&
> +	test_when_finished "git reset --hard X" &&
> +
> +	(
> +		if test -n "$reflog_action"
> +		then
> +			GIT_REFLOG_ACTION="$reflog_action" &&
> +			export GIT_REFLOG_ACTION
> +		fi &&
> +		git rebase $mode main
> +	) &&
> +
> +	git log -g --format=%gs -2 >actual &&
> +	write_reflog_expect <<-EOF &&
> +	${reflog_action:-rebase} (finish): returning to refs/heads/fast-forward
> +	${reflog_action:-rebase} (start): checkout main
>  	EOF
>  	test_cmp expect actual &&

Likewise.  This only makes sure that the topmost two are what you
expect without checking if it added anything extra before these two.
Actually counting the entries would give you an easy fix.

> -	git log -g --format=%gs -2 reflog-apply >actual &&
> -	cat >expect <<-EOF &&
> -	rebase finished: refs/heads/reflog-apply onto $(git rev-parse Y)
> -	branch: Created from start
> +	git log -g --format=%gs -1 fast-forward >actual &&
> +	write_reflog_expect <<-EOF &&
> +	${reflog_action:-rebase} (finish): refs/heads/fast-forward onto $(git rev-parse main)
>  	EOF
> -	test_cmp expect actual
> -'
> +	test_cmp expect actual &&
> +
> +	# check there is only one new entry in the branch reflog
> +	test_cmp_rev fast-forward@{1} X

The same.  This does not ensure there is only one new entry.  It
merely says that the set of entries you cared about (which is a set
of one) is preceded by an entry that happened to point at X.

> +	'
> +}
> +
> +test_reflog --merge
> +test_reflog --merge my-reflog-action
> +test_reflog --apply
> +test_reflog --apply my-reflog-action
>  
>  test_expect_success 'rebase -i onto unrelated history' '
>  	git init unrelated &&

Thanks.
