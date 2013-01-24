From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: [PATCH v4 3/4] pretty: Add failing tests: user format ignores i18n.logOutputEncoding setting
Date: Thu, 24 Jan 2013 13:10:27 +0400
Message-ID: <6de583a2d281b1614c69d5e7b6f5c4495488f6a3.1359018188.git.Alex.Crezoff@gmail.com>
References: <cover.1359018188.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexey Shumkin <Alex.Crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 24 10:11:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyIqe-00034R-La
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 10:11:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752584Ab3AXJLb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2013 04:11:31 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:36004 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375Ab3AXJL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 04:11:29 -0500
Received: by mail-lb0-f174.google.com with SMTP id l12so2382340lbo.19
        for <git@vger.kernel.org>; Thu, 24 Jan 2013 01:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=EgQRlDAy/qZ9kuFU8lnovK4McrHQoNZW8ptVvewsrag=;
        b=KCYDzGyH3PpOAb+/RRptas2FUkAaJWUZxmL/H59MSKir3MTmT4QebziXc5UdXyJP6o
         RxnILD3/lndCzDgjzlN2SgmEvCW1n/FcjaLXwq9vGf2PZFIcXsAA2VlNPbBbakyD8IpN
         tPukYQre4Iaf4Hvcf1bt9oux/7q+mrjjgAJO3M5fuL+OgnqpgqEVLeC+tBpXezBeEHXQ
         uJjXxc8mwgWtm586Bpx5nm9vWiMWMiuIpMEzOs8YF3J7ab5G5Eq7g/wNGBiJqWv7XCm8
         fYCscl1oj52kqZ1SfHPWfZSRZapnG1V0YyTew/6ndZncicrdwKmpSki93+BZ+LYL0KJu
         3aZA==
X-Received: by 10.112.28.133 with SMTP id b5mr485767lbh.79.1359018687800;
        Thu, 24 Jan 2013 01:11:27 -0800 (PST)
Received: from ds212plus (ppp91-77-44-105.pppoe.mtu-net.ru. [91.77.44.105])
        by mx.google.com with ESMTPS id bf3sm9300302lbb.16.2013.01.24.01.11.26
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 24 Jan 2013 01:11:27 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by ds212plus (Postfix) with ESMTP id 3340C600CC;
	Thu, 24 Jan 2013 13:11:54 +0400 (MSK)
X-Mailer: git-send-email 1.8.1.1.10.g9255f3f
In-Reply-To: <cover.1359018188.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1359018188.git.Alex.Crezoff@gmail.com>
References: <20110921004602.3d59bed4@zappedws> <cover.1359018188.git.Alex.Crezoff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214422>

The following two commands are expected to give the same output to a te=
rminal:

	$ git log --oneline --no-color
	$ git log --pretty=3Dformat:'%h %s'

However, the former pays attention to i18n.logOutputEncoding
configuration, while the latter does not when it format "%s".
Log messages written in an encoding i18n.commitEncoding which differs
from terminal encoding are shown corrupted with the latter even
when i18n.logOutputEncoding and terminal encoding are the same.

The same corruption is true for
	$ git diff --submodule=3Dlog
and
	$ git rev-list --pretty=3Dformat:%s HEAD
and
	$ git reset --hard

Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
---
 t/t4041-diff-submodule-option.sh | 33 ++++++++-------
 t/t4205-log-pretty-formats.sh    | 43 +++++++++++++++----
 t/t6006-rev-list-format.sh       | 90 ++++++++++++++++++++++++++------=
--------
 t/t7102-reset.sh                 | 32 +++++++++++---
 4 files changed, 138 insertions(+), 60 deletions(-)

diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-=
option.sh
index 32d4a60..e7d6363 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -1,6 +1,7 @@
 #!/bin/sh
 #
 # Copyright (c) 2009 Jens Lehmann, based on t7401 by Ping Yin
+# Copyright (c) 2011 Alexey Shumkin (+ non-UTF-8 commit encoding tests=
)
 #
=20
 test_description=3D'Support for verbose submodule differences in git d=
iff
@@ -10,6 +11,7 @@ This test tries to verify the sanity of the --submodu=
le option of git diff.
=20
 . ./test-lib.sh
