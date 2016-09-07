Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C4BD1F859
	for <e@80x24.org>; Wed,  7 Sep 2016 15:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934866AbcIGPNi (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 11:13:38 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:48196 "EHLO
        iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934756AbcIGPNg (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 7 Sep 2016 11:13:36 -0400
Received: from x590d6d43.dyn.telefonica.de ([89.13.109.67] helo=localhost.localdomain)
        by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
        iface 141.3.10.81 id 1bheXX-0006Yc-Ga; Wed, 07 Sep 2016 17:13:29 +0200
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Leho Kraav <leho@conversionready.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 5/5] versioncmp: cope with common leading parts in versionsort.prereleaseSuffix
Date:   Wed,  7 Sep 2016 17:12:51 +0200
Message-Id: <20160907151251.30978-6-szeder@ira.uka.de>
X-Mailer: git-send-email 2.10.0.74.g6632b1b
In-Reply-To: <20160907151251.30978-1-szeder@ira.uka.de>
References: <20160906214550.Horde.ducOghtmsQb9pQ6lixxddVz@webmail.informatik.kit.edu>
 <20160907151251.30978-1-szeder@ira.uka.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1473261209.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Version sort with prerelease reordering sometimes puts tagnames in the
wrong order, when the common part of two compared tagnames ends with
the leading character(s) of one or more configured prerelease
suffixes.

  $ git config --get-all versionsort.prereleaseSuffix
  -beta
  $ git tag -l --sort=version:refname v2.1.*
  v2.1.0-beta-2
  v2.1.0-beta-3
  v2.1.0
  v2.1.0-RC1
  v2.1.0-RC2
  v2.1.0-beta-1
  v2.1.1
  v2.1.2

The reason is that when comparing a pair of tagnames, first
versioncmp() looks for the first different character in a pair of
tagnames, and then the swap_prereleases() helper function checks for
prerelease suffixes _starting at_ that character.  Thus, when in the
above example the sorting algorithm happens to compare the tagnames
"v2.1.0-beta-1" and "v2.1.0-RC2", swap_prereleases() will try to match
the suffix "-beta" against "beta-1" to no avail, and the two tagnames
erroneously end up being ordered lexicographically.

To fix this issue change swap_prereleases() to look for configured
prerelease suffixes containing that first different character.

Reported-by: Leho Kraav <leho@conversionready.com>
Signed-off-by: SZEDER Gábor <szeder@ira.uka.de>
---
 t/t7004-tag.sh |  4 ++--
 versioncmp.c   | 24 +++++++++++++++++++-----
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index d69ac4940388..f0cfe1fa3d8b 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1538,7 +1538,7 @@ test_expect_success 'reverse version sort with prerelease reordering' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'version sort with prerelease reordering and common leading character' '
+test_expect_success 'version sort with prerelease reordering and common leading character' '
 	test_config versionsort.prereleaseSuffix -beta &&
 	git tag foo1.6-after1 &&
 	git tag -l --sort=version:refname "foo*" >actual &&
@@ -1555,7 +1555,7 @@ test_expect_failure 'version sort with prerelease reordering and common leading
 
 # Capitalization of suffixes is important here, because "-RC" would normally
 # be sorted before "-beta" and the config settings should override that.
-test_expect_failure 'version sort with prerelease reordering, multiple suffixes and common leading character' '
+test_expect_success 'version sort with prerelease reordering, multiple suffixes and common leading character' '
 	test_config versionsort.prereleaseSuffix -beta &&
 	git config --add versionsort.prereleaseSuffix -RC &&
 	git tag foo1.6-RC1 &&
diff --git a/versioncmp.c b/versioncmp.c
index fed02d2a2878..87b49a622423 100644
--- a/versioncmp.c
+++ b/versioncmp.c
@@ -27,7 +27,8 @@ static int initialized;
 /*
  * off is the offset of the first different character in the two strings
  * s1 and s2. If either s1 or s2 contains a prerelease suffix starting
- * at that offset, it will be forced to be on top.
+ * at that offset or the character at that offset is part of a
+ * prerelease suffix, then that string will be forced to be on top.
  *
  * If both s1 and s2 contain a (different) suffix at that position, the
  * order is determined by config file.
@@ -47,10 +48,23 @@ static int swap_prereleases(const char *s1,
 
 	for (i = 0; i < prereleases->nr; i++) {
 		const char *suffix = prereleases->items[i].string;
-		if (i1 == -1 && starts_with(s1 + off, suffix))
-			i1 = i;
-		if (i2 == -1 && starts_with(s2 + off, suffix))
-			i2 = i;
+		int j, start, suffix_len = strlen(suffix);
+		if (suffix_len < off)
+			start = off - suffix_len + 1;
+		else
+			start = 0;
+		for (j = start; j <= off; j++) {
+			if (i1 == -1 && starts_with(s1 + j, suffix)) {
+				i1 = i;
+				break;
+			}
+		}
+		for (j = start; j <= off; j++) {
+			if (i2 == -1 && starts_with(s2 + j, suffix)) {
+				i2 = i;
+				break;
+			}
+		}
 	}
 	if (i1 == -1 && i2 == -1)
 		return 0;
-- 
2.10.0.74.g6632b1b

