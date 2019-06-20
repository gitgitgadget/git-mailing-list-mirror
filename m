Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B30201F462
	for <e@80x24.org>; Thu, 20 Jun 2019 07:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbfFTHlU (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 03:41:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:45340 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726732AbfFTHlT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 03:41:19 -0400
Received: (qmail 16580 invoked by uid 109); 20 Jun 2019 07:41:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Jun 2019 07:41:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12845 invoked by uid 111); 20 Jun 2019 07:42:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 20 Jun 2019 03:42:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jun 2019 03:41:17 -0400
Date:   Thu, 20 Jun 2019 03:41:17 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 08/17] object: convert internal hash_obj() to object_id
Message-ID: <20190620074117.GH3713@sigill.intra.peff.net>
References: <20190620073952.GA1539@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190620073952.GA1539@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that lookup_object() has an object_id, we can consistently pass that
around instead of a raw sha1. We still convert to a hash to pass to
sha1hash(), but the goal is for that to go away shortly.

Signed-off-by: Jeff King <peff@peff.net>
---
 object.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/object.c b/object.c
index 34c1d0dc8f..dbfdbe504d 100644
--- a/object.c
+++ b/object.c
@@ -59,9 +59,9 @@ int type_from_string_gently(const char *str, ssize_t len, int gentle)
  * the specified sha1.  n must be a power of 2.  Please note that the
  * return value is *not* consistent across computer architectures.
  */
-static unsigned int hash_obj(const unsigned char *sha1, unsigned int n)
+static unsigned int hash_obj(const struct object_id *oid, unsigned int n)
 {
-	return sha1hash(sha1) & (n - 1);
+	return sha1hash(oid->hash) & (n - 1);
 }
 
 /*
@@ -71,7 +71,7 @@ static unsigned int hash_obj(const unsigned char *sha1, unsigned int n)
  */
 static void insert_obj_hash(struct object *obj, struct object **hash, unsigned int size)
 {
-	unsigned int j = hash_obj(obj->oid.hash, size);
+	unsigned int j = hash_obj(&obj->oid, size);
 
 	while (hash[j]) {
 		j++;
@@ -93,7 +93,7 @@ struct object *lookup_object(struct repository *r, const struct object_id *oid)
 	if (!r->parsed_objects->obj_hash)
 		return NULL;
 
-	first = i = hash_obj(oid->hash, r->parsed_objects->obj_hash_size);
+	first = i = hash_obj(oid, r->parsed_objects->obj_hash_size);
 	while ((obj = r->parsed_objects->obj_hash[i]) != NULL) {
 		if (oideq(oid, &obj->oid))
 			break;
-- 
2.22.0.732.g5402924b4b