=20
+added=3D$(printf "\320\264\320\276\320\261\320\260\320\262\320\273\320=
\265\320\275")
 add_file () {
 	(
 		cd "$1" &&
@@ -19,7 +21,8 @@ add_file () {
 			echo "$name" >"$name" &&
 			git add "$name" &&
 			test_tick &&
-			git commit -m "Add $name" || exit
+			msg_added_cp1251=3D$(echo "Add $name ($added $name)" | iconv -f utf=
-8 -t cp1251) &&
+			git -c 'i18n.commitEncoding=3Dcp1251' commit -m "$msg_added_cp1251"
 		done >/dev/null &&
 		git rev-parse --short --verify HEAD
 	)
@@ -89,29 +92,29 @@ test_expect_success 'diff.submodule does not affect=
 plumbing' '
 commit_file sm1 &&
 head2=3D$(add_file sm1 foo3)
=20
-test_expect_success 'modified submodule(forward)' '
+test_expect_failure 'modified submodule(forward)' '
 	git diff-index -p --submodule=3Dlog HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head1..$head2:
-	  > Add foo3
+	  > Add foo3 ($added foo3)
 	EOF
 	test_cmp expected actual
 '
=20
-test_expect_success 'modified submodule(forward)' '
+test_expect_failure 'modified submodule(forward)' '
 	git diff --submodule=3Dlog >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head1..$head2:
-	  > Add foo3
+	  > Add foo3 ($added foo3)
 	EOF
 	test_cmp expected actual
 '
=20
-test_expect_success 'modified submodule(forward) --submodule' '
+test_expect_failure 'modified submodule(forward) --submodule' '
 	git diff --submodule >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head1..$head2:
-	  > Add foo3
+	  > Add foo3 ($added foo3)
 	EOF
 	test_cmp expected actual
 '
@@ -138,25 +141,25 @@ head3=3D$(
 	git rev-parse --short --verify HEAD
 )
=20
-test_expect_success 'modified submodule(backward)' '
+test_expect_failure 'modified submodule(backward)' '
 	git diff-index -p --submodule=3Dlog HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head2..$head3 (rewind):
-	  < Add foo3
-	  < Add foo2
+	  < Add foo3 ($added foo3)
+	  < Add foo2 ($added foo2)
 	EOF
 	test_cmp expected actual
 '
=20
 head4=3D$(add_file sm1 foo4 foo5)
-test_expect_success 'modified submodule(backward and forward)' '
+test_expect_failure 'modified submodule(backward and forward)' '
 	git diff-index -p --submodule=3Dlog HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head2...$head4:
-	  > Add foo5
-	  > Add foo4
-	  < Add foo3
-	  < Add foo2
+	  > Add foo5 ($added foo5)
+	  > Add foo4 ($added foo4)
+	  < Add foo3 ($added foo3)
+	  < Add foo2 ($added foo2)
 	EOF
 	test_cmp expected actual
 '
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats=
=2Esh
index 98a43d4..76ffa0d 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -1,20 +1,31 @@
 #!/bin/sh
 #
 # Copyright (c) 2010, Will Palmer
+# Copyright (c) 2011, Alexey Shumkin (+ non-UTF-8 commit encoding test=
s)
 #
=20
 test_description=3D'Test pretty formats'
 . ./test-lib.sh
=20
+commit_msg() {
+	msg=3D$(printf "initial \320\272\320\276\320\274\320\274\320\270\321\=
202")
+	if test -n "$1"; then
+		msg=3D$(echo $msg | iconv -f utf-8 -t $1)
+	fi
+	echo $msg
+}
+
 test_expect_success 'set up basic repos' '
 	>foo &&
 	>bar &&
 	git add foo &&
 	test_tick &&
-	git commit -m initial &&
+	git config i18n.commitEncoding cp1251 &&
+	git commit -m "$(commit_msg cp1251)" &&
 	git add bar &&
 	test_tick &&
-	git commit -m "add bar"
+	git commit -m "add bar" &&
+	git config --unset i18n.commitEncoding
 '
=20
 test_expect_success 'alias builtin format' '
@@ -38,6 +49,20 @@ test_expect_success 'alias user-defined format' '
 	test_cmp expected actual
 '
=20
+test_expect_success 'alias user-defined tformat with %s (cp1251 encodi=
ng)' '
+	git config i18n.logOutputEncoding cp1251 &&
+	git log --oneline >expected-s &&
+	git log --pretty=3D"tformat:%h %s" >actual-s &&
+	git config --unset i18n.logOutputEncoding &&
+	test_cmp expected-s actual-s
+'
+
+test_expect_failure 'alias user-defined tformat with %s (utf-8 encodin=
g)' '
+	git log --oneline >expected-s &&
+	git log --pretty=3D"tformat:%h %s" >actual-s &&
+	test_cmp expected-s actual-s
+'
+
 test_expect_success 'alias user-defined tformat' '
 	git log --pretty=3D"tformat:%h" >expected &&
 	git config pretty.test-alias "tformat:%h" &&
@@ -71,22 +96,22 @@ test_expect_success 'alias loop' '
 	test_must_fail git log --pretty=3Dtest-foo
 '
=20
-test_expect_success 'NUL separation' '
-	printf "add bar\0initial" >expected &&
+test_expect_failure 'NUL separation' '
+	printf "add bar\0$(commit_msg)" >expected &&
 	git log -z --pretty=3D"format:%s" >actual &&
 	test_cmp expected actual
 '
=20
-test_expect_success 'NUL termination' '
-	printf "add bar\0initial\0" >expected &&
+test_expect_failure 'NUL termination' '
+	printf "add bar\0$(commit_msg)\0" >expected &&
 	git log -z --pretty=3D"tformat:%s" >actual &&
 	test_cmp expected actual
 '
=20
-test_expect_success 'NUL separation with --stat' '
+test_expect_failure 'NUL separation with --stat' '
 	stat0_part=3D$(git diff --stat HEAD^ HEAD) &&
 	stat1_part=3D$(git diff-tree --no-commit-id --stat --root HEAD^) &&
-	printf "add bar\n$stat0_part\n\0initial\n$stat1_part\n" >expected &&
+	printf "add bar\n$stat0_part\n\0$(commit_msg)\n$stat1_part\n" >expect=
ed &&
 	git log -z --stat --pretty=3D"format:%s" >actual &&
 	test_i18ncmp expected actual
 '
@@ -94,7 +119,7 @@ test_expect_success 'NUL separation with --stat' '
 test_expect_failure 'NUL termination with --stat' '
 	stat0_part=3D$(git diff --stat HEAD^ HEAD) &&
 	stat1_part=3D$(git diff-tree --no-commit-id --stat --root HEAD^) &&
-	printf "add bar\n$stat0_part\n\0initial\n$stat1_part\n\0" >expected &=
&
+	printf "add bar\n$stat0_part\n\0$(commit_msg)\n$stat1_part\n0" >expec=
ted &&
 	git log -z --stat --pretty=3D"tformat:%s" >actual &&
 	test_i18ncmp expected actual
 '
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index c248509..4db43a4 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -1,33 +1,54 @@
 #!/bin/sh
=20
+# Copyright (c) 2009 Jens Lehmann
+# Copyright (c) 2011 Alexey Shumkin (+ non-UTF-8 commit encoding tests=
)
+
 test_description=3D'git rev-list --pretty=3Dformat test'
