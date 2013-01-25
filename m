From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [RFC] test-lint-duplicates: check numbering in contrib/remote-helpers
Date: Fri, 25 Jan 2013 23:34:24 +0100
Message-ID: <201301252334.25283.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 25 23:36:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tyrsj-0002JC-SX
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 23:36:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753770Ab3AYWf6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jan 2013 17:35:58 -0500
Received: from mout.web.de ([212.227.17.11]:53026 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753652Ab3AYWf4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jan 2013 17:35:56 -0500
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0LvB2o-1Uy9k30c5K-00zknp; Fri, 25 Jan 2013 23:35:53 +0100
X-Provags-ID: V02:K0:0qX7zDA+da2CQSr5gMVyoqJMYEXyIM4U0UbwkdPfyko
 xub327DBfhDjcRybpV6SgkhpdJgH37jDmpk+luvj8a3AF5u68X
 H6BBvHrz4PaY/e+tsrHzpmyA66GfvN+Dm6JZo0z9gG4KCQ2L4O
 mHdQBv4n3zK7Fr3aSa9jZ/gUGj2zkz+JhreL+D7u301VxQwlSO
 sbVO9M12sti97mFTwvG5Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214593>

Running make inside contrib/remote-helpers failes in "test-lint-duplica=
tes"

This was because the regexp to check for duplicate numbers strips every=
thing
after the first "-" in the filename, including the prefix.

As a result, 2 pathnames like
"xxxx/contrib/remote-helpers/test-bzr.sh" and
"xxxx/contrib/remote-helpers/test-hg-bidi.sh"
are both converted into
"xxxx/contrib/remote" and reported as duplicate.

Improve the regexp:
Remove everything after "tNNNN-" (where X stand for a digit)

Rename the tests in contrib/remote-helpers into
t5810-test-bzr.sh,
t5820-test-hg-bidi.sh,
t5821-test-hg-hg-git.sh,
t5830-test-hg.sh

=46eed the numbers used in contrib/remote-helpers into t/Makefile
and check that the numbering is unique across both directories

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 contrib/remote-helpers/Makefile                |   3 +-
 contrib/remote-helpers/t5810-test-bzr.sh       | 143 +++++++
 contrib/remote-helpers/t5820-test-hg-bidi.sh   | 243 +++++++++++
 contrib/remote-helpers/t5821-test-hg-hg-git.sh | 534 +++++++++++++++++=
++++++++
 contrib/remote-helpers/t5830-test-hg.sh        | 121 ++++++
 contrib/remote-helpers/test-bzr.sh             | 143 -------
 contrib/remote-helpers/test-hg-bidi.sh         | 243 -----------
 contrib/remote-helpers/test-hg-hg-git.sh       | 534 -----------------=
--------
 contrib/remote-helpers/test-hg.sh              | 121 ------
 t/Makefile                                     |   2 +-
 10 files changed, 1044 insertions(+), 1043 deletions(-)
 create mode 100755 contrib/remote-helpers/t5810-test-bzr.sh
 create mode 100755 contrib/remote-helpers/t5820-test-hg-bidi.sh
 create mode 100755 contrib/remote-helpers/t5821-test-hg-hg-git.sh
 create mode 100755 contrib/remote-helpers/t5830-test-hg.sh
 delete mode 100755 contrib/remote-helpers/test-bzr.sh
 delete mode 100755 contrib/remote-helpers/test-hg-bidi.sh
 delete mode 100755 contrib/remote-helpers/test-hg-hg-git.sh
 delete mode 100755 contrib/remote-helpers/test-hg.sh

diff --git a/contrib/remote-helpers/Makefile b/contrib/remote-helpers/M=
akefile
index 9a76575..012ad50 100644
--- a/contrib/remote-helpers/Makefile
+++ b/contrib/remote-helpers/Makefile
@@ -1,6 +1,7 @@
-TESTS :=3D $(wildcard test*.sh)
+TESTS :=3D $(sort $(wildcard t[0-9][0-9][0-9][0-9]-*.sh))
=20
 export T :=3D $(addprefix $(CURDIR)/,$(TESTS))
+export TDUP :=3D $(sort $(wildcard ../../t/t[0-9][0-9][0-9][0-9]-*.sh)=
)
 export MAKE :=3D $(MAKE) -e
 export PATH :=3D $(CURDIR):$(PATH)
=20
diff --git a/contrib/remote-helpers/t5810-test-bzr.sh b/contrib/remote-=
helpers/t5810-test-bzr.sh
new file mode 100755
index 0000000..70aa8a0
--- /dev/null
+++ b/contrib/remote-helpers/t5810-test-bzr.sh
@@ -0,0 +1,143 @@
+#!/bin/sh
+#
+# Copyright (c) 2012 Felipe Contreras
+#
+
+test_description=3D'Test remote-bzr'
+
+. ./test-lib.sh
+
+if ! test_have_prereq PYTHON; then
+	skip_all=3D'skipping remote-bzr tests; python not available'
+	test_done
+fi
+
+if ! "$PYTHON_PATH" -c 'import bzrlib'; then
+	skip_all=3D'skipping remote-bzr tests; bzr not available'
+	test_done
+fi
+
+cmd=3D'
+import bzrlib
+bzrlib.initialize()
+import bzrlib.plugin
+bzrlib.plugin.load_plugins()
+import bzrlib.plugins.fastimport
+'
+
+if ! "$PYTHON_PATH" -c "$cmd"; then
+	echo "consider setting BZR_PLUGIN_PATH=3D$HOME/.bazaar/plugins" 1>&2
+	skip_all=3D'skipping remote-bzr tests; bzr-fastimport not available'
+	test_done
+fi
+
+check () {
+	(cd $1 &&
+	git log --format=3D'%s' -1 &&
+	git symbolic-ref HEAD) > actual &&
+	(echo $2 &&
+	echo "refs/heads/$3") > expected &&
+	test_cmp expected actual
+}
+
+bzr whoami "A U Thor <author@example.com>"
+
+test_expect_success 'cloning' '
+  (bzr init bzrrepo &&
+  cd bzrrepo &&
+  echo one > content &&
+  bzr add content &&
+  bzr commit -m one
+  ) &&
+
+  git clone "bzr::$PWD/bzrrepo" gitrepo &&
+  check gitrepo one master
+'
+
+test_expect_success 'pulling' '
+  (cd bzrrepo &&
+  echo two > content &&
+  bzr commit -m two
+  ) &&
+
+  (cd gitrepo && git pull) &&
+
+  check gitrepo two master
+'
+
+test_expect_success 'pushing' '
+  (cd gitrepo &&
+  echo three > content &&
+  git commit -a -m three &&
+  git push
+  ) &&
+
+  echo three > expected &&
+  cat bzrrepo/content > actual &&
+  test_cmp expected actual
+'
+
+test_expect_success 'roundtrip' '
+  (cd gitrepo &&
+  git pull &&
+  git log --format=3D"%s" -1 origin/master > actual) &&
+  echo three > expected &&
+  test_cmp expected actual &&
+
+  (cd gitrepo && git push && git pull) &&
+
+  (cd bzrrepo &&
+  echo four > content &&
+  bzr commit -m four
+  ) &&
+
+  (cd gitrepo && git pull && git push) &&
+
+  check gitrepo four master &&
+
+  (cd gitrepo &&
+  echo five > content &&
+  git commit -a -m five &&
+  git push && git pull
+  ) &&
+
+  (cd bzrrepo && bzr revert) &&
+
+  echo five > expected &&
+  cat bzrrepo/content > actual &&
+  test_cmp expected actual
+'
+
+cat > expected <<EOF
+100644 blob 54f9d6da5c91d556e6b54340b1327573073030af	content
+100755 blob 68769579c3eaadbe555379b9c3538e6628bae1eb	executable
+120000 blob 6b584e8ece562ebffc15d38808cd6b98fc3d97ea	link
+EOF
+
+test_expect_success 'special modes' '
+  (cd bzrrepo &&
+  echo exec > executable
+  chmod +x executable &&
+  bzr add executable
+  bzr commit -m exec &&
+  ln -s content link
+  bzr add link
+  bzr commit -m link &&
+  mkdir dir &&
+  bzr add dir &&
+  bzr commit -m dir) &&
+
+  (cd gitrepo &&
+  git pull
+  git ls-tree HEAD > ../actual) &&
+
+  test_cmp expected actual &&
+
+  (cd gitrepo &&
+  git cat-file -p HEAD:link > ../actual) &&
+
+  echo -n content > expected &&
+  test_cmp expected actual
+'
+
+test_done
diff --git a/contrib/remote-helpers/t5820-test-hg-bidi.sh b/contrib/rem=
ote-helpers/t5820-test-hg-bidi.sh
new file mode 100755
index 0000000..1d61982
--- /dev/null
+++ b/contrib/remote-helpers/t5820-test-hg-bidi.sh
@@ -0,0 +1,243 @@
+#!/bin/sh
+#
+# Copyright (c) 2012 Felipe Contreras
+#
+# Base commands from hg-git tests:
+# https://bitbucket.org/durin42/hg-git/src
+#
+
+test_description=3D'Test bidirectionality of remote-hg'
+
+. ./test-lib.sh
+
+if ! test_have_prereq PYTHON; then
+	skip_all=3D'skipping remote-hg tests; python not available'
+	test_done
+fi
+
+if ! "$PYTHON_PATH" -c 'import mercurial'; then
+	skip_all=3D'skipping remote-hg tests; mercurial not available'
+	test_done
+fi
+
+# clone to a git repo
+git_clone () {
+	hg -R $1 bookmark -f -r tip master &&
+	git clone -q "hg::$PWD/$1" $2
+}
+
+# clone to an hg repo
+hg_clone () {
+	(
+	hg init $2 &&
+	cd $1 &&
+	git push -q "hg::$PWD/../$2" 'refs/tags/*:refs/tags/*' 'refs/heads/*:=
refs/heads/*'
+	) &&
+
+	(cd $2 && hg -q update)
+}
+
+# push an hg repo
+hg_push () {
+	(
+	cd $2
+	old=3D$(git symbolic-ref --short HEAD)
+	git checkout -q -b tmp &&
+	git fetch -q "hg::$PWD/../$1" 'refs/tags/*:refs/tags/*' 'refs/heads/*=
:refs/heads/*' &&
+	git checkout -q $old &&
+	git branch -q -D tmp 2> /dev/null || true
+	)
+}
+
+hg_log () {
+	hg -R $1 log --graph --debug | grep -v 'tag: *default/'
+}
+
+setup () {
+	(
+	echo "[ui]"
+	echo "username =3D A U Thor <author@example.com>"
+	echo "[defaults]"
+	echo "backout =3D -d \"0 0\""
+	echo "commit =3D -d \"0 0\""
+	echo "debugrawcommit =3D -d \"0 0\""
+	echo "tag =3D -d \"0 0\""
+	) >> "$HOME"/.hgrc &&
+	git config --global remote-hg.hg-git-compat true
+
+	export HGEDITOR=3D/usr/bin/true
+
+	export GIT_AUTHOR_DATE=3D"2007-01-01 00:00:00 +0230"
+	export GIT_COMMITTER_DATE=3D"$GIT_AUTHOR_DATE"
+}
+
+setup
+
+test_expect_success 'encoding' '
+	mkdir -p tmp && cd tmp &&
+	test_when_finished "cd .. && rm -rf tmp" &&
+
+	(
+	git init -q gitrepo &&
+	cd gitrepo &&
+
+	echo alpha > alpha &&
+	git add alpha &&
+	git commit -m "add =C3=A4lph=C3=A0" &&
+
+	export GIT_AUTHOR_NAME=3D"t=C3=A9st =C3=A8nc=C3=B6d=C3=AEng" &&
+	echo beta > beta &&
+	git add beta &&
+	git commit -m "add beta" &&
+
+	echo gamma > gamma &&
+	git add gamma &&
+	git commit -m "add g=C3=A4mm=C3=A2" &&
+
+	: TODO git config i18n.commitencoding latin-1 &&
+	echo delta > delta &&
+	git add delta &&
+	git commit -m "add d=C3=A9lt=C3=A0"
+	) &&
+
+	hg_clone gitrepo hgrepo &&
+	git_clone hgrepo gitrepo2 &&
+	hg_clone gitrepo2 hgrepo2 &&
+
+	HGENCODING=3Dutf-8 hg_log hgrepo > expected &&
+	HGENCODING=3Dutf-8 hg_log hgrepo2 > actual &&
+
+	test_cmp expected actual
+'
+
+test_expect_success 'file removal' '
+	mkdir -p tmp && cd tmp &&
+	test_when_finished "cd .. && rm -rf tmp" &&
+
+	(
+	git init -q gitrepo &&
+	cd gitrepo &&
+	echo alpha > alpha &&
+	git add alpha &&
+	git commit -m "add alpha" &&
+	echo beta > beta &&
+	git add beta &&
+	git commit -m "add beta"
+	mkdir foo &&
+	echo blah > foo/bar &&
+	git add foo &&
+	git commit -m "add foo" &&
+	git rm alpha &&
+	git commit -m "remove alpha" &&
+	git rm foo/bar &&
+	git commit -m "remove foo/bar"
+	) &&
+
+	hg_clone gitrepo hgrepo &&
+	git_clone hgrepo gitrepo2 &&
+	hg_clone gitrepo2 hgrepo2 &&
+
+	hg_log hgrepo > expected &&
+	hg_log hgrepo2 > actual &&
+
+	test_cmp expected actual
+'
+
+test_expect_success 'git tags' '
+	mkdir -p tmp && cd tmp &&
+	test_when_finished "cd .. && rm -rf tmp" &&
+
+	(
+	git init -q gitrepo &&
+	cd gitrepo &&
+	git config receive.denyCurrentBranch ignore &&
+	echo alpha > alpha &&
+	git add alpha &&
+	git commit -m "add alpha" &&
+	git tag alpha &&
+
+	echo beta > beta &&
+	git add beta &&
+	git commit -m "add beta" &&
+	git tag -a -m "added tag beta" beta
+	) &&
+
+	hg_clone gitrepo hgrepo &&
+	git_clone hgrepo gitrepo2 &&
+	hg_clone gitrepo2 hgrepo2 &&
+
+	hg_log hgrepo > expected &&
+	hg_log hgrepo2 > actual &&
+
+	test_cmp expected actual
+'
+
+test_expect_success 'hg branch' '
+	mkdir -p tmp && cd tmp &&
+	test_when_finished "cd .. && rm -rf tmp" &&
+
+	(
+	git init -q gitrepo &&
+	cd gitrepo &&
+
+	echo alpha > alpha &&
+	git add alpha &&
+	git commit -q -m "add alpha" &&
+	git checkout -q -b not-master
+	) &&
+
+	(
+	hg_clone gitrepo hgrepo &&
+
+	cd hgrepo &&
+	hg -q co master &&
+	hg mv alpha beta &&
+	hg -q commit -m "rename alpha to beta" &&
+	hg branch gamma | grep -v "permanent and global" &&
+	hg -q commit -m "started branch gamma"
+	) &&
+
+	hg_push hgrepo gitrepo &&
+	hg_clone gitrepo hgrepo2 &&
+
+	: TODO, avoid "master" bookmark &&
+	(cd hgrepo2 && hg checkout gamma) &&
+
+	hg_log hgrepo > expected &&
+	hg_log hgrepo2 > actual &&
+
+	test_cmp expected actual
+'
+
+test_expect_success 'hg tags' '
+	mkdir -p tmp && cd tmp &&
+	test_when_finished "cd .. && rm -rf tmp" &&
+
+	(
+	git init -q gitrepo &&
+	cd gitrepo &&
+
+	echo alpha > alpha &&
+	git add alpha &&
+	git commit -m "add alpha" &&
+	git checkout -q -b not-master
+	) &&
+
+	(
+	hg_clone gitrepo hgrepo &&
+
+	cd hgrepo &&
+	hg co master &&
+	hg tag alpha
+	) &&
+
+	hg_push hgrepo gitrepo &&
+	hg_clone gitrepo hgrepo2 &&
+
+	hg_log hgrepo > expected &&
+	hg_log hgrepo2 > actual &&
+
+	test_cmp expected actual
+'
+
+test_done
diff --git a/contrib/remote-helpers/t5821-test-hg-hg-git.sh b/contrib/r=
emote-helpers/t5821-test-hg-hg-git.sh
new file mode 100755
index 0000000..7e3967f
--- /dev/null
+++ b/contrib/remote-helpers/t5821-test-hg-hg-git.sh
@@ -0,0 +1,534 @@
+#!/bin/sh
+#
+# Copyright (c) 2012 Felipe Contreras
+#
+# Base commands from hg-git tests:
+# https://bitbucket.org/durin42/hg-git/src
+#
+
+test_description=3D'Test remote-hg output compared to hg-git'
+
+. ./test-lib.sh
+
+if ! test_have_prereq PYTHON; then
+	skip_all=3D'skipping remote-hg tests; python not available'
+	test_done
+fi
+
+if ! "$PYTHON_PATH" -c 'import mercurial'; then
+	skip_all=3D'skipping remote-hg tests; mercurial not available'
+	test_done
+fi
+
+if ! "$PYTHON_PATH" -c 'import hggit'; then
+	skip_all=3D'skipping remote-hg tests; hg-git not available'
+	test_done
+fi
+
+# clone to a git repo with git
+git_clone_git () {
+	hg -R $1 bookmark -f -r tip master &&
+	git clone -q "hg::$PWD/$1" $2
+}
+
+# clone to an hg repo with git
+hg_clone_git () {
+	(
+	hg init $2 &&
+	cd $1 &&
+	git push -q "hg::$PWD/../$2" 'refs/tags/*:refs/tags/*' 'refs/heads/*:=
refs/heads/*'
+	) &&
+
+	(cd $2 && hg -q update)
+}
+
+# clone to a git repo with hg
+git_clone_hg () {
+	(
+	git init -q $2 &&
+	cd $1 &&
+	hg bookmark -f -r tip master &&
+	hg -q push -r master ../$2 || true
+	)
+}
+
+# clone to an hg repo with hg
+hg_clone_hg () {
+	hg -q clone $1 $2
+}
+
+# push an hg repo with git
+hg_push_git () {
+	(
+	cd $2
+	old=3D$(git symbolic-ref --short HEAD)
+	git checkout -q -b tmp &&
+	git fetch -q "hg::$PWD/../$1" 'refs/tags/*:refs/tags/*' 'refs/heads/*=
:refs/heads/*' &&
+	git checkout -q $old &&
+	git branch -q -D tmp 2> /dev/null || true
+	)
+}
+
+# push an hg git repo with hg
+hg_push_hg () {
+	(
+	cd $1 &&
+	hg -q push ../$2 || true
+	)
+}
+
+hg_log () {
+	hg -R $1 log --graph --debug | grep -v 'tag: *default/'
+}
+
+git_log () {
+	git --git-dir=3D$1/.git fast-export --branches
+}
+
+setup () {
+	(
+	echo "[ui]"
+	echo "username =3D A U Thor <author@example.com>"
+	echo "[defaults]"
+	echo "backout =3D -d \"0 0\""
+	echo "commit =3D -d \"0 0\""
+	echo "debugrawcommit =3D -d \"0 0\""
+	echo "tag =3D -d \"0 0\""
+	echo "[extensions]"
+	echo "hgext.bookmarks =3D"
+	echo "hggit =3D"
+	) >> "$HOME"/.hgrc &&
+	git config --global receive.denycurrentbranch warn
+	git config --global remote-hg.hg-git-compat true
+
+	export HGEDITOR=3D/usr/bin/true
+
+	export GIT_AUTHOR_DATE=3D"2007-01-01 00:00:00 +0230"
+	export GIT_COMMITTER_DATE=3D"$GIT_AUTHOR_DATE"
+}
+
+setup
+
+test_expect_success 'executable bit' '
+	mkdir -p tmp && cd tmp &&
+	test_when_finished "cd .. && rm -rf tmp" &&
+
+	(
+	git init -q gitrepo &&
+	cd gitrepo &&
+	echo alpha > alpha &&
+	chmod 0644 alpha &&
+	git add alpha &&
+	git commit -m "add alpha" &&
+	chmod 0755 alpha &&
+	git add alpha &&
+	git commit -m "set executable bit" &&
+	chmod 0644 alpha &&
+	git add alpha &&
+	git commit -m "clear executable bit"
+	) &&
+
+	for x in hg git; do
+		(
+		hg_clone_$x gitrepo hgrepo-$x &&
+		cd hgrepo-$x &&
+		hg_log . &&
+		hg manifest -r 1 -v &&
+		hg manifest -v
+		) > output-$x &&
+
+		git_clone_$x hgrepo-$x gitrepo2-$x &&
+		git_log gitrepo2-$x > log-$x
+	done &&
+	cp -r log-* output-* /tmp/foo/ &&
+
+	test_cmp output-hg output-git &&
+	test_cmp log-hg log-git
+'
+
+test_expect_success 'symlink' '
+	mkdir -p tmp && cd tmp &&
+	test_when_finished "cd .. && rm -rf tmp" &&
+
+	(
+	git init -q gitrepo &&
+	cd gitrepo &&
+	echo alpha > alpha &&
+	git add alpha &&
+	git commit -m "add alpha" &&
+	ln -s alpha beta &&
+	git add beta &&
+	git commit -m "add beta"
+	) &&
+
+	for x in hg git; do
+		(
+		hg_clone_$x gitrepo hgrepo-$x &&
+		cd hgrepo-$x &&
+		hg_log . &&
+		hg manifest -v
+		) > output-$x &&
+
+		git_clone_$x hgrepo-$x gitrepo2-$x &&
+		git_log gitrepo2-$x > log-$x
+	done &&
+
+	test_cmp output-hg output-git &&
+	test_cmp log-hg log-git
+'
+
+test_expect_success 'merge conflict 1' '
+	mkdir -p tmp && cd tmp &&
+	test_when_finished "cd .. && rm -rf tmp" &&
+
+	(
+	hg init hgrepo1 &&
+	cd hgrepo1 &&
+	echo A > afile &&
+	hg add afile &&
+	hg ci -m "origin" &&
+
+	echo B > afile &&
+	hg ci -m "A->B" &&
+
+	hg up -r0 &&
+	echo C > afile &&
+	hg ci -m "A->C" &&
+
+	hg merge -r1 || true &&
+	echo C > afile &&
+	hg resolve -m afile &&
+	hg ci -m "merge to C"
+	) &&
+
+	for x in hg git; do
+		git_clone_$x hgrepo1 gitrepo-$x &&
+		hg_clone_$x gitrepo-$x hgrepo2-$x &&
+		hg_log hgrepo2-$x > hg-log-$x &&
+		git_log gitrepo-$x > git-log-$x
+	done &&
+
+	test_cmp hg-log-hg hg-log-git &&
+	test_cmp git-log-hg git-log-git
+'
+
+test_expect_success 'merge conflict 2' '
+	mkdir -p tmp && cd tmp &&
+	test_when_finished "cd .. && rm -rf tmp" &&
+
+	(
+	hg init hgrepo1 &&
+	cd hgrepo1 &&
+	echo A > afile &&
+	hg add afile &&
+	hg ci -m "origin" &&
+
+	echo B > afile &&
+	hg ci -m "A->B" &&
+
+	hg up -r0 &&
+	echo C > afile &&
+	hg ci -m "A->C" &&
+
+	hg merge -r1 || true &&
+	echo B > afile &&
+	hg resolve -m afile &&
+	hg ci -m "merge to B"
+	) &&
+
+	for x in hg git; do
+		git_clone_$x hgrepo1 gitrepo-$x &&
+		hg_clone_$x gitrepo-$x hgrepo2-$x &&
+		hg_log hgrepo2-$x > hg-log-$x &&
+		git_log gitrepo-$x > git-log-$x
+	done &&
+
+	test_cmp hg-log-hg hg-log-git &&
+	test_cmp git-log-hg git-log-git
+'
+
+test_expect_success 'converged merge' '
+	mkdir -p tmp && cd tmp &&
+	test_when_finished "cd .. && rm -rf tmp" &&
+
+	(
+	hg init hgrepo1 &&
+	cd hgrepo1 &&
+	echo A > afile &&
+	hg add afile &&
+	hg ci -m "origin" &&
+
+	echo B > afile &&
+	hg ci -m "A->B" &&
+
+	echo C > afile &&
+	hg ci -m "B->C" &&
+
+	hg up -r0 &&
+	echo C > afile &&
+	hg ci -m "A->C" &&
+
+	hg merge -r2 || true &&
+	hg ci -m "merge"
+	) &&
+
+	for x in hg git; do
+		git_clone_$x hgrepo1 gitrepo-$x &&
+		hg_clone_$x gitrepo-$x hgrepo2-$x &&
+		hg_log hgrepo2-$x > hg-log-$x &&
+		git_log gitrepo-$x > git-log-$x
+	done &&
+
+	test_cmp hg-log-hg hg-log-git &&
+	test_cmp git-log-hg git-log-git
+'
+
+test_expect_success 'encoding' '
+	mkdir -p tmp && cd tmp &&
+	test_when_finished "cd .. && rm -rf tmp" &&
+
+	(
+	git init -q gitrepo &&
+	cd gitrepo &&
+
+	echo alpha > alpha &&
+	git add alpha &&
+	git commit -m "add =C3=A4lph=C3=A0" &&
+
+	export GIT_AUTHOR_NAME=3D"t=C3=A9st =C3=A8nc=C3=B6d=C3=AEng" &&
+	echo beta > beta &&
+	git add beta &&
+	git commit -m "add beta" &&
+
+	echo gamma > gamma &&
+	git add gamma &&
+	git commit -m "add g=C3=A4mm=C3=A2" &&
+
+	: TODO git config i18n.commitencoding latin-1 &&
+	echo delta > delta &&
+	git add delta &&
+	git commit -m "add d=C3=A9lt=C3=A0"
+	) &&
+
+	for x in hg git; do
+		hg_clone_$x gitrepo hgrepo-$x &&
+		git_clone_$x hgrepo-$x gitrepo2-$x &&
+
+		HGENCODING=3Dutf-8 hg_log hgrepo-$x > hg-log-$x &&
+		git_log gitrepo2-$x > git-log-$x
+	done &&
+
+	test_cmp hg-log-hg hg-log-git &&
+	test_cmp git-log-hg git-log-git
+'
+
+test_expect_success 'file removal' '
+	mkdir -p tmp && cd tmp &&
+	test_when_finished "cd .. && rm -rf tmp" &&
+
+	(
+	git init -q gitrepo &&
+	cd gitrepo &&
+	echo alpha > alpha &&
+	git add alpha &&
+	git commit -m "add alpha" &&
+	echo beta > beta &&
+	git add beta &&
+	git commit -m "add beta"
+	mkdir foo &&
+	echo blah > foo/bar &&
+	git add foo &&
+	git commit -m "add foo" &&
+	git rm alpha &&
+	git commit -m "remove alpha" &&
+	git rm foo/bar &&
+	git commit -m "remove foo/bar"
+	) &&
+
+	for x in hg git; do
+		(
+		hg_clone_$x gitrepo hgrepo-$x &&
+		cd hgrepo-$x &&
+		hg_log . &&
+		hg manifest -r 3 &&
+		hg manifest
+		) > output-$x &&
+
+		git_clone_$x hgrepo-$x gitrepo2-$x &&
+		git_log gitrepo2-$x > log-$x
+	done &&
+
+	test_cmp output-hg output-git &&
+	test_cmp log-hg log-git
+'
+
+test_expect_success 'git tags' '
+	mkdir -p tmp && cd tmp &&
+	test_when_finished "cd .. && rm -rf tmp" &&
+
+	(
+	git init -q gitrepo &&
+	cd gitrepo &&
+	git config receive.denyCurrentBranch ignore &&
+	echo alpha > alpha &&
+	git add alpha &&
+	git commit -m "add alpha" &&
+	git tag alpha &&
+
+	echo beta > beta &&
+	git add beta &&
+	git commit -m "add beta" &&
+	git tag -a -m "added tag beta" beta
+	) &&
+
+	for x in hg git; do
+		hg_clone_$x gitrepo hgrepo-$x &&
+		hg_log hgrepo-$x > log-$x
+	done &&
+
+	test_cmp log-hg log-git
+'
+
+test_expect_success 'hg author' '
+	mkdir -p tmp && cd tmp &&
+	test_when_finished "cd .. && rm -rf tmp" &&
+
+	for x in hg git; do
+		(
+		git init -q gitrepo-$x &&
+		cd gitrepo-$x &&
+
+		echo alpha > alpha &&
+		git add alpha &&
+		git commit -m "add alpha" &&
+		git checkout -q -b not-master
+		) &&
+
+		(
+		hg_clone_$x gitrepo-$x hgrepo-$x &&
+		cd hgrepo-$x &&
+
+		hg co master &&
+		echo beta > beta &&
+		hg add beta &&
+		hg commit -u "test" -m "add beta" &&
+
+		echo gamma >> beta &&
+		hg commit -u "test <test@example.com> (comment)" -m "modify beta" &&
+
+		echo gamma > gamma &&
+		hg add gamma &&
+		hg commit -u "<test@example.com>" -m "add gamma" &&
+
+		echo delta > delta &&
+		hg add delta &&
+		hg commit -u "name<test@example.com>" -m "add delta" &&
+
+		echo epsilon > epsilon &&
+		hg add epsilon &&
+		hg commit -u "name <test@example.com" -m "add epsilon" &&
+
+		echo zeta > zeta &&
+		hg add zeta &&
+		hg commit -u " test " -m "add zeta" &&
+
+		echo eta > eta &&
+		hg add eta &&
+		hg commit -u "test < test@example.com >" -m "add eta" &&
+
+		echo theta > theta &&
+		hg add theta &&
+		hg commit -u "test >test@example.com>" -m "add theta" &&
+
+		echo iota > iota &&
+		hg add iota &&
+		hg commit -u "test <test <at> example <dot> com>" -m "add iota"
+		) &&
+
+		hg_push_$x hgrepo-$x gitrepo-$x &&
+		hg_clone_$x gitrepo-$x hgrepo2-$x &&
+
+		hg_log hgrepo2-$x > hg-log-$x &&
+		git_log gitrepo-$x > git-log-$x
+	done &&
+
+	test_cmp git-log-hg git-log-git &&
+
+	test_cmp hg-log-hg hg-log-git &&
+	test_cmp git-log-hg git-log-git
+'
+
+test_expect_success 'hg branch' '
+	mkdir -p tmp && cd tmp &&
+	test_when_finished "cd .. && rm -rf tmp" &&
+
+	for x in hg git; do
+		(
+		git init -q gitrepo-$x &&
+		cd gitrepo-$x &&
+
+		echo alpha > alpha &&
+		git add alpha &&
+		git commit -q -m "add alpha" &&
+		git checkout -q -b not-master
+		) &&
+
+		(
+		hg_clone_$x gitrepo-$x hgrepo-$x &&
+
+		cd hgrepo-$x &&
+		hg -q co master &&
+		hg mv alpha beta &&
+		hg -q commit -m "rename alpha to beta" &&
+		hg branch gamma | grep -v "permanent and global" &&
+		hg -q commit -m "started branch gamma"
+		) &&
+
+		hg_push_$x hgrepo-$x gitrepo-$x &&
+		hg_clone_$x gitrepo-$x hgrepo2-$x &&
+
+		hg_log hgrepo2-$x > hg-log-$x &&
+		git_log gitrepo-$x > git-log-$x
+	done &&
+
+	test_cmp hg-log-hg hg-log-git &&
+	test_cmp git-log-hg git-log-git
+'
+
+test_expect_success 'hg tags' '
+	mkdir -p tmp && cd tmp &&
+	test_when_finished "cd .. && rm -rf tmp" &&
+
+	for x in hg git; do
+		(
+		git init -q gitrepo-$x &&
+		cd gitrepo-$x &&
+
+		echo alpha > alpha &&
+		git add alpha &&
+		git commit -m "add alpha" &&
+		git checkout -q -b not-master
+		) &&
+
+		(
+		hg_clone_$x gitrepo-$x hgrepo-$x &&
+
+		cd hgrepo-$x &&
+		hg co master &&
+		hg tag alpha
+		) &&
+
+		hg_push_$x hgrepo-$x gitrepo-$x &&
+		hg_clone_$x gitrepo-$x hgrepo2-$x &&
+
+		(
+		git --git-dir=3Dgitrepo-$x/.git tag -l &&
+		hg_log hgrepo2-$x &&
+		cat hgrepo2-$x/.hgtags
+		) > output-$x
+	done &&
+
+	test_cmp output-hg output-git
+'
+
+test_done
diff --git a/contrib/remote-helpers/t5830-test-hg.sh b/contrib/remote-h=
elpers/t5830-test-hg.sh
new file mode 100755
index 0000000..5f81dfa
--- /dev/null
+++ b/contrib/remote-helpers/t5830-test-hg.sh
@@ -0,0 +1,121 @@
+#!/bin/sh
+#
+# Copyright (c) 2012 Felipe Contreras
+#
+# Base commands from hg-git tests:
+# https://bitbucket.org/durin42/hg-git/src
+#
+
+test_description=3D'Test remote-hg'
+
+. ./test-lib.sh
+
+if ! test_have_prereq PYTHON; then
+	skip_all=3D'skipping remote-hg tests; python not available'
+	test_done
+fi
+
+if ! "$PYTHON_PATH" -c 'import mercurial'; then
+	skip_all=3D'skipping remote-hg tests; mercurial not available'
+	test_done
+fi
+
+check () {
+	(cd $1 &&
+	git log --format=3D'%s' -1 &&
+	git symbolic-ref HEAD) > actual &&
+	(echo $2 &&
+	echo "refs/heads/$3") > expected &&
+	test_cmp expected actual
+}
+
+setup () {
+	(
+	echo "[ui]"
+	echo "username =3D H G Wells <wells@example.com>"
+	) >> "$HOME"/.hgrc
+}
+
+setup
+
+test_expect_success 'cloning' '
+  test_when_finished "rm -rf gitrepo*" &&
+
+  (
+  hg init hgrepo &&
+  cd hgrepo &&
+  echo zero > content &&
+  hg add content &&
+  hg commit -m zero
+  ) &&
+
+  git clone "hg::$PWD/hgrepo" gitrepo &&
+  check gitrepo zero master
+'
+
+test_expect_success 'cloning with branches' '
+  test_when_finished "rm -rf gitrepo*" &&
+
+  (
+  cd hgrepo &&
+  hg branch next &&
+  echo next > content &&
+  hg commit -m next
+  ) &&
+
+  git clone "hg::$PWD/hgrepo" gitrepo &&
+  check gitrepo next next &&
+
+  (cd hgrepo && hg checkout default) &&
+
+  git clone "hg::$PWD/hgrepo" gitrepo2 &&
+  check gitrepo2 zero master
+'
+
+test_expect_success 'cloning with bookmarks' '
+  test_when_finished "rm -rf gitrepo*" &&
+
+  (
+  cd hgrepo &&
+  hg bookmark feature-a &&
+  echo feature-a > content &&
+  hg commit -m feature-a
+  ) &&
+
+  git clone "hg::$PWD/hgrepo" gitrepo &&
+  check gitrepo feature-a feature-a
+'
+
+test_expect_success 'cloning with detached head' '
+  test_when_finished "rm -rf gitrepo*" &&
+
+  (
+  cd hgrepo &&
+  hg update -r 0
+  ) &&
+
+  git clone "hg::$PWD/hgrepo" gitrepo &&
+  check gitrepo zero master
+'
+
+test_expect_success 'update bookmark' '
+  test_when_finished "rm -rf gitrepo*" &&
+
+  (
+  cd hgrepo &&
+  hg bookmark devel
+  ) &&
+
+  (
+  git clone "hg::$PWD/hgrepo" gitrepo &&
+  cd gitrepo &&
+  git checkout devel &&
+  echo devel > content &&
+  git commit -a -m devel &&
+  git push
+  ) &&
+
+  hg -R hgrepo bookmarks | grep "devel\s\+3:"
+'
+
+test_done
diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helper=
s/test-bzr.sh
deleted file mode 100755
index 70aa8a0..0000000
--- a/contrib/remote-helpers/test-bzr.sh
+++ /dev/null
@@ -1,143 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2012 Felipe Contreras
-#
-
-test_description=3D'Test remote-bzr'
-
-. ./test-lib.sh
-
-if ! test_have_prereq PYTHON; then
-	skip_all=3D'skipping remote-bzr tests; python not available'
-	test_done
-fi
-
-if ! "$PYTHON_PATH" -c 'import bzrlib'; then
-	skip_all=3D'skipping remote-bzr tests; bzr not available'
-	test_done
-fi
-
-cmd=3D'
-import bzrlib
-bzrlib.initialize()
-import bzrlib.plugin
-bzrlib.plugin.load_plugins()
-import bzrlib.plugins.fastimport
-'
-
-if ! "$PYTHON_PATH" -c "$cmd"; then
-	echo "consider setting BZR_PLUGIN_PATH=3D$HOME/.bazaar/plugins" 1>&2
-	skip_all=3D'skipping remote-bzr tests; bzr-fastimport not available'
-	test_done
-fi
-
-check () {
-	(cd $1 &&
-	git log --format=3D'%s' -1 &&
-	git symbolic-ref HEAD) > actual &&
-	(echo $2 &&
-	echo "refs/heads/$3") > expected &&
-	test_cmp expected actual
-}
-
-bzr whoami "A U Thor <author@example.com>"
-
-test_expect_success 'cloning' '
-  (bzr init bzrrepo &&
-  cd bzrrepo &&
-  echo one > content &&
-  bzr add content &&
-  bzr commit -m one
-  ) &&
-
-  git clone "bzr::$PWD/bzrrepo" gitrepo &&
-  check gitrepo one master
-'
-
-test_expect_success 'pulling' '
-  (cd bzrrepo &&
-  echo two > content &&
-  bzr commit -m two
-  ) &&
-
-  (cd gitrepo && git pull) &&
-
-  check gitrepo two master
-'
-
-test_expect_success 'pushing' '
-  (cd gitrepo &&
-  echo three > content &&
-  git commit -a -m three &&
-  git push
-  ) &&
-
-  echo three > expected &&
-  cat bzrrepo/content > actual &&
-  test_cmp expected actual
-'
-
-test_expect_success 'roundtrip' '
-  (cd gitrepo &&
-  git pull &&
-  git log --format=3D"%s" -1 origin/master > actual) &&
-  echo three > expected &&
-  test_cmp expected actual &&
-
-  (cd gitrepo && git push && git pull) &&
-
-  (cd bzrrepo &&
-  echo four > content &&
-  bzr commit -m four
-  ) &&
-
-  (cd gitrepo && git pull && git push) &&
-
-  check gitrepo four master &&
-
-  (cd gitrepo &&
-  echo five > content &&
-  git commit -a -m five &&
-  git push && git pull
-  ) &&
-
-  (cd bzrrepo && bzr revert) &&
-
-  echo five > expected &&
-  cat bzrrepo/content > actual &&
-  test_cmp expected actual
-'
-
-cat > expected <<EOF
-100644 blob 54f9d6da5c91d556e6b54340b1327573073030af	content
-100755 blob 68769579c3eaadbe555379b9c3538e6628bae1eb	executable
-120000 blob 6b584e8ece562ebffc15d38808cd6b98fc3d97ea	link
-EOF
-
-test_expect_success 'special modes' '
-  (cd bzrrepo &&
-  echo exec > executable
-  chmod +x executable &&
-  bzr add executable
-  bzr commit -m exec &&
-  ln -s content link
-  bzr add link
-  bzr commit -m link &&
-  mkdir dir &&
-  bzr add dir &&
-  bzr commit -m dir) &&
-
-  (cd gitrepo &&
-  git pull
-  git ls-tree HEAD > ../actual) &&
-
-  test_cmp expected actual &&
-
-  (cd gitrepo &&
-  git cat-file -p HEAD:link > ../actual) &&
-
-  echo -n content > expected &&
-  test_cmp expected actual
-'
-
-test_done
diff --git a/contrib/remote-helpers/test-hg-bidi.sh b/contrib/remote-he=
lpers/test-hg-bidi.sh
deleted file mode 100755
index 1d61982..0000000
--- a/contrib/remote-helpers/test-hg-bidi.sh
+++ /dev/null
@@ -1,243 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2012 Felipe Contreras
-#
-# Base commands from hg-git tests:
-# https://bitbucket.org/durin42/hg-git/src
-#
-
-test_description=3D'Test bidirectionality of remote-hg'
-
-. ./test-lib.sh
-
-if ! test_have_prereq PYTHON; then
-	skip_all=3D'skipping remote-hg tests; python not available'
-	test_done
-fi
-
-if ! "$PYTHON_PATH" -c 'import mercurial'; then
-	skip_all=3D'skipping remote-hg tests; mercurial not available'
-	test_done
-fi
-
-# clone to a git repo
-git_clone () {
-	hg -R $1 bookmark -f -r tip master &&
-	git clone -q "hg::$PWD/$1" $2
-}
-
-# clone to an hg repo
-hg_clone () {
-	(
-	hg init $2 &&
-	cd $1 &&
-	git push -q "hg::$PWD/../$2" 'refs/tags/*:refs/tags/*' 'refs/heads/*:=
refs/heads/*'
-	) &&
-
-	(cd $2 && hg -q update)
-}
-
-# push an hg repo
-hg_push () {
-	(
-	cd $2
-	old=3D$(git symbolic-ref --short HEAD)
-	git checkout -q -b tmp &&
-	git fetch -q "hg::$PWD/../$1" 'refs/tags/*:refs/tags/*' 'refs/heads/*=
:refs/heads/*' &&
-	git checkout -q $old &&
-	git branch -q -D tmp 2> /dev/null || true
-	)
-}
-
-hg_log () {
-	hg -R $1 log --graph --debug | grep -v 'tag: *default/'
-}
-
-setup () {
-	(
-	echo "[ui]"
-	echo "username =3D A U Thor <author@example.com>"
-	echo "[defaults]"
-	echo "backout =3D -d \"0 0\""
-	echo "commit =3D -d \"0 0\""
-	echo "debugrawcommit =3D -d \"0 0\""
-	echo "tag =3D -d \"0 0\""
-	) >> "$HOME"/.hgrc &&
-	git config --global remote-hg.hg-git-compat true
-
-	export HGEDITOR=3D/usr/bin/true
-
-	export GIT_AUTHOR_DATE=3D"2007-01-01 00:00:00 +0230"
-	export GIT_COMMITTER_DATE=3D"$GIT_AUTHOR_DATE"
-}
-
-setup
-
-test_expect_success 'encoding' '
-	mkdir -p tmp && cd tmp &&
-	test_when_finished "cd .. && rm -rf tmp" &&
-
-	(
-	git init -q gitrepo &&
-	cd gitrepo &&
-
-	echo alpha > alpha &&
-	git add alpha &&
-	git commit -m "add =C3=A4lph=C3=A0" &&
-
-	export GIT_AUTHOR_NAME=3D"t=C3=A9st =C3=A8nc=C3=B6d=C3=AEng" &&
-	echo beta > beta &&
-	git add beta &&
-	git commit -m "add beta" &&
-
-	echo gamma > gamma &&
-	git add gamma &&
-	git commit -m "add g=C3=A4mm=C3=A2" &&
-
-	: TODO git config i18n.commitencoding latin-1 &&
-	echo delta > delta &&
-	git add delta &&
-	git commit -m "add d=C3=A9lt=C3=A0"
-	) &&
-
-	hg_clone gitrepo hgrepo &&
-	git_clone hgrepo gitrepo2 &&
-	hg_clone gitrepo2 hgrepo2 &&
-
-	HGENCODING=3Dutf-8 hg_log hgrepo > expected &&
-	HGENCODING=3Dutf-8 hg_log hgrepo2 > actual &&
-
-	test_cmp expected actual
-'
-
-test_expect_success 'file removal' '
-	mkdir -p tmp && cd tmp &&
-	test_when_finished "cd .. && rm -rf tmp" &&
-
-	(
-	git init -q gitrepo &&
-	cd gitrepo &&
-	echo alpha > alpha &&
-	git add alpha &&
-	git commit -m "add alpha" &&
-	echo beta > beta &&
-	git add beta &&
-	git commit -m "add beta"
-	mkdir foo &&
-	echo blah > foo/bar &&
-	git add foo &&
-	git commit -m "add foo" &&
-	git rm alpha &&
-	git commit -m "remove alpha" &&
-	git rm foo/bar &&
-	git commit -m "remove foo/bar"
-	) &&
-
-	hg_clone gitrepo hgrepo &&
-	git_clone hgrepo gitrepo2 &&
-	hg_clone gitrepo2 hgrepo2 &&
-
-	hg_log hgrepo > expected &&
-	hg_log hgrepo2 > actual &&
-
-	test_cmp expected actual
-'
-
-test_expect_success 'git tags' '
-	mkdir -p tmp && cd tmp &&
-	test_when_finished "cd .. && rm -rf tmp" &&
-
-	(
-	git init -q gitrepo &&
-	cd gitrepo &&
-	git config receive.denyCurrentBranch ignore &&
-	echo alpha > alpha &&
-	git add alpha &&
-	git commit -m "add alpha" &&
-	git tag alpha &&
-
-	echo beta > beta &&
-	git add beta &&
-	git commit -m "add beta" &&
-	git tag -a -m "added tag beta" beta
-	) &&
-
-	hg_clone gitrepo hgrepo &&
-	git_clone hgrepo gitrepo2 &&
-	hg_clone gitrepo2 hgrepo2 &&
-
-	hg_log hgrepo > expected &&
-	hg_log hgrepo2 > actual &&
-
-	test_cmp expected actual
-'
-
-test_expect_success 'hg branch' '
-	mkdir -p tmp && cd tmp &&
-	test_when_finished "cd .. && rm -rf tmp" &&
-
-	(
-	git init -q gitrepo &&
-	cd gitrepo &&
-
-	echo alpha > alpha &&
-	git add alpha &&
-	git commit -q -m "add alpha" &&
-	git checkout -q -b not-master
-	) &&
-
-	(
-	hg_clone gitrepo hgrepo &&
-
-	cd hgrepo &&
-	hg -q co master &&
-	hg mv alpha beta &&
-	hg -q commit -m "rename alpha to beta" &&
-	hg branch gamma | grep -v "permanent and global" &&
-	hg -q commit -m "started branch gamma"
-	) &&
-
-	hg_push hgrepo gitrepo &&
-	hg_clone gitrepo hgrepo2 &&
-
-	: TODO, avoid "master" bookmark &&
-	(cd hgrepo2 && hg checkout gamma) &&
-
-	hg_log hgrepo > expected &&
-	hg_log hgrepo2 > actual &&
-
-	test_cmp expected actual
-'
-
-test_expect_success 'hg tags' '
-	mkdir -p tmp && cd tmp &&
-	test_when_finished "cd .. && rm -rf tmp" &&
-
-	(
-	git init -q gitrepo &&
-	cd gitrepo &&
-
-	echo alpha > alpha &&
-	git add alpha &&
-	git commit -m "add alpha" &&
-	git checkout -q -b not-master
-	) &&
-
-	(
-	hg_clone gitrepo hgrepo &&
-
-	cd hgrepo &&
-	hg co master &&
-	hg tag alpha
-	) &&
-
-	hg_push hgrepo gitrepo &&
-	hg_clone gitrepo hgrepo2 &&
-
-	hg_log hgrepo > expected &&
-	hg_log hgrepo2 > actual &&
-
-	test_cmp expected actual
-'
-
-test_done
diff --git a/contrib/remote-helpers/test-hg-hg-git.sh b/contrib/remote-=
helpers/test-hg-hg-git.sh
deleted file mode 100755
index 7e3967f..0000000
--- a/contrib/remote-helpers/test-hg-hg-git.sh
+++ /dev/null
@@ -1,534 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2012 Felipe Contreras
-#
-# Base commands from hg-git tests:
-# https://bitbucket.org/durin42/hg-git/src
-#
-
-test_description=3D'Test remote-hg output compared to hg-git'
-
-. ./test-lib.sh
-
-if ! test_have_prereq PYTHON; then
-	skip_all=3D'skipping remote-hg tests; python not available'
-	test_done
-fi
-
-if ! "$PYTHON_PATH" -c 'import mercurial'; then
-	skip_all=3D'skipping remote-hg tests; mercurial not available'
-	test_done
-fi
-
-if ! "$PYTHON_PATH" -c 'import hggit'; then
-	skip_all=3D'skipping remote-hg tests; hg-git not available'
-	test_done
-fi
-
-# clone to a git repo with git
-git_clone_git () {
-	hg -R $1 bookmark -f -r tip master &&
-	git clone -q "hg::$PWD/$1" $2
-}
-
-# clone to an hg repo with git
-hg_clone_git () {
-	(
-	hg init $2 &&
-	cd $1 &&
-	git push -q "hg::$PWD/../$2" 'refs/tags/*:refs/tags/*' 'refs/heads/*:=
refs/heads/*'
-	) &&
-
-	(cd $2 && hg -q update)
-}
-
-# clone to a git repo with hg
-git_clone_hg () {
-	(
-	git init -q $2 &&
-	cd $1 &&
-	hg bookmark -f -r tip master &&
-	hg -q push -r master ../$2 || true
-	)
-}
-
-# clone to an hg repo with hg
-hg_clone_hg () {
-	hg -q clone $1 $2
-}
-
-# push an hg repo with git
-hg_push_git () {
-	(
-	cd $2
-	old=3D$(git symbolic-ref --short HEAD)
-	git checkout -q -b tmp &&
-	git fetch -q "hg::$PWD/../$1" 'refs/tags/*:refs/tags/*' 'refs/heads/*=
:refs/heads/*' &&
-	git checkout -q $old &&
-	git branch -q -D tmp 2> /dev/null || true
-	)
-}
-
-# push an hg git repo with hg
-hg_push_hg () {
-	(
-	cd $1 &&
-	hg -q push ../$2 || true
-	)
-}
-
-hg_log () {
-	hg -R $1 log --graph --debug | grep -v 'tag: *default/'
-}
-
-git_log () {
-	git --git-dir=3D$1/.git fast-export --branches
-}
-
-setup () {
-	(
-	echo "[ui]"
-	echo "username =3D A U Thor <author@example.com>"
-	echo "[defaults]"
-	echo "backout =3D -d \"0 0\""
-	echo "commit =3D -d \"0 0\""
-	echo "debugrawcommit =3D -d \"0 0\""
-	echo "tag =3D -d \"0 0\""
-	echo "[extensions]"
-	echo "hgext.bookmarks =3D"
-	echo "hggit =3D"
-	) >> "$HOME"/.hgrc &&
-	git config --global receive.denycurrentbranch warn
-	git config --global remote-hg.hg-git-compat true
-
-	export HGEDITOR=3D/usr/bin/true
-
-	export GIT_AUTHOR_DATE=3D"2007-01-01 00:00:00 +0230"
-	export GIT_COMMITTER_DATE=3D"$GIT_AUTHOR_DATE"
-}
-
-setup
-
-test_expect_success 'executable bit' '
-	mkdir -p tmp && cd tmp &&
-	test_when_finished "cd .. && rm -rf tmp" &&
-
-	(
-	git init -q gitrepo &&
-	cd gitrepo &&
-	echo alpha > alpha &&
-	chmod 0644 alpha &&
-	git add alpha &&
-	git commit -m "add alpha" &&
-	chmod 0755 alpha &&
-	git add alpha &&
-	git commit -m "set executable bit" &&
-	chmod 0644 alpha &&
-	git add alpha &&
-	git commit -m "clear executable bit"
-	) &&
-
-	for x in hg git; do
-		(
-		hg_clone_$x gitrepo hgrepo-$x &&
-		cd hgrepo-$x &&
-		hg_log . &&
-		hg manifest -r 1 -v &&
-		hg manifest -v
-		) > output-$x &&
-
-		git_clone_$x hgrepo-$x gitrepo2-$x &&
-		git_log gitrepo2-$x > log-$x
-	done &&
-	cp -r log-* output-* /tmp/foo/ &&
-
-	test_cmp output-hg output-git &&
-	test_cmp log-hg log-git
-'
-
-test_expect_success 'symlink' '
-	mkdir -p tmp && cd tmp &&
-	test_when_finished "cd .. && rm -rf tmp" &&
-
-	(
-	git init -q gitrepo &&
-	cd gitrepo &&
-	echo alpha > alpha &&
-	git add alpha &&
-	git commit -m "add alpha" &&
-	ln -s alpha beta &&
-	git add beta &&
-	git commit -m "add beta"
-	) &&
-
-	for x in hg git; do
-		(
-		hg_clone_$x gitrepo hgrepo-$x &&
-		cd hgrepo-$x &&
-		hg_log . &&
-		hg manifest -v
-		) > output-$x &&
-
-		git_clone_$x hgrepo-$x gitrepo2-$x &&
-		git_log gitrepo2-$x > log-$x
-	done &&
-
-	test_cmp output-hg output-git &&
-	test_cmp log-hg log-git
-'
-
-test_expect_success 'merge conflict 1' '
-	mkdir -p tmp && cd tmp &&
-	test_when_finished "cd .. && rm -rf tmp" &&
-
-	(
-	hg init hgrepo1 &&
-	cd hgrepo1 &&
-	echo A > afile &&
-	hg add afile &&
-	hg ci -m "origin" &&
-
-	echo B > afile &&
-	hg ci -m "A->B" &&
-
-	hg up -r0 &&
-	echo C > afile &&
-	hg ci -m "A->C" &&
-
-	hg merge -r1 || true &&
-	echo C > afile &&
-	hg resolve -m afile &&
-	hg ci -m "merge to C"
-	) &&
-
-	for x in hg git; do
-		git_clone_$x hgrepo1 gitrepo-$x &&
-		hg_clone_$x gitrepo-$x hgrepo2-$x &&
-		hg_log hgrepo2-$x > hg-log-$x &&
-		git_log gitrepo-$x > git-log-$x
-	done &&
-
-	test_cmp hg-log-hg hg-log-git &&
-	test_cmp git-log-hg git-log-git
-'
-
-test_expect_success 'merge conflict 2' '
-	mkdir -p tmp && cd tmp &&
-	test_when_finished "cd .. && rm -rf tmp" &&
-
-	(
-	hg init hgrepo1 &&
-	cd hgrepo1 &&
-	echo A > afile &&
-	hg add afile &&
-	hg ci -m "origin" &&
-
-	echo B > afile &&
-	hg ci -m "A->B" &&
-
-	hg up -r0 &&
-	echo C > afile &&
-	hg ci -m "A->C" &&
-
-	hg merge -r1 || true &&
-	echo B > afile &&
-	hg resolve -m afile &&
-	hg ci -m "merge to B"
-	) &&
-
-	for x in hg git; do
-		git_clone_$x hgrepo1 gitrepo-$x &&
-		hg_clone_$x gitrepo-$x hgrepo2-$x &&
-		hg_log hgrepo2-$x > hg-log-$x &&
-		git_log gitrepo-$x > git-log-$x
-	done &&
-
-	test_cmp hg-log-hg hg-log-git &&
-	test_cmp git-log-hg git-log-git
-'
-
-test_expect_success 'converged merge' '
-	mkdir -p tmp && cd tmp &&
-	test_when_finished "cd .. && rm -rf tmp" &&
-
-	(
-	hg init hgrepo1 &&
-	cd hgrepo1 &&
-	echo A > afile &&
-	hg add afile &&
-	hg ci -m "origin" &&
-
-	echo B > afile &&
-	hg ci -m "A->B" &&
-
-	echo C > afile &&
-	hg ci -m "B->C" &&
-
-	hg up -r0 &&
-	echo C > afile &&
-	hg ci -m "A->C" &&
-
-	hg merge -r2 || true &&
-	hg ci -m "merge"
-	) &&
-
-	for x in hg git; do
-		git_clone_$x hgrepo1 gitrepo-$x &&
-		hg_clone_$x gitrepo-$x hgrepo2-$x &&
-		hg_log hgrepo2-$x > hg-log-$x &&
-		git_log gitrepo-$x > git-log-$x
-	done &&
-
-	test_cmp hg-log-hg hg-log-git &&
-	test_cmp git-log-hg git-log-git
-'
-
-test_expect_success 'encoding' '
-	mkdir -p tmp && cd tmp &&
-	test_when_finished "cd .. && rm -rf tmp" &&
-
-	(
-	git init -q gitrepo &&
-	cd gitrepo &&
-
-	echo alpha > alpha &&
-	git add alpha &&
-	git commit -m "add =C3=A4lph=C3=A0" &&
-
-	export GIT_AUTHOR_NAME=3D"t=C3=A9st =C3=A8nc=C3=B6d=C3=AEng" &&
-	echo beta > beta &&
-	git add beta &&
-	git commit -m "add beta" &&
-
-	echo gamma > gamma &&
-	git add gamma &&
-	git commit -m "add g=C3=A4mm=C3=A2" &&
-
-	: TODO git config i18n.commitencoding latin-1 &&
-	echo delta > delta &&
-	git add delta &&
-	git commit -m "add d=C3=A9lt=C3=A0"
-	) &&
-
-	for x in hg git; do
-		hg_clone_$x gitrepo hgrepo-$x &&
-		git_clone_$x hgrepo-$x gitrepo2-$x &&
-
-		HGENCODING=3Dutf-8 hg_log hgrepo-$x > hg-log-$x &&
-		git_log gitrepo2-$x > git-log-$x
-	done &&
-
-	test_cmp hg-log-hg hg-log-git &&
-	test_cmp git-log-hg git-log-git
-'
-
-test_expect_success 'file removal' '
-	mkdir -p tmp && cd tmp &&
-	test_when_finished "cd .. && rm -rf tmp" &&
-
-	(
-	git init -q gitrepo &&
-	cd gitrepo &&
-	echo alpha > alpha &&
-	git add alpha &&
-	git commit -m "add alpha" &&
-	echo beta > beta &&
-	git add beta &&
-	git commit -m "add beta"
-	mkdir foo &&
-	echo blah > foo/bar &&
-	git add foo &&
-	git commit -m "add foo" &&
-	git rm alpha &&
-	git commit -m "remove alpha" &&
-	git rm foo/bar &&
-	git commit -m "remove foo/bar"
-	) &&
-
-	for x in hg git; do
-		(
-		hg_clone_$x gitrepo hgrepo-$x &&
-		cd hgrepo-$x &&
-		hg_log . &&
-		hg manifest -r 3 &&
-		hg manifest
-		) > output-$x &&
-
-		git_clone_$x hgrepo-$x gitrepo2-$x &&
-		git_log gitrepo2-$x > log-$x
-	done &&
-
-	test_cmp output-hg output-git &&
-	test_cmp log-hg log-git
-'
-
-test_expect_success 'git tags' '
-	mkdir -p tmp && cd tmp &&
-	test_when_finished "cd .. && rm -rf tmp" &&
-
-	(
-	git init -q gitrepo &&
-	cd gitrepo &&
-	git config receive.denyCurrentBranch ignore &&
-	echo alpha > alpha &&
-	git add alpha &&
-	git commit -m "add alpha" &&
-	git tag alpha &&
-
-	echo beta > beta &&
-	git add beta &&
-	git commit -m "add beta" &&
-	git tag -a -m "added tag beta" beta
-	) &&
-
-	for x in hg git; do
-		hg_clone_$x gitrepo hgrepo-$x &&
-		hg_log hgrepo-$x > log-$x
-	done &&
-
-	test_cmp log-hg log-git
-'
-
-test_expect_success 'hg author' '
-	mkdir -p tmp && cd tmp &&
-	test_when_finished "cd .. && rm -rf tmp" &&
-
-	for x in hg git; do
-		(
-		git init -q gitrepo-$x &&
-		cd gitrepo-$x &&
-
-		echo alpha > alpha &&
-		git add alpha &&
-		git commit -m "add alpha" &&
-		git checkout -q -b not-master
-		) &&
-
-		(
-		hg_clone_$x gitrepo-$x hgrepo-$x &&
-		cd hgrepo-$x &&
-
-		hg co master &&
-		echo beta > beta &&
-		hg add beta &&
-		hg commit -u "test" -m "add beta" &&
-
-		echo gamma >> beta &&
-		hg commit -u "test <test@example.com> (comment)" -m "modify beta" &&
-
-		echo gamma > gamma &&
-		hg add gamma &&
-		hg commit -u "<test@example.com>" -m "add gamma" &&
-
-		echo delta > delta &&
-		hg add delta &&
-		hg commit -u "name<test@example.com>" -m "add delta" &&
-
-		echo epsilon > epsilon &&
-		hg add epsilon &&
-		hg commit -u "name <test@example.com" -m "add epsilon" &&
-
-		echo zeta > zeta &&
-		hg add zeta &&
-		hg commit -u " test " -m "add zeta" &&
-
-		echo eta > eta &&
-		hg add eta &&
-		hg commit -u "test < test@example.com >" -m "add eta" &&
-
-		echo theta > theta &&
-		hg add theta &&
-		hg commit -u "test >test@example.com>" -m "add theta" &&
-
-		echo iota > iota &&
-		hg add iota &&
-		hg commit -u "test <test <at> example <dot> com>" -m "add iota"
-		) &&
-
-		hg_push_$x hgrepo-$x gitrepo-$x &&
-		hg_clone_$x gitrepo-$x hgrepo2-$x &&
-
-		hg_log hgrepo2-$x > hg-log-$x &&
-		git_log gitrepo-$x > git-log-$x
-	done &&
-
-	test_cmp git-log-hg git-log-git &&
-
-	test_cmp hg-log-hg hg-log-git &&
-	test_cmp git-log-hg git-log-git
-'
-
-test_expect_success 'hg branch' '
-	mkdir -p tmp && cd tmp &&
-	test_when_finished "cd .. && rm -rf tmp" &&
-
-	for x in hg git; do
-		(
-		git init -q gitrepo-$x &&
-		cd gitrepo-$x &&
-
-		echo alpha > alpha &&
-		git add alpha &&
-		git commit -q -m "add alpha" &&
-		git checkout -q -b not-master
-		) &&
-
-		(
-		hg_clone_$x gitrepo-$x hgrepo-$x &&
-
-		cd hgrepo-$x &&
-		hg -q co master &&
-		hg mv alpha beta &&
-		hg -q commit -m "rename alpha to beta" &&
-		hg branch gamma | grep -v "permanent and global" &&
-		hg -q commit -m "started branch gamma"
-		) &&
-
-		hg_push_$x hgrepo-$x gitrepo-$x &&
-		hg_clone_$x gitrepo-$x hgrepo2-$x &&
-
-		hg_log hgrepo2-$x > hg-log-$x &&
-		git_log gitrepo-$x > git-log-$x
-	done &&
-
-	test_cmp hg-log-hg hg-log-git &&
-	test_cmp git-log-hg git-log-git
-'
-
-test_expect_success 'hg tags' '
-	mkdir -p tmp && cd tmp &&
-	test_when_finished "cd .. && rm -rf tmp" &&
-
-	for x in hg git; do
-		(
-		git init -q gitrepo-$x &&
-		cd gitrepo-$x &&
-
-		echo alpha > alpha &&
-		git add alpha &&
-		git commit -m "add alpha" &&
-		git checkout -q -b not-master
-		) &&
-
-		(
-		hg_clone_$x gitrepo-$x hgrepo-$x &&
-
-		cd hgrepo-$x &&
-		hg co master &&
-		hg tag alpha
-		) &&
-
-		hg_push_$x hgrepo-$x gitrepo-$x &&
-		hg_clone_$x gitrepo-$x hgrepo2-$x &&
-
-		(
-		git --git-dir=3Dgitrepo-$x/.git tag -l &&
-		hg_log hgrepo2-$x &&
-		cat hgrepo2-$x/.hgtags
-		) > output-$x
-	done &&
-
-	test_cmp output-hg output-git
-'
-
-test_done
diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers=
/test-hg.sh
deleted file mode 100755
index 5f81dfa..0000000
--- a/contrib/remote-helpers/test-hg.sh
+++ /dev/null
@@ -1,121 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2012 Felipe Contreras
-#
-# Base commands from hg-git tests:
-# https://bitbucket.org/durin42/hg-git/src
-#
-
-test_description=3D'Test remote-hg'
-
-. ./test-lib.sh
-
-if ! test_have_prereq PYTHON; then
-	skip_all=3D'skipping remote-hg tests; python not available'
-	test_done
-fi
-
-if ! "$PYTHON_PATH" -c 'import mercurial'; then
-	skip_all=3D'skipping remote-hg tests; mercurial not available'
-	test_done
-fi
-
-check () {
-	(cd $1 &&
-	git log --format=3D'%s' -1 &&
-	git symbolic-ref HEAD) > actual &&
-	(echo $2 &&
-	echo "refs/heads/$3") > expected &&
-	test_cmp expected actual
-}
-
-setup () {
-	(
-	echo "[ui]"
-	echo "username =3D H G Wells <wells@example.com>"
-	) >> "$HOME"/.hgrc
-}
-
-setup
-
-test_expect_success 'cloning' '
-  test_when_finished "rm -rf gitrepo*" &&
-
-  (
-  hg init hgrepo &&
-  cd hgrepo &&
-  echo zero > content &&
-  hg add content &&
-  hg commit -m zero
-  ) &&
-
-  git clone "hg::$PWD/hgrepo" gitrepo &&
-  check gitrepo zero master
-'
-
-test_expect_success 'cloning with branches' '
-  test_when_finished "rm -rf gitrepo*" &&
-
-  (
-  cd hgrepo &&
-  hg branch next &&
-  echo next > content &&
-  hg commit -m next
-  ) &&
-
-  git clone "hg::$PWD/hgrepo" gitrepo &&
-  check gitrepo next next &&
-
-  (cd hgrepo && hg checkout default) &&
-
-  git clone "hg::$PWD/hgrepo" gitrepo2 &&
-  check gitrepo2 zero master
-'
-
-test_expect_success 'cloning with bookmarks' '
-  test_when_finished "rm -rf gitrepo*" &&
-
-  (
-  cd hgrepo &&
-  hg bookmark feature-a &&
-  echo feature-a > content &&
-  hg commit -m feature-a
-  ) &&
-
-  git clone "hg::$PWD/hgrepo" gitrepo &&
-  check gitrepo feature-a feature-a
-'
-
-test_expect_success 'cloning with detached head' '
-  test_when_finished "rm -rf gitrepo*" &&
-
-  (
-  cd hgrepo &&
-  hg update -r 0
-  ) &&
-
-  git clone "hg::$PWD/hgrepo" gitrepo &&
-  check gitrepo zero master
-'
-
-test_expect_success 'update bookmark' '
-  test_when_finished "rm -rf gitrepo*" &&
-
-  (
-  cd hgrepo &&
-  hg bookmark devel
-  ) &&
-
-  (
-  git clone "hg::$PWD/hgrepo" gitrepo &&
-  cd gitrepo &&
-  git checkout devel &&
-  echo devel > content &&
-  git commit -a -m devel &&
-  git push
-  ) &&
-
-  hg -R hgrepo bookmarks | grep "devel\s\+3:"
-'
-
-test_done
diff --git a/t/Makefile b/t/Makefile
index 1923cc1..612fe79 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -48,7 +48,7 @@ clean: clean-except-prove-cache
 test-lint: test-lint-duplicates test-lint-executable test-lint-shell-s=
yntax
=20
 test-lint-duplicates:
-	@dups=3D`echo $(T) | tr ' ' '\n' | sed 's/-.*//' | sort | uniq -d` &&=
 \
+	@dups=3D`echo $(T) $(TDUP) | tr ' ' '\n' | sed -ne 's|\(.*/\)*t\([0-9=
][0-9][0-9][0-9]\)-.*|\2|p' | sort | uniq -d` && \
 		test -z "$$dups" || { \
 		echo >&2 "duplicate test numbers:" $$dups; exit 1; }
=20
--=20
1.8.1.1
