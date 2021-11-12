Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41729C433F5
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 22:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 267CC60698
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 22:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235980AbhKLWZz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 17:25:55 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56136 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhKLWZy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 17:25:54 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A9EE6FB636;
        Fri, 12 Nov 2021 17:23:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=SnvK3NJhLLckxK7xhtlPMMlOCaL8XKDJQcZe5oagBz0=; b=mwJ3
        MDSWUucMMnyUQdP2yZ8l79wqj7KLtLTxpCQ3kDTyEq7ggfWD8AG6EBl3TrtakQGy
        FcZ2etxTC3cSlj+eR8VIpQlwbNZOriJ2PM4DJcrbwITsTDEF4RkwrHiwPZJE4jLm
        gCZao4ULV89e0BYWLsg/o9xM9x4vY8TomyjQ8x4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A1CF2FB635;
        Fri, 12 Nov 2021 17:23:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EE332FB634;
        Fri, 12 Nov 2021 17:23:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Aleen <aleen42@vip.qq.com>
Subject: Re: [PATCH v2 2/4] am: support --always option to am empty commits
References: <pull.1076.git.1636693095.gitgitgadget@gmail.com>
        <pull.1076.v2.git.1636700040.gitgitgadget@gmail.com>
        <59b1417da3754add11e72692ec11c09e486269e4.1636700040.git.gitgitgadget@gmail.com>
Date:   Fri, 12 Nov 2021 14:23:00 -0800
Message-ID: <xmqq4k8hovy3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 193436B6-4407-11EC-9B89-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Aleen via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Aleen <aleen42@vip.qq.com>
> Subject: Re: [PATCH v2 2/4] am: support --always option to am empty commits

As the inventor of "format-patch" and "am", I probably should wish
that "to am" were by now a valid verb, but no, it is not.

More importantly, when an empty patch comes, there can be many
different ways for the "am" command to handle it.  "to am empty
commits" does not say how the patch chooses to so and does not make
a very useful title for this commit.

Right now, we error out, simply because it is an easy mistake to
save a non-patch e-mail to the mailbox when intending to save a
series of patches belonging to a topic, and the user is expected to
say "git am --skip" to skip over it when it happens.  The above
"Subject:" can be read to mean that the new option instead allows
such an empty message to be skipped without stopping and forcing the
user to say "am --skip", which may be a useful thing to do.  Or it
may mean that the new option creates an empty commit, using the
contents of the e-mail as the commit log message.  Does this patch
offer both behaviour?  If so, "to am", even though it does not
convey a bit of information, might be an acceptable compromise.  If
the patch implements only one of the behaviours, then we should say
so.  Either one of these two:

    am: --always option skips empty patches
    am: --always option records empty patches as empty commits

Also, I thought that the previous round saw a conclusion that --always
is a bad name for the option.  If we are making the second round,
let's not start with a bad name and the "fix the mistake" of
starting with a bad name in a later step.  Just start with the final
name from the beginning.

> +--always::
> +	Apply patches of commits with detailed commit messages,
> +	even if they emit no changes. (see linkgit:git-format-patch[1])

Almost the same comment as 1/4 applies to the above description.

    --empty-patch=(skip|asis|die)::
	The command usually errors out when seeing an input e-mail
	message that lacks a patch.  When this option is set to
	'skip', skip such an e-mail message without erroring out.
	When this option is set to 'asis', create an empty commit,
	recording the contents of the e-mail message as its log.
	'die' is the default.


perhaps?  Assuming that 'skip' would make a useful addition to the
mix in the future.

> diff --git a/builtin/am.c b/builtin/am.c
> index 8677ea2348a..d11efc16f92 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -124,6 +124,8 @@ struct am_state {
>  	int ignore_date;
>  	int allow_rerere_autoupdate;
>  	const char *sign_commit;
> +	int always;

OK, so here is where the parse_options() records the command line
option.

> +	int empty_commit;

I do not think this addtion of empty_commit member to this structure
is welcome or necessary.

>  	int rebasing;
>  };

> @@ -1249,8 +1251,12 @@ static int parse_mail(struct am_state *state, const char *mail)
>  	}

>  	if (is_empty_or_missing_file(am_path(state, "patch"))) {
> -		printf_ln(_("Patch is empty."));
> -		die_user_resolve(state);
> +		if (state->always) {
> +			state->empty_commit = 1;
> +		} else {
> +			printf_ln(_("Patch is empty."));
> +			die_user_resolve(state);
> +		}
>  	}

