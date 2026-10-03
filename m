Received: from mx-out2.startmail.com (mx-out2.startmail.com [145.131.90.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F9333998
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 01:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.131.90.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790989742; cv=none; b=CV0mNmu+dLwu5pccWJPR9fy02wpbjr6zhG0N3mw3u51HIBP3asxZFCRf46iMH+KwJj5Gl7BUXfIj7vE0qMdPi5cvJ+mO857NRO+/kI0O139cAHIfaXYEsZPpt4HXi7SACryooEkOI2DZzcjQ2AKN7erJXeaOP8Tm62Y6wq+fut8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790989742; c=relaxed/simple;
	bh=jJT7cExrrl1dmfw8C5Cs+PvM+tLxbWXPatBr5st+fFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version; b=tstGZMoca9qsnITOL4K2oMBvrSKSoaYQK4O0MfWkGDD1wXLhEsqiX8owov914xJdVKQ9VYMV29krsV4/Wokdc/hRyNh527UMtH0ad10asfZ+X6s3H7q5iIkh95xkVnde1xd8bF/gtY7bpY7cwnKHteuvqaKSgwJRTsZTlFzzZok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grantmoyer.com; spf=pass smtp.mailfrom=grantmoyer.com; dkim=pass (2048-bit key) header.d=startmail.com header.i=@startmail.com header.b=xLyL7CBO; arc=none smtp.client-ip=145.131.90.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grantmoyer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grantmoyer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=startmail.com header.i=@startmail.com header.b="xLyL7CBO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
	s=2020-07; t=1790989348;
	bh=NfUKzhLwiO94K8SDJ5YORIXiV2leU5ga2HJTLQZBSsQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version:Content-Transfer-Encoding:From:Subject:To:Date:Sender:
	 Content-Type:Content-Transfer-Encoding:Content-Disposition:
	 Mime-Version:Reply-To:In-Reply-To:References:Message-Id:Autocrypt;
	b=xLyL7CBOnHw+REYq44vxmTHXSUscrNqqg9uipk2gjR5OthNhx7N3SBjJh8cJVt/3T
	 zjoxc+JiTL46A3wHZBYm+wUNYfSV9neqp+Sfyk4nqj2y6QoYewLGb8MgA25ngR51v+
	 +0ni/fX4Y8/XW62DugmS+NPyMcgD7ZdD2LVjM7algPfu/Ay8s1iQKFPPbUtM4zh/L9
	 0F4IN7qOo1TEyDthGriyPwD+leXwvY05+zbaRFOJMABkn0LQoqjvmKyp7EA+O0ZkW/
	 EY3MR9+xxQX2npiFNYr8qePLrrmtUdw4XAs81O270RZ+F/TamBRLMrWgas2OZQ/57S
	 tfm1LgRScPWxg==
From: Grant Moyer <dev@grantmoyer.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Grant Moyer <dev@grantmoyer.com>,
	Michele Locati <michele@locati.it>
Subject: [PATCH v3] filter-branch: fix commit map init from state branch
Date: Fri,  2 Oct 2026 21:01:27 -0400
Message-ID: <20261003010128.256757-1-dev@grantmoyer.com>
In-Reply-To: <20261001012347.3998801-1-dev@grantmoyer.com>
References: <20261001012347.3998801-1-dev@grantmoyer.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit

The "--state-branch" option asks git-filter-branch(1) to write a
mapping from old to new objects into a branch to enable incremental
processing of large histories. This object mapping is stored as
a simple blob at "$state_branch:filter.map" with one object pair
per line in the format "$from_commit:$to_commit". Before processing
commits in a subsequent run, the state branch is used to populate an
object mapping directory, where each file is named "map/$from_commit"
and has contents "$to_commit".

In f6d855091e (filter-branch: stop depending on Perl, 2025-04-16),
we refactored git-filter-branch(1) to no longer require Perl,
but accidentally started to interpret object pairs in reverse (as
"$to_commit:$from_commit") when populating the map directory from
the state branch. This can cause all kinds of bad behavior from the
state-branch being effectively ignored to previously filtered objects
accidentally being mapped back to unfiltered objects. One especially
evident case occurs when "git filter-branch --prune-empty ..." maps
some commits to nothing, then on subsequent runs outputs many errors
while trying to create files with empty names, like:

> /usr/lib/git-core/git-filter-branch: line 305: ../map/: Is a directory

This regression went unnoticed because, since the introduction of
the only test for "--state-branch" in 709cfe848a (filter-branch: skip
commits present on --state-branch, 2018-06-26), the test accidentally
passes even if commits are not skipped. The test checks that after
populating a state branch with git-filter-branch(1), then running
it again with that state branch, the resulting filtered commits for
the first run and second run match. However since the filter used is
deterministic, the commits always match, even if the commits in the
state branch are re-filtered.

Fix the population of the object mapping dir by interpreting
object pairs as "$from_commit:$to_commit". Also fix the existing
"--state-branch" test by directly exiting with a non-zero code if
any commits from the state branch aren't skipped. Finally, add a new
"--state-branch" test which directly checks that a commit from the
state branch is used when incrementally filtering a repo.

Tested-by: Michele Locati <michele@locati.it>
Co-authored-by: Michele Locati <michele@locati.it>
Signed-off-by: Michele Locati <michele@locati.it>
Signed-off-by: Grant Moyer <dev@grantmoyer.com>
---
 git-filter-branch.sh     |  4 +++-
 t/t7003-filter-branch.sh | 25 ++++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 24fa317aaa..9aa07be6e1 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -302,7 +302,9 @@ then
 		do
 			case "$line" in
 			*:*)
-				echo "${line%:*}" >../map/"${line#*:}";;
+				from_commit=${line%:*}
+				to_commit=${line#*:}
+				echo "$to_commit" >../map/"$from_commit";;
 			*)
 				die "Unable to load state from $state_branch:filter.map";;
 			esac
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 86011e7b1f..801cc83e5e 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -121,10 +121,33 @@ W=$(git rev-parse HEAD)
 test_expect_success 'using --state-branch to skip already rewritten commits' '
 	test_when_finished git reset --hard $V &&
 	git reset --hard $V &&
-	git filter-branch --state-branch state -f --tree-filter "touch file || :" HEAD &&
+	git filter-branch --state-branch state -f --tree-filter "exit 1" HEAD &&
 	test_cmp_rev $W HEAD
 '
 
+test_expect_success '--state-branch incremental rewrite uses the rewritten parents' '
+	test_when_finished "rm -fr incremental" &&
+	git init incremental &&
+	(
+		cd incremental &&
+		mkdir sub &&
+		test_commit first sub/file &&
+		test_commit outside root-file &&
+		git filter-branch --state-branch refs/state \
+			--prune-empty --subdirectory-filter sub -- HEAD &&
+		rewritten_first=$(git rev-parse HEAD) &&
+		git reset --hard outside &&
+		test_commit second sub/file &&
+		git filter-branch -f --state-branch refs/state \
+			--prune-empty --subdirectory-filter sub -- outside..HEAD &&
+		test_cmp_rev $rewritten_first HEAD^ &&
+		git show refs/state:filter.map >map &&
+		echo "$(git rev-parse second):$(git rev-parse HEAD)" >expect &&
+		grep "^$(git rev-parse second):" map >actual &&
+		test_cmp expect actual
+	)
+'
+
 git tag oldD HEAD~4
 test_expect_success 'rewrite one branch, keeping a side branch' '
 	git branch modD oldD &&
-- 
2.55.0

