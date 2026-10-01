Received: from mx-out1.startmail.com (mx-out1.startmail.com [145.131.90.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2201A5B9E
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 01:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.131.90.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790817875; cv=none; b=mpFvLvM93xOJrigF5IWozUf8uriycKMtf7khHb9UYI/sniDpLU5dvLimovZYzcJ47+qwwKdaqkBW0WCz4PtWg0gU8LEYThCINGtAAOL9Jz2XBb7+jBrbQY2AyZu9JU9q7+d6juZB7dSfQd40oPHPDUXHMLtt+sSwzqoNMS05Jk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790817875; c=relaxed/simple;
	bh=dgZ8kMg74Ekll3VQzqsleSUcn1RaL3WNCsgLjTsHt64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version; b=N8e9TCP1ikALEzSN5xXcKytT90cZB3rzJdVm0Ai/3AUp2B/WYs91bcYTt9MaX4MEZGe2s5upqtPGkHZdFQq4lCYI2AqHO+uznisJ8naGcoQL99BUQtjb52LyBDOLga3bksklLIGoG0adizV0KALRhaRSeWNy5ve6/RCmPX4knKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grantmoyer.com; spf=pass smtp.mailfrom=grantmoyer.com; dkim=pass (2048-bit key) header.d=startmail.com header.i=@startmail.com header.b=xw60gpNM; arc=none smtp.client-ip=145.131.90.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grantmoyer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grantmoyer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=startmail.com header.i=@startmail.com header.b="xw60gpNM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
	s=2020-07; t=1790817869;
	bh=S6fmnSwGY4WaBXjfs559PVG4x758Jby0Uj6lkU5T+no=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version:Content-Transfer-Encoding:From:Subject:To:Date:Sender:
	 Content-Type:Content-Transfer-Encoding:Content-Disposition:
	 Mime-Version:Reply-To:In-Reply-To:References:Message-Id:Autocrypt;
	b=xw60gpNM31I7QWDagz6YWGnphMSmc9xXkFMjzpNmjZIMAtCaBFlUYfTu+P9YUd7zm
	 XJBSyButVxvasxgcAQVI3YFHwOL9utK+JiK+WPMaG/HLua2JtSxhGMG/JPgRfOmnPt
	 e4wxE4KZ5Mwex1/VhPZD5/+phH8wbbNxw+j5xUdHCQox/6s+O0tXshdnwt0OBOrmVQ
	 w9RpPywup0w+2tJNINmc18FhwTAJ/aZKTSNDf3D+sAYP75s6RNFv0NFrnwxfRWFRyq
	 TzAZV4xHe4bDJ6hCqd0t06oF83LahbURMfLkVB98psyb/nSiHYfaO2/+CbHFvC8/lu
	 PwT6X9xtpcnGg==
From: Grant Moyer <dev@grantmoyer.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Grant Moyer <dev@grantmoyer.com>,
	Michele Locati <michele@locati.it>
Subject: [PATCH v2] filter-branch: fix commit map init from state branch
Date: Wed, 30 Sep 2026 21:23:47 -0400
Message-ID: <20261001012347.3998801-1-dev@grantmoyer.com>
In-Reply-To: <20260801033127.10606-1-dev@grantmoyer.com>
References: <20260801033127.10606-1-dev@grantmoyer.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit map dir is populated from the state branch assuming a
"to_commit:from_commit" format, but the state branch is written with a
"from_commit:to_commit" format, resulting in an inverted mapping when the
map is populated from the state branch. This is especially evident when
--prune-empty is used and creates commits which map to nothing; when the
map dir is populated from this state on subsequent runs, git-filter-branch
outputs many errors while trying to create files with empty names, like:

> /usr/lib/git-core/git-filter-branch: line 305: ../map/: Is a directory

This change corrects the population of the commit map dir to match the
"from_commit:to_commit" format and adds/updates tests to check that the
state branch is written correctly.

Signed-off-by: Grant Moyer <dev@grantmoyer.com>
Tested-by: Michele Locati <michele@locati.it>
Co-authored-by: Michele Locati <michele@locati.it>
---
 git-filter-branch.sh     |  4 +++-
 t/t7003-filter-branch.sh | 24 +++++++++++++++++++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)

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
index 86011e7b1f..cf225b0f0f 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -121,10 +121,32 @@ W=$(git rev-parse HEAD)
 test_expect_success 'using --state-branch to skip already rewritten commits' '
 	test_when_finished git reset --hard $V &&
 	git reset --hard $V &&
-	git filter-branch --state-branch state -f --tree-filter "touch file || :" HEAD &&
+	git filter-branch --state-branch state -f --tree-filter "exit 1" HEAD &&
 	test_cmp_rev $W HEAD
 '
 
+test_expect_success '--state-branch incremental rewrite uses the rewritten parents' '
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

