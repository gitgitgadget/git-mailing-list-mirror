From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH v2 05/11] notes: clean up t3301
Date: Wed, 17 Feb 2010 00:26:01 +0100
Message-ID: <2c7b0e51f7d299a481b62cbe4f728ff20e4651ab.1266361759.git.trast@student.ethz.ch>
References: <cover.1266361759.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>, Johan Herland <johan@herland.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 17 00:27:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhWp4-0006BI-TG
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 00:27:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933532Ab0BPX1B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 18:27:01 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:45469 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757044Ab0BPX0e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 18:26:34 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 17 Feb
 2010 00:26:26 +0100
Received: from localhost.localdomain (84.74.100.59) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 17 Feb
 2010 00:26:09 +0100
X-Mailer: git-send-email 1.7.0.67.g67ac3
In-Reply-To: <cover.1266361759.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140172>

The existing tests handrolled test_commit, so use that instead.

Unfortunately this changes all sha1's.  Since we're not supposed to
unneccessarily rely on them anyway, introduce a small helper that
filters out the commit headers before comparing, and remove them from
the expected outputs.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/t3301-notes.sh |  141 ++++++++++++++++++------------------------------------
 1 files changed, 46 insertions(+), 95 deletions(-)

diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 90178f9..3fec7ae 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -7,6 +7,15 @@ test_description='Test commit notes'
 
 . ./test-lib.sh
 
+strip_header () {
+	sed -i '/^\(commit\|tree\|parent\) /d' "$@"
+}
+
+strip_then_cmp () {
+	strip_header "$2"
+	test_cmp "$@"
+}
+
 cat > fake_editor.sh << \EOF
 echo "$MSG" > "$1"
 echo "$MSG" >& 2
@@ -20,14 +29,8 @@ test_expect_success 'cannot annotate non-existing HEAD' '
 '
 
 test_expect_success setup '
-	: > a1 &&
-	git add a1 &&
-	test_tick &&
-	git commit -m 1st &&
-	: > a2 &&
-	git add a2 &&
-	test_tick &&
-	git commit -m 2nd
+	test_commit 1st &&
+	test_commit 2nd
 '
 
 test_expect_success 'need valid notes ref' '
@@ -92,7 +95,6 @@ test_expect_success 'can overwrite existing note with "git notes add -f"' '
 '
 
 cat > expect << EOF
-commit 268048bfb8a1fb38e703baceb8ab235421bf80c5
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:14:13 2005 -0700
 
@@ -105,21 +107,17 @@ EOF
 test_expect_success 'show notes' '
 	! (git cat-file commit HEAD | grep b1) &&
 	git log -1 > output &&
-	test_cmp expect output
+	strip_then_cmp expect output
 '
 
 test_expect_success 'create multi-line notes (setup)' '
-	: > a3 &&
-	git add a3 &&
-	test_tick &&
-	git commit -m 3rd &&
+	test_commit 3rd &&
 	MSG="b3
 c3c3c3c3
 d3d3d3" git notes add
 '
 
 cat > expect-multiline << EOF
-commit 1584215f1d29c65e99c6c6848626553fdd07fd75
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:15:13 2005 -0700
 
@@ -136,19 +134,15 @@ cat expect >> expect-multiline
 
 test_expect_success 'show multi-line notes' '
 	git log -2 > output &&
-	test_cmp expect-multiline output
+	strip_then_cmp expect-multiline output
 '
 test_expect_success 'create -F notes (setup)' '
-	: > a4 &&
-	git add a4 &&
-	test_tick &&
-	git commit -m 4th &&
+	test_commit 4th &&
 	echo "xyzzy" > note5 &&
 	git notes add -F note5
 '
 
 cat > expect-F << EOF
-commit 15023535574ded8b1a89052b32673f84cf9582b8
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:16:13 2005 -0700
 
@@ -163,13 +157,10 @@ cat expect-multiline >> expect-F
 
 test_expect_success 'show -F notes' '
 	git log -3 > output &&
