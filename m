From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=20v4=2012/13=5D=20remote-hg=3A=20add=20tests=20to=20compare=20with=20hg-git?=
Date: Sun, 28 Oct 2012 04:54:12 +0100
Message-ID: <1351396453-29042-13-git-send-email-felipe.contreras@gmail.com>
References: <1351396453-29042-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 28 04:55:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSJye-0003es-Ko
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 04:55:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755000Ab2J1Dzo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Oct 2012 23:55:44 -0400
Received: from mail-ea0-f174.google.com ([209.85.215.174]:48471 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754986Ab2J1Dzm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2012 23:55:42 -0400
Received: by mail-ea0-f174.google.com with SMTP id c13so1289841eaa.19
        for <git@vger.kernel.org>; Sat, 27 Oct 2012 20:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=+60pyXNMNjzGq0aO1hJzo5qCQVvxNuQraHKu/iuYde8=;
        b=QBIEf7oTk0iW/Idp8pDuOE33EqZsTjHk09iR6L1xN/duNtm7TxZRrwGtSerO4EofKJ
         OuPZHfLVlbVz8flXTohrMDmnMMYTVhLMY9MCMpIRYnHtNHmKrI1uKW7rmUOu7BAyjnro
         pEoAx8zq7lActP8Fj5SCpxDANWS02eO5tvruk5khZiQ5CLLkCQIFN8Z09m9phBvSP+iR
         0gguzlDmT5VZQ/TqF1sahxQoJcGjzMkZKh6uQBsrbksvZ6CM8cxoRrSdDmuS1VdXRPTU
         VHZE2Knlp0i/sZDtrq+rJGM5OGwvQjJybFREyqH5WLw6+Zyjgphv5rbHpPMQZHOu6BIE
         Nltg==
Received: by 10.14.172.195 with SMTP id t43mr48299052eel.17.1351396541628;
        Sat, 27 Oct 2012 20:55:41 -0700 (PDT)
Received: from localhost (ip-109-43-0-40.web.vodafone.de. [109.43.0.40])
        by mx.google.com with ESMTPS id e1sm13236403eem.3.2012.10.27.20.55.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 27 Oct 2012 20:55:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351396453-29042-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208530>

The base commands come from the tests of the hg-git project.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5802-remote-hg-hg-git.sh | 445 ++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 445 insertions(+)
 create mode 100755 t/t5802-remote-hg-hg-git.sh

diff --git a/t/t5802-remote-hg-hg-git.sh b/t/t5802-remote-hg-hg-git.sh
new file mode 100755
index 0000000..3cfa9e6
--- /dev/null
+++ b/t/t5802-remote-hg-hg-git.sh
@@ -0,0 +1,445 @@
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
+test_expect_success 'setup' '
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
+		hg commit -u "test >test@example.com>" -m "add theta"
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
+		git --git-dir=3Dgitrepo-hg/.git tag -l &&
+		hg_log hgrepo2-hg &&
+		cat hgrepo2-hg/.hgtags
+		) > output-$x
+	done &&
+
+	test_cmp output-hg output-git
+'
+
+test_done
--=20
1.8.0
