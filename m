Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339A71FBCA1
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 19:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755631570; cv=none; b=aJ97EC79+Uowu87Tjs+4b+0LnBp51B1gHTzsjtYJzNFxLR78lLjMqe2zHIO8+WBCqICsvxXe2NGCjWRzVE6hLg4BNIiGzqPIAL5wPD0Ys87+/z+G4Nkzh/jSPBKsqWp87/9/CBoCgKVb+RPHhuJDxgdwLpz6iMlbG8mqpXjwgPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755631570; c=relaxed/simple;
	bh=FQ5WKJ5i+vmIVlz6J1J9lA+uYLrwG3h3Hiem0ndFXr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ehP6GdV37ZoK5wsPgzRLgoZnPAxGb0b80lMrDpNQpvaslGsrM7osbLmk+neYw5R7oCdO3nc0VevBuE3+h8T0ukN5W1Xru2O+QiMXgmceDPTovzUi2r0n4SXD4c4xoujCeldu7gLJpJ9Lk/a9eegE4feXNNq3EdKrRezSl8/3sdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Z1x12XJO; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Z1x12XJO"
Received: (qmail 31194 invoked by uid 109); 19 Aug 2025 19:26:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=FQ5WKJ5i+vmIVlz6J1J9lA+uYLrwG3h3Hiem0ndFXr0=; b=Z1x12XJOEAkvTEgZ1aT9GLzIsbvS+l70U8cYEPPe7QDTeTanaYqs4gnaTwv0/pVC2TYad2GlShT6c7wCvqHGZrM91slpnhWKJ3vuMlfmfsepE/HQtSxiqeqJlBtdgwmDumOqdOrAXBXrfj/QGgRZbdmUCumVWxhdFsVi3qHUunVb29dBuCuA8N+Kooqt2U/xwn4bTd5lkxnIDYJUfjD9epyR7BnAgyr+8GAFjnHMruMArM6QLvi1zdfgSxLZfBsmRN7Hb0j/waqf6FItpaaTboTNLVdVsBteEioT4DbbBr0N2nZkKbv9Fl4iST63ywtPGQKPDkEzhthcYAbJ9af4Ug==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 19 Aug 2025 19:26:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 46428 invoked by uid 111); 19 Aug 2025 19:26:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 Aug 2025 15:26:06 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 19 Aug 2025 15:26:06 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 2/4] t5510: stop changing top-level working directory
Message-ID: <20250819192606.GB1059295@coredump.intra.peff.net>
References: <20250819192004.GA1058857@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250819192004.GA1058857@coredump.intra.peff.net>

Several tests in t5510 do a bare "cd subrepo", not in a subshell. This
changes the working directory for subsequent tests. As a result, almost
every test has to start with "cd $D" to go back to the top-level.

Our usual style is to do per-test environment changes like this in a
subshell, so that tests can assume they are starting at the top-level
$TRASH_DIRECTORY.

Let's switch to that style, which lets us drop all of that extra
path-handling.

Most cases can switch to using a subshell, but in a few spots we can
simplify by doing "git init foo && git -C foo ...". We do have to make
sure that we weren't intentionally touching the environment in any code
which was moved into a subshell (e.g., with a test_when_finished), but
that isn't the case for any of these tests.

