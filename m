Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 843DE1F6BF
	for <e@80x24.org>; Mon,  5 Sep 2016 09:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932444AbcIEJpb (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 05:45:31 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:50176 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932395AbcIEJpa (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Sep 2016 05:45:30 -0400
X-AuditID: 1207440c-217ff700000008d5-c9-57cd3ea0b4e2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id 62.69.02261.0AE3DC75; Mon,  5 Sep 2016 05:45:04 -0400 (EDT)
Received: from bagpipes.fritz.box (p57907BC3.dip0.t-ipconnect.de [87.144.123.195])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u859iwtO008788
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 5 Sep 2016 05:45:02 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     git@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 1/8] xdl_change_compact(): fix compaction heuristic to adjust ixo
Date:   Mon,  5 Sep 2016 11:44:46 +0200
Message-Id: <119c03e74c022ccdd6ebd8661a98b43917f8e966.1473068229.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1473068229.git.mhagger@alum.mit.edu>
References: <cover.1473068229.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsUixO6iqLvA7my4wZkv2hZdV7qZLBp6rzBb
        7F7cz2yx4uocZoszW4Gs2yvmM1v8aOlhtph51dpi8+Z2FgdOj7/vPzB57Jx1l91jwaZSj2e9
        exg9Ll5S9ti/dBubx+dNch63n21jCeCI4rJJSc3JLEst0rdL4MroXyBVMJGnYu2uoywNjEc5
        uxg5OSQETCRenHzB1sXIxSEksJVR4s7tCUwQzkkmieZJi1lAqtgEdCUW9TQzgdgiAuISb4/P
        ZAcpYhb4yySx+NFdNpCEsECIREPnO7AGFgFViYN7l4LZvAJRErcv7GGGWCcncWnbFzCbU8BC
        YsmXPnYQW0jAXGLevGbmCYw8CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGurlZpbopaaU
        bmKEBB/PDsZv62QOMQpwMCrx8FponwkXYk0sK67MPcQoycGkJMpboHo2XIgvKT+lMiOxOCO+
        qDQntfgQowQHs5IIb44tUI43JbGyKrUoHyYlzcGiJM6rukTdT0ggPbEkNTs1tSC1CCYrw8Gh
        JMGrBtIoWJSanlqRlplTgpBm4uAEGc4DNNzZBmR4cUFibnFmOkT+FKOilDhvCkhCACSRUZoH
        1wtLDq8YxYFeEeadD7KCB5hY4LpfAQ1mAhq8bvdpkMEliQgpqQZGBq1fF6ceia36Elu3U0ut
        6sb/62uUC7NrpV6855UQ3bSlSunN1qia9L7Vh1/dbV+aFNy+PXnJlqdzMyoyzyX474nfnBqg
        bJzHtPdG/Zy3tvdZ1+Zd3Hf/7mLmsJaiktPtX3cnJJyRMrmYPWt9o+XtjeseHoy7fFisO523
        bEGPwn5TlYLopy5KSizFGYmGWsxFxYkA/i0AnekCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code branch used for the compaction heuristic forgot to keep ixo in
sync while the group was shifted. This is certainly wrong, as it causes
the two counters to get out of sync.

I *think* that this bug could also have caused the function to read past
the end of the rchgo array, though I haven't done the work to prove it
for sure. Here is my reasoning:

If ixo is not decremented correctly during one iteration of the outer
while loop, then it will loose sync with the ix counter. In particular,
ixo will be too large.

Suppose that the next iterations of the outer while loop (i.e.,
processing the next block of add/delete lines) don't have any sliders.
Then the ixo counter would be incremented by the number of non-changed
lines in xdf, which is the same as the number of non-changed lines in
xdfo that *should have* followed the group that experienced the
malfunction. But since ixo was too large at the end of that iteration,
it will be incremented past the end of the xdfo->rchg array, and will
try to read that memory illegally.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 xdiff/xdiffi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index b3c6848..95b037e 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -528,6 +528,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			       recs_match(recs, ixs - 1, ix - 1, flags)) {
 				rchg[--ixs] = 1;
 				rchg[--ix] = 0;
+				while (rchgo[--ixo]);
 			}
 		}
 	}
-- 
2.9.3

