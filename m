Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77BBA34
	for <git@vger.kernel.org>; Thu, 23 May 2024 00:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716425019; cv=none; b=eB7aJs0Lc5Qq4QmdRc6AY0x0ScRgIT476AEjSn2y5AyTbwJTV0HWXucI4J9tldgU1dhs0CrtRHoHwQKwfoOSV2oEBjBCCA3Lorpc2iUH93NoaoJCthRySRwxEN0TrGMzTDILHaRlhvcT9tJlx8agvhOuQEFoViPGNNy/vqL8eBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716425019; c=relaxed/simple;
	bh=QbPx4BaZne04yXy+vIUUxtMnmFrS0GA+AVE6jqJhHLQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sINuChjKXVQE+xM9FcuAYg9/xmBOKwAq+HgouYjTxRbkA4LKcpG0ii2h/l3ddVEd/kpWZbhj82Y1KicTuAKyITCjdDvsBS2kG38jdn6FFSd5IdmPR0FsBO7ogaqCDubEmX0Or8HqpReJuBMrWzQW7MMveF74BtbqXpQF/YKPqFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kQiSGi1O; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kQiSGi1O"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5FD1237F4D;
	Wed, 22 May 2024 20:43:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=QbPx4BaZne04yXy+vIUUxtMnmFrS0GA+AVE6jq
	JhHLQ=; b=kQiSGi1OCpufs/ilwaWDQmOmAPbcGflwcLrIDS+fg54LQPcRdboZsn
	0rU1OCyFIPNC3jBJ+moL/F5l8ex7haOivBn2Uq162zBMhkSoQqRzYorL+N5RyHdD
	hGG9I3GN3YaDbmn17gvhJMhMV79rEis1F7qX1GLblT5fzchEPzwEI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4B45E37F4C;
	Wed, 22 May 2024 20:43:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0379337F4B;
	Wed, 22 May 2024 20:43:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Heghedus Razvan <heghedus.razvan@protonmail.com>
Subject: [PATCH v2] setup: fix bug with "includeIf.onbranch" when
 initializing dir
In-Reply-To: <cf182bb9ee7d4a7eb46e5dbf4f3ef5deb198d823.1716374321.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 22 May 2024 12:38:46 +0200")
References: <D1F5SJ52H4Z0.1NR7M8APRFTOB@protonmail.com>
	<cf182bb9ee7d4a7eb46e5dbf4f3ef5deb198d823.1716374321.git.ps@pks.im>
Date: Wed, 22 May 2024 17:43:32 -0700
Message-ID: <xmqqwmnlz7bf.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7BF428E8-189D-11EF-9E19-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

It was reported that git-init(1) can fail when initializing an existing
directory in case the config contains an "includeIf.onbranch:"
condition:

    $ mkdir repo
    $ git -c includeIf.onbranch:main.path=nonexistent init repo
    BUG: refs.c:2056: reference backend is unknown

The same error can also be triggered when re-initializing an already
existing repository.

The bug has been introduced in 173761e21b (setup: start tracking ref
storage format, 2023-12-29), which wired up the ref storage format. The
root cause is in `init_db()`, which tries to read the config before we
have initialized `the_repository` and most importantly its ref storage
format. We eventually end up calling `include_by_branch()` and execute
`refs_resolve_ref_unsafe()`, but because we have not initialized the ref
storage format yet this will trigger the above bug.

Interestingly, `include_by_branch()` has a mechanism that will only
cause us to resolve the ref when `the_repository->gitdir` is set. This
is also the reason why this only happens when we initialize an already
existing directory or repository: `gitdir` is set in those cases, but
not when creating a new directory.

Now there are two ways to address the issue:

  - We can adapt `include_by_branch()` to also make the code conditional
    on whether `the_repository->ref_storage_format` is set.

  - We can shift around code such that we initialize the repository
    format before we read the config.

While the first approach would be safe, it may also cause us to paper
over issues where a ref store should have been set up. In our case for
example, it may be reasonable to expect that re-initializing the repo
will cause the "onbranch:" condition to trigger, but we would not do
that if the ref storage format was not set up yet. This also used to
work before the above commit that introduced this bug.

Rearrange the code such that we set up the repository format before
reading the config. This fixes the bug and ensures that "onbranch:"
conditions can trigger.

Reported-by: Heghedus Razvan <heghedus.razvan@protonmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
Tested-by: Heghedus Razvan <heghedus.razvan@protonmail.com>
[jc: backported to v2.44.0 codebase]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * So this is how it should look like if we later wanted to merge
   down the fix to the 2.44 maintenance track.

 setup.c         |  26 +++++++------
 t/t0001-init.sh | 101 ++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 108 insertions(+), 19 deletions(-)

diff --git a/setup.c b/setup.c
index b69b1cbc2a..c6fffa0164 100644
--- a/setup.c
+++ b/setup.c
@@ -2196,13 +2196,6 @@ int init_db(const char *git_dir, const char *real_git_dir,
 	}
 	startup_info->have_repository = 1;
 
