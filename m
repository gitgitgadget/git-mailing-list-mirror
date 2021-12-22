Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76548C433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 23:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343708AbhLVXxF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 18:53:05 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62323 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232471AbhLVXxE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 18:53:04 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4A99315257E;
        Wed, 22 Dec 2021 18:53:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dJ6LoSem6MrM/a+cU46wRqOkBj+OF/19jFQE/T
        n3esg=; b=AxBYDJ7IMtXZIShRgQiN7DSMyd+qbeGeCvNBR7QgtDzzFrHMc5m2LP
        8f70T9IT4he/eno9Erznb0x30aYEtfxRcf63cLox0ufWhzGAn5BPPIx3fPiz+4kb
        +b0ZOMcPF6giIELIEdM4RBUNronyJcs9Baw0egB8v9ZmPx2a8ta88=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 439E915257D;
        Wed, 22 Dec 2021 18:53:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 95607152576;
        Wed, 22 Dec 2021 18:53:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Marc Strapetz via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Marc Strapetz <marc.strapetz@syntevo.com>
Subject: Re: [PATCH] update-index: refresh should rewrite index in case of
 racy timestamps
References: <pull.1105.git.1640181390841.gitgitgadget@gmail.com>
Date:   Wed, 22 Dec 2021 15:52:59 -0800
In-Reply-To: <pull.1105.git.1640181390841.gitgitgadget@gmail.com> (Marc
        Strapetz via GitGitGadget's message of "Wed, 22 Dec 2021 13:56:30
        +0000")
Message-ID: <xmqqfsqkdwo4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4B901C0C-6382-11EC-BBE3-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Marc Strapetz via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  builtin/update-index.c               |  6 +++
>  cache.h                              |  1 +
>  read-cache.c                         |  2 +-
>  t/t2108-update-index-refresh-racy.sh | 58 ++++++++++++++++++++++++++++
>  4 files changed, 66 insertions(+), 1 deletion(-)
>  create mode 100755 t/t2108-update-index-refresh-racy.sh
>
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index 187203e8bb5..0a069281e23 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -787,6 +787,12 @@ static int refresh(struct refresh_params *o, unsigned int flag)
>  	setup_work_tree();
>  	read_cache();
>  	*o->has_errors |= refresh_cache(o->flags | flag);
> +	if (has_racy_timestamp(&the_index)) {
> +		/* For racy timestamps we should set active_cache_changed immediately:
> +		 * other callbacks may follow for which some of them may reset
> +		 * active_cache_changed. */
> +		active_cache_changed |= SOMETHING_CHANGED;
> +	}

Documentation/CodingGuidelines says:

 - Multi-line comments include their delimiters on separate lines from
   the text.  E.g.

	/*
	 * A very long
	 * multi-line comment.
	 */

The last half-sentence puzzles me, partly because of the word
"callback", which is an implementation detail of how --refresh and
other actions are triggered by the update-index command.  Calling
them "operation" or "action" might be easier to understand.  I dunno.

But more problematic is the word "reset", which at least to me
implies that the SOMETHING_CHANGED bit may be cleared by them, which
sounds just wrong and broken.

    ... goes and looks ...

Ah, there are cases where we do clear active_cache_changed when we
notice that an operation detected an error, to avoid spreading the
breakage by writing the index file out, and I think that is the
right thing to do.  Which means that the above patch is not quite
right.  Perhaps taking all of the above together, something like
this?

	*o->has_errors |= refresh_cache(o->flags | flag);
	if (*o->has_errors)
		active_cache_changed = 0; 
	else if (has_racy_timestamps(&the_index))
        	/*
		 * Even if nothing else has changed, updating the file
		 * increases the chance that racy timestamps become
		 * non-racy, helping future run-time performance.
		 */
		active_cache_changed |= SOMETHING_CHANGED;


> diff --git a/t/t2108-update-index-refresh-racy.sh b/t/t2108-update-index-refresh-racy.sh
> new file mode 100755
> index 00000000000..ece1151847c
> --- /dev/null
> +++ b/t/t2108-update-index-refresh-racy.sh
> @@ -0,0 +1,58 @@
> +#!/bin/sh
> +
> +test_description='update-index refresh tests related to racy timestamps'
> +
> +. ./test-lib.sh
> +
> +reset_mtime() {

Documentation/CodingGuidelines

 - We prefer a space between the function name and the parentheses,
   and no space inside the parentheses. The opening "{" should also
   be on the same line.

	(incorrect)
	my_function(){
		...

	(correct)
	my_function () {
		...

> +	test-tool chmtime =$(test-tool chmtime --get .git/fs-tstamp) $1

Even if we know all the existing callers pass a single word argument
to this function, it would be a good discipline to put double-quotes
around "$1" to assure the readers that we are future-proofed.

> +}
> +
> +update_assert_unchanged() {
> +	local ts1=$(test-tool chmtime --get .git/index) &&
> +	git update-index $1 &&
> +	local ts2=$(test-tool chmtime --get .git/index) &&
> +	[ $ts1 -eq $ts2 ]

Documentation/CodingGuidelines

 - We prefer "test" over "[ ... ]".

> +}
> +
> +update_assert_changed() {
> +	local ts1=$(test-tool chmtime --get .git/index) &&
> +	test_might_fail git update-index $1 &&
> +	local ts2=$(test-tool chmtime --get .git/index) &&
> +	[ $ts1 -ne $ts2 ]
> +}
> +
> +test_expect_success 'setup' '
> +	touch .git/fs-tstamp &&

Not that it is wrong, but do we need to create such a throw-away
file inside the .git directory?

When we care only the presence of a path, and not that the path has
the current timestamp, we prefer not to use "touch".

	>.git/fs-tstamp

I am debating myself which is more appropriate in this case.  A
mistaken implementation of "touch" could call gettimeofday() and use
the result to call utimes(), leaving wallclock timestamp in the
result, but redirecation to create or truncate the path is a more
guaranteed way to make sure the timestamp comes from the filesystem,
so it may be more suitable for our needs here.

> +	test-tool chmtime -1 .git/fs-tstamp &&
> +	echo content >file &&
> +	reset_mtime file &&
> +
> +	git add file &&
> +	git commit -m "initial import"
> +'
> +
> +test_expect_success '--refresh has no racy timestamps to fix' '
> +	reset_mtime .git/index &&
> +	test-tool chmtime +1 .git/index &&
> +	update_assert_unchanged --refresh
> +'
> +
> +test_expect_success '--refresh should fix racy timestamp' '
> +	reset_mtime .git/index &&
> +	update_assert_changed --refresh
> +'
> +
> +test_expect_success '--really-refresh should fix racy timestamp' '
> +	reset_mtime .git/index &&
> +	update_assert_changed --really-refresh
> +'
> +
> +test_expect_success '--refresh should fix racy timestamp even if needs update' '
> +	echo content2 >file &&
> +	reset_mtime file &&
> +	reset_mtime .git/index &&
> +	update_assert_changed --refresh
> +'
> +
> +test_done
>
> base-commit: 597af311a2899bfd6640b9b107622c5795d5f998
