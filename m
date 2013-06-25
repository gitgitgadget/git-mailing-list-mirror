From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v15 15/16] test: add t7301 for git-clean--interactive
Date: Tue, 25 Jun 2013 23:53:56 +0800
Message-ID: <e492b49b19fa4860116a4d54e06b1a8c4a0fa7f9.1372175283.git.worldhello.net@gmail.com>
References: <cover.1372175282.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Jun 25 17:56:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrVaw-0004nk-0F
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 17:55:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643Ab3FYPzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 11:55:16 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:38405 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752611Ab3FYPzL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 11:55:11 -0400
Received: by mail-pb0-f42.google.com with SMTP id un1so12787372pbc.29
        for <git@vger.kernel.org>; Tue, 25 Jun 2013 08:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=sQwoQg5eBb6Kd9e4WT5mHfdhwh1+OKE76zkllFd9rXI=;
        b=QEt6z0yFheS5YWO8wtKbQu3fDqD9LG6W1gI6cuF2iMxo1wQDyiPVUsoX+urCrjOVX1
         l6AQbDNnx46LGWaMAF3kS9aQR/fS9CTzZFVfC5LjlhBt9QQyf/QSnVq5MSR//eD5GJ6z
         8+Q6748eAXoAFYye5S5EyhFq4OS0mPPr+8eoCP6kSnNCYa+r0lrUqQdrM3DUEGWOUgmi
         g8kvc8CHfL2FUjQ3iMJapS4JrkgFumv3C3xEHf3pKOtQI0JA39xKkq+5KE2IqKFTAqmR
         j7zYkOA+sU3J+LF/ECB8mzrNf3Wm12YREwKhBs3NJmV1b4hnliV7LplI9yom9PSytvA4
         obKg==
X-Received: by 10.66.155.138 with SMTP id vw10mr466891pab.91.1372175710819;
        Tue, 25 Jun 2013 08:55:10 -0700 (PDT)
Received: from localhost.localdomain ([114.248.133.39])
        by mx.google.com with ESMTPSA id pb5sm23760930pbc.29.2013.06.25.08.55.05
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 25 Jun 2013 08:55:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.756.g2e9b71f
In-Reply-To: <cover.1372175282.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1372175282.git.worldhello.net@gmail.com>
References: <cover.1372175282.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228975>

Add test cases for git-clean--interactive.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7301-clean-interactive.sh | 439 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 439 insertions(+)
 create mode 100755 t/t7301-clean-interactive.sh

diff --git a/t/t7301-clean-interactive.sh b/t/t7301-clean-interactive.sh
new file mode 100755
index 00000..4e605
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
+	docs/manual.txt obj.o build/lib.so &&
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
+	docs/manual.txt obj.o build/lib.so &&
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
+	docs/manual.txt obj.o build/lib.so &&
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
+	docs/manual.txt obj.o build/lib.so &&
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
+	docs/manual.txt obj.o build/lib.so &&
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
+	docs/manual.txt obj.o build/lib.so &&
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
+	docs/manual.txt obj.o build/lib.so &&
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
+	docs/manual.txt obj.o build/lib.so &&
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
+	docs/manual.txt obj.o build/lib.so &&
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
+	docs/manual.txt obj.o build/lib.so &&
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
+	docs/manual.txt obj.o build/lib.so &&
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
+	docs/manual.txt obj.o build/lib.so &&
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
+	docs/manual.txt obj.o build/lib.so &&
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
+	docs/manual.txt obj.o build/lib.so &&
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
+	docs/manual.txt obj.o build/lib.so &&
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
+	docs/manual.txt obj.o build/lib.so &&
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
+	docs/manual.txt obj.o build/lib.so &&
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
+	docs/manual.txt obj.o build/lib.so &&
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
+	docs/manual.txt obj.o build/lib.so &&
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
1.8.3.1.756.g2e9b71f