=20
 . ./test-lib.sh
=20
 test_tick
+added=3D$(printf "added (\320\264\320\276\320\261\320\260\320\262\320\=
273\320\265\320\275) foo")
+added_cp1251=3D$(echo "$added" | iconv -f utf-8 -t cp1251)
+changed=3D$(printf "changed (\320\264\320\276\320\261\320\260\320\262\=
320\273\320\265\320\275) foo")
+changed_cp1251=3D$(echo "$changed" | iconv -f utf-8 -t cp1251)
+
 test_expect_success 'setup' '
 	touch foo &&
 	git add foo &&
-	git commit -m "added foo" &&
+	git config i18n.commitEncoding cp1251 &&
+	git commit -m "$added_cp1251" &&
 	head1=3D$(git rev-parse --verify HEAD) &&
 	head1_7=3D$(echo $head1 | cut -c1-7) &&
-	echo changed >foo &&
-	git commit -a -m "changed foo" &&
+	echo "$changed" > foo &&
+	git commit -a -m "$changed_cp1251" &&
 	head2=3D$(git rev-parse --verify HEAD) &&
 	head2_7=3D$(echo $head2 | cut -c1-7) &&
+	tree2=3D$(git cat-file -p HEAD | grep tree | cut -f 2 -d" ") &&
+	tree2_7=3D$(echo $tree2 | cut -c1-7) &&
 	head2_parent=3D$(git cat-file -p HEAD | grep parent | cut -f 2 -d" ")=
 &&
 	head2_parent_7=3D$(echo $head2_parent | cut -c1-7) &&
