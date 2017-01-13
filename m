Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9320820756
	for <e@80x24.org>; Fri, 13 Jan 2017 16:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752085AbdAMQP2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 11:15:28 -0500
Received: from userp1040.oracle.com ([156.151.31.81]:34621 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751449AbdAMQP0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 11:15:26 -0500
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v0DGFHuj031669
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2017 16:15:18 GMT
Received: from t460.home (dhcp-ukc1-twvpn-3-vpnpool-10-175-225-84.vpn.oracle.com [10.175.225.84])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id v0DGFF6U022180;
        Fri, 13 Jan 2017 16:15:16 GMT
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH 1/3] xdiff: -W: relax end-of-file function detection
Date:   Fri, 13 Jan 2017 17:15:10 +0100
Message-Id: <1484324112-17773-1-git-send-email-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Source-IP: aserv0022.oracle.com [141.146.126.234]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When adding a new function to the end of a file, it's enough to know
that 1) the addition is at the end of the file; and 2) there is a
function _somewhere_ in there.

If we had simply been changing the end of an existing function, then we
would also be deleting something from the old version.

This fixes the case where we add e.g.

	// Begin of dummy
	static int dummy(void)
	{
	}

to the end of the file.

Cc: René Scharfe <l.s.r@web.de>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 xdiff/xemit.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 7389ce4..8c88dbd 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -183,16 +183,14 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 
 				/*
 				 * We don't need additional context if
-				 * a whole function was added, possibly
-				 * starting with empty lines.
+				 * a whole function was added.
 				 */
-				while (i2 < xe->xdf2.nrec &&
-				       is_empty_rec(&xe->xdf2, i2))
+				while (i2 < xe->xdf2.nrec) {
+					if (match_func_rec(&xe->xdf2, xecfg, i2,
+						dummy, sizeof(dummy)) >= 0)
+						goto post_context_calculation;
 					i2++;
-				if (i2 < xe->xdf2.nrec &&
-				    match_func_rec(&xe->xdf2, xecfg, i2,
-						   dummy, sizeof(dummy)) >= 0)
-					goto post_context_calculation;
+				}
 
 				/*
 				 * Otherwise get more context from the
-- 
2.7.4

