Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2E13570CA
	for <git@vger.kernel.org>; Tue, 27 Jan 2026 13:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769520402; cv=none; b=euUfN7RlDSHHifWQiHn4G4u7Ifrc/ERwm52s60TY+qTBam0VXJcuLfEplsxRAYX7zjbRhQ2rB5IzoSc3KqzdkA8LZ326Ci4oVF3rAdXUUpIULvthRpAEJe6diJ7XYkGSQ8UTAd7r0InxOB0sjaAOje1fapOAAmS85lJqCKq1J8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769520402; c=relaxed/simple;
	bh=Drj87lI+hoo4ihbsoNsdFiwTsQ6lXcn4tkaXKUM3MJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lki97B5PoH0OgC94uuTD+SPmnnIGpcRBaHdyNCDwdU4m64ahKZjcHtQntjttspDC4T+IMe8bMgfnCZcpmHhbyxCE9JJOftQKEt59Xznh8b6c5YTsJAEB6LWS9Y8SZF8WMju17lr9kTMd60f/yqZs5LCzxW7UbnQMDxQuB7XNp9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=V2Yzqc67; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="V2Yzqc67"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1769520399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=07k04mZU+M+Luh0uaJHvkP4Q+LR+smP4fKTXg0bpUOc=;
	b=V2Yzqc67NGxOqgkDGIsjaQzbQvy20lkIeM8P+EP5yvWHZDK2gr8BQN4ij374z+2+zZIRAh
	bStFv+SvIVMpZM2kBYe/Q7rPb0sS7JIY2bKRWmo+Xb6QfuRSWE66G6CgSfW3lIaXBn1C0c
	J2cEuom+Fw7/o1tpggSPNl1dMhXnZI4=
From: Toon Claes <toon@iotcl.com>
Date: Tue, 27 Jan 2026 14:26:19 +0100
Subject: [PATCH v5 3/4] last-modified: remove double error message
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-toon-last-modified-tree-v5-3-38d18a0956d4@iotcl.com>
References: <20260127-toon-last-modified-tree-v5-0-38d18a0956d4@iotcl.com>
In-Reply-To: <20260127-toon-last-modified-tree-v5-0-38d18a0956d4@iotcl.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Toon Claes <toon@iotcl.com>, Gusted <gusted@codeberg.org>
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
index 31dea975a0..e02ec8428b 100644
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
2.53.0.rc1.267.g6e3a78c723

