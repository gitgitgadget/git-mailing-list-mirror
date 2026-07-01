Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096DF3EFFA8
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 08:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782895860; cv=none; b=lq6H/F/DBzJzjhIx4aXQXf9xD4v+22KS/9Ep8kVIWODbE89KC/yeKAWeV5iYy7cuYesOQdDJT28jhlVsLfSMnccPuppwx8Qk9LUY7jAajpTwfxesXlHmctqKorL5kEggNjRpUO0reW9060iahy82bcKg3iWxCeBK8Jvx86hM34M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782895860; c=relaxed/simple;
	bh=3Ie/kC9KBYop/GAXq/HgSRtxNaauVE4gqKZezZjL3Og=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XWRlAnJdmNy5Juh5tSypBwA4DysAY1M9pN5kxMVTeau33LeqhU4unFga2Iw245l+RxOJLFtoub2Eg9WbyiyJeIK9HywQ4UnFjSsU+kbAnkAJ/ali2SonNeCcZziOHPdoZMgLvNwTBsCvW/yI3oqmdvuDxYj5nWmefIUn1DbhyL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=H0xJbGJN; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="H0xJbGJN"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1782895855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qJ6PHioXxe9MckPnxCVLI1HlLbB1LRdSjlItXSPeIxM=;
	b=H0xJbGJNbZRE0j3/wlg+RLAlsdx/aBW6mbvzwjiGRZiurTuLSA7+EyPxykdZHEnMisZzSp
	NsjHkWaDCiKfqgxlNGJWvddwKb04o3SbItOjWPuYSVVpC7112K7vvDDO9iA93N7xdIynk/
	X7628YR4UMqGtqEbz8rULT/qN6VPcgk=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>, Johannes
 Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5 3/3] replay: offer an option to linearize the commit
 topology
In-Reply-To: <xmqq5x358byf.fsf@gitster.g>
References: <20260626-toon-git-replay-drop-merges-v5-0-5e120738b9d0@iotcl.com>
 <20260626-toon-git-replay-drop-merges-v5-3-5e120738b9d0@iotcl.com>
 <xmqq5x358byf.fsf@gitster.g>
Date: Wed, 01 Jul 2026 10:50:41 +0200
Message-ID: <874iij3xge.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> Toon Claes <toon@iotcl.com> writes:
>
>>  Documentation/git-replay.adoc |  8 ++++-
>>  builtin/replay.c              |  6 +++-
>>  replay.c                      | 50 ++++++++++++++++----------
>>  replay.h                      |  5 +++
>>  t/t3650-replay-basics.sh      | 84 ++++++++++++++++++++++++++++++++++++++++++-
>>  5 files changed, 132 insertions(+), 21 deletions(-)
>
> "replay --linearize" behaves differently from the flattening rebase
> in a case where X and Y that forked from A are merged at Z, and we
> ask to flatten the history leading to Z, doesn't it?
>
>      A----X
>       \    \
>        Y----Z (tip)
>
> A typical flattening rebase would rewrite X to X', Y to Y', while
> dropping Z, and would leave us a flattened history, like
>
>      A---X'---Y' (updated tip, the order of X' and Y' may be swapped)
>
> I may be misreading the logic, but doesn't "replay --linearize"
> instead produce
>
>      A----X' (dangling)
>       \ 
>        Y' (tip -- Z is dropped and gets mapped)
>
> and leave X' dangling (or Y'; the point is that only one of them
> will survive), never incorporating it in the resulting history?

You bring up a good point here, and it is very similar to what Dscho
brought up[1].

When I started working on v5, I realized multiple tips can be passed to
git-replay(1) and the code in v1-v4 would replay all commits into a
single linear history. I assumed that's not what we want.

In my mind, replaying unrelated histories with --onto and --linearize
should remain unrelated. Also assuming the --linearize option would only
linearize merge commits.

