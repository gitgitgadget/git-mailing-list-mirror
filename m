From: Max Kirillov <max@max630.net>
Subject: [PATCH v2 2/2] git-merge-file: do not add LF at EOF while applying unrelated change
Date: Sun, 29 Jun 2014 01:04:46 +0300
Message-ID: <1403993086-15625-3-git-send-email-max@max630.net>
References: <1403993086-15625-1-git-send-email-max@max630.net>
Cc: git@vger.kernel.org, Max Kirillov <max@max630.net>
To: Bert Wesarg <bert.wesarg@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 29 00:13:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X10sN-0002ym-Eq
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jun 2014 00:13:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbaF1WNf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2014 18:13:35 -0400
Received: from p3plsmtpa06-07.prod.phx3.secureserver.net ([173.201.192.108]:38291
	"EHLO p3plsmtpa06-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750944AbaF1WNf (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Jun 2014 18:13:35 -0400
X-Greylist: delayed 473 seconds by postgrey-1.27 at vger.kernel.org; Sat, 28 Jun 2014 18:13:06 EDT
Received: from wheezy.local ([82.181.158.170])
	by p3plsmtpa06-07.prod.phx3.secureserver.net with 
	id Ky521o00K3gsSd601y5EdL; Sat, 28 Jun 2014 15:05:18 -0700
X-Mailer: git-send-email 2.0.0.526.g5318336
In-Reply-To: <1403993086-15625-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252622>

If 'current-file' does not contain LF at EOF, and change between
'base-file' and 'other-file' does not change any line close to EOF, the
3-way merge should not add LF to EOF.  This is what 'diff3 -m' does, and
seems to be a reasonable expectation.

The change which introduced the behavior is cd1d61c44f. It always calls
function xdl_recs_copy() for sides with add_nl == 1. In fact, it looks
like the only case when this is needed is when 2 files are being
union-merged, and they do not have LF at EOF (strictly speaking, the
first of them).

Add tests:
* "merge without conflict (missing LF at EOF, away from change in the
other file)" and "merge does not add LF away of change", to demonstrate
the changed behavior.
* "conflict at EOF without LF resolved by --union", to verify that the
union-merge at the end inerts newline between versions.
* some more tests which I felt like not covering the functionality well

Signed-off-by: Max Kirillov <max@max630.net>
---
 t/t6023-merge-file.sh | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++
 xdiff/xmerge.c        |  4 +--
 2 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
index 6da921c..59ae712 100755
--- a/t/t6023-merge-file.sh
+++ b/t/t6023-merge-file.sh
@@ -83,6 +83,23 @@ test_expect_failure "merge without conflict (missing LF at EOF)" \
 test_expect_failure "merge result added missing LF" \
 	"test_cmp test.txt test2.txt"
 
+cp new4.txt test3.txt
+test_expect_success "merge without conflict (missing LF at EOF, away from change in the other file)" \
+	"git merge-file --quiet test3.txt new2.txt new3.txt"
+
+cat > expect.txt << EOF
+DOMINUS regit me,
+et nihil mihi deerit.
+In loco pascuae ibi me collocavit,
+super aquam refectionis educavit me;
+animam meam convertit,
+deduxit me super semitas jusitiae,
+EOF
+printf "propter nomen suum." >> expect.txt
+
+test_expect_success "merge does not add LF away of change" \
+	"test_cmp test3.txt expect.txt"
+
 cp test.txt backup.txt
 test_expect_success "merge with conflicts" \
 	"test_must_fail git merge-file test.txt orig.txt new3.txt"
@@ -107,6 +124,55 @@ EOF
 test_expect_success "expected conflict markers" "test_cmp test.txt expect.txt"
 
 cp backup.txt test.txt
