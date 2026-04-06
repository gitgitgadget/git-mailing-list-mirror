Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6DD35CB91
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 06:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775457395; cv=none; b=j4xGGXIjLKMDAJETyCHy4Jnd4BYJtAji3pmS5GPSNGC/Ed3/2c6/VCYok2/94Pw75IoYr1ryEX02OXOmq6ujn+7gOSS6FbdV4T7k0BgtgjV5rW8Z7vCKTQClG5lkOWmtp4t88gZSXtt6TVVygnHRx1jx1tjIRtvZJE7bccUtaM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775457395; c=relaxed/simple;
	bh=caXoSYhQ5pIgD1lPmxbkYumDCTlh50uL30W6Dp+K8V4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YE3fSsij4Rl44zy5wVILEuMaVBZcVU4WHNwYKZieYC2TsomIayymPx6uZJ4wMrTPZka/KnE2oAYjdZEzVICQHZpA8yfs5jcRMGio4WVAYc5UeEQRx0aX3ysGI/i1XLS8ElR9quKWNHXbBJ6LAg4j9Tfiqe4x49CNES8agFG+Z8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev; spf=pass smtp.mailfrom=ameretat.dev; dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b=cPpU9fZt; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="cPpU9fZt"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
	s=default; t=1775457391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Fa2ZYBFdLU/AbCyVd4ozjSkT6nyMggwQxt7YlarZ3fA=;
	b=cPpU9fZtmi1kxNboCkP75gX/bu75f33C7ff74znJxnjVnPVNEtydJrBXInhZtzrVfs4yTL
	NRpGtA7TnMcYT0F3PX/3gVBtnyi8ATtEfYTiCLQ8PwBMG4llaQK4MB3lcjkxORlm4AwdTR
	j73yrDMpw+z2fzqNgWMh1oTxixtMXaY=
From: "Raymond E. Pasco" <ray@ameretat.dev>
To: git@vger.kernel.org
Cc: ray@ameretat.dev
Subject: [WIP PATCH] fast-export: emit deletions first
Date: Mon,  6 Apr 2026 02:36:03 -0400
Message-ID: <20260406063607.15353-1-ray@ameretat.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

fast-export chooses its output order by pathname, sorting longer
paths earlier. However, this causes faulty output when the deleted
path is a prefix of the added one. For example, deleting a file 'a' and
creating a file 'a/b' emits:

from :prev_label
M 100644 :blob_label a/b
D a

Fix this by sorting deletions to come before other types of change.

Signed-off-by: Raymond E. Pasco <ray@ameretat.dev>
---

This is a quick and dirty fix for the bug. However, I do want to spend a
little more time on it - it may be that we only want to reverse the sort
when the deletion is specifically the prefix of some addition, and I
want to fence this off with new tests.

 builtin/fast-export.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index b90da5e616..82d73b2f43 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -354,6 +354,12 @@ static int depth_first(const void *a_, const void *b_)
 	int len_a, len_b, len;
 	int cmp;
 
+	/* emit deletions first */
+	int a_deletes = (a->status == DIFF_STATUS_DELETED);
+	int b_deletes = (b->status == DIFF_STATUS_DELETED);
+	if (a_deletes != b_deletes)
+		return b_deletes - a_deletes;
+
 	name_a = a->one ? a->one->path : a->two->path;
 	name_b = b->one ? b->one->path : b->two->path;
 
-- 
2.54.0.rc0.605.g598a273b03.dirty

