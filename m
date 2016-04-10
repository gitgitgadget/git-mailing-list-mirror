From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH v2 06/21] bisect: add test for the bisect algorithm
Date: Sun, 10 Apr 2016 15:18:59 +0200
Message-ID: <1460294354-7031-7-git-send-email-s-beyer@gmx.net>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 15:20:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apFI1-0000Af-F2
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 15:20:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396AbcDJNUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 09:20:09 -0400
Received: from mout.gmx.net ([212.227.17.22]:50240 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753101AbcDJNUH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 09:20:07 -0400
Received: from fermat.fritz.box ([92.76.224.62]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0M03qC-1bf1ag1Bi0-00uKcA; Sun, 10 Apr 2016 15:20:02
 +0200
X-Mailer: git-send-email 2.8.1.137.g522756c
In-Reply-To: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
X-Provags-ID: V03:K0:MG4HPiCj/6FlERqhFgLuiMabk0TwEE1RHrqqn1BIPI3MasmZKZy
 exZoERoIRF6texGoTGhE09nM/h/8WPU59pgz+ccSDw42aOZB8JrzTDwhBu4mupL6lDWNImb
 0BuTl2ytkyJtf6FwqHOnUEGI5GE8SDEM9T8GUQRcHW8eqhvAGsJwn1JJcfCRZHFTzDS0uJm
 /0ebMgWY6j0Y5nQA1LRQg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:chWpVPw9Utg=:3O5gPseqvoJK/A8tdGA+3h
 bSTvC0h1R7SEWLUA0q0e3Usm7kEis3IDnT0XUH8ubxOmw/FWcXaHAEXbzm0FOjqFwwzHKMPM0
 9SkbYysj4GoN9MKo/PJheOZ7/Dvojsls5waPJTbYoN6xFw0czZ0bMCv1zAQXr1bPTpSJrCjp+
 Sf4/B6ieMrfjgB5Kw12jkT4vVT8DaJAYluVaBLxURXUZkhCss6KVrcSs8d1J4y65G9gmQti2Z
 jOdTArSqpxShwhbWNEooPtluxzP5LNtRqedZwRXNAPqAEb34Jn0Lmgkhl3rwHFl8b4AkxpUlz
 +EriOvPcdfKxKrJY/sg4r0gA/yVNN1RzmlgbpcAtdsOw81xHVvy1oITrt366pIFCwRIb4f0P5
 UIqUOHC87ZIN3R6Xb+NfhnEUC8xI9onBztRa4ahnvveZmEL4VZxj3YgjgN1iykfTcNipPDlm2
 +z8dXkK7BTL3B99AZcjuCu02Pw3BlDhgnZ4IBb60i+yNMR/1wj40oV+roRjH2mf5aUfxiiMrg
 2hVmU9hCJVWXn9LpDxh+tHGd63n3o7H7BdTaDGB7PKJJxXA9xMTsW1pW0IRR8mqVxz7Md9awL
 R5B7R/0NMs9YuUjXQ499x6DiqlvLwNXMRDtO/OKOcWrjbjzC8IWghj9ySMo3AD6c3LbIwr9Yi
 QLFNDuyHe2sGPUNRSNKV3JmFHnIsUzPGXwZ3CgC21Kkv92C0akJxdRgHatF6t9WqHoPxF98yy
 sOhsbOIkdntGeE0J6Ro7r7bXfVP3mxiJrBd3++4rOi6ZZiWpFOELfowb+ns=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291152>

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---

Notes:
    Based on the review by Christian Couder, I use test_cmp_rev()
    instead of non-standard test ... -o ...

 t/t8010-bisect-algorithm.sh | 155 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 155 insertions(+)
 create mode 100755 t/t8010-bisect-algorithm.sh

diff --git a/t/t8010-bisect-algorithm.sh b/t/t8010-bisect-algorithm.sh
new file mode 100755
index 0000000..b06053a
--- /dev/null
+++ b/t/t8010-bisect-algorithm.sh
@@ -0,0 +1,155 @@
+#!/bin/sh
+#
+# Copyright (c) 2016 Stephan Beyer
+#
+test_description='Tests git bisect algorithm'
+
+. ./test-lib.sh
+
+test_expect_success 'set up a history for the test' '
+	test_commit A1 A 1 &&
+	test_commit A2 A 2 &&
+	test_commit A3 A 3 &&
+	test_commit A4 A 4 &&
+	test_commit A5 A 5 &&
+	test_commit A6 A 6 &&
+	git checkout -b b A5 &&
+	test_commit B1 B 1 &&
+	git checkout master &&
+	test_commit A7 A 7 &&
+	git checkout b &&
+	test_commit B2 B 2 &&
+	git checkout master &&
+	test_commit A8 A 8 &&
+	test_merge Bmerge b &&
+	git checkout b &&
+	test_commit B3 B 3 &&
+	git checkout -b c A7 &&
+	test_commit C1 C 1 &&
+	git checkout -b d A3 &&
+	test_commit D1 D 1 &&
+	git checkout c &&
+	test_commit C2 C 2 &&
+	git checkout d &&
+	test_commit D2 D 2 &&
+	git checkout c &&
+	test_commit C3 C 3 &&
+	git checkout master &&
+	git merge -m BCDmerge b c d &&
+	git tag BCDmerge &&
+	test_commit A9 A 9 &&
+	git checkout d &&
+	test_commit D3 &&
+	git checkout master
+'
+
+test_expect_success 'bisect algorithm works in linear history with an odd number of commits' '
+	git bisect start A7 &&
+	git bisect next &&
+	test_cmp_rev HEAD A3 A4
+'
+
+test_expect_success 'bisect algorithm works in linear history with an even number of commits' '
+	git bisect reset &&
+	git bisect start A8 &&
+	git bisect next &&
+	test_cmp_rev HEAD A4
+'
+
+test_expect_success 'bisect algorithm works with a merge' '
+	git bisect reset &&
+	git bisect start Bmerge &&
+	git bisect next &&
+	test_cmp_rev HEAD A5 &&
+	git bisect good &&
+	test_cmp_rev HEAD A8 &&
+	git bisect good &&
+	test_cmp_rev HEAD B1 B2
+'
+
+#                   | w  min | w  min | w  min | w  min |
+# B---.    BCDmerge | 18  0  | 9    0 | 5    0 | 3    0 |
+# |\ \ \            |        |        |        |        |
+# | | | *  D2       | 5   5  | 2    2 | 2    2*| good   |
+# | | | *  D1       | 4   4  | 1    1 | 1    1 | good   |
+# | | * |  C3       | 10  8  | 1    1 | 1    1 | 1    1*|
+# | | * |  C2       | 9   9 *| good   | good   | good   |
+# | | * |  C1       | 8   8  | good   | good   | good   |
+# | * | |  B3       | 8   8  | 3    3 | 1    1 | 1    1*|
+# * | | |  Bmerge   | 11  7  | 4    4*| good   | good   |
+# |\ \ \ \          |        |        |        |        |
+# | |/ / /          |        |        |        |        |
+# | * | |  B2       | 7   7  | 2    2 | good   | good   |
+# | * | |  B1       | 6   6  | 1    1 | good   | good   |
+# * | | |  A8       | 8   8  | 1    1 | good   | good   |
+# | |/ /            |        |        |        |        |
+# |/| |             |        |        |        |        |
+# * | |   A7        | 7   7  | good   | good   | good   |
+# * | |   A6        | 6   6  | good   | good   | good   |
+# |/ /              |        |        |        |        |
+# * |     A5        | 5   5  | good   | good   | good   |
+# * |     A4        | 4   4  | good   | good   | good   |
+# |/                |        |        |        |        |
+# *       A3        | 3   3  | good   | good   | good   |
+# *       A2        | 2   2  | good   | good   | good   |
+# *       A1        | 1   1  | good   | good   | good   |
+
+test_expect_success 'bisect algorithm works with octopus merge' '
+	git bisect reset &&
+	git bisect start BCDmerge &&
+	git bisect next &&
+	test_cmp_rev HEAD C2 &&
+	git bisect good &&
+	test_cmp_rev HEAD Bmerge &&
+	git bisect good &&
+	test_cmp_rev HEAD D2 &&
+	git bisect good &&
+	test_cmp_rev HEAD B3 C3 &&
+	git bisect good &&
+	test_cmp_rev HEAD C3 B3 &&
+	git bisect good > output &&
+	grep "$(git rev-parse BCDmerge) is the first bad commit" output
+'
+
+# G 5a6bcdf        D3       | w  min | w  min |
+# | B 02f2eed      A9       | 14  0  | 7   0  |
+# | *---. 6174c5c  BCDmerge | 13  1  | 6   1  |
+# | |\ \ \                  |        |        |
+# | |_|_|/                  |        |        |
+# |/| | |                   |        |        |
+# G | | | a6d6dab  D2       | good   | good   |
+# * | | | 86414e4  D1       | good   | good   |
+# | | | * c672402  C3       | 7   7 *| good   |
+# | | | * 0555272  C2       | 6   6  | good   |
+# | | | * 28c2b2a  C1       | 5   5  | good   |
+# | | * | 4b5a7d9  B3       | 5   5  | 3   3 *|
+# | * | | a419ab7  Bmerge   | 8   6  | 4   3 *|
+# | |\ \ \                  |        |        |
+# | | |/ /                  |        |        |
+# | | * | 4fa1e39  B2       | 4   4  | 2   2  |
+# | | * | 92a014d  B1       | 3   3  | 1   1  |
+# | * | | 79158c7  A8       | 5   5  | 1   1  |
+# | | |/                    |        |        |
+# | |/|                     |        |        |
+# | * | 237eb73    A7       | 4   4  | good   |
+# | * | 3b2f811    A6       | 3   3  | good   |
+# | |/                      |        |        |
+# | * 0f2b6d2      A5       | 2   2  | good   |
+# | * 1fcdaf0      A4       | 1   1  | good   |
+# |/                        |        |        |
+# * 096648b        A3       | good   | good   |
+# * 1cf01b8        A2       | good   | good   |
+# * 6623165        A1       | good   | good   |
+
+test_expect_success 'bisect algorithm works with good commit on unrelated branch' '
+	git bisect reset &&
+	git bisect start A9 D3 &&
+	test_cmp_rev HEAD "$(git merge-base A9 D3)" &&
+	test_cmp_rev HEAD D2 &&
+	git bisect good &&
+	test_cmp_rev HEAD C3 &&
+	git bisect good &&
+	test_cmp_rev HEAD B3 Bmerge
+'
+
+test_done
-- 
2.8.1.137.g522756c
