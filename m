Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4E0D1F404
	for <e@80x24.org>; Thu,  6 Sep 2018 10:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbeIFOv7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 10:51:59 -0400
Received: from mout.gmx.net ([212.227.17.21]:35737 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727753AbeIFOv7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 10:51:59 -0400
Received: from localhost.localdomain ([2.247.240.61]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MRjd7-1gQcdz0Gk5-00Sthk; Thu, 06 Sep 2018 12:17:02 +0200
From:   Tim Schumacher <timschumi@gmx.de>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, pclouds@gmail.com
Subject: [PATCH v3] Allow aliases that include other aliases
Date:   Thu,  6 Sep 2018 12:16:58 +0200
Message-Id: <20180906101658.1865-1-timschumi@gmx.de>
X-Mailer: git-send-email 2.19.0.rc1.2.g8008c49c4.dirty
In-Reply-To: <20180905085427.4099-1-timschumi@gmx.de>
References: <20180905085427.4099-1-timschumi@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0s2KcPfHz/766xcrf3wOm1bo7aJjeZCVrzRA/u+o/OznQ1n10cB
 eWi9RI3JeuYKluhfguJP41T2qA8jVZDvHJ9yyKuC//OsbG6HCgFqPnlyIJvxxkkSYRUtmtx
 SNg3DOXZfuO/OiyQZS/Hp0pnT0BJOEMfcUlBYBEutkCTVAwDPD6aGVdK1+HXiaLQRuw9c+x
 a8ove89vthOtT4D//eq2A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6+4aiGQoASA=:czympGrOFXxtmc5kMcpvHu
 DGeaKqUU8jBac34bAc4s8UKZrJKeRcqD2hruN3CVLtikxNxH9Gtvgcpj3tXgd5dayUvii1OL6
 yfxv4vLQnKM8XSAI/D/VjAGyFrkLtquQkgVn4LjI+4BXMng8oEI4OHN6M1W/QyAfgqg0yAp2N
 u8XYvb67lDaVuQYRL+vqq6vUwhqObDq6q1BkEO45xaNRAx4t1v5fSIbOLcY0r5q1A++DoJeno
 Luf/uzeiZ4RkJMDRcBWv7Kba27nN9kGDXjhf990DJB5d892QhuaYcu3jNPyL+H/naxkWFicjy
 KssYDIvhEnXYl0KpRGi9G9RoScBblrnUj1WbvI3kaKOvlYqY5rAvtUZN78qE8afVhEL+B9Vx+
 VukWS2sPKccwu6CK++p8v2/NNJtygpZuUnUHm1Qi57komn6XV2eSp47Na6MkjG49Rydf323Bf
 HW6NvZBPH8co/hrnv0teUjGGgG2hZ19y5rqd8ai4gY5zC2Zs5WSprgoBjXw/rKou7NlfqUaUC
 jo5WwClLaUOMyJoIl73ShxVRsv9CCeucF744F9tBDIL8/ifM0Z+FoPoZ0drrX3sTUbZmvENSW
 3nTxQ62hHAcAB9GhrimHh7gsDDLwK8oc3bII0rTvuajYZNZzX4TNTGC21trYs6AEqiLZJuO+P
 9TJmGzUEtbezIwpEZ6ZxRF9tvdP6hGarDhGlvID3hcw6rx2VfzgfSgJNxhbN+mW9tEVFT8J5o
 NxkY2D31LxIDNwteFQor/Fi08VjiKmiZLj+dwigarI7V3x4rdY6xJZp+TFU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Aliases can only contain non-alias git commands and their
arguments, not other user-defined aliases. Resolving further
(nested) aliases is prevented by breaking the loop after the
first alias was processed. Git then fails with a command-not-found
error.

Allow resolving nested aliases by not breaking the loop in
run_argv() after the first alias was processed. Instead, continue
incrementing `done_alias` until `handle_alias()` fails, which means that
there are no further aliases that can be processed. Prevent looping
aliases by storing substituted commands in `cmd_list` and checking if
a command has been substituted previously.

While we're at it, fix a styling issue just below the added code.
---
 git.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/git.c b/git.c
index c27c38738..64f5fbd57 100644
--- a/git.c
+++ b/git.c
@@ -674,6 +674,7 @@ static void execv_dashed_external(const char **argv)
 static int run_argv(int *argcp, const char ***argv)
 {
 	int done_alias = 0;
+	struct string_list cmd_list = STRING_LIST_INIT_NODUP;
 
 	while (1) {
 		/*
@@ -691,17 +692,23 @@ static int run_argv(int *argcp, const char ***argv)
 		/* .. then try the external ones */
 		execv_dashed_external(*argv);
 
-		/* It could be an alias -- this works around the insanity
+		if (string_list_has_string(&cmd_list, *argv[0]))
+			die(_("loop alias: %s is called twice"), *argv[0]);
+
+		string_list_append(&cmd_list, *argv[0]);
+
+		/*
+		 * It could be an alias -- this works around the insanity
 		 * of overriding "git log" with "git show" by having
 		 * alias.log = show
 		 */
-		if (done_alias)
-			break;
 		if (!handle_alias(argcp, argv))
 			break;
-		done_alias = 1;
+		done_alias++;
 	}
 
+	string_list_clear(&cmd_list, 0);
+
 	return done_alias;
 }
 
-- 
2.19.0.rc1.2.g8008c49c4.dirty

