Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FE191F829
	for <e@80x24.org>; Mon,  1 May 2017 02:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425886AbdEACcV (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 22:32:21 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:36056 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2999504AbdEACbM (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 30 Apr 2017 22:31:12 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 8E8EF280D9;
        Mon,  1 May 2017 02:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1493605814;
        bh=AIX5H24+nl8PJ1JUs0Jvy6qEQ4Jp8TAXhNfggaJZgrY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iq3l2zHjU50uR1bSsePENvPpGKuPm391hY8oIcK4rQu8TPCTzMS9OUWY1diC7FcQr
         u/HbAt83qFkaCB6FAinSpN6FNjj/M3RToLqFxmE0OOF2yW+4QNUNCFW9z1p602tbPq
         ea4zaVb40XtRq3VKYwkQTVVu0KOMZJ0JpJ81sDeeo2jzWaMWqKbV9e028XcahmDv/i
         iekEEkpqZ1O2VnFFSDhWA0H05aj8ihPoGx+NojI2t3jwGCRCp2x0x2u3ZTVTT/MyDH
         bSaTaSNe85cdgAmivPjEFj2VI0LJ8mL5i12ocP+0PTsiZAwEGxGviP/fxMI9s5PQJW
         WZ4VthcTB/MvoiFt3TKJPb/bW1d9SXREQAkyRFujyYMVcM4sTignD+bn0/fFAQu2o8
         QbGwBqoI3JIONBa9xhvJwqV7gF1iEwu3oTrmV725ejb6gfRdHqn5/ITbtFILe+hIRy
         H3BY7a3aExYNPyt3nTBQLgRL7gdo15L3E0I1WJV95zEsfg9KU84
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 41/53] revision: rename add_pending_sha1 to add_pending_oid
Date:   Mon,  1 May 2017 02:29:34 +0000
Message-Id: <20170501022946.258735-42-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d
In-Reply-To: <20170501022946.258735-1-sandals@crustytoothpaste.net>
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename this function and convert it to take a pointer to struct
object_id.

This is a prerequisite for converting get_reference, which is needed to
convert parse_object.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/am.c       | 2 +-
 builtin/checkout.c | 4 ++--
 revision.c         | 8 ++++----
 revision.h         | 6 +++---
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 7663f12e6..642d7047d 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1618,7 +1618,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 		init_revisions(&rev_info, NULL);
 		rev_info.diffopt.output_format = DIFF_FORMAT_NAME_STATUS;
 		diff_opt_parse(&rev_info.diffopt, &diff_filter_str, 1, rev_info.prefix);
-		add_pending_sha1(&rev_info, "HEAD", our_tree.hash, 0);
+		add_pending_oid(&rev_info, "HEAD", &our_tree, 0);
 		diff_setup_done(&rev_info.diffopt);
 		run_diff_index(&rev_info, 1);
 	}
diff --git a/builtin/checkout.c b/builtin/checkout.c
index afa99fb8a..7f1eeea94 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -721,7 +721,7 @@ static int add_pending_uninteresting_ref(const char *refname,
 					 const struct object_id *oid,
 					 int flags, void *cb_data)
 {
-	add_pending_sha1(cb_data, refname, oid->hash, UNINTERESTING);
+	add_pending_oid(cb_data, refname, oid, UNINTERESTING);
 	return 0;
 }
 
@@ -807,7 +807,7 @@ static void orphaned_commit_warning(struct commit *old, struct commit *new)
 	add_pending_object(&revs, object, oid_to_hex(&object->oid));
 
 	for_each_ref(add_pending_uninteresting_ref, &revs);
-	add_pending_sha1(&revs, "HEAD", new->object.oid.hash, UNINTERESTING);
+	add_pending_oid(&revs, "HEAD", &new->object.oid, UNINTERESTING);
 
 	refs = revs.pending;
 	revs.leak_pending = 1;
diff --git a/revision.c b/revision.c
index c2091b6de..f82c56e1f 100644
--- a/revision.c
+++ b/revision.c
@@ -203,10 +203,10 @@ static struct object *get_reference(struct rev_info *revs, const char *name,
 	return object;
 }
 
-void add_pending_sha1(struct rev_info *revs, const char *name,
-		      const unsigned char *sha1, unsigned int flags)
+void add_pending_oid(struct rev_info *revs, const char *name,
+		      const struct object_id *oid, unsigned int flags)
 {
-	struct object *object = get_reference(revs, name, sha1, flags);
+	struct object *object = get_reference(revs, name, oid->hash, flags);
 	add_pending_object(revs, object, name);
 }
 
@@ -1159,7 +1159,7 @@ static int handle_one_ref(const char *path, const struct object_id *oid,
 
 	object = get_reference(cb->all_revs, path, oid->hash, cb->all_flags);
 	add_rev_cmdline(cb->all_revs, object, path, REV_CMD_REF, cb->all_flags);
-	add_pending_sha1(cb->all_revs, path, oid->hash, cb->all_flags);
+	add_pending_oid(cb->all_revs, path, oid, cb->all_flags);
 	return 0;
 }
 
diff --git a/revision.h b/revision.h
index 14886ec92..728425a02 100644
--- a/revision.h
+++ b/revision.h
@@ -263,9 +263,9 @@ extern void show_object_with_name(FILE *, struct object *, const char *);
 
 extern void add_pending_object(struct rev_info *revs,
 			       struct object *obj, const char *name);
-extern void add_pending_sha1(struct rev_info *revs,
-			     const char *name, const unsigned char *sha1,
-			     unsigned int flags);
+extern void add_pending_oid(struct rev_info *revs,
+			    const char *name, const struct object_id *oid,
+			    unsigned int flags);
 
 extern void add_head_to_pending(struct rev_info *);
 extern void add_reflogs_to_pending(struct rev_info *, unsigned int flags);
