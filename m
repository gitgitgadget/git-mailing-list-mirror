From: Johan Herland <johan@herland.net>
Subject: [PATCH 5/7] Softrefs: Add testcases for basic softrefs behaviour
Date: Sat, 09 Jun 2007 20:23:38 +0200
Message-ID: <200706092023.38661.johan@herland.net>
References: <200706040251.05286.johan@herland.net>
 <200706092019.13185.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 20:23:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx5bH-0004Zm-0e
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 20:23:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756368AbXFISXq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 14:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756386AbXFISXp
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 14:23:45 -0400
Received: from smtp.getmail.no ([84.208.20.33]:41957 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756273AbXFISXp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 14:23:45 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJD00L03SFKZK00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 20:23:44 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJD00JN1SFFIH00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 20:23:39 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJD000OPSFEUA50@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 20:23:39 +0200 (CEST)
In-reply-to: <200706092019.13185.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49597>

Adds testing of the basic options available to the git-softref command.

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t3050-softrefs.sh |  314 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 314 insertions(+), 0 deletions(-)
 create mode 100755 t/t3050-softrefs.sh

diff --git a/t/t3050-softrefs.sh b/t/t3050-softrefs.sh
new file mode 100755
index 0000000..a925178
--- /dev/null
+++ b/t/t3050-softrefs.sh
@@ -0,0 +1,314 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Johan Herland
+#
+
+test_description='Basic functionality of soft references'
+. ./test-lib.sh
+
+
+# Prepare repo and create some notes
+
+test_expect_success 'Populating repo with test data' '
+	echo "foo" > foo &&
+	git-add foo &&
+	test_tick &&
+	git-commit -m "Initial commit" &&
+	git-tag -a -m "Tagging initial commit" footag &&
+	echo "bar" >> foo &&
+	test_tick &&
+	git-commit -m "Second commit" foo &&
+	git-tag -a -m "Tagging second commit" bartag
+'
+
+# At this point we should have:
+# - commit @ 301711b66fe71164f646b798706a2c1f7024da8d ("Initial commit")
+#    - tag @ ad60bc179c6874af6d97f181c67f11adcca5122b ("footag")
+# - commit @ 9671cbee7ad26528645b2665c8f74d39a6288864 ("Second commit")
+#    - tag @ a927fc832d42f1f64d8318e8acec43545d9562de ("bartag")
+# - The tag creation should also have created softrefs:
+#   - From "Initial commit" to "footag"
+#   - From  "Second commit" to "bartag"
+
+# Testing git-softref --list
+
+test_expect_success 'Testing git-softref --list on initial test data (1)' '
+	cat > expected_output << EOF &&
+301711b66fe71164f646b798706a2c1f7024da8d ad60bc179c6874af6d97f181c67f11adcca5122b
+9671cbee7ad26528645b2665c8f74d39a6288864 a927fc832d42f1f64d8318e8acec43545d9562de
+EOF
+	git-softref > actual_output 2>&1 &&
+	cmp actual_output expected_output &&
+	git-softref --list > actual_output 2>&1 &&
+	cmp actual_output expected_output
+'
+
+test_expect_success 'Testing git-softref --list on initial test data (2)' '
+	cat > expected_output << EOF &&
+9671cbee7ad26528645b2665c8f74d39a6288864 a927fc832d42f1f64d8318e8acec43545d9562de
+EOF
+	git-softref --list 9671cbee7ad26528645b2665c8f74d39a6288864 > actual_output 2>&1 &&
+	cmp actual_output expected_output &&
+	git-softref --list HEAD > actual_output 2>&1 &&
+	cmp actual_output expected_output
+'
+
+test_expect_success 'Testing git-softref --list on initial test data (3)' '
+	cat > expected_output << EOF &&
+301711b66fe71164f646b798706a2c1f7024da8d ad60bc179c6874af6d97f181c67f11adcca5122b
+EOF
+	git-softref --list 301711b66fe71164f646b798706a2c1f7024da8d > actual_output 2>&1 &&
+	cmp actual_output expected_output &&
+	git-softref --list HEAD^ > actual_output 2>&1 &&
+	cmp actual_output expected_output
+'
+
+test_expect_success 'Testing git-softref --list on initial test data (4)' '
+	cat > expected_output << EOF &&
+EOF
+	git-softref --list footag > actual_output 2>&1 &&
+	cmp actual_output expected_output &&
+	git-softref --list bartag > actual_output 2>&1 &&
+	cmp actual_output expected_output
+'
+
+# Testing git-softref --has
+
+test_expect_success 'Testing git-softref --has on initial test data' '
+	(git-softref --has 301711b66fe71164f646b798706a2c1f7024da8d ad60bc179c6874af6d97f181c67f11adcca5122b;
+	test "$?" = "1") &&
+	(git-softref --has HEAD^ footag;
+	test "$?" = "1") &&
+	(git-softref --has footag^{} footag;
+	test "$?" = "1") &&
+	(git-softref --has 9671cbee7ad26528645b2665c8f74d39a6288864 a927fc832d42f1f64d8318e8acec43545d9562de;
+	test "$?" = "1") &&
+	(git-softref --has HEAD bartag;
+	test "$?" = "1") &&
+	(git-softref --has bartag^{} bartag;
+	test "$?" = "1") &&
+	(git-softref --has ad60bc179c6874af6d97f181c67f11adcca5122b 301711b66fe71164f646b798706a2c1f7024da8d;
+	test "$?" = "0") &&
+	(git-softref --has a927fc832d42f1f64d8318e8acec43545d9562de 9671cbee7ad26528645b2665c8f74d39a6288864;
+	test "$?" = "0") &&
+	(git-softref --has HEAD HEAD^;
+	test "$?" = "0") &&
+	(git-softref --has HEAD^ HEAD;
+	test "$?" = "0") &&
+	(git-softref --has footag HEAD;
+	test "$?" = "0") &&
+	(git-softref --has bartag HEAD;
+	test "$?" = "0") &&
+	(git-softref --has footag HEAD^;
+	test "$?" = "0") &&
+	(git-softref --has bartag HEAD^;
+	test "$?" = "0") &&
+	(git-softref --has footag bartag;
+	test "$?" = "0") &&
+	(git-softref --has bartag footag;
+	test "$?" = "0")
+'
+
+# Testing git-softref --rebuild-tags
+
+test_expect_success 'Testing git-softref --rebuild-tags on initial test data' '
+	cat > expected_output << EOF &&
+Added 0 missing softrefs for tag objects.
+EOF
+	cat .git/softrefs.* | sort > expected_softrefs &&
+	git-softref --rebuild-tags > actual_output 2>&1 &&
+	cat .git/softrefs.* | sort > actual_softrefs &&
+	cmp actual_output   expected_output &&
+	cmp actual_softrefs expected_softrefs
+'
+
+# Testing git-softref --add
+
+test_expect_success 'Testing git-softref --add with existing softref' '
+	cat > expected_output << EOF &&
+EOF
+	cat .git/softrefs.* | sort > expected_softrefs &&
+	git-softref --add HEAD bartag > actual_output 2>&1 &&
+	cat .git/softrefs.* | sort > actual_softrefs &&
+	cmp actual_output   expected_output &&
+	cmp actual_softrefs expected_softrefs
+'
+
+test_expect_success 'Testing git-softref --add with self-refential softref' '
+	cat > expected_output << EOF &&
+error: Cannot add self-reference (9671cbee7ad26528645b2665c8f74d39a6288864 -> 9671cbee7ad26528645b2665c8f74d39a6288864)
+fatal: Failed to create softref from HEAD to HEAD
+EOF
+	cat .git/softrefs.* | sort > expected_softrefs &&
+	(git-softref --add HEAD HEAD > actual_output 2>&1; test "$?" != "0") &&
+	cat .git/softrefs.* | sort > actual_softrefs &&
+	cmp actual_output   expected_output &&
+	cmp actual_softrefs expected_softrefs
+'
+
+test_expect_success 'Testing git-softref --add with non-existing objects (1)' '
+	cat > expected_output << EOF &&
+fatal: Not a valid object name 1234567890123456789012345678901234567890
+EOF
+	cat .git/softrefs.* | sort > expected_softrefs &&
+	(git-softref --add 1234567890123456789012345678901234567890 HEAD > actual_output 2>&1;
+		test "$?" != "0") &&
+	cat .git/softrefs.* | sort > actual_softrefs &&
+	cmp actual_output   expected_output &&
+	cmp actual_softrefs expected_softrefs &&
+	(git-softref --add HEAD 1234567890123456789012345678901234567890 > actual_output 2>&1;
+		test "$?" != "0") &&
+	cat .git/softrefs.* | sort > actual_softrefs &&
+	cmp actual_output   expected_output &&
+	cmp actual_softrefs expected_softrefs
+'
+
+test_expect_success 'Testing git-softref --add with non-existing objects (2)' '
+	cat > expected_output << EOF &&
+fatal: Not a valid object name HEAD^^^
+EOF
+	cat .git/softrefs.* | sort > expected_softrefs &&
+	(git-softref --add HEAD^^^ HEAD > actual_output 2>&1; test "$?" != "0") &&
+	cat .git/softrefs.* | sort > actual_softrefs &&
+	cmp actual_output   expected_output &&
+	cmp actual_softrefs expected_softrefs
+'
+
+test_expect_success 'Testing git-softref --add with valid arguments (1)' '
+	cat > expected_output << EOF &&
+EOF
+	cat > new_softref << EOF
+301711b66fe71164f646b798706a2c1f7024da8d 9671cbee7ad26528645b2665c8f74d39a6288864
+EOF
+	cat .git/softrefs.* new_softref | sort > expected_softrefs &&
+	git-softref --add HEAD^ HEAD > actual_output 2>&1 &&
+	cat .git/softrefs.* | sort > actual_softrefs &&
+	cmp actual_output   expected_output &&
+	cmp actual_softrefs expected_softrefs
+'
+
+test_expect_success 'Testing git-softref --add with valid arguments (2)' '
+	cat > expected_output << EOF &&
+EOF
+	cat > new_softref << EOF
+ad60bc179c6874af6d97f181c67f11adcca5122b a927fc832d42f1f64d8318e8acec43545d9562de
+EOF
+	cat .git/softrefs.* new_softref | sort > expected_softrefs &&
+	git-softref --add footag bartag > actual_output 2>&1 &&
+	cat .git/softrefs.* | sort > actual_softrefs &&
+	cmp actual_output   expected_output &&
+	cmp actual_softrefs expected_softrefs
+'
+
+# Removing softrefs
+
+test_expect_success 'Removing all softrefs' '
+	rm .git/softrefs.*
+'
+
+# Testing git-softref --list and --has
+
+test_expect_success 'Testing git-softref with no softrefs' '
+	cat > expected_output << EOF &&
+EOF
+	git-softref > actual_output 2>&1 &&
+	cmp actual_output expected_output &&
+	git-softref --list > actual_output 2>&1 &&
+	cmp actual_output expected_output &&
+	git-softref --list 9671cbee7ad26528645b2665c8f74d39a6288864 > actual_output 2>&1 &&
+	cmp actual_output expected_output &&
+	git-softref --list HEAD > actual_output 2>&1 &&
+	cmp actual_output expected_output &&
+	git-softref --list HEAD^ > actual_output 2>&1 &&
+	cmp actual_output expected_output &&
+	git-softref --list footag > actual_output 2>&1 &&
+	cmp actual_output expected_output &&
+	git-softref --list bartag > actual_output 2>&1 &&
+	cmp actual_output expected_output &&
+	git-softref --has HEAD bartag > actual_output 2>&1 &&
+	cmp actual_output expected_output &&
+	git-softref --has HEAD^ footag > actual_output 2>&1 &&
+	cmp actual_output expected_output
+'
+
+# Testing git-softref --rebuild-tags
+# (Should recreated missing softrefs for tag objects reachable from 'refs/tags')
+
+test_expect_success 'Testing git-softref --rebuild-tags to rebuild missing tag softrefs' '
+	cat > expected_output << EOF &&
+Added 2 missing softrefs for tag objects.
+EOF
+	cat > new_softref << EOF
+301711b66fe71164f646b798706a2c1f7024da8d ad60bc179c6874af6d97f181c67f11adcca5122b
+9671cbee7ad26528645b2665c8f74d39a6288864 a927fc832d42f1f64d8318e8acec43545d9562de
+EOF
+	cat .git/softrefs.* new_softref | sort > expected_softrefs &&
+	git-softref --rebuild-tags > actual_output 2>&1 &&
+	cat .git/softrefs.* | sort > actual_softrefs &&
+	cmp actual_output   expected_output &&
+	cmp actual_softrefs expected_softrefs
+'
+
+# Testing git-softref --merge-unsorted
+
+test_expect_success 'Testing git-softref --merge-unsorted' '
+	cat > expected_output << EOF &&
+EOF
+	rm .git/softrefs*
+	cat > .git/softrefs.unsorted << EOF
+9671cbee7ad26528645b2665c8f74d39a6288864 a927fc832d42f1f64d8318e8acec43545d9562de
+301711b66fe71164f646b798706a2c1f7024da8d ad60bc179c6874af6d97f181c67f11adcca5122b
+EOF
+	cat > expected_softrefs << EOF
+301711b66fe71164f646b798706a2c1f7024da8d ad60bc179c6874af6d97f181c67f11adcca5122b
+9671cbee7ad26528645b2665c8f74d39a6288864 a927fc832d42f1f64d8318e8acec43545d9562de
+EOF
+	git-softref --merge-unsorted > actual_output 2>&1 &&
+	cmp actual_output expected_output &&
+	cmp .git/softrefs.sorted expected_softrefs &&
+	test ! -e .git/softrefs.unsorted
+'
+
+# Testing git-softref --merge-unsorted <filename>
+
+test_expect_success 'Testing git-softref --merge-unsorted <filename>' '
+	cat > expected_output << EOF &&
+EOF
+	rm .git/softrefs*
+	cat > new_softrefs << EOF
+9671cbee7ad26528645b2665c8f74d39a6288864 a927fc832d42f1f64d8318e8acec43545d9562de
+301711b66fe71164f646b798706a2c1f7024da8d ad60bc179c6874af6d97f181c67f11adcca5122b
+EOF
+	cat > expected_softrefs << EOF
+301711b66fe71164f646b798706a2c1f7024da8d ad60bc179c6874af6d97f181c67f11adcca5122b
+9671cbee7ad26528645b2665c8f74d39a6288864 a927fc832d42f1f64d8318e8acec43545d9562de
+EOF
+	git-softref --merge-unsorted new_softrefs > actual_output 2>&1 &&
+	cmp actual_output expected_output &&
+	cmp .git/softrefs.sorted expected_softrefs &&
+	test -e new_softrefs
+'
+
+# Testing git-softref --merge-sorted <filename>
+
+test_expect_success 'Testing git-softref --merge-sorted <filename>' '
+	cat > expected_output << EOF &&
+EOF
+	rm .git/softrefs*
+	cat > new_softrefs << EOF
+301711b66fe71164f646b798706a2c1f7024da8d ad60bc179c6874af6d97f181c67f11adcca5122b
+9671cbee7ad26528645b2665c8f74d39a6288864 a927fc832d42f1f64d8318e8acec43545d9562de
+EOF
+	cat > expected_softrefs << EOF
+301711b66fe71164f646b798706a2c1f7024da8d ad60bc179c6874af6d97f181c67f11adcca5122b
+9671cbee7ad26528645b2665c8f74d39a6288864 a927fc832d42f1f64d8318e8acec43545d9562de
+EOF
+	git-softref --merge-sorted new_softrefs > actual_output 2>&1 &&
+	cmp actual_output expected_output &&
+	cmp .git/softrefs.sorted expected_softrefs &&
+	test -e new_softrefs
+'
+
+# FIXME: More testing needed on how softrefs interact with the rest of git
+
+test_done
-- 
1.5.2.1.144.gabc40
