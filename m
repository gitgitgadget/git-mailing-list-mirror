Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12BA1862
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 14:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769783226; cv=none; b=SliSikV8666JnTu+l+6rAy+JjucRhrxyJYUVfQwGoWtS9DsBrEwoBti8k7wGT2T8Ezw94iblw/tFwrcxzUOstv8gv7IowAmBC77rumxXeI6CFXFsnI2tkFjWZUTpcc9VJIpbQ+oxX9vhLxOH5cmZ9uX+nK6XvgB72IsFPIJQGqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769783226; c=relaxed/simple;
	bh=vRCswNY9qcE71llc9H+4G0q0MmeowPpqMESsu0iMMoU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kwA4ppLjPR4O1FibA5Iqop2wSxo6D+sWwbe0uZn8y877BUgIV2ficIaWBMVOishE22Wi2QvHcWt+eG2ASbVfIpY7Aci1TD/doFYZbsrbiD4AlOMK+92bRqstvBHyMn9K8kxhVgYLuEw8QedvzkC4K1JGi3vgeQMjDOYwhte9B/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=WIkbwXym; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="WIkbwXym"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1769783223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fmfL8mEQ0l07MYbh3D1J9od3sFxsf0IrGgxibS+h72o=;
	b=WIkbwXymZGLtqB1r99USTzSU21MxJQJVzASnlyE/TokIEQnhPu8+IkIfgdle87rx4UsSoy
	PGWK6rJ/Fhbkz+NykcSOU+xIO/foDDrSQpM3dbTKuRhaAAz0+7ds33yxoXpVLvA1eAJo7f
	fW7i5pcRtFQLdGnrEbLADQWfqITO+gU=
From: Toon Claes <toon@iotcl.com>
Date: Fri, 30 Jan 2026 15:26:36 +0100
Subject: [PATCH v6 2/4] last-modified: fix memory leak when more than one
 commit is given
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260130-toon-last-modified-tree-v6-2-db827e5df985@iotcl.com>
References: <20260130-toon-last-modified-tree-v6-0-db827e5df985@iotcl.com>
In-Reply-To: <20260130-toon-last-modified-tree-v6-0-db827e5df985@iotcl.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Gusted <gusted@codeberg.org>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

When more than one commit is given, the function
populate_paths_from_revs() leaks a `struct pathspec`. Plug it.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 builtin/last-modified.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index 1219f6802e..31dea975a0 100644
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
-			return error(_("last-modified can only operate on one commit at a time"));
+		if (num_interesting++) {
+			ret = error(_("last-modified can only operate on one commit at a time"));
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
2.53.0.rc1.267.g6e3a78c723

