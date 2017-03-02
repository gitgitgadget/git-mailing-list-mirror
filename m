Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39F142013E
	for <e@80x24.org>; Thu,  2 Mar 2017 23:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751132AbdCBXh5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 18:37:57 -0500
Received: from aserp1050.oracle.com ([141.146.126.70]:18277 "EHLO
        aserp1050.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdCBXh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 18:37:56 -0500
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
        by aserp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v22Hb0Uc011115
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <git@vger.kernel.org>; Thu, 2 Mar 2017 17:37:00 GMT
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v22HZ5bH013895
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Mar 2017 17:35:05 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id v22HZ47q007552
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Mar 2017 17:35:05 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id v22HZ4vv016369;
        Thu, 2 Mar 2017 17:35:04 GMT
Received: from localhost (/10.167.103.212)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Mar 2017 09:35:03 -0800
From:   Allan Xavier <allan.x.xavier@oracle.com>
To:     gitster@pobox.com
Cc:     Allan Xavier <allan.x.xavier@oracle.com>, git@vger.kernel.org
Subject: [PATCH] line-log.c: prevent crash during union of too many ranges
Date:   Thu,  2 Mar 2017 17:29:02 +0000
Message-Id: <20170302172902.16850-1-allan.x.xavier@oracle.com>
X-Mailer: git-send-email 2.11.0
X-Source-IP: aserp1040.oracle.com [141.146.126.69]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The existing implementation of range_set_union does not correctly
reallocate memory, leading to a heap overflow when it attempts to union
more than 24 separate line ranges.

For struct range_set *out to grow correctly it must have out->nr set to
the current size of the buffer when it is passed to range_set_grow.
However, the existing implementation of range_set_union only updates
out->nr at the end of the function, meaning that it is always zero
before this. This results in range_set_grow never growing the buffer, as
well as some of the union logic itself being incorrect as !out->nr is
always true.

The reason why 24 is the limit is that the first allocation of size 1
ends up allocating a buffer of size 24 (due to the call to alloc_nr in
ALLOC_GROW). This goes some way to explain why this hasn't been
caught before.

Fix the problem by correctly updating out->nr after reallocating the
range_set. As this results in out->nr containing the same value as the
variable o, replace o with out->nr as well.

Finally, add a new test to help prevent the problem reoccurring in the
future. Thanks to Vegard Nossum for writing the test.

Signed-off-by: Allan Xavier <allan.x.xavier@oracle.com>
---

Originally sent to git-security@googlegroups.com to give hosted
services a chance to apply this if they were affected.

 line-log.c          | 15 +++++++--------
 t/t4211-line-log.sh | 10 ++++++++++
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/line-log.c b/line-log.c
index 65f3558b3..951029665 100644
--- a/line-log.c
+++ b/line-log.c
@@ -144,7 +144,7 @@ void sort_and_merge_range_set(struct range_set *rs)
 static void range_set_union(struct range_set *out,
 			     struct range_set *a, struct range_set *b)
 {
-	int i = 0, j = 0, o = 0;
+	int i = 0, j = 0;
 	struct range *ra = a->ranges;
 	struct range *rb = b->ranges;
 	/* cannot make an alias of out->ranges: it may change during grow */
@@ -167,16 +167,15 @@ static void range_set_union(struct range_set *out,
 			new = &rb[j++];
 		if (new->start == new->end)
 			; /* empty range */
-		else if (!o || out->ranges[o-1].end < new->start) {
+		else if (!out->nr || out->ranges[out->nr-1].end < new->start) {
 			range_set_grow(out, 1);
-			out->ranges[o].start = new->start;
-			out->ranges[o].end = new->end;
-			o++;
-		} else if (out->ranges[o-1].end < new->end) {
-			out->ranges[o-1].end = new->end;
+			out->ranges[out->nr].start = new->start;
+			out->ranges[out->nr].end = new->end;
+			out->nr++;
+		} else if (out->ranges[out->nr-1].end < new->end) {
+			out->ranges[out->nr-1].end = new->end;
 		}
 	}
-	out->nr = o;
 }
 
 /*
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 9d87777b5..d0377fae5 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -106,4 +106,14 @@ test_expect_success '-L with --output' '
 	test_line_count = 70 log
 '
 
+test_expect_success 'range_set_union' '
+	test_seq 500 > c.c &&
+	git add c.c &&
+	git commit -m "many lines" &&
+	test_seq 1000 > c.c &&
+	git add c.c &&
+	git commit -m "modify many lines" &&
+	git log $(for x in $(test_seq 200); do echo -L $((2*x)),+1:c.c; done)
+'
+
 test_done
-- 
2.11.0

