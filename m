Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81D79204A0
	for <e@80x24.org>; Sun,  1 Jan 2017 19:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932429AbdAATUN (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jan 2017 14:20:13 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:53808 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932384AbdAATTj (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 1 Jan 2017 14:19:39 -0500
Received: from genre.crustytoothpaste.net (unknown [173.243.43.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id A5FED280AD;
        Sun,  1 Jan 2017 19:19:38 +0000 (UTC)
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 06/17] builtin/grep: convert to struct object_id
Date:   Sun,  1 Jan 2017 19:18:36 +0000
Message-Id: <20170101191847.564741-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170101191847.564741-1-sandals@crustytoothpaste.net>
References: <20170101191847.564741-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert several functions to use struct object_id, and rename them so
that they no longer refer to SHA-1.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/grep.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 8887b6add..6fc9f2dc9 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -281,17 +281,17 @@ static int grep_cmd_config(const char *var, const char *value, void *cb)
 	return st;
 }
 
-static void *lock_and_read_sha1_file(const unsigned char *sha1, enum object_type *type, unsigned long *size)
+static void *lock_and_read_oid_file(const struct object_id *oid, enum object_type *type, unsigned long *size)
 {
 	void *data;
 
 	grep_read_lock();
-	data = read_sha1_file(sha1, type, size);
+	data = read_sha1_file(oid->hash, type, size);
 	grep_read_unlock();
 	return data;
 }
 
-static int grep_sha1(struct grep_opt *opt, const unsigned char *sha1,
+static int grep_oid(struct grep_opt *opt, const struct object_id *oid,
 		     const char *filename, int tree_name_len,
 		     const char *path)
 {
@@ -306,7 +306,7 @@ static int grep_sha1(struct grep_opt *opt, const unsigned char *sha1,
 
 #ifndef NO_PTHREADS
 	if (num_threads) {
-		add_work(opt, GREP_SOURCE_SHA1, pathbuf.buf, path, sha1);
+		add_work(opt, GREP_SOURCE_SHA1, pathbuf.buf, path, oid);
 		strbuf_release(&pathbuf);
 		return 0;
 	} else
@@ -315,7 +315,7 @@ static int grep_sha1(struct grep_opt *opt, const unsigned char *sha1,
 		struct grep_source gs;
 		int hit;
 
-		grep_source_init(&gs, GREP_SOURCE_SHA1, pathbuf.buf, path, sha1);
+		grep_source_init(&gs, GREP_SOURCE_SHA1, pathbuf.buf, path, oid);
 		strbuf_release(&pathbuf);
 		hit = grep_source(opt, &gs);
 
@@ -398,7 +398,7 @@ static int grep_cache(struct grep_opt *opt, const struct pathspec *pathspec, int
 		if (cached || (ce->ce_flags & CE_VALID) || ce_skip_worktree(ce)) {
 			if (ce_stage(ce) || ce_intent_to_add(ce))
 				continue;
-			hit |= grep_sha1(opt, ce->oid.hash, ce->name, 0,
+			hit |= grep_oid(opt, &ce->oid, ce->name, 0,
 					 ce->name);
 		}
 		else
@@ -439,7 +439,7 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 		strbuf_add(base, entry.path, te_len);
 
 		if (S_ISREG(entry.mode)) {
-			hit |= grep_sha1(opt, entry.oid->hash, base->buf, tn_len,
+			hit |= grep_oid(opt, entry.oid, base->buf, tn_len,
 					 check_attr ? base->buf + tn_len : NULL);
 		}
 		else if (S_ISDIR(entry.mode)) {
@@ -448,7 +448,7 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 			void *data;
 			unsigned long size;
 
-			data = lock_and_read_sha1_file(entry.oid->hash, &type, &size);
+			data = lock_and_read_oid_file(entry.oid, &type, &size);
 			if (!data)
 				die(_("unable to read tree (%s)"),
 				    oid_to_hex(entry.oid));
@@ -471,7 +471,7 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 		       struct object *obj, const char *name, const char *path)
 {
 	if (obj->type == OBJ_BLOB)
-		return grep_sha1(opt, obj->oid.hash, name, 0, path);
+		return grep_oid(opt, &obj->oid, name, 0, path);
 	if (obj->type == OBJ_COMMIT || obj->type == OBJ_TREE) {
 		struct tree_desc tree;
 		void *data;
@@ -820,11 +820,11 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	/* Check revs and then paths */
 	for (i = 0; i < argc; i++) {
 		const char *arg = argv[i];
-		unsigned char sha1[20];
+		struct object_id oid;
 		struct object_context oc;
 		/* Is it a rev? */
-		if (!get_sha1_with_context(arg, 0, sha1, &oc)) {
-			struct object *object = parse_object_or_die(sha1, arg);
+		if (!get_sha1_with_context(arg, 0, oid.hash, &oc)) {
+			struct object *object = parse_object_or_die(oid.hash, arg);
 			if (!seen_dashdash)
 				verify_non_filename(prefix, arg);
 			add_object_array_with_path(object, arg, &list, oc.mode, oc.path);
-- 
2.11.0

