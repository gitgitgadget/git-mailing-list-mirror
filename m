From: Brad King <brad.king@kitware.com>
Subject: [PATCH v4 8/8] update-ref: add test cases covering --stdin signature
Date: Wed,  4 Sep 2013 11:22:45 -0400
Message-ID: <80fd3ec9c847a0dbf505da3a539d690d524972e2.1378307529.git.brad.king@kitware.com>
References: <cover.1378142795.git.brad.king@kitware.com> <cover.1378307529.git.brad.king@kitware.com>
Cc: gitster@pobox.com, mhagger@alum.mit.edu
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 04 17:24:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHEwn-00085z-Fz
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 17:24:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935096Ab3IDPYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 11:24:41 -0400
Received: from tripoint.kitware.com ([66.194.253.20]:60257 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S935083Ab3IDPYj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 11:24:39 -0400
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id 905879FB98; Wed,  4 Sep 2013 11:22:45 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.rc3
In-Reply-To: <cover.1378307529.git.brad.king@kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233838>

Extend t/t1400-update-ref.sh to cover cases using the --stdin option.

Signed-off-by: Brad King <brad.king@kitware.com>
---
 t/t1400-update-ref.sh | 445 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 445 insertions(+)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index e415ee0..e8ba0d2 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -302,4 +302,449 @@ test_expect_success \
 	'git cat-file blob master@{2005-05-26 23:42}:F (expect OTHER)' \
 	'test OTHER = $(git cat-file blob "master@{2005-05-26 23:42}:F")'
 
+a=refs/heads/a
+b=refs/heads/b
+c=refs/heads/c
+E='""'
+pws='path with space'
+
+print_nul() {
+	while test $# -gt 0; do
+		printf -- "$1" &&
+		printf -- "Q" | q_to_nul &&
+		shift || return
+	done
+}
+
+test_expect_success '-z fails without --stdin' '
+	test_must_fail git update-ref -z $m $m $m 2>err &&
+	grep "usage: git update-ref" err
+'
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
+test_expect_success 'stdin works with whitespace-only input' '
+	echo " " >stdin &&
+	git update-ref --stdin <stdin 2>err &&
+	git rev-parse --verify -q $m
+'
+
+test_expect_success 'stdin fails on bad input line with only --' '
+	echo "--" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: input line with no ref" err
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
+	grep "fatal: invalid ref format: ~a" err
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
+	grep "fatal: too many arguments for ref $a" err
+'
+
+test_expect_success 'stdin fails on bad input line with too few arguments' '
+	echo "$a" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: missing new value for ref $a" err
+'
+
+test_expect_success 'stdin fails with duplicate refs' '
+	cat >stdin <<-EOF &&
+	$a $m
+	$b $m
+	$a $m
+	EOF
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
+	echo "$b $m $Z" >stdin &&
+	git update-ref --stdin <stdin &&
+	git rev-parse $m >expect &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual &&
+	git update-ref -d $b
+'
+
+test_expect_success 'stdin create ref works with empty old value' '
+	echo "$b $m $E" >stdin &&
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
+	test_cmp expect actual &&
+	git update-ref -d refs/blobs/pws
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
+	grep "fatal: invalid old value for ref $c: does-not-exist" err &&
+	test_must_fail git rev-parse --verify -q $c
+'
+
+test_expect_success 'stdin create ref fails with bad new value' '
+	echo "$c does-not-exist" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: invalid new value for ref $c: does-not-exist" err &&
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
+	echo "$a $E $m~1" >stdin &&
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
+	echo "--no-deref TESTSYMREF $E $b" >stdin &&
+	git update-ref --stdin <stdin &&
+	test_must_fail git rev-parse --verify -q TESTSYMREF &&
+	git rev-parse $m~1 >expect &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin delete ref works with right old value' '
+	echo "$b $E $m~1" >stdin &&
+	git update-ref --stdin <stdin &&
+	test_must_fail git rev-parse --verify -q $b
+'
+
+test_expect_success 'stdin create refs works with some old values' '
+	cat >stdin <<-EOF &&
+	$a $m
+	$b $m $Z
+	$c $Z $Z
+	EOF
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
+	$a $m $m
+	$b $m $m
+	$c $Z $E
+	EOF
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
+	''
+	$a $m $m
+	''
+	 "$b"  $m $m ''
+	''
+	-- $c  $Z  $E  ''
+	EOF
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
+	$a $m $m
+	$b $m $m
+	$c $E $E
+	EOF
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
+	$a $Z $m
+	$b $Z $m
+	$c $E $m~1
+	EOF
+	git update-ref --stdin <stdin &&
+	test_must_fail git rev-parse --verify -q $a &&
+	test_must_fail git rev-parse --verify -q $b &&
+	test_must_fail git rev-parse --verify -q $c
+'
+
+test_expect_success 'stdin -z works on empty input' '
+	>stdin &&
+	git update-ref -z --stdin <stdin &&
+	git rev-parse --verify -q $m
+'
+
+test_expect_success 'stdin -z works on empty input sequence' '
+	print_nul "\n" >stdin &&
+	git update-ref -z --stdin <stdin &&
+	git rev-parse --verify -q $m
+'
+
+test_expect_success 'stdin -z fails on unterminated input sequence' '
+	print_nul "$a" "$m" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: unterminated -z input sequence" err
+'
+
+test_expect_success 'stdin -z create ref works with no old value' '
+	print_nul "$a" "$m" "\n" >stdin &&
+	git update-ref -z --stdin <stdin &&
+	git rev-parse $m >expect &&
+	git rev-parse $a >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin -z create ref works with zero old value' '
+	print_nul "$b" "$m" "$Z" "\n" >stdin &&
+	git update-ref -z --stdin <stdin &&
+	git rev-parse $m >expect &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual &&
+	git update-ref -d $b
+'
+
+test_expect_success 'stdin -z create ref works with empty old value' '
+	print_nul "$b" "$m" "" "\n" >stdin &&
+	git update-ref -z --stdin <stdin &&
+	git rev-parse $m >expect &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin -z create ref works with path with space to blob' '
+	print_nul "refs/blobs/pws" "$m:$pws" "\n" >stdin &&
+	git update-ref -z --stdin <stdin &&
+	git rev-parse "$m:$pws" >expect &&
+	git rev-parse refs/blobs/pws >actual &&
+	test_cmp expect actual &&
+	git update-ref -d refs/blobs/pws
+'
+
+test_expect_success 'stdin -z create ref fails with wrong old value' '
+	print_nul "$c" "$m" "$m~1" "\n" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: Cannot lock the ref '"'"'$c'"'"'" err &&
+	test_must_fail git rev-parse --verify -q $c
+'
+
+test_expect_success 'stdin -z create ref fails with bad old value' '
+	print_nul "$c" "$m" "does-not-exist" "\n" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: invalid old value for ref $c: does-not-exist" err &&
+	test_must_fail git rev-parse --verify -q $c
+'
+
+test_expect_success 'stdin -z create ref fails with bad new value' '
+	print_nul "$c" "does-not-exist" "\n" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: invalid new value for ref $c: does-not-exist" err &&
+	test_must_fail git rev-parse --verify -q $c
+'
+
+test_expect_success 'stdin -z update ref works with right old value' '
+	print_nul "$b" "$m~1" "$m" "\n" >stdin &&
+	git update-ref -z --stdin <stdin &&
+	git rev-parse $m~1 >expect &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin -z update ref fails with wrong old value' '
+	print_nul "$b" "$m~1" "$m" "\n" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: Cannot lock the ref '"'"'$b'"'"'" err &&
+	git rev-parse $m~1 >expect &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin -z delete ref fails with wrong old value' '
+	print_nul "$a" "" "$m~1" "\n" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: Cannot lock the ref '"'"'$a'"'"'" err &&
+	git rev-parse $m >expect &&
+	git rev-parse $a >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin -z update symref works with --no-deref' '
+	git symbolic-ref TESTSYMREF $b &&
+	print_nul "--no-deref" "TESTSYMREF" "$a" "$b" "\n" >stdin &&
+	git update-ref -z --stdin <stdin &&
+	git rev-parse TESTSYMREF >expect &&
+	git rev-parse $a >actual &&
+	test_cmp expect actual &&
+	git rev-parse $m~1 >expect &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin -z delete symref works with --no-deref' '
+	git symbolic-ref TESTSYMREF $b &&
+	print_nul "--no-deref" "TESTSYMREF" "" "$b" "\n" >stdin &&
+	git update-ref -z --stdin <stdin &&
+	test_must_fail git rev-parse --verify -q TESTSYMREF &&
+	git rev-parse $m~1 >expect &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin -z delete ref works with right old value' '
+	print_nul "$b" "" "$m~1" "\n" >stdin &&
+	git update-ref -z --stdin <stdin &&
+	test_must_fail git rev-parse --verify -q $b
+'
+
+test_expect_success 'stdin -z create refs works with some old values' '
+	print_nul "$a" "$m" "\n" "$b" "$m" "$Z" "\n" "$c" "$Z" "$Z" "\n" >stdin &&
+	git update-ref -z --stdin <stdin &&
+	git rev-parse $m >expect &&
+	git rev-parse $a >actual &&
+	test_cmp expect actual &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual &&
+	test_must_fail git rev-parse --verify -q $c
+'
+
+test_expect_success 'stdin -z update refs works with identity updates' '
+	print_nul "$a" "$m" "$m" "\n" "$b" "$m" "$m" "\n" "$c" "$Z" "" "\n" >stdin &&
+	git update-ref -z --stdin <stdin &&
+	git rev-parse $m >expect &&
+	git rev-parse $a >actual &&
+	test_cmp expect actual &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual &&
+	test_must_fail git rev-parse --verify -q $c
+'
+
+test_expect_success 'stdin -z update refs fails with wrong old value' '
+	git update-ref $c $m &&
+	print_nul "$a" "$m" "$m" "\n" "$b" "$m" "$m" "\n" "$c" "" "" "\n" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
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
+test_expect_success 'stdin -z delete refs works with packed and loose refs' '
+	git pack-refs --all &&
+	git update-ref $c $m~1 &&
+	print_nul "$a" "$Z" "$m" "\n" "$b" "$Z" "$m" "\n" "$c" "" "$m~1" "\n" >stdin &&
+	git update-ref -z --stdin <stdin &&
+	test_must_fail git rev-parse --verify -q $a &&
+	test_must_fail git rev-parse --verify -q $b &&
+	test_must_fail git rev-parse --verify -q $c
+'
+
 test_done
-- 
1.8.4.rc3
