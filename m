Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521C61096F
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 13:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768568951; cv=none; b=RB0kkvtpC7FQ+dWNL2IUbQMUjz0GHfuh7mnCqEjYt5JOXl8IiUaTmwdLTMztjNwi5uPF6U4ouflaHstwZ4JyOp0tGSyEb6gViE38GjGrZpjjmnrOQP/Pzp5ahCof+9famjaaEJwyph5Dew7Khl/+Alh6hwvHsBnSBCgIMCf7RPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768568951; c=relaxed/simple;
	bh=2CbL9DK8GldFm/VlkCSWpsokOUhuvofkf2z5H2jaS6g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A2l8yswK4zZHhief5/9m1Fdm9fJWneKFN29uV5QlhAhgLvQ5tzlf4S8MrFkQ1LyxcfLK29OBWzD93IsoiW8Y8QyxZzq40Hh8Xc0T0SdOWeAWQ+AC97i5UuQThVO2iBKQf2vENS/B+TBSz/4b3+urwaIL8SWD6e178RllIjO6VEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=JBN1sTki; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="JBN1sTki"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1768568947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1XXGtfEdP7PuXVB4kbu1que/0T+x0yvwYPEMi8njfcA=;
	b=JBN1sTkibuve31UyYu93essdgRiEMyoES89J+KbXSUUWE897Uod8XMZywJ2AQ1xNRAqU0w
	8N4HKzhWX5+qujLk4/83PTqFxifglKZ6YgK9tDFgfChF1TCzRE9cLT+i46C+AvRGgXb3YZ
	rjxkoCOrGBjyxVR3OXkHLEdM1eqFG5g=
From: Toon Claes <toon@iotcl.com>
Date: Fri, 16 Jan 2026 14:08:38 +0100
Subject: [PATCH v3 2/4] last-modified: fix memory leak when more than one
 revision is given
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-toon-last-modified-tree-v3-2-e6ade4dc35ab@iotcl.com>
References: <20260116-toon-last-modified-tree-v3-0-e6ade4dc35ab@iotcl.com>
In-Reply-To: <20260116-toon-last-modified-tree-v3-0-e6ade4dc35ab@iotcl.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Toon Claes <toon@iotcl.com>, Gusted <gusted@codeberg.org>
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