All of the references to the $D variable can go away, replaced generally
with $PWD or $TRASH_DIRECTORY (if we use it inside a chdir'd subshell).
Note in one test, "fetch --prune prints the remotes url", we make sure
to use $(pwd) to get the Windows-style path on that platform (for the
other tests, the exact form doesn't matter).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5510-fetch.sh | 356 +++++++++++++++++++++--------------------------
 1 file changed, 161 insertions(+), 195 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 64fea9f4a5..93e309e213 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -14,8 +14,6 @@ then
 	test_done
 fi
 
-D=$(pwd)
-
 test_expect_success setup '
 	echo >file original &&
 	git add file &&
@@ -51,46 +49,50 @@ test_expect_success "clone and setup child repos" '
 '
 
 test_expect_success "fetch test" '
-	cd "$D" &&
 	echo >file updated by origin &&
 	git commit -a -m "updated by origin" &&
-	cd two &&
-	git fetch &&
-	git rev-parse --verify refs/heads/one &&
-	mine=$(git rev-parse refs/heads/one) &&
-	his=$(cd ../one && git rev-parse refs/heads/main) &&
-	test "z$mine" = "z$his"
+	(
+		cd two &&
+		git fetch &&
+		git rev-parse --verify refs/heads/one &&
+		mine=$(git rev-parse refs/heads/one) &&
+		his=$(cd ../one && git rev-parse refs/heads/main) &&
+		test "z$mine" = "z$his"
+	)
 '
 
 test_expect_success "fetch test for-merge" '
-	cd "$D" &&
-	cd three &&
-	git fetch &&
-	git rev-parse --verify refs/heads/two &&
-	git rev-parse --verify refs/heads/one &&
-	main_in_two=$(cd ../two && git rev-parse main) &&
-	one_in_two=$(cd ../two && git rev-parse one) &&
-	{
-		echo "$one_in_two	" &&
-		echo "$main_in_two	not-for-merge"
-	} >expected &&
-	cut -f -2 .git/FETCH_HEAD >actual &&
-	test_cmp expected actual'
+	(
+		cd three &&
+		git fetch &&
+		git rev-parse --verify refs/heads/two &&
+		git rev-parse --verify refs/heads/one &&
+		main_in_two=$(cd ../two && git rev-parse main) &&
+		one_in_two=$(cd ../two && git rev-parse one) &&
+		{
+			echo "$one_in_two	" &&
+			echo "$main_in_two	not-for-merge"
+		} >expected &&
+		cut -f -2 .git/FETCH_HEAD >actual &&
+		test_cmp expected actual
+	)
+'
 
 test_expect_success "fetch test remote HEAD" '
-	cd "$D" &&
-	cd two &&
-	git fetch &&
-	git rev-parse --verify refs/remotes/origin/HEAD &&
-	git rev-parse --verify refs/remotes/origin/main &&
-	head=$(git rev-parse refs/remotes/origin/HEAD) &&
-	branch=$(git rev-parse refs/remotes/origin/main) &&
-	test "z$head" = "z$branch"'
+	(
+		cd two &&
+		git fetch &&
+		git rev-parse --verify refs/remotes/origin/HEAD &&
+		git rev-parse --verify refs/remotes/origin/main &&
+		head=$(git rev-parse refs/remotes/origin/HEAD) &&
+		branch=$(git rev-parse refs/remotes/origin/main) &&
+		test "z$head" = "z$branch"
+	)
+'
 
 test_expect_success "fetch test remote HEAD in bare repository" '
 	test_when_finished rm -rf barerepo &&
 	(
-		cd "$D" &&
 		git init --bare barerepo &&
 		cd barerepo &&
 		git remote add upstream ../two &&
@@ -105,23 +107,24 @@ test_expect_success "fetch test remote HEAD in bare repository" '
 
 
 test_expect_success "fetch test remote HEAD change" '
-	cd "$D" &&
-	cd two &&
-	git switch -c other &&
-	git push -u origin other &&
-	git rev-parse --verify refs/remotes/origin/HEAD &&
-	git rev-parse --verify refs/remotes/origin/main &&
-	git rev-parse --verify refs/remotes/origin/other &&
-	git remote set-head origin other &&
-	git fetch &&
-	head=$(git rev-parse refs/remotes/origin/HEAD) &&
-	branch=$(git rev-parse refs/remotes/origin/other) &&
-	test "z$head" = "z$branch"'
+	(
+		cd two &&
+		git switch -c other &&
+		git push -u origin other &&
+		git rev-parse --verify refs/remotes/origin/HEAD &&
+		git rev-parse --verify refs/remotes/origin/main &&
+		git rev-parse --verify refs/remotes/origin/other &&
+		git remote set-head origin other &&
+		git fetch &&
+		head=$(git rev-parse refs/remotes/origin/HEAD) &&
+		branch=$(git rev-parse refs/remotes/origin/other) &&
+		test "z$head" = "z$branch"
+	)
+'
 
 test_expect_success "fetch test followRemoteHEAD never" '
-	test_when_finished "git -C \"$D/two\" config unset remote.origin.followRemoteHEAD" &&
+	test_when_finished "git -C two config unset remote.origin.followRemoteHEAD" &&
 	(
-		cd "$D" &&
 		cd two &&
 		git update-ref --no-deref -d refs/remotes/origin/HEAD &&
 		git config set remote.origin.followRemoteHEAD "never" &&
@@ -134,9 +137,8 @@ test_expect_success "fetch test followRemoteHEAD never" '
 '
 
 test_expect_success "fetch test followRemoteHEAD warn no change" '
-	test_when_finished "git -C \"$D/two\" config unset remote.origin.followRemoteHEAD" &&
+	test_when_finished "git -C two config unset remote.origin.followRemoteHEAD" &&
 	(
-		cd "$D" &&
 		cd two &&
 		git rev-parse --verify refs/remotes/origin/other &&
 		git remote set-head origin other &&
@@ -154,9 +156,8 @@ test_expect_success "fetch test followRemoteHEAD warn no change" '
 '
 
 test_expect_success "fetch test followRemoteHEAD warn create" '
-	test_when_finished "git -C \"$D/two\" config unset remote.origin.followRemoteHEAD" &&
+	test_when_finished "git -C two config unset remote.origin.followRemoteHEAD" &&
 	(
-		cd "$D" &&
 		cd two &&
 		git update-ref --no-deref -d refs/remotes/origin/HEAD &&
 		git config set remote.origin.followRemoteHEAD "warn" &&
@@ -170,9 +171,8 @@ test_expect_success "fetch test followRemoteHEAD warn create" '
 '
 
 test_expect_success "fetch test followRemoteHEAD warn detached" '
-	test_when_finished "git -C \"$D/two\" config unset remote.origin.followRemoteHEAD" &&
+	test_when_finished "git -C two config unset remote.origin.followRemoteHEAD" &&
 	(
-		cd "$D" &&
 		cd two &&
 		git update-ref --no-deref -d refs/remotes/origin/HEAD &&
 		git update-ref refs/remotes/origin/HEAD HEAD &&
@@ -187,9 +187,8 @@ test_expect_success "fetch test followRemoteHEAD warn detached" '
 '
 
 test_expect_success "fetch test followRemoteHEAD warn quiet" '
-	test_when_finished "git -C \"$D/two\" config unset remote.origin.followRemoteHEAD" &&
+	test_when_finished "git -C two config unset remote.origin.followRemoteHEAD" &&
 	(
-		cd "$D" &&
 		cd two &&
 		git rev-parse --verify refs/remotes/origin/other &&
 		git remote set-head origin other &&
@@ -205,9 +204,8 @@ test_expect_success "fetch test followRemoteHEAD warn quiet" '
 '
 
 test_expect_success "fetch test followRemoteHEAD warn-if-not-branch branch is same" '
-	test_when_finished "git -C \"$D/two\" config unset remote.origin.followRemoteHEAD" &&
+	test_when_finished "git -C two config unset remote.origin.followRemoteHEAD" &&
 	(
-		cd "$D" &&
 		cd two &&
 		git rev-parse --verify refs/remotes/origin/other &&
 		git remote set-head origin other &&
@@ -223,9 +221,8 @@ test_expect_success "fetch test followRemoteHEAD warn-if-not-branch branch is sa
 '
 
 test_expect_success "fetch test followRemoteHEAD warn-if-not-branch branch is different" '
-	test_when_finished "git -C \"$D/two\" config unset remote.origin.followRemoteHEAD" &&
+	test_when_finished "git -C two config unset remote.origin.followRemoteHEAD" &&
 	(
-		cd "$D" &&
 		cd two &&
 		git rev-parse --verify refs/remotes/origin/other &&
 		git remote set-head origin other &&
@@ -243,9 +240,8 @@ test_expect_success "fetch test followRemoteHEAD warn-if-not-branch branch is di
 '
 
 test_expect_success "fetch test followRemoteHEAD always" '
-	test_when_finished "git -C \"$D/two\" config unset remote.origin.followRemoteHEAD" &&
+	test_when_finished "git -C two config unset remote.origin.followRemoteHEAD" &&
 	(
-		cd "$D" &&
 		cd two &&
 		git rev-parse --verify refs/remotes/origin/other &&
 		git remote set-head origin other &&
@@ -260,9 +256,8 @@ test_expect_success "fetch test followRemoteHEAD always" '
 '
 
 test_expect_success 'followRemoteHEAD does not kick in with refspecs' '
-	test_when_finished "git -C \"$D/two\" config unset remote.origin.followRemoteHEAD" &&
+	test_when_finished "git -C two config unset remote.origin.followRemoteHEAD" &&
 	(
-		cd "$D" &&
 		cd two &&
 		git remote set-head origin other &&
 		git config set remote.origin.followRemoteHEAD always &&
@@ -274,93 +269,100 @@ test_expect_success 'followRemoteHEAD does not kick in with refspecs' '
 '
 
 test_expect_success 'fetch --prune on its own works as expected' '
-	cd "$D" &&
 	git clone . prune &&
-	cd prune &&
-	git update-ref refs/remotes/origin/extrabranch main &&
+	(
+		cd prune &&
+		git update-ref refs/remotes/origin/extrabranch main &&
 
-	git fetch --prune origin &&
-	test_must_fail git rev-parse origin/extrabranch
+		git fetch --prune origin &&
+		test_must_fail git rev-parse origin/extrabranch
+	)
 '
 
 test_expect_success 'fetch --prune with a branch name keeps branches' '
-	cd "$D" &&
 	git clone . prune-branch &&
-	cd prune-branch &&
-	git update-ref refs/remotes/origin/extrabranch main &&
+	(
+		cd prune-branch &&
+		git update-ref refs/remotes/origin/extrabranch main &&
 
-	git fetch --prune origin main &&
-	git rev-parse origin/extrabranch
+		git fetch --prune origin main &&
+		git rev-parse origin/extrabranch
+	)
 '
 
 test_expect_success 'fetch --prune with a namespace keeps other namespaces' '
-	cd "$D" &&
 	git clone . prune-namespace &&
-	cd prune-namespace &&
+	(
+		cd prune-namespace &&
 
-	git fetch --prune origin refs/heads/a/*:refs/remotes/origin/a/* &&
-	git rev-parse origin/main
+		git fetch --prune origin refs/heads/a/*:refs/remotes/origin/a/* &&
+		git rev-parse origin/main
+	)
 '
 
 test_expect_success 'fetch --prune handles overlapping refspecs' '
-	cd "$D" &&
 	git update-ref refs/pull/42/head main &&
 	git clone . prune-overlapping &&
-	cd prune-overlapping &&
-	git config --add remote.origin.fetch refs/pull/*/head:refs/remotes/origin/pr/* &&
+	(
+		cd prune-overlapping &&
+		git config --add remote.origin.fetch refs/pull/*/head:refs/remotes/origin/pr/* &&
 
-	git fetch --prune origin &&
-	git rev-parse origin/main &&
-	git rev-parse origin/pr/42 &&
+		git fetch --prune origin &&
+		git rev-parse origin/main &&
+		git rev-parse origin/pr/42 &&
 
-	git config --unset-all remote.origin.fetch &&
-	git config remote.origin.fetch refs/pull/*/head:refs/remotes/origin/pr/* &&
-	git config --add remote.origin.fetch refs/heads/*:refs/remotes/origin/* &&
+		git config --unset-all remote.origin.fetch &&
+		git config remote.origin.fetch refs/pull/*/head:refs/remotes/origin/pr/* &&
+		git config --add remote.origin.fetch refs/heads/*:refs/remotes/origin/* &&
 
-	git fetch --prune origin &&
-	git rev-parse origin/main &&
-	git rev-parse origin/pr/42
+		git fetch --prune origin &&
+		git rev-parse origin/main &&
+		git rev-parse origin/pr/42
+	)
 '
 
 test_expect_success 'fetch --prune --tags prunes branches but not tags' '
-	cd "$D" &&
 	git clone . prune-tags &&
-	cd prune-tags &&
-	git tag sometag main &&
-	# Create what looks like a remote-tracking branch from an earlier
-	# fetch that has since been deleted from the remote:
-	git update-ref refs/remotes/origin/fake-remote main &&
-
-	git fetch --prune --tags origin &&
-	git rev-parse origin/main &&
-	test_must_fail git rev-parse origin/fake-remote &&
-	git rev-parse sometag
+	(
+		cd prune-tags &&
+		git tag sometag main &&
+		# Create what looks like a remote-tracking branch from an earlier
+		# fetch that has since been deleted from the remote:
+		git update-ref refs/remotes/origin/fake-remote main &&
+
+		git fetch --prune --tags origin &&
+		git rev-parse origin/main &&
+		test_must_fail git rev-parse origin/fake-remote &&
+		git rev-parse sometag
+	)
 '
 
 test_expect_success 'fetch --prune --tags with branch does not prune other things' '
-	cd "$D" &&
 	git clone . prune-tags-branch &&
-	cd prune-tags-branch &&
-	git tag sometag main &&
-	git update-ref refs/remotes/origin/extrabranch main &&
+	(
+		cd prune-tags-branch &&
+		git tag sometag main &&
+		git update-ref refs/remotes/origin/extrabranch main &&
 
-	git fetch --prune --tags origin main &&
-	git rev-parse origin/extrabranch &&
-	git rev-parse sometag
+		git fetch --prune --tags origin main &&
+		git rev-parse origin/extrabranch &&
+		git rev-parse sometag
+	)
 '
 
 test_expect_success 'fetch --prune --tags with refspec prunes based on refspec' '
-	cd "$D" &&
 	git clone . prune-tags-refspec &&
-	cd prune-tags-refspec &&
-	git tag sometag main &&
-	git update-ref refs/remotes/origin/foo/otherbranch main &&
-	git update-ref refs/remotes/origin/extrabranch main &&
-
-	git fetch --prune --tags origin refs/heads/foo/*:refs/remotes/origin/foo/* &&
-	test_must_fail git rev-parse refs/remotes/origin/foo/otherbranch &&
-	git rev-parse origin/extrabranch &&
-	git rev-parse sometag
+	(
+		cd prune-tags-refspec &&
+		git tag sometag main &&
+		git update-ref refs/remotes/origin/foo/otherbranch main &&
+		git update-ref refs/remotes/origin/extrabranch main &&
+
+		git fetch --prune --tags origin refs/heads/foo/*:refs/remotes/origin/foo/* &&
+		test_must_fail git rev-parse refs/remotes/origin/foo/otherbranch &&
+		git rev-parse origin/extrabranch &&
+		git rev-parse sometag
+	)
 '
 
 test_expect_success 'fetch --tags gets tags even without a configured remote' '
@@ -381,21 +383,21 @@ test_expect_success 'fetch --tags gets tags even without a configured remote' '
 '
 
 test_expect_success REFFILES 'fetch --prune fails to delete branches' '
-	cd "$D" &&
 	git clone . prune-fail &&
-	cd prune-fail &&
-	git update-ref refs/remotes/origin/extrabranch main &&
-	git pack-refs --all &&
-	: this will prevent --prune from locking packed-refs for deleting refs, but adding loose refs still succeeds  &&
-	>.git/packed-refs.new &&
+	(
+		cd prune-fail &&
+		git update-ref refs/remotes/origin/extrabranch main &&
+		git pack-refs --all &&
+		: this will prevent --prune from locking packed-refs for deleting refs, but adding loose refs still succeeds  &&
+		>.git/packed-refs.new &&
 
-	test_must_fail git fetch --prune origin
+		test_must_fail git fetch --prune origin
+	)
 '
 
 test_expect_success 'fetch --atomic works with a single branch' '
-	test_when_finished "rm -rf \"$D\"/atomic" &&
+	test_when_finished "rm -rf atomic" &&
 
-	cd "$D" &&
 	git clone . atomic &&
 	git branch atomic-branch &&
 	oid=$(git rev-parse atomic-branch) &&
@@ -408,9 +410,8 @@ test_expect_success 'fetch --atomic works with a single branch' '
 '
 
 test_expect_success 'fetch --atomic works with multiple branches' '
-	test_when_finished "rm -rf \"$D\"/atomic" &&
+	test_when_finished "rm -rf atomic" &&
 
-	cd "$D" &&
 	git clone . atomic &&
 	git branch atomic-branch-1 &&
 	git branch atomic-branch-2 &&
@@ -423,9 +424,8 @@ test_expect_success 'fetch --atomic works with multiple branches' '
 '
 
 test_expect_success 'fetch --atomic works with mixed branches and tags' '
-	test_when_finished "rm -rf \"$D\"/atomic" &&
+	test_when_finished "rm -rf atomic" &&
 
-	cd "$D" &&
 	git clone . atomic &&
 	git branch atomic-mixed-branch &&
 	git tag atomic-mixed-tag &&
@@ -437,9 +437,8 @@ test_expect_success 'fetch --atomic works with mixed branches and tags' '
 '
 
 test_expect_success 'fetch --atomic prunes references' '
-	test_when_finished "rm -rf \"$D\"/atomic" &&
+	test_when_finished "rm -rf atomic" &&
 
-	cd "$D" &&
 	git branch atomic-prune-delete &&
 	git clone . atomic &&
 	git branch --delete atomic-prune-delete &&
@@ -453,9 +452,8 @@ test_expect_success 'fetch --atomic prunes references' '
 '
 
 test_expect_success 'fetch --atomic aborts with non-fast-forward update' '
-	test_when_finished "rm -rf \"$D\"/atomic" &&
+	test_when_finished "rm -rf atomic" &&
 
-	cd "$D" &&
 	git branch atomic-non-ff &&
 	git clone . atomic &&
 	git rev-parse HEAD >actual &&
@@ -472,9 +470,8 @@ test_expect_success 'fetch --atomic aborts with non-fast-forward update' '
 '
 
 test_expect_success 'fetch --atomic executes a single reference transaction only' '
-	test_when_finished "rm -rf \"$D\"/atomic" &&
+	test_when_finished "rm -rf atomic" &&
 
-	cd "$D" &&
 	git clone . atomic &&
 	git branch atomic-hooks-1 &&
 	git branch atomic-hooks-2 &&
@@ -499,9 +496,8 @@ test_expect_success 'fetch --atomic executes a single reference transaction only
 '
 
 test_expect_success 'fetch --atomic aborts all reference updates if hook aborts' '
-	test_when_finished "rm -rf \"$D\"/atomic" &&
+	test_when_finished "rm -rf atomic" &&
 
-	cd "$D" &&
 	git clone . atomic &&
 	git branch atomic-hooks-abort-1 &&
 	git branch atomic-hooks-abort-2 &&
@@ -536,9 +532,8 @@ test_expect_success 'fetch --atomic aborts all reference updates if hook aborts'
 '
 
 test_expect_success 'fetch --atomic --append appends to FETCH_HEAD' '
-	test_when_finished "rm -rf \"$D\"/atomic" &&
+	test_when_finished "rm -rf atomic" &&
 
-	cd "$D" &&
 	git clone . atomic &&
 	oid=$(git rev-parse HEAD) &&
 
@@ -574,8 +569,7 @@ test_expect_success REFFILES 'fetch --atomic fails transaction if reference lock
 '
 
 test_expect_success '--refmap="" ignores configured refspec' '
-	cd "$TRASH_DIRECTORY" &&
-	git clone "$D" remote-refs &&
+	git clone . remote-refs &&
 	git -C remote-refs rev-parse remotes/origin/main >old &&
 	git -C remote-refs update-ref refs/remotes/origin/main main~1 &&
 	git -C remote-refs rev-parse remotes/origin/main >new &&
@@ -599,34 +593,26 @@ test_expect_success '--refmap="" and --prune' '
 
 test_expect_success 'fetch tags when there is no tags' '
 
-    cd "$D" &&
-
-    mkdir notags &&
-    cd notags &&
-    git init &&
-
-    git fetch -t ..
+	git init notags &&
+	git -C notags fetch -t ..
 
 '
 
 test_expect_success 'fetch following tags' '
 
-	cd "$D" &&
 	git tag -a -m "annotated" anno HEAD &&
 	git tag light HEAD &&
 
-	mkdir four &&
-	cd four &&
-	git init &&
-
-	git fetch .. :track &&
-	git show-ref --verify refs/tags/anno &&
-	git show-ref --verify refs/tags/light
-
+	git init four &&
+	(
+		cd four &&
+		git fetch .. :track &&
+		git show-ref --verify refs/tags/anno &&
+		git show-ref --verify refs/tags/light
+	)
 '
 
 test_expect_success 'fetch uses remote ref names to describe new refs' '
-	cd "$D" &&
 	git init descriptive &&
 	(
 		cd descriptive &&
@@ -654,30 +640,20 @@ test_expect_success 'fetch uses remote ref names to describe new refs' '
 
 test_expect_success 'fetch must not resolve short tag name' '
 
-	cd "$D" &&
-
-	mkdir five &&
-	cd five &&
-	git init &&
-
-	test_must_fail git fetch .. anno:five
+	git init five &&
+	test_must_fail git -C five fetch .. anno:five
 
 '
 
 test_expect_success 'fetch can now resolve short remote name' '
 
-	cd "$D" &&
 	git update-ref refs/remotes/six/HEAD HEAD &&
 
-	mkdir six &&
-	cd six &&
-	git init &&
-
-	git fetch .. six:six
+	git init six &&
+	git -C six fetch .. six:six
 '
 
 test_expect_success 'create bundle 1' '
-	cd "$D" &&
 	echo >file updated again by origin &&
 	git commit -a -m "tip" &&
 	git bundle create --version=3 bundle1 main^..main
@@ -691,35 +667,36 @@ test_expect_success 'header of bundle looks right' '
 	OID refs/heads/main
 
 	EOF
-	sed -e "s/$OID_REGEX/OID/g" -e "5q" "$D"/bundle1 >actual &&
+	sed -e "s/$OID_REGEX/OID/g" -e "5q" bundle1 >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'create bundle 2' '
-	cd "$D" &&
 	git bundle create bundle2 main~2..main
 '
 
 test_expect_success 'unbundle 1' '
-	cd "$D/bundle" &&
-	git checkout -b some-branch &&
-	test_must_fail git fetch "$D/bundle1" main:main
+	(
+		cd bundle &&
+		git checkout -b some-branch &&
+		test_must_fail git fetch bundle1 main:main
+	)
 '
 
 
 test_expect_success 'bundle 1 has only 3 files ' '
-	cd "$D" &&
 	test_bundle_object_count bundle1 3
 '
 
 test_expect_success 'unbundle 2' '
-	cd "$D/bundle" &&
-	git fetch ../bundle2 main:main &&
-	test "tip" = "$(git log -1 --pretty=oneline main | cut -d" " -f2)"
+	(
+		cd bundle &&
+		git fetch ../bundle2 main:main &&
+		test "tip" = "$(git log -1 --pretty=oneline main | cut -d" " -f2)"
+	)
 '
 
 test_expect_success 'bundle does not prerequisite objects' '
-	cd "$D" &&
 	touch file2 &&
 	git add file2 &&
 	git commit -m add.file2 file2 &&
@@ -729,7 +706,6 @@ test_expect_success 'bundle does not prerequisite objects' '
 
 test_expect_success 'bundle should be able to create a full history' '
 
-	cd "$D" &&
 	git tag -a -m "1.0" v1.0 main &&
 	git bundle create bundle4 v1.0
 
@@ -783,7 +759,6 @@ test_expect_success 'quoting of a strangely named repo' '
 
 test_expect_success 'bundle should record HEAD correctly' '
 
-	cd "$D" &&
 	git bundle create bundle5 HEAD main &&
 	git bundle list-heads bundle5 >actual &&
 	for h in HEAD refs/heads/main
@@ -803,7 +778,6 @@ test_expect_success 'mark initial state of origin/main' '
 
 test_expect_success 'explicit fetch should update tracking' '
 
-	cd "$D" &&
 	git branch -f side &&
 	(
 		cd three &&
@@ -818,7 +792,6 @@ test_expect_success 'explicit fetch should update tracking' '
 
 test_expect_success 'explicit pull should update tracking' '
 
-	cd "$D" &&
 	git branch -f side &&
 	(
 		cd three &&
@@ -832,15 +805,13 @@ test_expect_success 'explicit pull should update tracking' '
 '
 
 test_expect_success 'explicit --refmap is allowed only with command-line refspec' '
-	cd "$D" &&
 	(
 		cd three &&
 		test_must_fail git fetch --refmap="*:refs/remotes/none/*"
 	)
 '
 
 test_expect_success 'explicit --refmap option overrides remote.*.fetch' '
-	cd "$D" &&
 	git branch -f side &&
 	(
 		cd three &&
@@ -855,7 +826,6 @@ test_expect_success 'explicit --refmap option overrides remote.*.fetch' '
 '
 
 test_expect_success 'explicitly empty --refmap option disables remote.*.fetch' '
-	cd "$D" &&
 	git branch -f side &&
 	(
 		cd three &&
@@ -870,7 +840,6 @@ test_expect_success 'explicitly empty --refmap option disables remote.*.fetch' '
 
 test_expect_success 'configured fetch updates tracking' '
 
-	cd "$D" &&
 	git branch -f side &&
 	(
 		cd three &&
@@ -884,7 +853,6 @@ test_expect_success 'configured fetch updates tracking' '
 '
 
 test_expect_success 'non-matching refspecs do not confuse tracking update' '
-	cd "$D" &&
 	git update-ref refs/odd/location HEAD &&
 	(
 		cd three &&
@@ -901,14 +869,12 @@ test_expect_success 'non-matching refspecs do not confuse tracking update' '
 
 test_expect_success 'pushing nonexistent branch by mistake should not segv' '
 
-	cd "$D" &&
 	test_must_fail git push seven no:no
 
 '
 
 test_expect_success 'auto tag following fetches minimum' '
 
-	cd "$D" &&
 	git clone .git follow &&
 	git checkout HEAD^0 &&
 	(
@@ -1307,7 +1273,7 @@ test_expect_success 'fetch --prune prints the remotes url' '
 		cd only-prunes &&
 		git fetch --prune origin 2>&1 | head -n1 >../actual
 	) &&
-	echo "From ${D}/." >expect &&
+	echo "From $(pwd)/." >expect &&
 	test_cmp expect actual
 '
 
@@ -1357,14 +1323,14 @@ test_expect_success 'fetching with auto-gc does not lock up' '
 	echo "$*" &&
 	false
 	EOF
-	git clone "file://$D" auto-gc &&
+	git clone "file://$PWD" auto-gc &&
 	test_commit test2 &&
 	(
 		cd auto-gc &&
 		git config fetch.unpackLimit 1 &&
 		git config gc.autoPackLimit 1 &&
 		git config gc.autoDetach false &&
-		GIT_ASK_YESNO="$D/askyesno" git fetch --verbose >fetch.out 2>&1 &&
+		GIT_ASK_YESNO="$TRASH_DIRECTORY/askyesno" git fetch --verbose >fetch.out 2>&1 &&
 		test_grep "Auto packing the repository" fetch.out &&
 		! grep "Should I try again" fetch.out
 	)
-- 
2.51.0.326.gecbb38d78e

