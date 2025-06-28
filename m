Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4229241664
	for <git@vger.kernel.org>; Sat, 28 Jun 2025 23:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751151603; cv=none; b=WqJbuum5tM+QieaB0C1gRrVp283tvx8sx1QVm/oKzk+uzFvdmCZBvhtXSEFNUEFE0bs6aNS+iYIYtfj6tIctkrtxJiqhMgJr7OB4WBog5zIPtHSyc7uqk4nu5jaVWzRqOYCXfBRtfHqphazSv6DOn1c++heuVQLt679hsp3fbls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751151603; c=relaxed/simple;
	bh=yKGccAu7RUqd4stMSRIPWLy2extykAZSYj/66LfsBOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gt+JPdgP+xiE+6j93ouromJos2YP5dtSKUQQqG+u+tdfl0nvhQQ3ATzlYJtc/rvnF18f08yehbRmatOf4ZFKu18KQT1TDV3Fz5xbRnfT5WRBEErA2FzIirDyew4k1Ea51aTO1Vg4x9PmS7gIawE4Bf4M5Tpl+qQfC4GMrUBqfp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev; spf=pass smtp.mailfrom=ameretat.dev; dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b=cyY9gG68; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="cyY9gG68"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
	s=default; t=1751151598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NZHxdHeChwgabcI9i6b41LU4iLLPzTMEPj3NXNxPyNk=;
	b=cyY9gG68g7iv5qq8IhPwVTI0yu79WO6L/7tQCAGGHpvL3cXLcu7aV+XCyf8ro1iDI5PQc6
	kUbGBw2uHChjl3Q9sf4JzPKvZf2oceaCpt/671BAIiMe8mV5McGE7hUcnRnZzZJa9R90Y3
	xhtMV+HFJZZNA50FTSK76J0rtCPJJxA=
From: "Raymond E. Pasco" <ray@ameretat.dev>
To: git@vger.kernel.org
Cc: "Raymond E. Pasco" <ray@ameretat.dev>
Subject: [PATCH 4/5] t4140: test apply --intent-to-add interactions
Date: Sat, 28 Jun 2025 18:52:06 -0400
Message-ID: <20250628225819.1294068-6-ray@ameretat.dev>
In-Reply-To: <20250628225819.1294068-2-ray@ameretat.dev>
References: <20250628225819.1294068-2-ray@ameretat.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Test that applying a new file creation patch to an existing index works,
and that applying a patch with both modifications and new file creations
works.

Signed-off-by: Raymond E. Pasco <ray@ameretat.dev>
---
 t/t4140-apply-ita.sh | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/t/t4140-apply-ita.sh b/t/t4140-apply-ita.sh
index c614eaf04c..c664209c41 100755
--- a/t/t4140-apply-ita.sh
+++ b/t/t4140-apply-ita.sh
@@ -7,6 +7,10 @@ test_description='git apply of i-t-a file'
 test_expect_success setup '
 	test_write_lines 1 2 3 4 5 >blueprint &&
 
+  cat blueprint >committed-file &&
+  git add committed-file &&
+  git commit -m "commit" &&
+
 	cat blueprint >test-file &&
 	git add -N test-file &&
 	git diff >creation-patch &&
@@ -14,7 +18,14 @@ test_expect_success setup '
 
 	rm -f test-file &&
 	git diff >deletion-patch &&
-	grep "deleted file mode 100644" deletion-patch
+	grep "deleted file mode 100644" deletion-patch &&
+
+	git rm -f test-file &&
+	test_write_lines 6 >>committed-file &&
+	cat blueprint >test-file &&
+	git add -N test-file &&
+	git diff >complex-patch &&
+	git restore committed-file
 '
 
 test_expect_success 'apply creation patch to ita path (--cached)' '
@@ -53,4 +64,22 @@ test_expect_success 'apply deletion patch to ita path (--index)' '
 	git ls-files --stage --error-unmatch test-file
 '
 
+test_expect_success 'apply creation patch to existing index with -N' '
+  git rm -f test-file &&
+  cat blueprint >index-file &&
+  git add index-file &&
+  git apply -N creation-patch &&
+
+  git ls-files --stage --error-unmatch index-file &&
+  git ls-files --stage --error-unmatch test-file
+'
+
+test_expect_success 'apply complex patch with -N' '
+  git rm -f test-file index-file &&
+  git apply -N complex-patch &&
+
+  git ls-files --stage --error-unmatch test-file &&
+  git diff | grep "a/committed-file"
+'
+
 test_done
-- 
2.50.0.195.g74e6fc65d0

