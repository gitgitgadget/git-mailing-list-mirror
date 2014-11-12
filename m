From: Johan Herland <johan@herland.net>
Subject: [PATCHv5 9/9] t3301: Modernize
Date: Wed, 12 Nov 2014 01:40:16 +0100
Message-ID: <1415752816-22782-10-git-send-email-johan@herland.net>
References: <1415752816-22782-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, mackyle@gmail.com, jhf@trifork.com,
	sunshine@sunshineco.com, peff@peff.net, blume.mike@gmail.com,
	Johan Herland <johan@herland.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 12 01:40:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoLzV-0005vi-7Y
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 01:40:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752506AbaKLAkw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2014 19:40:52 -0500
Received: from mail-la0-f51.google.com ([209.85.215.51]:39584 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752684AbaKLAkr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2014 19:40:47 -0500
Received: by mail-la0-f51.google.com with SMTP id q1so10415189lam.24
        for <git@vger.kernel.org>; Tue, 11 Nov 2014 16:40:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rA9qJLa7O6XKdmHyrVQz7yggxTr4MPGFG2ljEaiNIxM=;
        b=X1PfPf+OmL6zKQ4yMi0d9RrtIZF4wywPbYzCH383nFQJyxg0wh4E4/Oon0K7fxZP46
         KWN+BsD1ozaQbgKS1vGW+FvPkydE1IpJlawp+k8tvWUdFIu6dgngRzgDPPBU3+6e2ZiS
         VbghsVVkC6NgLtRAvcXE2OUY/CQTVehRGbMt74lng2LMGxubBgaK9iFoJGUBZoySEnsa
         k6qc7/ab8d85dk/IX/DwM0lZ7JHVeGQOEP/ZMPoCLwdXcuv5S+h/RBjQTpHbxGXwRNDf
         lC80VSeJenElul75Byg2zZhXdjj5PIBUuacNJnbQrxmgnJmdu/5qie6Q6spFCqInCjnt
         /PKg==
X-Received: by 10.152.2.74 with SMTP id 10mr39143526las.22.1415752845579;
        Tue, 11 Nov 2014 16:40:45 -0800 (PST)
Received: from alpha.herland (245.37-191-128.fiber.lynet.no. [37.191.128.245])
        by mx.google.com with ESMTPSA id 8sm6341174lav.15.2014.11.11.16.40.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Nov 2014 16:40:44 -0800 (PST)
X-Mailer: git-send-email 2.0.0.rc4.501.gdaf83ca
In-Reply-To: <1415752816-22782-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make this test script appear somewhat less old-fashioned:
 - Use test helper functions:
    - write_script
    - test_commit
    - test_write_lines
    - test_line_count
    - test_config
    - test_unconfig
    - test_path_is_missing
 - Remove whitespace between redirection operators and their targets.
 - Move preparation of "expect" files into tests.
 - Rename "output" files to "actual".
 - More consistent quoting, especially around commands that might
   expand to nothing.
 - More visibility of important whitespace with ${indent}.
 - Combine pairs of tests that unnecessarily split setup and verification.

Improved-by: Eric Sunshine <sunshine@sunshineco.com>
Improved-by: Junio C Hamano <gitster@pobox.com>
Improved-by: Michael Blume <blume.mike@gmail.com>
Improved-by: Jeff King <peff@peff.net>
Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t3301-notes.sh | 1300 +++++++++++++++++++++++++-----------------------------
 1 file changed, 601 insertions(+), 699 deletions(-)

diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 416ed9e..861c159 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -7,28 +7,22 @@ test_description='Test commit notes'
 
 . ./test-lib.sh
 
-cat > fake_editor.sh << \EOF
-#!/bin/sh
-echo "$MSG" > "$1"
-echo "$MSG" >& 2
+write_script fake_editor <<\EOF
+echo "$MSG" >"$1"
+echo "$MSG" >&2
 EOF
-chmod a+x fake_editor.sh
-GIT_EDITOR=./fake_editor.sh
+GIT_EDITOR=./fake_editor
 export GIT_EDITOR
 
+indent="    "
+
 test_expect_success 'cannot annotate non-existing HEAD' '
 	test_must_fail env MSG=3 git notes add
 '
 
-test_expect_success setup '
-	: > a1 &&
-	git add a1 &&
-	test_tick &&
-	git commit -m 1st &&
-	: > a2 &&
-	git add a2 &&
-	test_tick &&
-	git commit -m 2nd
+test_expect_success 'setup' '
+	test_commit 1st &&
+	test_commit 2nd
 '
 
 test_expect_success 'need valid notes ref' '
@@ -50,206 +44,186 @@ test_expect_success 'handle empty notes gracefully' '
 '
 
 test_expect_success 'show non-existent notes entry with %N' '
-	for l in A B
-	do
-		echo "$l"
-	done >expect &&
-	git show -s --format='A%n%NB' >output &&
-	test_cmp expect output
+	test_write_lines A B >expect &&
+	git show -s --format="A%n%NB" >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'create notes' '
-	git config core.notesRef refs/notes/commits &&
 	MSG=b4 git notes add &&
-	test ! -f .git/NOTES_EDITMSG &&
-	test 1 = $(git ls-tree refs/notes/commits | wc -l) &&
-	test b4 = $(git notes show) &&
+	test_path_is_missing .git/NOTES_EDITMSG &&
+	git ls-tree -r refs/notes/commits >actual &&
+	test_line_count = 1 actual
+	test "b4" = "$(git notes show)" &&
 	git show HEAD^ &&
 	test_must_fail git notes show HEAD^
 '
 
 test_expect_success 'show notes entry with %N' '
-	for l in A b4 B
-	do
-		echo "$l"
-	done >expect &&
-	git show -s --format='A%n%NB' >output &&
-	test_cmp expect output
+	test_write_lines A b4 B >expect &&
+	git show -s --format="A%n%NB" >actual &&
+	test_cmp expect actual
 '
 
-cat >expect <<EOF
-d423f8c refs/notes/commits@{0}: notes: Notes added by 'git notes add'
-EOF
-
 test_expect_success 'create reflog entry' '
-	git reflog show refs/notes/commits >output &&
-	test_cmp expect output
+	cat <<-EOF >expect &&
+		a1d8fa6 refs/notes/commits@{0}: notes: Notes added by '"'"'git notes add'"'"'
+	EOF
+	git reflog show refs/notes/commits >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'edit existing notes' '
 	MSG=b3 git notes edit &&
-	test ! -f .git/NOTES_EDITMSG &&
-	test 1 = $(git ls-tree refs/notes/commits | wc -l) &&
-	test b3 = $(git notes show) &&
+	test_path_is_missing .git/NOTES_EDITMSG &&
+	git ls-tree -r refs/notes/commits >actual &&
+	test_line_count = 1 actual
+	test "b3" = "$(git notes show)" &&
 	git show HEAD^ &&
 	test_must_fail git notes show HEAD^
 '
 
 test_expect_success 'cannot "git notes add -m" where notes already exists' '
 	test_must_fail git notes add -m "b2" &&
-	test ! -f .git/NOTES_EDITMSG &&
-	test 1 = $(git ls-tree refs/notes/commits | wc -l) &&
-	test b3 = $(git notes show) &&
+	test_path_is_missing .git/NOTES_EDITMSG &&
+	git ls-tree -r refs/notes/commits >actual &&
+	test_line_count = 1 actual
+	test "b3" = "$(git notes show)" &&
 	git show HEAD^ &&
 	test_must_fail git notes show HEAD^
 '
 
 test_expect_success 'can overwrite existing note with "git notes add -f -m"' '
 	git notes add -f -m "b1" &&
-	test ! -f .git/NOTES_EDITMSG &&
-	test 1 = $(git ls-tree refs/notes/commits | wc -l) &&
-	test b1 = $(git notes show) &&
+	test_path_is_missing .git/NOTES_EDITMSG &&
+	git ls-tree -r refs/notes/commits >actual &&
+	test_line_count = 1 actual
+	test "b1" = "$(git notes show)" &&
 	git show HEAD^ &&
 	test_must_fail git notes show HEAD^
 '
 
 test_expect_success 'add w/no options on existing note morphs into edit' '
 	MSG=b2 git notes add &&
-	test ! -f .git/NOTES_EDITMSG &&
-	test 1 = $(git ls-tree refs/notes/commits | wc -l) &&
-	test b2 = $(git notes show) &&
+	test_path_is_missing .git/NOTES_EDITMSG &&
+	git ls-tree -r refs/notes/commits >actual &&
+	test_line_count = 1 actual
+	test "b2" = "$(git notes show)" &&
 	git show HEAD^ &&
 	test_must_fail git notes show HEAD^
 '
 
 test_expect_success 'can overwrite existing note with "git notes add -f"' '
 	MSG=b1 git notes add -f &&
-	test ! -f .git/NOTES_EDITMSG &&
-	test 1 = $(git ls-tree refs/notes/commits | wc -l) &&
-	test b1 = $(git notes show) &&
+	test_path_is_missing .git/NOTES_EDITMSG &&
+	git ls-tree -r refs/notes/commits >actual &&
+	test_line_count = 1 actual
+	test "b1" = "$(git notes show)" &&
 	git show HEAD^ &&
 	test_must_fail git notes show HEAD^
 '
 
-cat > expect << EOF
-commit 268048bfb8a1fb38e703baceb8ab235421bf80c5
-Author: A U Thor <author@example.com>
-Date:   Thu Apr 7 15:14:13 2005 -0700
-
-    2nd
+test_expect_success 'show notes' '
+	cat >expect <<-EOF &&
+		commit 7a4ca6ee52a974a66cbaa78e33214535dff1d691
+		Author: A U Thor <author@example.com>
+		Date:   Thu Apr 7 15:14:13 2005 -0700
 
-Notes:
-    b1
-EOF
+		${indent}2nd
 
-test_expect_success 'show notes' '
+		Notes:
+		${indent}b1
+	EOF
 	! (git cat-file commit HEAD | grep b1) &&
-	git log -1 > output &&
-	test_cmp expect output
-'
-
-test_expect_success 'create multi-line notes (setup)' '
-	: > a3 &&
-	git add a3 &&
-	test_tick &&
-	git commit -m 3rd &&
-	MSG="b3
-c3c3c3c3
-d3d3d3" git notes add
+	git log -1 >actual &&
+	test_cmp expect actual
 '
 
-cat > expect-multiline << EOF
-commit 1584215f1d29c65e99c6c6848626553fdd07fd75
-Author: A U Thor <author@example.com>
-Date:   Thu Apr 7 15:15:13 2005 -0700
-
-    3rd
+test_expect_success 'show multi-line notes' '
+	test_commit 3rd &&
+	MSG="b3${LF}c3c3c3c3${LF}d3d3d3" git notes add &&
+	cat >expect-multiline <<-EOF &&
+		commit d07d62e5208f22eb5695e7eb47667dc8b9860290
+		Author: A U Thor <author@example.com>
+		Date:   Thu Apr 7 15:15:13 2005 -0700
 
-Notes:
-    b3
-    c3c3c3c3
-    d3d3d3
-EOF
+		${indent}3rd
 
-printf "\n" >> expect-multiline
-cat expect >> expect-multiline
+		Notes:
+		${indent}b3
+		${indent}c3c3c3c3
+		${indent}d3d3d3
 
-test_expect_success 'show multi-line notes' '
-	git log -2 > output &&
-	test_cmp expect-multiline output
+	EOF
+	cat expect >>expect-multiline &&
+	git log -2 >actual &&
+	test_cmp expect-multiline actual
 '
-test_expect_success 'create -F notes (setup)' '
-	: > a4 &&
-	git add a4 &&
-	test_tick &&
-	git commit -m 4th &&
-	echo "xyzzy" > note5 &&
-	git notes add -F note5
-'
-
-cat > expect-F << EOF
-commit 15023535574ded8b1a89052b32673f84cf9582b8
-Author: A U Thor <author@example.com>
-Date:   Thu Apr 7 15:16:13 2005 -0700
 
-    4th
+test_expect_success 'show -F notes' '
+	test_commit 4th &&
+	echo "xyzzy" >note5 &&
+	git notes add -F note5 &&
+	cat >expect-F <<-EOF &&
+		commit 0f7aa3ec6325aeb88b910453bb3eb37c49d75c11
+		Author: A U Thor <author@example.com>
+		Date:   Thu Apr 7 15:16:13 2005 -0700
 
-Notes:
-    xyzzy
-EOF
+		${indent}4th
 
-printf "\n" >> expect-F
-cat expect-multiline >> expect-F
+		Notes:
+		${indent}xyzzy
 
-test_expect_success 'show -F notes' '
-	git log -3 > output &&
-	test_cmp expect-F output
+	EOF
+	cat expect-multiline >>expect-F &&
+	git log -3 >actual &&
+	test_cmp expect-F actual
 '
 
 test_expect_success 'Re-adding -F notes without -f fails' '
-	echo "zyxxy" > note5 &&
+	echo "zyxxy" >note5 &&
 	test_must_fail git notes add -F note5 &&
-	git log -3 > output &&
-	test_cmp expect-F output
+	git log -3 >actual &&
+	test_cmp expect-F actual
 '
 
-cat >expect << EOF
-commit 15023535574ded8b1a89052b32673f84cf9582b8
-tree e070e3af51011e47b183c33adf9736736a525709
-parent 1584215f1d29c65e99c6c6848626553fdd07fd75
-author A U Thor <author@example.com> 1112912173 -0700
-committer C O Mitter <committer@example.com> 1112912173 -0700
-
-    4th
-EOF
 test_expect_success 'git log --pretty=raw does not show notes' '
-	git log -1 --pretty=raw >output &&
-	test_cmp expect output
+	cat >expect <<-EOF &&
+		commit 0f7aa3ec6325aeb88b910453bb3eb37c49d75c11
+		tree 05ac65288c4c4b3b709a020ae94b2ece2f2201ae
+		parent d07d62e5208f22eb5695e7eb47667dc8b9860290
+		author A U Thor <author@example.com> 1112912173 -0700
+		committer C O Mitter <committer@example.com> 1112912173 -0700
+
+		${indent}4th
+	EOF
+	git log -1 --pretty=raw >actual &&
+	test_cmp expect actual
 '
 
-cat >>expect <<EOF
-
-Notes:
-    xyzzy
-EOF
 test_expect_success 'git log --show-notes' '
-	git log -1 --pretty=raw --show-notes >output &&
-	test_cmp expect output
+	cat >>expect <<-EOF &&
+
+	Notes:
+	${indent}xyzzy
+	EOF
+	git log -1 --pretty=raw --show-notes >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'git log --no-notes' '
-	git log -1 --no-notes >output &&
-	! grep xyzzy output
+	git log -1 --no-notes >actual &&
+	! grep xyzzy actual
 '
 
 test_expect_success 'git format-patch does not show notes' '
-	git format-patch -1 --stdout >output &&
-	! grep xyzzy output
+	git format-patch -1 --stdout >actual &&
+	! grep xyzzy actual
 '
 
 test_expect_success 'git format-patch --show-notes does show notes' '
-	git format-patch --show-notes -1 --stdout >output &&
-	grep xyzzy output
+	git format-patch --show-notes -1 --stdout >actual &&
+	grep xyzzy actual
 '
 
 for pretty in \
@@ -261,8 +235,8 @@ do
 	?*) p="$pretty" not=" not" negate="!" ;;
 	esac
 	test_expect_success "git show $pretty does$not show notes" '
