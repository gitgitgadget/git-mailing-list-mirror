Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E8B11FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 13:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933199AbdCaNv5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 09:51:57 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:62867 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933015AbdCaNv4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 09:51:56 -0400
Received: from localhost ([130.75.46.4]) by mrelayeu.kundenserver.de (mreue101
 [212.227.15.183]) with ESMTPSA (Nemesis) id 0M0z9T-1bzdHe1agR-00v8je; Fri, 31
 Mar 2017 15:51:33 +0200
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCH v3 1/4] name-rev: refactor logic to see if a new candidate is a better name
Date:   Fri, 31 Mar 2017 15:51:21 +0200
Message-Id: <b3d7263ef7b435c6fd64f1fc820e7f6fb668adba.1490967948.git.git@grubix.eu>
X-Mailer: git-send-email 2.12.2.739.gfc3eb97820
In-Reply-To: <xmqqinmq65at.fsf@gitster.mtv.corp.google.com>
References: <xmqqinmq65at.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <cover.1490967948.git.git@grubix.eu>
References: <cover.1490967948.git.git@grubix.eu>
X-Provags-ID: V03:K0:X1SCG5M+xujfPcYVmq/ucbpE7ZYO140NcXIwn0oDSNzcLYr9tte
 TUvbFKJph8o+2swS7HrwX8XWivmieZGiw4Cau2MVXitEVSSzpzONCFvrSfzKxvvrakqGu4e
 i6fIa2Vxg/yIQgkHrfHITtV9fbrsXkjqtmCoq0rjVmCr4/ECNr2BvHAnOnNPhXEbBYanPzl
 jDMcg3r19DdrVT7lV8yEg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:h2vmocmGeII=:AqXLb0zWO8kIOxxb/aniGc
 h95dZKy0IJ33Lcx8Q9ugS+kmnM1Sm2T/QWgviDebw8Rfiq6A53KsWlFs23ot5+L7cOeS7bc5/
 d7uji7ZnLx9pShvcgTHojPCUZp4JgVA3eZJ1gVkP6inlF2aaLyfBSdrbIni49BIgXe4xpc5gU
 dZjYx/qWXEbJTZYDiLm244R7esKe5NJAADr7TAjPHvUgejum8U3hpHUm8FewguI/oWkoQfNpo
 XLXfHEeFUpI4cM2XxMU2o4AmhKJ6Ars5Z+YI1S1dTY38W0daUxhPyVexx3miYqlvfEZaD+qxn
 lM2j6+tEK8xaiz7l/rvUbSL/UIfLnSBaIWSX2zgw25/0b8lTjIxYvUVIUvWpGcQh2ZL9KoP1U
 NahaoeiDl87lo0gzI6Evlktb6kNnHv7gYPOUpcVrQtqnPqwsEXNPLsYA614qGRxGYAWX0ZbWN
 Fx8c+El/ILA5fwQT9R5weg78Y74jatzG54XphmfPiJtESWJtnGWMEHwEEtKVG3DPmsrcJcgHG
 MsT9Cq3KrAixZ3twrtTz0t9W4hj9fXNlnz4/gYM+n68WlsV22lDFfXoiLQpBHcW41sDZ/OkOt
 0oMS2ri5pxkfNGRlPr+1yLK+PcMANflOUnvkA8UhM84GrjqGL8RCzPHZ6dxvIKXrTW+zoMVAr
 AxRvNN4ZLqAJVyYnKuIRH6BliV3njdsWG2cDCXrogqfVpugnD6d90e1TqT21Opc4rQ8w=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

When we encounter a new ref that could describe the commit we are
looking at, we compare the name that is formed using that ref and
the name we found so far and pick a better one.

Factor the comparison logic out to a separate helper function, while
keeping the current logic the same (i.e. a name that is based on an
older tag is better, and if two tags of the same age can reach the
commit, the one with fewer number of hops to reach the commit is
better).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael J Gruber <git@grubix.eu>
---
 builtin/name-rev.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 8bdc3eaa6f..7890f826ce 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -20,6 +20,17 @@ static long cutoff = LONG_MAX;
 /* How many generations are maximally preferred over _one_ merge traversal? */
 #define MERGE_TRAVERSAL_WEIGHT 65535
 
+static int is_better_name(struct rev_name *name,
+			  const char *tip_name,
+			  unsigned long taggerdate,
+			  int generation,
+			  int distance)
+{
+	return (name->taggerdate > taggerdate ||
+		(name->taggerdate == taggerdate &&
+		 name->distance > distance));
+}
+
 static void name_rev(struct commit *commit,
 		const char *tip_name, unsigned long taggerdate,
 		int generation, int distance,
@@ -45,9 +56,8 @@ static void name_rev(struct commit *commit,
 		name = xmalloc(sizeof(rev_name));
 		commit->util = name;
 		goto copy_data;
-	} else if (name->taggerdate > taggerdate ||
-			(name->taggerdate == taggerdate &&
-			 name->distance > distance)) {
+	} else if (is_better_name(name, tip_name, taggerdate,
+				  generation, distance)) {
 copy_data:
 		name->tip_name = tip_name;
 		name->taggerdate = taggerdate;
-- 
2.12.2.739.gfc3eb97820

