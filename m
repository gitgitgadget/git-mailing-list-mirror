Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3F5320193
	for <e@80x24.org>; Mon,  5 Sep 2016 15:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755286AbcIEPpQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 11:45:16 -0400
Received: from mout.gmx.net ([212.227.15.15]:60165 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754345AbcIEPpM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 11:45:12 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MFdDB-1bsmZG3ZNl-00EeAM; Mon, 05 Sep 2016 17:45:03
 +0200
Date:   Mon, 5 Sep 2016 17:45:02 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] Demonstrate a problem: our pickaxe code assumes
 NUL-terminated buffers
In-Reply-To: <cover.1473090278.git.johannes.schindelin@gmx.de>
Message-ID: <ca678535c64570add58cfff95709c3c67384139d.1473090278.git.johannes.schindelin@gmx.de>
References: <cover.1473090278.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:2ERmd0r74gbPInmGiJWQd2UrUR04Vp62KK4mOkmCde+kDOdqA9t
 6ap3+QAYGHktruMQoa4rEw5ccYgBiwW9xC6KC8hz2grOXmyS9LQI+tPwj0/yL+PUzgmpuLQ
 arYvUJYUoktA7nmYHzgDn8W2aeJvwNf3E2sJJwl1oJ7EQxLeMxIQHfrC8YxM0RFOW7Rz77x
 pCN0ie+Uy92sYK3msTg7A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/iWRs7Kw5+U=:im6/9pQNWsk3UpsgwidOZ5
 sCOsLv5L5ky7vArhKeBBPElAVjq3RuDQUGfgCJdSBtWOAnOXsdU7UsUYTsXfefVz918RyVaDv
 KThJDPv7fN7pVjnywHENSBVxkvRn/IWyWd3ECPg5GIimtYNSEjhIXPd0jMiZk2Ts3Ktd0e+WP
 mPpVCN5ZU7IBcUVi8nDwcVrMwm2CzGd+3u+ZqfpsKx6cVM30A4X7IuMnzimMdgNnLCqK8+84T
 ZHZgETsG7oLjg+aMJJC1tdIszYRatnkvqGpAiozP9EtpcQAFJmMv2RM9FASXz3z24GxAR13Ex
 3W2deft1TZ2vo1jcEtz8RtTXcAt/EtaYYhSsX9mybuIYnQ3utU8O9QGea5eHgRiHpduw9W7jm
 n/wNIYwP2YnNJ6HAi6yrHn5lYmVCsfyOlEzvecaCHIbD+0GA0J1A0mD78GD8sLF/0P8x4mMMt
 qEgPvSLc1l4cuLPa5drR5fMuvVs0WjDqycslf+I+PYYwBQBiSwag8tq/21DDYU5Zr5JS7o3Bl
 UKpwgG3kxdl084RZ+GfwYrMkX9jVRxFH0FnU4NGNoW79tIsGNB9/v6kd1NazZzV0l8aI36xk1
 Hk5v676dxaLWAo/JAbGBdwAXnb6yGZX3+hFuc0TXhk640xdtwSNvbd6FR7qcxLThjvCp+SVzx
 65NbI0wGDasviWQ3z11w/liqKXPZXzHTORMeXxvYMa/Fa9jupNUQlQf6RkECHfS5HqQX/lCnz
 y0ZiQ2cdBsVM9YreD3Z2+P9MzFc1t5290Qjt9L7ElmAmMCrhVLaRQ+rXXGdv2blcuWQlLohQN
 fQGXtGZ
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

So we simply mark it with `test_expect_success` for now.

This test case represents a Minimal, Complete and Verifiable Example of
a breakage reported by Chris Sidi.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t4059-diff-pickaxe.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100755 t/t4059-diff-pickaxe.sh

diff --git a/t/t4059-diff-pickaxe.sh b/t/t4059-diff-pickaxe.sh
new file mode 100755
index 0000000..f0bf50b
--- /dev/null
+++ b/t/t4059-diff-pickaxe.sh
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
+test_expect_success '-G matches' '
+	git diff --name-only -G "^0{4096}$" HEAD^ >out &&
+	test 4096-zeroes.txt = "$(cat out)"
+'
+
+test_done
-- 
2.10.0.windows.1.2.g732a511


