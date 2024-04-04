Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21DB82D90
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 16:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712247764; cv=none; b=cylhVIAdEWvt39+ojVuhEkd3B4r+lYanqfEpaCXkviqlkXW+nwOXZzmDZ9Wp7KVlraEZXyy0gEpMa6G4BuvGyooN+gloxMtfqF5zt+sfmz24cC45JZXlQHdtT2N9rq0AB1WbskmZ4WXl7K7crbauEsJROtB229968vLjyyH484w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712247764; c=relaxed/simple;
	bh=FrNrJ4C1O6GCp9D8cPsowUDdolYfB/7oI2DKHQpUTMM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZNYxnOBRocDEVX0m7jidY+kklQ7lhK+fLHd56yR4gOBXB45mAPIEouh8MVqo0ijBtKw2yRb9z/QlFVNUhUwDmrGulQJZedA7DE8+5x/VH+g55rtFbnv+hLFVdkqb8i6RraYOP11VjURByLV7iLX2oaSdGn82m3eGGfJFcL8KU8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=PkUk0x8l; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PkUk0x8l"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 66EBD1BCA2;
	Thu,  4 Apr 2024 12:22:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=FrNrJ4C1O6GCp9D8cPsowUDdolYfB/7oI2DKHQ
	pUTMM=; b=PkUk0x8llLk1VX4NrB9TCmNm7SfWjGPGBwb3/hQ/1OyXqNDt4B9vNh
	JA8VjTtMW29ztq0Wx396tvnTpb0ku3WCuwqGKWQQlkXOQqsCQJvoakdWXVj5M4W1
	qAoa7a1nFgHq1GDAD82yhT+iIrrLHLxiQgo6/JFmKL3lVTjj6VW2g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5EF511BCA1;
	Thu,  4 Apr 2024 12:22:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DDC4A1BCA0;
	Thu,  4 Apr 2024 12:22:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "David Bimmler via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  David Bimmler <david.bimmler@isovalent.com>
