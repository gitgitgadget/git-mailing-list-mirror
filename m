Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C15C001B0
	for <git@archiver.kernel.org>; Wed, 19 Jul 2023 21:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjGSVcn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jul 2023 17:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGSVcm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2023 17:32:42 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC771FCD
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 14:32:40 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E53A631A8D;
        Wed, 19 Jul 2023 17:32:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vcprd4BIlH8/jDj1mYOCLGvdTXvX/MAE9MsJE0
        mou4g=; b=MH/w43BPkYOUt2E8L5gYLDGG6wqb08twAXOzL1gPDB1nrQRAVOWZE+
        MOd4b+65u2yFFDBvqz6TxhwuogKBZUsCBYuZuqGBU7LDSkUKJ7ADep51vUnKePZO
        NJ06CKqBjBp4MNwxc8AEOjWC0S1Tmt/NkDvz6qLCTJ3hsgikC2ZfI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DF07931A8C;
        Wed, 19 Jul 2023 17:32:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 608EF31A8B;
        Wed, 19 Jul 2023 17:32:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, alban.gruin@gmail.com
Subject: Re: [PATCH] sequencer: finish parsing the todo list despite an
 invalid first line
References: <20230719144339.447852-1-alexhenrie24@gmail.com>
Date:   Wed, 19 Jul 2023 14:32:35 -0700
In-Reply-To: <20230719144339.447852-1-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Wed, 19 Jul 2023 08:43:15 -0600")
Message-ID: <xmqq351ja8p8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C772E9CC-267B-11EE-9247-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> ddb81e5072 (rebase-interactive: use todo_list_write_to_file() in
> edit_todo_list(), 2019-03-05) made edit_todo_list more efficient by
> replacing transform_todo_file with todo_list_parse_insn_buffer.
> Unfortunately, that innocuous change caused a regression because
> todo_list_parse_insn_buffer would stop parsing after encountering an
> invalid 'fixup' line. If the user accidentally made the first line a
> 'fixup' and tried to recover from their mistake with `git rebase
> --edit-todo`, all of the commands after the first would be lost.
>
> To avoid throwing away important parts of the todo list, change
> todo_list_parse_insn_buffer to keep going and not return early on error.
>
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  sequencer.c                   |  2 +-
>  t/t3404-rebase-interactive.sh | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index cc9821ece2..adc9cfb4df 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2702,7 +2702,7 @@ int todo_list_parse_insn_buffer(struct repository *r, char *buf,
>  		if (fixup_okay)
>  			; /* do nothing */
>  		else if (is_fixup(item->command))
> -			return error(_("cannot '%s' without a previous commit"),
> +			res = error(_("cannot '%s' without a previous commit"),
>  				command_to_string(item->command));
>  		else if (!is_noop(item->command))
>  			fixup_okay = 1;

Well spotted.

> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index ff0afad63e..d2801ffee4 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1596,6 +1596,25 @@ test_expect_success 'static check of bad command' '
>  	test C = $(git cat-file commit HEAD^ | sed -ne \$p)
>  '
>  
> +test_expect_success 'the first command cannot be a fixup' '

A very good test to the point.

> +	# When using `git rebase --edit-todo` to recover from this error, ensure
> +	# that none of the original todo list is lost
> +	rebase_setup_and_clean fixup-first &&
> +	(
> +		set_fake_editor &&
> +		test_must_fail env FAKE_LINES="fixup 1 2 3 4 5" \
> +			       git rebase -i --root 2>actual &&
> +		test_i18ngrep "cannot .fixup. without a previous commit" \
> +				actual &&
> +		test_i18ngrep "You can fix this with .git rebase --edit-todo.." \
> +				actual &&

These days, we do not add new uses of test_i18n_grep; just replacing
it with "grep" would be good enough, so I'll touch them up locally.

> +		grep -v "^#" .git/rebase-merge/git-rebase-todo >orig &&
> +		test_must_fail git rebase --edit-todo &&
> +		grep -v "^#" .git/rebase-merge/git-rebase-todo >actual &&

Makes me wonder if "grep -v" is too loose (i.e. are there good
reasons to expect/allow that comments would be different and will
not compare well if they are left in?) and is too tight (i.e. can
the rebase machinery when rewriting the todo file reformat the
contents on the non-comment lines in such a way that they do not
compare byte-for-byte identical?).  But we'll find out if its the
latter (and we do not care too much if future changes to the command
will start clobbering the comment lines).

Will queue with minimum fixups.

Thanks.

> +		test_cmp orig actual
> +	)
> +'
> +
>  test_expect_success 'tabs and spaces are accepted in the todolist' '
>  	rebase_setup_and_clean indented-comment &&
>  	write_script add-indent.sh <<-\EOF &&
