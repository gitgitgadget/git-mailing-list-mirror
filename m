Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C66A356A04
	for <git@vger.kernel.org>; Tue, 27 Jan 2026 13:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769520396; cv=none; b=TqMR884YdZNUcDrD+HrCfna+DtRwRZ6n2l6tP6JFpe7lOBzCvMVm/VBG2H7k0594hmeQhHyvEs7ydCPBj7HKsVb387ngpWKMZVxeU5D828ypLOcq9875swcuyo4CSiQcZKDW3utCPXitfSh0hjAHDkoKPvj04pI0qORmAU7Ui6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769520396; c=relaxed/simple;
	bh=kokY0ancjTX2/uU+qXMPGS+ThLRi3bWdCcRX6Tg1na4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tgTry6w/7IP2rCYK7oXiAkbiItB52ufNzinoibynTU262OjXtlW91cQ5cOv13Wo0ndlg+3/mlWR5a54yfIiFoNTk9CB0wlWUYb3ddWsqpn9dPFgtZnwfPEWeaGWkFF657cAPr9y9C8jX3Om3LKiuY2xJ84O9TacTJgLHaX/fQ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=ZViP6FAe; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="ZViP6FAe"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1769520392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2wQhsrQ2Av1j5rCf4LWHgGHxzjM6pQn09INiIwachRM=;
	b=ZViP6FAeduFIcpFIiy9/3tPHVKNUY7ICU+Kxt2YVICCbdIlx7zIgPk9S3WCBxK104S4BiK
	Zy9QbBAOdNMmlOHfqau1hYuvxmvh68goUgWhc4iKdYI3mljEd5uln/FCk7cCT1po1PtQZn
	03DrFOk0ifOZh9yylY9o+W+0mNj83Gk=
From: Toon Claes <toon@iotcl.com>
Date: Tue, 27 Jan 2026 14:26:17 +0100
Subject: [PATCH v5 1/4] last-modified: rewrite error message when more than
 one commit given
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-toon-last-modified-tree-v5-1-38d18a0956d4@iotcl.com>
References: <20260127-toon-last-modified-tree-v5-0-38d18a0956d4@iotcl.com>
In-Reply-To: <20260127-toon-last-modified-tree-v5-0-38d18a0956d4@iotcl.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Toon Claes <toon@iotcl.com>, Gusted <gusted@codeberg.org>
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

