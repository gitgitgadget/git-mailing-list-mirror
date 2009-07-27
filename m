From: Johan Herland <johan@herland.net>
Subject: [RFC 11/11] Add simple test cases of git-vcs-cvs functionality
Date: Mon, 27 Jul 2009 03:04:19 +0200
Message-ID: <1248656659-21415-12-git-send-email-johan@herland.net>
References: <1248656659-21415-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Johan Herland <johan@herland.net>, barkalow@iabervon.org,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 27 03:06:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVEfW-0004JH-9k
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 03:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755528AbZG0BGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2009 21:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752187AbZG0BGK
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 21:06:10 -0400
Received: from mx.getmail.no ([84.208.15.66]:48755 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755524AbZG0BGE (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jul 2009 21:06:04 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNF0042G1Q2SEC0@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 27 Jul 2009 03:06:03 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNF004SX1O2UG30@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 27 Jul 2009 03:06:02 +0200 (MEST)
X-PMX-Version: 5.5.5.374460, Antispam-Engine: 2.7.1.369594,
 Antispam-Data: 2009.7.27.5416
X-Mailer: git-send-email 1.6.4.rc3.138.ga6b98.dirty
In-reply-to: <1248656659-21415-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124152>

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t9800-foreign-vcs-cvs-basic.sh |  518 ++++++++++++++++++++++++++++++++++++++
 t/t9801-foreign-vcs-cvs-fetch.sh |  291 +++++++++++++++++++++
 t/test-lib.sh                    |    1 +
 3 files changed, 810 insertions(+), 0 deletions(-)
 create mode 100755 t/t9800-foreign-vcs-cvs-basic.sh
 create mode 100755 t/t9801-foreign-vcs-cvs-fetch.sh

diff --git a/t/t9800-foreign-vcs-cvs-basic.sh b/t/t9800-foreign-vcs-cvs-basic.sh
new file mode 100755
index 0000000..4e29e62
--- /dev/null
+++ b/t/t9800-foreign-vcs-cvs-basic.sh
@@ -0,0 +1,518 @@
+#!/bin/sh
+
+test_description='git vcs-cvs basic tests'
+. ./test-lib.sh
+
+if ! test_have_prereq PYTHON; then
+	say 'skipping CVS foreign-vcs helper tests, python not available'
+	test_done
+fi
+
+CVS_EXEC=cvs
+CVS_OPTS="-f -q"
+CVS="$CVS_EXEC $CVS_OPTS"
+
+CVSROOT=$(pwd)/cvsroot
+export CVSROOT
+unset CVS_SERVER
+
+CVSMODULE=cvsmodule
+GITREMOTE=cvsremote
+
+if ! type $CVS_EXEC >/dev/null 2>&1
+then
+	say 'skipping vcs-cvs tests, $CVS_EXEC not found'
+	test_done
+fi
+
+test_expect_success 'setup cvsroot' '$CVS init'
+
+test_expect_success '#1: setup a cvs module' '
+
+	mkdir "$CVSROOT/$CVSMODULE" &&
+	$CVS co -d module-cvs $CVSMODULE &&
+	(
+		cd module-cvs &&
+		cat <<EOF >o_fortuna &&
+O Fortuna
+velut luna
+statu variabilis,
+
+semper crescis
+aut decrescis;
+vita detestabilis
+
+nunc obdurat
+et tunc curat
+ludo mentis aciem,
+
+egestatem,
+potestatem
+dissolvit ut glaciem.
+EOF
+		$CVS add o_fortuna &&
+		cat <<EOF >message &&
+add "O Fortuna" lyrics
+
+These public domain lyrics make an excellent sample text.
+EOF
+		$CVS commit -f -F message o_fortuna
+	)
+'
+
+test_expect_success 'set up CVS repo as a foreign remote' '
+
+	git config "user.name" "Test User"
+	git config "user.email" "test@example.com"
+	git config "remote.$GITREMOTE.vcs" cvs
+	git config "remote.$GITREMOTE.cvsRoot" "$CVSROOT"
+	git config "remote.$GITREMOTE.cvsModule" "$CVSMODULE"
+	git config "remote.$GITREMOTE.fetch" \
+		"+refs/cvs/$GITREMOTE/*:refs/remotes/$GITREMOTE/*"
+
+'
+
+test_expect_success '#1: git-vcs-cvs "capabilities" command' '
+
+	echo "capabilities" | git vcs-cvs "$GITREMOTE" > actual &&
+	cat <<EOF >expect &&
+marks .git/info/cvs/$GITREMOTE/marks
+
+EOF
+	test_cmp expect actual
+
+'
+
+test_expect_success '#1: git-vcs-cvs "list" command' '
+
+	echo "list" | git vcs-cvs "$GITREMOTE" > actual &&
+	cat <<EOF >expect &&
+refs/cvs/$GITREMOTE/HEAD changed
+
+EOF
+	test_cmp expect actual
+
+'
+
+test_expect_success '#1: git-vcs-cvs "import" command' '
+
+	echo "import refs/cvs/$GITREMOTE/HEAD" | git vcs-cvs "$GITREMOTE" > actual &&
+	cat <<EOF >expect &&
+# Importing CVS revision o_fortuna:1.1
+blob
+mark :1
+data 180
+O Fortuna
+velut luna
+statu variabilis,
+
+semper crescis
+aut decrescis;
+vita detestabilis
+
+nunc obdurat
+et tunc curat
+ludo mentis aciem,
+
+egestatem,
+potestatem
+dissolvit ut glaciem.
+
+commit refs/cvs/$GITREMOTE/HEAD
+mark :2
+data 82
+add "O Fortuna" lyrics
+
+These public domain lyrics make an excellent sample text.
+
+M 644 :1 o_fortuna
+
+# Importing note for object 2
+blob
+mark :3
+data 14
+o_fortuna:1.1
+
+commit refs/notes/cvs/$GITREMOTE
+mark :4
+data 43
+Annotate commits imported by "git vcs-cvs"
+
+M 644 :3 :2
+
+blob
+mark :5
+data 32
+1 o_fortuna:1.1
+2 o_fortuna:1.1
+
+blob
+mark :6
+data 16
+blob 1
+commit 2
+
+commit refs/cvs/$GITREMOTE/_metadata
+mark :7
+data 39
+Updated metadata used by "git vcs-cvs"
+
+M 644 :5 CVS/marks
+M 644 :6 o_fortuna/1.1
+
+EOF
+	grep -v "^committer " actual > actual.filtered &&
+	test_cmp expect actual.filtered
+
+'
+
+test_expect_success '#1: Passing git-vcs-cvs output to git-fast-import' '
+
+	git fast-import --quiet \
+		--export-marks=".git/info/cvs/$GITREMOTE/marks" \
+		< actual &&
+	git gc
+
+'
+
+test_expect_success '#1: Verifying correctness of import' '
+
+	echo "verify HEAD" | git vcs-cvs "$GITREMOTE"
+
+'
+
+test_expect_success '#2: update cvs module' '
+
+	(
+		cd module-cvs &&
+		cat <<EOF >o_fortuna &&
+O Fortune,
+like the moon
+you are changeable,
+
+ever waxing
+and waning;
+hateful life
+
+first oppresses
+and then soothes
+as fancy takes it;
+
+poverty
+and power
+it melts them like ice.
+EOF
+		cat <<EOF >message &&
+translate to English
+
+My Latin is terrible.
+EOF
+		$CVS commit -f -F message o_fortuna
+	)
+'
+
+test_expect_success '#2: git-vcs-cvs "capabilities" command' '
+
+	echo "capabilities" | git vcs-cvs "$GITREMOTE" > actual &&
+	cat <<EOF >expect &&
+marks .git/info/cvs/$GITREMOTE/marks
+
+EOF
+	test_cmp expect actual
+
+'
+
+test_expect_success '#2: git-vcs-cvs "list" command' '
+
+	echo "list" | git vcs-cvs "$GITREMOTE" > actual &&
+	cat <<EOF >expect &&
+refs/cvs/$GITREMOTE/HEAD changed
+
+EOF
+	test_cmp expect actual
+
+'
+
+test_expect_success '#2: git-vcs-cvs "import" command' '
+
+	echo "import refs/cvs/$GITREMOTE/HEAD" | git vcs-cvs "$GITREMOTE" > actual &&
+	cat <<EOF >expect &&
+# Importing CVS revision o_fortuna:1.2
+blob
+mark :8
+data 179
+O Fortune,
+like the moon
+you are changeable,
+
+ever waxing
+and waning;
+hateful life
+
+first oppresses
+and then soothes
+as fancy takes it;
+
+poverty
+and power
+it melts them like ice.
+
+commit refs/cvs/$GITREMOTE/HEAD
+mark :9
+data 44
+translate to English
+
+My Latin is terrible.
+
+from refs/cvs/$GITREMOTE/HEAD^0
+M 644 :8 o_fortuna
+
+# Importing note for object 9
+blob
+mark :10
+data 14
+o_fortuna:1.2
+
+commit refs/notes/cvs/$GITREMOTE
+mark :11
+data 43
+Annotate commits imported by "git vcs-cvs"
+
+from refs/notes/cvs/$GITREMOTE^0
+M 644 :10 :9
+
+blob
+mark :12
+data 32
+8 o_fortuna:1.2
+9 o_fortuna:1.2
+
+blob
+mark :13
+data 94
+
+blob
+mark :14
+data 16
+blob 8
+commit 9
+
+commit refs/cvs/$GITREMOTE/_metadata
+mark :15
+data 39
+Updated metadata used by "git vcs-cvs"
+
+from refs/cvs/$GITREMOTE/_metadata^0
+M 644 :12 CVS/marks
+M 644 :13 o_fortuna/1.1
+M 644 :14 o_fortuna/1.2
+
+EOF
+	grep -v -e "^committer " -e "\b[0-9a-f]\{40\}\b" actual > actual.filtered &&
+	test_cmp expect actual.filtered
+
+'
+
+test_expect_success '#2: Passing git-vcs-cvs output to git-fast-import' '
+
+	git fast-import --quiet \
+		--import-marks=".git/info/cvs/$GITREMOTE/marks" \
+		--export-marks=".git/info/cvs/$GITREMOTE/marks" \
+		< actual &&
+	git gc
+
+'
+
+test_expect_success '#2: Verifying correctness of import' '
+
+	echo "verify HEAD" | git vcs-cvs "$GITREMOTE"
+
+'
+
+test_expect_success '#3: update cvs module' '
+
+	(
+		cd module-cvs &&
+		echo 1 >tick &&
+		$CVS add tick &&
+		$CVS commit -f -m 1 tick
+	)
+
+'
+
+test_expect_success '#3: git-vcs-cvs "capabilities" command' '
+
+	echo "capabilities" | git vcs-cvs "$GITREMOTE" > actual &&
+	cat <<EOF >expect &&
+marks .git/info/cvs/$GITREMOTE/marks
+
+EOF
+	test_cmp expect actual
+
+'
+
+test_expect_success '#3: git-vcs-cvs "list" command' '
+
+	echo "list" | git vcs-cvs "$GITREMOTE" > actual &&
+	cat <<EOF >expect &&
+refs/cvs/$GITREMOTE/HEAD changed
+
+EOF
+	test_cmp expect actual
+
+'
+
+test_expect_success '#3: git-vcs-cvs "import" command' '
+
+	echo "import refs/cvs/$GITREMOTE/HEAD" | git vcs-cvs "$GITREMOTE" > actual &&
+	cat <<EOF >expect &&
+# Importing CVS revision tick:1.1
+blob
+mark :16
+data 2
+1
+
+commit refs/cvs/$GITREMOTE/HEAD
+mark :17
+data 2
+1
+
+from refs/cvs/$GITREMOTE/HEAD^0
+M 644 :16 tick
+
+# Importing note for object 17
+blob
+mark :18
+data 23
+o_fortuna:1.2
+tick:1.1
+
+commit refs/notes/cvs/$GITREMOTE
+mark :19
+data 43
+Annotate commits imported by "git vcs-cvs"
+
+from refs/notes/cvs/$GITREMOTE^0
+M 644 :18 :17
+
+blob
+mark :20
+data 41
+16 tick:1.1
+17 tick:1.1
+17 o_fortuna:1.2
+
+blob
+mark :21
+data 104
+commit 17
+
+blob
+mark :22
+data 18
+blob 16
+commit 17
+
+commit refs/cvs/$GITREMOTE/_metadata
+mark :23
+data 39
+Updated metadata used by "git vcs-cvs"
+
+from refs/cvs/$GITREMOTE/_metadata^0
+M 644 :20 CVS/marks
+M 644 :21 o_fortuna/1.2
+M 644 :22 tick/1.1
+
+EOF
+	grep -v -e "^committer " -e "\b[0-9a-f]\{40\}\b" actual > actual.filtered &&
+	test_cmp expect actual.filtered
+
+'
+
+test_expect_success '#3: Passing git-vcs-cvs output to git-fast-import' '
+
+	git fast-import --quiet \
+		--import-marks=".git/info/cvs/$GITREMOTE/marks" \
+		--export-marks=".git/info/cvs/$GITREMOTE/marks" \
+		< actual &&
+	git gc
+
+'
+
+test_expect_success '#3: Verifying correctness of import' '
+
+	echo "verify HEAD" | git vcs-cvs "$GITREMOTE"
+
+'
+
+test_expect_success '#4: git-vcs-cvs "capabilities" command' '
+
+	echo "capabilities" | git vcs-cvs "$GITREMOTE" > actual &&
+	cat <<EOF >expect &&
+marks .git/info/cvs/$GITREMOTE/marks
+
+EOF
+	test_cmp expect actual
+
+'
+
+test_expect_success '#4: git-vcs-cvs "list" command' '
+
+	echo "list" | git vcs-cvs "$GITREMOTE" > actual &&
+	cat <<EOF >expect &&
+refs/cvs/$GITREMOTE/HEAD unchanged
+
+EOF
+	test_cmp expect actual
+
+'
+
+test_expect_success '#4: git-vcs-cvs "import" command' '
+
+	echo "import refs/cvs/$GITREMOTE/HEAD" | git vcs-cvs "$GITREMOTE" > actual &&
+	cat <<EOF >expect &&
+blob
+mark :24
+data 0
+
+blob
+mark :25
+data 142
+
+blob
+mark :26
+data 94
+
+commit refs/cvs/$GITREMOTE/_metadata
+mark :27
+data 39
+Updated metadata used by "git vcs-cvs"
+
+from refs/cvs/$GITREMOTE/_metadata^0
+M 644 :24 CVS/marks
+M 644 :25 o_fortuna/1.2
+M 644 :26 tick/1.1
+
+EOF
+	grep -v -e "^committer " -e "\b[0-9a-f]\{40\}\b" actual > actual.filtered &&
+	test_cmp expect actual.filtered
+
+'
+
+test_expect_success '#4: Passing git-vcs-cvs output to git-fast-import' '
+
+	git fast-import --quiet \
+		--import-marks=".git/info/cvs/$GITREMOTE/marks" \
+		--export-marks=".git/info/cvs/$GITREMOTE/marks" \
+		< actual &&
+	git gc
+
+'
+
+test_expect_success '#4: Verifying correctness of import' '
+
+	echo "verify HEAD" | git vcs-cvs "$GITREMOTE"
+
+'
+
+test_done
diff --git a/t/t9801-foreign-vcs-cvs-fetch.sh b/t/t9801-foreign-vcs-cvs-fetch.sh
new file mode 100755
index 0000000..62a2325
--- /dev/null
+++ b/t/t9801-foreign-vcs-cvs-fetch.sh
@@ -0,0 +1,291 @@
+#!/bin/sh
+
+test_description='git vcs-cvs basic tests'
+. ./test-lib.sh
+
+if ! test_have_prereq PYTHON; then
+	say 'skipping CVS foreign-vcs helper tests, python not available'
+	test_done
+fi
+
+CVS_EXEC=cvs
+CVS_OPTS="-f -q"
+CVS="$CVS_EXEC $CVS_OPTS"
+
+CVSROOT=$(pwd)/cvsroot
+export CVSROOT
+unset CVS_SERVER
+
+CVSMODULE=cvsmodule
+GITREMOTE=cvsremote
+
+if ! type $CVS_EXEC >/dev/null 2>&1
+then
+	say 'skipping vcs-cvs tests, $CVS_EXEC not found'
+	test_done
+fi
+
+verify () {
+	git log --reverse --format="--- %T%n%s%n%n%b" "$GITREMOTE/$1" >actual &&
+	test_cmp "expect.$1" actual &&
+	echo "verify $1" | git vcs-cvs "$GITREMOTE"
+}
+
+test_expect_success 'setup CVS repo' '$CVS init'
+
+test_expect_success 'create CVS module with initial commit' '
+
+	mkdir "$CVSROOT/$CVSMODULE" &&
+	$CVS co -d module-cvs $CVSMODULE &&
+	(
+		cd module-cvs &&
+		cat <<EOF >o_fortuna &&
+O Fortuna
+velut luna
+statu variabilis,
+
+semper crescis
+aut decrescis;
+vita detestabilis
+
+nunc obdurat
+et tunc curat
+ludo mentis aciem,
+
+egestatem,
+potestatem
+dissolvit ut glaciem.
+EOF
+		$CVS add o_fortuna &&
+		cat <<EOF >message &&
+add "O Fortuna" lyrics
+
+These public domain lyrics make an excellent sample text.
+EOF
+		$CVS commit -f -F message o_fortuna
+	)
+'
+
+test_expect_success 'set up CVS repo/module as a foreign remote' '
+
+	git config "user.name" "Test User"
+	git config "user.email" "test@example.com"
+	git config "remote.$GITREMOTE.vcs" cvs
+	git config "remote.$GITREMOTE.cvsRoot" "$CVSROOT"
+	git config "remote.$GITREMOTE.cvsModule" "$CVSMODULE"
+	git config "remote.$GITREMOTE.fetch" \
+		"+refs/cvs/$GITREMOTE/*:refs/remotes/$GITREMOTE/*"
+
+'
+
+test_expect_success 'initial fetch from CVS remote' '
+
+	cat <<EOF >expect.HEAD &&
+--- 0e06d780dedab23e683c686fb041daa9a84c936c
+add "O Fortuna" lyrics
+
+These public domain lyrics make an excellent sample text.
+
+EOF
+	git fetch "$GITREMOTE" &&
+	verify HEAD
+
+'
+
+test_expect_success 'CVS commit' '
+
+	(
+		cd module-cvs &&
+		cat <<EOF >o_fortuna &&
+O Fortune,
+like the moon
+you are changeable,
+
+ever waxing
+and waning;
+hateful life
+
+first oppresses
+and then soothes
+as fancy takes it;
+
+poverty
+and power
+it melts them like ice.
+EOF
+		cat <<EOF >message &&
+translate to English
+
+My Latin is terrible.
+EOF
+		$CVS commit -f -F message o_fortuna
+	) &&
+	cat <<EOF >>expect.HEAD &&
+--- daa87269a5e00388135ad9542dc16ab6754466e5
+translate to English
+
+My Latin is terrible.
+
+EOF
+	git fetch "$GITREMOTE" &&
+	verify HEAD
+
+'
+
+test_expect_success 'CVS commit with new file' '
+
+	(
+		cd module-cvs &&
+		echo 1 >tick &&
+		$CVS add tick &&
+		$CVS commit -f -m 1 tick
+	) &&
+	cat <<EOF >>expect.HEAD &&
+--- 486935b4fccecea9b64cbed3a797ebbcbe2b7461
+1
+
+
+EOF
+	git fetch "$GITREMOTE" &&
+	verify HEAD
+
+'
+
+test_expect_success 'fetch without CVS changes' '
+
+	git fetch "$GITREMOTE" &&
+	verify HEAD
+
+'
+
+test_expect_success 'add 2 CVS commits' '
+
+	(
+		cd module-cvs &&
+		echo 2 >tick &&
+		$CVS commit -f -m 2 tick &&
+		echo 3 >tick &&
+		$CVS commit -f -m 3 tick
+	) &&
+	cat <<EOF >>expect.HEAD &&
+--- 83437ab3e57bf0a42915de5310e3419792b5a36f
+2
+
+
+--- 60fc50406a82dc6bd32dc6e5f7bd23e4c3cdf7ef
+3
+
+
+EOF
+	git fetch "$GITREMOTE" &&
+	verify HEAD
+
+'
+
+test_expect_success 'CVS commit with removed file' '
+
+	(
+		cd module-cvs &&
+		$CVS remove -f tick &&
+		$CVS commit -f -m "remove file" tick
+	) &&
+	cat <<EOF >>expect.HEAD &&
+--- daa87269a5e00388135ad9542dc16ab6754466e5
+remove file
+
+
+EOF
+	git fetch "$GITREMOTE" &&
+	verify HEAD
+
+'
+
+test_expect_success 'CVS commit with several new files' '
+
+	(
+		cd module-cvs &&
+		echo spam >spam &&
+		echo sausage >sausage &&
+		echo eggs >eggs &&
+		$CVS add spam sausage eggs &&
+		$CVS commit -f -m "spam, sausage, and eggs" spam sausage eggs
+	) &&
+	cat <<EOF >>expect.HEAD &&
+--- 3190dfce44a6d5e9916b4870dbf8f37d1ca4ddaf
+spam, sausage, and eggs
+
+
+EOF
+	git fetch "$GITREMOTE" &&
+	verify HEAD
+
+'
+
+test_expect_success 'new CVS branch' '
+
+	(
+		cd module-cvs &&
+		$CVS tag -b foo
+	) &&
+	cp expect.HEAD expect.foo &&
+	git fetch "$GITREMOTE" &&
+	verify HEAD &&
+	verify foo
+
+'
+
+test_expect_success 'CVS commit on branch' '
+
+	(
+		cd module-cvs &&
+		$CVS up -r foo &&
+		echo "spam spam spam" >spam &&
+		$CVS commit -f -m "commit on branch foo" spam
+	) &&
+	cat <<EOF >>expect.foo &&
+--- 1aba123e5c83898ce3a8b976cc6064d60246aef4
+commit on branch foo
+
+
+EOF
+	git fetch "$GITREMOTE" &&
+	verify HEAD &&
+	verify foo
+
+'
+
+test_expect_success 'create CVS tag' '
+
+	(
+		cd module-cvs &&
+		$CVS tag bar
+	) &&
+	cp expect.foo expect.bar &&
+	git fetch "$GITREMOTE" &&
+	verify HEAD &&
+	verify foo &&
+	verify bar
+
+'
+
+test_expect_success 'another CVS commit on branch' '
+
+	(
+		cd module-cvs &&
+		echo "spam spam spam spam spam spam" >> spam &&
+		$CVS commit -f -m "another commit on branch foo" spam
+	) &&
+	cat <<EOF >>expect.foo &&
+--- 15a2635e76e8e5a5a8746021643de317452f2340
+another commit on branch foo
+
+
+EOF
+	git fetch "$GITREMOTE" &&
+	verify HEAD &&
+	verify foo &&
+	verify bar
+
+'
+
+test_done
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 5fdc5d9..8eb8b95 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -706,6 +706,7 @@ case $(uname -s) in
 esac
 
 test -z "$NO_PERL" && test_set_prereq PERL
+test -z "$NO_PYTHON" && test_set_prereq PYTHON
 
 # test whether the filesystem supports symbolic links
 ln -s x y 2>/dev/null && test -h y 2>/dev/null && test_set_prereq SYMLINKS
-- 
1.6.4.rc3.138.ga6b98.dirty
