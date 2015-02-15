From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/6] t4008: modernise style
Date: Sun, 15 Feb 2015 15:43:44 -0800
Message-ID: <1424043824-25242-7-git-send-email-gitster@pobox.com>
References: <1424043824-25242-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 16 00:44:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YN8rG-0006Kx-DH
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 00:44:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755137AbbBOXoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2015 18:44:07 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54162 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755076AbbBOXoC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2015 18:44:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5627E39CFE;
	Sun, 15 Feb 2015 18:44:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=JZSD
	nUQJSeDJl9FNSLMT2+SbM5M=; b=ApwEw+zPNZBfJIeUZG40beZ+drMBNR8fWzqD
	6KByd6kwAvUA/VibrtCr1nGgj2qeh5L1WyB1S5XMp9zKR4BiUT5ZS6plVahzImpz
	8SOO3RLcvA+I3UX8PN1N5CkvjC1nmKLhWoaNKxsRLKK7NLYqlMbo55XZY/xj1IrJ
	IzP0uC4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=byeji+
	KwA253eLLoYpza1rU0rm3JFLKfi/fFke0pg57sEDK74UCLlZJDMOEgNreNLVaKx5
	YHXcJkWAHtrIDqAnjNM4EwTJ6FFB65Ghl8kUJxTFLhss4FlxN6WVtszueDX8tZYq
	NmsHTnLV0o5KIfjnAxrQx4pa4204RQDbn1hRw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4DADD39CFD;
	Sun, 15 Feb 2015 18:44:02 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B9A7739CF2;
	Sun, 15 Feb 2015 18:43:55 -0500 (EST)
X-Mailer: git-send-email 2.3.0-266-g5b48884
In-Reply-To: <1424043824-25242-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 8142FCDC-B56C-11E4-9248-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263861>

Update this ancient test script to a more modern style in which the
expected result is prepared inside the body of the test that uses
it.  Also, instead of using $tree, a shell variable, throughout the
test script, create a tag that points at it, to make it easier to
manually debug the test script in its trash directory.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4008-diff-break-rewrite.sh | 286 +++++++++++++++++++-----------------------
 1 file changed, 126 insertions(+), 160 deletions(-)

diff --git a/t/t4008-diff-break-rewrite.sh b/t/t4008-diff-break-rewrite.sh
index 718274f..9dd1bc5 100755
--- a/t/t4008-diff-break-rewrite.sh
+++ b/t/t4008-diff-break-rewrite.sh
@@ -24,165 +24,131 @@ Further, with -B and -M together, these should turn into two renames.
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/diff-lib.sh ;# test-lib chdir's into trash
 
