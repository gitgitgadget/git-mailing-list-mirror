From: Alexey Shumkin <zapped@mail.ru>
Subject: =?UTF-8?q?=5BPATCH=201/2=5D=20pretty=3A=20Add=20failing=20tests=3A=20user=20format=20ignores=20i18n=2ElogOutputEncoding=20setting?=
Date: Fri,  9 Sep 2011 12:43:25 +0400
Message-ID: <1315557806-5555-2-git-send-email-zapped@mail.ru>
References: <7vwrf6qh49.fsf@alter.siamese.dyndns.org>
 <1315557806-5555-1-git-send-email-zapped@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexey Shumkin <zapped@mail.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 10:44:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1whQ-0007NU-Uf
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 10:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932844Ab1IIIob convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Sep 2011 04:44:31 -0400
Received: from smtp19.mail.ru ([94.100.176.156]:54270 "EHLO smtp19.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932096Ab1IIIo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 04:44:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail;
	h=Sender:Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=GyKsvu50VSafX/nJ1/Ko7QjOSg3sgPN9CTepe+Fl8GA=;
	b=D+STe4kpdRKBy5GfbmI1bps2tcJZMctjUnt53ND/HznRIhe9f49242HCu2thEkY+H8pLZ5L6B/ud+8l1Mh0lGj2WbX+wlXaFexp41UGZ/xPB86TD2DpejjRboaN+lpT2;
Received: from [91.77.44.195] (port=20192 helo=zappedws)
	by smtp19.mail.ru with asmtp 
	id 1R1whG-0000VG-00; Fri, 09 Sep 2011 12:44:27 +0400
Received: from Alex by zappedws with local (Exim 4.76)
	(envelope-from <zapped@mail.ru>)
	id 1R1wgq-0001YI-RJ; Fri, 09 Sep 2011 12:44:00 +0400
X-Mailer: git-send-email 1.7.6.1.g8f21c
In-Reply-To: <1315557806-5555-1-git-send-email-zapped@mail.ru>
X-Spam: Not detected
X-Mras: Ok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181036>

The following two ought to give the same output to a terminal:

	$ git log --oneline --no-color
	$ git log --pretty=3Dformat:'%h %s'

However, the former pays attention to i18n.logOutputEncoding
configuration, while the latter does not when it format "%s". A log
messages written in an encoding i18n.commitEncoding that differs
from terminal encoding are shown corrupted with the latter even
when i18n.logOutputEncoding and terminal encoding are the same.

The same corruption is true for
	$ git diff --submodule=3Dlog
and
	$ git rev-list --pretty=3Dformat:%s HEAD

Signed-off-by: Alexey Shumkin <zapped@mail.ru>
---
 t/t4041-diff-submodule-option.sh |   44 +++++----
 t/t4205-log-pretty-formats.sh    |   22 ++++-
 t/t6006-rev-list-format.sh       |  192 +++++++++++++++++++++++-------=
--------
 3 files changed, 161 insertions(+), 97 deletions(-)

diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-=
option.sh
index bf9a752..4460cff 100755
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
 	sm=3D$1
 	shift
@@ -19,8 +21,12 @@ add_file () {
 		echo "$name" > "$name" &&
 		git add "$name" &&
 		test_tick &&
-		git commit -m "Add $name"
+		git config i18n.commitEncoding cp1251 &&
+		echo "Add $name ($added $name)" \
+			| iconv -f utf-8 -t cp1251 \
+			| xargs -I{} git commit -m "{}"
 	done >/dev/null
+	git config --unset i18n.commitEncoding
 	git rev-parse --verify HEAD | cut -c1-7
 	cd "$owd"
 }
@@ -37,7 +43,7 @@ head1=3D$(add_file sm1 foo1 foo2)
 test_expect_success 'added submodule' "
 	git add sm1 &&
 	git diff-index -p --submodule=3Dlog HEAD >actual &&
-	cat >expected <<-EOF &&
+	cat >expected <<EOF
 Submodule sm1 0000000...$head1 (new submodule)
 EOF
 	test_cmp expected actual
@@ -48,27 +54,27 @@ head2=3D$(add_file sm1 foo3)
=20
 test_expect_success 'modified submodule(forward)' "
 	git diff-index -p --submodule=3Dlog HEAD >actual &&
-	cat >expected <<-EOF &&
+	cat >expected <<EOF
 Submodule sm1 $head1..$head2:
-  > Add foo3
+  > Add foo3 ($added foo3)
 EOF
 	test_cmp expected actual
 "
=20
 test_expect_success 'modified submodule(forward)' "
 	git diff --submodule=3Dlog >actual &&
-	cat >expected <<-EOF &&
+	cat >expected <<EOF
 Submodule sm1 $head1..$head2:
-  > Add foo3
+  > Add foo3 ($added foo3)
 EOF
 	test_cmp expected actual
 "
=20
 test_expect_success 'modified submodule(forward) --submodule' "
 	git diff --submodule >actual &&
-	cat >expected <<-EOF &&
+	cat >expected <<EOF
 Submodule sm1 $head1..$head2:
-  > Add foo3
+  > Add foo3 ($added foo3)
 EOF
 	test_cmp expected actual
 "
@@ -98,10 +104,10 @@ head3=3D$(
=20
 test_expect_success 'modified submodule(backward)' "
 	git diff-index -p --submodule=3Dlog HEAD >actual &&
-	cat >expected <<-EOF &&
+	cat >expected <<EOF
 Submodule sm1 $head2..$head3 (rewind):
-  < Add foo3
-  < Add foo2
+  < Add foo3 ($added foo3)
+  < Add foo2 ($added foo2)
 EOF
 	test_cmp expected actual
 "
@@ -110,12 +116,12 @@ head4=3D$(add_file sm1 foo4 foo5) &&
 head4_full=3D$(GIT_DIR=3Dsm1/.git git rev-parse --verify HEAD)
 test_expect_success 'modified submodule(backward and forward)' "
 	git diff-index -p --submodule=3Dlog HEAD >actual &&
-	cat >expected <<-EOF &&
+	cat >expected <<EOF
 Submodule sm1 $head2...$head4:
-  > Add foo5
-  > Add foo4
-  < Add foo3
-  < Add foo2
+  > Add foo5 ($added foo5)
+  > Add foo4 ($added foo4)
+  < Add foo3 ($added foo3)
+  < Add foo2 ($added foo2)
 EOF
 	test_cmp expected actual
 "
@@ -131,10 +137,10 @@ mv sm1-bak sm1
 test_expect_success 'typechanged submodule(submodule->blob), --cached'=
 "
 	git diff --submodule=3Dlog --cached >actual &&
 	cat >expected <<-EOF &&
-Submodule sm1 41fbea9...0000000 (submodule deleted)
+Submodule sm1 $head4...0000000 (submodule deleted)
 diff --git a/sm1 b/sm1
 new file mode 100644
-index 0000000..9da5fb8
+index 0000000..$head5
 --- /dev/null
 +++ b/sm1
 @@ -0,0 +1 @@
@@ -148,7 +154,7 @@ test_expect_success 'typechanged submodule(submodul=
e->blob)' "
 	cat >expected <<-EOF &&
 diff --git a/sm1 b/sm1
 deleted file mode 100644
-index 9da5fb8..0000000
+index $head5..0000000
 --- a/sm1
 +++ /dev/null
 @@ -1 +0,0 @@
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats=
=2Esh
index 2ae9faa..96e0229 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -1,6 +1,7 @@
 #!/bin/sh
 #
 # Copyright (c) 2010, Will Palmer
+# Copyright (c) 2011, Alexey Shumkin (+ non-UTF-8 commit encoding test=
s)
 #
