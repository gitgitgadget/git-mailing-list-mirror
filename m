Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A9E30E0F1
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 19:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755631642; cv=none; b=Vc0QGZzgTBrW84LusLD60vQkeQYOLRWrZ7xvYvrhWN3SzD36JDqaKhwhMCY53QSuJN6EzSF51+z5iO637jnOnqiWEV6wRgpnGkAXahGhzdIsM+wlb2NFByEnXctyXdPOlffjNIlO+GnkEsVRwAGiapt20hvv8CGVjHgbeeVqugY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755631642; c=relaxed/simple;
	bh=OD5pnYTnN0rdShLSHXMjk1SgI/y5fz+RAkRnvc9ZqRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHcx4fFd5hkYd7JxCBZNC4uclazVh/WzhLi/84RfMWobyqDogSdhQkJzmgZfHQyUrPw/KVOsk88jbAhMQrShux3tRp/+Mv8QUHwProH/z48pu4H9K2aR0dxIXo4dOGTk2go8a/pMvFROHEZetE6JQI+HlWZZz8At1JJKthZ3JRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=MyE12u4O; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="MyE12u4O"
Received: (qmail 31204 invoked by uid 109); 19 Aug 2025 19:27:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=OD5pnYTnN0rdShLSHXMjk1SgI/y5fz+RAkRnvc9ZqRI=; b=MyE12u4Oh/7Lfdv2yy7h9/S4FpDJRqn+Ith4DFQE0EfwoGJxLBiUcxsubeQjIV5xTiQ1JYR+DZyaa1KrJBVIse/JprwAUXBQRkLB42ynsVeMZRiJr4+sdHw2lgyzO+C18Qq6A8ir5wY0lDkpX1AiNCN3wBkHDjZCpEDGxZgA90IUsofkhHlCdw0m8poyWx5RkkjdlRRhTGArppHMf6Ek8wMCGRvqVPiVncJjmpOXvnOjHKpUzSwOlVdjxVJAbr6DRrasX/Xswvof28eEU3cTFOZPZs1y51x6rEpBjj45rpbKWk/VEz0jxoD52yUEDiPIhOgmRHmJsO2eDQ7CQUxuSg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 19 Aug 2025 19:27:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 46432 invoked by uid 111); 19 Aug 2025 19:27:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 Aug 2025 15:27:17 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 19 Aug 2025 15:27:16 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 3/4] t5510: prefer "git -C" to subshell for followRemoteHEAD
 tests
Message-ID: <20250819192716.GC1059295@coredump.intra.peff.net>
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

These tests set config within a sub-repo using (cd two && git config),
and then a separate test_when_finished outside the subshell to clean it
up. We can't use test_config to do this, because the cleanup command it
registers inside the subshell would be lost. Nor can we do it before
entering the subshell, because the config has to be set after some other
commands are run.

Let's switch these tests to use "git -C" for each command instead of a
subshell. That lets us use test_config (with -C also) at the appropriate
part of the test. And we no longer need the manual cleanup command.

Signed-off-by: Jeff King <peff@peff.net>
---
It is perhaps debatable whether this makes the result more readable.
It's fewer lines, but there is "-C" sprinkled everywhere. So if people
find this ugly we can drop it (and I'd rewrite patch 4 to use the
subshell form in its new test).

 t/t5510-fetch.sh | 202 +++++++++++++++++++----------------------------
 1 file changed, 83 insertions(+), 119 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 93e309e213..24379ec7aa 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -123,149 +123,113 @@ test_expect_success "fetch test remote HEAD change" '
 '
 
 test_expect_success "fetch test followRemoteHEAD never" '
