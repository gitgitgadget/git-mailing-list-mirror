Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27396207D6
	for <e@80x24.org>; Thu,  4 May 2017 13:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755250AbdEDNz4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 09:55:56 -0400
Received: from mout.gmx.net ([212.227.15.18]:63863 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755186AbdEDNzp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 09:55:45 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Le5bY-1drfjr0CVA-00ps40; Thu, 04
 May 2017 15:55:39 +0200
Date:   Thu, 4 May 2017 15:55:38 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v4 04/25] add_commit_patch_id(): avoid allocating memory
 unnecessarily
In-Reply-To: <cover.1493906084.git.johannes.schindelin@gmx.de>
Message-ID: <c20dfea3a2cbf5905d52d5a550653736dd71ea4c.1493906085.git.johannes.schindelin@gmx.de>
References: <cover.1493740497.git.johannes.schindelin@gmx.de> <cover.1493906084.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:0cJ4poDeSj75NcAyz3Of+bMa94r8KNaD0G49bapzVTbmwBZ0t4l
 IVNqCGHue4uBuPte+xTu62hOUD9HoB1zjv+D3zfGETqDt1WRh9RFjv84Q/BpLCv5on60oZy
 5Vo/QYZKZbujqaryzCN5Z7cP+YzfeRM4FTronLiAtGNUUNg2ekq1+ABvi3DiK7qc6+X+pzR
 NBGi3oD2ey+2Nt42MN3aA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:U3hUy9xHqPM=:ynLKlftn+Eojo7s8BqClfT
 mTuf03WSLP+umrGozPVejV85qv1QMrOny4fh2bME2N/Jdhdjc5jofUvDLFGZ/4GgDd5yYuyva
 pzNFQpeSaKN+JJQMWdUC5adtQkeby5edLCNmPHpdoYsANrE9vbCzLkIA6ZVYUXpSflg9Z6256
 eeAq5+LMWzu4FWZCVjJH1Tqg3YCu5XNFMk/U9vzf7J0DbtdYaWJ5Aii2QRIddNSSTDJMistkC
 U75ZFzTVrgoZV66UsLV2XzExnLtYoyqOnFUAdsLW4wIuDHLnupxf4nq+CUgH+LatcdPwBOyfJ
 2uetduUuxatCP4kdKn6nVkNmvz9YjIS0UDq9OlcMT4VrdFiuUziGEPvc37R0jAWS13QecGxLd
 UeltpgBiLTl70m+lH1GveFOTTcAKYNu9FiZJ0oS75kAt/GIuptRDQP4IhdLVrLrbQjs5EVNfq
 MUpn+d4ZfeViM/OTf+/FLfqveu3N66/xBShk2b0lZk9ufp0ZP56oph3pIzyVt2Vr6dZjBVG4n
 wMa6+ngM1QpRSacQH/8K7FvuWNaaoDv615L4R6/tCVqoLLJSGooccy79fQFRSAhl14EgNErDj
 4ohgFR93hosgH5HMPIbqtzHP5SjNkAwe2O77VmlEiYiWyEGP/XZe4xZlqlPU28ZgQVy7G1ucE
 HEdoH0IwYKAp4pW/YVE45K6tUBGqCqKXfPAIHOxdc+C7xuVLZAWpSMD/dmE/JrDp3u6FOKaAt
 WrLQ6Pm0GSQrAf/4dmME3waUQvYOtJ49TYUKkX/n0W1cZ1r2xW/NL91L0yCKytkobRmg+75tI
 U7gwHOg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It would appear that we allocate (and forget to release) memory if the
patch ID is not even defined.

Reported by the Coverity tool.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 patch-ids.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/patch-ids.c b/patch-ids.c
index fa8f11de826..92eba7a059e 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -99,11 +99,12 @@ struct patch_id *has_commit_patch_id(struct commit *commit,
 struct patch_id *add_commit_patch_id(struct commit *commit,
 				     struct patch_ids *ids)
 {
-	struct patch_id *key = xcalloc(1, sizeof(*key));
+	struct patch_id *key;
 
 	if (!patch_id_defined(commit))
 		return NULL;
 
+	key = xcalloc(1, sizeof(*key));
 	if (init_patch_id_entry(key, commit, ids)) {
 		free(key);
 		return NULL;
-- 
2.12.2.windows.2.800.gede8f145e06


