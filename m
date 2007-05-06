From: Michael Spang <mspang@uwaterloo.ca>
Subject: [PATCH 1/3] t7300: Basic tests for git-clean
Date: Sun, 06 May 2007 14:09:08 -0400
Message-ID: <463E19C4.8010601@uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 06 20:09:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HklAk-000655-SA
	for gcvg-git@gmane.org; Sun, 06 May 2007 20:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754859AbXEFSJX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 14:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754846AbXEFSJX
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 14:09:23 -0400
Received: from services10.student.cs.uwaterloo.ca ([129.97.152.18]:63844 "EHLO
	services10.student.cs.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754859AbXEFSJW (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 May 2007 14:09:22 -0400
Received: from [10.100.100.102] (rn-wan3a10.uwaterloo.ca [129.97.219.111])
	(authenticated bits=0)
	by services10.student.cs.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id l46I9EE5023539
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 6 May 2007 14:09:14 -0400 (EDT)
User-Agent: Icedove 1.5.0.10 (X11/20070329)
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.0 (services10.student.cs.uwaterloo.ca [129.97.152.13]); Sun, 06 May 2007 14:09:19 -0400 (EDT)
X-Miltered: at mailchk-m03 with ID 463E19CA.001 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: ClamAV version 0.90.2, clamav-milter version 0.90.2 on localhost
X-Virus-Status: Clean
X-UUID: 2b5e88da-863f-410f-9857-faa23b5c1a4c
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46353>

This tests the -d, -n, -f, -x, and -X options to git-clean.

Signed-off-by: Michael Spang <mspang@uwaterloo.ca>
---
 t/t7300-clean.sh |  157 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 157 insertions(+), 0 deletions(-)
 create mode 100755 t/t7300-clean.sh

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
new file mode 100755
index 0000000..1fb3850
--- /dev/null
+++ b/t/t7300-clean.sh
@@ -0,0 +1,157 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Michael Spang
+#
+
+test_description='git-clean basic tests'
+
+. ./test-lib.sh
+
+test_expect_success \
+    'setup' \
+    "mkdir -p src &&
+    touch src/part1.c Makefile &&
+    echo build >> .gitignore &&
+    echo *.o >> .gitignore &&
+    git-add . &&
+    git-commit -m setup &&
+    touch src/part2.c README &&
+    git-add ."
+
+test_expect_success \
+    'git-clean' \
+    "mkdir -p build docs &&
+    touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
+    git-clean &&
+    test -f Makefile &&
+    test -f README &&
+    test -f src/part1.c &&
+    test -f src/part2.c &&
+    test ! -e a.out &&
+    test ! -e src/part3.c &&
+    test -f docs/manual.txt &&
+    test -f obj.o &&
+    test -f build/lib.so"
+
+test_expect_success \
+    'git-clean -n' \
+    "mkdir -p build docs &&
+    touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
+    git-clean -n &&
+    test -f Makefile &&
+    test -f README &&
+    test -f src/part1.c &&
+    test -f src/part2.c &&
+    test -f a.out &&
+    test -f src/part3.c &&
+    test -f docs/manual.txt &&
+    test -f obj.o &&
+    test -f build/lib.so"
+
+test_expect_success \
+    'git-clean -d' \
+    "mkdir -p build docs &&
+    touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
+    git-clean -d &&
+    test -f Makefile &&
+    test -f README &&
+    test -f src/part1.c &&
+    test -f src/part2.c &&
+    test ! -e a.out &&
+    test ! -e src/part3.c &&
+    test ! -e docs &&
+    test -f obj.o &&
+    test -f build/lib.so"
+
+test_expect_success \
+    'git-clean -x' \
+    "mkdir -p build docs &&
+    touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
+    git-clean -x &&
+    test -f Makefile &&
+    test -f README &&
+    test -f src/part1.c &&
+    test -f src/part2.c &&
+    test ! -e a.out &&
+    test ! -e src/part3.c &&
+    test -f docs/manual.txt &&
+    test ! -e obj.o &&
+    test -f build/lib.so"
+
+test_expect_success \
+    'git-clean -d -x' \
+    "mkdir -p build docs &&
+    touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
+    git-clean -d -x &&
+    test -f Makefile &&
+    test -f README &&
+    test -f src/part1.c &&
+    test -f src/part2.c &&
+    test ! -e a.out &&
+    test ! -e src/part3.c &&
+    test ! -e docs &&
+    test ! -e obj.o &&
+    test ! -e build"
+
+test_expect_success \
+    'git-clean -X' \
+    "mkdir -p build docs &&
+    touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
+    git-clean -X &&
+    test -f Makefile &&
+    test -f README &&
+    test -f src/part1.c &&
+    test -f src/part2.c &&
+    test -f a.out &&
+    test -f src/part3.c &&
+    test -f docs/manual.txt &&
+    test ! -e obj.o &&
+    test -f build/lib.so"
+
+test_expect_success \
+    'git-clean -d -X' \
+    "mkdir -p build docs &&
+    touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
+    git-clean -d -X &&
+    test -f Makefile &&
+    test -f README &&
+    test -f src/part1.c &&
+    test -f src/part2.c &&
+    test -f a.out &&
+    test -f src/part3.c &&
+    test -f docs/manual.txt &&
+    test ! -e obj.o &&
+    test ! -e build"
+
+test_expect_failure \
+    'clean.requireForce' \
+    "mkdir -p build docs &&
+    touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
+    git-config clean.requireForce true &&
+    git-clean"
+
+test_expect_success \
+    'clean.requireForce and -n' \
+    "test -f Makefile &&
+    test -f README &&
+    test -f src/part1.c &&
+    test -f src/part2.c &&
+    test -f a.out &&
+    test -f src/part3.c &&
+    test -f docs/manual.txt &&
+    test -f obj.o &&
+    test -f build/lib.so"
+
+test_expect_success \
+    'clean.requireForce and -f' \
+    "git-clean -f &&
+    test -f README &&
+    test -f src/part1.c &&
+    test -f src/part2.c &&
+    test ! -e a.out &&
+    test ! -e src/part3.c &&
+    test -f docs/manual.txt &&
+    test -f obj.o &&
+    test -f build/lib.so"
+
+test_done
