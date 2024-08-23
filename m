Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB091494D6
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 22:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724453214; cv=none; b=XgCHF21rsXySIO2zXnTvRipl+XdWN2Zx1HYT2LuwbutDpKCKOry/Vx7olafvOG8WSKy+4UlT2KStdTp5a885ZhrYYsTqohe/TUaQUgPfmn5ATE1o1n3Rk9XAj9bMgNbwjshXYaChkkeQhbq7bVsch4672sH8E2/1v0FSQ4BWpBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724453214; c=relaxed/simple;
	bh=IEJVhlQKubt6dC8wtYYqpGri8d+i72lLqxRL/avBFaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uai1OMxitC0ZUeAsuOYa7YTS3rdGZvdH5813DwXmdedAOBzUVszpnzUEcYAWVVZjXoIq8g28DTbgDWZTS2cD6s6XV/0eTJ4AZBq+7U57Lsw1RV4qCUhfSX0WAf4CwfX7M0Ml9l1VOIEw4oke4sACc64eoydhAlFHO4REl+eHF+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=dZ/Z7DSK; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="dZ/Z7DSK"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C1FE1F513;
	Fri, 23 Aug 2024 22:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1724453191;
	bh=IEJVhlQKubt6dC8wtYYqpGri8d+i72lLqxRL/avBFaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dZ/Z7DSKAhP9fDrSB69sc8F0sOOoHzp28gGNF+/7gLo6X04gARqHKVEm0n9WMo4eW
	 0uuRHCsPzM6lCGzdxsWBHDM7uleT2hWOVItfo2l1pKjq22slahzLfozX0vxbbboE2N
	 5PpvOkVRr/phvgKuy4ieP5FGArAiE7qy8S4QV2gE=
From: Eric Wong <e@80x24.org>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 02/10] packfile: allow content-limit for cat-file
Date: Fri, 23 Aug 2024 22:46:22 +0000
Message-ID: <20240823224630.1180772-3-e@80x24.org>
In-Reply-To: <20240823224630.1180772-1-e@80x24.org>
References: <20240823224630.1180772-1-e@80x24.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff King <peff@peff.net>

Avoid unnecessary round trips to the object store to speed
up cat-file contents retrievals.  The majority of packed objects
don't benefit from the streaming interface at all and we end up
having to load them in core anyways to satisfy our streaming
API.

This drops the runtime of
`git cat-file --batch-all-objects --unordered --batch' on
git.git from ~7.1s to ~6.1s on Jeff's machine.

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
index 4028763947..c12a0515b3 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1529,7 +1529,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 	 * We always get the representation type, but only convert it to
 	 * a "real" type later if the caller is interested.
 	 */
-	if (oi->contentp) {
+	if (oi->contentp && !oi->content_limit) {
 		*oi->contentp = cache_or_unpack_entry(r, p, obj_offset, oi->sizep,
 						      &type);
 		if (!*oi->contentp)
@@ -1555,6 +1555,17 @@ int packed_object_info(struct repository *r, struct packed_git *p,
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