-	test_when_finished "git -C two config unset remote.origin.followRemoteHEAD" &&
-	(
-		cd two &&
-		git update-ref --no-deref -d refs/remotes/origin/HEAD &&
-		git config set remote.origin.followRemoteHEAD "never" &&
-		GIT_TRACE_PACKET=$PWD/trace.out git fetch &&
-		# Confirm that we do not even ask for HEAD when we are
-		# not going to act on it.
-		test_grep ! "ref-prefix HEAD" trace.out &&
-		test_must_fail git rev-parse --verify refs/remotes/origin/HEAD
-	)
+	git -C two update-ref --no-deref -d refs/remotes/origin/HEAD &&
+	test_config -C two remote.origin.followRemoteHEAD "never" &&
+	GIT_TRACE_PACKET=$PWD/trace.out git -C two fetch &&
+	# Confirm that we do not even ask for HEAD when we are
+	# not going to act on it.
+	test_grep ! "ref-prefix HEAD" trace.out &&
+	test_must_fail git -C two rev-parse --verify refs/remotes/origin/HEAD
 '
 
 test_expect_success "fetch test followRemoteHEAD warn no change" '
-	test_when_finished "git -C two config unset remote.origin.followRemoteHEAD" &&
-	(
-		cd two &&
-		git rev-parse --verify refs/remotes/origin/other &&
-		git remote set-head origin other &&
-		git rev-parse --verify refs/remotes/origin/HEAD &&
-		git rev-parse --verify refs/remotes/origin/main &&
-		git config set remote.origin.followRemoteHEAD "warn" &&
-		git fetch >output &&
-		echo "${SQ}HEAD${SQ} at ${SQ}origin${SQ} is ${SQ}main${SQ}," \
-			"but we have ${SQ}other${SQ} locally." >expect &&
-		test_cmp expect output &&
-		head=$(git rev-parse refs/remotes/origin/HEAD) &&
-		branch=$(git rev-parse refs/remotes/origin/other) &&
-		test "z$head" = "z$branch"
-	)
+	git -C two rev-parse --verify refs/remotes/origin/other &&
+	git -C two remote set-head origin other &&
+	git -C two rev-parse --verify refs/remotes/origin/HEAD &&
+	git -C two rev-parse --verify refs/remotes/origin/main &&
+	test_config -C two remote.origin.followRemoteHEAD "warn" &&
+	git -C two fetch >output &&
+	echo "${SQ}HEAD${SQ} at ${SQ}origin${SQ} is ${SQ}main${SQ}," \
+		"but we have ${SQ}other${SQ} locally." >expect &&
+	test_cmp expect output &&
+	head=$(git -C two rev-parse refs/remotes/origin/HEAD) &&
+	branch=$(git -C two rev-parse refs/remotes/origin/other) &&
+	test "z$head" = "z$branch"
 '
 
 test_expect_success "fetch test followRemoteHEAD warn create" '
-	test_when_finished "git -C two config unset remote.origin.followRemoteHEAD" &&
-	(
-		cd two &&
-		git update-ref --no-deref -d refs/remotes/origin/HEAD &&
-		git config set remote.origin.followRemoteHEAD "warn" &&
-		git rev-parse --verify refs/remotes/origin/main &&
-		output=$(git fetch) &&
-		test "z" = "z$output" &&
-		head=$(git rev-parse refs/remotes/origin/HEAD) &&
-		branch=$(git rev-parse refs/remotes/origin/main) &&
-		test "z$head" = "z$branch"
-	)
+	git -C two update-ref --no-deref -d refs/remotes/origin/HEAD &&
+	test_config -C two remote.origin.followRemoteHEAD "warn" &&
+	git -C two rev-parse --verify refs/remotes/origin/main &&
+	output=$(git -C two fetch) &&
+	test "z" = "z$output" &&
+	head=$(git -C two rev-parse refs/remotes/origin/HEAD) &&
+	branch=$(git -C two rev-parse refs/remotes/origin/main) &&
+	test "z$head" = "z$branch"
 '
 
 test_expect_success "fetch test followRemoteHEAD warn detached" '