I am only thinking aloud, but I suspect that the whole "if 'patch'
is empty, do something special" code logically belongs to the
caller.  Perhaps we should remove this block altogether and let the
code continue the rest of this function.  And return 0, as this is
not like mail-system-internal-data that we want to pretend did not
even exist, and have the caller check if "patch" file is empty and
act accordingly.

> @@ -1792,6 +1798,9 @@ static void am_run(struct am_state *state, int resume)
>  		if (state->interactive && do_interactive(state))
>  			goto next;
>  
> +		if (state->empty_commit)
> +			goto commit;
> +

This is probably a wrong place to jump from.  You are bypassing
applypatch-msg-hook that may be serving as a gate to catch typos
if you are going to create a commit.

So, perhaps check if "patch" is empty here, using the code you'd
lift from parse_mail(), and if it is empty then:

  - if --empty-commit is set to die (or left default), do the
    printf_ln(_("Patch is empty.")) followed by a call to
    die_user_resolve(state), just like before.

  - if it is set to skip, jump to "next", just like when
    parse_mail() returned 1.

  - otherwise (i.e. you are told to create an empty commit),
    remember the fact that current e-mail has no patch, but continue
    to the next step to run the hook.

>  		if (run_applypatch_msg_hook(state))
>  			exit(1);

And after passing the hook, if your earlier check says that there is
no patch and you are to create an empty commit, jump to "commit"
label from here.

> diff --git a/t/t4150-am.sh b/t/t4150-am.sh
> index 2aaaa0d7ded..5b3617857a8 100755
> --- a/t/t4150-am.sh
> +++ b/t/t4150-am.sh
> @@ -196,6 +196,12 @@ test_expect_success setup '
>  
>  	git format-patch -M --stdout lorem^ >rename-add.patch &&
>  
> +	git checkout -b empty-commit &&
> +	git commit -m "empty commit" --allow-empty &&
> +
> +	git format-patch --stdout empty-commit^ >empty.patch &&
> +	git format-patch --always --stdout empty-commit^ >empty-commit.patch &&
> +
>  	# reset time
>  	sane_unset test_tick &&
>  	test_tick
> @@ -1152,4 +1158,23 @@ test_expect_success 'apply binary blob in partial clone' '
>  	git -C client am ../patch
>  '
>  
> +test_expect_success 'am a real empty patch with the --always option' '
> +	rm -fr .git/rebase-apply &&

What is this one about?  If this is trying to clean up the cruft the
previous step made, it may be better to do the clean-up in the
previous step using test_when_finished.

> +	git reset --hard &&
> +	test_must_fail git am --always empty.patch 2>actual &&
> +	echo Patch format detection failed. >expected &&
> +	test_cmp expected actual
> +'

It is curious that the error message the patch touched said "Patch
is empty." but the test checks for a different message.  Are we
testing the right failure mode?

> +test_expect_success 'am a patch with empty commits' '
> +	grep "empty commit" empty-commit.patch &&

What is this testing?  If it is checking the sanity of test data we
created earlier, shouldn't we do so where we generated the data
(i.e. the "setup" block that we earlier saw)?

> +	rm -fr .git/rebase-apply &&
> +	git reset --hard &&

These are trying to clean up the cruft the previous step (added by
this patch) may have left.  Perhaps these should be done inside
test_when_finished of the previous step?

> +	git checkout empty-commit^ &&
> +	git am --always empty-commit.patch &&
> +	test_path_is_missing .git/rebase-apply &&

We should trust "git am"'s exit status here, I would think, rather
than be so intimate with the internal implementation detail like the
name of the temporary directory the command uses.

> +	git cat-file commit HEAD >actual &&
> +	test_i18ngrep "empty commit" actual

test_i18ngrep -> grep

The input (i.e. the commit that resulted in this empty patch) said.
"empty commit", and we are making sure that string appears, but we
are not making sure that is the only string appears in the log
message.  Is it because we will later enhance the command to
automatically extend the single-liner "empty patch" log message into
a lot more detailed one?  I doubt it ;-)

More importantly, the above checks if (part of) the log message is
recorded, but does not check if the resulting commit is what is
expected, i.e. an empty one.

Perhaps checking with "grep" is way too loose a test.  Shouldn't we
do something like

	git show -1 --format='%B' >actual

and compare it with expected "the log is recorded as-is, and there
is no change between HEAD^ and HEAD"?

> +'
> +
>  test_done

Thanks.