-		git show $p >output &&
-		eval "$negate grep xyzzy output"
+		git show $p >actual &&
+		eval "$negate grep xyzzy actual"
 	'
 done
 
@@ -271,161 +245,131 @@ test_expect_success 'setup alternate notes ref' '
 '
 
 test_expect_success 'git log --notes shows default notes' '
-	git log -1 --notes >output &&
-	grep xyzzy output &&
-	! grep alternate output
+	git log -1 --notes >actual &&
+	grep xyzzy actual &&
+	! grep alternate actual
 '
 
 test_expect_success 'git log --notes=X shows only X' '
-	git log -1 --notes=alternate >output &&
-	! grep xyzzy output &&
-	grep alternate output
+	git log -1 --notes=alternate >actual &&
+	! grep xyzzy actual &&
+	grep alternate actual
 '
 
 test_expect_success 'git log --notes --notes=X shows both' '
-	git log -1 --notes --notes=alternate >output &&
-	grep xyzzy output &&
-	grep alternate output
+	git log -1 --notes --notes=alternate >actual &&
+	grep xyzzy actual &&
+	grep alternate actual
 '
 
 test_expect_success 'git log --no-notes resets default state' '
 	git log -1 --notes --notes=alternate \
 		--no-notes --notes=alternate \
-		>output &&
-	! grep xyzzy output &&
-	grep alternate output
+		>actual &&
+	! grep xyzzy actual &&
+	grep alternate actual
 '
 
 test_expect_success 'git log --no-notes resets ref list' '
 	git log -1 --notes --notes=alternate \
 		--no-notes --notes \