-	tree2=3D$(git cat-file -p HEAD | grep tree | cut -f 2 -d" ") &&
-	tree2_7=3D$(echo $tree2 | cut -c1-7)
+	git config --unset i18n.commitEncoding
 '
=20
 # usage: test_format name format_string <expected_output
 test_format() {
+	local must_fail=3D0
+	# if parameters count is more than 2 then test must fail
+	if [ $# -gt 2 ]; then
+		must_fail=3D1
+		# remove first parameter which is flag for test failure
+		shift
+	fi
 	cat >expect.$1
-	test_expect_success "format $1" "
-git rev-list --pretty=3Dformat:'$2' master >output.$1 &&
-test_cmp expect.$1 output.$1
-"
+	name=3D"format $1"
+	command=3D"git rev-list --pretty=3Dformat:'$2' master >output.$1 &&
+test_cmp expect.$1 output.$1"
+	if [ $must_fail -eq 1 ]; then
+		test_expect_failure "$name" "$command"
+	else
+		test_expect_success "$name" "$command"
+	fi
 }
=20
 test_format percent %%h <<EOF
@@ -95,16 +116,16 @@ Thu, 7 Apr 2005 15:13:13 -0700
 1112911993
 EOF
=20
-test_format encoding %e <<EOF
+test_format failure encoding %e <<EOF
 commit $head2
 commit $head1
 EOF
=20
-test_format subject %s <<EOF
+test_format failure subject %s <<EOF
 commit $head2
-changed foo
+$changed
 commit $head1
-added foo
+$added
 EOF
=20
 test_format body %b <<EOF
@@ -112,12 +133,12 @@ commit $head2
 commit $head1
 EOF
=20
-test_format raw-body %B <<'EOF'
-commit 131a310eb913d107dd3c09a65d1651175898735d
-changed foo
+test_format failure raw-body %B <<EOF
+commit $head2
+$changed
=20
-commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
-added foo
+commit $head1
+$added
=20
 EOF
=20
@@ -135,16 +156,16 @@ commit $head1
 =1B[1;31;43mfoo=1B[m
 EOF
=20
-cat >commit-msg <<'EOF'
+iconv -f utf-8 -t cp1251 > commit-msg <<EOF
 Test printing of complex bodies
=20
 This commit message is much longer than the others,
-and it will be encoded in iso8859-1. We should therefore
-include an iso8859 character: =C2=A1bueno!
+and it will be encoded in cp1251. We should therefore
+include an cp1251 character: =D1=82=D0=B0=D0=BA =D0=B2=D0=BE=D1=82!
 EOF
=20
 test_expect_success 'setup complex body' '
-	git config i18n.commitencoding iso8859-1 &&
+	git config i18n.commitencoding cp1251 &&
 	echo change2 >foo && git commit -a -F commit-msg &&
 	head3=3D$(git rev-parse --verify HEAD) &&
 	head3_7=3D$(echo $head3 | cut -c1-7)
@@ -152,25 +173,32 @@ test_expect_success 'setup complex body' '
=20
 test_format complex-encoding %e <<EOF
 commit $head3
-iso8859-1
+cp1251
 commit $head2
+cp1251
 commit $head1
+cp1251
 EOF
=20
-test_format complex-subject %s <<EOF
+# unset commit encoding config
+# otherwise %e does not print encoding value
+# and following test fails
+git config --unset i18n.commitencoding
+
+test_format failure complex-subject %s <<EOF
 commit $head3
 Test printing of complex bodies
 commit $head2
-changed foo
+$changed
 commit $head1
-added foo
+$added
 EOF
=20
-test_format complex-body %b <<EOF
+test_format failure complex-body %b <<EOF
 commit $head3
 This commit message is much longer than the others,
-and it will be encoded in iso8859-1. We should therefore
-include an iso8859 character: =C2=A1bueno!
+and it will be encoded in cp1251. We should therefore
+include an cp1251 character: =D1=82=D0=B0=D0=BA =D0=B2=D0=BE=D1=82!
=20
 commit $head2
 commit $head1
@@ -224,12 +252,12 @@ test_expect_success 'add LF before non-empty (2)'=
 '
=20
 test_expect_success 'add SP before non-empty (1)' '
 	git show -s --pretty=3Dformat:"%s% bThanks" HEAD^^ >actual &&
-	test $(wc -w <actual) =3D 2
+	test $(wc -w <actual) =3D 3
 '
=20
 test_expect_success 'add SP before non-empty (2)' '
 	git show -s --pretty=3Dformat:"%s% sThanks" HEAD^^ >actual &&
-	test $(wc -w <actual) =3D 4
+	test $(wc -w <actual) =3D 6
 '
=20
 test_expect_success '--abbrev' '
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index cf492f4..699c824 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -9,6 +9,14 @@ Documented tests for git reset'
=20
 . ./test-lib.sh
=20
+commit_msg() {
+	msg=3D$(printf "modify 2nd file (\320\270\320\267\320\274\320\265\320=
\275\321\221\320\275 \321\204\320\260\320\271\320\273)")
+	if test -n "$1"; then
+		msg=3D$(echo $msg | iconv -f utf-8 -t $1)
+	fi
+	echo $msg
+}
+
 test_expect_success 'creating initial files and commits' '
 	test_tick &&
 	echo "1st file" >first &&
@@ -28,7 +36,7 @@ test_expect_success 'creating initial files and commi=
ts' '
=20
 	echo "1st line 2nd file" >secondfile &&
 	echo "2nd line 2nd file" >>secondfile &&
-	git commit -a -m "modify 2nd file" &&
+	git -c "i18n.commitEncoding=3Dcp1251" commit -a -m "$(commit_msg cp12=
51)" &&
 	head5=3D$(git rev-parse --verify HEAD)
 '
 # git log --pretty=3Doneline # to see those SHA1 involved
@@ -44,6 +52,20 @@ check_changes () {
 	done | test_cmp .cat_expect -
 }
=20
+test_expect_failure 'reset --hard message' '
+	hex=3D$(git log -1 --format=3D"%h") &&
+	git reset --hard > .actual &&
+	echo HEAD is now at $hex $(commit_msg) > .expected &&
+	test_cmp .actual .expected
+'
+
+test_expect_success 'reset --hard message (cp1251 logoutencoding)' '
+	hex=3D$(git log -1 --format=3D"%h") &&
+	git -c "i18n.logOutputEncoding=3Dcp1251" reset --hard > .actual &&
+	echo HEAD is now at $hex $(commit_msg cp1251) > .expected &&
+	test_cmp .actual .expected
+'
+
 >.diff_expect
 >.cached_expect
 cat >.cat_expect <<EOF
@@ -192,7 +214,7 @@ test_expect_success \
 	'changing files and redo the last commit should succeed' '
 	echo "3rd line 2nd file" >>secondfile &&
 	git commit -a -C ORIG_HEAD &&
-	check_changes 3d3b7be011a58ca0c179ae45d94e6c83c0b0cd0d &&
+	check_changes f06f78b8dd468c722952b77569dd0db212442c25 &&
 	test "$(git rev-parse ORIG_HEAD)" =3D \
 			$head5
 '
@@ -211,7 +233,7 @@ test_expect_success \
 	git reset --hard HEAD~2 &&
 	check_changes ddaefe00f1da16864591c61fdc7adb5d7cd6b74e &&
 	test "$(git rev-parse ORIG_HEAD)" =3D \
-			3d3b7be011a58ca0c179ae45d94e6c83c0b0cd0d
+			f06f78b8dd468c722952b77569dd0db212442c25
 '
=20
 >.diff_expect
@@ -303,7 +325,7 @@ test_expect_success 'redoing the last two commits s=
hould succeed' '
=20
 	echo "1st line 2nd file" >secondfile &&
 	echo "2nd line 2nd file" >>secondfile &&
-	git commit -a -m "modify 2nd file" &&
+	git -c "i18n.commitEncoding=3Dcp1251" commit -a -m "$(commit_msg cp12=
51)" &&
 	check_changes $head5
 '
=20
@@ -329,7 +351,7 @@ test_expect_success '--hard reset to HEAD should cl=
ear a failed merge' '
=20
 	test_must_fail git pull . branch1 &&
 	git reset --hard &&
-	check_changes 77abb337073fb4369a7ad69ff6f5ec0e4d6b54bb
+	check_changes f26fb896db2344fe158ce3720249e1df4d26174b
 '
=20
 >.diff_expect
--=20
1.8.1.1.10.g9255f3f
