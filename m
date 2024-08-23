Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06719185B72
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 22:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724453249; cv=none; b=rE2yB9naMcn8Bd/F0wkmjIMOZNZvv0Otibu2ZVgK16KJzQXJXrDK+kXPeZ/hSpl4rrzBE0IFIJu2CCzzWlpGx3rwdsUdEhMpHLgy+5JoqGrxknLtY2+taCAVXnrsogVULhpR7pWE6N0xyV8SmwD2Gk4GY/OhZwNHVsAEJtwzjn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724453249; c=relaxed/simple;
	bh=7VXnokmq29XlxhRRe8WntaEmwqhoE7gjQSeuo3pAJKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PXaKzBS0Bbxw7OqivEp91S2OBSoLyAATaDYyetivh11dc0LzV0P4jFA2SYMjqKFOqyR5m+29IFhM7nQ/Zrl1Yg3SHTHZAGxMEjPtYuJFQPCu6IBM8bzPiUwya955jj9nLnYiiGsTM5PnVmNiv18tlNa99bZvHnr+TXSJTBRuhz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=4b4hqEaK; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="4b4hqEaK"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 737141F549;
	Fri, 23 Aug 2024 22:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1724453192;
	bh=7VXnokmq29XlxhRRe8WntaEmwqhoE7gjQSeuo3pAJKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=4b4hqEaK9wodkTtKL/hI89TWIvDEYpWYrphX+qYpwc21juJSxAeMnzypRk37MCF6C
	 QHSebCXnaaJel/GN9w0y0jUwqWVbxHSoDdSVTI/XuvVqjYs0jIStQa8NW+S3/b8z+Q
	 W0jB7GHsa+w2JmeBcklwsjtnrUhIH37ALmX/ypUo=
From: Eric Wong <e@80x24.org>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 07/10] object_info: content_limit only applies to blobs
Date: Fri, 23 Aug 2024 22:46:27 +0000
Message-ID: <20240823224630.1180772-8-e@80x24.org>
In-Reply-To: <20240823224630.1180772-1-e@80x24.org>
References: <20240823224630.1180772-1-e@80x24.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Streaming is only supported for blobs, so we'd end up having to
slurp all the other object types into memory regardless.  So
slurp all the non-blob types up front when requesting content
since we always handle them in-core, anyways.

Signed-off-by: Eric Wong <e@80x24.org>
---
 builtin/cat-file.c  | 21 +++++++++++++++++++--
 object-file.c       |  3 ++-
 packfile.c          |  8 +++++---
 t/t1006-cat-file.sh | 19 ++++++++++++++++---
 4 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 8debcdca3e..2aedd62324 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -385,7 +385,24 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 	assert(data->info.typep);
 
 	if (data->content) {
-		batch_write(opt, data->content, data->size);
+		void *content = data->content;
+		unsigned long size = data->size;
+
+		data->content = NULL;
+		if (use_mailmap && (data->type == OBJ_COMMIT ||
+					data->type == OBJ_TAG)) {
+			size_t s = size;
+
+			if (data->info.whence == OI_DBCACHED) {
+				content = xmemdupz(content, s);
+				data->info.whence = OI_PACKED;
+			}
+
+			content = replace_idents_using_mailmap(content, &s);
+			size = cast_size_t_to_ulong(s);
+		}
+
+		batch_write(opt, content, size);
 		switch (data->info.whence) {
 		case OI_CACHED:
 			/*
@@ -395,7 +412,7 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 			BUG("TODO OI_CACHED support not done");
 		case OI_LOOSE:
 		case OI_PACKED:
-			FREE_AND_NULL(data->content);
+			free(content);
 			break;
 		case OI_DBCACHED:
 			unlock_delta_base_cache();
diff --git a/object-file.c b/object-file.c
index 19100e823d..59842cfe1b 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1492,7 +1492,8 @@ static int loose_object_info(struct repository *r,
 
 		if (!oi->contentp)
 			break;
-		if (oi->content_limit && *oi->sizep > oi->content_limit) {
+		if (oi->content_limit && *oi->typep == OBJ_BLOB &&
+				*oi->sizep > oi->content_limit) {
 			git_inflate_end(&stream);
 			oi->contentp = NULL;
 			goto cleanup;
diff --git a/packfile.c b/packfile.c
index 94d20034e4..a592e0b32c 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1546,7 +1546,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 			if (oi->direct_cache) {
 				lock_delta_base_cache();
 				*oi->contentp = ent->data;
-			} else if (!oi->content_limit ||
+			} else if (type != OBJ_BLOB || !oi->content_limit ||
 					ent->size <= oi->content_limit) {
 				*oi->contentp = xmemdupz(ent->data, ent->size);
 			} else {
@@ -1583,10 +1583,12 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 		}
 
 		if (oi->contentp) {
-			if (oi->sizep && *oi->sizep <= oi->content_limit) {
+			final_type = packed_to_object_type(r, p, obj_offset,
+						     type, &w_curs, curpos);
+			if (final_type != OBJ_BLOB || (oi->sizep &&
+					*oi->sizep <= oi->content_limit)) {
 				*oi->contentp = unpack_entry(r, p, obj_offset,
 							&type, oi->sizep);
-				final_type = type;
 				if (!*oi->contentp)
 					type = OBJ_BAD;
 			} else {
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index ff9bf213aa..841e8567e9 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -622,20 +622,33 @@ test_expect_success 'confirm that neither loose blob is a delta' '
 	test_cmp expect actual
 '
 
+test_expect_success 'setup delta base tests' '
+	foo="$(git rev-parse HEAD:foo)" &&
+	foo_plus="$(git rev-parse HEAD:foo-plus)" &&
+	git repack -ad
+'
+
 # To avoid relying too much on the current delta heuristics,
 # we will check only that one of the two objects is a delta
 # against the other, but not the order. We can do so by just
 # asking for the base of both, and checking whether either
 # oid appears in the output.
 test_expect_success '%(deltabase) reports packed delta bases' '
-	git repack -ad &&
 	git cat-file --batch-check="%(deltabase)" <blobs >actual &&
 	{
-		grep "$(git rev-parse HEAD:foo)" actual ||
-		grep "$(git rev-parse HEAD:foo-plus)" actual
+		grep "$foo" actual || grep "$foo_plus" actual
 	}
 '
 
+test_expect_success 'delta base direct cache use succeeds w/o asserting' '
+	commands="info $foo
+info $foo_plus
+contents $foo_plus
+contents $foo" &&
+	echo "$commands" >in &&
+	git cat-file --batch-command <in >out
+'
+
 test_expect_success 'setup bogus data' '
 	bogus_short_type="bogus" &&
 	bogus_short_content="bogus" &&
