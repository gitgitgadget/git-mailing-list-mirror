Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74C071F859
	for <e@80x24.org>; Sun, 28 Aug 2016 23:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932346AbcH1X2I (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Aug 2016 19:28:08 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:40992 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756157AbcH1X2D (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 Aug 2016 19:28:03 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 2F6F6280AA;
        Sun, 28 Aug 2016 23:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1472426882;
        bh=n5P5eC/Mcw/q5xrRtmltX9c8NO9pdbzhc+VlK44ebO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YcCTi9H5cT7cQdyHeygkRc3m8wJ/dbqFqk6dO6HLGLnDqln2aIAAstb/zlDRJAjHb
         P6nUxeMN5AonpiR/bnbo5ibQs/FahGsme6LhcwAdoaFsdl5hYglp94lsBrr4gKKfVU
         YkGX9NTf6iEO1J2t9Dse0OwqlPQvLvbuYiciyB5QiYcukHqr6HGMLf9mBgCYk1SHvh
         EVqJKLTB7jrLyf1opx4dO3bHxFmLQvwPMnjhDQ+FffQQOXByxs2dBZShShmtbo3gs3
         9NNJEgzwqHT6lOkbiVy8pOXuBOaD3qXAQ99Y7hmuTnsoUMdPs7/FjBmQwEEv/vz77D
         Qz+VEl+1m692o6/vZBTMlKWhmRTyEAScle4cE25TgLvxgm+V1vFyQ6KlU5dfqq1g5w
         9z9L1Le8so55fzeAAeSBw/ie0PC49IHaxaCyXiBzTFu6ALs9AfBABPeZRNiiixwfuO
         ULN+1EkUoJQIyyf5h2UESsCB/HqghaGLIV6pHgZ2EQTyA0Ia6Wv
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Paul Tan <pyokagan@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH 04/20] builtin/log: convert some static functions to use struct object_id
Date:   Sun, 28 Aug 2016 23:27:41 +0000
Message-Id: <20160828232757.373278-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160828232757.373278-1-sandals@crustytoothpaste.net>
References: <20160828232757.373278-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/log.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 92dc34dc..226212c9 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -464,9 +464,9 @@ static void show_tagger(char *buf, int len, struct rev_info *rev)
 	strbuf_release(&out);
 }
 
