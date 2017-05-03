Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79C24207F8
	for <e@80x24.org>; Wed,  3 May 2017 23:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752456AbdECXlP (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 19:41:15 -0400
Received: from avasout07.plus.net ([84.93.230.235]:48525 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751366AbdECXlN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 19:41:13 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout07 with smtp
        id Fzh51v0031keHif01zh6kL; Thu, 04 May 2017 00:41:07 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=HP2zLslv c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=EYCQrzecNKGN43fLVDgA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] archive-tar: fix a sparse 'constant too large' warning
Message-ID: <252ddd6a-3516-6619-8ea6-d3897f13d93d@ramsayjones.plus.com>
Date:   Thu, 4 May 2017 00:41:05 +0100
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
constant to use an 'ULL' type suffix.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Junio,

I try to build git on 32-bit Linux about once a week (but it can
sometimes be less often than that!). During tonight's build sparse
chirped at me while building the 'next' branch.

This patch was built on top of next.

ATB,
Ramsay Jones

 archive-tar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/archive-tar.c b/archive-tar.c
index 319a5b1c7..6dddc0cff 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -33,7 +33,7 @@ static int write_tar_filter_archive(const struct archiver *ar,
 #if TIME_MAX == 0xFFFFFFFF
 #define USTAR_MAX_MTIME TIME_MAX
 #else
-#define USTAR_MAX_MTIME 077777777777UL
+#define USTAR_MAX_MTIME 077777777777ULL
 #endif
 
 /* writes out the whole block, but only if it is full */
-- 
2.12.0