-		>output &&
-	grep xyzzy output &&
-	! grep alternate output
-'
-
-test_expect_success 'create -m notes (setup)' '
-	: > a5 &&
-	git add a5 &&
-	test_tick &&
-	git commit -m 5th &&
-	git notes add -m spam -m "foo
-bar
-baz"
-'
-
-whitespace="    "
-cat > expect-m << EOF
-commit bd1753200303d0a0344be813e504253b3d98e74d
-Author: A U Thor <author@example.com>
-Date:   Thu Apr 7 15:17:13 2005 -0700
-
-    5th
-
-Notes:
-    spam
-$whitespace
-    foo
-    bar
-    baz
-EOF
-
-printf "\n" >> expect-m
-cat expect-F >> expect-m
-
-test_expect_success 'show -m notes' '
-	git log -4 > output &&
-	test_cmp expect-m output
+		>actual &&
+	grep xyzzy actual &&
+	! grep alternate actual
 '
 
-test_expect_success 'remove note with add -f -F /dev/null (setup)' '
-	git notes add -f -F /dev/null
-'
-
-cat > expect-rm-F << EOF
-commit bd1753200303d0a0344be813e504253b3d98e74d
-Author: A U Thor <author@example.com>
-Date:   Thu Apr 7 15:17:13 2005 -0700
-
-    5th
-EOF
-
-printf "\n" >> expect-rm-F
-cat expect-F >> expect-rm-F
-
-test_expect_success 'verify note removal with -F /dev/null' '
-	git log -4 > output &&
-	test_cmp expect-rm-F output &&
+test_expect_success 'show -m notes' '
+	test_commit 5th &&
+	git notes add -m spam -m "foo${LF}bar${LF}baz" &&
+	cat >expect-m <<-EOF &&
+		commit 7f9ad8836c775acb134c0a055fc55fb4cd1ba361
+		Author: A U Thor <author@example.com>
+		Date:   Thu Apr 7 15:17:13 2005 -0700
+
+		${indent}5th
+
+		Notes:
+		${indent}spam
+		${indent}
+		${indent}foo
+		${indent}bar
+		${indent}baz
+
+	EOF
+	cat expect-F >>expect-m &&
+	git log -4 >actual &&
+	test_cmp expect-m actual
+'
+
+test_expect_success 'remove note with add -f -F /dev/null' '
+	git notes add -f -F /dev/null &&
+	cat >expect-rm-F <<-EOF &&
+		commit 7f9ad8836c775acb134c0a055fc55fb4cd1ba361
+		Author: A U Thor <author@example.com>
+		Date:   Thu Apr 7 15:17:13 2005 -0700
+
+		${indent}5th
+
+	EOF
+	cat expect-F >>expect-rm-F &&
+	git log -4 >actual &&
+	test_cmp expect-rm-F actual &&
 	test_must_fail git notes show
 '
 
-test_expect_success 'do not create empty note with -m "" (setup)' '
-	git notes add -m ""
-'
-
-test_expect_success 'verify non-creation of note with -m ""' '
-	git log -4 > output &&
-	test_cmp expect-rm-F output &&
+test_expect_success 'do not create empty note with -m ""' '
+	git notes add -m "" &&
+	git log -4 >actual &&
+	test_cmp expect-rm-F actual &&
 	test_must_fail git notes show
 '
 
-cat > expect-combine_m_and_F << EOF
-foo
-
-xyzzy
+test_expect_success 'create note with combination of -m and -F' '
+	cat >expect-combine_m_and_F <<-EOF &&
+		foo
 
-bar
+		xyzzy
 
-zyxxy
+		bar
 
-baz
-EOF
+		zyxxy
 
-test_expect_success 'create note with combination of -m and -F' '
-	echo "xyzzy" > note_a &&
-	echo "zyxxy" > note_b &&
+		baz
+	EOF
+	echo "xyzzy" >note_a &&
+	echo "zyxxy" >note_b &&
 	git notes add -m "foo" -F note_a -m "bar" -F note_b -m "baz" &&
-	git notes show > output &&
-	test_cmp expect-combine_m_and_F output
+	git notes show >actual &&
+	test_cmp expect-combine_m_and_F actual
 '
 
-test_expect_success 'remove note with "git notes remove" (setup)' '
+test_expect_success 'remove note with "git notes remove"' '
 	git notes remove HEAD^ &&
-	git notes remove
-'
+	git notes remove &&
+	cat >expect-rm-remove <<-EOF &&
+		commit 7f9ad8836c775acb134c0a055fc55fb4cd1ba361
+		Author: A U Thor <author@example.com>
+		Date:   Thu Apr 7 15:17:13 2005 -0700
 
-cat > expect-rm-remove << EOF
-commit bd1753200303d0a0344be813e504253b3d98e74d
-Author: A U Thor <author@example.com>
-Date:   Thu Apr 7 15:17:13 2005 -0700
+		${indent}5th
 
-    5th
+		commit 0f7aa3ec6325aeb88b910453bb3eb37c49d75c11
+		Author: A U Thor <author@example.com>
+		Date:   Thu Apr 7 15:16:13 2005 -0700
 
-commit 15023535574ded8b1a89052b32673f84cf9582b8
-Author: A U Thor <author@example.com>
-Date:   Thu Apr 7 15:16:13 2005 -0700
+		${indent}4th
 
-    4th
-EOF
-
-printf "\n" >> expect-rm-remove
-cat expect-multiline >> expect-rm-remove
-
-test_expect_success 'verify note removal with "git notes remove"' '
-	git log -4 > output &&
-	test_cmp expect-rm-remove output &&
+	EOF
+	cat expect-multiline >>expect-rm-remove &&
+	git log -4 >actual &&
+	test_cmp expect-rm-remove actual &&
 	test_must_fail git notes show HEAD^
 '
 
-cat > expect << EOF
-c18dc024e14f08d18d14eea0d747ff692d66d6a3 1584215f1d29c65e99c6c6848626553fdd07fd75
-c9c6af7f78bc47490dbf3e822cf2f3c24d4b9061 268048bfb8a1fb38e703baceb8ab235421bf80c5
-EOF
-
 test_expect_success 'removing non-existing note should not create new commit' '
-	git rev-parse --verify refs/notes/commits > before_commit &&
+	git rev-parse --verify refs/notes/commits >before_commit &&
 	test_must_fail git notes remove HEAD^ &&
-	git rev-parse --verify refs/notes/commits > after_commit &&
+	git rev-parse --verify refs/notes/commits >after_commit &&
 	test_cmp before_commit after_commit
 '
 