-	test_when_finished "git -C two config unset remote.origin.followRemoteHEAD" &&
-	(
-		cd two &&
-		git update-ref --no-deref -d refs/remotes/origin/HEAD &&
-		git update-ref refs/remotes/origin/HEAD HEAD &&
-		HEAD=$(git log --pretty="%H") &&
-		git config set remote.origin.followRemoteHEAD "warn" &&
-		git fetch >output &&
-		echo "${SQ}HEAD${SQ} at ${SQ}origin${SQ} is ${SQ}main${SQ}," \
-			"but we have a detached HEAD pointing to" \
-			"${SQ}${HEAD}${SQ} locally." >expect &&
-		test_cmp expect output
-	)
+	git -C two update-ref --no-deref -d refs/remotes/origin/HEAD &&
+	git -C two update-ref refs/remotes/origin/HEAD HEAD &&
+	HEAD=$(git -C two log --pretty="%H") &&
+	test_config -C two remote.origin.followRemoteHEAD "warn" &&
+	git -C two fetch >output &&
+	echo "${SQ}HEAD${SQ} at ${SQ}origin${SQ} is ${SQ}main${SQ}," \
+		"but we have a detached HEAD pointing to" \
+		"${SQ}${HEAD}${SQ} locally." >expect &&
+	test_cmp expect output
 '
 
 test_expect_success "fetch test followRemoteHEAD warn quiet" '
-	test_when_finished "git -C two config unset remote.origin.followRemoteHEAD" &&
-	(
-		cd two &&
-		git rev-parse --verify refs/remotes/origin/other &&
-		git remote set-head origin other &&
-		git rev-parse --verify refs/remotes/origin/HEAD &&
-		git rev-parse --verify refs/remotes/origin/main &&
-		git config set remote.origin.followRemoteHEAD "warn" &&
-		output=$(git fetch --quiet) &&
-		test "z" = "z$output" &&
-		head=$(git rev-parse refs/remotes/origin/HEAD) &&
-		branch=$(git rev-parse refs/remotes/origin/other) &&
-		test "z$head" = "z$branch"
-	)
+	git -C two rev-parse --verify refs/remotes/origin/other &&
+	git -C two remote set-head origin other &&
+	git -C two rev-parse --verify refs/remotes/origin/HEAD &&
+	git -C two rev-parse --verify refs/remotes/origin/main &&
+	test_config -C two remote.origin.followRemoteHEAD "warn" &&
+	output=$(git -C two fetch --quiet) &&
+	test "z" = "z$output" &&
+	head=$(git -C two rev-parse refs/remotes/origin/HEAD) &&
+	branch=$(git -C two rev-parse refs/remotes/origin/other) &&
+	test "z$head" = "z$branch"
 '
 
 test_expect_success "fetch test followRemoteHEAD warn-if-not-branch branch is same" '
-	test_when_finished "git -C two config unset remote.origin.followRemoteHEAD" &&
-	(
-		cd two &&
-		git rev-parse --verify refs/remotes/origin/other &&
-		git remote set-head origin other &&
-		git rev-parse --verify refs/remotes/origin/HEAD &&
-		git rev-parse --verify refs/remotes/origin/main &&
-		git config set remote.origin.followRemoteHEAD "warn-if-not-main" &&
-		actual=$(git fetch) &&
-		test "z" = "z$actual" &&
-		head=$(git rev-parse refs/remotes/origin/HEAD) &&
-		branch=$(git rev-parse refs/remotes/origin/other) &&
-		test "z$head" = "z$branch"
-	)
+	git -C two rev-parse --verify refs/remotes/origin/other &&
+	git -C two remote set-head origin other &&
+	git -C two rev-parse --verify refs/remotes/origin/HEAD &&
+	git -C two rev-parse --verify refs/remotes/origin/main &&
+	test_config -C two remote.origin.followRemoteHEAD "warn-if-not-main" &&
+	actual=$(git -C two fetch) &&
+	test "z" = "z$actual" &&
+	head=$(git -C two rev-parse refs/remotes/origin/HEAD) &&
+	branch=$(git -C two rev-parse refs/remotes/origin/other) &&
+	test "z$head" = "z$branch"
 '
 
 test_expect_success "fetch test followRemoteHEAD warn-if-not-branch branch is different" '
