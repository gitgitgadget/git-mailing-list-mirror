Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E0B26CE18
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 21:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751491722; cv=none; b=Kt9dPdVeQYNHepcOJnDc8OGskjmOF1/CyWApHbZgrQfhr1g2EjuuaJi6Uig5WpLiLDUXNIdKjce+CUFuxiv7BG/Xh5PY9kwso4QGMV2+qIxCfyFVgnhiMD147iVeBa0VKxZFbgQubIFO1oeAUDziV6mU+5Hzifwr70O+IuAgxTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751491722; c=relaxed/simple;
	bh=vMkKRboLODMcWxD9x3zz02pj/UJ6cyZU0KCa7DX0HD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1v9qJECoYZT8dg3pteeY8TCctMamfezdwVu44HXERje3TkSLUvSV0UDWhOR6LbhVu71IXVt9SsaXZhQG//t05+pivOMZURWweaHFkzbCq4e9+DsZOlzpVdG4Mb+9z/ZFcR0S7qEmSPeALdeABQ8JIEgxhM0BPvERtAsQS435LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev; spf=pass smtp.mailfrom=ameretat.dev; dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b=VFJG55YW; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="VFJG55YW"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
	s=default; t=1751491717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r3Y+kRTLH7PK0j7r55CbC9Kh1PxnCxrPSuKNjhXlfUo=;
	b=VFJG55YW8X3NjQ/JrHaLPWtAhAVnO7dPPC4iUzh9gjDSVmGQHeqZCHZoAf8cX9Rb3FEtv9
	J1WU8HdDrXWWEul6Rp0MFpjSb/+91c+31dauw+0DX8uwBfoJIhN3kuodjMNrXzod85FNBW
	FV+3aSlTX1CwKEPCsLCBTID+Iiulrvw=
From: "Raymond E. Pasco" <ray@ameretat.dev>
To: ray@ameretat.dev
Cc: aclopte@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	jason11choca@proton.me,
	kristofferhaugsbakk@fastmail.com,
	rhodges@cisco.com
Subject: [PATCH v2 3/4] t4140: test apply --intent-to-add interactions
Date: Wed,  2 Jul 2025 17:26:46 -0400
Message-ID: <20250702212814.1923253-4-ray@ameretat.dev>
In-Reply-To: <20250702212814.1923253-1-ray@ameretat.dev>
References: <20250628225819.1294068-2-ray@ameretat.dev>
 <20250702212814.1923253-1-ray@ameretat.dev>
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
index c614eaf04c..0b11a8aef4 100755
--- a/t/t4140-apply-ita.sh
+++ b/t/t4140-apply-ita.sh
@@ -7,6 +7,10 @@ test_description='git apply of i-t-a file'
 test_expect_success setup '
 	test_write_lines 1 2 3 4 5 >blueprint &&
 
+	cat blueprint >committed-file &&
+	git add committed-file &&
+	git commit -m "commit" &&
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
+	git rm -f test-file &&
+	cat blueprint >index-file &&
+	git add index-file &&
+	git apply -N creation-patch &&
+
+	git ls-files --stage --error-unmatch index-file &&
+	git ls-files --stage --error-unmatch test-file
+'
+
+test_expect_success 'apply complex patch with -N' '
+	git rm -f test-file index-file &&
+	git apply -N complex-patch &&
+
+	git ls-files --stage --error-unmatch test-file &&
+	git diff | grep "a/committed-file"
+'
+
 test_done
-- 
2.50.0.201.gfeb04032fb

