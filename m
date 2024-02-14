Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775401DDC1
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 22:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707950890; cv=none; b=iGhKm+TpNbmbCrSZ3cNL7xf82Ukuy5g0BuHtCDOokVGX5nnAQkG1Gl8oEAuiPAxVFrAUzxS5aa6bFpuAZM82t/V3OH6vpJD+sli/LE/cc9tFIF5A/bh+cl+Iz2H+OQEcB6b1AdRqE0KMEen/k0Vo1XMYsWn6iWc5loBp69QDHF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707950890; c=relaxed/simple;
	bh=B02E5aJZdlfUxFaFH5XaknHvBZyWZP8Syg/QlGTGbB0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z8cgdZMKLn+jYVUcQWvN8H3ZhdNWs1j+wWCEUPs26U6eEvOZyJxdiVmNckplsB1WnWraqq0O9vSWFUh9Nc4bwgRJoFS1HoEyLsIk1eCOEqVn8i4G3QkdxaYjObVnYgnOKUojJi/Ai2okxzwP2lYYMK6/GGy/iMx+xBlaYnicopg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=WtPt62RZ; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WtPt62RZ"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B6F81D497A;
	Wed, 14 Feb 2024 17:45:40 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=B02E5aJZdlfUxFaFH5XaknHvBZyWZP8Syg/QlG
	TGbB0=; b=WtPt62RZ8AlzZUeXBdGDlLjebRDTGLP+xvF4mij1+6Efuvz2q3O9Ht
	CAHah6c6mYytWQS4d0dhSkIUuRaw6dDjxQsdxnzv04f3qv9V8bdJkD/oMa+/4flY
	tSxlWWzfpjnMUAA9xAtIj/vpfiUfXGq/w+rgYVwhvYLYt6CFTI48s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 141DC1D4978;
	Wed, 14 Feb 2024 17:45:40 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 79E4C1D4977;
	Wed, 14 Feb 2024 17:45:39 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/7] t: move tests exercising the "files" backend