@@ -505,70 +449,68 @@ test_expect_success 'removing with --stdin --ignore-missing' '
 '
 
 test_expect_success 'list notes with "git notes list"' '
-	git notes list > output &&
-	test_cmp expect output
+	cat >expect <<-EOF &&
+		c9c6af7f78bc47490dbf3e822cf2f3c24d4b9061 7a4ca6ee52a974a66cbaa78e33214535dff1d691
+		c18dc024e14f08d18d14eea0d747ff692d66d6a3 d07d62e5208f22eb5695e7eb47667dc8b9860290
+	EOF
+	git notes list >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'list notes with "git notes"' '
-	git notes > output &&
-	test_cmp expect output
+	git notes >actual &&
+	test_cmp expect actual
 '
 
-cat > expect << EOF
-c18dc024e14f08d18d14eea0d747ff692d66d6a3
-EOF
-
 test_expect_success 'list specific note with "git notes list <object>"' '
-	git notes list HEAD^^ > output &&
-	test_cmp expect output
+	cat >expect <<-EOF &&
+		c18dc024e14f08d18d14eea0d747ff692d66d6a3
+	EOF
+	git notes list HEAD^^ >actual &&
+	test_cmp expect actual
 '
 
-cat > expect << EOF
-EOF
-
 test_expect_success 'listing non-existing notes fails' '
-	test_must_fail git notes list HEAD > output &&
-	test_cmp expect output
+	cat >expect <<-EOF &&
+	EOF
+	test_must_fail git notes list HEAD >actual &&
+	test_cmp expect actual
 '
 
-cat > expect << EOF
-Initial set of notes
-
-More notes appended with git notes append
-EOF
-
 test_expect_success 'append to existing note with "git notes append"' '
+	cat >expect <<-EOF &&
+		Initial set of notes
+
+		More notes appended with git notes append
+	EOF
 	git notes add -m "Initial set of notes" &&
 	git notes append -m "More notes appended with git notes append" &&
-	git notes show > output &&
-	test_cmp expect output
+	git notes show >actual &&
+	test_cmp expect actual
 '
 
-cat > expect_list << EOF
-c18dc024e14f08d18d14eea0d747ff692d66d6a3 1584215f1d29c65e99c6c6848626553fdd07fd75
-c9c6af7f78bc47490dbf3e822cf2f3c24d4b9061 268048bfb8a1fb38e703baceb8ab235421bf80c5
-4b6ad22357cc8a1296720574b8d2fbc22fab0671 bd1753200303d0a0344be813e504253b3d98e74d
-EOF
-
 test_expect_success '"git notes list" does not expand to "git notes list HEAD"' '
-	git notes list > output &&
-	test_cmp expect_list output
+	cat >expect_list <<-EOF &&
+		c9c6af7f78bc47490dbf3e822cf2f3c24d4b9061 7a4ca6ee52a974a66cbaa78e33214535dff1d691
+		4b6ad22357cc8a1296720574b8d2fbc22fab0671 7f9ad8836c775acb134c0a055fc55fb4cd1ba361
+		c18dc024e14f08d18d14eea0d747ff692d66d6a3 d07d62e5208f22eb5695e7eb47667dc8b9860290
+	EOF
+	git notes list >actual &&
+	test_cmp expect_list actual
 '
 
 test_expect_success 'appending empty string does not change existing note' '
 	git notes append -m "" &&
-	git notes show > output &&
-	test_cmp expect output
+	git notes show >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'git notes append == add when there is no existing note' '
 	git notes remove HEAD &&
 	test_must_fail git notes list HEAD &&
-	git notes append -m "Initial set of notes
-
-More notes appended with git notes append" &&
-	git notes show > output &&
-	test_cmp expect output
+	git notes append -m "Initial set of notes${LF}${LF}More notes appended with git notes append" &&
+	git notes show >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'appending empty string to non-existing note does not create note' '
@@ -579,229 +521,208 @@ test_expect_success 'appending empty string to non-existing note does not create
 '
 
 test_expect_success 'create other note on a different notes ref (setup)' '
-	: > a6 &&
-	git add a6 &&
-	test_tick &&
-	git commit -m 6th &&
-	GIT_NOTES_REF="refs/notes/other" git notes add -m "other note"
-'
-
-cat > expect-other << EOF
-commit 387a89921c73d7ed72cd94d179c1c7048ca47756
-Author: A U Thor <author@example.com>
-Date:   Thu Apr 7 15:18:13 2005 -0700
+	test_commit 6th &&
+	GIT_NOTES_REF="refs/notes/other" git notes add -m "other note" &&
+	cat >expect-not-other <<-EOF &&
+		commit 2c125331118caba0ff8238b7f4958ac6e93fe39c
+		Author: A U Thor <author@example.com>
+		Date:   Thu Apr 7 15:18:13 2005 -0700
 
-    6th
+		${indent}6th
+	EOF
+	cp expect-not-other expect-other &&
+	cat >>expect-other <<-EOF
 
-Notes (other):
-    other note
-EOF
-
-cat > expect-not-other << EOF
-commit 387a89921c73d7ed72cd94d179c1c7048ca47756
-Author: A U Thor <author@example.com>
-Date:   Thu Apr 7 15:18:13 2005 -0700
-
-    6th
-EOF
+		Notes (other):
+		${indent}other note
+	EOF
+'
 
 test_expect_success 'Do not show note on other ref by default' '
-	git log -1 > output &&
-	test_cmp expect-not-other output
+	git log -1 >actual &&
+	test_cmp expect-not-other actual
 '
 
 test_expect_success 'Do show note when ref is given in GIT_NOTES_REF' '
-	GIT_NOTES_REF="refs/notes/other" git log -1 > output &&
-	test_cmp expect-other output
+	GIT_NOTES_REF="refs/notes/other" git log -1 >actual &&
+	test_cmp expect-other actual
 '
 
 test_expect_success 'Do show note when ref is given in core.notesRef config' '
-	git config core.notesRef "refs/notes/other" &&
-	git log -1 > output &&
-	test_cmp expect-other output
+	test_config core.notesRef "refs/notes/other" &&
+	git log -1 >actual &&
+	test_cmp expect-other actual
 '
 
 test_expect_success 'Do not show note when core.notesRef is overridden' '
-	GIT_NOTES_REF="refs/notes/wrong" git log -1 > output &&
-	test_cmp expect-not-other output
+	test_config core.notesRef "refs/notes/other" &&
+	GIT_NOTES_REF="refs/notes/wrong" git log -1 >actual &&
+	test_cmp expect-not-other actual
 '
 
-cat > expect-both << EOF
-commit 387a89921c73d7ed72cd94d179c1c7048ca47756
-Author: A U Thor <author@example.com>
-Date:   Thu Apr 7 15:18:13 2005 -0700
-
-    6th
+test_expect_success 'Show all notes when notes.displayRef=refs/notes/*' '
+	cat >expect-both <<-EOF &&
+		commit 2c125331118caba0ff8238b7f4958ac6e93fe39c
+		Author: A U Thor <author@example.com>
+		Date:   Thu Apr 7 15:18:13 2005 -0700
 
-Notes:
-    order test
+		${indent}6th
 
-Notes (other):
-    other note
+		Notes:
+		${indent}order test
 
-commit bd1753200303d0a0344be813e504253b3d98e74d
-Author: A U Thor <author@example.com>
-Date:   Thu Apr 7 15:17:13 2005 -0700
+		Notes (other):
+		${indent}other note
 
-    5th
+		commit 7f9ad8836c775acb134c0a055fc55fb4cd1ba361
+		Author: A U Thor <author@example.com>
+		Date:   Thu Apr 7 15:17:13 2005 -0700
 
-Notes:
-    replacement for deleted note
-EOF
+		${indent}5th
 
