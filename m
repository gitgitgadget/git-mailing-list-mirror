Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8FAF1F858
	for <e@80x24.org>; Wed,  3 Aug 2016 22:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932821AbcHCWBK (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 18:01:10 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:44998 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756504AbcHCWA7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2016 18:00:59 -0400
X-AuditID: 12074411-a07ff70000000932-2a-57a269937b07
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 49.84.02354.39962A75; Wed,  3 Aug 2016 18:00:51 -0400 (EDT)
Received: from michael.fritz.box (p57907C5F.dip0.t-ipconnect.de [87.144.124.95])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u73M0fSb023677
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 3 Aug 2016 18:00:49 -0400
From:	Michael Haggerty <mhagger@alum.mit.edu>
To:	git@vger.kernel.org
Cc:	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 4/8] xdl_change_compact(): do one final shift or the other, not both
Date:	Thu,  4 Aug 2016 00:00:32 +0200
Message-Id: <39a135da93834fd72ee923d95d0cebfe525dfe7a.1470259583.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1470259583.git.mhagger@alum.mit.edu>
References: <cover.1470259583.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsUixO6iqDs5c1G4wfp2YYuuK91MFg29V5gt
	di/uZ7ZYcXUOs8XtFfOZLX609DBbbN7czuLA7vH3/Qcmj52z7rJ7LNhU6vGsdw+jx8VLyh6f
	N8kFsEVx2aSk5mSWpRbp2yVwZTzq1ymYL1rxdHoPSwPjVf4uRk4OCQETiTU9f9m7GLk4hAS2
	Mkpc+reYCcI5ziRx4Pw9FpAqNgFdiUU9zUwgtoiAuMTb4zPBOpgF+pkkfnR0MYIkhAVCJLqP
	LmIHsVkEVCW29a4BauDg4BWIkjj/LBxim5zE5ekP2EBsTgELiauTZoPNFBIwl3jbsYt1AiPP
	AkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6pnq5mSV6qSmlmxghQSW4g3HGSblDjAIcjEo8
	vBskF4ULsSaWFVfmHmKU5GBSEuXNSQUK8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuG9lwKU401J
	rKxKLcqHSUlzsCiJ8/ItUfcTEkhPLEnNTk0tSC2CycpwcChJ8CZnADUKFqWmp1akZeaUIKSZ
	ODhBhvMADd+TDjK8uCAxtzgzHSJ/ilFRSpzXAiQhAJLIKM2D64VF/StGcaBXhHmrQVbwABMG
	XPcroMFMQINPGCwAGVySiJCSamDcfvjMwbnfN3w0fFGxsdhkqumL/KBDXNbKQvanW+dffBup
	3LXkVg/TI+UzC+IuF+z7+yo06ab67YcZF/fLNPdwL5Q7xslpv/j9pOk2O77svM/OJ7D3rj/P
	lRfTQrKE9U4WTdneu9JRcXJEaZrtIkd27b975lxwPFP/QJBlmUry/LBDX1N6Ii5eUmIpzkg0
	1GIuKk4EAJAr66DVAgAA
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

There is no need to shift the group to match a diff in the other file if
we're just going to override that shift based on the compaction
heuristic. Note that this changes the behavior if the matching shift
would have shifted the group higher than the last blank line: the old
code would have ignored the compaction heuristic in that case, whereas
the new code always gives precedence to the compaction heuristic when it
is turned on.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 xdiff/xdiffi.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 0f235bc..c67cfe3 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -547,11 +547,28 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			}
 		} while (groupsize != end - start);
 
-		/*
-		 * Try to move back the possibly merged group of changes, to match
-		 * the recorded position in the other file.
-		 */
-		if (end_matching_other != -1) {
+		if ((flags & XDF_COMPACTION_HEURISTIC) && blank_lines) {
+			/*
+			 * Compaction heuristic: if a group can be moved back and
+			 * forth, then if possible shift the group to make its
+			 * bottom line a blank line.
+			 *
+			 * As we already shifted the group forward as far as
+			 * possible in the earlier loop, we only need to handle
+			 * backward shifts, not forward ones.
+			 */
+			while (start > 0 &&
+			       !is_blank_line(recs, end - 1, flags) &&
+			       recs_match(recs, start - 1, end - 1, flags)) {
+				rchg[--start] = 1;
+				rchg[--end] = 0;
+			}
+		} else if (end_matching_other != -1) {
+			/*
+			 * Move the possibly merged group of changes back to line
+			 * up with the last group of changes from the other file
+			 * that it can align with.
+			 */
 			while (end_matching_other < end) {
 				rchg[--start] = 1;
 				rchg[--end] = 0;
@@ -561,23 +578,6 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 					io--;
 			}
 		}
-
-		/*
-		 * If a group can be moved back and forth, see if there is a
-		 * blank line in the moving space. If there is a blank line,
-		 * make sure the last blank line is the end of the group.
-		 *
-		 * As we already shifted the group forward as far as possible
-		 * in the earlier loop, we need to shift it back only if at all.
-		 */
-		if ((flags & XDF_COMPACTION_HEURISTIC) && blank_lines) {
-			while (start > 0 &&
-			       !is_blank_line(recs, end - 1, flags) &&
-			       recs_match(recs, start - 1, end - 1, flags)) {
-				rchg[--start] = 1;
-				rchg[--end] = 0;
-			}
-		}
 	}
 
 	return 0;
-- 
2.8.1

