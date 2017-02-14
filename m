Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB28A1FC44
	for <e@80x24.org>; Tue, 14 Feb 2017 02:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751804AbdBNCdB (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 21:33:01 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:50600 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751007AbdBNCcM (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Feb 2017 21:32:12 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 7E256280B1;
        Tue, 14 Feb 2017 02:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1487039516;
        bh=kgg2IZbLFB9gnqR2coRq05CxMPsnKISRojBmhvZZ2fA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rdikOYYMybA9YXE8QejivUPF9GaJC0qJfeYXo9bYKzSAbeeYTsiDiXG61XSg61gkX
         nj9RRj0yXouV8UYGBFTkp4Axvl9/1/tE6PDU1lwWsFqz5ggZsyUCnjvUg7f4lvooF2
         69v6T5uy4P639VOGLOX/opbKZ2cGM/IE8g8BXOB19Rxc2MEgzQhiyCTeNiomBEH7xp
         z4eS3LFVTm96gQJ0nmUACZytjWFZBNdvLiXElwj4Sknri8AxuGPWvDuXYgMV3rZ2ug
         2Y0iY2vHlGVLF03307K2/7rEHYCDqprv7ZsRe7NPxv8xAtpODRvJBPm/PG2kgtRPCG
         7Roc9Fp0Kw9qt8baUbC82WsyEpOeZIR38lttWPZt2DEQ7USLUpixInOPc8S6HF+lx1
         iH/KwbELtDZV+YlUgbqO9p/7QX3dR8kWVJRqUwE+0UNo0Ma05IgMpMUpqg4WVHFaby
         efWxS1cL525s2ZVwUy8fMdzzsRdeXIlOM3eKCLhKgbVRx3SYOqn
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 04/19] builtin/fast-export: convert to struct object_id
Date:   Tue, 14 Feb 2017 02:31:26 +0000
Message-Id: <20170214023141.842922-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170214023141.842922-1-sandals@crustytoothpaste.net>
References: <20170214023141.842922-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In addition to converting to struct object_id, write some hardcoded
buffer sizes in terms of GIT_SHA1_RAWSZ.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/fast-export.c | 58 +++++++++++++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 1e815b5577..e0220630d0 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -212,7 +212,7 @@ static char *anonymize_blob(unsigned long *size)
 	return strbuf_detach(&out, NULL);
 }
 
-static void export_blob(const unsigned char *sha1)
+static void export_blob(const struct object_id *oid)
 {
 	unsigned long size;
 	enum object_type type;
@@ -223,34 +223,34 @@ static void export_blob(const unsigned char *sha1)
 	if (no_data)
 		return;
 
-	if (is_null_sha1(sha1))
+	if (is_null_oid(oid))
 		return;
 
-	object = lookup_object(sha1);
+	object = lookup_object(oid->hash);
 	if (object && object->flags & SHOWN)
 		return;
 
 	if (anonymize) {
 		buf = anonymize_blob(&size);
-		object = (struct object *)lookup_blob(sha1);
+		object = (struct object *)lookup_blob(oid->hash);
 		eaten = 0;
 	} else {
-		buf = read_sha1_file(sha1, &type, &size);
+		buf = read_sha1_file(oid->hash, &type, &size);
 		if (!buf)
-			die ("Could not read blob %s", sha1_to_hex(sha1));
-		if (check_sha1_signature(sha1, buf, size, typename(type)) < 0)
-			die("sha1 mismatch in blob %s", sha1_to_hex(sha1));
-		object = parse_object_buffer(sha1, type, size, buf, &eaten);
+			die ("Could not read blob %s", oid_to_hex(oid));
+		if (check_sha1_signature(oid->hash, buf, size, typename(type)) < 0)
+			die("sha1 mismatch in blob %s", oid_to_hex(oid));
+		object = parse_object_buffer(oid->hash, type, size, buf, &eaten);
 	}
 
 	if (!object)
-		die("Could not read blob %s", sha1_to_hex(sha1));
+		die("Could not read blob %s", oid_to_hex(oid));
 
 	mark_next_object(object);
 
 	printf("blob\nmark :%"PRIu32"\ndata %lu\n", last_idnum, size);
 	if (size && fwrite(buf, size, 1, stdout) != 1)
-		die_errno ("Could not write blob '%s'", sha1_to_hex(sha1));
+		die_errno ("Could not write blob '%s'", oid_to_hex(oid));
 	printf("\n");
 
 	show_progress();
@@ -323,19 +323,19 @@ static void print_path(const char *path)
 	}
 }
 
