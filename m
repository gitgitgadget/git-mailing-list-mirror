Received: from mx-out2.startmail.com (mx-out2.startmail.com [145.131.90.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F169C2DA768
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 03:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.131.90.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785555547; cv=none; b=LpZ4gHi5heJA4qnM1Fa1Q4GTgRKaSFp4pNLMVbKH/qzfUb0nXorJ2zv9ufWazFAUtOkv19Ah7g0Obo2xxvr2i3Z/dUw+yzxblbKSpZVAd01UaBFcqSfUWFY9eOfGrmffgedJJ4dbN7MV8/WHXOEY1zhlB7ms0g0j+ePy50jLZb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785555547; c=relaxed/simple;
	bh=GnY82xREcO01EIMBY63kU81LXs6fj/A5uCIwHJgPKbc=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version; b=F2Ydktyfw+o8Gp6FLyG6DsTRHSt41cpoNn6h/MxkRTFAlsuPl0j+esXt+bmHn0S3zQrg4YeV0jfE7vp9nO26M/xmzjs9e4u3DB60ScJyeIb/oCKHrAIRICLyY/ijQmhzUS2oPeJCl2bilyjDeVTLgZ4p9Fgou4JpkzzzYDvORlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grantmoyer.com; spf=pass smtp.mailfrom=grantmoyer.com; dkim=pass (2048-bit key) header.d=startmail.com header.i=@startmail.com header.b=Ic6lbBrE; arc=none smtp.client-ip=145.131.90.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grantmoyer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grantmoyer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=startmail.com header.i=@startmail.com header.b="Ic6lbBrE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
	s=2020-07; t=1785555113;
	bh=4shntbzfo+KNRpTfKku3aG2rZHqaeaIi7mx7y0oD3GM=;
	h=From:To:Subject:Date:Message-ID:Mime-Version:
	 Content-Transfer-Encoding:From:Subject:To:Date:Sender:Content-Type:
	 Content-Transfer-Encoding:Content-Disposition:Mime-Version:
	 Reply-To:In-Reply-To:References:Message-Id:Autocrypt;
	b=Ic6lbBrE3witeO880VYmHGubP8CiUzqM8cgaTdZGrDkZOeLninJ8IvS0Ton1ZKfct
	 mxLQsXbQ22ovugBld12AeYgqNTF72n3voSUpuAtLB+f3htc4xea9pjke5TipjFCZ6Q
	 QG+PcB8gsmPK1jFntu9XmJHwovnoOqYjtBV/jP3FiGRPlux8M4IBpaF+mgBz9foxyp
	 Q6zMBYnYL2ieaTshhfmMRYg1bHSKqzQaUaDS8CrOXm15NqxENm0X4w/KHMC3XqHFop
	 L3tm3TYDc6ii2/F/qYZ/oq8NXP1taJS/jMF3w551nCB4nyRiZzjRoerY0AwEDpP+Aq
	 DF85qHfanqbAQ==
From: Grant Moyer <dev@grantmoyer.com>
To: git@vger.kernel.org
Cc: Grant Moyer <dev@grantmoyer.com>
Subject: [PATCH] fiter-branch: fix commit map init from state branch
Date: Fri, 31 Jul 2026 23:31:27 -0400
Message-ID: <20260801033127.10606-1-dev@grantmoyer.com>
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
"from_commit:to_commit" format.

Signed-off-by: Grant Moyer <dev@grantmoyer.com>
---
 git-filter-branch.sh     | 4 +++-
 t/t7003-filter-branch.sh | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

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
index 86011e7b1f..3934cc4a11 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -121,7 +121,7 @@ W=$(git rev-parse HEAD)
 test_expect_success 'using --state-branch to skip already rewritten commits' '
 	test_when_finished git reset --hard $V &&
 	git reset --hard $V &&
-	git filter-branch --state-branch state -f --tree-filter "touch file || :" HEAD &&
+	git filter-branch --state-branch state -f --tree-filter "exit 1" HEAD &&
 	test_cmp_rev $W HEAD
 '
 

base-commit: a97fcc37c2bc6340a8d7ce78dedf227aac4e9aa7
-- 
2.55.0

