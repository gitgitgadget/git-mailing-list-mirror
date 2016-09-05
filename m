Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B60332070F
	for <e@80x24.org>; Mon,  5 Sep 2016 20:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964968AbcIEUKe (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 16:10:34 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:42954 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964878AbcIEUI0 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Sep 2016 16:08:26 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 5793F280A8;
        Mon,  5 Sep 2016 20:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1473106105;
        bh=sNeTvSLZJ7od3IFF95SrLDMaVcc1MSaVTkGnoQPsBFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uNCFeKlWpkb3aHIJPjgeuYaFwtFiGAwtAnjPVbNTkXK3Tm7svm5S5ZJFjPnCcoZDp
         qy4v3kuqo95mIuNQq9fRQIAnVO+1Wlug0+dxvGTm7/pGeCf2TwVfUrgayNPc2SjxiR
         3OI13kN3/WYwzuP9nVU3Q1fbu5EMUSpQoHe4aoHj6VjQPeyo6v1K635gqIa745zxSe
         dQoczSpA33/cYwOpNkXsEjTjh/MvB6k4iMpuUYWsV5/BlTuOpCfaCI4advNJDSWf3U
         j7hRGHEA6Tq1flhyitXzpOwov20JCY14rWZhL/0eNYZRopTVD++pLowWyMOKbo/wWE
         THhx/FG/m7Gz/0EAk7aTCxkRmQKsnQ6Lzd4laqP7B8pdA6DRkfYBrVRS96Zw59sVNB
         ucGqVNae8Rii8Rdz+kU96yYZHQCUA1f60aqo/q8PAmoxYjD9a673m2DMmCdvWnqpBR
         v1ZMuekccbOmDiXrJVzXqM78eIuiB3PBYQGTK91UZJcX4gzLIWm
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Paul Tan <pyokagan@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v2 02/20] builtin/apply: convert static functions to struct object_id
Date:   Mon,  5 Sep 2016 20:07:53 +0000
Message-Id: <20160905200811.697889-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160905200811.697889-1-sandals@crustytoothpaste.net>
References: <20160905200811.697889-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There were several static functions using unsigned char arrays for SHA-1
values.  Convert them to use struct object_id.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/apply.c | 96 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index ba0e75bf..76b16121 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3101,16 +3101,16 @@ static int apply_binary(struct apply_state *state,
 			struct patch *patch)
 {
 	const char *name = patch->old_name ? patch->old_name : patch->new_name;
-	unsigned char sha1[20];
+	struct object_id oid;
 
 	/*
 	 * For safety, we require patch index line to contain
 	 * full 40-byte textual SHA1 for old and new, at least for now.
 	 */
-	if (strlen(patch->old_sha1_prefix) != 40 ||
-	    strlen(patch->new_sha1_prefix) != 40 ||
-	    get_sha1_hex(patch->old_sha1_prefix, sha1) ||
-	    get_sha1_hex(patch->new_sha1_prefix, sha1))
+	if (strlen(patch->old_sha1_prefix) != GIT_SHA1_HEXSZ ||
+	    strlen(patch->new_sha1_prefix) != GIT_SHA1_HEXSZ ||
+	    get_oid_hex(patch->old_sha1_prefix, &oid) ||
+	    get_oid_hex(patch->new_sha1_prefix, &oid))
 		return error("cannot apply binary patch to '%s' "
 			     "without full index line", name);
 
@@ -3119,12 +3119,12 @@ static int apply_binary(struct apply_state *state,
 		 * See if the old one matches what the patch
 		 * applies to.
 		 */
-		hash_sha1_file(img->buf, img->len, blob_type, sha1);
-		if (strcmp(sha1_to_hex(sha1), patch->old_sha1_prefix))
+		hash_sha1_file(img->buf, img->len, blob_type, oid.hash);
+		if (strcmp(oid_to_hex(&oid), patch->old_sha1_prefix))
 			return error("the patch applies to '%s' (%s), "
 				     "which does not match the "
 				     "current contents.",
-				     name, sha1_to_hex(sha1));
+				     name, oid_to_hex(&oid));
 	}
 	else {
 		/* Otherwise, the old one must be empty. */
@@ -3133,19 +3133,19 @@ static int apply_binary(struct apply_state *state,
 				     "'%s' but it is not empty", name);
 	}
 