-static void *generate_fake_sha1(const void *old, size_t *len)
+static void *generate_fake_oid(const void *old, size_t *len)
 {
 	static uint32_t counter = 1; /* avoid null sha1 */
-	unsigned char *out = xcalloc(20, 1);
-	put_be32(out + 16, counter++);
+	unsigned char *out = xcalloc(GIT_SHA1_RAWSZ, 1);
+	put_be32(out + GIT_SHA1_RAWSZ - 4, counter++);
 	return out;
 }
 
-static const unsigned char *anonymize_sha1(const unsigned char *sha1)
+static const unsigned char *anonymize_sha1(const struct object_id *oid)
 {
 	static struct hashmap sha1s;
-	size_t len = 20;
-	return anonymize_mem(&sha1s, generate_fake_sha1, sha1, &len);
+	size_t len = GIT_SHA1_RAWSZ;
+	return anonymize_mem(&sha1s, generate_fake_oid, oid, &len);
 }
 
 static void show_filemodify(struct diff_queue_struct *q,
@@ -383,7 +383,7 @@ static void show_filemodify(struct diff_queue_struct *q,
 			if (no_data || S_ISGITLINK(spec->mode))
 				printf("M %06o %s ", spec->mode,
 				       sha1_to_hex(anonymize ?
-						   anonymize_sha1(spec->oid.hash) :
+						   anonymize_sha1(&spec->oid) :
 						   spec->oid.hash));
 			else {
 				struct object *object = lookup_object(spec->oid.hash);
@@ -572,7 +572,7 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
 	/* Export the referenced blobs, and remember the marks. */
 	for (i = 0; i < diff_queued_diff.nr; i++)
 		if (!S_ISGITLINK(diff_queued_diff.queue[i]->two->mode))
-			export_blob(diff_queued_diff.queue[i]->two->oid.hash);
+			export_blob(&diff_queued_diff.queue[i]->two->oid);
 
 	refname = commit->util;
 	if (anonymize) {
@@ -797,14 +797,14 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info)
 
 	for (i = 0; i < info->nr; i++) {
 		struct rev_cmdline_entry *e = info->rev + i;
-		unsigned char sha1[20];
+		struct object_id oid;
 		struct commit *commit;
 		char *full_name;
 
 		if (e->flags & UNINTERESTING)
 			continue;
 
-		if (dwim_ref(e->name, strlen(e->name), sha1, &full_name) != 1)
+		if (dwim_ref(e->name, strlen(e->name), oid.hash, &full_name) != 1)
 			continue;
 
 		if (refspecs) {
@@ -828,7 +828,7 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info)
 		case OBJ_COMMIT:
 			break;
 		case OBJ_BLOB:
-			export_blob(commit->object.oid.hash);
+			export_blob(&commit->object.oid);
 			continue;
 		default: /* OBJ_TAG (nested tags) is already handled */
 			warning("Tag points to object of unexpected type %s, skipping.",
@@ -912,7 +912,7 @@ static void import_marks(char *input_file)
 	while (fgets(line, sizeof(line), f)) {
 		uint32_t mark;
 		char *line_end, *mark_end;
-		unsigned char sha1[20];
+		struct object_id oid;
 		struct object *object;
 		struct commit *commit;
 		enum object_type type;
@@ -924,28 +924,28 @@ static void import_marks(char *input_file)
 
 		mark = strtoumax(line + 1, &mark_end, 10);
 		if (!mark || mark_end == line + 1
-			|| *mark_end != ' ' || get_sha1_hex(mark_end + 1, sha1))
+			|| *mark_end != ' ' || get_oid_hex(mark_end + 1, &oid))
 			die("corrupt mark line: %s", line);
 
 		if (last_idnum < mark)
 			last_idnum = mark;
 
-		type = sha1_object_info(sha1, NULL);
+		type = sha1_object_info(oid.hash, NULL);
 		if (type < 0)
-			die("object not found: %s", sha1_to_hex(sha1));
+			die("object not found: %s", oid_to_hex(&oid));
 
 		if (type != OBJ_COMMIT)
 			/* only commits */
 			continue;
 
-		commit = lookup_commit(sha1);
+		commit = lookup_commit(oid.hash);
 		if (!commit)
-			die("not a commit? can't happen: %s", sha1_to_hex(sha1));
+			die("not a commit? can't happen: %s", oid_to_hex(&oid));
 
 		object = &commit->object;
 
 		if (object->flags & SHOWN)
-			error("Object %s already has a mark", sha1_to_hex(sha1));
+			error("Object %s already has a mark", oid_to_hex(&oid));
 
 		mark_object(object, mark);
 
-- 
2.11.0

