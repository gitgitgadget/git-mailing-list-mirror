Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2507D376BCB
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 10:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768386311; cv=none; b=qx4vou6swCaBcNwttD0txBKAaWFz8fzXfdmJhDn+aCsQHo/VExX7l/I8CWQzXW4lLhWIlL+udNJHwRpmR/9TV4/+S9tgZdW9Vm2ANTxU8E+UMIZF0MwLI2PHK7eb5bm36tZDVcvHQNEkDnRt2pWM+OGRq7oj7snrkwjtj616TRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768386311; c=relaxed/simple;
	bh=eXTIpgU5sFp9KiKON3UKOzNpuQ3fcekFuEmy4e1sPmM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hz23yUIPoj2un83V3WmtUihl4VcKxqn7GOKfaTcmbuAme1cqHwk6ahZZUUKe/GFezYvLA0SXxTNnf9Yh43cN0ifMo5R2s9yOmSsOAZXsyzY61W47+O8wLLmq0SSxYL6EzcPj+NYBKJsEbVQUOx7QNt1bkHhONLmwm9MWODK+nRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=vRFUbcly; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="vRFUbcly"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1768386304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8fsEixiPbCMB6icwDG3ivaUrKO/gYxTA7wdNMv8IKX0=;
	b=vRFUbclyQ7UVJJJx3qoy3aVEqMAmiDUmNK3WpdL/on47Fe0o8N2bKeH9bDeJQBV0K6qRYo
	EWyEJmX9B52kMdAbjw/X2iteNgfaRnyKWbBHBwyH4FsPLlJQC/ks8V43U8YY7BSPfEGo1P
	vTIcSaEE0Aw5Vjy3o2Acr73tkExpzvQ=
From: Toon Claes <toon@iotcl.com>
Date: Wed, 14 Jan 2026 11:24:46 +0100
Subject: [PATCH v2 2/3] last-modified: remove double error message
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-toon-last-modified-tree-v2-2-ba3b1860898f@iotcl.com>
References: <20260114-toon-last-modified-tree-v2-0-ba3b1860898f@iotcl.com>
In-Reply-To: <20260114-toon-last-modified-tree-v2-0-ba3b1860898f@iotcl.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Toon Claes <toon@iotcl.com>
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