-	test_cmp expect-F output
+	strip_then_cmp expect-F output
 '
 
 cat >expect << EOF
-commit 15023535574ded8b1a89052b32673f84cf9582b8
-tree e070e3af51011e47b183c33adf9736736a525709
-parent 1584215f1d29c65e99c6c6848626553fdd07fd75
 author A U Thor <author@example.com> 1112912173 -0700
 committer C O Mitter <committer@example.com> 1112912173 -0700
 
@@ -177,7 +168,7 @@ committer C O Mitter <committer@example.com> 1112912173 -0700
 EOF
 test_expect_success 'git log --pretty=raw does not show notes' '
 	git log -1 --pretty=raw >output &&
-	test_cmp expect output
+	strip_then_cmp expect output
 '
 
 cat >>expect <<EOF
@@ -187,7 +178,7 @@ Notes:
 EOF
 test_expect_success 'git log --show-notes' '
 	git log -1 --pretty=raw --show-notes >output &&
-	test_cmp expect output
+	strip_then_cmp expect output
 '
 
 test_expect_success 'git log --no-notes' '
@@ -220,10 +211,7 @@ do
 done
 
 test_expect_success 'create -m notes (setup)' '
-	: > a5 &&
-	git add a5 &&
-	test_tick &&
-	git commit -m 5th &&
+	test_commit 5th &&
 	git notes add -m spam -m "foo
 bar
 baz"
@@ -231,7 +219,6 @@ baz"
 
 whitespace="    "
 cat > expect-m << EOF
-commit bd1753200303d0a0344be813e504253b3d98e74d
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:17:13 2005 -0700
 
@@ -250,7 +237,7 @@ cat expect-F >> expect-m
 
 test_expect_success 'show -m notes' '
 	git log -4 > output &&
-	test_cmp expect-m output
+	strip_then_cmp expect-m output
 '
 
 test_expect_success 'remove note with add -f -F /dev/null (setup)' '
@@ -258,7 +245,6 @@ test_expect_success 'remove note with add -f -F /dev/null (setup)' '
 '
 
 cat > expect-rm-F << EOF
-commit bd1753200303d0a0344be813e504253b3d98e74d
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:17:13 2005 -0700
 
@@ -270,7 +256,7 @@ cat expect-F >> expect-rm-F
 
 test_expect_success 'verify note removal with -F /dev/null' '
 	git log -4 > output &&
-	test_cmp expect-rm-F output &&
+	strip_then_cmp expect-rm-F output &&
 	! git notes show
 '
 
@@ -280,7 +266,7 @@ test_expect_success 'do not create empty note with -m "" (setup)' '
 
 test_expect_success 'verify non-creation of note with -m ""' '
 	git log -4 > output &&
-	test_cmp expect-rm-F output &&
+	strip_then_cmp expect-rm-F output &&
 	! git notes show
 '
 
@@ -301,7 +287,7 @@ test_expect_success 'create note with combination of -m and -F' '
 	echo "zyxxy" > note_b &&
 	git notes add -m "foo" -F note_a -m "bar" -F note_b -m "baz" &&
 	git notes show > output &&
-	test_cmp expect-combine_m_and_F output
+	strip_then_cmp expect-combine_m_and_F output
 '
 
 test_expect_success 'remove note with "git notes remove" (setup)' '
@@ -310,13 +296,11 @@ test_expect_success 'remove note with "git notes remove" (setup)' '
 '
 
 cat > expect-rm-remove << EOF
-commit bd1753200303d0a0344be813e504253b3d98e74d
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:17:13 2005 -0700
 
     5th
 
-commit 15023535574ded8b1a89052b32673f84cf9582b8
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:16:13 2005 -0700
 
@@ -328,13 +312,13 @@ cat expect-multiline >> expect-rm-remove
 
 test_expect_success 'verify note removal with "git notes remove"' '
 	git log -4 > output &&
-	test_cmp expect-rm-remove output &&
+	strip_then_cmp expect-rm-remove output &&
 	! git notes show HEAD^
 '
 
 cat > expect << EOF
