Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D000C433ED
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 19:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5245261205
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 19:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355523AbhDGTAi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 15:00:38 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58034 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355515AbhDGTAg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 15:00:36 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CFAB11263DA;
        Wed,  7 Apr 2021 15:00:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vsMHETV+iCU9e69DWRIyo3KVQn4=; b=oOrS/L
        cJ+Q3E8bJVuvq02GU/DPMd6PI/W6awRjZ+RTaOcn6I57hWFL1vrrjb1e5udG+E8l
        0CNpUOZxKE6KcpOqQtKBQB8oiRXoNAhA5z+/ivvEkM/7Tgi2GcIgs73yOSL0Fqen
        REiVdB9ZfeGd9Swv3LhZWCuNG/s1C8DYB2StI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sVsxH7HCqCWrNw/4EiHR5DkM0JDUtdYh
        kcYFud3xn5t7Vx6khCX7GKVl3T4KSFVjGKMjB/jTpTnbgrh5IPxQYqI6x5dQY0zf
        Sh3RBXC1/GRYUPl7N+3nqTMZ+/ruZtbYQ/rxa7CWdTkc9TZcrVj+1wo+TMr+ocuJ
        ZjvgpWSAcHg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C78D91263D9;
        Wed,  7 Apr 2021 15:00:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AC5BF1263D8;
        Wed,  7 Apr 2021 15:00:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jerry Zhang <jerry@skydio.com>
Cc:     git@vger.kernel.org, newren@gmail.com, ross@skydio.com,
        abe@skydio.com, brian.kubisiak@skydio.com
Subject: Re: [PATCH v4] git-apply: allow simultaneous --cached and --3way
 options
References: <20210406024931.24355-1-jerry@skydio.com>
        <20210407180349.10173-1-jerry@skydio.com>
Date:   Wed, 07 Apr 2021 12:00:19 -0700
In-Reply-To: <20210407180349.10173-1-jerry@skydio.com> (Jerry Zhang's message
        of "Wed, 7 Apr 2021 11:03:49 -0700")
Message-ID: <xmqqzgy9zzr0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 80A69C8E-97D3-11EB-83ED-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jerry Zhang <jerry@skydio.com> writes:

