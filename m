Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665D8C43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 19:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 133DD20659
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 19:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XgYxsulL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbfLDTTj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 14:19:39 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61256 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbfLDTTj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 14:19:39 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7097698A5E;
        Wed,  4 Dec 2019 14:19:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ztYGiR/InwePwSZ0WjKSAadq/ow=; b=XgYxsu
        lLs0kM04VIhY8m11ewuZkkd+r4Hnucrn1CqO8s4jYngA406jD3i9ZOcmZCI8MO4C
        ScCn5tueAOawRVCQBTiYhb65iGz75q17jvzpdHrqz6CBEUJ77A4TnvW1ShZRvfAR
        Hw8ySP7IFt8/8+lkA0niWH28WdDqX+IDaWUT8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rdMuPcO92Y3jaU7Aa1DdZusI2Um8aIar
        lErfNA3slCUNOcMfhBKs0mhVe9R8Dq9721EnDkGTbqOrXA8sECmVUrTIvbeAwXaN
        0fwn+ZhvY8pgKaHmSM4yjmKU6vUHoTxmJAASDLn5qJykvNOU6f99SGOIhJ/6VSdy
        9SydcljBfPE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 688E198A5D;
        Wed,  4 Dec 2019 14:19:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 88DFA98A59;
        Wed,  4 Dec 2019 14:19:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 2/2] rebase-interactive: warn if commit is dropped with `rebase --edit-todo'
References: <20191104095449.9964-1-alban.gruin@gmail.com>
        <20191202234759.26201-1-alban.gruin@gmail.com>
        <20191202234759.26201-3-alban.gruin@gmail.com>
Date:   Wed, 04 Dec 2019 11:19:32 -0800
In-Reply-To: <20191202234759.26201-3-alban.gruin@gmail.com> (Alban Gruin's
        message of "Tue, 3 Dec 2019 00:47:59 +0100")
Message-ID: <xmqqk17b5263.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0164AD06-16CB-11EA-AD42-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> When set to "warn" or "error", `rebase.missingCommitsCheck' would make
> `rebase -i' warn if the user removed commits from the todo list to
> prevent mistakes.  Unfortunately, `rebase --edit-todo' and `rebase
> --continue' don't take it into account.
>
> This adds the ability for `rebase --edit-todo' and `rebase --continue'
> to check if commits were dropped by the user.  As both edit_todo_list()
> and complete_action() parse the todo list and check for dropped commits,
> the code doing so in the latter is removed to reduce duplication.
> `edit_todo_list_advice' is removed from sequencer.c as it is no longer
> used there.
>
> This changes when a backup of the todo list is made.  Until now, it was
> saved only before the initial edit.  Now, it is always performed before
> the todo list is edited.  Without this, sequencer_continue() (`rebase
> --continue') could only compare the current todo list against the
> original, unedited list.  Before this change, this file was only used by
> edit_todo_list() and `rebase -p' to create the backup before the initial
> edit, and check_todo_list_from_file(), only used by `rebase -p' to check
> for dropped commits after its own initial edit.
>
> Three tests are added to t3404.  The tests for
> `rebase.missingCommitsCheck = warn' and `rebase.missingCommitsCheck =
> error' have a similar structure.  First, we start a rebase with an
> incorrect command on the first line.  Then, we edit the todo list,
> removing the first and the last lines.  This demonstrates that
> `--edit-todo' notices dropped commits, but not when the command is
> incorrect.  Then, we restore the original todo list, and edit it to
> remove the last line.  This demonstrates that if we add a commit after
> the initial edit, then remove it, `--edit-todo' will notice that it has
> been dropped.  Then, the actual rebase takes place.  In the third test,
> it is also checked that `--continue' will refuse to resume the rebase if
> commits were dropped.
>
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>  rebase-interactive.c          | 22 ++++++----
>  sequencer.c                   | 24 +++++-----
>  t/t3404-rebase-interactive.sh | 83 +++++++++++++++++++++++++++++++++++
>  3 files changed, 110 insertions(+), 19 deletions(-)

Let me see if I understand the primary idea behind this change by
trying to paraphrase the log (read: this is not to suggest a better
phrasing of the log message proposed in your message).

 * rebase-interactive.c::edit_todo_list() does not perform "did the
   user delete a pick, instead of turning pick into drop?" but after
   the end-user edits the file is the most logical place to do so.
   Let's do that there.

 * The sequencer used to perform "did the user delete a pick,
   instead of turning pick into drop?" check in complete_action().
   We drop that call but for this particular codepath it does not
   make any behaviour difference due to the next item.

 * New code does the check in sequencer_continue(), which is called
   at the end of complete_action(), as well as many other places,
   like builtin/rebase.c, builtin/revert.c, and sequencer_skip().
   Because the check is only done when we are running "rebase-i",
   this is safe---it only affects complete_action().

I hope I got it more-or-less correctly ;-)

> diff --git a/rebase-interactive.c b/rebase-interactive.c
> index ad5dd49c31..80b6a2e7a6 100644
> --- a/rebase-interactive.c
> +++ b/rebase-interactive.c
> @@ -97,7 +97,8 @@ int edit_todo_list(struct repository *r, struct todo_list *todo_list,
>  		   struct todo_list *new_todo, const char *shortrevisions,
>  		   const char *shortonto, unsigned flags)
>  {
> -	const char *todo_file = rebase_path_todo();
> +	const char *todo_file = rebase_path_todo(),
> +		*todo_backup = rebase_path_todo_backup();
>  	/* If the user is editing the todo list, we first try to parse
> @@ -110,9 +111,9 @@ int edit_todo_list(struct repository *r, struct todo_list *todo_list,
>  				    -1, flags | TODO_LIST_SHORTEN_IDS | TODO_LIST_APPEND_TODO_HELP))
>  		return error_errno(_("could not write '%s'"), todo_file);
>  
> -	if (initial && copy_file(rebase_path_todo_backup(), todo_file, 0666))
> -		return error(_("could not copy '%s' to '%s'."), todo_file,
> -			     rebase_path_todo_backup());
> +	unlink(todo_backup);
> +	if (copy_file(todo_backup, todo_file, 0666))
> +		return error(_("could not copy '%s' to '%s'."), todo_file, todo_backup);

We used to copy ONLY when initial is set and we left old todo_backup
intact when !initial.  That is no longer true after this change, but
it is intended---we create an exact copy of what we would hand out
to the end-user, so that we can compare it with the edited result
to figure out what got changed.

We unlink(2) unconditionally because the only effect we want to see
here is that todo_backup does not exist before we call copy_file()
that wants to do O_CREAT|O_EXCL.  I wonder if we want to avoid
unlink() when initial, and also if we want to do unlink_or_warn()
when !initial (read: this is just "wondering" without thinking long
enough to suggest that doing so would be better)

> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 29a35840ed..9051c1e11d 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1343,6 +1343,89 @@ test_expect_success 'rebase -i respects rebase.missingCommitsCheck = error' '
>  	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
>  '
>  
> +test_expect_success 'rebase --edit-todo respects rebase.missingCommitsCheck = ignore' '
> +	test_config rebase.missingCommitsCheck ignore &&
> +	rebase_setup_and_clean missing-commit &&
> +	set_fake_editor &&
> +	FAKE_LINES="break 1 2 3 4 5" git rebase -i --root &&
> +	FAKE_LINES="1 2 3 4" git rebase --edit-todo 2>actual &&

OK, so we lost "pick 5" but with missing-check disabled, that should
not trigger any annoying warning or error.

> +	git rebase --continue 2>actual &&
> +	test D = $(git cat-file commit HEAD | sed -ne \$p) &&

> +	test_i18ngrep \
> +		"Successfully rebased and updated refs/heads/missing-commit" \
> +		actual
> +'
> +
> +test_expect_success 'rebase --edit-todo respects rebase.missingCommitsCheck = warn' '
> +	cat >expect <<-EOF &&
> +	error: invalid line 1: badcmd $(git rev-list --pretty=oneline --abbrev-commit -1 master~4)
> +	Warning: some commits may have been dropped accidentally.
> +	Dropped commits (newer to older):
> +	 - $(git rev-list --pretty=oneline --abbrev-commit -1 master)
> +	To avoid this message, use "drop" to explicitly remove a commit.
> +	EOF
> +	tail -n4 expect >expect.2 &&
> +	test_config rebase.missingCommitsCheck warn &&
> +	rebase_setup_and_clean missing-commit &&
> +	set_fake_editor &&
> +	test_must_fail env FAKE_LINES="bad 1 2 3 4 5" \
> +		git rebase -i --root &&
> +	cp .git/rebase-merge/git-rebase-todo.backup orig &&
> +	FAKE_LINES="2 3 4" git rebase --edit-todo 2>actual.2 &&
> +	head -n5 actual.2 >actual &&
> +	test_i18ncmp expect actual &&

OK, so we lost "pick 1" while discarding "bad", and we should notice
the lossage?  I see "head -n5" there, which means we are still
getting "invalid line 1: badcmd", even though FAKE_LINES now got rid
of "bad"?  Puzzled...
