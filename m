Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F4E71FC44
	for <e@80x24.org>; Tue, 14 Feb 2017 02:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751371AbdBNCcP (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 21:32:15 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:50626 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751289AbdBNCcO (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Feb 2017 21:32:14 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 17C47280B3;
        Tue, 14 Feb 2017 02:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1487039517;
        bh=CVzshxDk2+Z+rp/+LfzPUSQSemXELl8DbRLn/Kwpi20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eQai8/QuXTxsm4sovY817NoGmDflc+3GXCiOG5qmMSDHb3OF58Tn7/fF0U7rqYza6
         mzXEsPoZAliGxM9yJ71y84rjGpl1J98lZIGjv9/GdsdxsJarhonVbM/XidThBlBsjW
         IZgr0nYHalKdtxtZb6DnfeSGKt2m4WES1xCMGWQT8MSebuRrBGge25CZbN7pxHDqLY
         Wj0JpY0gmjZa67UZWqfrAEnKaMFt/lfY1QAR6b1TgC8mUkmt57S9um+azSoOYstQ5J
         BCDyZAGWHobsp+8AjV7smCS53msWc3QBHDoNgdWgkUlk6MKuYik7FdOwAqqC8Lgxh/
         G9nyAzxegZAyw1NJ/8GZvpYxp5VChyk8XpuYVALp32X88F7zLwrt3aT2hXQ5FY2L/E
         b3si5+hRW6OJ91AjU0+s4skn68M7p5FL9y9It91sbodT9C2IPUm5j/Iict9E5vwPOY
         CyGhXqhChCZQjNPnNcg9zHEpEQb0FNoJS2o5ikA5spk2YTSmhY2
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 06/19] builtin/grep: convert to struct object_id
Date:   Tue, 14 Feb 2017 02:31:28 +0000
Message-Id: <20170214023141.842922-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170214023141.842922-1-sandals@crustytoothpaste.net>
References: <20170214023141.842922-1-sandals@crustytoothpaste.net>
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
index 2c727ef499..0393b0fdc4 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -294,17 +294,17 @@ static int grep_cmd_config(const char *var, const char *value, void *cb)
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
@@ -323,7 +323,7 @@ static int grep_sha1(struct grep_opt *opt, const unsigned char *sha1,
 
 #ifndef NO_PTHREADS
 	if (num_threads) {
-		add_work(opt, GREP_SOURCE_SHA1, pathbuf.buf, path, sha1);
+		add_work(opt, GREP_SOURCE_SHA1, pathbuf.buf, path, oid);
 		strbuf_release(&pathbuf);
 		return 0;
 	} else
@@ -332,7 +332,7 @@ static int grep_sha1(struct grep_opt *opt, const unsigned char *sha1,
 		struct grep_source gs;
 		int hit;
 
-		grep_source_init(&gs, GREP_SOURCE_SHA1, pathbuf.buf, path, sha1);
+		grep_source_init(&gs, GREP_SOURCE_SHA1, pathbuf.buf, path, oid);
 		strbuf_release(&pathbuf);
 		hit = grep_source(opt, &gs);
 
@@ -690,7 +690,7 @@ static int grep_cache(struct grep_opt *opt, const struct pathspec *pathspec,
 			    ce_skip_worktree(ce)) {
 				if (ce_stage(ce) || ce_intent_to_add(ce))
 					continue;
-				hit |= grep_sha1(opt, ce->oid.hash, ce->name,
+				hit |= grep_oid(opt, &ce->oid, ce->name,
 						 0, ce->name);
 			} else {
 				hit |= grep_file(opt, ce->name);
@@ -750,7 +750,7 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 		strbuf_add(base, entry.path, te_len);
 
 		if (S_ISREG(entry.mode)) {
-			hit |= grep_sha1(opt, entry.oid->hash, base->buf, tn_len,
+			hit |= grep_oid(opt, entry.oid, base->buf, tn_len,
 					 check_attr ? base->buf + tn_len : NULL);
 		} else if (S_ISDIR(entry.mode)) {
 			enum object_type type;
@@ -758,7 +758,7 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 			void *data;
 			unsigned long size;
 
-			data = lock_and_read_sha1_file(entry.oid->hash, &type, &size);
+			data = lock_and_read_oid_file(entry.oid, &type, &size);
 			if (!data)
 				die(_("unable to read tree (%s)"),
 				    oid_to_hex(entry.oid));
@@ -787,7 +787,7 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 		       struct object *obj, const char *name, const char *path)
 {
 	if (obj->type == OBJ_BLOB)
-		return grep_sha1(opt, obj->oid.hash, name, 0, path);
+		return grep_oid(opt, &obj->oid, name, 0, path);
 	if (obj->type == OBJ_COMMIT || obj->type == OBJ_TREE) {
 		struct tree_desc tree;
 		void *data;
@@ -1152,11 +1152,11 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
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