Looking at less obvious situations, like your example above, things
aren't really that simple. And I agree the new Y' tip is not correct and
X' shouldn't be dangling.

On the other hand though, if there was a branch pointing to X, we still
need a piece of history that has X', but doesn't have Y'. In your
flattened history X' isn't a descendant of Y', but the order may be
swapped and we would need to create something like:

      A----X' (other tip)
       \
        Y'----X' (tip)

That's quite complex trying to achieve something like that in code. In
short, --linearize will change the topology of the (merge) commits, and
we have to do this in a predictable way. Thus I'm currently leaning
toward bringing v1-v4 behavior back and linearize all commits in to a
single line when using --linearize. Meaning:

        B----C (other tip)
       /
      A----X
       \
        Y----Z (tip)

  $ git replay --onto X --linearize Z C

Would result into:

      A----X----Y----Z----B----C
                               ^ (new other tip)
                     ^ (new tip)

This might not always be the expected behavior, especially when
replaying multiple branches at once. But to those I would suggest: don't
replay multiple branches at once.

But then again: Given the above example, you want to replay Z and C on
top of eachother, but don't want to rewrite the "(other tip)"? They have
I think two options:

  $ git replay --onto X --linearize --ref=tip Z C

By passing --ref we could tell git-replay(1) to only update that ref.
(sidenote: --ref currently cannot be combined with multiple revision
ranges, because that normally produces multiple tips and it would be
ambiguous which one --ref should point at. But --linearize collapses
everything into a single tip, so that ambiguity goes away; maybe we
should loosen the constraint in that case.)

Or:

  $ git replay --onto X --linearize Z^{commit} C

By peeling Z to a commit, git-replay(1) doesn't see it as a ref to
update.

Anyhow, a lot to unpack and I'll try to do my best in the next version
to cover that in the commit message, docs and test cases.

[1]: <f8b520d1-edeb-9e45-c503-025c8b5833c3@gmx.de>

>> +		if (commit->parents && commit->parents->next) {
>> +			if (!opts->linearize)
>> +				die(_("replaying merge commits is not supported yet!"));
>> +			/*
>> +			 * Drop the merge commit: do not pick it, leave
>> +			 * `last_commit` unchanged, and fall through to the
>> +			 * rest of the loop. As a result:
>> +			 * - the merge commit is mapped to `last_commit` in
>> +			 *   `replayed_commits`, this will become the parent for
>> +			 *   the child commits.
>> +			 * - refs previously pointing to the merge commit are
>> +			 *   rewritten to point to the previous non-merge commit.
>> +			 */
>> +		} else {
>> +			/*
>> +			 * pick_regular_commit() looks up the parent of `commit` in
>> +			 * `replayed_commits` to determine the ancestor to replay onto.
>> +			 * The `default_base` parameter is used when no ancestor is found,
>> +			 * which happens for the first commit in the revision range.
>> +			 * When reverting, commits are replayed in reverse order, so the
>> +			 * lookup never succeeds, and we need to pass `last_commit`.
>> +			 */
>> +			struct commit *base = onto;
>> +			if (mode == REPLAY_MODE_REVERT)
>> +				base = last_commit;
>> +
>> +			last_commit = pick_regular_commit(revs->repo, commit, base,
>> +							  replayed_commits,
>> +							  &merge_opt, &result,
>> +							  mode, opts->empty);
>> +		}
>> +
>>  		if (!last_commit)
>>  			break;
>
> Immediately after this hunk beyond the post-context are these lines.
>
> 		/* Record commit -> last_commit mapping */
> 		put_mapped_commit(replayed_commits, commit, last_commit);
>
> Let's imagine X gets processed first. X (and other commits on its
> branch) gets replayed, last_commit is set to X' (which is the
> rewritten X).  replayed_commits mapping holds X->X' mapping.
>
> Then let's imagine the history leading to Y is replayed next.
> last_commit becomes Y', and Y->Y' mapping is stored in
> replayed_commits.
>
> Finally, we see Z.  We are going to _drop_ it.  last_commit is left
> unchanged, pointing at Y'.  Then last_commit (i.e., Y') is used as
> the merge commit Z maps to (i.e., correctly dropping Z).
>
> Any descendants of Z, if any, will be grafted as descendants of Y'.
> If X did not have any descendants other than Z in the rewritten part
> of the history, then X' (and commits leading to it) would be lost,
> no?