-test_expect_success 'Show all notes when notes.displayRef=refs/notes/*' '
+		Notes:
+		${indent}replacement for deleted note
+	EOF
 	GIT_NOTES_REF=refs/notes/commits git notes add \
 		-m"replacement for deleted note" HEAD^ &&
 	GIT_NOTES_REF=refs/notes/commits git notes add -m"order test" &&
-	git config --unset core.notesRef &&
-	git config notes.displayRef "refs/notes/*" &&
-	git log -2 > output &&
-	test_cmp expect-both output
+	test_unconfig core.notesRef &&
+	test_config notes.displayRef "refs/notes/*" &&
+	git log -2 >actual &&
+	test_cmp expect-both actual
 '
 
 test_expect_success 'core.notesRef is implicitly in notes.displayRef' '
-	git config core.notesRef refs/notes/commits &&
-	git config notes.displayRef refs/notes/other &&
-	git log -2 > output &&
-	test_cmp expect-both output
+	test_config core.notesRef refs/notes/commits &&
+	test_config notes.displayRef refs/notes/other &&
+	git log -2 >actual &&
+	test_cmp expect-both actual
 '
 
 test_expect_success 'notes.displayRef can be given more than once' '
-	git config --unset core.notesRef &&
-	git config notes.displayRef refs/notes/commits &&
+	test_unconfig core.notesRef &&
+	test_config notes.displayRef refs/notes/commits &&
 	git config --add notes.displayRef refs/notes/other &&
-	git log -2 > output &&
-	test_cmp expect-both output
+	git log -2 >actual &&
+	test_cmp expect-both actual
 '
 
-cat > expect-both-reversed << EOF
-commit 387a89921c73d7ed72cd94d179c1c7048ca47756
-Author: A U Thor <author@example.com>
-Date:   Thu Apr 7 15:18:13 2005 -0700
-
-    6th
+test_expect_success 'notes.displayRef respects order' '
+	cat >expect-both-reversed <<-EOF &&
+		commit 2c125331118caba0ff8238b7f4958ac6e93fe39c
+		Author: A U Thor <author@example.com>
+		Date:   Thu Apr 7 15:18:13 2005 -0700
 
-Notes (other):
-    other note
+		${indent}6th
 
-Notes:
-    order test
-EOF
+		Notes (other):
+		${indent}other note
 
-test_expect_success 'notes.displayRef respects order' '
-	git config core.notesRef refs/notes/other &&
-	git config --unset-all notes.displayRef &&
-	git config notes.displayRef refs/notes/commits &&
-	git log -1 > output &&
-	test_cmp expect-both-reversed output
+		Notes:
+		${indent}order test
+	EOF
+	test_config core.notesRef refs/notes/other &&
+	test_config notes.displayRef refs/notes/commits &&
+	git log -1 >actual &&
+	test_cmp expect-both-reversed actual
 '
 
 test_expect_success 'GIT_NOTES_DISPLAY_REF works' '
-	git config --unset-all core.notesRef &&
-	git config --unset-all notes.displayRef &&
 	GIT_NOTES_DISPLAY_REF=refs/notes/commits:refs/notes/other \
-		git log -2 > output &&
-	test_cmp expect-both output
+		git log -2 >actual &&
+	test_cmp expect-both actual
 '
 
-cat > expect-none << EOF
-commit 387a89921c73d7ed72cd94d179c1c7048ca47756
-Author: A U Thor <author@example.com>
-Date:   Thu Apr 7 15:18:13 2005 -0700
-
-    6th
+test_expect_success 'GIT_NOTES_DISPLAY_REF overrides config' '
+	cat >expect-none <<-EOF &&
+		commit 2c125331118caba0ff8238b7f4958ac6e93fe39c
+		Author: A U Thor <author@example.com>
+		Date:   Thu Apr 7 15:18:13 2005 -0700
 
-commit bd1753200303d0a0344be813e504253b3d98e74d
-Author: A U Thor <author@example.com>
-Date:   Thu Apr 7 15:17:13 2005 -0700
+		${indent}6th
 
-    5th
-EOF
+		commit 7f9ad8836c775acb134c0a055fc55fb4cd1ba361
+		Author: A U Thor <author@example.com>
+		Date:   Thu Apr 7 15:17:13 2005 -0700
 
-test_expect_success 'GIT_NOTES_DISPLAY_REF overrides config' '
-	git config notes.displayRef "refs/notes/*" &&
-	GIT_NOTES_REF= GIT_NOTES_DISPLAY_REF= git log -2 > output &&
-	test_cmp expect-none output
+		${indent}5th
+	EOF
+	test_config notes.displayRef "refs/notes/*" &&
+	GIT_NOTES_REF= GIT_NOTES_DISPLAY_REF= git log -2 >actual &&
+	test_cmp expect-none actual
 '
 
 test_expect_success '--show-notes=* adds to GIT_NOTES_DISPLAY_REF' '
-	GIT_NOTES_REF= GIT_NOTES_DISPLAY_REF= git log --show-notes=* -2 > output &&
-	test_cmp expect-both output
+	GIT_NOTES_REF= GIT_NOTES_DISPLAY_REF= git log --show-notes=* -2 >actual &&
+	test_cmp expect-both actual
 '
 
-cat > expect-commits << EOF
-commit 387a89921c73d7ed72cd94d179c1c7048ca47756
-Author: A U Thor <author@example.com>
-Date:   Thu Apr 7 15:18:13 2005 -0700
-
-    6th
+test_expect_success '--no-standard-notes' '
+	cat >expect-commits <<EOF
+		commit 2c125331118caba0ff8238b7f4958ac6e93fe39c
+		Author: A U Thor <author@example.com>
+		Date:   Thu Apr 7 15:18:13 2005 -0700
 
-Notes:
-    order test
-EOF
+		${indent}6th
 
-test_expect_success '--no-standard-notes' '
-	git log --no-standard-notes --show-notes=commits -1 > output &&
-	test_cmp expect-commits output
+		Notes:
+		${indent}order test
+	EOF
+	git log --no-standard-notes --show-notes=commits -1 >actual &&
+	test_cmp expect-commits actual
 '
 
 test_expect_success '--standard-notes' '
+	test_config notes.displayRef "refs/notes/*" &&
 	git log --no-standard-notes --show-notes=commits \
-		--standard-notes -2 > output &&
-	test_cmp expect-both output
+		--standard-notes -2 >actual &&
+	test_cmp expect-both actual
 '
 
 test_expect_success '--show-notes=ref accumulates' '
 	git log --show-notes=other --show-notes=commits \
-		 --no-standard-notes -1 > output &&
-	test_cmp expect-both-reversed output
+		 --no-standard-notes -1 >actual &&
+	test_cmp expect-both-reversed actual
 '
 
 test_expect_success 'Allow notes on non-commits (trees, blobs, tags)' '
-	git config core.notesRef refs/notes/other &&
-	echo "Note on a tree" > expect &&
+	test_config core.notesRef refs/notes/other &&
+	echo "Note on a tree" >expect &&
 	git notes add -m "Note on a tree" HEAD: &&
-	git notes show HEAD: > actual &&
+	git notes show HEAD: >actual &&
 	test_cmp expect actual &&
-	echo "Note on a blob" > expect &&
+	echo "Note on a blob" >expect &&
 	filename=$(git ls-tree --name-only HEAD | head -n1) &&
 	git notes add -m "Note on a blob" HEAD:$filename &&
-	git notes show HEAD:$filename > actual &&
+	git notes show HEAD:$filename >actual &&
 	test_cmp expect actual &&
-	echo "Note on a tag" > expect &&
+	echo "Note on a tag" >expect &&
 	git tag -a -m "This is an annotated tag" foobar HEAD^ &&
 	git notes add -m "Note on a tag" foobar &&
-	git notes show foobar > actual &&
+	git notes show foobar >actual &&
 	test_cmp expect actual
 '
 
