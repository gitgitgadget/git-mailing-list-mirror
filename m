From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 5/5] t3030: merge-recursive backend test.
Date: Sat, 07 Apr 2007 07:43:01 -0700
Message-ID: <7v4pnsckju.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 07 16:44:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HaC8G-0004NE-Tu
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 16:43:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965915AbXDGOnJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Apr 2007 10:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965921AbXDGOnI
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Apr 2007 10:43:08 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:40428 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965915AbXDGOnD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2007 10:43:03 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070407144302.YUHP28911.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sat, 7 Apr 2007 10:43:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id kEj11W0081kojtg0000000; Sat, 07 Apr 2007 10:43:02 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43971>

We have fairly extensive coverage of read-tree 3-way machinery,
and many Porcelain-ish tests use git-merge front-end tests, but
we did not have good basic test for merge-recursive, which made
it very hard to hack on it.

I used this during the recent work to teach D/F conflicts to
merge-recursive.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 t/t3030-merge-recursive.sh |  528 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 528 insertions(+), 0 deletions(-)
 create mode 100755 t/t3030-merge-recursive.sh

diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
new file mode 100755
index 0000000..aef92b9
--- /dev/null
+++ b/t/t3030-merge-recursive.sh
@@ -0,0 +1,528 @@
+#!/bin/sh
+
+test_description='merge-recursive backend test'
+
+. ./test-lib.sh
+
+test_expect_success 'setup 1' '
+
+	echo hello >a &&
+	o0=$(git hash-object a) &&
+	cp a b &&
+	cp a A &&
+	mkdir d &&
+	cp a d/e &&
+
+	test_tick &&
+	git add a b A d/e &&
+	git commit -m initial &&
+	c0=$(git rev-parse --verify HEAD) &&
+	git branch side &&
+	git branch df-1 &&
+	git branch df-2 &&
+	git branch df-3 &&
+	git branch remove &&
+
+	echo hello >>a &&
+	cp a d/e &&
+	o1=$(git hash-object a) &&
+
+	git add a d/e &&
+
+	test_tick &&
+	git commit -m "master modifies a and d/e" &&
+	c1=$(git rev-parse --verify HEAD) &&
+	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
+	(
+		echo "100644 blob $o0	A"
+		echo "100644 blob $o1	a"
+		echo "100644 blob $o0	b"
+		echo "100644 blob $o1	d/e"
+		echo "100644 $o0 0	A"
+		echo "100644 $o1 0	a"
+		echo "100644 $o0 0	b"
+		echo "100644 $o1 0	d/e"
+	) >expected &&
+	git diff -u expected actual
+'
+
+test_expect_success 'setup 2' '
+
+	rm -rf [Aabd] &&
+	git checkout side &&
+	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
+	(
+		echo "100644 blob $o0	A"
+		echo "100644 blob $o0	a"
+		echo "100644 blob $o0	b"
+		echo "100644 blob $o0	d/e"
+		echo "100644 $o0 0	A"
+		echo "100644 $o0 0	a"
+		echo "100644 $o0 0	b"
+		echo "100644 $o0 0	d/e"
+	) >expected &&
+	git diff -u expected actual &&
+
+	echo goodbye >>a &&
+	o2=$(git hash-object a) &&
+
+	git add a &&
+
+	test_tick &&
+	git commit -m "side modifies a" &&
+	c2=$(git rev-parse --verify HEAD) &&
+	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
+	(
+		echo "100644 blob $o0	A"
+		echo "100644 blob $o2	a"
+		echo "100644 blob $o0	b"
+		echo "100644 blob $o0	d/e"
+		echo "100644 $o0 0	A"
+		echo "100644 $o2 0	a"
+		echo "100644 $o0 0	b"
+		echo "100644 $o0 0	d/e"
+	) >expected &&
+	git diff -u expected actual
+'
+
+test_expect_success 'setup 3' '
+
+	rm -rf [Aabd] &&
+	git checkout df-1 &&
+	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
+	(
+		echo "100644 blob $o0	A"
+		echo "100644 blob $o0	a"
+		echo "100644 blob $o0	b"
+		echo "100644 blob $o0	d/e"
+		echo "100644 $o0 0	A"
+		echo "100644 $o0 0	a"
+		echo "100644 $o0 0	b"
+		echo "100644 $o0 0	d/e"
+	) >expected &&
+	git diff -u expected actual &&
+
+	rm -f b && mkdir b && echo df-1 >b/c && git add b/c &&
+	o3=$(git hash-object b/c) &&
+
+	test_tick &&
+	git commit -m "df-1 makes b/c" &&
+	c3=$(git rev-parse --verify HEAD) &&
+	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
+	(
+		echo "100644 blob $o0	A"
+		echo "100644 blob $o0	a"
+		echo "100644 blob $o3	b/c"
+		echo "100644 blob $o0	d/e"
+		echo "100644 $o0 0	A"
+		echo "100644 $o0 0	a"
+		echo "100644 $o3 0	b/c"
+		echo "100644 $o0 0	d/e"
+	) >expected &&
+	git diff -u expected actual
+'
+
+test_expect_success 'setup 4' '
+
+	rm -rf [Aabd] &&
+	git checkout df-2 &&
+	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
+	(
+		echo "100644 blob $o0	A"
+		echo "100644 blob $o0	a"
+		echo "100644 blob $o0	b"
+		echo "100644 blob $o0	d/e"
+		echo "100644 $o0 0	A"
+		echo "100644 $o0 0	a"
+		echo "100644 $o0 0	b"
+		echo "100644 $o0 0	d/e"
+	) >expected &&
+	git diff -u expected actual &&
+
+	rm -f a && mkdir a && echo df-2 >a/c && git add a/c &&
+	o4=$(git hash-object a/c) &&
+
+	test_tick &&
+	git commit -m "df-2 makes a/c" &&
+	c4=$(git rev-parse --verify HEAD) &&
+	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
+	(
+		echo "100644 blob $o0	A"
+		echo "100644 blob $o4	a/c"
+		echo "100644 blob $o0	b"
+		echo "100644 blob $o0	d/e"
+		echo "100644 $o0 0	A"
+		echo "100644 $o4 0	a/c"
+		echo "100644 $o0 0	b"
+		echo "100644 $o0 0	d/e"
+	) >expected &&
+	git diff -u expected actual
+'
+
+test_expect_success 'setup 5' '
+
+	rm -rf [Aabd] &&
+	git checkout remove &&
+	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
+	(
+		echo "100644 blob $o0	A"
+		echo "100644 blob $o0	a"
+		echo "100644 blob $o0	b"
+		echo "100644 blob $o0	d/e"
+		echo "100644 $o0 0	A"
+		echo "100644 $o0 0	a"
+		echo "100644 $o0 0	b"
+		echo "100644 $o0 0	d/e"
+	) >expected &&
+	git diff -u expected actual &&
+
+	rm -f b &&
+	echo remove-conflict >a &&
+
+	git add a &&
+	git rm b &&
+	o5=$(git hash-object a) &&
+
+	test_tick &&
+	git commit -m "remove removes b and modifies a" &&
+	c5=$(git rev-parse --verify HEAD) &&
+	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
+	(
+		echo "100644 blob $o0	A"
+		echo "100644 blob $o5	a"
+		echo "100644 blob $o0	d/e"
+		echo "100644 $o0 0	A"
+		echo "100644 $o5 0	a"
+		echo "100644 $o0 0	d/e"
+	) >expected &&
+	git diff -u expected actual
+
+'
+
+test_expect_success 'setup 6' '
+
+	rm -rf [Aabd] &&
+	git checkout df-3 &&
+	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
+	(
+		echo "100644 blob $o0	A"
+		echo "100644 blob $o0	a"
+		echo "100644 blob $o0	b"
+		echo "100644 blob $o0	d/e"
+		echo "100644 $o0 0	A"
+		echo "100644 $o0 0	a"
+		echo "100644 $o0 0	b"
+		echo "100644 $o0 0	d/e"
+	) >expected &&
+	git diff -u expected actual &&
+
+	rm -fr d && echo df-3 >d && git add d &&
+	o6=$(git hash-object d) &&
+
+	test_tick &&
+	git commit -m "df-3 makes d" &&
+	c6=$(git rev-parse --verify HEAD) &&
+	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
+	(
+		echo "100644 blob $o0	A"
+		echo "100644 blob $o0	a"
+		echo "100644 blob $o0	b"
+		echo "100644 blob $o6	d"
+		echo "100644 $o0 0	A"
+		echo "100644 $o0 0	a"
+		echo "100644 $o0 0	b"
+		echo "100644 $o6 0	d"
+	) >expected &&
+	git diff -u expected actual
+'
+
+test_expect_success 'merge-recursive simple' '
+
+	rm -fr [Aabd] &&
+	git checkout -f "$c2" &&
+
+	git-merge-recursive "$c0" -- "$c2" "$c1"
+	status=$?
+	case "$status" in
+	1)
+		: happy
+		;;
+	*)
+		echo >&2 "why status $status!!!"
+		false
+		;;
+	esac
+'
+
+test_expect_success 'merge-recursive result' '
+
+	git ls-files -s >actual &&
+	(
+		echo "100644 $o0 0	A"
+		echo "100644 $o0 1	a"
+		echo "100644 $o2 2	a"
+		echo "100644 $o1 3	a"
+		echo "100644 $o0 0	b"
+		echo "100644 $o1 0	d/e"
+	) >expected &&
+	git diff -u expected actual
+
+'
+
+test_expect_success 'merge-recursive remove conflict' '
+
+	rm -fr [Aabd] &&
+	git checkout -f "$c1" &&
+
+	git-merge-recursive "$c0" -- "$c1" "$c5"
+	status=$?
+	case "$status" in
+	1)
+		: happy
+		;;
+	*)
+		echo >&2 "why status $status!!!"
+		false
+		;;
+	esac
+'
+
+test_expect_success 'merge-recursive remove conflict' '
+
+	git ls-files -s >actual &&
+	(
+		echo "100644 $o0 0	A"
+		echo "100644 $o0 1	a"
+		echo "100644 $o1 2	a"
+		echo "100644 $o5 3	a"
+		echo "100644 $o1 0	d/e"
+	) >expected &&
+	git diff -u expected actual
+
+'
+
+test_expect_success 'merge-recursive d/f simple' '
+	rm -fr [Aabd] &&
+	git reset --hard &&
+	git checkout -f "$c1" &&
+
+	git-merge-recursive "$c0" -- "$c1" "$c3"
+'
+
+test_expect_success 'merge-recursive result' '
+
+	git ls-files -s >actual &&
+	(
+		echo "100644 $o0 0	A"
+		echo "100644 $o1 0	a"
+		echo "100644 $o3 0	b/c"
+		echo "100644 $o1 0	d/e"
+	) >expected &&
+	git diff -u expected actual
+
+'
+
+test_expect_success 'merge-recursive d/f conflict' '
+
+	rm -fr [Aabd] &&
+	git reset --hard &&
+	git checkout -f "$c1" &&
+
+	git-merge-recursive "$c0" -- "$c1" "$c4"
+	status=$?
+	case "$status" in
+	1)
+		: happy
+		;;
+	*)
+		echo >&2 "why status $status!!!"
+		false
+		;;
+	esac
+'
+
+test_expect_success 'merge-recursive d/f conflict result' '
+
+	git ls-files -s >actual &&
+	(
+		echo "100644 $o0 0	A"
+		echo "100644 $o0 1	a"
+		echo "100644 $o1 2	a"
+		echo "100644 $o4 0	a/c"
+		echo "100644 $o0 0	b"
+		echo "100644 $o1 0	d/e"
+	) >expected &&
+	git diff -u expected actual
+
+'
+
+test_expect_success 'merge-recursive d/f conflict the other way' '
+
+	rm -fr [Aabd] &&
+	git reset --hard &&
+	git checkout -f "$c4" &&
+
+	git-merge-recursive "$c0" -- "$c4" "$c1"
+	status=$?
+	case "$status" in
+	1)
+		: happy
+		;;
+	*)
+		echo >&2 "why status $status!!!"
+		false
+		;;
+	esac
+'
+
+test_expect_success 'merge-recursive d/f conflict result the other way' '
+
+	git ls-files -s >actual &&
+	(
+		echo "100644 $o0 0	A"
+		echo "100644 $o0 1	a"
+		echo "100644 $o1 3	a"
+		echo "100644 $o4 0	a/c"
+		echo "100644 $o0 0	b"
+		echo "100644 $o1 0	d/e"
+	) >expected &&
+	git diff -u expected actual
+
+'
+
+test_expect_success 'merge-recursive d/f conflict' '
+
+	rm -fr [Aabd] &&
+	git reset --hard &&
+	git checkout -f "$c1" &&
+
+	git-merge-recursive "$c0" -- "$c1" "$c6"
+	status=$?
+	case "$status" in
+	1)
+		: happy
+		;;
+	*)
+		echo >&2 "why status $status!!!"
+		false
+		;;
+	esac
+'
+
+test_expect_success 'merge-recursive d/f conflict result' '
+
+	git ls-files -s >actual &&
+	(
+		echo "100644 $o0 0	A"
+		echo "100644 $o1 0	a"
+		echo "100644 $o0 0	b"
+		echo "100644 $o6 3	d"
+		echo "100644 $o0 1	d/e"
+		echo "100644 $o1 2	d/e"
+	) >expected &&
+	git diff -u expected actual
+
+'
+
+test_expect_success 'merge-recursive d/f conflict' '
+
+	rm -fr [Aabd] &&
+	git reset --hard &&
+	git checkout -f "$c6" &&
+
+	git-merge-recursive "$c0" -- "$c6" "$c1"
+	status=$?
+	case "$status" in
+	1)
+		: happy
+		;;
+	*)
+		echo >&2 "why status $status!!!"
+		false
+		;;
+	esac
+'
+
+test_expect_success 'merge-recursive d/f conflict result' '
+
+	git ls-files -s >actual &&
+	(
+		echo "100644 $o0 0	A"
+		echo "100644 $o1 0	a"
+		echo "100644 $o0 0	b"
+		echo "100644 $o6 2	d"
+		echo "100644 $o0 1	d/e"
+		echo "100644 $o1 3	d/e"
+	) >expected &&
+	git diff -u expected actual
+
+'
+
+test_expect_success 'reset and 3-way merge' '
+
+	git reset --hard "$c2" &&
+	git read-tree -m "$c0" "$c2" "$c1"
+
+'
+
+test_expect_success 'reset and bind merge' '
+
+	git reset --hard master &&
+	git read-tree --prefix=M/ master &&
+	git ls-files -s >actual &&
+	(
+		echo "100644 $o0 0	A"
+		echo "100644 $o0 0	M/A"
+		echo "100644 $o1 0	M/a"
+		echo "100644 $o0 0	M/b"
+		echo "100644 $o1 0	M/d/e"
+		echo "100644 $o1 0	a"
+		echo "100644 $o0 0	b"
+		echo "100644 $o1 0	d/e"
+	) >expected &&
+	git diff -u expected actual &&
+
+	git read-tree --prefix=a1/ master &&
+	git ls-files -s >actual &&
+	(
+		echo "100644 $o0 0	A"
+		echo "100644 $o0 0	M/A"
+		echo "100644 $o1 0	M/a"
+		echo "100644 $o0 0	M/b"
+		echo "100644 $o1 0	M/d/e"
+		echo "100644 $o1 0	a"
+		echo "100644 $o0 0	a1/A"
+		echo "100644 $o1 0	a1/a"
+		echo "100644 $o0 0	a1/b"
+		echo "100644 $o1 0	a1/d/e"
+		echo "100644 $o0 0	b"
+		echo "100644 $o1 0	d/e"
+	) >expected &&
+	git diff -u expected actual
+
+	git read-tree --prefix=z/ master &&
+	git ls-files -s >actual &&
+	(
+		echo "100644 $o0 0	A"
+		echo "100644 $o0 0	M/A"
+		echo "100644 $o1 0	M/a"
+		echo "100644 $o0 0	M/b"
+		echo "100644 $o1 0	M/d/e"
+		echo "100644 $o1 0	a"
+		echo "100644 $o0 0	a1/A"
+		echo "100644 $o1 0	a1/a"
+		echo "100644 $o0 0	a1/b"
+		echo "100644 $o1 0	a1/d/e"
+		echo "100644 $o0 0	b"
+		echo "100644 $o1 0	d/e"
+		echo "100644 $o0 0	z/A"
+		echo "100644 $o1 0	z/a"
+		echo "100644 $o0 0	z/b"
+		echo "100644 $o1 0	z/d/e"
+	) >expected &&
+	git diff -u expected actual
+
+'
+
+test_done
+
-- 
1.5.1.81.gee969
