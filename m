Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF3FC35669
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 04:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD54520661
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 04:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbgBXEg5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Feb 2020 23:36:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:52346 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727186AbgBXEg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Feb 2020 23:36:57 -0500
Received: (qmail 5242 invoked by uid 109); 24 Feb 2020 04:36:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Feb 2020 04:36:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6984 invoked by uid 111); 24 Feb 2020 04:46:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 23 Feb 2020 23:46:02 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 23 Feb 2020 23:36:56 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 08/10] packed_object_info(): use object_id for returning
 delta base
Message-ID: <20200224043656.GH1018190@coredump.intra.peff.net>
References: <20200224042625.GA1015553@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200224042625.GA1015553@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a caller sets the object_info.delta_base_sha1 to a non-NULL pointer,
we'll write the oid of the object's delta base to it. But we can
increase our type safety by switching this to a real object_id struct.
All of our callers are just pointing into the hash member of an
object_id anyway, so there's no inconvenience.

Note that we do still keep it as a pointer-to-struct, because the NULL
sentinel value tells us whether the caller is even interested in the
information.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c | 2 +-
 object-store.h     | 2 +-
 packfile.c         | 6 +++---
 ref-filter.c       | 4 ++--
 sha1-file.c        | 8 ++++----
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index d6a1aa74cd..272f9fc6d7 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -262,7 +262,7 @@ static void expand_atom(struct strbuf *sb, const char *atom, int len,
 			strbuf_addstr(sb, data->rest);
 	} else if (is_atom("deltabase", atom, len)) {
 		if (data->mark_query)
-			data->info.delta_base_sha1 = data->delta_base_oid.hash;
+			data->info.delta_base_oid = &data->delta_base_oid;
 		else
 			strbuf_addstr(sb,
 				      oid_to_hex(&data->delta_base_oid));
diff --git a/object-store.h b/object-store.h
index 5b047637e3..be72fee7d5 100644
--- a/object-store.h
+++ b/object-store.h
@@ -300,7 +300,7 @@ struct object_info {
 	enum object_type *typep;
 	unsigned long *sizep;
 	off_t *disk_sizep;
-	unsigned char *delta_base_sha1;
+	struct object_id *delta_base_oid;
 	struct strbuf *type_name;
 	void **contentp;
 
diff --git a/packfile.c b/packfile.c
index 947c3f8e5d..ec7349bb86 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1556,7 +1556,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 		}
 	}
 
-	if (oi->delta_base_sha1) {
+	if (oi->delta_base_oid) {
 		if (type == OBJ_OFS_DELTA || type == OBJ_REF_DELTA) {
 			const unsigned char *base;
 
@@ -1567,9 +1567,9 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 				goto out;
 			}
 
-			hashcpy(oi->delta_base_sha1, base);
+			hashcpy(oi->delta_base_oid->hash, base);
 		} else
-			hashclr(oi->delta_base_sha1);
+			oidclr(oi->delta_base_oid);
 	}
 
 	oi->whence = in_delta_base_cache(p, obj_offset) ? OI_DBCACHED :
diff --git a/ref-filter.c b/ref-filter.c
index 6867e33648..79bb520678 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -279,9 +279,9 @@ static int deltabase_atom_parser(const struct ref_format *format, struct used_at
 	if (arg)
 		return strbuf_addf_ret(err, -1, _("%%(deltabase) does not take arguments"));
 	if (*atom->name == '*')
-		oi_deref.info.delta_base_sha1 = oi_deref.delta_base_oid.hash;
+		oi_deref.info.delta_base_oid = &oi_deref.delta_base_oid;
 	else
-		oi.info.delta_base_sha1 = oi.delta_base_oid.hash;
+		oi.info.delta_base_oid = &oi.delta_base_oid;
 	return 0;
 }
 
diff --git a/sha1-file.c b/sha1-file.c
index d785de8a85..616886799e 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1354,8 +1354,8 @@ static int loose_object_info(struct repository *r,
 	struct strbuf hdrbuf = STRBUF_INIT;
 	unsigned long size_scratch;
 
-	if (oi->delta_base_sha1)
-		hashclr(oi->delta_base_sha1);
+	if (oi->delta_base_oid)
+		oidclr(oi->delta_base_oid);
 
 	/*
 	 * If we don't care about type or size, then we don't
@@ -1474,8 +1474,8 @@ static int do_oid_object_info_extended(struct repository *r,
 			*(oi->sizep) = co->size;
 		if (oi->disk_sizep)
 			*(oi->disk_sizep) = 0;
-		if (oi->delta_base_sha1)
-			hashclr(oi->delta_base_sha1);
+		if (oi->delta_base_oid)
+			oidclr(oi->delta_base_oid);
 		if (oi->type_name)
 			strbuf_addstr(oi->type_name, type_name(co->type));
 		if (oi->contentp)
-- 
2.25.1.823.g95c5488cf7

