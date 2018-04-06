Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E50B61F404
	for <e@80x24.org>; Fri,  6 Apr 2018 18:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751944AbeDFS6g (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 14:58:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:56156 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751276AbeDFS6e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 14:58:34 -0400
Received: (qmail 23504 invoked by uid 109); 6 Apr 2018 18:58:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Apr 2018 18:58:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28066 invoked by uid 111); 6 Apr 2018 18:59:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 06 Apr 2018 14:59:35 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Apr 2018 14:58:32 -0400
Date:   Fri, 6 Apr 2018 14:58:32 -0400
From:   Jeff King <peff@peff.net>
To:     Harald Nordgren <haraldnordgren@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/3] ref-filter: use "struct object_id" consistently
Message-ID: <20180406185831.GA11108@sigill.intra.peff.net>
References: <20180406185801.GA921@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180406185801.GA921@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Internally we store a "struct object_id", and all of our
callers have one to pass us. But we insist that they peel it
to its bare-sha1 hash, which we then hashcpy() into place.
Let's pass it around as an object_id, which future-proofs us
for a post-sha1 world.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/tag.c        |  2 +-
 builtin/verify-tag.c |  2 +-
 ref-filter.c         | 10 +++++-----
 ref-filter.h         |  2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index da186691ed..42278f5167 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -117,7 +117,7 @@ static int verify_tag(const char *name, const char *ref,
 		return -1;
 
 	if (format->format)
-		pretty_print_ref(name, oid->hash, format);
+		pretty_print_ref(name, oid, format);
 
 	return 0;
 }
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index ad7b79fa5c..6fa04b751a 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -72,7 +72,7 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 		}
 
 		if (format.format)
-			pretty_print_ref(name, oid.hash, &format);
+			pretty_print_ref(name, &oid, &format);
 	}
 	return had_error;
 }
diff --git a/ref-filter.c b/ref-filter.c
index 45fc56216a..ade97a8486 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1826,12 +1826,12 @@ static const struct object_id *match_points_at(struct oid_array *points_at,
 
 /* Allocate space for a new ref_array_item and copy the objectname and flag to it */
 static struct ref_array_item *new_ref_array_item(const char *refname,
-						 const unsigned char *objectname,
+						 const struct object_id *oid,
 						 int flag)
 {
 	struct ref_array_item *ref;
 	FLEX_ALLOC_STR(ref, refname, refname);
-	hashcpy(ref->objectname.hash, objectname);
+	oidcpy(&ref->objectname, oid);
 	ref->flag = flag;
 
 	return ref;
@@ -1927,7 +1927,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 	 * to do its job and the resulting list may yet to be pruned
 	 * by maxcount logic.
 	 */
-	ref = new_ref_array_item(refname, oid->hash, flag);
+	ref = new_ref_array_item(refname, oid, flag);
 	ref->commit = commit;
 
 	REALLOC_ARRAY(ref_cbdata->array->items, ref_cbdata->array->nr + 1);
@@ -2165,11 +2165,11 @@ void show_ref_array_item(struct ref_array_item *info,
 	putchar('\n');
 }
 
-void pretty_print_ref(const char *name, const unsigned char *sha1,
+void pretty_print_ref(const char *name, const struct object_id *oid,
 		      const struct ref_format *format)
 {
 	struct ref_array_item *ref_item;
-	ref_item = new_ref_array_item(name, sha1, 0);
+	ref_item = new_ref_array_item(name, oid, 0);
 	ref_item->kind = ref_kind_from_refname(name);
 	show_ref_array_item(ref_item, format);
 	free_array_item(ref_item);
diff --git a/ref-filter.h b/ref-filter.h
index 0d98342b34..68268f9ebc 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -132,7 +132,7 @@ void setup_ref_filter_porcelain_msg(void);
  * Print a single ref, outside of any ref-filter. Note that the
  * name must be a fully qualified refname.
  */
-void pretty_print_ref(const char *name, const unsigned char *sha1,
+void pretty_print_ref(const char *name, const struct object_id *oid,
 		      const struct ref_format *format);
 
 #endif /*  REF_FILTER_H  */
-- 
2.17.0.686.g08b0810b04

