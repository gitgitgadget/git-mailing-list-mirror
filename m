Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A0321FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 22:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752643AbdCXWwZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 18:52:25 -0400
Received: from mout.gmx.net ([212.227.15.15]:54185 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751503AbdCXWwX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 18:52:23 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lb5nF-1cSuYs2Tof-00kdGO; Fri, 24
 Mar 2017 23:52:11 +0100
Date:   Fri, 24 Mar 2017 23:52:10 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] sha1dc: safeguard against outside definitions of BIGENDIAN
Message-ID: <856355e49e7a6016f5d1ef5f9785d94a455b5755.1490395862.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:hN9lnNS6boJN5eq7hrDO+NbpAXfCT+aFehAFfDIdVJ8/4PXMJFv
 fFTwpnVObJpw4msb7m+0ftiWsxCYvwzAjs7kvf0bs/fw7DAq9O8k9ocEShrTmJd5kDF2A60
 v1YDTY7NYQd39mUwPuevpOqnQ4QUn974pDLaheneTEm+eG5CBvQqBQx3+nHpPUFrlxkUu7Q
 wg3TTUqx0yEWLRVWprIpQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UwJtlbGtHhw=:/VDQbNSViDbr/FGZwrLFPN
 dJUlMFMU0BYCokOexHQawq6RUVbiGEy8vXO2V6vwnZ6gUWz9csVul4ae08BpxTivQ8clPPI3U
 Iyu2tzuF95BXEqImqmZXDxN180RjB9ilNi0wl8WkB29HbCxF56tEsF9ocO090L+nwiaxDzyoo
 UUUB1jekw8CbkrvKm0T0esHz4+OcDMN15wpMZREDc3TuM7F4mSOt5WxsWK8NMQX4VZ1JZBio6
 dgXkDrD1BV/gjZGr6gI/HQ1susGQCtHBuWCbwX/I6lPKxH+sbaP3ZdYWUr4xIlH+KlU16FuJp
 fMW9qacURUnn3RW22/wK5q77nsTrBjGYHgqn7QRbWpYwyMr6vNi/JUOHShIVfhbUbXVqGs39Q
 v83ZCGh+Kj7+97ZGM63A4Da5aUUK7npmxnZTVDIN1TSD3Bsqyih6jQfpKgOqW4lzwsbj9lZH0
 V6+4oUwsNsy6AosCN+Q5ClsY8vnuNvo5fki31myeAI2srlcYbmfeMOU1zLNXEY5r3+M+FmRVt
 Lz5QcM2gbG4i1QL2MMELY79eUNhdEipFppuj0BPt0KnUifBcOyQb/yHL85W97vzW/o38Zo7Xt
 HQhLXIrSqnuh9SnicydJGEgomoMou8iyrdBXmOy1t41ZJiBLIvLmH2w2jKh17Fe5nSWY7V4/7
 hYUXdVM2BgNcshPuxGiCwF1GHzSiTHJELwm4VaB5pb9m2kyvsd/MZykpdI3/4eB9sDzK9v9eb
 I+W2LWoQnNrzYO2Zb6vXNxCIUWgzCC/e8mzvqj/a8NjNcoabQzqFTpC93EzkUcdifmQGCzoxJ
 DCCprcIW/j8B3sxa3WwKBmxBZ9MIA==
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
Published-As: https://github.com/dscho/git/releases/tag/sha1dc-bigendian=0-v1
Fetch-It-Via: git fetch https://github.com/dscho/git sha1dc-bigendian=0-v1

	Obviously, this patch is based on `next`.

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

base-commit: c21884356fab0bc6bc5fa6abcadbda27a112a76c
-- 
2.12.1.windows.1
