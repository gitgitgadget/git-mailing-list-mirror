Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53E3D20985
	for <e@80x24.org>; Wed, 21 Sep 2016 18:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754708AbcIUSYC (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 14:24:02 -0400
Received: from mout.gmx.net ([212.227.15.15]:61559 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754218AbcIUSYB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 14:24:01 -0400
Received: from virtualbox ([108.198.118.51]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MgcTf-1baK8U18Pn-00O0Lh; Wed, 21 Sep 2016 20:23:53
 +0200
Date:   Wed, 21 Sep 2016 20:23:22 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Benjamin Kramer <benny.kra@googlemail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v4 1/3] regex: -G<pattern> feeds a non NUL-terminated string
 to regexec() and fails
In-Reply-To: <cover.1474482164.git.johannes.schindelin@gmx.de>
Message-ID: <5d2418672a7761c9b514139ee9c53792d0cf638b.1474482164.git.johannes.schindelin@gmx.de>
References: <cover.1473321437.git.johannes.schindelin@gmx.de> <cover.1474482164.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:SjE/AcdQRAq84NQZfeXq1chQMbklZwd+6tBqtGvPUmIfCMlp8Jr
 xcxxLKyGqnma55ey/xyUgA34gd7XxZs3fV3qeMe9RXOppJ16kFXJZ3M7rj9KR03OZdX8ypm
 SzF5U85U6zqSI/K7DsLAZ02eV9IuH0hIxLbiwt1P7hvh/ruHZEr0TFiW8SglnafeQ/JSC5S
 uLYj8BIEfzAfQvAHjAYsw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PFljq9sRImo=:Elc6WrO9AWMoF1ejhv2nUd
 vaqQJUYP5uxZGAFnTCiBVs08LFT3oJonh6okhzDGybCAx7QYepqBsNDfPS7qlfoWVgHxedKSQ
 o2Q9fUKCCUrcveuQqD/Xx2I0wvWXI8Wkfrgznj1cO/eAQ4A8pu23GHsuqK0u7I5+U0zt+Mvgm
 aL83hldHrZU1Y76tWlOp/HQF7q9WyRlm0Jc/QB3k/bCqHoJqWfv+5gZ29pp2GGgKZupGY3tgH
 +WEW5lA5a7OTrb0aJKDpQVQCuWKCrK7XHI2Ua5irdiXozmimaY9nYqtxy4gsP9USVt+pkMwa6
 pyg7QXoRNe+tKRjIJFLjgnnZAs3cs88wXTubcZTebadF+2feZY6fJYfp3ECKlbO2y12azM23H
 da7JJYqYmqwnLhvGjAN434qbZFtzY6TTRA9LikiLoQaZq5b4v1TtUopLFIUAGot0j/CNYYPv0
 Wu46lPZsOaGMIhLaimqxx/9ZjEYYZ7xnzGtzvo/3Xlhh8L9uGHaT3MgE9pt7U1P2SmvyHsAUh
 gg4XFFQfm9T5wHvENVy7KuEk0auz4fV13wFUujmIJmpygR1/WV00xzWhkzyB8MCS8CAdIsHfK
 gsUgJQSsLpAubjhlp5zHAchW0aSkj0CqAmu8vfmeE56KdGKAPX7m8JL61UGa1xSJe5CTbKjtS
 7BaQI5Rb5iqhpK37EzyeOXJQQsu2ilRyHExXcNeIIdDW/ZUb3181wV94rmbURcSnWdoyDErfm
 LtJPDaKsM1cypt5Vdo1X5TBPz1rPjX+vLvnu4KbC0XFiUzPsAUpdxHU2La919onwZDG8BOq91
 oSpZGEi
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


