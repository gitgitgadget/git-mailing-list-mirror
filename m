Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1147A221F12
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769178812; cv=none; b=Q2q2qcH+Rmo+F2/9rg05Pt+Lp5Y2M0/jE2UcpoeWkpOyxUiI3Vzu99VuXRmzpYSwVQbh0CfVl1duwsn3cgMXFYh/OYjRKVZHCGVwMxh5g5TgwkxAxeeGisRKJfUKeHagqjFqhJjoN4YFG5Y25AxbYNvLhW8jrL4PwZPMmDq5uIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769178812; c=relaxed/simple;
	bh=2CbL9DK8GldFm/VlkCSWpsokOUhuvofkf2z5H2jaS6g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZEfYveC/ZS8qgPBd0mxixj3A3RgV5OJbpAICL26gBEVNDLMk1dDdY3vT9VW0CKqGXF+yZp5ssoHK1n3YTwpDCOO9X4MWdKWuimwg32cZyQVMfvMaXixTt7HjFUnuNGizTa/GKngcxs9/4/XIljD7mEhrNAhh7SrMHChVHWcML9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=R1VGxz8k; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="R1VGxz8k"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1769178807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1XXGtfEdP7PuXVB4kbu1que/0T+x0yvwYPEMi8njfcA=;
	b=R1VGxz8kN4ua+HZSLOT8PBYJf/lQERzZ+3rPBgXBPpaLMEWV50+Q5F8G6/J0rpde3j1gRQ
	+/v6vrSzi//PXhz1Z5+Q0KFXjGBpiINvXMrftE56edbjnEZcKB3BF1+pk9hHRlQZiqgCW5
	Wja5L7VxPEVxmUwJBe+tuhZCcDroH/4=
From: Toon Claes <toon@iotcl.com>
Date: Fri, 23 Jan 2026 15:33:02 +0100
Subject: [PATCH v4 2/4] last-modified: fix memory leak when more than one
 revision is given
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-toon-last-modified-tree-v4-2-86bf97bad4e2@iotcl.com>
References: <20260123-toon-last-modified-tree-v4-0-86bf97bad4e2@iotcl.com>
In-Reply-To: <20260123-toon-last-modified-tree-v4-0-86bf97bad4e2@iotcl.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

When more than one revision is given, the function
populate_paths_from_revs() leaks a `struct pathspec`. Plug it.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 builtin/last-modified.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index 7d95244e3f..06e3f79aec 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -123,7 +123,7 @@ static void add_path_from_diff(struct diff_queue_struct *q,
 
 static int populate_paths_from_revs(struct last_modified *lm)
 {
-	int num_interesting = 0;
+	int num_interesting = 0, ret = 0;
 	struct diff_options diffopt;
 
 	/*
@@ -145,16 +145,20 @@ static int populate_paths_from_revs(struct last_modified *lm)
 		if (obj->item->flags & UNINTERESTING)
 			continue;
 
-		if (num_interesting++)
-			return error(_("last-modified can only operate on one revision at a time"));
+		if (num_interesting++) {
+			ret = error(_("last-modified can only operate on one revision at a time"));
+			goto out;
+		}
 
 		diff_tree_oid(lm->rev.repo->hash_algo->empty_tree,
 			      &obj->item->oid, "", &diffopt);
 		diff_flush(&diffopt);
 	}
+
+out:
 	clear_pathspec(&diffopt.pathspec);
 
-	return 0;
+	return ret;
 }
 
 static void last_modified_emit(struct last_modified *lm,

-- 
2.52.0