In-Reply-To: <2eca90234f60b5f48e444e8be212bd70b9ebf924.1707463221.git.ps@pks.im>
	(Patrick Steinhardt's message of "Fri, 9 Feb 2024 08:23:09 +0100")
References: <cover.1707463221.git.ps@pks.im>
	<2eca90234f60b5f48e444e8be212bd70b9ebf924.1707463221.git.ps@pks.im>
Date: Wed, 14 Feb 2024 14:45:38 -0800
Message-ID: <xmqqr0heu0kt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C6BB18D8-CB8A-11EE-8079-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> We still have a bunch of tests scattered across our test suites that
> exercise on-disk files of the "files" backend directly:
>
>   - t1301 exercises permissions of reflog files when the config
>     "core.sharedRepository" is set.
>
>   - t1400 exercises whether empty directories in the ref store are
>     handled correctly.
>
>   - t3200 exercises what happens when there are symlinks in the ref
>     store.
>
>   - t3400 also exercises what happens when ".git/logs" is a symlink.
>
> All of these are inherently low-level tests specific to the "files"
> backend. Move them into "t0600-reffiles-backend.sh" to reflect this.

Makes sense, and they look like straight code movements.

> diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
> index e6a5f1868f..485481d6b4 100755
> --- a/t/t0600-reffiles-backend.sh
> +++ b/t/t0600-reffiles-backend.sh
> @@ -381,4 +381,95 @@ test_expect_success 'log diagnoses bogus HEAD symref' '
>  	test_grep broken stderr
>  '

These two are from t1400.

> +test_expect_success 'empty directory removal' '
> +	git branch d1/d2/r1 HEAD &&
> +	git branch d1/r2 HEAD &&
> +	test_path_is_file .git/refs/heads/d1/d2/r1 &&
> +	test_path_is_file .git/logs/refs/heads/d1/d2/r1 &&
> +	git branch -d d1/d2/r1 &&
> +	test_must_fail git show-ref --verify -q refs/heads/d1/d2 &&
> +	test_must_fail git show-ref --verify -q logs/refs/heads/d1/d2 &&
> +	test_path_is_file .git/refs/heads/d1/r2 &&
> +	test_path_is_file .git/logs/refs/heads/d1/r2
> +'
> +
> +test_expect_success 'symref empty directory removal' '
> +	git branch e1/e2/r1 HEAD &&
> +	git branch e1/r2 HEAD &&
> +	git checkout e1/e2/r1 &&
> +	test_when_finished "git checkout main" &&
> +	test_path_is_file .git/refs/heads/e1/e2/r1 &&
> +	test_path_is_file .git/logs/refs/heads/e1/e2/r1 &&
> +	git update-ref -d HEAD &&
> +	test_must_fail git show-ref --verify -q refs/heads/e1/e2 &&
> +	test_must_fail git show-ref --verify -q logs/refs/heads/e1/e2 &&
> +	test_path_is_file .git/refs/heads/e1/r2 &&
> +	test_path_is_file .git/logs/refs/heads/e1/r2 &&
> +	test_path_is_file .git/logs/HEAD
> +'

Luckily there aren't refs that were created at this point by earlier
tests that would contradict/block the creation of the new refs this
moved tests would want to create.

> +test_expect_success 'directory not created deleting packed ref' '
> +	git branch d1/d2/r1 HEAD &&
> +	git pack-refs --all &&
> +	test_path_is_missing .git/refs/heads/d1/d2 &&
> +	git update-ref -d refs/heads/d1/d2/r1 &&
> +	test_path_is_missing .git/refs/heads/d1/d2 &&
> +	test_path_is_missing .git/refs/heads/d1
> +'

And this is from the same t1400 but appears much later in the file.
Curiously, this tries to create d1/d2/r1 that an earlier test
already created, and this one passes because the branch gets removed
in the other test that also created the branch.  Tricky but not a
fault of this patch.

> +test_expect_success SYMLINKS 'git branch -m u v should fail when the reflog for u is a symlink' '
> +	git branch --create-reflog u &&
> +	mv .git/logs/refs/heads/u real-u &&
> +	ln -s real-u .git/logs/refs/heads/u &&
> +	test_must_fail git branch -m u v
> +'

This was migrated from t3200 and has no interaction with the new
context of t0600 as branch 'u' has never been used.  I notice that
this test is buggy since its inception at 16c2bfbb (rename_ref: use
lstat(2) when testing for symlink, 2006-11-29) in that we move the
log for branch 'u' up and then make the log for branch 'u' into a
dangling symlink, so it probably failed for a wrong reason even
before 16c2bfbb updated stat() to lstat().  Anyway, the current code
will see that logs/refs/heads/u is a symbolic link and fails,
regardless of what the link points at, so we are OK.  In any case,
not a fault of this patch.

> +test_expect_success SYMLINKS 'git branch -m with symlinked .git/refs' '
> +	test_when_finished "rm -rf subdir" &&
> +	git init --bare subdir &&
> +
> +	rm -rfv subdir/refs subdir/objects subdir/packed-refs &&
> +	ln -s ../.git/refs subdir/refs &&
> +	ln -s ../.git/objects subdir/objects &&
> +	ln -s ../.git/packed-refs subdir/packed-refs &&
> +
> +	git -C subdir rev-parse --absolute-git-dir >subdir.dir &&
> +	git rev-parse --absolute-git-dir >our.dir &&
> +	! test_cmp subdir.dir our.dir &&
> +
> +	git -C subdir log &&
> +	git -C subdir branch rename-src &&
> +	git rev-parse rename-src >expect &&
> +	git -C subdir branch -m rename-src rename-dest &&
> +	git rev-parse rename-dest >actual &&
> +	test_cmp expect actual &&
> +	git branch -D rename-dest
> +'

OK.  As long as it cleans after itself, I won't read deeply into it
and stop at making sure this came verbatim from t3200.

> +test_expect_success MINGW,SYMLINKS_WINDOWS 'rebase when .git/logs is a symlink' '
> +	git checkout main &&
> +	mv .git/logs actual_logs &&
> +	cmd //c "mklink /D .git\logs ..\actual_logs" &&
> +	git rebase -f HEAD^ &&
> +	test -L .git/logs &&
> +	rm .git/logs &&
> +	mv actual_logs .git/logs
> +'

As t0600 forces the default branch to be 'main', having this one
migrated from t3400 should be safe.

> +test_expect_success POSIXPERM 'git reflog expire honors core.sharedRepository' '
> +	umask 077 &&
> +	git config core.sharedRepository group &&
> +	git reflog expire --all &&
> +	actual="$(ls -l .git/logs/refs/heads/main)" &&
> +	case "$actual" in
> +	-rw-rw-*)
> +		: happy
> +		;;
> +	*)
> +		echo Ooops, .git/logs/refs/heads/main is not 066x [$actual]
> +		false
> +		;;
> +	esac
> +'

And this is from t1301, another verbatim copy.


>  test_done
> diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
> index 8e2c01e760..b1eb5c01b8 100755
> --- a/t/t1301-shared-repo.sh
> +++ b/t/t1301-shared-repo.sh
> @@ -137,22 +137,6 @@ test_expect_success POSIXPERM 'info/refs respects umask in unshared repo' '
>  	test_cmp expect actual
>  '
>  
> -test_expect_success REFFILES,POSIXPERM 'git reflog expire honors core.sharedRepository' '
> -	umask 077 &&
> -	git config core.sharedRepository group &&
> -	git reflog expire --all &&
> -	actual="$(ls -l .git/logs/refs/heads/main)" &&
> -	case "$actual" in
> -	-rw-rw-*)
> -		: happy
> -		;;
> -	*)
> -		echo Ooops, .git/logs/refs/heads/main is not 066x [$actual]
> -		false
> -		;;
> -	esac
> -'
> -

The rest of t1301 does not appear to depend on the reflog being
expired, so this move should be safe.

