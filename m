Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A627A185B72
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 22:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724453256; cv=none; b=r2E/7znHXi6uZm+6Y6wBZdvDPuAAJxDP7kqJ0R8fNoL5IM+ab3bIrrkfSk1PS0fVDmMxDY4cHNRor2XKhcZw+go8Wm3OU7B4a1oGVTun4EM1OuxP/ijaBQrVn4gjs69XTDQ1O/Omy8/yRKT64HhKXths8MPy8QM1VoMjnQtQdaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724453256; c=relaxed/simple;
	bh=nGH6j8wnUTCvWDYLOlKwCPIY7BvMqe0mk8IAjgfDtFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bl0FgAI7G0K0O62ORP/qPmcSKDWSFouIu5YebqBt1zj/Upgz5CB8LUnaQ7Tuikuu05TN13uEXGXtKdf89p61Bj5njQuemMdt2CffcjYxlMSbXtNY1dog9y0yts9rlrRkDFVaEjKHgR9AOZtYHtLV7C2WGm0qK91JSz/kQ44GoD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=BFiE2oHP; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="BFiE2oHP"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id A68CD1F566;
	Fri, 23 Aug 2024 22:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1724453192;
	bh=nGH6j8wnUTCvWDYLOlKwCPIY7BvMqe0mk8IAjgfDtFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BFiE2oHP0pHTXmdZX7K19rFI8rcvlcZxP0l9bzmclCwc+PED/sCT4sbgQ1qJseQzP
	 msEomdY0tubgomvTD4KQc69VoPc6/8mCuwXw6mZPnBh1+obCL4ITQxr6Wo2DRbhizx
	 R6pKS+J+clYvfOhNqOELGyf7FsKBW0u9hp2WJnws=
From: Eric Wong <e@80x24.org>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 08/10] cat-file: batch-command uses content_limit
Date: Fri, 23 Aug 2024 22:46:28 +0000
Message-ID: <20240823224630.1180772-9-e@80x24.org>
In-Reply-To: <20240823224630.1180772-1-e@80x24.org>
References: <20240823224630.1180772-1-e@80x24.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As with the normal `--batch' mode, we can use the content_limit
round trip optimization to avoid a redundant lookup.  The only
tricky thing here is we need to enable/disable setting the
object_info.contentp field depending on whether we hit an `info'
or `contents' command.

t1006 is updated to ensure we can switch back and forth between
`info' and `contents' commands without problems.

Signed-off-by: Eric Wong <e@80x24.org>
---
 builtin/cat-file.c | 32 ++++++--------------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 2aedd62324..067cdbdbf9 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -417,7 +417,8 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 		case OI_DBCACHED:
 			unlock_delta_base_cache();
 		}
-	} else if (data->type == OBJ_BLOB) {
+	} else {
+		assert(data->type == OBJ_BLOB);
 		if (opt->buffer_output)
 			fflush(stdout);
 		if (opt->transform_mode) {
@@ -452,30 +453,6 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
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
@@ -689,6 +666,7 @@ static void parse_cmd_contents(struct batch_options *opt,
 			     struct expand_data *data)
 {
 	opt->batch_mode = BATCH_MODE_CONTENTS;
+	data->info.contentp = &data->content;
 	batch_one_object(line, output, opt, data);
 }
 
@@ -698,6 +676,7 @@ static void parse_cmd_info(struct batch_options *opt,
 			   struct expand_data *data)
 {
 	opt->batch_mode = BATCH_MODE_INFO;
+	data->info.contentp = NULL;
 	batch_one_object(line, output, opt, data);
 }
 
@@ -839,7 +818,8 @@ static int batch_objects(struct batch_options *opt)
 	 * Likewise, grab the content in the initial request if it's small
 	 * and we're not planning to filter it.
 	 */
-	if (opt->batch_mode == BATCH_MODE_CONTENTS) {
+	if ((opt->batch_mode == BATCH_MODE_CONTENTS) ||
+			(opt->batch_mode == BATCH_MODE_QUEUE_AND_DISPATCH)) {
 		data.info.typep = &data.type;
 		if (!opt->transform_mode) {
 			data.info.sizep = &data.size;