Subject: Re: [PATCH] sequencer: honor signoff opt in run_git_commit
In-Reply-To: <pull.1707.git.1712223572933.gitgitgadget@gmail.com> (David
	Bimmler via GitGitGadget's message of "Thu, 04 Apr 2024 09:39:32
	+0000")
References: <pull.1707.git.1712223572933.gitgitgadget@gmail.com>
Date: Thu, 04 Apr 2024 09:22:31 -0700
Message-ID: <xmqqzfu914jc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8A4F7380-F29F-11EE-B8AA-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"David Bimmler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: David Bimmler <david.bimmler@isovalent.com>
>
> When rebasing interactively, --signoff would not take effect for commits
> which conflict. That is, commits applying cleanly would be signed off,
> but commits requiring intervention would miss the sign off trailer.

Good finding.

> The reason is that run_git_commit did not check for the signoff replay
> opt, and hence even though the option was picked up and passed
> correctly, the actual committing dropped the ball.

We record and read back the initial "--signoff" given from the
command line (and options.signoff from the "options sheet" when not
REPLAY_INTERACTIVE_REBASE) in opts->signoff, but that piece of
information is used only to decide if we call append_signoff().
When do_commit(), after try_to_commit() punts, calls "git commit",
the invocation lacks "--signoff" on the command line.

    Side note: the "let's avoid spawning 'git commit' and duplicate
    it in-process" codepath in try_to_commit() does not seem to pay
    attention to opts->signoff at all, and it does not do the
    append_signoff() to add the trailer.  Is this something this
    patch needs to fix as well, or am I misreading the control flow
    (e.g., perhaps opts->signoff is set we somehow refrain from
    doing the "let's do it in-process" logic)?

If we forgot to tell "git commit" that we want the result
signed-off, of course it would not add the trailer.  Perhaps

    -correctly, the actual committing dropped the ball" 
    +correctly to run_git_commit(), it failed to pass it to
    +underlying 'git commit'

is less misleading.

> The patch adds a test specifically for this case, as well as amending a
> squash test which codified the broken behaviour.

"The patch adds" -> "Add"

I love this kind of test update that corrects a mistaken expectation
after a careful analysis of how the commands should behave.

Very good job.  Nicely done.

> diff --git a/sequencer.c b/sequencer.c
> index fa838f264f5..16595e26a17 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1121,6 +1121,8 @@ static int run_git_commit(const char *defmsg,
>  		strvec_pushf(&cmd.args, "-S%s", opts->gpg_sign);
>  	else
>  		strvec_push(&cmd.args, "--no-gpg-sign");
> +	if (opts->signoff)
> +		strvec_push(&cmd.args, "--signoff");
>  	if (defmsg)
>  		strvec_pushl(&cmd.args, "-F", defmsg, NULL);
>  	else if (!(flags & EDIT_MSG))

This is straight-forward and obviously correct.

> diff --git a/t/t3428-rebase-signoff.sh b/t/t3428-rebase-signoff.sh
> index e1b1e947647..fcecdf41978 100755
> --- a/t/t3428-rebase-signoff.sh
> +++ b/t/t3428-rebase-signoff.sh
> @@ -27,6 +27,13 @@ first
>  Signed-off-by: $(git var GIT_COMMITTER_IDENT | sed -e "s/>.*/>/")
>  EOF
>  
> +# Expected signed off message after resolving the conflict
> +cat >expected-signed-after-conflict <<EOF
> +update file on side
> +
> +Signed-off-by: $(git var GIT_COMMITTER_IDENT | sed -e "s/>.*/>/")
> +EOF
> +

The t3428 script uses ancient style to prepare these expectations
outside the test_expect_success blocks, and following the pattern
is fine (until we clean-up the style of the whole script).  Cleaning
it up is better done as a separate series, and when the dust settles
after this fix lands.  #leftoverbits 

>  # Expected commit message after rebase without --signoff (or with --no-signoff)
>  cat >expected-unsigned <<EOF
>  first
> @@ -82,4 +89,30 @@ test_expect_success 'rebase -m --signoff fails' '
>  	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
>  	test_cmp expected-signed actual
>  '
> +
> +test_expect_success 'rebase -i signs commits even if a conflict occurs' '
> +	git branch -M main &&
> +
> +	git branch side &&
> +	echo "b" >file &&
> +	git add file &&
> +	git commit -m"update file" &&

Have a SP between "-m" and its value, imitating existing tests.

> +	test_tick &&

Why?  Does the rest of the test depend on commits to have different
timestamps?

If you want to use test_tick, the pattern to follow is to call it
_before_ creating a commit, not after.  Up to this point in the
original script nobody calls it (or test_commit that by default
calls it), so "test_tick && git_commit" would be OK.

But if there is no dependency on exact sequence of timestamps,
letting the commit share the same initial timestamp (hardcoded in
test-lib.sh for better reproducibility) is more preferable, as use
of test_tick sends a wrong message that the test results may be
affected by the exact timestamps.

> +	test_must_fail git rebase -i --signoff main &&
> +
> +	echo "merged" >file &&
> +	git add file &&
> +	git rebase --continue &&
> +
> +	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
> +	test_cmp expected-signed-after-conflict actual

Running any git command on the left hand side of a pipe is frowned
upon, as it will hide exit status from it when it fails.

In this case, the primary thing we care about is that we have added
the sign off that did not exist in the original, so I wonder

	git cat-file commit HEAD >actual &&
	test_grep "Signed-off-by: " actual

would be sufficient?

> +'
> +
>  test_done
> diff --git a/t/t3437/expected-squash-message b/t/t3437/expected-squash-message
> index ab2434f90ed..d74af0bcf6b 100644
> --- a/t/t3437/expected-squash-message
> +++ b/t/t3437/expected-squash-message
> @@ -48,4 +48,6 @@ edited 1
>  edited 2
>  
>  edited 3
> +
> +Signed-off-by: Rebase Committer <rebase.committer@example.com>
>  squashed

This defines the expected outcome from

    git rebase -ik --signoff A

in t3437-rebase-fixup-options.sh; I am not sure if the location the
sign-off is inserted is sensible, though.

Thanks.