-	/* Ensure `core.hidedotfiles` is processed */
-	git_config(platform_core_config, NULL);
-
-	safe_create_dir(git_dir, 0);
-
-	prev_bare_repository = is_bare_repository();
-
 	/* Check to see if the repository version is right.
 	 * Note that a newly created repository does not have
 	 * config file, so this will not fail.  What we are catching
@@ -2213,10 +2206,6 @@ int init_db(const char *git_dir, const char *real_git_dir,
 	validate_hash_algorithm(&repo_fmt, hash);
 	validate_ref_storage_format(&repo_fmt, ref_storage_format);
 
-	reinit = create_default_files(template_dir, original_git_dir,
-				      &repo_fmt, prev_bare_repository,
-				      init_shared_repository);
-
 	/*
 	 * Now that we have set up both the hash algorithm and the ref storage
 	 * format we can update the repository's settings accordingly.
@@ -2224,6 +2213,21 @@ int init_db(const char *git_dir, const char *real_git_dir,
 	repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
 	repo_set_ref_storage_format(the_repository, repo_fmt.ref_storage_format);
 
+	/*
+	 * Ensure `core.hidedotfiles` is processed. This must happen after we
+	 * have set up the repository format such that we can evaluate
+	 * includeIf conditions correctly in the case of re-initialization.
+	 */
+	git_config(platform_core_config, NULL);
+
+	safe_create_dir(git_dir, 0);
+
+	prev_bare_repository = is_bare_repository();
+
+	reinit = create_default_files(template_dir, original_git_dir,
+				      &repo_fmt, prev_bare_repository,
+				      init_shared_repository);
+
 	if (!(flags & INIT_DB_SKIP_REFDB))
 		create_reference_database(repo_fmt.ref_storage_format,
 					  initial_branch, flags & INIT_DB_QUIET);
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index b131d665db..319ed81631 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -584,14 +584,39 @@ test_expect_success 'init with --ref-format=files' '
 	test_cmp expect actual
 '
 
-test_expect_success 're-init with same format' '
-	test_when_finished "rm -rf refformat" &&
-	git init --ref-format=files refformat &&
-	git init --ref-format=files refformat &&
-	echo files >expect &&
-	git -C refformat rev-parse --show-ref-format >actual &&
-	test_cmp expect actual
-'
+backends="files"
+for from_format in $backends
+do
+	test_expect_success "re-init with same format ($from_format)" '
+		test_when_finished "rm -rf refformat" &&
+		git init --ref-format=$from_format refformat &&
+		git init --ref-format=$from_format refformat &&
+		echo $from_format >expect &&
+		git -C refformat rev-parse --show-ref-format >actual &&
+		test_cmp expect actual
+	'
+
+	for to_format in $backends
+	do
+		if test "$from_format" = "$to_format"
+		then
+			continue
+		fi
+
+		test_expect_success "re-init with different format fails ($from_format -> $to_format)" '
+			test_when_finished "rm -rf refformat" &&
+			git init --ref-format=$from_format refformat &&
+			cat >expect <<-EOF &&
+			fatal: attempt to reinitialize repository with different reference storage format
+			EOF
+			test_must_fail git init --ref-format=$to_format refformat 2>err &&
+			test_cmp expect err &&
+			echo $from_format >expect &&
+			git -C refformat rev-parse --show-ref-format >actual &&
+			test_cmp expect actual
+		'
+	done
+done
 
 test_expect_success 'init with --ref-format=garbage' '
 	test_when_finished "rm -rf refformat" &&
@@ -678,4 +703,64 @@ test_expect_success 'branch -m with the initial branch' '
 	test_cmp expect actual
 '
 
+test_expect_success 'init with includeIf.onbranch condition' '
+	test_when_finished "rm -rf repo" &&
+	git -c includeIf.onbranch:main.path=nonexistent init repo &&
+	echo $GIT_DEFAULT_REF_FORMAT >expect &&
+	git -C repo rev-parse --show-ref-format >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'init with includeIf.onbranch condition with existing directory' '
+	test_when_finished "rm -rf repo" &&
+	mkdir repo &&
+	git -c includeIf.onbranch:nonexistent.path=/does/not/exist init repo &&
+	echo $GIT_DEFAULT_REF_FORMAT >expect &&
+	git -C repo rev-parse --show-ref-format >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 're-init with includeIf.onbranch condition' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	git -c includeIf.onbranch:nonexistent.path=/does/not/exist init repo &&
+	echo $GIT_DEFAULT_REF_FORMAT >expect &&
+	git -C repo rev-parse --show-ref-format >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 're-init with includeIf.onbranch condition' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	git -c includeIf.onbranch:nonexistent.path=/does/not/exist init repo &&
+	echo $GIT_DEFAULT_REF_FORMAT >expect &&
+	git -C repo rev-parse --show-ref-format >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 're-init skips non-matching includeIf.onbranch' '
+	test_when_finished "rm -rf repo config" &&
+	cat >config <<-EOF &&
+	[
+	garbage
+	EOF
+	git init repo &&
+	git -c includeIf.onbranch:nonexistent.path="$(test-tool path-utils absolute_path config)" init repo
+'
+
+test_expect_success 're-init reads matching includeIf.onbranch' '
+	test_when_finished "rm -rf repo config" &&
+	cat >config <<-EOF &&
+	[
+	garbage
+	EOF
+	path="$(test-tool path-utils absolute_path config)" &&
+	git init --initial-branch=branch repo &&
+	cat >expect <<-EOF &&
+	fatal: bad config line 1 in file $path
+	EOF
+	test_must_fail git -c includeIf.onbranch:branch.path="$path" init repo 2>err &&
+	test_cmp expect err
+'
+
 test_done
-- 
2.45.1-216-g4365c6fcf9