-	test_when_finished "git -C two config unset remote.origin.followRemoteHEAD" &&
-	(
-		cd two &&
-		git rev-parse --verify refs/remotes/origin/other &&
-		git remote set-head origin other &&
-		git rev-parse --verify refs/remotes/origin/HEAD &&
-		git rev-parse --verify refs/remotes/origin/main &&
-		git config set remote.origin.followRemoteHEAD "warn-if-not-some/different-branch" &&
-		git fetch >actual &&
-		echo "${SQ}HEAD${SQ} at ${SQ}origin${SQ} is ${SQ}main${SQ}," \
-			"but we have ${SQ}other${SQ} locally." >expect &&
-		test_cmp expect actual &&
-		head=$(git rev-parse refs/remotes/origin/HEAD) &&
-		branch=$(git rev-parse refs/remotes/origin/other) &&
-		test "z$head" = "z$branch"
-	)
+	git -C two rev-parse --verify refs/remotes/origin/other &&
+	git -C two remote set-head origin other &&
+	git -C two rev-parse --verify refs/remotes/origin/HEAD &&
+	git -C two rev-parse --verify refs/remotes/origin/main &&
+	test_config -C two remote.origin.followRemoteHEAD "warn-if-not-some/different-branch" &&
+	git -C two fetch >actual &&
+	echo "${SQ}HEAD${SQ} at ${SQ}origin${SQ} is ${SQ}main${SQ}," \
+		"but we have ${SQ}other${SQ} locally." >expect &&
+	test_cmp expect actual &&
+	head=$(git -C two rev-parse refs/remotes/origin/HEAD) &&
+	branch=$(git -C two rev-parse refs/remotes/origin/other) &&
+	test "z$head" = "z$branch"
 '
 
 test_expect_success "fetch test followRemoteHEAD always" '
-	test_when_finished "git -C two config unset remote.origin.followRemoteHEAD" &&
-	(
-		cd two &&
-		git rev-parse --verify refs/remotes/origin/other &&
-		git remote set-head origin other &&
-		git rev-parse --verify refs/remotes/origin/HEAD &&
-		git rev-parse --verify refs/remotes/origin/main &&
-		git config set remote.origin.followRemoteHEAD "always" &&
-		git fetch &&
-		head=$(git rev-parse refs/remotes/origin/HEAD) &&
-		branch=$(git rev-parse refs/remotes/origin/main) &&
-		test "z$head" = "z$branch"
-	)
+	git -C two rev-parse --verify refs/remotes/origin/other &&
+	git -C two remote set-head origin other &&
+	git -C two rev-parse --verify refs/remotes/origin/HEAD &&
+	git -C two rev-parse --verify refs/remotes/origin/main &&
+	test_config -C two remote.origin.followRemoteHEAD "always" &&
+	git -C two fetch &&
+	head=$(git -C two rev-parse refs/remotes/origin/HEAD) &&
+	branch=$(git -C two rev-parse refs/remotes/origin/main) &&
+	test "z$head" = "z$branch"
 '
 
 test_expect_success 'followRemoteHEAD does not kick in with refspecs' '
-	test_when_finished "git -C two config unset remote.origin.followRemoteHEAD" &&
-	(
-		cd two &&
-		git remote set-head origin other &&
-		git config set remote.origin.followRemoteHEAD always &&
-		git fetch origin refs/heads/main:refs/remotes/origin/main &&
-		echo refs/remotes/origin/other >expect &&
-		git symbolic-ref refs/remotes/origin/HEAD >actual &&
-		test_cmp expect actual
-	)
+	git -C two remote set-head origin other &&
+	test_config -C two remote.origin.followRemoteHEAD always &&
+	git -C two fetch origin refs/heads/main:refs/remotes/origin/main &&
+	echo refs/remotes/origin/other >expect &&
+	git -C two symbolic-ref refs/remotes/origin/HEAD >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'fetch --prune on its own works as expected' '
-- 
2.51.0.326.gecbb38d78e

