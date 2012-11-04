From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=20v6=2012/16=5D=20remote-hg=3A=20add=20bidirectional=20tests?=
Date: Sun,  4 Nov 2012 03:13:34 +0100
Message-ID: <1351995218-19889-13-git-send-email-felipe.contreras@gmail.com>
References: <1351995218-19889-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 04 03:14:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUpjg-0002j1-24
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 03:14:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752767Ab2KDCOi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Nov 2012 22:14:38 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62548 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488Ab2KDCOf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2012 22:14:35 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1657497bkc.19
        for <git@vger.kernel.org>; Sat, 03 Nov 2012 19:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=4yIsWqfLc4TUWiFwQUAOeLy5PNt5UjW2jCCskJWnhzI=;
        b=dylDP+0ifpjMXdTTsT+jt7q1Kg7odIDiM9plmWV1wW/eASctbq28+yI3SEJGLziPyc
         yGvlERLKFlzH3sNCw5IXvcuxAYen3FYx1uGkwFQYfK+NyRLL/7qu5lInVcQSUzx4nsB8
         kWdsnscAi4VXC7O1trKnWWdfQwfEodepnjEqzKJIvukSwTxd81+HnF2BO4JSaB7Aou+e
         8+dE0ZoVPs72HBXzOu69Sj4PTUxB9y95aCdeO+rDcVJJm7TdGHQKkMzPmu2csJCd4AsV
         X8F9ixYw8ObIOmOojUNPnVV8R2JQY7DZcvpovCM4k65d/SXaY679inMeGsM7i+73A10I
         TI0A==
Received: by 10.204.11.209 with SMTP id u17mr1462101bku.76.1351995274972;
        Sat, 03 Nov 2012 19:14:34 -0700 (PDT)
Received: from localhost (ip-109-43-0-39.web.vodafone.de. [109.43.0.39])
        by mx.google.com with ESMTPS id x13sm7967669bkv.16.2012.11.03.19.14.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Nov 2012 19:14:34 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351995218-19889-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209001>

Base commands from hg-git tests:
https://bitbucket.org/durin42/hg-git/src

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-hg-bidi.sh | 243 +++++++++++++++++++++++++=
++++++++
 1 file changed, 243 insertions(+)
 create mode 100755 contrib/remote-helpers/test-hg-bidi.sh

diff --git a/contrib/remote-helpers/test-hg-bidi.sh b/contrib/remote-he=
lpers/test-hg-bidi.sh
new file mode 100755
index 0000000..a94eb28
--- /dev/null
+++ b/contrib/remote-helpers/test-hg-bidi.sh
@@ -0,0 +1,243 @@
+#!/bin/sh
+#
+# Copyright (c) 2012 Felipe Contreras
+#
+# Base commands from hg-git tests:
+# https://bitbucket.org/durin42/hg-git/src
+#
+
+test_description=3D'Test biridectionality of remote-hg'
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
--=20
1.8.0
