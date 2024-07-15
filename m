Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C269C4C6D
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 00:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721003741; cv=none; b=Y+jajjQvY15HLbhutkXjxlSt6hb5VjDEvwWNl+RRwQJEwmHAgCX66T1jaQUIwbUDLlMg+BUUM64YLQB+qOuk01ZdfPl5S0vslO9TMGLMVekHdVuIwSyxU9dPpEIvSs45j+12te3hNRuv4yyO74EXlp8CG77hG8jaKPrXg5GZA8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721003741; c=relaxed/simple;
	bh=avaCAlocWs3hEew496DjcxwDlUSY/cPYu07TNipBK1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tpqw01SWjN8vaUlNBIW6LqhL6VfSRhUFTs8Mwwr3NH7XLh22MwZGeIrnf4jhO1g/NVMDWM5HT0h6MzGUhBNgncgIyFbxJbPAKRr+o/L8WTCzldN6ZmBl0Cxxoeqjb2oBW+OXGkNFM2Zj9cqeH60DKp+USaeUNZvdA+Qg8DN56XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=YkosBdUt; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="YkosBdUt"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 255F71F5A7;
	Mon, 15 Jul 2024 00:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1721003720;
	bh=avaCAlocWs3hEew496DjcxwDlUSY/cPYu07TNipBK1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YkosBdUt3g1n717g9ul/aEfV3XQjnQN5Htp7wimxP8K7b0UOOnNP9W2Gbup9Q0ssP
	 HGGQuYvvFMEl1S3YXF4uUQmtcU6Lk9POwTXe8xmmOcqirb9Wr+uW7iHXbdryy+XRrF
	 oa7VfbUUoa7nD2GjE/Xx9BHrdIV16+A6oRZAOFU4=
From: Eric Wong <e@80x24.org>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH v1 02/10] packfile: allow content-limit for cat-file
Date: Mon, 15 Jul 2024 00:35:11 +0000
Message-ID: <20240715003519.2671385-3-e@80x24.org>
In-Reply-To: <20240715003519.2671385-1-e@80x24.org>
References: <20240715003519.2671385-1-e@80x24.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff King <peff@peff.net>

This avoids unnecessary round trips to the object store to speed
up cat-file contents retrievals.  The majority of packed objects
don't benefit from the streaming interface at all and we end up
having to load them in core anyways to satisfy our streaming
API.

This drops the runtime of
`git cat-file --batch-all-objects --unordered --batch' from
~7.1s to ~6.1s on Jeff's machine.

[ew: commit message]

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Eric Wong <e@80x24.org>
---
 builtin/cat-file.c | 17 +++++++++++++++--
 object-file.c      |  6 ++++++
 object-store-ll.h  |  1 +
 packfile.c         | 13 ++++++++++++-
 4 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 18fe58d6b8..bc4bb89610 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -280,6 +280,7 @@ struct expand_data {
 	off_t disk_size;
 	const char *rest;
 	struct object_id delta_base_oid;
+	void *content;
 
 	/*
 	 * If mark_query is true, we do not expand anything, but rather
@@ -383,7 +384,10 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 
 	assert(data->info.typep);
 
-	if (data->type == OBJ_BLOB) {
+	if (data->content) {
+		batch_write(opt, data->content, data->size);
+		FREE_AND_NULL(data->content);
+	} else if (data->type == OBJ_BLOB) {
 		if (opt->buffer_output)
 			fflush(stdout);
 		if (opt->transform_mode) {
@@ -801,9 +805,18 @@ static int batch_objects(struct batch_options *opt)
 	/*
 	 * If we are printing out the object, then always fill in the type,
 	 * since we will want to decide whether or not to stream.
+	 *
+	 * Likewise, grab the content in the initial request if it's small
+	 * and we're not planning to filter it.
 	 */
-	if (opt->batch_mode == BATCH_MODE_CONTENTS)
+	if (opt->batch_mode == BATCH_MODE_CONTENTS) {
 		data.info.typep = &data.type;
+		if (!opt->transform_mode) {
+			data.info.sizep = &data.size;
+			data.info.contentp = &data.content;
+			data.info.content_limit = big_file_threshold;
+		}
+	}
 
 	if (opt->all_objects) {
 		struct object_cb_data cb;
diff --git a/object-file.c b/object-file.c
index 065103be3e..1cc29c3c58 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1492,6 +1492,12 @@ static int loose_object_info(struct repository *r,
 
 		if (!oi->contentp)
 			break;
+		if (oi->content_limit && *oi->sizep > oi->content_limit) {
+			git_inflate_end(&stream);
+			oi->contentp = NULL;
+			goto cleanup;
+		}
+
 		*oi->contentp = unpack_loose_rest(&stream, hdr, *oi->sizep, oid);
 		if (*oi->contentp)
 			goto cleanup;
diff --git a/object-store-ll.h b/object-store-ll.h
index c5f2bb2fc2..b71a15f590 100644
--- a/object-store-ll.h
+++ b/object-store-ll.h
@@ -289,6 +289,7 @@ struct object_info {
 	struct object_id *delta_base_oid;
 	struct strbuf *type_name;
 	void **contentp;
+	size_t content_limit;
 
 	/* Response */
 	enum {
diff --git a/packfile.c b/packfile.c
index e547522e3d..54b9d46928 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1530,7 +1530,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 	 * a "real" type later if the caller is interested. Likewise...
 	 * tbd.
 	 */
-	if (oi->contentp) {
+	if (oi->contentp && !oi->content_limit) {
 		*oi->contentp = cache_or_unpack_entry(r, p, obj_offset, oi->sizep,
 						      &type);
 		if (!*oi->contentp)
@@ -1556,6 +1556,17 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 				*oi->sizep = size;
 			}
 		}
+
+		if (oi->contentp) {
+			if (oi->sizep && *oi->sizep < oi->content_limit) {
+				*oi->contentp = cache_or_unpack_entry(r, p, obj_offset,
+								      oi->sizep, &type);
+				if (!*oi->contentp)
+					type = OBJ_BAD;
+			} else {
+				*oi->contentp = NULL;
+			}
+		}
 	}
 
 	if (oi->disk_sizep) {
