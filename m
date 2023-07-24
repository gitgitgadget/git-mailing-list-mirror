Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF9CC0015E
	for <git@archiver.kernel.org>; Mon, 24 Jul 2023 16:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjGXQky (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 12:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGXQkq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 12:40:46 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B00110F6
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 09:40:44 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 022301B40FA;
        Mon, 24 Jul 2023 12:40:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=n3j7S1Ku7faI97DEqBzKm1yLFG0spgGJxipgVm
        H64m4=; b=w9KytA0cVS6V/FFgRGewfhhqfGOfANfmA3ehGGcTmrtUN3SITC4Jo8
        L+C+OLux699gFcSZ5ee9NJli3um8Cx83ftt5FTcpETRIdT0LE3asVBL8OmUZ4v9j
        j9PhAJXxzm/wbuFi0BbVhWCJ9GXEoDxXFT072PYlNwKRc2YAt1jLg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ED3B81B40F9;
        Mon, 24 Jul 2023 12:40:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 218101B40F8;
        Mon, 24 Jul 2023 12:40:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, alban.gruin@gmail.com,
        phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 1/1] sequencer: finish parsing the todo list despite
 an invalid first line
References: <20230721060848.35641-1-alexhenrie24@gmail.com>
        <20230722212830.132135-1-alexhenrie24@gmail.com>
        <20230722212830.132135-2-alexhenrie24@gmail.com>
Date:   Mon, 24 Jul 2023 09:40:41 -0700
In-Reply-To: <20230722212830.132135-2-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Sat, 22 Jul 2023 15:28:25 -0600")
Message-ID: <xmqqjzupqn3q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D433BEC0-2A40-11EE-AE42-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> Before the todo list is edited it is rewritten to shorten the OIDs of
> the commits being picked and to append advice about editing the list.
> The exact advice depends on whether the todo list is being edited for
> the first time or not. After the todo list has been edited it is
> rewritten to lengthen the OIDs of the commits being picked and to remove
> the advice. If the edited list cannot be parsed then this last step is
> skipped.
>
> Prior to db81e50724 (rebase-interactive: use todo_list_write_to_file()
> in edit_todo_list(), 2019-03-05) if the existing todo list could not be
> parsed then the initial rewrite was skipped as well. This had the
> unfortunate consequence that if the list could not be parsed after the
> initial edit the advice given to the user was wrong when they re-edited
> the list. This change relied on todo_list_parse_insn_buffer() returning
> the whole todo list even when it cannot be parsed. Unfortunately if the
> list starts with a "fixup" command then it will be truncated and the
> remaining lines are lost. Fix this by continuing to parse after an
> initial "fixup" commit as we do when we see any other invalid line.
>
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  sequencer.c                   |  2 +-
>  t/t3404-rebase-interactive.sh | 27 +++++++++++++++++++++++++++
>  2 files changed, 28 insertions(+), 1 deletion(-)

Very cleanly explained.  Thanks for an update.

> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index ff0afad63e..c734983da0 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1596,6 +1596,33 @@ test_expect_success 'static check of bad command' '
>  	test C = $(git cat-file commit HEAD^ | sed -ne \$p)
>  '
>  
> +test_expect_success 'the first command cannot be a fixup' '
> +	rebase_setup_and_clean fixup-first &&
> +	(
> +		cat >orig <<-EOF &&
> +		fixup $(git log -1 --format="%h %s" B)
> +		pick $(git log -1 --format="%h %s" C)
> +		EOF
> +
> +		(
> +			set_replace_editor orig &&
> +			test_must_fail git rebase -i A 2>actual
> +		) &&
> +		grep "cannot .fixup. without a previous commit" actual &&
> +		grep "You can fix this with .git rebase --edit-todo.." actual &&
> +		# verify that the todo list has not been truncated
> +		grep -v "^#" .git/rebase-merge/git-rebase-todo >actual &&
> +		test_cmp orig actual &&
> +
> +		test_must_fail git rebase --edit-todo 2>actual &&
> +		grep "cannot .fixup. without a previous commit" actual &&
> +		grep "You can fix this with .git rebase --edit-todo.." actual &&
> +		# verify that the todo list has not been truncated
> +		grep -v "^#" .git/rebase-merge/git-rebase-todo >actual &&
> +		test_cmp orig actual
> +	)
> +'

The structure of this new test piece, including the use of "log -1
--format", seems to follow existing tests, and very readable.  Why
do we have one extra level of subshell, though?  There is no "cd"
that may affect the later test pieces, and set_something_editor that
touches environment that may affect the later test pieces is called
in its own subshell already.

Other than that, looking good (there may be a valid reason why the
test piece needs the subshell around it, but it was just not apparent
to me).

>  test_expect_success 'tabs and spaces are accepted in the todolist' '
>  	rebase_setup_and_clean indented-comment &&
>  	write_script add-indent.sh <<-\EOF &&
