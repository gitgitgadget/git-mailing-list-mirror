Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDAF51F803
	for <e@80x24.org>; Mon,  7 Jan 2019 08:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfAGIhc (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 03:37:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:56366 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725550AbfAGIhb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 03:37:31 -0500
Received: (qmail 1524 invoked by uid 109); 7 Jan 2019 08:37:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 07 Jan 2019 08:37:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 780 invoked by uid 111); 7 Jan 2019 08:37:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 07 Jan 2019 03:37:10 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Jan 2019 03:37:29 -0500
Date:   Mon, 7 Jan 2019 03:37:29 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 06/11] sha1-file: convert pass-through functions to object_id
Message-ID: <20190107083729.GF29431@sigill.intra.peff.net>
References: <20190107083150.GC21362@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190107083150.GC21362@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These two static functions, read_object() and quick_has_loose(), both
have to hashcpy() their bare-sha1 arguments into object_id structs to
pass them along. Since all of their callers actually have object_id
structs in the first place, we can eliminate the copying by adjusting
their input parameters.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1-file.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/sha1-file.c b/sha1-file.c
index 4938258ed1..589a666686 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -922,16 +922,13 @@ static int open_loose_object(struct repository *r,
 }
 
 static int quick_has_loose(struct repository *r,
-			   const unsigned char *sha1)
+			   const struct object_id *oid)
 {
-	struct object_id oid;
 	struct object_directory *odb;
 
-	hashcpy(oid.hash, sha1);
-
 	prepare_alt_odb(r);
 	for (odb = r->objects->odb; odb; odb = odb->next) {
-		if (oid_array_lookup(odb_loose_cache(odb, &oid), &oid) >= 0)
+		if (oid_array_lookup(odb_loose_cache(odb, oid), oid) >= 0)
 			return 1;
 	}
 	return 0;
@@ -1191,7 +1188,7 @@ static int loose_object_info(struct repository *r,
 		const char *path;
 		struct stat st;
 		if (!oi->disk_sizep && (flags & OBJECT_INFO_QUICK))
-			return quick_has_loose(r, oid->hash) ? 0 : -1;
+			return quick_has_loose(r, oid) ? 0 : -1;
 		if (stat_loose_object(r, oid, &st, &path) < 0)
 			return -1;
 		if (oi->disk_sizep)
@@ -1355,19 +1352,16 @@ int oid_object_info(struct repository *r,
 	return type;
 }
 
-static void *read_object(const unsigned char *sha1, enum object_type *type,
+static void *read_object(const struct object_id *oid, enum object_type *type,
 			 unsigned long *size)
 {
-	struct object_id oid;
 	struct object_info oi = OBJECT_INFO_INIT;
 	void *content;
 	oi.typep = type;
 	oi.sizep = size;
 	oi.contentp = &content;
 
-	hashcpy(oid.hash, sha1);
-
-	if (oid_object_info_extended(the_repository, &oid, &oi, 0) < 0)
+	if (oid_object_info_extended(the_repository, oid, &oi, 0) < 0)
 		return NULL;
 	return content;
 }
@@ -1408,7 +1402,7 @@ void *read_object_file_extended(const struct object_id *oid,
 		lookup_replace_object(the_repository, oid) : oid;
 
 	errno = 0;
-	data = read_object(repl->hash, type, size);
+	data = read_object(repl, type, size);
 	if (data)
 		return data;
 
@@ -1748,7 +1742,7 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
 
 	if (has_loose_object(oid))
 		return 0;
-	buf = read_object(oid->hash, &type, &len);
+	buf = read_object(oid, &type, &len);
 	if (!buf)
 		return error(_("cannot read sha1_file for %s"), oid_to_hex(oid));
 	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX , type_name(type), (uintmax_t)len) + 1;
-- 
2.20.1.470.g640a3e2614

