From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 2/2] Test for "stg edit"
Date: Tue, 08 Jul 2008 06:03:17 +0200
Message-ID: <20080708040317.23134.667.stgit@yoghurt>
References: <20080708035750.23134.75833.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 06:04:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG4RH-00034q-FF
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 06:04:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbYGHEDW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jul 2008 00:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbYGHEDV
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 00:03:21 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4300 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbYGHEDU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 00:03:20 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KG4Q8-0000YC-00; Tue, 08 Jul 2008 05:03:16 +0100
In-Reply-To: <20080708035750.23134.75833.stgit@yoghurt>
User-Agent: StGIT/0.14.3.185.gb9e85
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87698>

We weren't testing this comaratively complicated command at all. (And
not surprisingly, some corner cases that should have worked didn't.)

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 t/t3300-edit.sh |  205 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 205 insertions(+), 0 deletions(-)
 create mode 100755 t/t3300-edit.sh


diff --git a/t/t3300-edit.sh b/t/t3300-edit.sh
new file mode 100755
index 0000000..8304d9f
--- /dev/null
+++ b/t/t3300-edit.sh
@@ -0,0 +1,205 @@
+#!/bin/sh
+test_description=3D'Test "stg edit"'
+
+. ./test-lib.sh
+
+test_expect_success 'Setup' '
+    printf "000\n111\n222\n" >> foo &&
+    git add foo &&
+    git commit -m "Initial commit" &&
+    sed -i "s/000/000xx/" foo &&
+    git commit -a -m "First change" &&
+    sed -i "s/111/111yy/" foo &&
+    git commit -a -m "Second change" &&
+    sed -i "s/222/222zz/" foo &&
+    git commit -a -m "Third change" &&
+    stg init &&
+    stg uncommit -n 3 p &&
+    stg pop
+'
+
+# Commit parse functions.
+msg () { git cat-file -p $1 | sed '1,/^$/d' | tr '\n' / | sed 's,/*$,,=
' ; }
+auth () { git log -n 1 --pretty=3Dformat:"%an, %ae" $1 ; }
+date () { git log -n 1 --pretty=3Dformat:%ai $1 ; }
+
+test_expect_success 'Edit message of top patch' '
+    test "$(msg HEAD)" =3D "Second change" &&
+    stg edit p2 -m "Second change 2" &&
+    test "$(msg HEAD)" =3D "Second change 2"
+'
+
+test_expect_success 'Edit message of non-top patch' '
+    test "$(msg HEAD^)" =3D "First change" &&
+    stg edit p1 -m "First change 2" &&
+    test "$(msg HEAD^)" =3D "First change 2"
+'
+
+test_expect_success 'Edit message of unapplied patch' '
+    test "$(msg $(stg id p3))" =3D "Third change" &&
+    stg edit p3 -m "Third change 2" &&
+    test "$(msg $(stg id p3))" =3D "Third change 2"
+'
+
+test_expect_success 'Set patch message with --file <file>' '
+    test "$(msg HEAD)" =3D "Second change 2" &&
+    echo "Pride or Prejudice" > commitmsg &&
+    stg edit p2 -f commitmsg &&
+    test "$(msg HEAD)" =3D "Pride or Prejudice"
+'
+
+test_expect_success 'Set patch message with --file -' '
+    echo "Pride and Prejudice" | stg edit p2 -f - &&
+    test "$(msg HEAD)" =3D "Pride and Prejudice"
+'
+
+( printf 'From: A U Thor <author@example.com>\nDate: <omitted>'
+  printf '\n\nPride and Prejudice' ) > expected-tmpl
+omit_date () { sed "s/^Date:.*$/Date: <omitted>/" ; }
+
+test_expect_success 'Save template to file' '
+    stg edit --save-template saved-tmpl p2 &&
+    omit_date < saved-tmpl > saved-tmpl-d &&
+    test_cmp expected-tmpl saved-tmpl-d
+'
+
+test_expect_success 'Save template to stdout' '
+    stg edit --save-template - p2 > saved-tmpl2 &&
+    omit_date < saved-tmpl2 > saved-tmpl2-d &&
+    test_cmp expected-tmpl saved-tmpl2-d
+'
+
+# Test the various ways of invoking the interactive editor. The
+# preference order should be
+#
+#   1. GIT_EDITOR
+#   2. stgit.editor (legacy)
+#   3. core.editor
+#   4. VISUAL
+#   5. EDITOR
+#   6. vi
+
+mkeditor ()
+{
+    cat > "$1" <<EOF
+#!/bin/sh
+printf "\n$1\n" >> "\$1"
+EOF
+    chmod a+x "$1"
+}
+
+mkeditor vi
+test_expect_failure 'Edit commit message interactively (vi)' '
+    m=3D$(msg HEAD) &&
+    PATH=3D.:$PATH stg edit p2 &&
+    test "$(msg HEAD)" =3D "$m/vi"
+'
+
+mkeditor e1
+test_expect_success 'Edit commit message interactively (EDITOR)' '
+    m=3D$(msg HEAD) &&
+    EDITOR=3D./e1 PATH=3D.:$PATH stg edit p2 &&
+    echo $m && echo $(msg HEAD) &&
+    test "$(msg HEAD)" =3D "$m/e1"
+'
+
+mkeditor e2
+test_expect_failure 'Edit commit message interactively (VISUAL)' '
+    m=3D$(msg HEAD) &&
+    VISUAL=3D./e2 EDITOR=3D./e1 PATH=3D.:$PATH stg edit p2 &&
+    test "$(msg HEAD)" =3D "$m/e2"
+'
+
+mkeditor e3
+test_expect_failure 'Edit commit message interactively (core.editor)' =
'
+    m=3D$(msg HEAD) &&
+    git config core.editor e3 &&
+    VISUAL=3D./e2 EDITOR=3D./e1 PATH=3D.:$PATH stg edit p2 &&
+    test "$(msg HEAD)" =3D "$m/e3"
+'
+
+mkeditor e4
+test_expect_success 'Edit commit message interactively (stgit.editor)'=
 '
+    m=3D$(msg HEAD) &&
+    git config stgit.editor e4 &&
+    VISUAL=3D./e2 EDITOR=3D./e1 PATH=3D.:$PATH stg edit p2 &&
+    test "$(msg HEAD)" =3D "$m/e4"
+'
+
+mkeditor e5
+test_expect_failure 'Edit commit message interactively (GIT_EDITOR)' '
+    m=3D$(msg HEAD) &&
+    GIT_EDITOR=3D./e5 VISUAL=3D./e2 EDITOR=3D./e1 PATH=3D.:$PATH stg e=
dit p2 &&
+    test "$(msg HEAD)" =3D "$m/e5"
+'
+
+rm -f vi e1 e2 e3 e4 e5
+git config --unset core.editor
+git config --unset stgit.editor
+
+mkeditor twoliner
+test_expect_failure 'Both noninterative and interactive editing' '
+    EDITOR=3D./twoliner stg edit -e -m "oneliner" p2 &&
+    test "$(msg HEAD)" =3D "oneliner/twoliner"
+'
+rm -f twoliner
+
+cat > diffedit <<EOF
+#!/bin/sh
+sed -i 's/111yy/111YY/' "\$1"
+EOF
+chmod a+x diffedit
+test_expect_success 'Edit patch diff' '
+    EDITOR=3D./diffedit stg edit -d p2 &&
+    test "$(grep 111 foo)" =3D "111YY"
+'
+rm -f diffedit
+
+test_expect_success 'Sign a patch' '
+    m=3D$(msg HEAD) &&
+    stg edit --sign p2 &&
+    test "$(msg HEAD)" =3D "$m//Signed-off-by: C O Mitter <committer@e=
xample.com>"
+'
+
+test_expect_success 'Acknowledge a patch' '
+    m=3D$(msg HEAD^) &&
+    stg edit --ack p1 &&
+    test "$(msg HEAD^)" =3D "$m//Acked-by: C O Mitter <committer@examp=
le.com>"
+'
+
+test_expect_success 'Set author' '
+    stg edit p2 --author "Jane Austin <jaustin@example.com>" &&
+    test "$(auth HEAD)" =3D "Jane Austin, jaustin@example.com"
+'
+
+test_expect_success 'Fail to set broken author' '
+    command_error stg edit p2 --author "No Mail Address" &&
+    test "$(auth HEAD)" =3D "Jane Austin, jaustin@example.com"
+'
+
+test_expect_success 'Set author name' '
+    stg edit p2 --authname "Jane Austen" &&
+    test "$(auth HEAD)" =3D "Jane Austen, jaustin@example.com"
+'
+
+test_expect_success 'Set author email' '
+    stg edit p2 --authemail "jausten@example.com" &&
+    test "$(auth HEAD)" =3D "Jane Austen, jausten@example.com"
+'
+
+test_expect_failure 'Set author date (RFC2822 format)' '
+    stg edit p2 --authdate "Wed, 10 Jul 2013 23:39:00 pm -0300" &&
+    test "$(date HEAD)" =3D "2013-07-10 23:39:00 -0300"
+'
+
+test_expect_failure 'Set author date (ISO 8601 format)' '
+    stg edit p2 --authdate "2013-01-28 22:30:00 -0300" &&
+    test "$(date HEAD)" =3D "2013-01-28 22:30:00 -0300"
+'
+
+test_expect_failure 'Fail to set invalid author date' '
+    command_error stg edit p2 --authdate "28 Jan 1813" &&
+    test "$(date HEAD)" =3D "2013-01-28 22:30:00 -0300"
+'
+
+test_done