I appreciate you're breaking down the code here.

> This "loss of the other branch" may be an inherent characteristic of
> this feature (i.e., I do not think it is necessarily a bug, and it
> may even be that the "bug" is in the way I am reading the patch),
> but then I wonder if the user may want to have control over which
> side branch should survive, perhaps?  It would probably need to be
> documented, and a test or two to cast this behaviour in stone.
>
>> diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
>> index 3353bc4a4d..34c038eab9 100755
>> --- a/t/t3650-replay-basics.sh
>> +++ b/t/t3650-replay-basics.sh
>> @@ -52,8 +52,12 @@ test_expect_success 'setup' '
>
> The pre-context here has
>
> 	git switch --detach topic4 &&
> 	test_commit N &&
> 	test_commit O &&
> 	git switch -c topic-with-merge topic4 &&
>
>>  	test_merge P O --no-ff &&
>>  	git switch main &&
>
> The above does prepare topic-with-merge branch, but ...
>
>> +test_expect_success 'replay to rebase merge commit with --linearize' '
>> +	git replay --ref-action=print --linearize \
>> +		--onto main I..topic-with-merge >result &&
>
> ... this does not really exersize linearizing replay in a typical
> mergy history.  P merges O with --no-ff because otherwise there
> won't be a merge, since O is a descendant of the commit "test_merge
> P O" runs on (i.e., topic4 == topic-with-merge).
>
>     topic4 --- N --- O
>           \           \
>            .-----------P
>
> So, as long as O is replayed later than the parent of N (which is
> true), O' will be the surviving tip (corresponds to Y' that the
> dropped Z was mapped to in the earlier example), and nothing gets
> orphaned, I think.
>
> Perhaps a test to try a real merge may look something like this.
>
> diff --git c/t/t3650-replay-basics.sh w/t/t3650-replay-basics.sh
> index 34c038eab9..bb737f729a 100755
> --- c/t/t3650-replay-basics.sh
> +++ w/t/t3650-replay-basics.sh
> @@ -647,4 +647,37 @@ test_expect_success 'replay with --linearize to rebase multiple divergent branch
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'replay with --linearize of a divergent merge drops one branch' '
> +	git switch -c topic-divergent-base main &&
> +	test_commit base &&
> +	# Fork 1: base -> X
> +	git switch -c topic-divergent-x &&
> +	test_commit X &&
> +	# Fork 2: base -> Y
> +	git switch topic-divergent-base &&
> +	git switch -c topic-divergent-y &&
> +	test_commit Y &&
> +	# Merge them at Z
> +	git switch topic-divergent-x &&
> +	test_merge Z topic-divergent-y --no-ff &&
> +
> +	# History is now:
> +	#
> +	#       X - Z (topic-divergent-x)
> +	#      /   /
> +	#  base - Y
> +	#
> +
> +	git replay --ref-action=print --linearize \
> +		--onto main topic-divergent-base..topic-divergent-x >result &&
> +	test_line_count = 1 result &&
> +	tip=$(cut -f 3 -d " " result) &&
> +	# Get the commits replayed onto main
> +	git log --format=%s main..$tip >actual &&
> +	# We expect exactly one commit to be replayed (either X or Y)
> +	# because the other one is left dangling due to the merge being dropped.
> +	test_line_count = 1 actual &&
> +	test_grep "^[XY]$" actual
> +'
> +
>  test_done

Thank you for providing this test case.

-- 
Cheers,
Toon
