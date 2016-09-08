Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E37721F6BF
	for <e@80x24.org>; Thu,  8 Sep 2016 07:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932545AbcIHH55 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 03:57:57 -0400
Received: from mout.gmx.net ([212.227.17.22]:59329 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932529AbcIHH54 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 03:57:56 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MX19U-1bVtd31Hwi-00VxPs; Thu, 08 Sep 2016 09:57:49
 +0200
Date:   Thu, 8 Sep 2016 09:57:46 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 1/3] Demonstrate a problem: our pickaxe code assumes
 NUL-terminated buffers
In-Reply-To: <cover.1473321437.git.johannes.schindelin@gmx.de>
Message-ID: <53cde4f47b078378feb202dfc44c690373cfcdd2.1473321437.git.johannes.schindelin@gmx.de>
References: <cover.1473319844.git.johannes.schindelin@gmx.de> <cover.1473321437.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:zB6/G+h5NFGdSvUYBK3eiFu/UB7TfElS5sDHVh0PPK7epIRcer3
 Ukg7XiH3+ZVTT7d9oAlxHPvXt6mgJKDcfls9o+013gXy8+3kKScCYa8Ecmt8jX8i1gdFDXr
 oiPbOb+KXt18+O5+Wi6Qp2c2xbXRmlZ9qcunMKQox2efaA1BUTvNKB/Vz77Q0tUi4/IuDa+
 mrpEhFNgY/LPwfhJrfaiQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0hqmPLxY4SA=:56IiIv3nzGBGK1rbvVuE3G
 JWGHjnYiE3vCEr+WDSmPQLtTf7UFAMUg3Af7J3GB/Telhf9NZ1rGfcv5lVOBifAcD2Yc6E7gx
 5cIDoMPg04CmqyRM9UEyRXQaED/xLPEEjBFqpUKD3EpK2PBgpII6x7jvI7pNLBeP9aClWgfiD
 7Qk8kqF4bo1oroczjrOS9u5/WOTSA6FVol8cxpHYjsz5SqHSvke1XsiSqAYfsjLpFt0AxLXlA
 DpB+lRLWeDmoASiYmDelbe2toESu4GtMc2SLYKOjkpv6EnUmZXaH8EHgCKDiuY9X6YPjoKs4S
 DMeARdGKt33jpj/CUcVRZldugWEple51b6G2e5Gu9A61Cg8TR8BBwyP/jEZze1UN83/MQDWgL
 36QgeYJXFSgtYE+8yhJaUGF35DEtAX1CZZV/M0iAbOXqzncUuK19axLOgziOhp3KKQn0YTmYO
 VojWoW7w8L9ZPg+p+8Yydi+yTNqObClufom9MVyie1AyHVdfcsB6/gTvPav92BbM2xPpdzORS
 oXuA+1CEned7KoZmXqHsIMKx19i2wMSIGxcP7+YMx9Xt0VnwKP1xXkikDB1aACW5A6Y9EkkpX
 JdHnOS2ca14c1Emesvsh4CJvGNORvpJKddnq4/znJ/WVRSA6ecXDPr4KshR+KbQRBxiLTAK0p
 d/AFa19YSwJgW0gQzYUTvgbRu0SCSOa9ZQb5ws73jWOHS/0SNmhs6zQX9Et01v0gHH0+6LWv7
 kezZODHmeBdU9zrcmRzIFkVtMjm01H9JPZzcIpZdZdmSuViJm+7TDV8KHHTTRlqK3mL1vK2Ub
 jCUCP5d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When our pickaxe code feeds file contents to regexec(), it implicitly
assumes that the file contents are read into implicitly NUL-terminated
buffers (i.e. that we overallocate by 1, appending a single '\0').

This is not so.

In particular when the file contents are simply mmap()ed, we can be
virtually certain that the buffer is preceding uninitialized bytes, or
invalid pages.

Note that the test we add here is known to be flakey: we simply cannot
know whether the byte following the mmap()ed ones is a NUL or not.

Typically, on Linux the test passes. On Windows, it fails virtually
every time due to an access violation (that's a segmentation fault for
you Unix-y people out there). And Windows would be correct: the
regexec() call wants to operate on a regular, NUL-terminated string,
there is no NUL in the mmap()ed memory range, and it is undefined
whether the next byte is even legal to access.

When run with --valgrind it demonstrates quite clearly the breakage, of
course.

Being marked with `test_expect_failure`, this test will sometimes be
declare "TODO fixed", even if it only passes by mistake.

This test case represents a Minimal, Complete and Verifiable Example of
a breakage reported by Chris Sidi.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t4061-diff-pickaxe.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100755 t/t4061-diff-pickaxe.sh

diff --git a/t/t4061-diff-pickaxe.sh b/t/t4061-diff-pickaxe.sh
new file mode 100755
index 0000000..5929f2e
--- /dev/null
+++ b/t/t4061-diff-pickaxe.sh
@@ -0,0 +1,22 @@
+#!/bin/sh
+#
+# Copyright (c) 2016 Johannes Schindelin
+#
+
+test_description='Pickaxe options'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	test_commit initial &&
+	printf "%04096d" 0 >4096-zeroes.txt &&
+	git add 4096-zeroes.txt &&
+	test_tick &&
+	git commit -m "A 4k file"
+'
+test_expect_failure '-G matches' '
+	git diff --name-only -G "^0{4096}$" HEAD^ >out &&
+	test 4096-zeroes.txt = "$(cat out)"
+'
+
+test_done
-- 
2.10.0.windows.1.10.g803177d


