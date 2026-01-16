Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1601096F
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 13:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768568939; cv=none; b=CfMt0b2AVcyDs8jn6ef4F3ZYC1jyZ1cxjVAS4W9iTZlajPRhQ8Y5SfZ11NZEPqxY9S7FmnDiweoE8FcDMomI2cGldRMOSWhCqUI7zsNte7miysErNy6PdFIoz/fNceahAWjsDZL+i0dUrj4JeaU9aG6X6jMz7Al4c7yccK2a9Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768568939; c=relaxed/simple;
	bh=FVxPkOKB9Uj6gRT4dKFPRFvJ7MFfO4xrqvlV025t8e0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nJLDrdSADEFjFyyx3gIHuNmT8N3xEBhICNuc4GPUjTfLokSQGYhzyfKkd40F/8pCQdpzecmBeQc2+CAUpmEUiZO41oOnwOANbCr2ipfxUKOcBwrUulTADPSR1M2cKcd/Ag/IdxO0GEKY5WEXguJ5ut0qeEL5L4dIbozytwgfHzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=mly2Hr0i; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="mly2Hr0i"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1768568935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bbwY0pezClDms2+iHANHAXDYKnCcie6Ue6KsbxV8ZjA=;
	b=mly2Hr0i7kYEBFBt/yzaNPlK8Y0L9PuyPA9dGeYg5XYF6PFhu4egaOCwdrzP7Vbv0T84Be
	yv2e5hHhRd569baFDgnSn8HGH6/3Ad09Om8p8WZ6zMdeKK7Gv+qlyfpJmd8VBxjU6j8w4N
	tFksOupl18qOTCH1S20Pl5hXGQoi60s=
From: Toon Claes <toon@iotcl.com>
Date: Fri, 16 Jan 2026 14:08:37 +0100
Subject: [PATCH v3 1/4] last-modified: rewrite error message when more than
 one revision given
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-toon-last-modified-tree-v3-1-e6ade4dc35ab@iotcl.com>
References: <20260116-toon-last-modified-tree-v3-0-e6ade4dc35ab@iotcl.com>
In-Reply-To: <20260116-toon-last-modified-tree-v3-0-e6ade4dc35ab@iotcl.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Toon Claes <toon@iotcl.com>, Gusted <gusted@codeberg.org>
X-Migadu-Flow: FLOW_OUT

When more than one revision is passed to the git-last-modified(1)
command, this error message was printed:

    error: last-modified can only operate on one tree at a time

Calling these a "tree" is technically not correct. git-last-modified(1)
expects revisions that peel to a commit.

Rephrase the error message to:

    error: last-modified can only operate on one revision at a time

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 builtin/last-modified.c  | 2 +-
 t/t8020-last-modified.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index c80f0535f6..7d95244e3f 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -146,7 +146,7 @@ static int populate_paths_from_revs(struct last_modified *lm)
 			continue;
 
 		if (num_interesting++)
-			return error(_("last-modified can only operate on one tree at a time"));
+			return error(_("last-modified can only operate on one revision at a time"));
 
 		diff_tree_oid(lm->rev.repo->hash_algo->empty_tree,
 			      &obj->item->oid, "", &diffopt);
diff --git a/t/t8020-last-modified.sh b/t/t8020-last-modified.sh
index 50f4312f71..1183ae667b 100755
--- a/t/t8020-last-modified.sh
+++ b/t/t8020-last-modified.sh
@@ -12,7 +12,7 @@ test_expect_success 'setup' '
 	test_commit 3 a/b/file
 '
 
-test_expect_success 'cannot run last-modified on two trees' '
+test_expect_success 'cannot run last-modified on two revision' '
 	test_must_fail git last-modified HEAD HEAD~1
 '
 

-- 
2.52.0