=20
 test_description=3D'Test pretty formats'
@@ -11,10 +12,13 @@ test_expect_success 'set up basic repos' '
 	>bar &&
 	git add foo &&
 	test_tick &&
-	git commit -m initial &&
+	git config i18n.commitEncoding cp1251 &&
+	printf "initial \320\272\320\276\320\274\320\274\320\270\321\202" \
+		| iconv -f utf-8 -t cp1251 | xargs -I{} git commit -m "{}" &&
 	git add bar &&
 	test_tick &&
-	git commit -m "add bar"
+	git commit -m "add bar" &&
+	git config --unset i18n.commitEncoding
 '
=20
 test_expect_success 'alias builtin format' '
@@ -38,6 +42,20 @@ test_expect_success 'alias user-defined format' '
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
+test_expect_success 'alias user-defined tformat with %s (utf-8 encodin=
g)' '
+	git log --oneline >expected-s &&
+	git log --pretty=3D"tformat:%h %s" >actual-s &&
+	test_cmp expected-s actual-s
+'
+
 test_expect_success 'alias user-defined tformat' '
 	git log --pretty=3D"tformat:%h" >expected &&
 	git config pretty.test-alias "tformat:%h" &&
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index d918cc0..8d99635 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -1,13 +1,34 @@
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
-touch foo && git add foo && git commit -m "added foo" &&
-  echo changed >foo && git commit -a -m "changed foo"
+	touch foo &&
+	git add foo &&
+	git config i18n.commitEncoding cp1251 &&
+	git commit -m "$added_cp1251" &&
+	head1=3D$(git rev-parse --verify HEAD) &&
+	head1_7=3D$(echo $head1 | cut -c1-7) &&
+	echo "$changed" > foo &&
+	git commit -a -m "$changed_cp1251" &&
+	head2=3D$(git rev-parse --verify HEAD) &&
+	head2_7=3D$(echo $head2 | cut -c1-7) &&
+	tree2=3D$(git cat-file -p HEAD | grep tree | cut -f 2 -d" ") &&
+	tree2_7=3D$(echo $tree2 | cut -c1-7) &&
+	head2_parent=3D$(git cat-file -p HEAD | grep parent | cut -f 2 -d" ")=
 &&