> "git apply" does not allow "--cached" and
> "--3way" to be used together, since "--3way"
> writes conflict markers into the working tree.
>
> Allow "git apply" to accept "--cached" and
> "--3way" at the same time.  When a single file
> auto-resolves cleanly, the result is placed in the
> index at stage #0 and the command exits with 0
> status.  For a file that has a conflict which
> cannot be cleanly auto-resolved, the original
> contents from common ancestor (stage #1), our
> version (stage #2) and the contents from the
> patch (stage #3) are left at separate stages.
> No attempt is made to resolve the conflict at
> the content level, and the command exists with
> non-zero status, because there is no place
> (like the working tree) to leave a half-resolved
> merge for the user to resolve.
>
> The user can use `git diff` to view the contents
> of the conflict, or `git checkout -m -- .` to
> regenerate the conflict markers in the working
> directory.
>
> Don't attempt rerere in this case since it depends
> on conflict markers written to file for its database
> storage and lookup. There would be two main changes
> required to get rerere working:
> 1. Allow the rerere api to accept in memory object
> rather than files, which would allow us to pass in
> the conflict markers contained in the result from
> ll_merge().
> 2. Rerere can't write to the working directory, so
> it would have to apply the result to cache stage #0
> directly. A flag would be needed to control this.
>
> Signed-off-by: Jerry Zhang <jerry@skydio.com>
> ---

For future reference, please summarize what changed between v3 and
v4 in this space immediately after the three-dash line.  This is
especially helpful when sending v4 so soon after v3 that nobody had
a chance to review and respond to v3, as it helps reviewers to
decide if it is safe to skip v3 and jump directly to v4 to start
reading.

>  Documentation/git-apply.txt |  6 ++++--
>  apply.c                     |  7 +++----
>  t/t4108-apply-threeway.sh   | 24 ++++++++++++++++++++++++
>  3 files changed, 31 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
> index 9144575299c264dd299b542b7b5948eef35f211c..aa1ae56a25e0428cabcfa2539900ef2a09abcb7c 100644
> --- a/Documentation/git-apply.txt
> +++ b/Documentation/git-apply.txt
> @@ -87,8 +87,10 @@ OPTIONS
>  	Attempt 3-way merge if the patch records the identity of blobs it is supposed
>  	to apply to and we have those blobs available locally, possibly leaving the
>  	conflict markers in the files in the working tree for the user to
> -	resolve.  This option implies the `--index` option, and is incompatible
> -	with the `--reject` and the `--cached` options.
> +	resolve.  This option implies the `--index` option unless the
> +	`--cached` option is used, and is incompatible with the `--reject` option.
> +	When used with the `--cached` option, any conflicts are left at higher stages
> +	in the cache.

Also for future reference.

It is clear to me (from the pre-context lines of the above hunk)
that this change wants to depend on the other "3way-first" topic,
because I reviewed the other topic.

But it would not be too much trouble to say "this builds on the
jz/apply-run-3way-first topic 923cd87a (git-apply: try threeway
first when "--3way" is used, 2021-04-06)".  When potential reviewers
are tempted to apply this and try it out while reviewing, such a
note would help them.  And as a patch author, you would want to
increase the chance that your patch gets reviewed, so any help you
give to potential reviewers would help you.

The space between the three-dash line and the diffstat is the place
to write it.

> diff --git a/apply.c b/apply.c
> index 9bd4efcbced842d2c5c030a0f2178ddb36114600..0d1e91c88986433052e9b6e67c0dcbd04e6eb703 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -133,8 +133,6 @@ int check_apply_state(struct apply_state *state, int force_apply)
>  
>  	if (state->apply_with_reject && state->threeway)
>  		return error(_("--reject and --3way cannot be used together."));
> -	if (state->cached && state->threeway)
> -		return error(_("--cached and --3way cannot be used together."));
>  	if (state->threeway) {
>  		if (is_not_gitdir)
>  			return error(_("--3way outside a repository"));
> @@ -4644,8 +4642,9 @@ static int write_out_results(struct apply_state *state, struct patch *list)
>  				fprintf(stderr, "U %s\n", item->string);
>  		}
>  		string_list_clear(&cpath, 0);
> -
> -		repo_rerere(state->repo, 0);
> +		/* rerere relies on conflict markers which aren't written with --cached */

A minor nit.  It is not just "conflict markers" that rerere wants.
It wants a intermediate half-merged result "in the working tree",
because it does not work with in-core copy.  So

                /*
                 * With --cached, we do not write conflicted file to the
                 * working tree, so cannot use rerere to reuse previous
		 * resolution.
                 */

or something, perhaps.

> +		if (!state->cached)
> +			repo_rerere(state->repo, 0);
>  	}
>  
>  	return errs;
> diff --git a/t/t4108-apply-threeway.sh b/t/t4108-apply-threeway.sh
> index 9ff313f976422f9c12dc8032d14567b54cfe3765..37ba4f6fa201c49a4bf2882d6b8345c1c2bedf0c 100755
> --- a/t/t4108-apply-threeway.sh
> +++ b/t/t4108-apply-threeway.sh
> @@ -180,4 +180,28 @@ test_expect_success 'apply -3 with ambiguous repeating file' '
>  	test_cmp expect one_two_repeat
>  '
>  
> +test_expect_success 'apply with --3way --cached' '
> +	# Merging side should be similar to applying this patch
> +	git diff ...side >P.diff &&
> +
> +	# The corresponding conflicted merge
> +	git reset --hard &&
> +	git checkout main^0 &&
> +	test_must_fail git merge --no-commit side &&
> +	git ls-files -s >expect.ls &&
> +
> +	# should fail to apply
> +	git reset --hard &&
> +	git checkout main^0 &&
> +	test_must_fail git apply --cached --3way P.diff &&
> +	git ls-files -s >actual.ls &&
> +	print_sanitized_conflicted_diff >actual.diff &&
> +
> +	# The cache should resemble the corresponding merge
> +	test_cmp expect.ls actual.ls &&
> +	# However the working directory should not change
> +	>expect.diff &&
> +	test_cmp expect.diff actual.diff
> +'

Interesting.  I would have expected "ls-files -u" would be used, but
using "-s" to see the stage #0 entries is more thorough.

The above is only about a failing case, which is of course an
important case to validate, but don't we also want to check a
successful case, and a case where two paths are touched, and one
applies cleanly while the other conflicts?

Thanks.
