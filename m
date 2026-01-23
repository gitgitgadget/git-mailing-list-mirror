Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F8F2BEFE1
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769178814; cv=none; b=Vp/KFvjL6B2bjOVxrmpIhU4Z/O65556XWye2S7rODOZSd73Ossfhww8tu7DRk6j+QoVhdxIrlKZ9/wjPvzkNtKOGstPyPIyhn9naYwBPTS+Ebrd8O0qYA8VVBIm/wbWQlJfenUCOZFuaX70xVCjX+v+boIHrjg+hdger3pkRpD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769178814; c=relaxed/simple;
	bh=eXTIpgU5sFp9KiKON3UKOzNpuQ3fcekFuEmy4e1sPmM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Np7lDLrvZ6M21elUh56hXLjubeSYNswwfF7R7qxAzQLhnT4kRzN/Rv0UB5MDA5RlxRWP5Vaqt2iCEzasOKxbd0wduQU4lA1Km+AFyaixGD9OSckCTbCvjD5vQeG7+Bib4twRWBoASuL58sBmmsW2hqnKVP2HwVHQW5bKd99lCy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=R7uZkaJR; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="R7uZkaJR"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1769178810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8fsEixiPbCMB6icwDG3ivaUrKO/gYxTA7wdNMv8IKX0=;
	b=R7uZkaJRQaJ2lrTO6RGwqfWsdLwRVVbTdLNrMnu1GeaukVmY40mktfPG0JdU93yPFlJO9A
	KRVHBnnv4cEuFfKCKOrc4dUGcDzYbzJv0vD2Bagnmsxmdw4xhx53JNjPTKCS4XEo+WEMIR
	LrKPc2l0rZbgeN420Z9P4X1X4UPafy8=
From: Toon Claes <toon@iotcl.com>
Date: Fri, 23 Jan 2026 15:33:03 +0100
Subject: [PATCH v4 3/4] last-modified: remove double error message
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-toon-last-modified-tree-v4-3-86bf97bad4e2@iotcl.com>
References: <20260123-toon-last-modified-tree-v4-0-86bf97bad4e2@iotcl.com>
In-Reply-To: <20260123-toon-last-modified-tree-v4-0-86bf97bad4e2@iotcl.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

When the user passes two revisions, they get the following output:

    $ git last-modified HEAD HEAD~
    error: last-modified can only operate on one revision at a time
    error: unable to setup last-modified

The error message about "unable to setup" is not very informative,
remove it.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 builtin/last-modified.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index 06e3f79aec..0df85be318 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -495,7 +495,7 @@ static int last_modified_init(struct last_modified *lm, struct repository *r,
 	lm->rev.bloom_filter_settings = get_bloom_filter_settings(lm->rev.repo);
 
 	if (populate_paths_from_revs(lm) < 0)
-		return error(_("unable to setup last-modified"));
+		return -1;
 
 	CALLOC_ARRAY(lm->all_paths, hashmap_get_size(&lm->paths));
 	lm->all_paths_nr = 0;

-- 
2.52.0

