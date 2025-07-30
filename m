Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3922E11DF
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 17:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753898154; cv=none; b=oeLEqUI/IRvVHvklxbRPMKHd9ToHBKOkb39YgK+zBdhEirePPW45S5Gagqk7BQZfVDmQzjDNeiTdGJPPyqAwiXfdoPiuut+6unAZ1Pp24YYcfhPkjyqIxP9SjipMOKYEhD/oxVMWR0RtAhIrmG89wgeCM9f64s80g3E/zXzjuRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753898154; c=relaxed/simple;
	bh=j4xOYGjoVJlqAhsJXeKt1JQrD/KBNnTsSIvhmOFmmBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZoStqv0Pa5XLaMXd4u+AZhRSF/uVaEYz6G3HsN9xyaerR/gueKXHhOVjv9BCeNqqTjC4yT3KzL4fVsbtUsBv3P/5bMCJy+dWS7PtGqnCxb17mm/jFhZdbb1/zu4fW4Hbz7Aym38Itzu0AGOZ0+xi/OBCf191JplC18Ajo+yYrsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=I1MuJHyS; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="I1MuJHyS"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1753898150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kcCzUNv+keHxfgLfiifOdRbXFtD1WBZfONYgofOcmgA=;
	b=I1MuJHySg/FAjH7f9S2u3kKcdjqKjEL7daUqB9qK0fZrk3thJcJ6DPjibRjH46W7737Wj6
	8fYl9SKdpw3mXBCiD021WNoLmrKfvNGyadXYgOIZVaEb6gPj25KSJ6zo2cgme2SbJQz391
	+t7bGizv4lAEbtx6i1FPn97gigxZ9Is=
From: Toon Claes <toon@iotcl.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Taylor Blau <me@ttaylorr.com>,
	Derrick Stolee <stolee@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Toon Claes <toon@iotcl.com>
Subject: [PATCH v6 3/4] commit-graph: export prepare_commit_graph()
Date: Wed, 30 Jul 2025 19:55:09 +0200
Message-ID: <20250730175510.987383-4-toon@iotcl.com>
In-Reply-To: <20250716133206.1787549-1-toon@iotcl.com>
References: <20250716133206.1787549-1-toon@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Allow users of the commit-graph to explicitly prepare the commit-graph.
This can be useful when users want to start using bloom keys before
calling functions like prepare_revision_walk(). We'll use this exported
function in a subsequent commit.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 commit-graph.c | 8 +-------
 commit-graph.h | 8 ++++++++
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index bd7b6f5338..a1f9fc22a4 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -739,13 +739,7 @@ static void prepare_commit_graph_one(struct repository *r,
 	r->objects->commit_graph = read_commit_graph_one(r, source);
 }
 
-/*
- * Return 1 if commit_graph is non-NULL, and 0 otherwise.
- *
- * On the first invocation, this function attempts to load the commit
- * graph if the_repository is configured to have one.
- */
-static int prepare_commit_graph(struct repository *r)
+int prepare_commit_graph(struct repository *r)
 {
 	struct odb_source *source;
 
diff --git a/commit-graph.h b/commit-graph.h
index 78ab7b875b..0f76681333 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -131,6 +131,14 @@ struct repo_settings;
 struct commit_graph *parse_commit_graph(struct repo_settings *s,
 					void *graph_map, size_t graph_size);
 
+/*
+ * Return 1 if commit_graph is non-NULL, and 0 otherwise.
+ *
+ * On the first invocation, this function attempts to load the commit
+ * graph if the_repository is configured to have one.
+ */
+int prepare_commit_graph(struct repository *r);
+
 /*
  * Return 1 if and only if the repository has a commit-graph
  * file and generation numbers are computed in that file.
-- 
2.50.1.327.g047016eb4a