-cat > expect << EOF
-commit 2ede89468182a62d0bde2583c736089bcf7d7e92
-Author: A U Thor <author@example.com>
-Date:   Thu Apr 7 15:19:13 2005 -0700
-
-    7th
+test_expect_success 'create note from other note with "git notes add -C"' '
+	cat >expect <<-EOF &&
+		commit fb01e0ca8c33b6cc0c6451dde747f97df567cb5c
+		Author: A U Thor <author@example.com>
+		Date:   Thu Apr 7 15:19:13 2005 -0700
 
-Notes (other):
-    other note
-EOF
+		${indent}7th
 
-test_expect_success 'create note from other note with "git notes add -C"' '
-	: > a7 &&
-	git add a7 &&
-	test_tick &&
-	git commit -m 7th &&
+		Notes:
+		${indent}order test
+	EOF
+	test_commit 7th &&
 	git notes add -C $(git notes list HEAD^) &&
-	git log -1 > actual &&
+	git log -1 >actual &&
 	test_cmp expect actual &&
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
@@ -814,405 +735,386 @@ test_expect_success 'create note from non-blob with "git notes add -C" fails' '
 	test_must_fail git notes list HEAD
 '
 
-cat > expect << EOF
-commit 80d796defacd5db327b7a4e50099663902fbdc5c
-Author: A U Thor <author@example.com>
-Date:   Thu Apr 7 15:20:13 2005 -0700
-
-    8th
+test_expect_success 'create note from blob with "git notes add -C" reuses blob id' '
+	cat >expect <<-EOF &&
+		commit 9a4c31c7f722b5d517e92c64e932dd751e1413bf
+		Author: A U Thor <author@example.com>
+		Date:   Thu Apr 7 15:20:13 2005 -0700
 
-Notes (other):
-    This is a blob object
-EOF
+		${indent}8th
 
-test_expect_success 'create note from blob with "git notes add -C" reuses blob id' '
+		Notes:
+		${indent}This is a blob object
+	EOF
 	blob=$(echo "This is a blob object" | git hash-object -w --stdin) &&
 	git notes add -C $blob &&
-	git log -1 > actual &&
+	git log -1 >actual &&
 	test_cmp expect actual &&
 	test "$(git notes list HEAD)" = "$blob"
 '
 
-cat > expect << EOF
-commit 016e982bad97eacdbda0fcbd7ce5b0ba87c81f1b
-Author: A U Thor <author@example.com>
-Date:   Thu Apr 7 15:21:13 2005 -0700
+test_expect_success 'create note from other note with "git notes add -c"' '
+	cat >expect <<-EOF &&
+		commit 2e0db4bc649e174d667a1cde19e725cf897a5bd2
+		Author: A U Thor <author@example.com>
+		Date:   Thu Apr 7 15:21:13 2005 -0700
 
-    9th
+		${indent}9th
 
-Notes (other):
-    yet another note
-EOF
-
-test_expect_success 'create note from other note with "git notes add -c"' '
-	: > a9 &&
-	git add a9 &&
-	test_tick &&
-	git commit -m 9th &&
+		Notes:
+		${indent}yet another note
+	EOF
+	test_commit 9th &&
 	MSG="yet another note" git notes add -c $(git notes list HEAD^^) &&
-	git log -1 > actual &&
+	git log -1 >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'create note from non-existing note with "git notes add -c" fails' '
-	: > a10 &&
-	git add a10 &&
-	test_tick &&
-	git commit -m 10th &&
+	test_commit 10th &&
 	test_must_fail env MSG="yet another note" git notes add -c deadbeef &&
 	test_must_fail git notes list HEAD
 '
 
-cat > expect << EOF
-commit 016e982bad97eacdbda0fcbd7ce5b0ba87c81f1b
-Author: A U Thor <author@example.com>
-Date:   Thu Apr 7 15:21:13 2005 -0700
-
-    9th
-
-Notes (other):
-    yet another note
-$whitespace
-    yet another note
-EOF
-
 test_expect_success 'append to note from other note with "git notes append -C"' '
+	cat >expect <<-EOF &&
+		commit 2e0db4bc649e174d667a1cde19e725cf897a5bd2
+		Author: A U Thor <author@example.com>
+		Date:   Thu Apr 7 15:21:13 2005 -0700
+
+		${indent}9th
+
+		Notes:
+		${indent}yet another note
+		${indent}
+		${indent}yet another note
+	EOF
 	git notes append -C $(git notes list HEAD^) HEAD^ &&
-	git log -1 HEAD^ > actual &&
+	git log -1 HEAD^ >actual &&
 	test_cmp expect actual
 '
 
-cat > expect << EOF
-commit ffed603236bfa3891c49644257a83598afe8ae5a
-Author: A U Thor <author@example.com>
-Date:   Thu Apr 7 15:22:13 2005 -0700
-
-    10th
+test_expect_success 'create note from other note with "git notes append -c"' '
+	cat >expect <<-EOF &&
+		commit 7c3b87ab368f81e11b1ea87b2ab99a71ccd25406
+		Author: A U Thor <author@example.com>
+		Date:   Thu Apr 7 15:22:13 2005 -0700
 
-Notes (other):
-    other note
-EOF
+		${indent}10th
 
-test_expect_success 'create note from other note with "git notes append -c"' '
+		Notes:
+		${indent}other note
+	EOF
 	MSG="other note" git notes append -c $(git notes list HEAD^) &&
-	git log -1 > actual &&
+	git log -1 >actual &&
 	test_cmp expect actual
 '
 
-cat > expect << EOF
-commit ffed603236bfa3891c49644257a83598afe8ae5a
-Author: A U Thor <author@example.com>
-Date:   Thu Apr 7 15:22:13 2005 -0700
-
-    10th
-
-Notes (other):
-    other note
-$whitespace
-    yet another note
-EOF
-
 test_expect_success 'append to note from other note with "git notes append -c"' '
+	cat >expect <<-EOF &&
+		commit 7c3b87ab368f81e11b1ea87b2ab99a71ccd25406
+		Author: A U Thor <author@example.com>
+		Date:   Thu Apr 7 15:22:13 2005 -0700
+
+		${indent}10th
+
+		Notes:
+		${indent}other note
+		${indent}
+		${indent}yet another note
+	EOF
 	MSG="yet another note" git notes append -c $(git notes list HEAD) &&
-	git log -1 > actual &&
+	git log -1 >actual &&
 	test_cmp expect actual
 '
 
-cat > expect << EOF
-commit 6352c5e33dbcab725fe0579be16aa2ba8eb369be
-Author: A U Thor <author@example.com>
-Date:   Thu Apr 7 15:23:13 2005 -0700
-
-    11th
-
-Notes (other):
-    other note
-$whitespace
-    yet another note
-EOF
-
 test_expect_success 'copy note with "git notes copy"' '
-	: > a11 &&
-	git add a11 &&
-	test_tick &&
-	git commit -m 11th &&
+	cat >expect <<-EOF &&
+		commit a446fff8777efdc6eb8f4b7c8a5ff699484df0d5
+		Author: A U Thor <author@example.com>
+		Date:   Thu Apr 7 15:23:13 2005 -0700
+
+		${indent}11th
+
+		Notes:
+		${indent}other note
+		${indent}
+		${indent}yet another note
+	EOF
+	test_commit 11th &&
 	git notes copy HEAD^ HEAD &&
-	git log -1 > actual &&
+	git log -1 >actual &&
 	test_cmp expect actual &&
 	test "$(git notes list HEAD)" = "$(git notes list HEAD^)"
 '
 
 test_expect_success 'prevent overwrite with "git notes copy"' '
 	test_must_fail git notes copy HEAD~2 HEAD &&
-	git log -1 > actual &&
+	git log -1 >actual &&
 	test_cmp expect actual &&
 	test "$(git notes list HEAD)" = "$(git notes list HEAD^)"
 '
 