-test_expect_success \
-    setup \
-    'cat "$TEST_DIRECTORY"/diff-lib/README >file0 &&
-     cat "$TEST_DIRECTORY"/diff-lib/COPYING >file1 &&
-    git update-index --add file0 file1 &&
-    tree=$(git write-tree) &&
-    echo "$tree"'
-
-test_expect_success \
-    'change file1 with copy-edit of file0 and remove file0' \
-    'sed -e "s/git/GIT/" file0 >file1 &&
-     rm -f file0 &&
-    git update-index --remove file0 file1'
-
-test_expect_success \
-    'run diff with -B' \
-    'git diff-index -B --cached "$tree" >current'
-
-cat >expected <<\EOF
-:100644 000000 548142c327a6790ff8821d67c2ee1eff7a656b52 0000000000000000000000000000000000000000 D	file0
-:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 2fbedd0b5d4b8126e4750c3bee305e8ff79f80ec M100	file1
-EOF
-
-test_expect_success \
-    'validate result of -B (#1)' \
-    'compare_diff_raw expected current'
-
-test_expect_success \
-    'run diff with -B and -M' \
-    'git diff-index -B -M "$tree" >current'
-
-cat >expected <<\EOF
-:100644 100644 548142c327a6790ff8821d67c2ee1eff7a656b52 2fbedd0b5d4b8126e4750c3bee305e8ff79f80ec R100	file0	file1
-EOF
-
-test_expect_success \
-    'validate result of -B -M (#2)' \
-    'compare_diff_raw expected current'
-
-test_expect_success \
-    'swap file0 and file1' \
-    'rm -f file0 file1 &&
-     git read-tree -m $tree &&
-     git checkout-index -f -u -a &&
-     mv file0 tmp &&
-     mv file1 file0 &&
-     mv tmp file1 &&
-     git update-index file0 file1'
-
-test_expect_success \
-    'run diff with -B' \
-    'git diff-index -B "$tree" >current'
-
-cat >expected <<\EOF
-:100644 100644 548142c327a6790ff8821d67c2ee1eff7a656b52 6ff87c4664981e4397625791c8ea3bbb5f2279a3 M100	file0
-:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 548142c327a6790ff8821d67c2ee1eff7a656b52 M100	file1
-EOF
-
-test_expect_success \
-    'validate result of -B (#3)' \
-    'compare_diff_raw expected current'
-
-test_expect_success \
-    'run diff with -B and -M' \
-    'git diff-index -B -M "$tree" >current'
-
-cat >expected <<\EOF
-:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 6ff87c4664981e4397625791c8ea3bbb5f2279a3 R100	file1	file0
-:100644 100644 548142c327a6790ff8821d67c2ee1eff7a656b52 548142c327a6790ff8821d67c2ee1eff7a656b52 R100	file0	file1
-EOF
-
-test_expect_success \
-    'validate result of -B -M (#4)' \
-    'compare_diff_raw expected current'
-
-test_expect_success \
-    'make file0 into something completely different' \
-    'rm -f file0 &&
-     test_ln_s_add frotz file0 &&
-     git update-index file1'
-
-test_expect_success \
-    'run diff with -B' \
-    'git diff-index -B "$tree" >current'
-
-cat >expected <<\EOF
-:100644 120000 548142c327a6790ff8821d67c2ee1eff7a656b52 67be421f88824578857624f7b3dc75e99a8a1481 T	file0
-:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 548142c327a6790ff8821d67c2ee1eff7a656b52 M100	file1
-EOF
-
-test_expect_success \
-    'validate result of -B (#5)' \
-    'compare_diff_raw expected current'
-
-test_expect_success \
-    'run diff with -B -M' \
-    'git diff-index -B -M "$tree" >current'
-
-# file0 changed from regular to symlink.  file1 is very close to the preimage of file0.
-# the change does not make file0 disappear, so file1 is denoted as a copy of file0
-cat >expected <<\EOF
-:100644 120000 548142c327a6790ff8821d67c2ee1eff7a656b52 67be421f88824578857624f7b3dc75e99a8a1481 T	file0
-:100644 100644 548142c327a6790ff8821d67c2ee1eff7a656b52 548142c327a6790ff8821d67c2ee1eff7a656b52 C	file0	file1
-EOF
-
-test_expect_success \
-    'validate result of -B -M (#6)' \
-    'compare_diff_raw expected current'
-
-test_expect_success \
-    'run diff with -M' \
-    'git diff-index -M "$tree" >current'
-
-# This should not mistake file0 as the copy source of new file1
-# due to type differences.
-cat >expected <<\EOF
-:100644 120000 548142c327a6790ff8821d67c2ee1eff7a656b52 67be421f88824578857624f7b3dc75e99a8a1481 T	file0
-:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 548142c327a6790ff8821d67c2ee1eff7a656b52 M	file1
-EOF
-
-test_expect_success \
-    'validate result of -M (#7)' \
-    'compare_diff_raw expected current'
-
-test_expect_success \
-    'file1 edited to look like file0 and file0 rename-edited to file2' \
-    'rm -f file0 file1 &&
-     git read-tree -m $tree &&
-     git checkout-index -f -u -a &&
-     sed -e "s/git/GIT/" file0 >file1 &&
-     sed -e "s/git/GET/" file0 >file2 &&
-     rm -f file0 &&
-     git update-index --add --remove file0 file1 file2'
-
-test_expect_success \
-    'run diff with -B' \
-    'git diff-index -B "$tree" >current'
-
-cat >expected <<\EOF
-:100644 000000 548142c327a6790ff8821d67c2ee1eff7a656b52 0000000000000000000000000000000000000000 D	file0
-:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 2fbedd0b5d4b8126e4750c3bee305e8ff79f80ec M100	file1
-:000000 100644 0000000000000000000000000000000000000000 69a939f651686f56322566e2fd76715947a24162 A	file2
-EOF
-
-test_expect_success \
-    'validate result of -B (#8)' \
-    'compare_diff_raw expected current'
-
-test_expect_success \
-    'run diff with -B -C' \
-    'git diff-index -B -C "$tree" >current'
-
-cat >expected <<\EOF
-:100644 100644 548142c327a6790ff8821d67c2ee1eff7a656b52 2fbedd0b5d4b8126e4750c3bee305e8ff79f80ec C095	file0	file1
-:100644 100644 548142c327a6790ff8821d67c2ee1eff7a656b52 69a939f651686f56322566e2fd76715947a24162 R095	file0	file2
-EOF
-
-test_expect_success \
-    'validate result of -B -M (#9)' \
-    'compare_diff_raw expected current'
+test_expect_success setup '
+	cat "$TEST_DIRECTORY"/diff-lib/README >file0 &&
+	cat "$TEST_DIRECTORY"/diff-lib/COPYING >file1 &&
+	git update-index --add file0 file1 &&
+	git tag reference $(git write-tree)
+'
+
+test_expect_success 'change file1 with copy-edit of file0 and remove file0' '
+	sed -e "s/git/GIT/" file0 >file1 &&
+	rm -f file0 &&
+	git update-index --remove file0 file1
+'
+
+test_expect_success 'run diff with -B (#1)' '
+	git diff-index -B --cached reference >current &&
+	cat >expect <<-\EOF &&
+	:100644 000000 548142c327a6790ff8821d67c2ee1eff7a656b52 0000000000000000000000000000000000000000 D	file0
+	:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 2fbedd0b5d4b8126e4750c3bee305e8ff79f80ec M100	file1
+	EOF
+	compare_diff_raw expect current
+'
+
+test_expect_success 'run diff with -B and -M (#2)' '
+	git diff-index -B -M reference >current &&
+	cat >expect <<-\EOF &&
+	:100644 100644 548142c327a6790ff8821d67c2ee1eff7a656b52 2fbedd0b5d4b8126e4750c3bee305e8ff79f80ec R100	file0	file1
+	EOF
+	compare_diff_raw expect current
+'
+
+test_expect_success 'swap file0 and file1' '
+	rm -f file0 file1 &&
+	git read-tree -m reference &&
+	git checkout-index -f -u -a &&
+	mv file0 tmp &&
+	mv file1 file0 &&
+	mv tmp file1 &&
+	git update-index file0 file1
+'
+
+test_expect_success 'run diff with -B (#3)' '
+	git diff-index -B reference >current &&
+	cat >expect <<-\EOF &&
+	:100644 100644 548142c327a6790ff8821d67c2ee1eff7a656b52 6ff87c4664981e4397625791c8ea3bbb5f2279a3 M100	file0
+	:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 548142c327a6790ff8821d67c2ee1eff7a656b52 M100	file1
+	EOF
+	compare_diff_raw expect current
+'
+
+test_expect_success 'run diff with -B and -M (#4)' '
+	git diff-index -B -M reference >current &&
+	cat >expect <<-\EOF &&
+	:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 6ff87c4664981e4397625791c8ea3bbb5f2279a3 R100	file1	file0
+	:100644 100644 548142c327a6790ff8821d67c2ee1eff7a656b52 548142c327a6790ff8821d67c2ee1eff7a656b52 R100	file0	file1
+	EOF
+	compare_diff_raw expect current
+'
+
+test_expect_success 'make file0 into something completely different' '
+	rm -f file0 &&
+	test_ln_s_add frotz file0 &&
+	git update-index file1
+'
+
+test_expect_success 'run diff with -B (#5)' '
+	git diff-index -B reference >current &&
+	cat >expect <<-\EOF &&
+	:100644 120000 548142c327a6790ff8821d67c2ee1eff7a656b52 67be421f88824578857624f7b3dc75e99a8a1481 T	file0
+	:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 548142c327a6790ff8821d67c2ee1eff7a656b52 M100	file1
+	EOF
+	compare_diff_raw expect current
+'
+
+test_expect_success 'run diff with -B -M (#6)' '
+	git diff-index -B -M reference >current &&
+
+	# file0 changed from regular to symlink.  file1 is the same as the preimage
+	# of file0.  Because the change does not make file0 disappear, file1 is
+	# denoted as a copy of file0
+	cat >expect <<-\EOF &&
+	:100644 120000 548142c327a6790ff8821d67c2ee1eff7a656b52 67be421f88824578857624f7b3dc75e99a8a1481 T	file0
+	:100644 100644 548142c327a6790ff8821d67c2ee1eff7a656b52 548142c327a6790ff8821d67c2ee1eff7a656b52 C	file0	file1
+	EOF
+	compare_diff_raw expect current
+'
+
+test_expect_success 'run diff with -M (#7)' '
+	git diff-index -M reference >current &&
+
+	# This should not mistake file0 as the copy source of new file1
+	# due to type differences.
+	cat >expect <<-\EOF &&
+	:100644 120000 548142c327a6790ff8821d67c2ee1eff7a656b52 67be421f88824578857624f7b3dc75e99a8a1481 T	file0
+	:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 548142c327a6790ff8821d67c2ee1eff7a656b52 M	file1
+	EOF
+	compare_diff_raw expect current
+'
+
+test_expect_success 'file1 edited to look like file0 and file0 rename-edited to file2' '
+	rm -f file0 file1 &&
+	git read-tree -m reference &&
+	git checkout-index -f -u -a &&
+	sed -e "s/git/GIT/" file0 >file1 &&
+	sed -e "s/git/GET/" file0 >file2 &&
+	rm -f file0 &&
+	git update-index --add --remove file0 file1 file2
+'
+
+test_expect_success 'run diff with -B (#8)' '
+	git diff-index -B reference >current &&
+	cat >expect <<-\EOF &&
+	:100644 000000 548142c327a6790ff8821d67c2ee1eff7a656b52 0000000000000000000000000000000000000000 D	file0
+	:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 2fbedd0b5d4b8126e4750c3bee305e8ff79f80ec M100	file1
+	:000000 100644 0000000000000000000000000000000000000000 69a939f651686f56322566e2fd76715947a24162 A	file2
+	EOF
+	compare_diff_raw expect current
+'
+
+test_expect_success 'run diff with -B -C (#9)' '
+	git diff-index -B -C reference >current &&
+	cat >expect <<-\EOF &&
+	:100644 100644 548142c327a6790ff8821d67c2ee1eff7a656b52 2fbedd0b5d4b8126e4750c3bee305e8ff79f80ec C095	file0	file1
+	:100644 100644 548142c327a6790ff8821d67c2ee1eff7a656b52 69a939f651686f56322566e2fd76715947a24162 R095	file0	file2
+	EOF
+	compare_diff_raw expect current
+'
 
 test_done
-- 
2.3.0-266-g5b48884
