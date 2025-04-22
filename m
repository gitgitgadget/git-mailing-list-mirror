Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50A51ACED5
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 17:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745344019; cv=none; b=P3I908Ps1OFv+FL/Wx/HF4d+3oI3hmVNmrs95PX5AYtbRl08EQSMLXLHncW+mLvKMi2hLvpukUkxVHMTt/AdZNzzgbeAYY6yfS0QCU2q1ceBk2hFmXN2i17KmEB5/eH/Fsx4aERRB0xh3UwKR3Hi2LUId9USHiaBeYbp6E/4bFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745344019; c=relaxed/simple;
	bh=TaEoNCPZl6XrnFzaDhHue13edlLc2ZcxwjDTUb0O0As=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=unGrs0DZZfHeIRTDTmaq6Q033mEPTTUIQbb4xYHrQFsrYfDmR9AyxEd7F+BssAuRQ9nDfHy6dvC5PQcHzPSiXpgzF+/64PSVxUzrlhLqwaVyHjCvG54Dl323akvfE0xDR0p03C2zP8deUDcKzjrjGinBDv0Aitbp0O6E50ghN7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=U4KOwgy2; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="U4KOwgy2"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1745344014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g13xwIZ8vZ0kWV4yLvXZzIFa0Y4bh64TOXGGiPdHr5E=;
	b=U4KOwgy2JmuUngtYLcf7rSIxmZHqW7bYf0zPw6hG8qDALbT9e6coTuSeDtFboHcq0kkPe8
	p6+33HsFLfhZoIvgSz+3xjLbs+sb2KtIGc6hPXotaEIaiXIXLcCogl+FLwd6sXPg2OcYyb
	f6HYpmCygKz9Haye+Nzmeg63wl/LcN0=
From: Toon Claes <toon@iotcl.com>
Date: Tue, 22 Apr 2025 19:46:25 +0200
Subject: [PATCH RFC 2/5] t/perf: add blame-tree perf script
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-toon-new-blame-tree-v1-2-fdb51b8a394a@iotcl.com>
References: <20250422-toon-new-blame-tree-v1-0-fdb51b8a394a@iotcl.com>
In-Reply-To: <20250422-toon-new-blame-tree-v1-0-fdb51b8a394a@iotcl.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>, 
 Derrick Stolee <stolee@gmail.com>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

From: Jeff King <peff@peff.net>

This just runs some simple blame-tree's. We already test correctness in
the regular suite, so this is just about finding performance regressions
from one version to another.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 t/perf/p8020-blame-tree.sh | 21 +++++++++++++++++++++
 t/t8020-blame-tree.sh      | 19 ++++++++++---------
 2 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/t/perf/p8020-blame-tree.sh b/t/perf/p8020-blame-tree.sh
new file mode 100755
index 0000000000..6c4c2a369e
--- /dev/null
+++ b/t/perf/p8020-blame-tree.sh
@@ -0,0 +1,21 @@
+#!/bin/sh
+
+test_description='blame-tree perf tests'
+. ./perf-lib.sh
+
+test_perf_default_repo
+
+test_perf 'top-level blame-tree' '
+	git blame-tree HEAD
+'
+
+test_perf 'top-level recursive blame-tree' '
+	git blame-tree -r HEAD
+'
+
+test_perf 'subdir blame-tree' '
+	path=$(git ls-tree HEAD | grep ^040000 | head -n 1 | cut -f2)
+	git blame-tree -r HEAD -- "$path"
+'
+
+test_done
diff --git a/t/t8020-blame-tree.sh b/t/t8020-blame-tree.sh
index c11876c210..6a1db7efaa 100755
--- a/t/t8020-blame-tree.sh
+++ b/t/t8020-blame-tree.sh
@@ -43,7 +43,7 @@ check_blame() {
 }
 
 test_expect_success 'blame recursive' '
-	check_blame --recursive <<-\EOF
+	check_blame -r <<-\EOF
 	1 file
 	2 a/file
 	3 a/b/file
@@ -51,7 +51,7 @@ test_expect_success 'blame recursive' '
 '
 
 test_expect_success 'blame non-recursive' '
-	check_blame --no-recursive <<-\EOF
+	check_blame <<-\EOF
 	1 file
 	3 a
 	EOF
@@ -64,40 +64,41 @@ test_expect_success 'blame subdir' '
 '
 
 test_expect_success 'blame subdir recursive' '
-	check_blame --recursive a <<-\EOF
+	check_blame -r a <<-\EOF
 	2 a/file
 	3 a/b/file
 	EOF
 '
 
 test_expect_success 'blame from non-HEAD commit' '
-	check_blame --no-recursive HEAD^ <<-\EOF
+	check_blame HEAD^ <<-\EOF
 	1 file
 	2 a
 	EOF
 '
 
 test_expect_success 'blame from subdir defaults to root' '
-	check_blame -C a --no-recursive <<-\EOF
+	check_blame -C a <<-\EOF
 	1 file
 	3 a
 	EOF
 '
 
 test_expect_success 'blame from subdir uses relative pathspecs' '
-	check_blame -C a --recursive b <<-\EOF
+	check_blame -C a -r b <<-\EOF
 	3 a/b/file
 	EOF
 '
 
-test_expect_failure 'limit blame traversal by count' '
-	check_blame --no-recursive -1 <<-\EOF
+test_expect_success 'limit blame traversal by count' '
+	check_blame <<-\EOF
 	3 a
+	^2 file
 	EOF
 '
 
 test_expect_success 'limit blame traversal by commit' '
-	check_blame --no-recursive HEAD~2..HEAD <<-\EOF
+	check_blame HEAD~2..HEAD <<-\EOF
 	3 a
 	^1 file
 	EOF

-- 
2.49.0.rc2

