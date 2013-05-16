From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v10 14/14] test: add t7301 for git-clean--interactive
Date: Thu, 16 May 2013 17:53:45 +0800
Message-ID: <ea012065b1859f47b3b4698fca4a7f920f89da89.1368696028.git.worldhello.net@gmail.com>
References: <cover.1368696028.git.worldhello.net@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 16 11:54:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucutj-0001Jx-OO
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 11:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119Ab3EPJys (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 05:54:48 -0400
Received: from mail-da0-f53.google.com ([209.85.210.53]:56840 "EHLO
	mail-da0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841Ab3EPJyq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 05:54:46 -0400
Received: by mail-da0-f53.google.com with SMTP id t11so1546540daj.40
        for <git@vger.kernel.org>; Thu, 16 May 2013 02:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=ZloXDEs8ytBZ/BAq2UR0hQDtG6qO//gnIuOjPsD4cCw=;
        b=EpxTO8TcQzwu4u3QJmDeNWuTOzAlI9rf7hAVdSmCoVytasPFRk83RSB0zDI2PDZgnv
         2OR3rco6tZsqR1Zb1pQ0jb7rk1WN8zCasVOZCAsRcpPKl6w5floqun1Pq5moI9FmNf+5
         UoTY13toxKt3eCjDn7tgXTxfVlPzaAqmy81g5yXL3YGjpLwXDd47ZJ+hVTva3YAXcnaq
         8vWUv7vVNYvai+N+NFPw81ZVLjFGqTZZXlXIyZQx6DeO0YU/lYmvTV+wij4v8U9/AO/p
         Xfyu/Cwhzabfl8kw/nOd/fyDNWxgBrBWX0Cxv9Pb9UbXn60PnUYcHfjExjQG003s/N6P
         GPkw==
X-Received: by 10.68.87.229 with SMTP id bb5mr42166330pbb.171.1368698085564;
        Thu, 16 May 2013 02:54:45 -0700 (PDT)
Received: from localhost.localdomain ([114.248.153.37])
        by mx.google.com with ESMTPSA id cd2sm6183092pbd.35.2013.05.16.02.54.42
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 16 May 2013 02:54:44 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.407.g762149a
In-Reply-To: <cover.1368696028.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368696028.git.worldhello.net@gmail.com>
References: <cover.1368696028.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224542>

Add testcases for git-clean--interactive.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 t/t7301-clean-interactive.sh | 439 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 439 insertions(+)
 create mode 100755 t/t7301-clean-interactive.sh

diff --git a/t/t7301-clean-interactive.sh b/t/t7301-clean-interactive.sh
new file mode 100755
index 00000..27465
--- /dev/null
+++ b/t/t7301-clean-interactive.sh
@@ -0,0 +1,439 @@
+#!/bin/sh
+
+test_description='git clean -i basic tests'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+
+	mkdir -p src &&
+	touch src/part1.c Makefile &&
+	echo build >.gitignore &&
+	echo \*.o >>.gitignore &&
+	git add . &&
+	git commit -m setup &&
+	touch src/part2.c README &&
+	git add .
+
+'
+
+test_expect_success 'git clean -i (clean)' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
+        docs/manual.txt obj.o build/lib.so &&
+	echo c | git clean -i &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test ! -f a.out &&
+	test -f docs/manual.txt &&
+	test ! -f src/part3.c &&
+	test ! -f src/part3.h &&
+	test ! -f src/part4.c &&
+	test ! -f src/part4.h &&
+	test -f obj.o &&
+	test -f build/lib.so
+
+'
+
+test_expect_success 'git clean -i (quit)' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
+        docs/manual.txt obj.o build/lib.so &&
+	echo q | git clean -i &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test -f a.out &&
+	test -f docs/manual.txt &&
+	test -f src/part3.c &&
+	test -f src/part3.h &&
+	test -f src/part4.c &&
+	test -f src/part4.h &&
+	test -f obj.o &&
+	test -f build/lib.so
+
+'
+
+test_expect_success 'git clean -i (Ctrl+D)' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
+        docs/manual.txt obj.o build/lib.so &&
+	echo "\04" | git clean -i &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test -f a.out &&
+	test -f docs/manual.txt &&
+	test -f src/part3.c &&
+	test -f src/part3.h &&
+	test -f src/part4.c &&
+	test -f src/part4.h &&
+	test -f obj.o &&
+	test -f build/lib.so
+
+'
+
+test_expect_success 'git clean -id (filter all)' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
+        docs/manual.txt obj.o build/lib.so &&
+	(echo f; echo "*"; echo; echo c) | \
+	git clean -id &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test -f a.out &&
+	test -f docs/manual.txt &&
+	test -f src/part3.c &&
+	test -f src/part3.h &&
+	test -f src/part4.c &&
+	test -f src/part4.h &&
+	test -f obj.o &&
+	test -f build/lib.so
+
+'
+
+test_expect_success 'git clean -id (filter patterns)' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
+        docs/manual.txt obj.o build/lib.so &&
+	(echo f; echo "part3.* *.out"; echo; echo c) | \
+	git clean -id &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test -f a.out &&
+	test ! -f docs/manual.txt &&
+	test -f src/part3.c &&
+	test -f src/part3.h &&
+	test ! -f src/part4.c &&
+	test ! -f src/part4.h &&
+	test -f obj.o &&
+	test -f build/lib.so
+
+'
+
+test_expect_success 'git clean -id (filter patterns 2)' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
+        docs/manual.txt obj.o build/lib.so &&
+	(echo f; echo "* !*.out"; echo; echo c) | \
+	git clean -id &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test ! -f a.out &&
+	test -f docs/manual.txt &&
+	test -f src/part3.c &&
+	test -f src/part3.h &&
+	test -f src/part4.c &&
+	test -f src/part4.h &&
+	test -f obj.o &&
+	test -f build/lib.so
+
+'
+
+test_expect_success 'git clean -id (select - all)' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
+        docs/manual.txt obj.o build/lib.so &&
+	(echo s; echo "*"; echo; echo c) | \
+	git clean -id &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test ! -f a.out &&
+	test ! -f docs/manual.txt &&
+	test ! -f src/part3.c &&
+	test ! -f src/part3.h &&
+	test ! -f src/part4.c &&
+	test ! -f src/part4.h &&
+	test -f obj.o &&
+	test -f build/lib.so
+
+'
+
+test_expect_success 'git clean -id (select - none)' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
+        docs/manual.txt obj.o build/lib.so &&
+	(echo s; echo; echo c) | \
+	git clean -id &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test -f a.out &&
+	test -f docs/manual.txt &&
+	test -f src/part3.c &&
+	test -f src/part3.h &&
+	test -f src/part4.c &&
+	test -f src/part4.h &&
+	test -f obj.o &&
+	test -f build/lib.so
+
+'
+
+test_expect_success 'git clean -id (select - number)' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
+        docs/manual.txt obj.o build/lib.so &&
+	(echo s; echo 3; echo; echo c) | \
+	git clean -id &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test -f a.out &&
+	test -f docs/manual.txt &&
+	test ! -f src/part3.c &&
+	test -f src/part3.h &&
+	test -f src/part4.c &&
+	test -f src/part4.h &&
+	test -f obj.o &&
+	test -f build/lib.so
+
+'
+
+test_expect_success 'git clean -id (select - number 2)' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
+        docs/manual.txt obj.o build/lib.so &&
+	(echo s; echo 2 3; echo 5; echo; echo c) | \
+	git clean -id &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test -f a.out &&
+	test ! -f docs/manual.txt &&
+	test ! -f src/part3.c &&
+	test -f src/part3.h &&
+	test ! -f src/part4.c &&
+	test -f src/part4.h &&
+	test -f obj.o &&
+	test -f build/lib.so
+
+'
+
+test_expect_success 'git clean -id (select - number 3)' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
+        docs/manual.txt obj.o build/lib.so &&
+	(echo s; echo 3,4 5; echo; echo c) | \
+	git clean -id &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test -f a.out &&
+	test -f docs/manual.txt &&
+	test ! -f src/part3.c &&
+	test ! -f src/part3.h &&
+	test ! -f src/part4.c &&
+	test -f src/part4.h &&
+	test -f obj.o &&
+	test -f build/lib.so
+
+'
+
+test_expect_success 'git clean -id (select - range)' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
+        docs/manual.txt obj.o build/lib.so &&
+	(echo s; echo 1,3-4; echo 2; echo; echo c) | \
+	git clean -id &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test ! -f a.out &&
+	test ! -f src/part3.c &&
+	test ! -f src/part3.h &&
+	test -f src/part4.c &&
+	test -f src/part4.h &&
+	test ! -f docs/manual.txt &&
+	test -f obj.o &&
+	test -f build/lib.so
+
+'
+
+test_expect_success 'git clean -id (select - range 2)' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
+        docs/manual.txt obj.o build/lib.so &&
+	(echo s; echo 4- 1; echo; echo c) | \
+	git clean -id &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test ! -f a.out &&
+	test -f docs/manual.txt &&
+	test -f src/part3.c &&
+	test ! -f src/part3.h &&
+	test ! -f src/part4.c &&
+	test ! -f src/part4.h &&
+	test -f obj.o &&
+	test -f build/lib.so
+
+'
+
+test_expect_success 'git clean -id (inverse select)' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
+        docs/manual.txt obj.o build/lib.so &&
+	(echo s; echo "*"; echo -5- 1 -2; echo; echo c) | \
+	git clean -id &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test ! -f a.out &&
+	test -f docs/manual.txt &&
+	test ! -f src/part3.c &&
+	test ! -f src/part3.h &&
+	test -f src/part4.c &&
+	test -f src/part4.h &&
+	test -f obj.o &&
+	test -f build/lib.so
+
+'
+
+test_expect_success 'git clean -id (ask)' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
+        docs/manual.txt obj.o build/lib.so &&
+	(echo a; echo Y; echo y; echo no; echo yes; echo bad; echo) | \
+	git clean -id &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test ! -f a.out &&
+	test ! -f docs/manual.txt &&
+	test -f src/part3.c &&
+	test ! -f src/part3.h &&
+	test -f src/part4.c &&
+	test -f src/part4.h &&
+	test -f obj.o &&
+	test -f build/lib.so
+
+'
+
+test_expect_success 'git clean -id (ask - Ctrl+D)' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
+        docs/manual.txt obj.o build/lib.so &&
+	(echo a; echo Y; echo no; echo yes; echo "\04") | \
+	git clean -id &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test ! -f a.out &&
+	test -f docs/manual.txt &&
+	test ! -f src/part3.c &&
+	test -f src/part3.h &&
+	test -f src/part4.c &&
+	test -f src/part4.h &&
+	test -f obj.o &&
+	test -f build/lib.so
+
+'
+
+test_expect_success 'git clean -id with prefix and path (filter)' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
+        docs/manual.txt obj.o build/lib.so &&
+	(cd build/ && \
+	 (echo f; echo "docs"; echo "*.h"; echo ; echo c) | \
+	 git clean -id ..) &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test ! -f a.out &&
+	test -f docs/manual.txt &&
+	test ! -f src/part3.c &&
+	test -f src/part3.h &&
+	test ! -f src/part4.c &&
+	test -f src/part4.h &&
+	test -f obj.o &&
+	test -f build/lib.so
+
+'
+
+test_expect_success 'git clean -id with prefix and path (select by name)' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
+        docs/manual.txt obj.o build/lib.so &&
+	(cd build/ && \
+	 (echo s; echo "../docs/"; echo "../src/part3.c"; \
+	  echo "../src/part4.c";  echo; echo c) | \
+	 git clean -id ..) &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test -f a.out &&
+	test ! -f docs/manual.txt &&
+	test ! -f src/part3.c &&
+	test -f src/part3.h &&
+	test ! -f src/part4.c &&
+	test -f src/part4.h &&
+	test -f obj.o &&
+	test -f build/lib.so
+
+'
+
+test_expect_success 'git clean -id with prefix and path (ask)' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
+        docs/manual.txt obj.o build/lib.so &&
+	(cd build/ && \
+	 (echo a; echo Y; echo y; echo no; echo yes; echo bad; echo) | \
+	 git clean -id ..) &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test ! -f a.out &&
+	test ! -f docs/manual.txt &&
+	test -f src/part3.c &&
+	test ! -f src/part3.h &&
+	test -f src/part4.c &&
+	test -f src/part4.h &&
+	test -f obj.o &&
+	test -f build/lib.so
+
+'
+
+test_done
-- 
1.8.3.rc1.407.g762149a
