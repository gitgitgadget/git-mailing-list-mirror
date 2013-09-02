From: Brad King <brad.king@kitware.com>
Subject: [PATCH v3 8/8] update-ref: add test cases covering --stdin signature
Date: Mon,  2 Sep 2013 13:48:56 -0400
Message-ID: <9457f5c046a0fb420f4fd730c7b02c2a75ee7e0d.1378142796.git.brad.king@kitware.com>
References: <cover.1377885441.git.brad.king@kitware.com> <cover.1378142795.git.brad.king@kitware.com>
Cc: gitster@pobox.com, mhagger@alum.mit.edu
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 02 19:50:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGYH3-000623-EW
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 19:50:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758862Ab3IBRuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 13:50:46 -0400
Received: from tripoint.kitware.com ([66.194.253.20]:55786 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758857Ab3IBRup (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Sep 2013 13:50:45 -0400
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id B52D59FB93; Mon,  2 Sep 2013 13:48:56 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <cover.1378142795.git.brad.king@kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233645>

Extend t/t1400-update-ref.sh to cover cases using the --stdin option.

Signed-off-by: Brad King <brad.king@kitware.com>
---
 t/t1400-update-ref.sh |  256 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 256 insertions(+)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index e415ee0..b6d7dfa 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -302,4 +302,260 @@ test_expect_success \
 	'git cat-file blob master@{2005-05-26 23:42}:F (expect OTHER)' \
 	'test OTHER = $(git cat-file blob "master@{2005-05-26 23:42}:F")'
 
+a=refs/heads/a
+b=refs/heads/b
+c=refs/heads/c
+z=0000000000000000000000000000000000000000
+e='""'
+pws='path with space'
+
+test_expect_success 'stdin test setup' '
+	echo "$pws" >"$pws" &&
+	git add -- "$pws" &&
+	git commit -m "$pws"
+'
+
+test_expect_success 'stdin works with no input' '
+	>stdin &&
+	git update-ref --stdin <stdin &&
+	git rev-parse --verify -q $m
+'
+
+test_expect_success 'stdin fails on bad input line with only whitespace' '
+	echo " " >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: no ref on line:  " err
+'
+
+test_expect_success 'stdin fails on bad input line with only --' '
+	echo "--" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: no ref on line: --" err
+'
+
+test_expect_success 'stdin fails on bad input line with only --bad-option' '
+	echo "--bad-option" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: unknown option --bad-option" err
+'
+
+test_expect_success 'stdin fails on bad ref name' '
+	echo "~a $m" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: invalid ref format on line: ~a $m" err
+'
+
+test_expect_success 'stdin fails on badly quoted input' '
+	echo "$a \"master" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: badly quoted argument: \\\"master" err
+'
+
+test_expect_success 'stdin fails on bad input line with too many arguments' '
+	echo "$a $m $m $m" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: too many arguments on line: $a $m $m $m" err
+'
+
+test_expect_success 'stdin fails on bad input line with too few arguments' '
+	echo "$a" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: missing new value on line: $a" err
+'
+
+test_expect_success 'stdin fails with duplicate refs' '
+	cat >stdin <<-EOF &&
+$a $m
+$b $m
+$a $m
+EOF
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: Multiple updates for ref '"'"'$a'"'"' not allowed." err
+'
+
+test_expect_success 'stdin create ref works with no old value' '
+	echo "$a $m" >stdin &&
+	git update-ref --stdin <stdin &&
+	git rev-parse $m >expect &&
+	git rev-parse $a >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin create ref works with zero old value' '
+	echo "$b $m $z" >stdin &&
+	git update-ref --stdin <stdin &&
+	git rev-parse $m >expect &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual &&
+	git update-ref -d $b &&
+	echo "$b $m $e" >stdin &&
+	git update-ref --stdin <stdin &&
+	git rev-parse $m >expect &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin create ref works with path with space to blob' '
+	echo "refs/blobs/pws \"$m:$pws\"" >stdin &&
+	git update-ref --stdin <stdin &&
+	git rev-parse "$m:$pws" >expect &&
+	git rev-parse refs/blobs/pws >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin create ref fails with wrong old value' '
+	echo "$c $m $m~1" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: Cannot lock the ref '"'"'$c'"'"'" err &&
+	test_must_fail git rev-parse --verify -q $c
+'
+
+test_expect_success 'stdin create ref fails with bad old value' '
+	echo "$c $m does-not-exist" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: invalid old value on line: $c $m does-not-exist" err &&
+	test_must_fail git rev-parse --verify -q $c
+'
+
+test_expect_success 'stdin create ref fails with bad new value' '
+	echo "$c does-not-exist" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: invalid new value on line: $c does-not-exist" err &&
+	test_must_fail git rev-parse --verify -q $c
+'
+
+test_expect_success 'stdin update ref works with right old value' '
+	echo "$b $m~1 $m" >stdin &&
+	git update-ref --stdin <stdin &&
+	git rev-parse $m~1 >expect &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin update ref fails with wrong old value' '
+	echo "$b $m~1 $m" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: Cannot lock the ref '"'"'$b'"'"'" err &&
+	git rev-parse $m~1 >expect &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin delete ref fails with wrong old value' '
+	echo "$a $e $m~1" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: Cannot lock the ref '"'"'$a'"'"'" err &&
+	git rev-parse $m >expect &&
+	git rev-parse $a >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin update symref works with --no-deref' '
+	git symbolic-ref TESTSYMREF $b &&
+	echo "--no-deref TESTSYMREF $a $b" >stdin &&
+	git update-ref --stdin <stdin &&
+	git rev-parse TESTSYMREF >expect &&
+	git rev-parse $a >actual &&
+	test_cmp expect actual &&
+	git rev-parse $m~1 >expect &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin delete symref works with --no-deref' '
+	git symbolic-ref TESTSYMREF $b &&
+	echo "--no-deref TESTSYMREF $e $b" >stdin &&
+	git update-ref --stdin <stdin &&
+	test_must_fail git rev-parse --verify -q TESTSYMREF &&
+	git rev-parse $m~1 >expect &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin delete ref works with right old value' '
+	echo "$b $e $m~1" >stdin &&
+	git update-ref --stdin <stdin &&
+	test_must_fail git rev-parse --verify -q $b
+'
+
+test_expect_success 'stdin create refs works with some old values' '
+	cat >stdin <<-EOF &&
+$a $m
+$b $m $z
+$c $z $z
+EOF
+	git update-ref --stdin <stdin &&
+	git rev-parse $m >expect &&
+	git rev-parse $a >actual &&
+	test_cmp expect actual &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual &&
+	test_must_fail git rev-parse --verify -q $c
+'
+
+test_expect_success 'stdin update refs works with identity updates' '
+	cat >stdin <<-EOF &&
+$a $m $m
+$b $m $m
+$c $z $e
+EOF
+	git update-ref --stdin <stdin &&
+	git rev-parse $m >expect &&
+	git rev-parse $a >actual &&
+	test_cmp expect actual &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual &&
+	test_must_fail git rev-parse --verify -q $c
+'
+
+test_expect_success 'stdin update refs works with extra whitespace' '
+	cat >stdin <<-EOF &&
+
+$a $m $m
+
+ "$b"  $m $m ''
+
+-- $c  $z  $e  ''
+EOF
+	git update-ref --stdin <stdin &&
+	git rev-parse $m >expect &&
+	git rev-parse $a >actual &&
+	test_cmp expect actual &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual &&
+	test_must_fail git rev-parse --verify -q $c
+'
+
+test_expect_success 'stdin update refs fails with wrong old value' '
+	git update-ref $c $m &&
+	cat >stdin <<-EOF &&
+$a $m $m
+$b $m $m
+$c $e $e
+EOF
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: Cannot lock the ref '"'"'$c'"'"'" err &&
+	git rev-parse $m >expect &&
+	git rev-parse $a >actual &&
+	test_cmp expect actual &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual &&
+	git rev-parse $c >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin delete refs works with packed and loose refs' '
+	git pack-refs --all &&
+	git update-ref $c $m~1 &&
+	cat >stdin <<-EOF &&
+$a $z $m
+$b $z $m
+$c $e $m~1
+EOF
+	git update-ref --stdin <stdin &&
+	test_must_fail git rev-parse --verify -q $a &&
+	test_must_fail git rev-parse --verify -q $b &&
+	test_must_fail git rev-parse --verify -q $c
+'
+
 test_done
-- 
1.7.10.4