-cat > expect << EOF
-commit 6352c5e33dbcab725fe0579be16aa2ba8eb369be
-Author: A U Thor <author@example.com>
-Date:   Thu Apr 7 15:23:13 2005 -0700
-
-    11th
-
-Notes (other):
-    yet another note
-$whitespace
-    yet another note
-EOF
-
 test_expect_success 'allow overwrite with "git notes copy -f"' '
+	cat >expect <<-EOF &&
+		commit a446fff8777efdc6eb8f4b7c8a5ff699484df0d5
+		Author: A U Thor <author@example.com>
+		Date:   Thu Apr 7 15:23:13 2005 -0700
+
+		${indent}11th
+
+		Notes:
+		${indent}yet another note
+		${indent}
+		${indent}yet another note
+	EOF
 	git notes copy -f HEAD~2 HEAD &&
-	git log -1 > actual &&
+	git log -1 >actual &&
 	test_cmp expect actual &&
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
 
-cat > expect << EOF
-commit e5d4fb5698d564ab8c73551538ecaf2b0c666185
-Author: A U Thor <author@example.com>
-Date:   Thu Apr 7 15:25:13 2005 -0700
-
-    13th
+test_expect_success 'git notes copy --stdin' '
+	cat >expect <<-EOF &&
+		commit e871aa61182b1d95d0a6fb75445d891722863b6b
+		Author: A U Thor <author@example.com>
+		Date:   Thu Apr 7 15:25:13 2005 -0700
 
-Notes (other):
-    yet another note
-$whitespace
-    yet another note
+		${indent}13th
 
-commit 7038787dfe22a14c3867ce816dbba39845359719
-Author: A U Thor <author@example.com>
-Date:   Thu Apr 7 15:24:13 2005 -0700
+		Notes:
+		${indent}yet another note
+		${indent}
+		${indent}yet another note
 
-    12th
+		commit 65e263ded02ae4e8839bc151095113737579dc12
+		Author: A U Thor <author@example.com>
+		Date:   Thu Apr 7 15:24:13 2005 -0700
 
-Notes (other):
-    other note
-$whitespace
-    yet another note
-EOF
+		${indent}12th
 
-test_expect_success 'git notes copy --stdin' '
+		Notes:
+		${indent}other note
+		${indent}
+		${indent}yet another note
+	EOF
 	(echo $(git rev-parse HEAD~3) $(git rev-parse HEAD^); \
 	echo $(git rev-parse HEAD~2) $(git rev-parse HEAD)) |
 	git notes copy --stdin &&
-	git log -2 > output &&
-	test_cmp expect output &&
+	git log -2 >actual &&
+	test_cmp expect actual &&
 	test "$(git notes list HEAD)" = "$(git notes list HEAD~2)" &&
 	test "$(git notes list HEAD^)" = "$(git notes list HEAD~3)"
 '
 
-cat > expect << EOF
-commit 37a0d4cba38afef96ba54a3ea567e6dac575700b
-Author: A U Thor <author@example.com>
-Date:   Thu Apr 7 15:27:13 2005 -0700
-
-    15th
+test_expect_success 'git notes copy --for-rewrite (unconfigured)' '
+	cat >expect <<-EOF &&
+		commit 4acf42e847e7fffbbf89ee365c20ac7caf40de89
+		Author: A U Thor <author@example.com>
+		Date:   Thu Apr 7 15:27:13 2005 -0700
 
-commit be28d8b4d9951ad940d229ee3b0b9ee3b1ec273d
-Author: A U Thor <author@example.com>
-Date:   Thu Apr 7 15:26:13 2005 -0700
+		${indent}15th
 
-    14th
-EOF
+		commit 07c85d77059393ed0154b8c96906547a59dfcddd
+		Author: A U Thor <author@example.com>
+		Date:   Thu Apr 7 15:26:13 2005 -0700
 
-test_expect_success 'git notes copy --for-rewrite (unconfigured)' '
+		${indent}14th
+	EOF
 	test_commit 14th &&
 	test_commit 15th &&
 	(echo $(git rev-parse HEAD~3) $(git rev-parse HEAD^); \
 	echo $(git rev-parse HEAD~2) $(git rev-parse HEAD)) |
 	git notes copy --for-rewrite=foo &&
-	git log -2 > output &&
-	test_cmp expect output
+	git log -2 >actual &&
+	test_cmp expect actual
 '
 
-cat > expect << EOF
-commit 37a0d4cba38afef96ba54a3ea567e6dac575700b
-Author: A U Thor <author@example.com>
-Date:   Thu Apr 7 15:27:13 2005 -0700
-
-    15th
-
-Notes (other):
-    yet another note
-$whitespace
-    yet another note
-
-commit be28d8b4d9951ad940d229ee3b0b9ee3b1ec273d
-Author: A U Thor <author@example.com>
-Date:   Thu Apr 7 15:26:13 2005 -0700
-
-    14th
-
-Notes (other):
-    other note
-$whitespace
-    yet another note
-EOF
-
 test_expect_success 'git notes copy --for-rewrite (enabled)' '
-	git config notes.rewriteMode overwrite &&
-	git config notes.rewriteRef "refs/notes/*" &&
+	cat >expect <<-EOF &&
+		commit 4acf42e847e7fffbbf89ee365c20ac7caf40de89
+		Author: A U Thor <author@example.com>
+		Date:   Thu Apr 7 15:27:13 2005 -0700
+
+		${indent}15th
+
+		Notes:
+		${indent}yet another note
+		${indent}
+		${indent}yet another note
+
+		commit 07c85d77059393ed0154b8c96906547a59dfcddd
+		Author: A U Thor <author@example.com>
+		Date:   Thu Apr 7 15:26:13 2005 -0700
+
+		${indent}14th
+
+		Notes:
+		${indent}other note
+		${indent}
+		${indent}yet another note
+	EOF
+	test_config notes.rewriteMode overwrite &&
+	test_config notes.rewriteRef "refs/notes/*" &&
 	(echo $(git rev-parse HEAD~3) $(git rev-parse HEAD^); \
 	echo $(git rev-parse HEAD~2) $(git rev-parse HEAD)) |
 	git notes copy --for-rewrite=foo &&
-	git log -2 > output &&
-	test_cmp expect output
+	git log -2 >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'git notes copy --for-rewrite (disabled)' '
-	git config notes.rewrite.bar false &&
+	test_config notes.rewrite.bar false &&
 	echo $(git rev-parse HEAD~3) $(git rev-parse HEAD) |
 	git notes copy --for-rewrite=bar &&
-	git log -2 > output &&
-	test_cmp expect output
+	git log -2 >actual &&
+	test_cmp expect actual
 '
 
-cat > expect << EOF
-commit 37a0d4cba38afef96ba54a3ea567e6dac575700b
-Author: A U Thor <author@example.com>
-Date:   Thu Apr 7 15:27:13 2005 -0700
+test_expect_success 'git notes copy --for-rewrite (overwrite)' '
+	cat >expect <<-EOF &&
+		commit 4acf42e847e7fffbbf89ee365c20ac7caf40de89
+		Author: A U Thor <author@example.com>
+		Date:   Thu Apr 7 15:27:13 2005 -0700
 
-    15th
+		${indent}15th
 
-Notes (other):
-    a fresh note
-EOF
-
-test_expect_success 'git notes copy --for-rewrite (overwrite)' '
+		Notes:
+		${indent}a fresh note
+	EOF
 	git notes add -f -m"a fresh note" HEAD^ &&
+	test_config notes.rewriteMode overwrite &&
+	test_config notes.rewriteRef "refs/notes/*" &&
 	echo $(git rev-parse HEAD^) $(git rev-parse HEAD) |
 	git notes copy --for-rewrite=foo &&