+	head2_parent_7=3D$(echo $head2_parent | cut -c1-7) &&
+	git config --unset i18n.commitEncoding
 '
=20
 # usage: test_format name format_string <expected_output
@@ -19,49 +40,49 @@ test_cmp expect.$1 output.$1
 "
 }
=20
-test_format percent %%h <<'EOF'
-commit 131a310eb913d107dd3c09a65d1651175898735d
+test_format percent %%h <<EOF
+commit $head2
 %h
-commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+commit $head1
 %h
 EOF
=20
-test_format hash %H%n%h <<'EOF'
-commit 131a310eb913d107dd3c09a65d1651175898735d
-131a310eb913d107dd3c09a65d1651175898735d
-131a310
-commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
-86c75cfd708a0e5868dc876ed5b8bb66c80b4873
-86c75cf
+test_format hash %H%n%h <<EOF
+commit $head2
+$head2
+$head2_7
+commit $head1
+$head1
+$head1_7
 EOF
=20
-test_format tree %T%n%t <<'EOF'
-commit 131a310eb913d107dd3c09a65d1651175898735d
-fe722612f26da5064c32ca3843aa154bdb0b08a0
-fe72261
-commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+test_format tree %T%n%t <<EOF
+commit $head2
+$tree2
+$tree2_7
+commit $head1
 4d5fcadc293a348e88f777dc0920f11e7d71441c
 4d5fcad
 EOF
=20
-test_format parents %P%n%p <<'EOF'
-commit 131a310eb913d107dd3c09a65d1651175898735d
-86c75cfd708a0e5868dc876ed5b8bb66c80b4873
-86c75cf
-commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+test_format parents %P%n%p <<EOF
+commit $head2
+$head1
+$head2_parent_7
+commit $head1
=20
=20
 EOF
=20
 # we don't test relative here
-test_format author %an%n%ae%n%ad%n%aD%n%at <<'EOF'
-commit 131a310eb913d107dd3c09a65d1651175898735d
+test_format author %an%n%ae%n%ad%n%aD%n%at <<EOF
+commit $head2
 A U Thor
 author@example.com
 Thu Apr 7 15:13:13 2005 -0700
 Thu, 7 Apr 2005 15:13:13 -0700
 1112911993
-commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+commit $head1
 A U Thor
 author@example.com
 Thu Apr 7 15:13:13 2005 -0700
@@ -69,14 +90,14 @@ Thu, 7 Apr 2005 15:13:13 -0700
 1112911993
 EOF
=20
-test_format committer %cn%n%ce%n%cd%n%cD%n%ct <<'EOF'
-commit 131a310eb913d107dd3c09a65d1651175898735d
+test_format committer %cn%n%ce%n%cd%n%cD%n%ct <<EOF
+commit $head2
 C O Mitter
 committer@example.com
 Thu Apr 7 15:13:13 2005 -0700
 Thu, 7 Apr 2005 15:13:13 -0700
 1112911993
-commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+commit $head1
 C O Mitter
 committer@example.com
 Thu Apr 7 15:13:13 2005 -0700
@@ -84,86 +105,105 @@ Thu, 7 Apr 2005 15:13:13 -0700
 1112911993
 EOF
=20
-test_format encoding %e <<'EOF'
-commit 131a310eb913d107dd3c09a65d1651175898735d
-commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+test_format encoding %e <<EOF
+commit $head2
+commit $head1
 EOF
