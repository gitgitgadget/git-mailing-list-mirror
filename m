Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FF811F404
	for <e@80x24.org>; Wed, 14 Feb 2018 18:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161632AbeBNSIW (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 13:08:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:52286 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1161585AbeBNSIW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 13:08:22 -0500
Received: (qmail 29354 invoked by uid 109); 14 Feb 2018 18:08:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 14 Feb 2018 18:08:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31045 invoked by uid 111); 14 Feb 2018 18:09:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 14 Feb 2018 13:09:06 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Feb 2018 13:08:20 -0500
Date:   Wed, 14 Feb 2018 13:08:20 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 5/6] test-hashmap: simplify alloc_test_entry
Message-ID: <20180214180819.GE9919@sigill.intra.peff.net>
References: <20180214180322.GA9190@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180214180322.GA9190@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function takes two ptr/len pairs, which implies that
they can be arbitrary buffers. But internally, it assumes
that each "ptr" is NUL-terminated at "len" (because we
memcpy an extra byte to pick up the NUL terminator).

In practice this works because each caller only ever passes
strlen(ptr) as the length. But let's drop the "len"
parameters to make our expectations clear.

Note that we can get rid of the "l1" and "l2" variables from
cmd_main() as a further cleanup, since they are now mostly
used to check whether the p1 and p2 arguments are present
(technically the length parameters conflated NULL with the
empty string, which we no longer do, but I think that is
actually an improvement).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/helper/test-hashmap.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
index 15fc4e372f..56efff36e8 100644
--- a/t/helper/test-hashmap.c
+++ b/t/helper/test-hashmap.c
@@ -30,9 +30,10 @@ static int test_entry_cmp(const void *cmp_data,
 		return strcmp(e1->key, key ? key : e2->key);
 }
 
-static struct test_entry *alloc_test_entry(int hash, char *key, int klen,
-		char *value, int vlen)
+static struct test_entry *alloc_test_entry(int hash, char *key, char *value)
 {
+	size_t klen = strlen(key);
+	size_t vlen = strlen(value);
 	struct test_entry *entry = xmalloc(st_add4(sizeof(*entry), klen, vlen, 2));
 	hashmap_entry_init(entry, hash);
 	memcpy(entry->key, key, klen + 1);
@@ -89,7 +90,7 @@ static void perf_hashmap(unsigned int method, unsigned int rounds)
 	ALLOC_ARRAY(hashes, TEST_SIZE);
 	for (i = 0; i < TEST_SIZE; i++) {
 		xsnprintf(buf, sizeof(buf), "%i", i);
-		entries[i] = alloc_test_entry(0, buf, strlen(buf), "", 0);
+		entries[i] = alloc_test_entry(0, buf, "");
 		hashes[i] = hash(method, i, entries[i]->key);
 	}
 
@@ -155,7 +156,7 @@ int cmd_main(int argc, const char **argv)
 	/* process commands from stdin */
 	while (strbuf_getline(&line, stdin) != EOF) {
 		char *cmd, *p1 = NULL, *p2 = NULL;
-		int l1 = 0, l2 = 0, hash = 0;
+		int hash = 0;
 		struct test_entry *entry;
 
 		/* break line into command and up to two parameters */
@@ -166,31 +167,29 @@ int cmd_main(int argc, const char **argv)
 
 		p1 = strtok(NULL, DELIM);
 		if (p1) {
-			l1 = strlen(p1);
 			hash = icase ? strihash(p1) : strhash(p1);
 			p2 = strtok(NULL, DELIM);
-			if (p2)
-				l2 = strlen(p2);
 		}
 
-		if (!strcmp("hash", cmd) && l1) {
+		if (!strcmp("hash", cmd) && p1) {
 
 			/* print results of different hash functions */
-			printf("%u %u %u %u\n", strhash(p1), memhash(p1, l1),
-					strihash(p1), memihash(p1, l1));
+			printf("%u %u %u %u\n",
+			       strhash(p1), memhash(p1, strlen(p1)),
+			       strihash(p1), memihash(p1, strlen(p1)));
 
-		} else if (!strcmp("add", cmd) && l1 && l2) {
+		} else if (!strcmp("add", cmd) && p1 && p2) {
 
 			/* create entry with key = p1, value = p2 */
-			entry = alloc_test_entry(hash, p1, l1, p2, l2);
+			entry = alloc_test_entry(hash, p1, p2);
 
 			/* add to hashmap */
 			hashmap_add(&map, entry);
 
-		} else if (!strcmp("put", cmd) && l1 && l2) {
+		} else if (!strcmp("put", cmd) && p1 && p2) {
 
 			/* create entry with key = p1, value = p2 */
-			entry = alloc_test_entry(hash, p1, l1, p2, l2);
+			entry = alloc_test_entry(hash, p1, p2);
 
 			/* add / replace entry */
 			entry = hashmap_put(&map, entry);
@@ -199,7 +198,7 @@ int cmd_main(int argc, const char **argv)
 			puts(entry ? get_value(entry) : "NULL");
 			free(entry);
 
-		} else if (!strcmp("get", cmd) && l1) {
+		} else if (!strcmp("get", cmd) && p1) {
 
 			/* lookup entry in hashmap */
 			entry = hashmap_get_from_hash(&map, hash, p1);
@@ -212,7 +211,7 @@ int cmd_main(int argc, const char **argv)
 				entry = hashmap_get_next(&map, entry);
 			}
 
-		} else if (!strcmp("remove", cmd) && l1) {
+		} else if (!strcmp("remove", cmd) && p1) {
 
 			/* setup static key */
 			struct hashmap_entry key;
@@ -238,7 +237,7 @@ int cmd_main(int argc, const char **argv)
 			printf("%u %u\n", map.tablesize,
 			       hashmap_get_size(&map));
 
-		} else if (!strcmp("intern", cmd) && l1) {
+		} else if (!strcmp("intern", cmd) && p1) {
 
 			/* test that strintern works */
 			const char *i1 = strintern(p1);
@@ -252,7 +251,7 @@ int cmd_main(int argc, const char **argv)
 			else
 				printf("%s\n", i1);
 
-		} else if (!strcmp("perfhashmap", cmd) && l1 && l2) {
+		} else if (!strcmp("perfhashmap", cmd) && p1 && p2) {
 
 			perf_hashmap(atoi(p1), atoi(p2));
 
-- 
2.16.1.464.gc4bae515b7

