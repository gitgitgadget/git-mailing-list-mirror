Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E246214A8F
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 20:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743020396; cv=none; b=FwoN2xMBXSG6vTOVzEh93t8eW8kRdkLUH62i53S5qI5vgR5IsMVkMSXYp0ubIzMA/BdKNkrvEtGT29/pgI7PtcGbuFOrlSn6L489tTCP2kEL4XSY65jDqResCq0f21VFAZjCXGK3qdH/RyJXZG094oDu8jye2rEC1nWHSVJHT14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743020396; c=relaxed/simple;
	bh=g7G5U0ib82y4oTPSle8iKL8Mj8IzRt5eLSqCBaOiG44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e/h7cWDZN6pPAh98xQSg51cagpgMfjCU8EEO9y261n+/7TRFqj2uL0G1zr/WyE3+G+XeZsagvflq/LDJjLYqnpeGa880e/+xUKM6GTlUESM9nzO8/d5Q5KcCSW1lznf7i5pzYhugjsveB4Q709McHoDlwZJ6xbmY+71tHzUkCf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=V+8/4vhg; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="V+8/4vhg"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1743020392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=77bAUie27+ANIS2Evl6uua+NwfDNh6OrEC9u7U29vpw=;
	b=V+8/4vhgEPogXU4EaeIOWIlUtnmv11m0h4Nnc2uNNTZ2p0L8li9QcAXIDiJMaLJPsnvfgf
	1pzOaWAwLVGNN6BMIhgM6QYiNogjEWuNNxkNApw0Swd72g7X8zpjqew3d6RzWuzJUTmQD4
	6zZ9kuRhxEnoto07++5AnaX2pNjUjXU=
From: Toon Claes <toon@iotcl.com>
Date: Wed, 26 Mar 2025 21:18:30 +0100
Subject: [PATCH 6/8] pathspec: turn on tries when appropriate
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-toon-blame-tree-v1-6-4173133f3786@iotcl.com>
References: <20250326-toon-blame-tree-v1-0-4173133f3786@iotcl.com>
In-Reply-To: <20250326-toon-blame-tree-v1-0-4173133f3786@iotcl.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
X-Migadu-Flow: FLOW_OUT

From: Jeff King <peff@peff.net>

An earlier commit introduced pathspec_tries, but we did not
actually generate them by default. This patch causes us to
do so when it is possible (i.e., when no wildcards or other
pathspec magic are in use). This doesn't actually do
anything yet, though, as none of the pathspec users have
learned to make use of the tries.

We embed the pathspec_trie directly inside the "struct
pathspec". This is not strictly necessary, as once created,
the trie does not depend on the original pathspec. However,
since the intended use is to optimize existing pathspec
callers, passing the trie around as part of the pathspec
will minimize disruption to the call chain.

Signed-off-by: Jeff King <peff@peff.net>
---
 pathspec.c               | 19 +++++++++++++++++++
 pathspec.h               |  1 +
 t/helper/test-pathspec.c |  6 ++----
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 0e381fd748..c174edef32 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -117,6 +117,19 @@ struct pathspec_trie *pathspec_trie_build(const struct pathspec *pathspec)
 	return ret;
 }
 
+static void pathspec_trie_clear(struct pathspec_trie *t)
+{
+	if (t) {
+		for (size_t i = 0; i < t->nr; i++) {
+			pathspec_trie_clear(t->entries[i]);
+			FREE_AND_NULL(t->entries[i]);
+		}
+
+		t->nr = 0;
+		FREE_AND_NULL(t->entries);
+	}
+}
+
 int pathspec_trie_lookup(const struct pathspec_trie *parent,
 			 const char *path, size_t len)
 {
@@ -799,6 +812,8 @@ void parse_pathspec(struct pathspec *pathspec,
 			BUG("PATHSPEC_MAXDEPTH_VALID and PATHSPEC_KEEP_ORDER are incompatible");
 		QSORT(pathspec->items, pathspec->nr, pathspec_item_cmp);
 	}
+
+	pathspec->trie = pathspec_trie_build(pathspec);
 }
 
 void parse_pathspec_file(struct pathspec *pathspec, unsigned magic_mask,
@@ -859,6 +874,8 @@ void copy_pathspec(struct pathspec *dst, const struct pathspec *src)
 
 		d->attr_check = attr_check_dup(s->attr_check);
 	}
+
+	dst->trie = pathspec_trie_build(dst);
 }
 
 void clear_pathspec(struct pathspec *pathspec)
@@ -877,6 +894,8 @@ void clear_pathspec(struct pathspec *pathspec)
 			attr_check_free(pathspec->items[i].attr_check);
 	}
 
+	pathspec_trie_clear(pathspec->trie);
+	FREE_AND_NULL(pathspec->trie);
 	FREE_AND_NULL(pathspec->items);
 	pathspec->nr = 0;
 }
diff --git a/pathspec.h b/pathspec.h
index 71bafb78a9..ff11599d25 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -76,6 +76,7 @@ struct pathspec {
 		} *attr_match;
 		struct attr_check *attr_check;
 	} *items;
+	struct pathspec_trie *trie;
 };
 
 #define GUARD_PATHSPEC(ps, mask) \
diff --git a/t/helper/test-pathspec.c b/t/helper/test-pathspec.c
index c04417681f..72e335abc1 100644
--- a/t/helper/test-pathspec.c
+++ b/t/helper/test-pathspec.c
@@ -63,7 +63,6 @@ static int cmd_trie(const char **argv)
 {
 	const char **specs, **paths;
 	struct pathspec pathspec;
-	struct pathspec_trie *trie;
 
 	paths = specs = argv;
 	while (*paths && strcmp(*paths, "--"))
@@ -72,12 +71,11 @@ static int cmd_trie(const char **argv)
 		*paths++ = NULL;
 
 	parse_pathspec(&pathspec, 0, 0, "", specs);
-	trie = pathspec_trie_build(&pathspec);
-	if (!trie)
+	if (!pathspec.trie)
 		die("unable to make trie from pathspec");
 
 	for (; *paths; paths++) {
-		if (trie_match(trie, *paths))
+		if (trie_match(pathspec.trie, *paths))
 			printf("yes\n");
 		else
 			printf("no\n");

-- 
2.49.0.rc2

