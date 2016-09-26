Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D7E3209AA
	for <e@80x24.org>; Mon, 26 Sep 2016 12:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030356AbcIZMAg (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 08:00:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:48041 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965590AbcIZMAf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 08:00:35 -0400
Received: (qmail 18726 invoked by uid 109); 26 Sep 2016 12:00:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Sep 2016 12:00:35 +0000
Received: (qmail 4431 invoked by uid 111); 26 Sep 2016 12:00:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Sep 2016 08:00:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Sep 2016 08:00:33 -0400
Date:   Mon, 26 Sep 2016 08:00:33 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 09/10] for_each_abbrev: drop duplicate objects
Message-ID: <20160926120032.7zl65iam3hgk5t62@sigill.intra.peff.net>
References: <20160926115720.p2yb22lcq37gboon@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160926115720.p2yb22lcq37gboon@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If an object appears multiple times in the object database
(e.g., in both loose and packed form, or in two separate
packs), the disambiguation machinery may see it more than
once. The get_short_sha1() function handles this already,
but for_each_abbrev() blindly fires the callback for each
instance it finds.

We can fix this by collecting the output in a sha1 array and
de-duplicating it.  As a bonus, the sort done for the
de-duplication means that our output will be stable,
regardless of the order in which the objects are found.

Note that the old code normalized the callback's output to
0/1 to store in the 1-bit ds->ambiguous flag (which both
halted the iteration and was returned from the
for_each_abbrev function). Now that we are using sha1_array,
we can return the real value. In practice, it doesn't matter
as the sole caller only ever returns 0.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_name.c                         | 19 +++++++++++++++----
 t/t1512-rev-parse-disambiguation.sh |  7 +++++++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index d4c7e26..f7403d7 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -7,6 +7,7 @@
 #include "refs.h"
 #include "remote.h"
 #include "dir.h"
+#include "sha1-array.h"
 
 static int get_sha1_oneline(const char *, unsigned char *, struct commit_list *);
 
@@ -355,20 +356,30 @@ static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 	return status;
 }
 
+static int collect_ambiguous(const unsigned char *sha1, void *data)
+{
+	sha1_array_append(data, sha1);
+	return 0;
+}
+
 int for_each_abbrev(const char *prefix, each_abbrev_fn fn, void *cb_data)
 {
+	struct sha1_array collect = SHA1_ARRAY_INIT;
 	struct disambiguate_state ds;
+	int ret;
 
 	if (init_object_disambiguation(prefix, strlen(prefix), &ds) < 0)
 		return -1;
 
 	ds.always_call_fn = 1;
-	ds.cb_data = cb_data;
-	ds.fn = fn;
-
+	ds.fn = collect_ambiguous;
+	ds.cb_data = &collect;
 	find_short_object_filename(&ds);
 	find_short_packed_object(&ds);
-	return ds.ambiguous;
+
+	ret = sha1_array_for_each_unique(&collect, fn, cb_data);
+	sha1_array_clear(&collect);
+	return ret;
 }
 
 int find_unique_abbrev_r(char *hex, const unsigned char *sha1, int len)
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index dfd3567..1d8f550 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -280,6 +280,13 @@ test_expect_success 'rev-parse --disambiguate' '
 	test "$(sed -e "s/^\(.........\).*/\1/" actual | sort -u)" = 000000000
 '
 
+test_expect_success 'rev-parse --disambiguate drops duplicates' '
+	git rev-parse --disambiguate=000000000 >expect &&
+	git pack-objects .git/objects/pack/pack <expect &&
+	git rev-parse --disambiguate=000000000 >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'ambiguous 40-hex ref' '
 	TREE=$(git mktree </dev/null) &&
 	REF=$(git rev-parse HEAD) &&
-- 
2.10.0.492.g14f803f

