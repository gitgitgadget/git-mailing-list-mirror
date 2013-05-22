From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v13 15/15] test: add t7301 for git-clean--interactive
Date: Wed, 22 May 2013 09:40:36 +0800
Message-ID: <2dd5d7db36c5ea524d58f10e150aa02f913422f0.1369186574.git.worldhello.net@gmail.com>
References: <cover.1369186574.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 22 03:41:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uey3o-0001jn-Gh
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 03:41:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754723Ab3EVBlg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 21:41:36 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:43917 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754710Ab3EVBlc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 21:41:32 -0400
Received: by mail-pb0-f44.google.com with SMTP id wz12so1197393pbc.17
        for <git@vger.kernel.org>; Tue, 21 May 2013 18:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=FV+7zyvxRWPBo4fwyHLR6ZpaFAjP5RRs33i+kjW6vPQ=;
        b=P3iTryqXf7Ra2aQnq5SrMmZTjjNlXO27RbTes7xnDCRf7tJERvGxvkK8Bva881zMhu
         YVT2hur1NXGtUd+xOpYfKTP0alchxTWTZKVn5XQxxgDnbkq5mp2jbzcW8ghMJLkob65j
         Ngrsp+edkDxdCAR48f06RjuTDIYDIUygQiqSRq6WoKqz0ZgFAqD9DOo8JkJjrZzdmfKT
         dA6HqfuFjMK5wR5wgsi8hbiYsjXOSS1/nf7SNNlq7SqWoqb7Jsbo3kD84Ai7f3PwYlsX
         C+Ey0qVJQI9EUpgk6iQPibBZP848UJVaoKtWEnL7pr/JLoHiN1gOJdPd770SkYwRCUA8
         h67w==
X-Received: by 10.68.245.200 with SMTP id xq8mr5539572pbc.32.1369186891354;
        Tue, 21 May 2013 18:41:31 -0700 (PDT)
Received: from localhost.localdomain ([114.248.150.82])
        by mx.google.com with ESMTPSA id at1sm4939345pbc.10.2013.05.21.18.41.28
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 21 May 2013 18:41:30 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.368.g7c798dd
In-Reply-To: <cover.1369186574.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1369186574.git.worldhello.net@gmail.com>
References: <7vhahwm5n6.fsf@alter.siamese.dyndns.org> <cover.1369186574.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225116>

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
1.8.3.rc3.368.g7c798dd
