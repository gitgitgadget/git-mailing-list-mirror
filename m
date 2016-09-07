Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 834931F859
	for <e@80x24.org>; Wed,  7 Sep 2016 15:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934742AbcIGPNd (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 11:13:33 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:48168 "EHLO
        iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933183AbcIGPNc (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 7 Sep 2016 11:13:32 -0400
Received: from x590d6d43.dyn.telefonica.de ([89.13.109.67] helo=localhost.localdomain)
        by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
        iface 141.3.10.81 id 1bheXU-0006Yc-IZ; Wed, 07 Sep 2016 17:13:27 +0200
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Leho Kraav <leho@conversionready.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 4/5] versioncmp: pass full tagnames to swap_prereleases()
Date:   Wed,  7 Sep 2016 17:12:50 +0200
Message-Id: <20160907151251.30978-5-szeder@ira.uka.de>
X-Mailer: git-send-email 2.10.0.74.g6632b1b
In-Reply-To: <20160907151251.30978-1-szeder@ira.uka.de>
References: <20160906214550.Horde.ducOghtmsQb9pQ6lixxddVz@webmail.informatik.kit.edu>
 <20160907151251.30978-1-szeder@ira.uka.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1473261207.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The swap_prereleases() helper function is responsible for finding
configured prerelease suffixes in a pair of tagnames to be compared,
but this function currently only gets to see only the parts of those
two tagnames starting at the first different character.  To fix some
issues related to multiple prerelease suffixes starting with the same
leading character(s), this helper function must see the preceeding
matching characters as well.

In preparation for the fix in the following patch, refactor
swap_prereleases() and its caller to pass two full tagnames and an
additional offset indicating the position of the first different
character.

Signed-off-by: SZEDER Gábor <szeder@ira.uka.de>
---
 versioncmp.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/versioncmp.c b/versioncmp.c
index 80bfd109fa12..fed02d2a2878 100644
--- a/versioncmp.c
+++ b/versioncmp.c
@@ -25,32 +25,31 @@ static const struct string_list *prereleases;
 static int initialized;
 
 /*
- * p1 and p2 point to the first different character in two strings. If
- * either p1 or p2 starts with a prerelease suffix, it will be forced
- * to be on top.
+ * off is the offset of the first different character in the two strings
+ * s1 and s2. If either s1 or s2 contains a prerelease suffix starting
+ * at that offset, it will be forced to be on top.
  *
- * If both p1 and p2 start with (different) suffix, the order is
- * determined by config file.
+ * If both s1 and s2 contain a (different) suffix at that position, the
+ * order is determined by config file.
  *
- * Note that we don't have to deal with the situation when both p1 and
- * p2 start with the same suffix because the common part is already
+ * Note that we don't have to deal with the situation when both s1 and
+ * s2 contain the same suffix because the common part is already
  * consumed by the caller.
  *
  * Return non-zero if *diff contains the return value for versioncmp()
  */
-static int swap_prereleases(const void *p1_,
-			    const void *p2_,
+static int swap_prereleases(const char *s1,
+			    const char *s2,
+			    int off,
 			    int *diff)
 {
-	const char *p1 = p1_;
-	const char *p2 = p2_;
 	int i, i1 = -1, i2 = -1;
 
 	for (i = 0; i < prereleases->nr; i++) {
 		const char *suffix = prereleases->items[i].string;
-		if (i1 == -1 && starts_with(p1, suffix))
+		if (i1 == -1 && starts_with(s1 + off, suffix))
 			i1 = i;
-		if (i2 == -1 && starts_with(p2, suffix))
+		if (i2 == -1 && starts_with(s2 + off, suffix))
 			i2 = i;
 	}
 	if (i1 == -1 && i2 == -1)
@@ -121,7 +120,8 @@ int versioncmp(const char *s1, const char *s2)
 		initialized = 1;
 		prereleases = git_config_get_value_multi("versionsort.prereleasesuffix");
 	}
-	if (prereleases && swap_prereleases(p1 - 1, p2 - 1, &diff))
+	if (prereleases && swap_prereleases(s1, s2, (const char *) p1 - s1 - 1,
+					    &diff))
 		return diff;
 
 	state = result_type[state * 3 + (((c2 == '0') + (isdigit (c2) != 0)))];
-- 
2.10.0.74.g6632b1b

