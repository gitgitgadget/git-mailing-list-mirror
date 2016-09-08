Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E5F61F6BF
	for <e@80x24.org>; Thu,  8 Sep 2016 07:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757514AbcIHHba (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 03:31:30 -0400
Received: from mout.gmx.net ([212.227.17.21]:59084 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752676AbcIHHb3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 03:31:29 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0M0hT0-1avAV80Bm2-00umsq; Thu, 08 Sep 2016 09:31:16
 +0200
Date:   Thu, 8 Sep 2016 09:31:15 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 1/3] Demonstrate a problem: our pickaxe code assumes
 NUL-terminated buffers
In-Reply-To: <cover.1473319844.git.johannes.schindelin@gmx.de>
Message-ID: <53cde4f47b078378feb202dfc44c690373cfcdd2.1473319844.git.johannes.schindelin@gmx.de>
References: <cover.1473090278.git.johannes.schindelin@gmx.de> <cover.1473319844.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ZymWEkaeEIVzFoziNFvYrRiahXua4WGMbt7EqVTbKZ8p6115FL2
 a/WHqmzeJ3Ai31Ev2m0gmD6/jqj0hoLqu2bzVZ1jZHDIJOora7cfJopFR4s/8ta3g6OWPAx
 ntXfU6r94B7iTb7rJZTa8QS61Kr7ni2hw4ZH48SzX9659AHQuPCZkl9b61QxlD/WGhv+Af/
 pSvLjkN20sVRjivEnmzRQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WXRCsFiQ8Ug=:oO76uH6zZBP00VgKLvuU6P
 P9BO4+hdtlYtc+TTm3n+PiiP3KH7YlsQfYkfxCDlpvhSpJXRVFMe1JLiFnV/aC2Ie8lddK648
 lEAelAdhP9tQD6WfqNdPokqs2jspW18FxhRM6D3F5L/vZs4SLJaUZiZvK5t+u/FR2rfFcqgtJ
 WBYS3JS1+Wxl2ZAYUcNiaXgc7FRJEaYFT7W7xBnntWPAzS7j+yjpdQ+zlY416lBqrGzll0cfF
 kSEZObNQ+zwqj9ll2w6b3U+sgQygG1bMH7hNWTbr6VSaHrB2GIllq/Y6fAjbdA1N9MqqZa8NF
 f8TN9NvbZG+LN0E9+BwTqVCPH0qp2YaFtDC4feKhpKkU8tqeqm6vwI2HoyideNKQuLTW5bxMH
 Srmm4vM1M4xOoVMNsckFqdPJm72pz1pQ3PFPtXbvR+4Lib8FVuQM9gi0tPPK3BkXbFTK4Z+k8
 jbcVDFTXxSMW03ZUxdC/es/NDeCd8O0ZO/euHJNvqDWwFxX+1Mr14a6s6a5UdZ3gJ0qp+7OlV
 j6iBWsmQ+2958y5MWLyrX5nykYLv1RaPuJHUub9skIuar+7V159ng6I3U9FKOOCSKe7Xk5Uj+
 87e+TRGrkEGHCcELFkcSBttWZS5j8dxcuu/0wS4NpbjfCR5NQJegekKmO4VdpB/iOpVLBFqDg
 ueXSVnciklHiXYGCZnoOovT6JODt9Kglra5zsPzjjECwNVQptKcsiHQaj5tkgiKkWHHT+BeVB
 eSP7iyKH76kEKj/QlS16/cyi6j8sP+0j2XOGFobdmlXPeHw8GHUD9jFecO0ds2YPDM4B1l8aL
 Y+Btdhe
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


