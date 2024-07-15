Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103F84C62
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 00:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721003777; cv=none; b=ObIEKn3UYeVrfSNBNU1C4wM/G62NzCnAkmlmC8YDVH7kqWoCp0vET3MIhyvY48rhiVaxvpT2BvY1CBWIttWGaLpGgIw6fYTuXlWsi3KDsbpljfLMUDT8rfNLPVX8ARVuyqeF+EFP3LjKyj450cEi3KQya/Mgfs/JWWxzR/mIjGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721003777; c=relaxed/simple;
	bh=TVjtD0jkM2pCp+tx52kmK9b+zEKH319AJPyaDHiN4HU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JPApfdJLRzY+HHC1c8XXzxi2IGpdebY8U8q0WbUk0Y5erdFXGKXpKq4C7m4fEwbWtBNQevuMvgrhMIDGYDoNeMPWU9BygzLd9h8ubzp8H+DVs3z5x2Cw483q+ArmII22sqswPNGwBB0i7o2YGQyFmWMiXNo9VLy3l9/jlb07Q+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=UpttgpnT; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="UpttgpnT"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id E065B1F5B9;
	Mon, 15 Jul 2024 00:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1721003720;
	bh=TVjtD0jkM2pCp+tx52kmK9b+zEKH319AJPyaDHiN4HU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UpttgpnT/3Sntz6LotMJ8XwRzYluxzXpJjD7ku+GFScMPD1YcTbTQmJA8v7awN6xZ
	 bPaNhiZHD37wkkMHXp0rhNpehx1P7hNxh+OpW4+/MBfPUrzu+VOw7BRcCPqtsBNKeR
	 V3Pz2cUBCvVznYfTHy4LhY/J3C7yyQObuFq6bbBI=
From: Eric Wong <e@80x24.org>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH v1 07/10] object_info: content_limit only applies to blobs
Date: Mon, 15 Jul 2024 00:35:16 +0000
Message-ID: <20240715003519.2671385-8-e@80x24.org>
In-Reply-To: <20240715003519.2671385-1-e@80x24.org>
References: <20240715003519.2671385-1-e@80x24.org>
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
 builtin/cat-file.c | 51 +++++++++++++++++++++-------------------------
 object-file.c      |  3 ++-
 packfile.c         |  8 +++++---
 3 files changed, 30 insertions(+), 32 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 769c8b48d2..0752ff7a74 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -386,20 +386,39 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
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
+			if (USE_DIRECT_CACHE &&
+					data->info.whence == OI_DBCACHED) {
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
 		case OI_CACHED: BUG("FIXME OI_CACHED support not done");
 		case OI_LOOSE:
 		case OI_PACKED:
-			FREE_AND_NULL(data->content);
+			free(content);
 			break;
 		case OI_DBCACHED:
 			if (USE_DIRECT_CACHE)
 				unlock_delta_base_cache();
 			else
-				FREE_AND_NULL(data->content);
+				free(content);
 		}
-	} else if (data->type == OBJ_BLOB) {
+	} else {
+		assert(data->type == OBJ_BLOB);
 		if (opt->buffer_output)
 			fflush(stdout);
 		if (opt->transform_mode) {
@@ -434,30 +453,6 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 			stream_blob(oid);
 		}
 	}
-	else {
-		enum object_type type;
-		unsigned long size;
-		void *contents;
-
-		contents = repo_read_object_file(the_repository, oid, &type,
-						 &size);
-		if (!contents)
-			die("object %s disappeared", oid_to_hex(oid));
-
-		if (use_mailmap) {
-			size_t s = size;
-			contents = replace_idents_using_mailmap(contents, &s);
-			size = cast_size_t_to_ulong(s);
-		}
-
-		if (type != data->type)
-			die("object %s changed type!?", oid_to_hex(oid));
-		if (data->info.sizep && size != data->size && !use_mailmap)
-			die("object %s changed size!?", oid_to_hex(oid));
-
-		batch_write(opt, contents, size);
-		free(contents);
-	}
 }
 
 static void print_default_format(struct strbuf *scratch, struct expand_data *data,
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
index c2ba6ab203..01ce3a49db 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1542,7 +1542,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 			if (oi->direct_cache) {
 				lock_delta_base_cache();
 				*oi->contentp = ent->data;
-			} else if (!oi->content_limit ||
+			} else if (type != OBJ_BLOB || !oi->content_limit ||
 					ent->size <= oi->content_limit) {
 				*oi->contentp = xmemdupz(ent->data, ent->size);
 			} else {
@@ -1579,10 +1579,12 @@ int packed_object_info(struct repository *r, struct packed_git *p,
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
