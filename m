Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C701F95C
	for <git@vger.kernel.org>; Sun, 11 May 2025 00:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746924052; cv=none; b=E4XFPls0CRjFvfdUIy8bBFmc341yHDUm13jCyo4yFpt7VdcVmKofE5zHVcfMcqijyR8Lk8061vRMgEgMWYimfL1jO+YRHx3iPqKXtZhFiG4mKvslut4GUwLJZ8N4YLvjlm3VlVorwRSrRqx8zF1vyr1/XnWtcIlgRiqfEh3nrY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746924052; c=relaxed/simple;
	bh=Idy4QZBbC0mj7XAn8Suc7yWvXkJUnEJruE3QZLX/Fl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NpAQuZgrFWITEw1SHaPtxI2UC74guobDGH0UOR5vAwqtIPQ7KUUykLvmD0Szg+/o7QYmrA5y/r+C0GRXaIYMjfFFXNBny6PUYaK7yXXnjmVQdGmHwKw0kdGam1TsiQVGWUwxQbItK7YW/Er4SBddy4Ql1Wwdk/4zSRQSINCwzeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev; spf=pass smtp.mailfrom=ameretat.dev; dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b=WoZRl+ot; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="WoZRl+ot"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
	s=default; t=1746924047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VA3kaMFnSZUnRHmlB67rxMgb2F9OOV3shF23+eRrggc=;
	b=WoZRl+otgpQqMZC91SSKe98D+gTescy3aw55dBvV5X3sMjS59MIszEdDSxduU9dUE5K+wu
	gqP+96+F/sfHAipnXWo5ptw9Vtp0FxVk3nI7Xu4DrBmGar3EKgHw6V/M0V9eZbk8BYqfNx
	pQJoorddTi1rfkwMrxPEudhZVlx4TIU=
From: "Raymond E. Pasco" <ray@ameretat.dev>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Jason Cho <jason11choca@proton.me>,
	"aclopte@gmail.com" <aclopte@gmail.com>,
	Ryan Hodges <rhodges@cisco.com>,
	"Raymond E. Pasco" <ray@ameretat.dev>
Subject: [PATCH 4/5] t4140: test apply --intent-to-add interactions
Date: Sat, 10 May 2025 20:36:47 -0400
Message-ID: <20250511003955.242889-5-ray@ameretat.dev>
In-Reply-To: <20250511003955.242889-1-ray@ameretat.dev>
References: <4e2szrowd43w6lrzawqtddamdxvp6ke65jkzmdoru4gjin7xhn@kaqe7skrktgt>
 <20250511003955.242889-1-ray@ameretat.dev>
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
2.49.0.1106.gc0efa3ba58