-static int show_blob_object(const unsigned char *sha1, struct rev_info *rev, const char *obj_name)
+static int show_blob_object(const struct object_id *oid, struct rev_info *rev, const char *obj_name)
 {
-	unsigned char sha1c[20];
+	struct object_id oidc;
 	struct object_context obj_context;
 	char *buf;
 	unsigned long size;
@@ -474,13 +474,13 @@ static int show_blob_object(const unsigned char *sha1, struct rev_info *rev, con
 	fflush(rev->diffopt.file);
 	if (!DIFF_OPT_TOUCHED(&rev->diffopt, ALLOW_TEXTCONV) ||
 	    !DIFF_OPT_TST(&rev->diffopt, ALLOW_TEXTCONV))
-		return stream_blob_to_fd(1, sha1, NULL, 0);
+		return stream_blob_to_fd(1, oid->hash, NULL, 0);
 
-	if (get_sha1_with_context(obj_name, 0, sha1c, &obj_context))
+	if (get_sha1_with_context(obj_name, 0, oidc.hash, &obj_context))
 		die(_("Not a valid object name %s"), obj_name);
 	if (!obj_context.path[0] ||
-	    !textconv_object(obj_context.path, obj_context.mode, sha1c, 1, &buf, &size))
-		return stream_blob_to_fd(1, sha1, NULL, 0);
+	    !textconv_object(obj_context.path, obj_context.mode, oidc.hash, 1, &buf, &size))
+		return stream_blob_to_fd(1, oid->hash, NULL, 0);
 
 	if (!buf)
 		die(_("git show %s: bad file"), obj_name);
@@ -489,15 +489,15 @@ static int show_blob_object(const unsigned char *sha1, struct rev_info *rev, con
 	return 0;
 }
 
-static int show_tag_object(const unsigned char *sha1, struct rev_info *rev)
+static int show_tag_object(const struct object_id *oid, struct rev_info *rev)
 {
 	unsigned long size;
 	enum object_type type;
-	char *buf = read_sha1_file(sha1, &type, &size);
+	char *buf = read_sha1_file(oid->hash, &type, &size);
 	int offset = 0;
 
 	if (!buf)
-		return error(_("Could not read object %s"), sha1_to_hex(sha1));
+		return error(_("Could not read object %s"), oid_to_hex(oid));
 
 	assert(type == OBJ_TAG);
 	while (offset < size && buf[offset] != '\n') {
@@ -574,7 +574,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 		const char *name = objects[i].name;
 		switch (o->type) {
 		case OBJ_BLOB:
-			ret = show_blob_object(o->oid.hash, &rev, name);
+			ret = show_blob_object(&o->oid, &rev, name);
 			break;
 		case OBJ_TAG: {
 			struct tag *t = (struct tag *)o;
@@ -585,7 +585,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 					diff_get_color_opt(&rev.diffopt, DIFF_COMMIT),
 					t->tag,
 					diff_get_color_opt(&rev.diffopt, DIFF_RESET));
-			ret = show_tag_object(o->oid.hash, &rev);
+			ret = show_tag_object(&o->oid, &rev);
 			rev.shown_one = 1;
 			if (ret)
 				break;
@@ -1248,11 +1248,11 @@ static struct commit *get_base_commit(const char *base_commit,
 		if (upstream) {
 			struct commit_list *base_list;
 			struct commit *commit;
-			unsigned char sha1[20];
+			struct object_id oid;
 
-			if (get_sha1(upstream, sha1))
+			if (get_oid(upstream, &oid))
 				die(_("Failed to resolve '%s' as a valid ref."), upstream);
-			commit = lookup_commit_or_die(sha1, "upstream base");
+			commit = lookup_commit_or_die(oid.hash, "upstream base");
 			base_list = get_merge_bases_many(commit, total, list);
 			/* There should be one and only one merge base. */
 			if (!base_list || base_list->next)
@@ -1339,15 +1339,15 @@ static void prepare_bases(struct base_tree_info *bases,
 	 * and stuff them in bases structure.
 	 */
 	while ((commit = get_revision(&revs)) != NULL) {
-		unsigned char sha1[20];
+		struct object_id oid;
 		struct object_id *patch_id;
 		if (commit->util)
 			continue;
-		if (commit_patch_id(commit, &diffopt, sha1, 0))
+		if (commit_patch_id(commit, &diffopt, oid.hash, 0))
 			die(_("cannot get patch id"));
 		ALLOC_GROW(bases->patch_id, bases->nr_patch_id + 1, bases->alloc_patch_id);
 		patch_id = bases->patch_id + bases->nr_patch_id;
-		hashcpy(patch_id->hash, sha1);
+		oidcpy(patch_id, &oid);
 		bases->nr_patch_id++;
 	}
 }
@@ -1628,10 +1628,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			check_head = 1;
 
 		if (check_head) {
-			unsigned char sha1[20];
+			struct object_id oid;
 			const char *ref, *v;
 			ref = resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
-						 sha1, NULL);
+						 oid.hash, NULL);
 			if (ref && skip_prefix(ref, "refs/heads/", &v))
 				branch_name = xstrdup(v);
 			else
@@ -1802,9 +1802,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 
 static int add_pending_commit(const char *arg, struct rev_info *revs, int flags)
 {
-	unsigned char sha1[20];
-	if (get_sha1(arg, sha1) == 0) {
-		struct commit *commit = lookup_commit_reference(sha1);
+	struct object_id oid;
+	if (get_oid(arg, &oid) == 0) {
+		struct commit *commit = lookup_commit_reference(oid.hash);
 		if (commit) {
 			commit->object.flags |= flags;
 			add_pending_object(revs, &commit->object, arg);