-	git log -1 > output &&
-	test_cmp expect output
+	git log -1 >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'git notes copy --for-rewrite (ignore)' '
-	git config notes.rewriteMode ignore &&
+	test_config notes.rewriteMode ignore &&
+	test_config notes.rewriteRef "refs/notes/*" &&
 	echo $(git rev-parse HEAD^) $(git rev-parse HEAD) |
 	git notes copy --for-rewrite=foo &&
-	git log -1 > output &&
-	test_cmp expect output
+	git log -1 >actual &&
+	test_cmp expect actual
 '
 
-cat > expect << EOF
-commit 37a0d4cba38afef96ba54a3ea567e6dac575700b
-Author: A U Thor <author@example.com>
-Date:   Thu Apr 7 15:27:13 2005 -0700
-
-    15th
-
-Notes (other):
-    a fresh note
-$whitespace
-    another fresh note
-EOF
-
 test_expect_success 'git notes copy --for-rewrite (append)' '
+	cat >expect <<-EOF &&
+		commit 4acf42e847e7fffbbf89ee365c20ac7caf40de89
+		Author: A U Thor <author@example.com>
+		Date:   Thu Apr 7 15:27:13 2005 -0700
+
+		${indent}15th
+
+		Notes:
+		${indent}a fresh note
+		${indent}
+		${indent}another fresh note
+	EOF
 	git notes add -f -m"another fresh note" HEAD^ &&
-	git config notes.rewriteMode concatenate &&
+	test_config notes.rewriteMode concatenate &&
+	test_config notes.rewriteRef "refs/notes/*" &&
 	echo $(git rev-parse HEAD^) $(git rev-parse HEAD) |
 	git notes copy --for-rewrite=foo &&
-	git log -1 > output &&
-	test_cmp expect output
+	git log -1 >actual &&
+	test_cmp expect actual
 '
 
-cat > expect << EOF
-commit 37a0d4cba38afef96ba54a3ea567e6dac575700b
-Author: A U Thor <author@example.com>
-Date:   Thu Apr 7 15:27:13 2005 -0700
-
-    15th
-
-Notes (other):
-    a fresh note
-$whitespace
-    another fresh note
-$whitespace
-    append 1
-$whitespace
-    append 2
-EOF
-
 test_expect_success 'git notes copy --for-rewrite (append two to one)' '
+	cat >expect <<-EOF &&
+		commit 4acf42e847e7fffbbf89ee365c20ac7caf40de89
+		Author: A U Thor <author@example.com>
+		Date:   Thu Apr 7 15:27:13 2005 -0700
+
+		${indent}15th
+
+		Notes:
+		${indent}a fresh note
+		${indent}
+		${indent}another fresh note
+		${indent}
+		${indent}append 1
+		${indent}
+		${indent}append 2
+	EOF
 	git notes add -f -m"append 1" HEAD^ &&
 	git notes add -f -m"append 2" HEAD^^ &&
+	test_config notes.rewriteMode concatenate &&
+	test_config notes.rewriteRef "refs/notes/*" &&
 	(echo $(git rev-parse HEAD^) $(git rev-parse HEAD);
 	echo $(git rev-parse HEAD^^) $(git rev-parse HEAD)) |
 	git notes copy --for-rewrite=foo &&
-	git log -1 > output &&
-	test_cmp expect output
+	git log -1 >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'git notes copy --for-rewrite (append empty)' '
 	git notes remove HEAD^ &&
+	test_config notes.rewriteMode concatenate &&
+	test_config notes.rewriteRef "refs/notes/*" &&
 	echo $(git rev-parse HEAD^) $(git rev-parse HEAD) |
 	git notes copy --for-rewrite=foo &&
-	git log -1 > output &&
-	test_cmp expect output
+	git log -1 >actual &&
+	test_cmp expect actual
 '
 
-cat > expect << EOF
-commit 37a0d4cba38afef96ba54a3ea567e6dac575700b
-Author: A U Thor <author@example.com>
-Date:   Thu Apr 7 15:27:13 2005 -0700
-
-    15th
-
-Notes (other):
-    replacement note 1
-EOF
-
 test_expect_success 'GIT_NOTES_REWRITE_MODE works' '
+	cat >expect <<-EOF &&
+		commit 4acf42e847e7fffbbf89ee365c20ac7caf40de89
+		Author: A U Thor <author@example.com>
+		Date:   Thu Apr 7 15:27:13 2005 -0700
+
+		${indent}15th
+
+		Notes:
+		${indent}replacement note 1
+	EOF
+	test_config notes.rewriteMode concatenate &&
+	test_config notes.rewriteRef "refs/notes/*" &&
 	git notes add -f -m"replacement note 1" HEAD^ &&
 	echo $(git rev-parse HEAD^) $(git rev-parse HEAD) |
 	GIT_NOTES_REWRITE_MODE=overwrite git notes copy --for-rewrite=foo &&
-	git log -1 > output &&
-	test_cmp expect output
+	git log -1 >actual &&
+	test_cmp expect actual
 '
 
-cat > expect << EOF
-commit 37a0d4cba38afef96ba54a3ea567e6dac575700b
-Author: A U Thor <author@example.com>
-Date:   Thu Apr 7 15:27:13 2005 -0700
-
-    15th
+test_expect_success 'GIT_NOTES_REWRITE_REF works' '
+	cat >expect <<-EOF &&
+		commit 4acf42e847e7fffbbf89ee365c20ac7caf40de89
+		Author: A U Thor <author@example.com>
+		Date:   Thu Apr 7 15:27:13 2005 -0700
 
-Notes (other):
-    replacement note 2
-EOF
+		${indent}15th
 
-test_expect_success 'GIT_NOTES_REWRITE_REF works' '
-	git config notes.rewriteMode overwrite &&
+		Notes:
+		${indent}replacement note 2
+	EOF
 	git notes add -f -m"replacement note 2" HEAD^ &&
-	git config --unset-all notes.rewriteRef &&
+	test_config notes.rewriteMode overwrite &&
+	test_unconfig notes.rewriteRef &&
 	echo $(git rev-parse HEAD^) $(git rev-parse HEAD) |
 	GIT_NOTES_REWRITE_REF=refs/notes/commits:refs/notes/other \
 		git notes copy --for-rewrite=foo &&
-	git log -1 > output &&
-	test_cmp expect output
+	git log -1 >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'GIT_NOTES_REWRITE_REF overrides config' '
-	git config notes.rewriteRef refs/notes/other &&
 	git notes add -f -m"replacement note 3" HEAD^ &&
+	test_config notes.rewriteMode overwrite &&
+	test_config notes.rewriteRef refs/notes/other &&
 	echo $(git rev-parse HEAD^) $(git rev-parse HEAD) |
 	GIT_NOTES_REWRITE_REF= git notes copy --for-rewrite=foo &&
-	git log -1 > output &&
-	test_cmp expect output
+	git log -1 >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'git notes copy diagnoses too many or too few parameters' '
@@ -1221,13 +1123,13 @@ test_expect_success 'git notes copy diagnoses too many or too few parameters' '
 '
 
 test_expect_success 'git notes get-ref (no overrides)' '
-	git config --unset core.notesRef &&
+	test_unconfig core.notesRef &&
 	sane_unset GIT_NOTES_REF &&
 	test "$(git notes get-ref)" = "refs/notes/commits"
 '
 
 test_expect_success 'git notes get-ref (core.notesRef)' '
-	git config core.notesRef refs/notes/foo &&
+	test_config core.notesRef refs/notes/foo &&
 	test "$(git notes get-ref)" = "refs/notes/foo"
 '
 
@@ -1277,10 +1179,10 @@ EOF
 test_expect_success 'empty notes are displayed by git log' '
 	test_commit 17th &&
 	git log -1 >expect &&
-	cat >>expect <<\EOF &&
+	cat >>expect <<-EOF &&
 
-Notes:
-EOF
+		Notes:
+	EOF
 	git notes add -C "$empty_blob" --allow-empty &&
 	git log -1 >actual &&
 	test_cmp expect actual
-- 
2.0.0.rc4.501.gdaf83ca
