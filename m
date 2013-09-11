From: Brad King <brad.king@kitware.com>
Subject: [PATCH v6.1 8/8] update-ref: add test cases covering --stdin signature
Date: Wed, 11 Sep 2013 08:46:18 -0400
Message-ID: <6e43bee0d5d8f3ba5e1e41ed8f9faa2f10654591.1378903086.git.brad.king@kitware.com>
References: <CAPig+cQNrtznw1jc+dVOZhqBV7me0gC6Vx-k5siMPeyCzxmBSQ@mail.gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 11 14:48:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJjqT-00025L-9Q
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 14:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640Ab3IKMs3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 08:48:29 -0400
Received: from tripoint.kitware.com ([66.194.253.20]:44753 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751327Ab3IKMs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 08:48:28 -0400
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id ACD899FB8C; Wed, 11 Sep 2013 08:46:18 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.rc3
In-Reply-To: <CAPig+cQNrtznw1jc+dVOZhqBV7me0gC6Vx-k5siMPeyCzxmBSQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234563>

Extend t/t1400-update-ref.sh to cover cases using the --stdin option.

Signed-off-by: Brad King <brad.king@kitware.com>
---

On 09/10/2013 06:46 PM, Eric Sunshine wrote:
> Thus printf provides all the functionality you require, and
> print_nul() function can be dropped. So:
> 
>     printf '%s\0' foo bar baz

Wonderful, thanks!  The single-quotes do not fit easily inside
test code blocks that are themselves single-quoted, so I packaged
the format up in a variable.  Here is a revised patch.

-Brad

 t/t1400-update-ref.sh | 632 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 632 insertions(+)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index e415ee0..6ffd82f 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -302,4 +302,636 @@ test_expect_success \
 	'git cat-file blob master@{2005-05-26 23:42}:F (expect OTHER)' \
 	'test OTHER = $(git cat-file blob "master@{2005-05-26 23:42}:F")'
 
+a=refs/heads/a
+b=refs/heads/b
+c=refs/heads/c
+E='""'
+F='%s\0'
+pws='path with space'
+
+test_expect_success 'stdin test setup' '
+	echo "$pws" >"$pws" &&
+	git add -- "$pws" &&
+	git commit -m "$pws"
+'
+
+test_expect_success '-z fails without --stdin' '
+	test_must_fail git update-ref -z $m $m $m 2>err &&
+	grep "usage: git update-ref" err
+'
+
+test_expect_success 'stdin works with no input' '
+	>stdin &&
+	git update-ref --stdin <stdin &&
+	git rev-parse --verify -q $m
+'
+
+test_expect_success 'stdin fails on empty line' '
+	echo "" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: empty command in input" err
+'
+
+test_expect_success 'stdin fails on only whitespace' '
+	echo " " >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: whitespace before command:  " err
+'
+
+test_expect_success 'stdin fails on leading whitespace' '
+	echo " create $a $m" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: whitespace before command:  create $a $m" err
+'
+
+test_expect_success 'stdin fails on unknown command' '
+	echo "unknown $a" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: unknown command: unknown $a" err
+'
+
+test_expect_success 'stdin fails on badly quoted input' '
+	echo "create $a \"master" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: badly quoted argument: \\\"master" err
+'
+
+test_expect_success 'stdin fails on arguments not separated by space' '
+	echo "create \"$a\"master" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: expected SP but got: master" err
+'
+
+test_expect_success 'stdin fails create with no ref' '
+	echo "create " >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: create line missing <ref>" err
+'
+
+test_expect_success 'stdin fails create with bad ref name' '
+	echo "create ~a $m" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: invalid ref format: ~a" err
+'
+
+test_expect_success 'stdin fails create with no new value' '
+	echo "create $a" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: create $a missing <newvalue>" err
+'
+
+test_expect_success 'stdin fails create with too many arguments' '
+	echo "create $a $m $m" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: create $a has extra input:  $m" err
+'
+
+test_expect_success 'stdin fails update with no ref' '
+	echo "update " >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: update line missing <ref>" err
+'
+
+test_expect_success 'stdin fails update with bad ref name' '
+	echo "update ~a $m" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: invalid ref format: ~a" err
+'
+
+test_expect_success 'stdin fails update with no new value' '
+	echo "update $a" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: update $a missing <newvalue>" err
+'
+
+test_expect_success 'stdin fails update with too many arguments' '
+	echo "update $a $m $m $m" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: update $a has extra input:  $m" err
+'
+
+test_expect_success 'stdin fails delete with no ref' '
+	echo "delete " >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: delete line missing <ref>" err
+'
+
+test_expect_success 'stdin fails delete with bad ref name' '
+	echo "delete ~a $m" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: invalid ref format: ~a" err
+'
+
+test_expect_success 'stdin fails delete with too many arguments' '
+	echo "delete $a $m $m" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: delete $a has extra input:  $m" err
+'
+
+test_expect_success 'stdin fails verify with too many arguments' '
+	echo "verify $a $m $m" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: verify $a has extra input:  $m" err
+'
+
+test_expect_success 'stdin fails option with unknown name' '
+	echo "option unknown" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: option unknown: unknown" err
+'
+
+test_expect_success 'stdin fails with duplicate refs' '
+	cat >stdin <<-EOF &&
+	create $a $m
+	create $b $m
+	create $a $m
+	EOF
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: Multiple updates for ref '"'"'$a'"'"' not allowed." err
+'
+
+test_expect_success 'stdin create ref works' '
+	echo "create $a $m" >stdin &&
+	git update-ref --stdin <stdin &&
+	git rev-parse $m >expect &&
+	git rev-parse $a >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin update ref creates with zero old value' '
+	echo "update $b $m $Z" >stdin &&
+	git update-ref --stdin <stdin &&
+	git rev-parse $m >expect &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual &&
+	git update-ref -d $b
+'
+
+test_expect_success 'stdin update ref creates with empty old value' '
+	echo "update $b $m $E" >stdin &&
+	git update-ref --stdin <stdin &&
+	git rev-parse $m >expect &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin create ref works with path with space to blob' '
+	echo "create refs/blobs/pws \"$m:$pws\"" >stdin &&
+	git update-ref --stdin <stdin &&
+	git rev-parse "$m:$pws" >expect &&
+	git rev-parse refs/blobs/pws >actual &&
+	test_cmp expect actual &&
+	git update-ref -d refs/blobs/pws
+'
+
+test_expect_success 'stdin update ref fails with wrong old value' '
+	echo "update $c $m $m~1" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: Cannot lock the ref '"'"'$c'"'"'" err &&
+	test_must_fail git rev-parse --verify -q $c
+'
+
+test_expect_success 'stdin update ref fails with bad old value' '
+	echo "update $c $m does-not-exist" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: invalid old value for ref $c: does-not-exist" err &&
+	test_must_fail git rev-parse --verify -q $c
+'
+
+test_expect_success 'stdin create ref fails with bad new value' '
+	echo "create $c does-not-exist" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: invalid new value for ref $c: does-not-exist" err &&
+	test_must_fail git rev-parse --verify -q $c
+'
+
+test_expect_success 'stdin create ref fails with zero new value' '
+	echo "create $c " >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: create $c given zero new value" err &&
+	test_must_fail git rev-parse --verify -q $c
+'
+
+test_expect_success 'stdin update ref works with right old value' '
+	echo "update $b $m~1 $m" >stdin &&
+	git update-ref --stdin <stdin &&
+	git rev-parse $m~1 >expect &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin delete ref fails with wrong old value' '
+	echo "delete $a $m~1" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: Cannot lock the ref '"'"'$a'"'"'" err &&
+	git rev-parse $m >expect &&
+	git rev-parse $a >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin delete ref fails with zero old value' '
+	echo "delete $a " >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: delete $a given zero old value" err &&
+	git rev-parse $m >expect &&
+	git rev-parse $a >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin update symref works option no-deref' '
+	git symbolic-ref TESTSYMREF $b &&
+	cat >stdin <<-EOF &&
+	option no-deref
+	update TESTSYMREF $a $b
+	EOF
+	git update-ref --stdin <stdin &&
+	git rev-parse TESTSYMREF >expect &&
+	git rev-parse $a >actual &&
+	test_cmp expect actual &&
+	git rev-parse $m~1 >expect &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin delete symref works option no-deref' '
+	git symbolic-ref TESTSYMREF $b &&
+	cat >stdin <<-EOF &&
+	option no-deref
+	delete TESTSYMREF $b
+	EOF
+	git update-ref --stdin <stdin &&
+	test_must_fail git rev-parse --verify -q TESTSYMREF &&
+	git rev-parse $m~1 >expect &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin delete ref works with right old value' '
+	echo "delete $b $m~1" >stdin &&
+	git update-ref --stdin <stdin &&
+	test_must_fail git rev-parse --verify -q $b
+'
+
+test_expect_success 'stdin update/create/verify combination works' '
+	cat >stdin <<-EOF &&
+	update $a $m
+	create $b $m
+	verify $c
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
+	update $a $m $m
+	update $b $m $m
+	update $c $Z $E
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
+	update $a $m $m
+	update $b $m $m
+	update $c  ''
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
+	delete $a $m
+	update $b $Z $m
+	update $c $E $m~1
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
+test_expect_success 'stdin -z fails on empty line' '
+	echo "" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: whitespace before command: " err
+'
+
+test_expect_success 'stdin -z fails on empty command' '
+	printf $F "" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: empty command in input" err
+'
+
+test_expect_success 'stdin -z fails on only whitespace' '
+	printf $F " " >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: whitespace before command:  " err
+'
+
+test_expect_success 'stdin -z fails on leading whitespace' '
+	printf $F " create $a" "$m" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: whitespace before command:  create $a" err
+'
+
+test_expect_success 'stdin -z fails on unknown command' '
+	printf $F "unknown $a" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: unknown command: unknown $a" err
+'
+
+test_expect_success 'stdin -z fails create with no ref' '
+	printf $F "create " >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: create line missing <ref>" err
+'
+
+test_expect_success 'stdin -z fails create with bad ref name' '
+	printf $F "create ~a " "$m" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: invalid ref format: ~a " err
+'
+
+test_expect_success 'stdin -z fails create with no new value' '
+	printf $F "create $a" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: create $a missing <newvalue>" err
+'
+
+test_expect_success 'stdin -z fails create with too many arguments' '
+	printf $F "create $a" "$m" "$m" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: unknown command: $m" err
+'
+
+test_expect_success 'stdin -z fails update with no ref' '
+	printf $F "update " >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: update line missing <ref>" err
+'
+
+test_expect_success 'stdin -z fails update with bad ref name' '
+	printf $F "update ~a" "$m" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: invalid ref format: ~a" err
+'
+
+test_expect_success 'stdin -z fails update with no new value' '
+	printf $F "update $a" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: update $a missing <newvalue>" err
+'
+
+test_expect_success 'stdin -z fails update with no old value' '
+	printf $F "update $a" "$m" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: update $a missing \\[<oldvalue>\\] NUL" err
+'
+
+test_expect_success 'stdin -z fails update with too many arguments' '
+	printf $F "update $a" "$m" "$m" "$m" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: unknown command: $m" err
+'
+
+test_expect_success 'stdin -z fails delete with no ref' '
+	printf $F "delete " >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: delete line missing <ref>" err
+'
+
+test_expect_success 'stdin -z fails delete with bad ref name' '
+	printf $F "delete ~a" "$m" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: invalid ref format: ~a" err
+'
+
+test_expect_success 'stdin -z fails delete with no old value' '
+	printf $F "delete $a" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: delete $a missing \\[<oldvalue>\\] NUL" err
+'
+
+test_expect_success 'stdin -z fails delete with too many arguments' '
+	printf $F "delete $a" "$m" "$m" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: unknown command: $m" err
+'
+
+test_expect_success 'stdin -z fails verify with too many arguments' '
+	printf $F "verify $a" "$m" "$m" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: unknown command: $m" err
+'
+
+test_expect_success 'stdin -z fails verify with no old value' '
+	printf $F "verify $a" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: verify $a missing \\[<oldvalue>\\] NUL" err
+'
+
+test_expect_success 'stdin -z fails option with unknown name' '
+	printf $F "option unknown" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: option unknown: unknown" err
+'
+
+test_expect_success 'stdin -z fails with duplicate refs' '
+	printf $F "create $a" "$m" "create $b" "$m" "create $a" "$m" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: Multiple updates for ref '"'"'$a'"'"' not allowed." err
+'
+
+test_expect_success 'stdin -z create ref works' '
+	printf $F "create $a" "$m" >stdin &&
+	git update-ref -z --stdin <stdin &&
+	git rev-parse $m >expect &&
+	git rev-parse $a >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin -z update ref creates with zero old value' '
+	printf $F "update $b" "$m" "$Z" >stdin &&
+	git update-ref -z --stdin <stdin &&
+	git rev-parse $m >expect &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual &&
+	git update-ref -d $b
+'
+
+test_expect_success 'stdin -z update ref creates with empty old value' '
+	printf $F "update $b" "$m" "" >stdin &&
+	git update-ref -z --stdin <stdin &&
+	git rev-parse $m >expect &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin -z create ref works with path with space to blob' '
+	printf $F "create refs/blobs/pws" "$m:$pws" >stdin &&
+	git update-ref -z --stdin <stdin &&
+	git rev-parse "$m:$pws" >expect &&
+	git rev-parse refs/blobs/pws >actual &&
+	test_cmp expect actual &&
+	git update-ref -d refs/blobs/pws
+'
+
+test_expect_success 'stdin -z update ref fails with wrong old value' '
+	printf $F "update $c" "$m" "$m~1" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: Cannot lock the ref '"'"'$c'"'"'" err &&
+	test_must_fail git rev-parse --verify -q $c
+'
+
+test_expect_success 'stdin -z update ref fails with bad old value' '
+	printf $F "update $c" "$m" "does-not-exist" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: invalid old value for ref $c: does-not-exist" err &&
+	test_must_fail git rev-parse --verify -q $c
+'
+
+test_expect_success 'stdin -z create ref fails with bad new value' '
+	printf $F "create $c" "does-not-exist" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: invalid new value for ref $c: does-not-exist" err &&
+	test_must_fail git rev-parse --verify -q $c
+'
+
+test_expect_success 'stdin -z create ref fails with zero new value' '
+	printf $F "create $c" "" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: create $c given zero new value" err &&
+	test_must_fail git rev-parse --verify -q $c
+'
+
+test_expect_success 'stdin -z update ref works with right old value' '
+	printf $F "update $b" "$m~1" "$m" >stdin &&
+	git update-ref -z --stdin <stdin &&
+	git rev-parse $m~1 >expect &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin -z delete ref fails with wrong old value' '
+	printf $F "delete $a" "$m~1" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: Cannot lock the ref '"'"'$a'"'"'" err &&
+	git rev-parse $m >expect &&
+	git rev-parse $a >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin -z delete ref fails with zero old value' '
+	printf $F "delete $a" "$Z" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: delete $a given zero old value" err &&
+	git rev-parse $m >expect &&
+	git rev-parse $a >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin -z update symref works option no-deref' '
+	git symbolic-ref TESTSYMREF $b &&
+	printf $F "option no-deref" "update TESTSYMREF" "$a" "$b" >stdin &&
+	git update-ref -z --stdin <stdin &&
+	git rev-parse TESTSYMREF >expect &&
+	git rev-parse $a >actual &&
+	test_cmp expect actual &&
+	git rev-parse $m~1 >expect &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin -z delete symref works option no-deref' '
+	git symbolic-ref TESTSYMREF $b &&
+	printf $F "option no-deref" "delete TESTSYMREF" "$b" >stdin &&
+	git update-ref -z --stdin <stdin &&
+	test_must_fail git rev-parse --verify -q TESTSYMREF &&
+	git rev-parse $m~1 >expect &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin -z delete ref works with right old value' '
+	printf $F "delete $b" "$m~1" >stdin &&
+	git update-ref -z --stdin <stdin &&
+	test_must_fail git rev-parse --verify -q $b
+'
+
+test_expect_success 'stdin -z update/create/verify combination works' '
+	printf $F "update $a" "$m" "" "create $b" "$m" "verify $c" "" >stdin &&
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
+	printf $F "update $a" "$m" "$m" "update $b" "$m" "$m" "update $c" "$Z" "" >stdin &&
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
+	printf $F "update $a" "$m" "$m" "update $b" "$m" "$m" "update $c" "" "$Z" >stdin &&
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
+	printf $F "delete $a" "$m" "update $b" "$Z" "$m" "update $c" "" "$m~1" >stdin &&
+	git update-ref -z --stdin <stdin &&
+	test_must_fail git rev-parse --verify -q $a &&
+	test_must_fail git rev-parse --verify -q $b &&
+	test_must_fail git rev-parse --verify -q $c
+'
+
 test_done
-- 
1.8.4.rc3