-c18dc024e14f08d18d14eea0d747ff692d66d6a3 1584215f1d29c65e99c6c6848626553fdd07fd75
-c9c6af7f78bc47490dbf3e822cf2f3c24d4b9061 268048bfb8a1fb38e703baceb8ab235421bf80c5
+c9c6af7f78bc47490dbf3e822cf2f3c24d4b9061 7a4ca6ee52a974a66cbaa78e33214535dff1d691
+c18dc024e14f08d18d14eea0d747ff692d66d6a3 d07d62e5208f22eb5695e7eb47667dc8b9860290
 EOF
 
 test_expect_success 'list notes with "git notes list"' '
@@ -401,15 +385,11 @@ test_expect_success 'appending empty string to non-existing note does not create
 '
 
 test_expect_success 'create other note on a different notes ref (setup)' '
-	: > a6 &&
-	git add a6 &&
-	test_tick &&
-	git commit -m 6th &&
+	test_commit 6th &&
 	GIT_NOTES_REF="refs/notes/other" git notes add -m "other note"
 '
 
 cat > expect-other << EOF
-commit 387a89921c73d7ed72cd94d179c1c7048ca47756
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:18:13 2005 -0700
 
@@ -420,7 +400,6 @@ Notes:
 EOF
 
 cat > expect-not-other << EOF
-commit 387a89921c73d7ed72cd94d179c1c7048ca47756
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:18:13 2005 -0700
 
@@ -429,23 +408,23 @@ EOF
 
 test_expect_success 'Do not show note on other ref by default' '
 	git log -1 > output &&
-	test_cmp expect-not-other output
+	strip_then_cmp expect-not-other output
 '
 
 test_expect_success 'Do show note when ref is given in GIT_NOTES_REF' '
 	GIT_NOTES_REF="refs/notes/other" git log -1 > output &&
-	test_cmp expect-other output
+	strip_then_cmp expect-other output
 '
 
 test_expect_success 'Do show note when ref is given in core.notesRef config' '
 	git config core.notesRef "refs/notes/other" &&
 	git log -1 > output &&
-	test_cmp expect-other output
+	strip_then_cmp expect-other output
 '
 
 test_expect_success 'Do not show note when core.notesRef is overridden' '
 	GIT_NOTES_REF="refs/notes/wrong" git log -1 > output &&
-	test_cmp expect-not-other output
+	strip_then_cmp expect-not-other output
 '
 
 test_expect_success 'Allow notes on non-commits (trees, blobs, tags)' '
@@ -466,7 +445,6 @@ test_expect_success 'Allow notes on non-commits (trees, blobs, tags)' '
 '
 
 cat > expect << EOF
-commit 2ede89468182a62d0bde2583c736089bcf7d7e92
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:19:13 2005 -0700
 
@@ -477,27 +455,20 @@ Notes:
 EOF
 
 test_expect_success 'create note from other note with "git notes add -C"' '
-	: > a7 &&
-	git add a7 &&
-	test_tick &&
-	git commit -m 7th &&
+	test_commit 7th &&
 	git notes add -C $(git notes list HEAD^) &&
 	git log -1 > actual &&
-	test_cmp expect actual &&
+	strip_then_cmp expect actual &&
 	test "$(git notes list HEAD)" = "$(git notes list HEAD^)"
 '
 
 test_expect_success 'create note from non-existing note with "git notes add -C" fails' '
-	: > a8 &&
-	git add a8 &&
-	test_tick &&
-	git commit -m 8th &&
+	test_commit 8th &&
 	test_must_fail git notes add -C deadbeef &&
 	test_must_fail git notes list HEAD
 '
 
 cat > expect << EOF
-commit 016e982bad97eacdbda0fcbd7ce5b0ba87c81f1b
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:21:13 2005 -0700
 
@@ -508,26 +479,19 @@ Notes:
 EOF
 
 test_expect_success 'create note from other note with "git notes add -c"' '
