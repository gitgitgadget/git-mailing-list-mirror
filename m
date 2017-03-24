Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 693461FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 23:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754550AbdCXXY4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 19:24:56 -0400
Received: from mout.gmx.net ([212.227.15.19]:53648 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751533AbdCXXY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 19:24:56 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mdren-1cWSvU0VrB-00PbUY; Sat, 25
 Mar 2017 00:24:49 +0100
Date:   Sat, 25 Mar 2017 00:24:47 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/7] sha1dc: safeguard against outside definitions of
 BIGENDIAN
In-Reply-To: <cover.1490397869.git.johannes.schindelin@gmx.de>
Message-ID: <cb494e68de5875b34fab1a0163e85c85c5dcb263.1490397869.git.johannes.schindelin@gmx.de>
References: <cover.1490397869.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:iqP4xAnehd+AKiZeKdX3aAgAgHJZvmXiSqIfzS/dfoNmw/YgigE
 8XiyNXEGa26VkZFvVsHtBdWijTdfOlrkcUbi83IXORse8nyIhaMveQfkjtBiulKTG2cPUue
 U7QOgBtx0ulzCB7AF9SzRXe415ClhvUFdh5CTHUiVZOzpFPFilodblEj7zL7gLMG186A0sm
 ASMjDVzivwUVU52/8Gxuw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VVN6lPbROy4=:whXutzrZEYID0Oh7SWe/gn
 tF9NIFAXv2FzYPlad3T1BpjgfW0Gt3M0kUUGoreT8w4ZvBK6+cCssIGSU5IYZ6cnv8bOM4MQw
 x5ZDRSUTexo9j9SiaEKCBsvEdkfCpSgWcf+jlf9p9sNivRK+KWDZbvYzWXhxgpnuQRRMHeUOm
 7Ti4tJapa/xzy/Was6wnfbsIz2fO41RSwNf4Esgr6CszTyCCCHk/P+cn25Dc/W1JUqfHY0KN4
 3r19lHdmtOvcHuEaEGKdLk9fFS4jt9WQtnVRu7W2RDB+IiLqRNPu+U1lkUSVDb+XLw4c5/YYd
 0c1bn/2RSkVdXMdTWh45CuYn8jssWHwB/aOkMMsmy0zbBbrEuFgckMeeSsITrUWPdSKYo66Pk
 L22E2pwSgq/+7lSEWwDSA9dtybD5kfZKrz1HXG8snupdyRJdLBPUA2OPAdsayuAbNrMx2Dqk2
 5VqQmo9avjSZgvUBXPzLrzv1lXekqEIaGjfHwefalnC3gCO35TX7CBYN40U962urSxYtzbfVe
 oOwCZT8IZWW5An/PYrJMLM1ZjL50X67470oODJwi2pSIszt9tf4mHf6yK4NBtjh1mzB+TSE51
 ojVrxl7t0+Z1/xAhmgVG5j4yn0O7W/W6xuvRktK8YPGbj8FNeIQNeD2JL1XZJ19q7XSTaUYeU
 utev5ZfI7YJMqmmRTDPbkwhoR503IEjnkEpKnrX/i4I/Oh3aOLFu+GWvpV3JypfEWkQ0pvi0/
 1rPb7ow16wgmYV3Oav5L6M/9CCQ2AMWfjUc6BI4vDCN3rzJP/s7NpNp2Fn47NWsDv2TqtaZHQ
 LOT+QuPq+T0QSn4jC2kYtQgmKSlwg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In sha1dc/sha1.c, we #define BIGENDIAN under certain circumstances, and
obviously leave the door open for scenarios where our conditions do not
catch and that constant is #defined elsewhere.

However, we did not expect that anybody would possibly #define BIGENDIAN
to 0, indicating that the current platform is *not* big endian.

This is not just a theoretical consideration: On Windows, the winsock2.h
header file (which is used to allow Git to communicate via network) does
indeed do this.

Let's test for that circumstance, too, and byte-swap as intended in that
case.

This fixes a massive breakage on Windows where current `pu` (having
switched on DC_SHA1 by default) breaks pretty much every single test
case.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sha1dc/sha1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
index 6dd0da36084..d99db4f2e1b 100644
--- a/sha1dc/sha1.c
+++ b/sha1dc/sha1.c
@@ -35,7 +35,7 @@
 
 #define sha1_mix(W, t)  (rotate_left(W[t - 3] ^ W[t - 8] ^ W[t - 14] ^ W[t - 16], 1))
 
-#if defined(BIGENDIAN)
+#if defined(BIGENDIAN) && BIGENDIAN != 0
 	#define sha1_load(m, t, temp)  { temp = m[t]; }
 #else
 	#define sha1_load(m, t, temp)  { temp = m[t]; sha1_bswap32(temp); }
-- 
2.12.1.windows.1