-	get_sha1_hex(patch->new_sha1_prefix, sha1);
-	if (is_null_sha1(sha1)) {
+	get_oid_hex(patch->new_sha1_prefix, &oid);
+	if (is_null_oid(&oid)) {
 		clear_image(img);
 		return 0; /* deletion patch */
 	}
 
-	if (has_sha1_file(sha1)) {
+	if (has_sha1_file(oid.hash)) {
 		/* We already have the postimage */
 		enum object_type type;
 		unsigned long size;
 		char *result;
 
-		result = read_sha1_file(sha1, &type, &size);
+		result = read_sha1_file(oid.hash, &type, &size);
 		if (!result)
 			return error("the necessary postimage %s for "
 				     "'%s' cannot be read",
@@ -3164,10 +3164,10 @@ static int apply_binary(struct apply_state *state,
 				     name);
 
 		/* verify that the result matches */
-		hash_sha1_file(img->buf, img->len, blob_type, sha1);
-		if (strcmp(sha1_to_hex(sha1), patch->new_sha1_prefix))
+		hash_sha1_file(img->buf, img->len, blob_type, oid.hash);
+		if (strcmp(oid_to_hex(&oid), patch->new_sha1_prefix))
 			return error(_("binary patch to '%s' creates incorrect result (expecting %s, got %s)"),
-				name, patch->new_sha1_prefix, sha1_to_hex(sha1));
+				name, patch->new_sha1_prefix, oid_to_hex(&oid));
 	}
 
 	return 0;
@@ -3197,17 +3197,17 @@ static int apply_fragments(struct apply_state *state, struct image *img, struct
 	return 0;
 }
 
-static int read_blob_object(struct strbuf *buf, const unsigned char *sha1, unsigned mode)
+static int read_blob_object(struct strbuf *buf, const struct object_id *oid, unsigned mode)
 {
 	if (S_ISGITLINK(mode)) {
 		strbuf_grow(buf, 100);
-		strbuf_addf(buf, "Subproject commit %s\n", sha1_to_hex(sha1));
+		strbuf_addf(buf, "Subproject commit %s\n", oid_to_hex(oid));
 	} else {
 		enum object_type type;
 		unsigned long sz;
 		char *result;
 
-		result = read_sha1_file(sha1, &type, &sz);
+		result = read_sha1_file(oid->hash, &type, &sz);
 		if (!result)
 			return -1;
 		/* XXX read_sha1_file NUL-terminates */
@@ -3220,7 +3220,7 @@ static int read_file_or_gitlink(const struct cache_entry *ce, struct strbuf *buf
 {
 	if (!ce)
 		return 0;
-	return read_blob_object(buf, ce->oid.hash, ce->ce_mode);
+	return read_blob_object(buf, &ce->oid, ce->ce_mode);
 }
 
 static struct patch *in_fn_table(struct apply_state *state, const char *name)
@@ -3427,17 +3427,17 @@ static int load_preimage(struct apply_state *state,
 
 static int three_way_merge(struct image *image,
 			   char *path,
-			   const unsigned char *base,
-			   const unsigned char *ours,
-			   const unsigned char *theirs)
+			   const struct object_id *base,
+			   const struct object_id *ours,
+			   const struct object_id *theirs)
 {
 	mmfile_t base_file, our_file, their_file;
 	mmbuffer_t result = { NULL };
 	int status;
 
-	read_mmblob(&base_file, base);
-	read_mmblob(&our_file, ours);
-	read_mmblob(&their_file, theirs);
+	read_mmblob(&base_file, base->hash);
+	read_mmblob(&our_file, ours->hash);
+	read_mmblob(&their_file, theirs->hash);
 	status = ll_merge(&result, path,
 			  &base_file, "base",
 			  &our_file, "ours",
@@ -3506,7 +3506,7 @@ static int try_threeway(struct apply_state *state,
 			struct stat *st,
 			const struct cache_entry *ce)
 {
-	unsigned char pre_sha1[20], post_sha1[20], our_sha1[20];
+	struct object_id pre_oid, post_oid, our_oid;
 	struct strbuf buf = STRBUF_INIT;
 	size_t len;
 	int status;
@@ -3520,9 +3520,9 @@ static int try_threeway(struct apply_state *state,
 
 	/* Preimage the patch was prepared for */
 	if (patch->is_new)
-		write_sha1_file("", 0, blob_type, pre_sha1);
-	else if (get_sha1(patch->old_sha1_prefix, pre_sha1) ||
-		 read_blob_object(&buf, pre_sha1, patch->old_mode))
+		write_sha1_file("", 0, blob_type, pre_oid.hash);
+	else if (get_sha1(patch->old_sha1_prefix, pre_oid.hash) ||
+		 read_blob_object(&buf, &pre_oid, patch->old_mode))
 		return error("repository lacks the necessary blob to fall back on 3-way merge.");
 
 	fprintf(stderr, "Falling back to three-way merge...\n");
@@ -3535,7 +3535,7 @@ static int try_threeway(struct apply_state *state,
 		return -1;
 	}
 	/* post_sha1[] is theirs */
-	write_sha1_file(tmp_image.buf, tmp_image.len, blob_type, post_sha1);
+	write_sha1_file(tmp_image.buf, tmp_image.len, blob_type, post_oid.hash);
 	clear_image(&tmp_image);
 
 	/* our_sha1[] is ours */
@@ -3548,12 +3548,12 @@ static int try_threeway(struct apply_state *state,
 			return error("cannot read the current contents of '%s'",
 				     patch->old_name);
 	}
-	write_sha1_file(tmp_image.buf, tmp_image.len, blob_type, our_sha1);
+	write_sha1_file(tmp_image.buf, tmp_image.len, blob_type, our_oid.hash);
 	clear_image(&tmp_image);
 
 	/* in-core three-way merge between post and our using pre as base */
 	status = three_way_merge(image, patch->new_name,
-				 pre_sha1, our_sha1, post_sha1);
+				 &pre_oid, &our_oid, &post_oid);
 	if (status < 0) {
 		fprintf(stderr, "Failed to fall back on three-way merge...\n");
 		return status;
@@ -3564,9 +3564,9 @@ static int try_threeway(struct apply_state *state,
 		if (patch->is_new)
 			oidclr(&patch->threeway_stage[0]);
 		else
-			hashcpy(patch->threeway_stage[0].hash, pre_sha1);
-		hashcpy(patch->threeway_stage[1].hash, our_sha1);
-		hashcpy(patch->threeway_stage[2].hash, post_sha1);
+			oidcpy(&patch->threeway_stage[0], &pre_oid);
+		oidcpy(&patch->threeway_stage[1], &our_oid);
+		oidcpy(&patch->threeway_stage[2], &post_oid);
 		fprintf(stderr, "Applied patch to '%s' with conflicts.\n", patch->new_name);
 	} else {
 		fprintf(stderr, "Applied patch to '%s' cleanly.\n", patch->new_name);
@@ -3949,8 +3949,8 @@ static int check_patch_list(struct apply_state *state, struct patch *patch)
 	return err;
 }
 
-/* This function tries to read the sha1 from the current index */
-static int get_current_sha1(const char *path, unsigned char *sha1)
+/* This function tries to read the object ID from the current index */
+static int get_current_oid(const char *path, struct object_id *oid)
 {
 	int pos;
 
@@ -3959,11 +3959,11 @@ static int get_current_sha1(const char *path, unsigned char *sha1)
 	pos = cache_name_pos(path, strlen(path));
 	if (pos < 0)
 		return -1;
-	hashcpy(sha1, active_cache[pos]->oid.hash);
+	oidcpy(oid, &active_cache[pos]->oid);
 	return 0;
 }
 
-static int preimage_sha1_in_gitlink_patch(struct patch *p, unsigned char sha1[20])
+static int preimage_oid_in_gitlink_patch(struct patch *p, struct object_id *oid)
 {
 	/*
 	 * A usable gitlink patch has only one fragment (hunk) that looks like:
@@ -3987,14 +3987,14 @@ static int preimage_sha1_in_gitlink_patch(struct patch *p, unsigned char sha1[20
 	    (preimage = memchr(hunk->patch, '\n', hunk->size)) != NULL &&
 	    starts_with(++preimage, heading) &&
 	    /* does it record full SHA-1? */
-	    !get_sha1_hex(preimage + sizeof(heading) - 1, sha1) &&
-	    preimage[sizeof(heading) + 40 - 1] == '\n' &&
+	    !get_oid_hex(preimage + sizeof(heading) - 1, oid) &&
+	    preimage[sizeof(heading) + GIT_SHA1_HEXSZ - 1] == '\n' &&
 	    /* does the abbreviated name on the index line agree with it? */
 	    starts_with(preimage + sizeof(heading) - 1, p->old_sha1_prefix))
 		return 0; /* it all looks fine */
 
 	/* we may have full object name on the index line */
-	return get_sha1_hex(p->old_sha1_prefix, sha1);
+	return get_oid_hex(p->old_sha1_prefix, oid);
 }
 
 /* Build an index that contains the just the files needed for a 3way merge */
@@ -4008,7 +4008,7 @@ static void build_fake_ancestor(struct patch *list, const char *filename)
 	 * worth showing the new sha1 prefix, but until then...
 	 */
 	for (patch = list; patch; patch = patch->next) {
-		unsigned char sha1[20];
+		struct object_id oid;
 		struct cache_entry *ce;
 		const char *name;
 
@@ -4017,23 +4017,23 @@ static void build_fake_ancestor(struct patch *list, const char *filename)
 			continue;
 
 		if (S_ISGITLINK(patch->old_mode)) {
-			if (!preimage_sha1_in_gitlink_patch(patch, sha1))
+			if (!preimage_oid_in_gitlink_patch(patch, &oid))
 				; /* ok, the textual part looks sane */
 			else
 				die("sha1 information is lacking or useless for submodule %s",
 				    name);
-		} else if (!get_sha1_blob(patch->old_sha1_prefix, sha1)) {
+		} else if (!get_sha1_blob(patch->old_sha1_prefix, oid.hash)) {
 			; /* ok */
 		} else if (!patch->lines_added && !patch->lines_deleted) {
 			/* mode-only change: update the current */
-			if (get_current_sha1(patch->old_name, sha1))
+			if (get_current_oid(patch->old_name, &oid))
 				die("mode change for %s, which is not "
 				    "in current HEAD", name);
 		} else
 			die("sha1 information is lacking or useless "
 			    "(%s).", name);
 
-		ce = make_cache_entry(patch->old_mode, sha1, name, 0, 0);
+		ce = make_cache_entry(patch->old_mode, oid.hash, name, 0, 0);
 		if (!ce)
 			die(_("make_cache_entry failed for path '%s'"), name);
 		if (add_index_entry(&result, ce, ADD_CACHE_OK_TO_ADD))
@@ -4211,7 +4211,7 @@ static void add_index_file(struct apply_state *state,
 		const char *s;
 
 		if (!skip_prefix(buf, "Subproject commit ", &s) ||
-		    get_sha1_hex(s, ce->oid.hash))
+		    get_oid_hex(s, &ce->oid))
 			die(_("corrupt patch for submodule %s"), path);
 	} else {
 		if (!state->cached) {
