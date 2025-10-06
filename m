Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD422264AA
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 10:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759746066; cv=none; b=uOOTNItX3rOUHBVPSnxfcaQKgH9kEdbzkLDVtguRyRK/uMuIKWdrsw0O6XVxehZvdebLtid7Ny7DRC1DNVFECx3kFKeIYArHvn5ao5bDzk0E5tGfTGpWudfPf1AsOfdDXzTzVrvqV+MiKAUMY47GIyzq/v+TIrmPw459hksdNcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759746066; c=relaxed/simple;
	bh=emKcIayUPzDExMNmGiklSQojmDtYl00Nj2uzbCdzt6Q=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KNnGq8tL/Zf/a1UK5g5PEsppUFyr7QOGBUZi9WYQjB9UM9pVzPz7iJw3PkW2I27q37kjK0ljsekdTe4FxLq8EYokcqgJ/ZMpYk6mLj180gW8ku0qPLRhm09WC6RPx65te9LkOboXiV2W8UBERbCQUOvNvaDD6cIXHQEZh6BCgZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=FeHdleZd; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="FeHdleZd"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1759746059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kn/sPsfMw3SoY39R5uAhlvYlRhv3HZ1QlOYDSVOGHAU=;
	b=FeHdleZdRqW1538gEaBoasAWxfhZiv2SFNaPR+9+pM2OnPhnFQ6hcJ7x1KvJyzx06M2He0
	EZbXXhvHAoVBaUTQMw0z1l0SJ0w8CG0iqKNF1DocZZRYG4SfCW0v2oaVsHlRYmVTVMbkzZ
	VG2VvbwLiiqLTfhooqP09fHT6M8iGwQ=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 5/5] t8020: fix test failure due to indeterministic tag
 sorting
In-Reply-To: <20251002-pks-gitlab-ci-windows-improvements-v1-5-6a8b6b45d728@pks.im>
References: <20251002-pks-gitlab-ci-windows-improvements-v1-0-6a8b6b45d728@pks.im>
 <20251002-pks-gitlab-ci-windows-improvements-v1-5-6a8b6b45d728@pks.im>
Date: Mon, 06 Oct 2025 12:20:37 +0200
Message-ID: <874iscbabu.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> In e6c06e87a2 (last-modified: fix bug when some paths remain unhandled,
> 2025-09-18), we have fixed a bug where under certain circumstances,
> git-last-modified(1) would BUG because there's still some unhandled
> paths. The fix claims that the root cause here is criss-cross merges,
> and it adds a test case that seemingly exercises this.
>
> Curiously, this test case fails on some systems because the actual
> output does not match our expectations:
>
>     diff --git a/expect b/actual
>     index 5271607..bdc620e 100644
>     --- a/expect
>     --- b/actual
>     @@ -1,3 +1,3 @@
>      km3 a
>     -k2 k
>     +km2 k
>      1 file
>     error: last command exited with $?=1
>     not ok 15 - last-modified with subdir and criss-cross merge
>
> The output we see is git-name-rev(1) with `--annotate-stdin`. What it
> does is to take the output of git-last-modified(1), which contains
> object IDs of the blamed commits, and convert those object IDs into the
> names of the corresponding tags. Interestingly, we indeed have both "k2"
> and "km2" as tags, and even more interestingly both of these tags point
> to the same commit. So the output we get isn't _wrong_, as the tags are
> ambiguous.

Ahha, I see...

> But why do both of these tags point to the same commit? "km2" really is
> supposed to be a merge, but due to the way the test is constructed the
> merge turns into a fast-forward merge.

Ohw :o

> Which means that the resulting
> does not even contain a criss-cross merge in the first place! A quick
> test though shows that the test indeed triggers the bug, so the initial
> analysis that the behaviour is triggered by such merges must be wrong.

I've tried various things, this felt like the simplest case to
reproduce. Apparantly not realizing it was wrong.

> And it is: seemingly, the issue isn't with criss-cross merges, but
> rather with a graph where different files in the same directory were
> modified on both sides of a merge.

Well yes, it felt like it was something like this. But like said, it
_seemed_ I needed a criss-cross merge.

> Refactor the test so that we explicitly test for this specific situation
> instead of mentioning the "criss-cross merge" red herring.

Well, thanks for this cleanup!

> As the test
> is very specific to the actual layout of the repository we also adapt it
> to use its own standalone repository.

I should have done that in the first place. Trying to shoe horn this
test in the existing repo might have guided me to take incorrect
conclusions.
> Note that this requires us to drop the `test_when_finished` call in
> `check_last_modified` because it's not supported to execute that
> function in a subshell.

This is not an issue because these files are always overwritten before
comparing, so this the `rm` wasn't strictly needed.

> This refactoring also fixes the original tag ambiguity that caused us to
> fail on some platforms.

Awesome! 

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t8020-last-modified.sh | 34 +++++++++++++++++++---------------
>  1 file changed, 19 insertions(+), 15 deletions(-)
>
> diff --git a/t/t8020-last-modified.sh b/t/t8020-last-modified.sh
> index e13aad1439..61f00bc15c 100755
> --- a/t/t8020-last-modified.sh
> +++ b/t/t8020-last-modified.sh
> @@ -33,7 +33,6 @@ check_last_modified() {
>  	done &&
>  
>  	cat >expect &&
> -	test_when_finished "rm -f tmp.*" &&
>  	git ${indir:+-C "$indir"} last-modified "$@" >tmp.1 &&
>  	git name-rev --annotate-stdin --name-only --tags \
>  		<tmp.1 >tmp.2 &&
> @@ -128,20 +127,25 @@ test_expect_success 'only last-modified files in the current tree' '
>  	EOF
>  '
>  
> -test_expect_success 'last-modified with subdir and criss-cross merge' '
> -	git checkout -b branch-k1 1 &&
> -	mkdir -p a k &&
> -	test_commit k1 a/file2 &&
> -	git checkout -b branch-k2 &&
> -	test_commit k2 k/file2 &&
> -	git checkout branch-k1 &&
> -	test_merge km2 branch-k2 &&
> -	test_merge km3 3 &&
> -	check_last_modified <<-\EOF
> -	km3 a
> -	k2 k
> -	1 file
> -	EOF
> +test_expect_success 'subdirectory modified via merge' '
> +	test_when_finished rm -rf repo &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit base &&
> +		git switch --create left &&
> +		mkdir subdir &&
> +		test_commit left subdir/left &&
> +		git switch --create right base &&
> +		mkdir subdir &&
> +		test_commit right subdir/right &&
> +		git switch - &&
> +		test_merge merge right &&
> +		check_last_modified <<-\EOF
> +		merge subdir
> +		base base.t
> +		EOF
> +	)
>  '

Looks good to me.

-- 
Cheers,
Toon
