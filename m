Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9678520756
	for <e@80x24.org>; Fri, 13 Jan 2017 16:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751063AbdAMQPW (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 11:15:22 -0500
Received: from userp1040.oracle.com ([156.151.31.81]:34561 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750934AbdAMQPW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 11:15:22 -0500
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v0DGFJwF031736
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2017 16:15:19 GMT
Received: from t460.home (dhcp-ukc1-twvpn-3-vpnpool-10-175-225-84.vpn.oracle.com [10.175.225.84])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id v0DGFF6V022180;
        Fri, 13 Jan 2017 16:15:18 GMT
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH 2/3] xdiff: -W: include immediately preceding non-empty lines in context
Date:   Fri, 13 Jan 2017 17:15:11 +0100
Message-Id: <1484324112-17773-2-git-send-email-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1484324112-17773-1-git-send-email-vegard.nossum@oracle.com>
References: <1484324112-17773-1-git-send-email-vegard.nossum@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Source-IP: aserv0022.oracle.com [141.146.126.234]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using -W to include the whole function in the diff context, you
are typically doing this to be able to review the change in its entirety
within the context of the function. It is therefore almost always
desirable to include any comments that immediately precede the function.

This also the fixes the case for C where the declaration is split across
multiple lines (where the first line of the declaration would not be
included in the output), e.g.:

	void
	dummy(void)
	{
		...
	}

We can include these lines by simply scanning upwards from the place of
the detected function start until we hit the first non-blank line.

Cc: René Scharfe <l.s.r@web.de>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 xdiff/xemit.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 8c88dbd..3a3060d 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -200,6 +200,8 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 			}
 
 			fs1 = get_func_line(xe, xecfg, NULL, i1, -1);
+			while (fs1 > 0 && !is_empty_rec(&xe->xdf1, fs1 - 1))
+				fs1--;
 			if (fs1 < 0)
 				fs1 = 0;
 			if (fs1 < s1) {
@@ -220,6 +222,8 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 			long fe1 = get_func_line(xe, xecfg, NULL,
 						 xche->i1 + xche->chg1,
 						 xe->xdf1.nrec);
+			while (fe1 > 0 && !is_empty_rec(&xe->xdf1, fe1 - 1))
+				fe1--;
 			while (fe1 > 0 && is_empty_rec(&xe->xdf1, fe1 - 1))
 				fe1--;
 			if (fe1 < 0)
-- 
2.7.4

