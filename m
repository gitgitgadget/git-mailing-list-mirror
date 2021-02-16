Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A53C433E6
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 14:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 027EF64DF5
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 14:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhBPOpT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 09:45:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:34194 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229913AbhBPOpK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 09:45:10 -0500
Received: (qmail 13403 invoked by uid 109); 16 Feb 2021 14:44:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Feb 2021 14:44:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24741 invoked by uid 111); 16 Feb 2021 14:44:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Feb 2021 09:44:28 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Feb 2021 09:44:28 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Blake Burkhart <bburky@bburky.com>,
        Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: [PATCH 3/6] exclude: add flags parameter to add_patterns()
Message-ID: <YCvaTJjma1Mi29pz@coredump.intra.peff.net>
References: <YCvaJg8o882IqNnx@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YCvaJg8o882IqNnx@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are a number of callers of add_patterns() and its sibling
functions. Let's give them a "flags" parameter for adding new options
without having to touch each caller. We'll use this in a future patch to
add O_NOFOLLOW support. But for now each caller just passes 0.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/sparse-checkout.c |  8 ++++----
 dir.c                     | 13 +++++++------
 dir.h                     |  3 ++-
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 2306a9ad98..d7da50ada5 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -64,7 +64,7 @@ static int sparse_checkout_list(int argc, const char **argv)
 	pl.use_cone_patterns = core_sparse_checkout_cone;
 
 	sparse_filename = get_sparse_checkout_filename();
-	res = add_patterns_from_file_to_list(sparse_filename, "", 0, &pl, NULL);
+	res = add_patterns_from_file_to_list(sparse_filename, "", 0, &pl, NULL, 0);
 	free(sparse_filename);
 
 	if (res < 0) {
@@ -321,7 +321,7 @@ static int sparse_checkout_init(int argc, const char **argv)
 	memset(&pl, 0, sizeof(pl));
 
 	sparse_filename = get_sparse_checkout_filename();
-	res = add_patterns_from_file_to_list(sparse_filename, "", 0, &pl, NULL);
+	res = add_patterns_from_file_to_list(sparse_filename, "", 0, &pl, NULL, 0);
 
 	/* If we already have a sparse-checkout file, use it. */
 	if (res >= 0) {
@@ -483,7 +483,7 @@ static void add_patterns_cone_mode(int argc, const char **argv,
 	existing.use_cone_patterns = core_sparse_checkout_cone;
 
 	if (add_patterns_from_file_to_list(sparse_filename, "", 0,
-					   &existing, NULL))
+					   &existing, NULL, 0))
 		die(_("unable to load existing sparse-checkout patterns"));
 	free(sparse_filename);
 
@@ -507,7 +507,7 @@ static void add_patterns_literal(int argc, const char **argv,
 {
 	char *sparse_filename = get_sparse_checkout_filename();
 	if (add_patterns_from_file_to_list(sparse_filename, "", 0,
-					   pl, NULL))
+					   pl, NULL, 0))
 		die(_("unable to load existing sparse-checkout patterns"));
 	free(sparse_filename);
 	add_patterns_from_input(pl, argc, argv);
diff --git a/dir.c b/dir.c
index d153a63bbd..f7fb1db718 100644
--- a/dir.c
+++ b/dir.c
@@ -1046,7 +1046,7 @@ static int add_patterns_from_buffer(char *buf, size_t size,
  */
 static int add_patterns(const char *fname, const char *base, int baselen,
 			struct pattern_list *pl, struct index_state *istate,
-			struct oid_stat *oid_stat)
+			unsigned flags, struct oid_stat *oid_stat)
 {
 	struct stat st;
 	int r;
@@ -1143,9 +1143,10 @@ static int add_patterns_from_buffer(char *buf, size_t size,
 
 int add_patterns_from_file_to_list(const char *fname, const char *base,
 				   int baselen, struct pattern_list *pl,
-				   struct index_state *istate)
+				   struct index_state *istate,
+				   unsigned flags)
 {
-	return add_patterns(fname, base, baselen, pl, istate, NULL);
+	return add_patterns(fname, base, baselen, pl, istate, flags, NULL);
 }
 
 int add_patterns_from_blob_to_list(
@@ -1194,7 +1195,7 @@ static void add_patterns_from_file_1(struct dir_struct *dir, const char *fname,
 	if (!dir->untracked)
 		dir->unmanaged_exclude_files++;
 	pl = add_pattern_list(dir, EXC_FILE, fname);
-	if (add_patterns(fname, "", 0, pl, NULL, oid_stat) < 0)
+	if (add_patterns(fname, "", 0, pl, NULL, 0, oid_stat) < 0)
 		die(_("cannot use %s as an exclude file"), fname);
 }
 
@@ -1557,7 +1558,7 @@ static void prep_exclude(struct dir_struct *dir,
 			strbuf_addbuf(&sb, &dir->basebuf);
 			strbuf_addstr(&sb, dir->exclude_per_dir);
 			pl->src = strbuf_detach(&sb, NULL);
-			add_patterns(pl->src, pl->src, stk->baselen, pl, istate,
+			add_patterns(pl->src, pl->src, stk->baselen, pl, istate, 0,
 				     untracked ? &oid_stat : NULL);
 		}
 		/*
@@ -3009,7 +3010,7 @@ int get_sparse_checkout_patterns(struct pattern_list *pl)
 	char *sparse_filename = get_sparse_checkout_filename();
 
 	pl->use_cone_patterns = core_sparse_checkout_cone;
-	res = add_patterns_from_file_to_list(sparse_filename, "", 0, pl, NULL);
+	res = add_patterns_from_file_to_list(sparse_filename, "", 0, pl, NULL, 0);
 
 	free(sparse_filename);
 	return res;
diff --git a/dir.h b/dir.h
index facfae4740..04d886cfce 100644
--- a/dir.h
+++ b/dir.h
@@ -420,7 +420,8 @@ int hashmap_contains_parent(struct hashmap *map,
 struct pattern_list *add_pattern_list(struct dir_struct *dir,
 				      int group_type, const char *src);
 int add_patterns_from_file_to_list(const char *fname, const char *base, int baselen,
-				   struct pattern_list *pl, struct  index_state *istate);
+				   struct pattern_list *pl, struct index_state *istate,
+				   unsigned flags);
 void add_patterns_from_file(struct dir_struct *, const char *fname);
 int add_patterns_from_blob_to_list(struct object_id *oid,
 				   const char *base, int baselen,
-- 
2.30.1.986.gd86016a168

