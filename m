Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2F812018E
	for <e@80x24.org>; Sun, 28 Aug 2016 23:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932411AbcH1X2m (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Aug 2016 19:28:42 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:41056 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756192AbcH1X2H (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 Aug 2016 19:28:07 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id EA2E7280B2;
        Sun, 28 Aug 2016 23:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1472426884;
        bh=7DJcov5Oxl4srAw9IiKLTa2+xSjsfM8UhxVOQQ564xM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yn306c4c71gr/X0bVikMFDbhnSedp/PBdEpocIFWXhQp0sWuvIw8HfFNZqtl86vtB
         i7fKbQWOG0xXbosvnbqf77U7PeF5qJYF8VXsEXURMsOxCPhn65NMbypBOCZzUYs+cW
         1ieWGsDg1poJCo3yXTcfv0xaZ9Z8XWvIu3Okhyt6KOvm3pbGIY3Lev0Au0MYK4OQeZ
         OULrXu1zR50FYsHyVWvektLSaIoOMbCpTAIAsPnzj1+ZSpYei+VVafYAv+sqHahS0y
         IgRJccKgHapouG07QP53zcl8Dvm0wfsZBZ0gvjtQRJJ3fFsO4Am6+gQ1h5lEOiAEph
         yKBh15cCVCHpY2mWjYToraIqhbf+GkS2FIaL8ibuqrfHneyC214war5N+AstKOV5NQ
         TKgXOycHp6T24Kg+ikksiwWvemm6IoLWxvs4mHxNkK8IJSmDlQsBlQ/2dI7AD3/7l7
         aOWmdoGpx/3VdnIoMMIU68Z11i6kgH1ZObPPCh/Rr6U0CIv/eij
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Paul Tan <pyokagan@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH 11/20] Convert read_mmblob to take struct object_id.
Date:   Sun, 28 Aug 2016 23:27:48 +0000
Message-Id: <20160828232757.373278-12-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160828232757.373278-1-sandals@crustytoothpaste.net>
References: <20160828232757.373278-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since all of its callers have been updated, convert read_mmblob to take
a pointer to struct object_id.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/apply.c    | 6 +++---
 builtin/checkout.c | 6 +++---
 merge-recursive.c  | 6 +++---
 notes-merge.c      | 6 +++---
 xdiff-interface.c  | 8 ++++----
 xdiff-interface.h  | 3 ++-
 6 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 76b16121..df2c95d3 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3435,9 +3435,9 @@ static int three_way_merge(struct image *image,
 	mmbuffer_t result = { NULL };
 	int status;
 
-	read_mmblob(&base_file, base->hash);
-	read_mmblob(&our_file, ours->hash);
-	read_mmblob(&their_file, theirs->hash);
+	read_mmblob(&base_file, base);
+	read_mmblob(&our_file, ours);
+	read_mmblob(&their_file, theirs);
 	status = ll_merge(&result, path,
 			  &base_file, "base",
 			  &our_file, "ours",
diff --git a/builtin/checkout.c b/builtin/checkout.c
index ec85af56..13169221 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -195,9 +195,9 @@ static int checkout_merged(int pos, struct checkout *state)
 	if (is_null_oid(&threeway[1]) || is_null_oid(&threeway[2]))
 		return error(_("path '%s' does not have necessary versions"), path);
 
-	read_mmblob(&ancestor, threeway[0].hash);
-	read_mmblob(&ours, threeway[1].hash);
-	read_mmblob(&theirs, threeway[2].hash);
+	read_mmblob(&ancestor, &threeway[0]);
+	read_mmblob(&ours, &threeway[1]);
+	read_mmblob(&theirs, &threeway[2]);
 
 	/*
 	 * NEEDSWORK: re-create conflicts from merges with
diff --git a/merge-recursive.c b/merge-recursive.c
index e3db594d..3750d253 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -910,9 +910,9 @@ static int merge_3way(struct merge_options *o,
 		name2 = mkpathdup("%s", branch2);
 	}
 
-	read_mmblob(&orig, one->oid.hash);
-	read_mmblob(&src1, a->oid.hash);
-	read_mmblob(&src2, b->oid.hash);
+	read_mmblob(&orig, &one->oid);
+	read_mmblob(&src1, &a->oid);
+	read_mmblob(&src2, &b->oid);
 
 	merge_status = ll_merge(result_buf, a->path, &orig, base_name,
 				&src1, name1, &src2, name2, &ll_opts);
diff --git a/notes-merge.c b/notes-merge.c
index 68129cdb..d405a412 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -343,9 +343,9 @@ static int ll_merge_in_worktree(struct notes_merge_options *o,
 	mmfile_t base, local, remote;
 	int status;
 
-	read_mmblob(&base, p->base.hash);
-	read_mmblob(&local, p->local.hash);
-	read_mmblob(&remote, p->remote.hash);
+	read_mmblob(&base, &p->base);
+	read_mmblob(&local, &p->local);
+	read_mmblob(&remote, &p->remote);
 
 	status = ll_merge(&result_buf, oid_to_hex(&p->obj), &base, NULL,
 			  &local, o->local_ref, &remote, o->remote_ref, NULL);
diff --git a/xdiff-interface.c b/xdiff-interface.c
index f34ea762..3bfc69ca 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -178,20 +178,20 @@ int read_mmfile(mmfile_t *ptr, const char *filename)
 	return 0;
 }
 
-void read_mmblob(mmfile_t *ptr, const unsigned char *sha1)
+void read_mmblob(mmfile_t *ptr, const struct object_id *oid)
 {
 	unsigned long size;
 	enum object_type type;
 
-	if (!hashcmp(sha1, null_sha1)) {
+	if (!oidcmp(oid, &null_oid)) {
 		ptr->ptr = xstrdup("");
 		ptr->size = 0;
 		return;
 	}
 
-	ptr->ptr = read_sha1_file(sha1, &type, &size);
+	ptr->ptr = read_sha1_file(oid->hash, &type, &size);
 	if (!ptr->ptr || type != OBJ_BLOB)
-		die("unable to read blob object %s", sha1_to_hex(sha1));
+		die("unable to read blob object %s", oid_to_hex(oid));
 	ptr->size = size;
 }
 
diff --git a/xdiff-interface.h b/xdiff-interface.h
index fbb5a1c3..6f6ba909 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -1,6 +1,7 @@
 #ifndef XDIFF_INTERFACE_H
 #define XDIFF_INTERFACE_H
 
+#include "cache.h"
 #include "xdiff/xdiff.h"
 
 /*
@@ -20,7 +21,7 @@ int parse_hunk_header(char *line, int len,
 		      int *ob, int *on,
 		      int *nb, int *nn);
 int read_mmfile(mmfile_t *ptr, const char *filename);
-void read_mmblob(mmfile_t *ptr, const unsigned char *sha1);
+void read_mmblob(mmfile_t *ptr, const struct object_id *oid);
 int buffer_is_binary(const char *ptr, unsigned long size);
 
 extern void xdiff_set_find_func(xdemitconf_t *xecfg, const char *line, int cflags);
