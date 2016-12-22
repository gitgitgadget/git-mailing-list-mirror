Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 392741FCC7
	for <e@80x24.org>; Thu, 22 Dec 2016 23:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941867AbcLVXQZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 18:16:25 -0500
Received: from mout.gmx.net ([212.227.17.20]:62044 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941861AbcLVXQY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 18:16:24 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lu2F0-1ck9952qLG-011VTA; Fri, 23
 Dec 2016 00:16:17 +0100
Date:   Fri, 23 Dec 2016 00:16:16 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v3 1/3] mingw: adjust is_console() to work with stdin
In-Reply-To: <cover.1482448531.git.johannes.schindelin@gmx.de>
Message-ID: <ca4c61c603247c8ad0b876b068f6cd41fbe01667.1482448531.git.johannes.schindelin@gmx.de>
References: <cover.1482426497.git.johannes.schindelin@gmx.de> <cover.1482448531.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:v6sxmJ+Qp9o5ZzI0MtclXIbLNawsIEiQbMmc9vTrJ41JKaH3NKO
 R2pDtMBBaa2peSJMWB+Yaviz5QHJi1Z4z8gpjzhMLR/etXt05Qz7MpgwY00Ft3CPVvqPbyu
 1pH+UaMp+/M1A6nyiJgpjN9gmhy6UgSscom7nFBqIs4kgn7dRu+v52sNRlq8qccsTtVeZ/o
 zCbHvpzwXKRZP2AB2Qr5Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lrCqXCyoMA8=:ercHjTWNVHxIqisNZ9R3B1
 kEg4ksydOk5AwuKrkR4JJPlkrSyrGkJlpQ6EeGZlklllo2RK2Ek2OMwSk7/tXKLdWfP/eSGWs
 nrIgejKOK3TIA6GvhMHZfJvyFbEMiEH+64y9faMzOYHIc1MaPk2CuvEXPluLczyDBFdMA1RVW
 iC8L2JZ+UTIdoCj6PVYTbiCzc3QxZS5kdyDSCVCpMCbrWw4lzWkFuMCaLrm0yIwlYg3kW3Cgq
 rWA4WKvGoR/4DUjyD3nGSm0AVw0dTidnYmiPk/pTUfFU3AIsiocODhM9kXta0Vz/sx3PFDPWK
 qKaQ/P3pgK5ORAIkx0DeLD5sUUjDYHhlWrek0IyAVIVCUSndQS2JXgeJ4MHwjSu6oIn4V1yNC
 MzCA2dLqmR0v/8MKCPWvXpkmM0kuaosI5wXgcf6+jHqhkeGMaMBvVZnAyCY6dIlk/BwQNUFWp
 MswKV2dyNsjvanBwuJ98VBgf2aSIR68FooInpvzgkqmCuku7UpjQ6JiAfRDL98qNqDXiVDC2I
 cNoYo1VT+ZQKqLkgTUMZ9Te+jRO1ELHpjGOEkvA5v4IFBI/1WE1MroDNgMo/AdsJod8tbR9ny
 US6Mj0MTUlraNyJI/eGW88dzcwYRkGkW96Iu2wKMyoljfIyM2ETs3jYMm1mWv1Yd66FV90+k4
 lVGGKsAhmyOggIwDeLE4nDuk2o5t/cDH2j4FHPP/+ZDBrrfIKHFQmCA4OXIPocLTgcUfmk8U8
 cR60HxmCi9b+dmRqG9qjiKhp6beIvBkT8viWYqvJgtHoZwQbtn+lL1bmExVLUvdK9EVpA2jv3
 vmN07nL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When determining whether a handle corresponds to a *real* Win32 Console
(as opposed to, say, a character device such as /dev/null), we use the
GetConsoleOutputBufferInfo() function as a tell-tale.

However, that does not work for *input* handles associated with a
console. Let's just use the GetConsoleMode() function for input handles,
and since it does not work on output handles fall back to the previous
method for those.

This patch prepares for using is_console() instead of my previous
misguided attempt in cbb3f3c9b1 (mingw: intercept isatty() to handle
/dev/null as Git expects it, 2016-12-11) that broke everything on
Windows.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/winansi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/compat/winansi.c b/compat/winansi.c
index cb725fb02f..590d61cb1b 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -84,6 +84,7 @@ static void warn_if_raster_font(void)
 static int is_console(int fd)
 {
 	CONSOLE_SCREEN_BUFFER_INFO sbi;
+	DWORD mode;
 	HANDLE hcon;
 
 	static int initialized = 0;
@@ -98,7 +99,10 @@ static int is_console(int fd)
 		return 0;
 
 	/* check if its a handle to a console output screen buffer */
-	if (!GetConsoleScreenBufferInfo(hcon, &sbi))
+	if (!fd) {
+		if (!GetConsoleMode(hcon, &mode))
+			return 0;
+	} else if (!GetConsoleScreenBufferInfo(hcon, &sbi))
 		return 0;
 
 	/* initialize attributes */
-- 
2.11.0.rc3.windows.1