>  test_expect_success POSIXPERM 'forced modes' '
>  	test_when_finished "rm -rf new" &&
>  	mkdir -p templates/hooks &&
> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index f18843bf7a..3294b7ce08 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -288,33 +288,6 @@ test_expect_success "set $m (logged by touch)" '
>  	test $A = $(git show-ref -s --verify $m)
>  '
>  
> -test_expect_success REFFILES 'empty directory removal' '
> -	git branch d1/d2/r1 HEAD &&
> -	git branch d1/r2 HEAD &&
> -	test_path_is_file .git/refs/heads/d1/d2/r1 &&
> -	test_path_is_file .git/logs/refs/heads/d1/d2/r1 &&
> -	git branch -d d1/d2/r1 &&
> -	test_must_fail git show-ref --verify -q refs/heads/d1/d2 &&
> -	test_must_fail git show-ref --verify -q logs/refs/heads/d1/d2 &&
> -	test_path_is_file .git/refs/heads/d1/r2 &&
> -	test_path_is_file .git/logs/refs/heads/d1/r2
> -'
> -
> -test_expect_success REFFILES 'symref empty directory removal' '
> -	git branch e1/e2/r1 HEAD &&
> -	git branch e1/r2 HEAD &&
> -	git checkout e1/e2/r1 &&
> -	test_when_finished "git checkout main" &&
> -	test_path_is_file .git/refs/heads/e1/e2/r1 &&
> -	test_path_is_file .git/logs/refs/heads/e1/e2/r1 &&
> -	git update-ref -d HEAD &&
> -	test_must_fail git show-ref --verify -q refs/heads/e1/e2 &&
> -	test_must_fail git show-ref --verify -q logs/refs/heads/e1/e2 &&
> -	test_path_is_file .git/refs/heads/e1/r2 &&
> -	test_path_is_file .git/logs/refs/heads/e1/r2 &&
> -	test_path_is_file .git/logs/HEAD
> -'
> -
>  cat >expect <<EOF
>  $Z $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	Initial Creation
>  $A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150260 +0000	Switch
> @@ -1668,13 +1641,4 @@ test_expect_success PIPE 'transaction flushes status updates' '
>  	test_cmp expected actual
>  '
>  
> -test_expect_success REFFILES 'directory not created deleting packed ref' '
> -	git branch d1/d2/r1 HEAD &&
> -	git pack-refs --all &&
> -	test_path_is_missing .git/refs/heads/d1/d2 &&
> -	git update-ref -d refs/heads/d1/d2/r1 &&
> -	test_path_is_missing .git/refs/heads/d1/d2 &&
> -	test_path_is_missing .git/refs/heads/d1
> -'

I've covered how these removals should be safe for the remaining
tests in this file already.  Good.

>  test_done
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index de7d3014e4..e36f4d15f2 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -836,35 +836,6 @@ test_expect_success 'renaming a symref is not allowed' '
>  	test_ref_missing refs/heads/new-topic
>  '
>  
> -test_expect_success SYMLINKS,REFFILES 'git branch -m u v should fail when the reflog for u is a symlink' '
> -	git branch --create-reflog u &&
> -	mv .git/logs/refs/heads/u real-u &&
> -	ln -s real-u .git/logs/refs/heads/u &&
> -	test_must_fail git branch -m u v
> -'
> -
> -test_expect_success SYMLINKS,REFFILES 'git branch -m with symlinked .git/refs' '
> -	test_when_finished "rm -rf subdir" &&
> -	git init --bare subdir &&
> -
> -	rm -rfv subdir/refs subdir/objects subdir/packed-refs &&
> -	ln -s ../.git/refs subdir/refs &&
> -	ln -s ../.git/objects subdir/objects &&
> -	ln -s ../.git/packed-refs subdir/packed-refs &&
> -
> -	git -C subdir rev-parse --absolute-git-dir >subdir.dir &&
> -	git rev-parse --absolute-git-dir >our.dir &&
> -	! test_cmp subdir.dir our.dir &&
> -
> -	git -C subdir log &&
> -	git -C subdir branch rename-src &&
> -	git rev-parse rename-src >expect &&
> -	git -C subdir branch -m rename-src rename-dest &&
> -	git rev-parse rename-dest >actual &&
> -	test_cmp expect actual &&
> -	git branch -D rename-dest
> -'

Likewise.

> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> index 57f1392926..e1c8c5f701 100755
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -424,16 +424,6 @@ test_expect_success 'refuse to switch to branch checked out elsewhere' '
>  	test_grep "already used by worktree at" err
>  '
>  
> -test_expect_success REFFILES,MINGW,SYMLINKS_WINDOWS 'rebase when .git/logs is a symlink' '
> -	git checkout main &&
> -	mv .git/logs actual_logs &&
> -	cmd //c "mklink /D .git\logs ..\actual_logs" &&
> -	git rebase -f HEAD^ &&
> -	test -L .git/logs &&
> -	rm .git/logs &&
> -	mv actual_logs .git/logs
> -'
> -
>  test_expect_success 'rebase when inside worktree subdirectory' '
>  	git init main-wt &&
>  	(

Looking good.

Thanks.
