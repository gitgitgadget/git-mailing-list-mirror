Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95D1C433F5
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 23:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbiDOXPi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 19:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiDOXPg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 19:15:36 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C4549683
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 16:13:05 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E6F9010D6BF;
        Fri, 15 Apr 2022 19:13:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0CTjQOV7HRcb4V560VdvE5W2xUFlgW6SxOmREt
        9kWDc=; b=SjNKQk5TTeeX5BLLmnxzQV4dfS5UzcC2DT2/fN1kztHr+9Bd5R0Nhs
        MWiabnBZmu7IY0y2llQeNBMgDFoQBHXxUeYIPmcpkYPrAIPIK7g7M6kxKyZpmJVu
        H/Q5lIWVqQNAQ1EV9qX7mXXD17TiHOa/TYbwVy7TBuK6Cd2pxgixM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D8B7910D6BE;
        Fri, 15 Apr 2022 19:13:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0474110D6BB;
        Fri, 15 Apr 2022 19:13:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miklos Vajna <vmiklos@vmiklos.hu>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v4] git-log: add a --since=... --as-filter option
References: <xmqqtub3moa0.fsf@gitster.g> <xmqqv8vkpara.fsf@gitster.g>
        <YlCiqgO6rL908Zsi@vmiklos.hu>
        <220412.86pmlmhe9a.gmgdl@evledraar.gmail.com>
        <YlnYDgZRzDI87b/z@vmiklos.hu>
