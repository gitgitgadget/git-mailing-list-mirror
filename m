Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EB01862
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 14:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769783220; cv=none; b=p3bNpcPxClvXXcOjCAs0t0ZeTzNCU3at7A+c0o/G3joPZ3Opv+CGf9VMVgZ3QcGs/RA0PhhmXotzi0xmQ/K3+Tyd6UhorRUbCgwv8J+znUnHy9Wi1g9X9ZHdaNDI2EMAOmx6KCTNrls7tOnL9RwqeUemX0ghNR0r38Vqk7hPVFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769783220; c=relaxed/simple;
	bh=kokY0ancjTX2/uU+qXMPGS+ThLRi3bWdCcRX6Tg1na4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NUxrKJn1iWCIJzAvwV/o5QR7u2aWQlXqJ+gwX4FQVjvVgoRyed9CDVrxcqLzE5WtYSWYdxxG4eJZVEJr2v06vs1idj1FiQlPNn6FKLmyYYUOvysCcz8fwULV2ByZS4IXCfNQt4MFR4bhVra3/KZBZWTWg4Qwc+7c0VBv5L7FkLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=jwRcer5t; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="jwRcer5t"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1769783216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2wQhsrQ2Av1j5rCf4LWHgGHxzjM6pQn09INiIwachRM=;
	b=jwRcer5t3yRJDswLPRFHOWXPlWUSE0JqRCFomgEY0Y7bwSBvbgZADhQ4zyqtQTrM+iVz1E
	XSkaNa5BngPrXnfIaHgxnYQxhoYkFX8UvfOmMlX/6UBUYNu58ohnOwm2WSEWz18MdG1Z9L
	5rdCfnMv9RVnvD1AyrsCc1P+BwIqadk=
From: Toon Claes <toon@iotcl.com>
Date: Fri, 30 Jan 2026 15:26:35 +0100
Subject: [PATCH v6 1/4] last-modified: rewrite error message when more than
 one commit given
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260130-toon-last-modified-tree-v6-1-db827e5df985@iotcl.com>
References: <20260130-toon-last-modified-tree-v6-0-db827e5df985@iotcl.com>
In-Reply-To: <20260130-toon-last-modified-tree-v6-0-db827e5df985@iotcl.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Gusted <gusted@codeberg.org>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

When more than one commit is passed to the git-last-modified(1) command,
this error message was printed:

    error: last-modified can only operate on one tree at a time

Calling these a "tree" is technically not correct. git-last-modified(1)
expects revisions that peel to a commit.

Rephrase the error message to:

    error: last-modified can only operate on one commit at a time

While at it, modify the test to ensure the correct error message is
printed.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 builtin/last-modified.c  |  2 +-
 t/t8020-last-modified.sh | 11 ++++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index c80f0535f6..1219f6802e 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -146,7 +146,7 @@ static int populate_paths_from_revs(struct last_modified *lm)
 			continue;
 
 		if (num_interesting++)
-			return error(_("last-modified can only operate on one tree at a time"));
+			return error(_("last-modified can only operate on one commit at a time"));
 
 		diff_tree_oid(lm->rev.repo->hash_algo->empty_tree,
 			      &obj->item->oid, "", &diffopt);
diff --git a/t/t8020-last-modified.sh b/t/t8020-last-modified.sh
index 50f4312f71..d1aad12319 100755
--- a/t/t8020-last-modified.sh
+++ b/t/t8020-last-modified.sh
@@ -12,10 +12,6 @@ test_expect_success 'setup' '
 	test_commit 3 a/b/file
 '
 
-test_expect_success 'cannot run last-modified on two trees' '
-	test_must_fail git last-modified HEAD HEAD~1
-'
-
 check_last_modified() {
 	local indir= &&
 	while test $# != 0
@@ -230,9 +226,14 @@ test_expect_success 'last-modified merge undoes changes' '
 	EOF
 '
 
+test_expect_success 'cannot run last-modified on two commits' '
+	test_must_fail git last-modified HEAD HEAD~1 2>err &&
+	test_grep "last-modified can only operate on one commit at a time" err
+'
+
 test_expect_success 'last-modified complains about unknown arguments' '
 	test_must_fail git last-modified --foo 2>err &&
-	grep "unknown last-modified argument: --foo" err
+	test_grep "unknown last-modified argument: --foo" err
 '
 
 test_done

-- 
2.53.0.rc1.267.g6e3a78c723