=20
-test_format subject %s <<'EOF'
-commit 131a310eb913d107dd3c09a65d1651175898735d
-changed foo
-commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
-added foo
+expected=3D$(printf "commit $head2\n\
+$changed\n\
+commit $head1\n\
+$added
+")
+
+test_format subject %s <<EOF
+$expected
 EOF
=20
-test_format body %b <<'EOF'
-commit 131a310eb913d107dd3c09a65d1651175898735d
-commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+test_format body %b <<EOF
+commit $head2
+commit $head1
 EOF
=20
-test_format raw-body %B <<'EOF'
-commit 131a310eb913d107dd3c09a65d1651175898735d
-changed foo
+expected=3D$(printf "commit $head2\n\
+$changed\n\
+\n\
+commit $head1\n\
+$added
+")
=20
-commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
-added foo
+test_format raw-body %B <<EOF
+$expected
=20
 EOF
=20
-test_format colors %Credfoo%Cgreenbar%Cbluebaz%Cresetxyzzy <<'EOF'
-commit 131a310eb913d107dd3c09a65d1651175898735d
+test_format colors %Credfoo%Cgreenbar%Cbluebaz%Cresetxyzzy <<EOF
+commit $head2
 =1B[31mfoo=1B[32mbar=1B[34mbaz=1B[mxyzzy
-commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+commit $head1
 =1B[31mfoo=1B[32mbar=1B[34mbaz=1B[mxyzzy
 EOF
=20
-test_format advanced-colors '%C(red yellow bold)foo%C(reset)' <<'EOF'
-commit 131a310eb913d107dd3c09a65d1651175898735d
+test_format advanced-colors '%C(red yellow bold)foo%C(reset)' <<EOF
+commit $head2
 =1B[1;31;43mfoo=1B[m
-commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+commit $head1
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
+
 test_expect_success 'setup complex body' '
-git config i18n.commitencoding iso8859-1 &&
-  echo change2 >foo && git commit -a -F commit-msg
+	git config i18n.commitencoding cp1251 &&
+	echo change2 >foo && git commit -a -F commit-msg &&
+	head3=3D$(git rev-parse --verify HEAD) &&
+	head3_7=3D$(echo $head3 | cut -c1-7)
 '
=20
-test_format complex-encoding %e <<'EOF'
-commit f58db70b055c5718631e5c61528b28b12090cdea
-iso8859-1
-commit 131a310eb913d107dd3c09a65d1651175898735d
-commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+test_format complex-encoding %e <<EOF
+commit $head3
+cp1251
+commit $head2
+cp1251
+commit $head1
+cp1251
 EOF
=20
-test_format complex-subject %s <<'EOF'
-commit f58db70b055c5718631e5c61528b28b12090cdea
-Test printing of complex bodies
-commit 131a310eb913d107dd3c09a65d1651175898735d
-changed foo
-commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
-added foo
+# unset commit encoding config
+# otherwise %e does not print encoding value
+# and following test fails
+git config --unset i18n.commitencoding
+
+expected=3D$(printf "commit $head3\n\
+Test printing of complex bodies\n\
+commit $head2\n\
+$changed\n\
+commit $head1\n\
+$added
+")
+
+test_format complex-subject %s <<EOF
+$expected
 EOF
=20
-test_format complex-body %b <<'EOF'
-commit f58db70b055c5718631e5c61528b28b12090cdea
+test_format complex-body %b <<EOF
+commit $head3
 This commit message is much longer than the others,
-and it will be encoded in iso8859-1. We should therefore
-include an iso8859 character: =C2=A1bueno!
+and it will be encoded in cp1251. We should therefore
+include an cp1251 character: =D1=82=D0=B0=D0=BA =D0=B2=D0=BE=D1=82!
=20
-commit 131a310eb913d107dd3c09a65d1651175898735d
-commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+commit $head2
+commit $head1
 EOF
=20
 test_expect_success '%x00 shows NUL' '
-	echo  >expect commit f58db70b055c5718631e5c61528b28b12090cdea &&
+	echo  >expect commit $head3 &&
 	echo >>expect fooQbar &&
 	git rev-list -1 --format=3Dfoo%x00bar HEAD >actual.nul &&
 	nul_to_q <actual.nul >actual &&
@@ -210,12 +250,12 @@ test_expect_success 'add LF before non-empty (2)'=
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
--=20
1.7.6.1.g8f21c