Date:   Fri, 15 Apr 2022 16:13:02 -0700
In-Reply-To: <YlnYDgZRzDI87b/z@vmiklos.hu> (Miklos Vajna's message of "Fri, 15
        Apr 2022 22:39:42 +0200")
Message-ID: <xmqqmtgm9c01.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A2D04A4-BD11-11EC-A02A-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miklos Vajna <vmiklos@vmiklos.hu> writes:

> This is similar to --since, but it will filter out not matching commits,
> rather than stopping at the first not matching commit.
>
> This is useful if you e.g. want to list the commits from the last year,
> but one odd commit has a bad commit date and that would hide lots of
> earlier commits in that range.
>
> The behavior of --since is left unchanged, since it's valid to depend on
> its current behavior.

The above is good if it were a new --since-as-filter option.  Adding
"--as-filter" as a separate option to be used in conjunction with
"--since" would fundamentally mean "The behaviour of --since is left
unchanged" cannot possibly be true.

A suggested rewrite.  I label each section and highlight its point,
but in the end product, you should just separate them with a blank
line, making each of them into its own paragraph.

Title (single line, short and to the point)

    log: "--as-filter" option adjusts how "--since" cut-off works

Intro (observation of the current state)

    The "--since=<time>" option of "git log" limits the commits
    displayed by the command by stopping the traversal once it
    sees a commit whose timestamp is older than the given time and
    not digging further into its parents.

Problem description (pros and cons of the current state)

    This is OK in a history where a commit always has a newer
    timestamp than any of its parents'.  Once you see a commit older
    than the given <time>, all ancestor commits of it are even older
    than the time anyway.  It poses, however, a problem when there
    is a commit with a wrong timestamp that makes it appear older
    than its parents.  Stopping traversal at the "incorrectly old"
    commit will hide its ancestors that are newer than that wrong
    commit and are newer than the cut-off time given with the --since
    option.  --max-age and --after being the synonyms to --since,
    they share the same issue.

Solution (give orders to the codebase to "be like so")

    Add a new "--as-filter" option that modifies how "--since=<time>"
    is used.  Instead of stopping the traversal to hide an old
    enough commit and its all ancestors, exclude commits with an old
    timestamp from the output but still keep digging the history.

Other comments (caveats, etc.)

    Without other traversal stopping options, this will force the
    command in "git log" family to dig down the history to the root.
    It may be an acceptable cost for a small project with short
    history and many commits with screwy timestamps.

> diff --git a/revision.c b/revision.c
> index 7d435f8048..ff018c3976 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1440,6 +1440,9 @@ static int limit_list(struct rev_info *revs)
>  		if (revs->min_age != -1 && (commit->date > revs->min_age) &&
>  		    !revs->line_level_traverse)
>  			continue;
> +		if (revs->max_age != -1 && revs->as_filter && (commit->date < revs->max_age) &&
> +		    !revs->line_level_traverse)

That's an overly long line.

> +			continue;

In any case, isn't this too late in limit_list() to adjust --since?
There is this logic earlier in the loop:

	while (original_list) {
		struct commit *commit = pop_commit(&original_list);
		struct object *obj = &commit->object;
		show_early_output_fn_t show;

		if (commit == interesting_cache)
			interesting_cache = NULL;

		if (revs->max_age != -1 && (commit->date < revs->max_age))
			obj->flags |= UNINTERESTING;
		if (process_parents(revs, commit, &original_list, NULL) < 0)
			return -1;

We look at max_age and if it is set and newer than the timestamp of
the commit we are looking at, we immediately mark that commit
uninteresting so that this and all its ancestors are excluded from
the output.  Don't you want to disable that logic so that the
traversal continues?

> @@ -3862,6 +3868,9 @@ enum commit_action get_commit_action(struct rev_info *revs, struct commit *commi
>  	if (revs->min_age != -1 &&
>  	    comparison_date(revs, commit) > revs->min_age)
>  			return commit_ignore;
> +	if (revs->max_age != -1 && revs->as_filter &&
> +	    comparison_date(revs, commit) < revs->max_age)
> +			return commit_ignore;
>  	if (revs->min_parents || (revs->max_parents >= 0)) {
>  		int n = commit_list_count(commit->parents);
>  		if ((n < revs->min_parents) ||

I am not sure how --since should affect (or not affect) the history
simplification, but my gut feeling says this may cause unintended
fallout.  I do not have time to dig deeper today, but something to
keep in mind...

> diff --git a/t/t4217-log-limit.sh b/t/t4217-log-limit.sh
> new file mode 100755
> index 0000000000..2a3705c714
> --- /dev/null
> +++ b/t/t4217-log-limit.sh
> @@ -0,0 +1,36 @@
> +#!/bin/sh
> +
> +test_description='git log with filter options limiting the output'

OK.

> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME

Does any of the tests in this file care?  The above is a mechanism
primarily for transitioning scripts that were written long time ago,
and newly written tests that do not have to care about the initial
branch should not need it (they can instead explicitly create a
branch and work on it, if they really need to refer the initial
branch by name, but as far as I can tell, none your test in this
file even needs to refer to any branch with any name).

> +
> +. ./test-lib.sh
> +
> +GIT_TEST_COMMIT_GRAPH=0
> +GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0

Do these matter, and should these matter?  Does anybody export them
to make any difference in this test?

> +test_expect_success 'setup test' '
> +	git init &&
> +	echo a > file &&

Style:

	echo a >file &&

(cf. Documentation/CodingGuidelines)

> +	git add file &&
> +	GIT_COMMITTER_DATE="2021-02-01 0:00" git commit -m init &&

It is somewhat annoying to see 00:00 spelled as 0:00 here (and below).

> +	echo a >> file &&
> +	git add file &&
> +	GIT_COMMITTER_DATE="2022-02-01 0:00" git commit -m first &&
> +	echo a >> file &&
> +	git add file &&
> +	GIT_COMMITTER_DATE="2021-03-01 0:00" git commit -m second &&
> +	echo a >> file &&
> +	git add file &&
> +	GIT_COMMITTER_DATE="2022-03-01 0:00" git commit -m third
> +'
> +
> +test_expect_success 'git log --since=... --as-filter' '
> +	git log --since="2022-01-01" --as-filter --pretty="format:%s" > actual &&

I think you meant --format=%s (which is --pretty="tformat:%s"), as
you do not want "actual" to end in an incomplete line.  The same
"no space between the redirection operator and its target" applies
here as everywhere else.

> +	! test_i18ngrep init actual &&
> +	test_i18ngrep first actual &&
> +	! test_i18ngrep second actual &&
> +	test_i18ngrep third actual

test_i18ngrep -> grep

But stepping back a bit, do we or do we not care the order in which
first and third appear in the "actual" file?  It's not like we have
a mergy history and two commits that cannot topologically be
compared.  We have a simple linear single strand of pearls here, and
if you start traversing from the tip, you'll reliably see third
first, then second, then first and then finally init, in that order
and in no other order.  So, wouldn't we be better off writing it
more like ...

	git log --since=2022-01-01 --as-filter --format=%s >actual &&
	cat >expect <<-\EOF &&
	third
	first
	EOF
	test_cmp expect actual

... i.e. explicitly spell out what we expect not to change?

Thanks.