-	: > a9 &&
-	git add a9 &&
-	test_tick &&
-	git commit -m 9th &&
+	test_commit 9th &&
 	MSG="yet another note" git notes add -c $(git notes list HEAD^^) &&
 	git log -1 > actual &&
-	test_cmp expect actual
+	strip_then_cmp expect actual
 '
 
 test_expect_success 'create note from non-existing note with "git notes add -c" fails' '
-	: > a10 &&
-	git add a10 &&
-	test_tick &&
-	git commit -m 10th &&
+	test_commit 10th &&
 	test_must_fail MSG="yet another note" git notes add -c deadbeef &&
 	test_must_fail git notes list HEAD
 '
 
 cat > expect << EOF
-commit 016e982bad97eacdbda0fcbd7ce5b0ba87c81f1b
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:21:13 2005 -0700
 
@@ -542,11 +506,10 @@ EOF
 test_expect_success 'append to note from other note with "git notes append -C"' '
 	git notes append -C $(git notes list HEAD^) HEAD^ &&
 	git log -1 HEAD^ > actual &&
-	test_cmp expect actual
+	strip_then_cmp expect actual
 '
 
 cat > expect << EOF
-commit ffed603236bfa3891c49644257a83598afe8ae5a
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:22:13 2005 -0700
 
@@ -559,11 +522,10 @@ EOF
 test_expect_success 'create note from other note with "git notes append -c"' '
 	MSG="other note" git notes append -c $(git notes list HEAD^) &&
 	git log -1 > actual &&
-	test_cmp expect actual
+	strip_then_cmp expect actual
 '
 
 cat > expect << EOF
-commit ffed603236bfa3891c49644257a83598afe8ae5a
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:22:13 2005 -0700
 
@@ -578,11 +540,10 @@ EOF
 test_expect_success 'append to note from other note with "git notes append -c"' '
 	MSG="yet another note" git notes append -c $(git notes list HEAD) &&
 	git log -1 > actual &&
-	test_cmp expect actual
+	strip_then_cmp expect actual
 '
 
 cat > expect << EOF
-commit 6352c5e33dbcab725fe0579be16aa2ba8eb369be
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:23:13 2005 -0700
 
@@ -595,25 +556,21 @@ $whitespace
 EOF
 
 test_expect_success 'copy note with "git notes copy"' '
-	: > a11 &&
-	git add a11 &&
-	test_tick &&
-	git commit -m 11th &&
+	test_commit 11th &&
 	git notes copy HEAD^ HEAD &&
 	git log -1 > actual &&
-	test_cmp expect actual &&
+	strip_then_cmp expect actual &&
 	test "$(git notes list HEAD)" = "$(git notes list HEAD^)"
 '
 
 test_expect_success 'prevent overwrite with "git notes copy"' '
 	test_must_fail git notes copy HEAD~2 HEAD &&
 	git log -1 > actual &&
-	test_cmp expect actual &&
+	strip_then_cmp expect actual &&
 	test "$(git notes list HEAD)" = "$(git notes list HEAD^)"
 '
 
 cat > expect << EOF
-commit 6352c5e33dbcab725fe0579be16aa2ba8eb369be
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:23:13 2005 -0700
 
@@ -628,19 +585,13 @@ EOF
 test_expect_success 'allow overwrite with "git notes copy -f"' '
 	git notes copy -f HEAD~2 HEAD &&
 	git log -1 > actual &&
-	test_cmp expect actual &&
+	strip_then_cmp expect actual &&
 	test "$(git notes list HEAD)" = "$(git notes list HEAD~2)"
 '
 
 test_expect_success 'cannot copy note from object without notes' '
-	: > a12 &&
-	git add a12 &&
-	test_tick &&
-	git commit -m 12th &&
-	: > a13 &&
-	git add a13 &&
-	test_tick &&
-	git commit -m 13th &&
+	test_commit 12th &&
+	test_commit 13th &&
 	test_must_fail git notes copy HEAD^ HEAD
 '
 
-- 
1.7.0.53.g5c2e6.dirty
