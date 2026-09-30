Received: from smtpcmd14161.aruba.it (smtpcmd14161.aruba.it [62.149.156.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCE050255E
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 20:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790800900; cv=none; b=qykrpxujv2sCc4X2/9H725PxX2esk15eXH+nSfHLuDCPKkckQqd338g7ykFc9BcLc/9DPz/s1BSBUec8a5ynexhyixDqD6i8Rkrm65KZbe8PnDRD8rgGuxS92NW8JMZO1cExS5s5hKO1SoWUNK3xRh28ZejugPrGBtKYzM2g2GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790800900; c=relaxed/simple;
	bh=nfGl0NHqGC49TDXmL2I45kYYIU64wc/q8o6Y5j0Q8RU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GVtSIjmwmU+yP3g5D8SNx3/cl2yCxwHx9x6Cilmr6Q5Ioq9X3myemwNJb9sIS+3UC5PNl61hkTobTEsuwZy7uq/8/KtA+iGcqHvacT9LJMFF2AC52V3XGmF8OLrsChVekjIzsUdiB3+USTy0SaAZa5riN2iy+ULuIkVUZzRvTjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=locati.it; spf=pass smtp.mailfrom=locati.it; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=impb+Tfe; arc=none smtp.client-ip=62.149.156.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=locati.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=locati.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="impb+Tfe"
Received: from HP-PCD-007.progesoft.local ([95.227.74.73])
	by Aruba SMTP with ESMTPSA
	id C14KxO8WAd66KC14MxdnD1; Wed, 30 Sep 2026 22:38:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1790800707; bh=nfGl0NHqGC49TDXmL2I45kYYIU64wc/q8o6Y5j0Q8RU=;
	h=From:To:Subject:Date:MIME-Version;
	b=impb+Tfe5r2kAfDhyqyqTrXxKeCl8WWKkUxFMmu7YUGW471vk3xUORVHLhcUkBCBp
	 lv4FqryMsaBEfaJLaf955W+Kekv00wldzR1U9g4Pt50SlW0X769nYAYI6kHyvNyYV8
	 bemdXy4n7eWVZuN8sCcPzESKaredHDvsRKMRpqQYlRFE+mY5pxICAMeYWMAnoj2GFE
	 MWNqgIJRRfeZZ8RI+0KBsKhAIclqBgwJTUT08mMQP1lbr4fasNm1MMKNatpCn8WwAU
	 tgXXCw0WoVrR0x7O3LUtY6q1WlGyD3iWt316aBQ7FzPXJTYCtTasaGUiklDz4AR/Lh
	 zK1jXjlBgts+A==
From: Michele Locati <michele@locati.it>
To: ps@pks.im
Cc: dev@grantmoyer.com,
	git@vger.kernel.org,
	gitster@pobox.com
Subject: Re: [PATCH] fiter-branch: fix commit map init from state branch
Date: Wed, 30 Sep 2026 22:38:22 +0200
Message-ID: <20260930203822.958-1-michele@locati.it>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ar0fRtN8XMG-fyis@pks.im>
References: <ar0fRtN8XMG-fyis@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfJzIi+Jl41yILOAJxNkG8XWj3tdGccm7wZ+zT2yyCSpPfmkPHXMMz3UZFPtyEuahFa6cR/Gld5TORK4QvJRThyWPkmyE+22/6HTQRkrVz4nrri1garh/
 zyKTY6Bewo0fG5df9P4Xhjg1+UW3tjT4Zc6REOm/5q20vMkhUBDIAQEet3DEF7whhJoTyTZvCClDCQpL5CvY+vMLNXnqA4f5/JRPg9wsGla5I+lM9CMaFQQQ
 0cdBd0Nj0YTLg3wGYOq4a2pKS+i+1UvqgYmTjwQ7Y30=

Hi Patrick,

> Michele, it seems like you have already invested some time into
> reproducing the issue. Can this maybe be put into a proper test case
> that directly exercises your issues (that is, the swapped entries and
> such)?

Sure. The test below performs an incremental rewrite in two runs:
the second run must attach the new commit to the parent rewritten by
the first run, and the saved state must contain "original:rewritten"
entries. Without the fix the new commit is attached to the original
parent, and the test fails at test_cmp_rev.

I checked it against master (a018953): it fails without the fix and
passes with it, and the other tests of t7003 still pass. It also
passes with v2.49.1, the last version before the regression.

Grant, feel free to squash it into your patch.

--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -126,6 +126,27 @@ test_expect_success 'using --state-branch to skip already rewritten commits' '
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

Thanks,
Michele
