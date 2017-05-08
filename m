Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 170E81FC44
	for <e@80x24.org>; Mon,  8 May 2017 20:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752784AbdEHUfC (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 16:35:02 -0400
Received: from avasout08.plus.net ([212.159.14.20]:42460 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751568AbdEHUfB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 16:35:01 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout08 with smtp
        id Hway1v0041keHif01wazY8; Mon, 08 May 2017 21:34:59 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=JPdLi4Cb c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=F8kVwyoW9nBH8-VlmQYA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2] archive-tar: fix a sparse 'constant too large' warning
Message-ID: <4bf9be3c-5d19-09e3-b8b3-dd58e00e623d@ramsayjones.plus.com>
Date:   Mon, 8 May 2017 21:34:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Commit dddbad728c ("timestamp_t: a new data type for timestamps",
26-04-2017) introduced a new typedef 'timestamp_t', as a synonym for an
unsigned long, which was used at the time to represent timestamps in
git. A later commit 28f4aee3fb ("use uintmax_t for timestamps",
26-04-2017) changed the typedef to use an 'uintmax_t' for the timestamp
representation type.

When building on a 32-bit Linux system, sparse complains that a constant
(USTAR_MAX_MTIME) used to detect a 'far-future mtime' timestamp, is too
large; 'warning: constant 077777777777UL is so big it is unsigned long
long' on lines 335 and 338 of archive-tar.c. Note that both gcc and
clang only issue a warning if this constant is used in a context that
requires an 'unsigned long' (rather than an uintmax_t). (Since TIME_MAX
is no longer equal to 0xFFFFFFFF, even on a 32-bit system, the macro
USTAR_MAX_MTIME is set to 077777777777UL, which cannot be represented as
an 'unsigned long' constant).

In order to suppress the warning, change the definition of the macro
constant USTAR_MAX_MTIME to use an 'ULL' type suffix.

In a similar vein, on systems which use a 64-bit representation of the
'unsigned long' type, the USTAR_MAX_SIZE constant macro is defined with
the value 077777777777ULL. Although this does not cause any warning
messages to be issued, it would be more appropriate for this constant
to use an 'UL' type suffix rather than 'ULL'.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Junio,

Sorry for being a bit slow with this, but this is the v2 version
of the patch that I promised, which includes the change to the
USTAR_MAX_SIZE macro that Johannes requested.

Thanks.

ATB,
Ramsay Jones

 archive-tar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 319a5b1c7..073e60ebd 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -28,12 +28,12 @@ static int write_tar_filter_archive(const struct archiver *ar,
 #if ULONG_MAX == 0xFFFFFFFF
 #define USTAR_MAX_SIZE ULONG_MAX
 #else
-#define USTAR_MAX_SIZE 077777777777ULL
+#define USTAR_MAX_SIZE 077777777777UL
 #endif
 #if TIME_MAX == 0xFFFFFFFF
 #define USTAR_MAX_MTIME TIME_MAX
 #else
-#define USTAR_MAX_MTIME 077777777777UL
+#define USTAR_MAX_MTIME 077777777777ULL
 #endif
 
 /* writes out the whole block, but only if it is full */
-- 
2.12.0