+
+cat > expect.txt << EOF
+Dominus regit me, et nihil mihi deerit.
+In loco pascuae ibi me collocavit,
+super aquam refectionis educavit me;
+animam meam convertit,
+deduxit me super semitas jusitiae,
+propter nomen suum.
+Nam et si ambulavero in medio umbrae mortis,
+non timebo mala, quoniam tu mecum es:
+virga tua et baculus tuus ipsa me consolata sunt.
+EOF
+test_expect_success "merge conflicting with --ours" \
+	"git merge-file --ours test.txt orig.txt new3.txt && test_cmp test.txt expect.txt"
+cp backup.txt test.txt
+
+cat > expect.txt << EOF
+DOMINUS regit me,
+et nihil mihi deerit.
+In loco pascuae ibi me collocavit,
+super aquam refectionis educavit me;
+animam meam convertit,
+deduxit me super semitas jusitiae,
+propter nomen suum.
+Nam et si ambulavero in medio umbrae mortis,
+non timebo mala, quoniam tu mecum es:
+virga tua et baculus tuus ipsa me consolata sunt.
+EOF
+test_expect_success "merge conflicting with --theirs" \
+	"git merge-file --theirs test.txt orig.txt new3.txt && test_cmp test.txt expect.txt"
+cp backup.txt test.txt
+
+cat > expect.txt << EOF
+Dominus regit me, et nihil mihi deerit.
+DOMINUS regit me,
+et nihil mihi deerit.
+In loco pascuae ibi me collocavit,
+super aquam refectionis educavit me;
+animam meam convertit,
+deduxit me super semitas jusitiae,
+propter nomen suum.
+Nam et si ambulavero in medio umbrae mortis,
+non timebo mala, quoniam tu mecum es:
+virga tua et baculus tuus ipsa me consolata sunt.
+EOF
+test_expect_success "merge conflicting with --union" \
+	"git merge-file --union test.txt orig.txt new3.txt && test_cmp test.txt expect.txt"
+cp backup.txt test.txt
+
 test_expect_success "merge with conflicts, using -L" \
 	"test_must_fail git merge-file -L 1 -L 2 test.txt orig.txt new3.txt"
 
@@ -260,4 +326,23 @@ test_expect_success 'marker size' '
 	test_cmp expect actual
 '
 
+printf "line1\nline2\nline3" >nolf-orig.txt
+printf "line1\nline2\nline3x" >nolf-diff1.txt
+printf "line1\nline2\nline3y" >nolf-diff2.txt
+
+test_expect_success 'conflict at EOF without LF resolved by --ours' \
+	'git merge-file -p --ours nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >output.txt &&
+	 printf "line1\nline2\nline3x" >expect.txt &&
+	 test_cmp expect.txt output.txt'
+
+test_expect_success 'conflict at EOF without LF resolved by --theirs' \
+	'git merge-file -p --theirs nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >output.txt &&
+	 printf "line1\nline2\nline3y" >expect.txt &&
+	 test_cmp expect.txt output.txt'
+
+test_expect_success 'conflict at EOF without LF resolved by --union' \
+	'git merge-file -p --union nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >output.txt &&
+	 printf "line1\nline2\nline3x\nline3y" >expect.txt &&
+	 test_cmp expect.txt output.txt'
+
 test_done
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 9e13b25..625198e 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -245,11 +245,11 @@ static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
 					      dest ? dest + size : NULL);
 			/* Postimage from side #1 */
 			if (m->mode & 1)
-				size += xdl_recs_copy(xe1, m->i1, m->chg1, 1,
+				size += xdl_recs_copy(xe1, m->i1, m->chg1, (m->mode & 2),
 						      dest ? dest + size : NULL);
 			/* Postimage from side #2 */
 			if (m->mode & 2)
-				size += xdl_recs_copy(xe2, m->i2, m->chg2, 1,
+				size += xdl_recs_copy(xe2, m->i2, m->chg2, 0,
 						      dest ? dest + size : NULL);
 		} else
 			continue;
-- 
2.0.0.526.g5318336
