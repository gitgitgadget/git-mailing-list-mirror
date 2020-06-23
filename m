Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43491C433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 15:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A25920776
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 15:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732997AbgFWPYx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 11:24:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:40130 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732885AbgFWPYx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 11:24:53 -0400
Received: (qmail 11809 invoked by uid 109); 23 Jun 2020 15:24:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Jun 2020 15:24:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16913 invoked by uid 111); 23 Jun 2020 15:24:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Jun 2020 11:24:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 23 Jun 2020 11:24:51 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 03/10] fast-export: store anonymized oids as hex strings
Message-ID: <20200623152451.GC1435482@coredump.intra.peff.net>
References: <20200623152436.GA50925@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200623152436.GA50925@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When fast-export stores anonymized oids, it does so as binary strings.
And while the anonymous mapping storage is binary-clean (at least as of
the previous commit), this will become awkward when we start exposing
more of it to the user. In particular, if we allow a method for
retaining token "foo", then users may want to specify a hex oid as such
a token.

Let's just switch to storing the hex strings. The difference in memory
usage is negligible (especially considering how infrequently we'd
generally store an oid compared to, say, path components).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fast-export.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 289395a131..4a3a4c933e 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -387,16 +387,19 @@ static void *generate_fake_oid(const void *old, size_t *len)
 {
 	static uint32_t counter = 1; /* avoid null oid */
 	const unsigned hashsz = the_hash_algo->rawsz;
-	unsigned char *out = xcalloc(hashsz, 1);
-	put_be32(out + hashsz - 4, counter++);
-	return out;
+	struct object_id oid;
+	char *hex = xmallocz(GIT_MAX_HEXSZ);
+
+	oidclr(&oid);
+	put_be32(oid.hash + hashsz - 4, counter++);
+	return oid_to_hex_r(hex, &oid);
 }
 
-static const struct object_id *anonymize_oid(const struct object_id *oid)
+static const char *anonymize_oid(const char *oid_hex)
 {
 	static struct hashmap objs;
-	size_t len = the_hash_algo->rawsz;
-	return anonymize_mem(&objs, generate_fake_oid, oid, &len);
+	size_t len = strlen(oid_hex);
+	return anonymize_mem(&objs, generate_fake_oid, oid_hex, &len);
 }
 
 static void show_filemodify(struct diff_queue_struct *q,
@@ -455,9 +458,9 @@ static void show_filemodify(struct diff_queue_struct *q,
 			 */
 			if (no_data || S_ISGITLINK(spec->mode))
 				printf("M %06o %s ", spec->mode,
-				       oid_to_hex(anonymize ?
-						  anonymize_oid(&spec->oid) :
-						  &spec->oid));
+				       anonymize ?
+				       anonymize_oid(oid_to_hex(&spec->oid)) :
+				       oid_to_hex(&spec->oid));
 			else {
 				struct object *object = lookup_object(the_repository,
 								      &spec->oid);
@@ -712,9 +715,10 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 		if (mark)
 			printf(":%d\n", mark);
 		else
-			printf("%s\n", oid_to_hex(anonymize ?
-						  anonymize_oid(&obj->oid) :
-						  &obj->oid));
+			printf("%s\n",
+			       anonymize ?
+			       anonymize_oid(oid_to_hex(&obj->oid)) :
+			       oid_to_hex(&obj->oid));
 		i++;
 	}
 
-- 
2.27.0.517.gbc32778fa3

