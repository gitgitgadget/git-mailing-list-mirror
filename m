From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 p1 05/13] Add new simplified git-remote-testgit
Date: Wed, 28 Nov 2012 23:11:01 +0100
Message-ID: <1354140669-23533-6-git-send-email-felipe.contreras@gmail.com>
References: <1354140669-23533-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 23:12:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tdprp-0003JU-U0
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 23:12:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932785Ab2K1WLp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 17:11:45 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43342 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932533Ab2K1WLm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 17:11:42 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so5972393bkw.19
        for <git@vger.kernel.org>; Wed, 28 Nov 2012 14:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=K3zgmTJ7X5G4n1eHT5HFw+ta5Atz6PryRaq0EAPwGI0=;
        b=euRDca/F9TsI8+Z8lXeMwXEevSy0UULWsBRdArOJ7ivIrrLjrTBrJuQ2/FoBrkfUJq
         HQsSnnnuDRWGLPyuMXYBRrD1tQBSLI7+1LR/+dcwh1z4rc3XgmPgx6X2ndFbF4+4tvQs
         +Ar5hG4nAVp8DE5dmbgsM+cRoI4a1sJdMOGrKHWk2rQdoYt2twf+xPLwntYKSxzgYiAs
         EUQtltc4OBpiucZj7cTObwZFleaiYUeEtJxAOnGJXK6B+EOTTUdvDG+fnhsVHvnCM8Vu
         LBbtpyb2ZnGpQ9S/vkLnt2kCHp9kw0s/VEe026BO+6BvT5N5JJ4/IDVQTcXoXcXakOvi
         CP3g==
Received: by 10.204.136.209 with SMTP id s17mr6066380bkt.13.1354140701563;
        Wed, 28 Nov 2012 14:11:41 -0800 (PST)
Received: from localhost (ip-109-43-0-26.web.vodafone.de. [109.43.0.26])
        by mx.google.com with ESMTPS id d16sm13781722bkw.2.2012.11.28.14.11.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Nov 2012 14:11:40 -0800 (PST)
X-Mailer: git-send-email 1.8.0.1
In-Reply-To: <1354140669-23533-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210788>

Exercising the python remote helper framework is for another tool and
another test. This is about testing the remote-helper interface.

It's way simpler, it exercises the same features of remote helpers, it's
easy to read and understand, and it doesn't depend on python.

For now let's just copy the old remote-helpers test script, although
some of those tests don't make sense. In addition, this script would be
able to test other features not currently being tested.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-remote-testgit.txt |   2 +-
 git-remote-testgit                   |  64 ++++++++++++++++
 t/t5801-remote-helpers.sh            | 139 +++++++++++++++++++++++++++++++++++
 3 files changed, 204 insertions(+), 1 deletion(-)
 create mode 100755 git-remote-testgit
 create mode 100755 t/t5801-remote-helpers.sh

diff --git a/Documentation/git-remote-testgit.txt b/Documentation/git-remote-testgit.txt
index 2a67d45..612a625 100644
--- a/Documentation/git-remote-testgit.txt
+++ b/Documentation/git-remote-testgit.txt
@@ -19,7 +19,7 @@ testcase for the remote-helper functionality, and as an example to
 show remote-helper authors one possible implementation.
 
 The best way to learn more is to read the comments and source code in
-'git-remote-testgit.py'.
+'git-remote-testgit'.
 
 SEE ALSO
 --------
diff --git a/git-remote-testgit b/git-remote-testgit
new file mode 100755
index 0000000..5042f5a
--- /dev/null
+++ b/git-remote-testgit
@@ -0,0 +1,64 @@
+#!/usr/bin/env bash
+# Copyright (c) 2012 Felipe Contreras
+
+alias=$1
+url=$2
+
+# huh?
+url="${url#file://}"
+
+dir="$GIT_DIR/testgit/$alias"
+prefix="refs/testgit/$alias"
+refspec="refs/heads/*:${prefix}/heads/*"
+
+gitmarks="$dir/git.marks"
+testgitmarks="$dir/testgit.marks"
+
+export GIT_DIR="$url/.git"
+
+mkdir -p "$dir"
+
+test -e "$gitmarks" || > "$gitmarks"
+test -e "$testgitmarks" || > "$testgitmarks"
+
+while read line
+do
+	case $line in
+	capabilities)
+		echo 'import'
+		echo 'export'
+		echo "refspec $refspec"
+		echo "*import-marks $gitmarks"
+		echo "*export-marks $gitmarks"
+		echo
+		;;
+	list)
+		git for-each-ref --format='? %(refname)' 'refs/heads/'
+		head=$(git symbolic-ref HEAD)
+		echo "@$head HEAD"
+		echo
+		;;
+	import*)
+		# read all import lines
+		while true
+		do
+			ref="${line#* }"
+			refs="$refs $ref"
+			read line
+			test "${line%% *}" != "import" && break
+		done
+
+		echo "feature import-marks=$gitmarks"
+		echo "feature export-marks=$gitmarks"
+		git fast-export --use-done-feature --{import,export}-marks="$testgitmarks" $refs |
+		sed -e "s#refs/heads/#${prefix}/heads/#g"
+		;;
+	export)
+		git fast-import --{import,export}-marks="$testgitmarks" --quiet
+		echo
+		;;
+	'')
+		exit
+		;;
+	esac
+done
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
new file mode 100755
index 0000000..f52ab14
--- /dev/null
+++ b/t/t5801-remote-helpers.sh
@@ -0,0 +1,139 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Sverre Rabbelier
+#
+
+test_description='Test remote-helper import and export commands'
+
+. ./test-lib.sh
+
+if ! type "${BASH-bash}" >/dev/null 2>&1; then
+	skip_all='skipping remote-testgit tests, bash not available'
+	test_done
+fi
+
+compare_refs() {
+	git --git-dir="$1/.git" rev-parse --verify $2 >expect &&
+	git --git-dir="$3/.git" rev-parse --verify $4 >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'setup repository' '
+	git init --bare server/.git &&
+	git clone server public &&
+	(cd public &&
+	 echo content >file &&
+	 git add file &&
+	 git commit -m one &&
+	 git push origin master)
+'
+
+test_expect_success 'cloning from local repo' '
+	git clone "testgit::${PWD}/server" localclone &&
+	test_cmp public/file localclone/file
+'
+
+test_expect_success 'cloning from remote repo' '
+	git clone "testgit::file://${PWD}/server" clone &&
+	test_cmp public/file clone/file
+'
+
+test_expect_success 'create new commit on remote' '
+	(cd public &&
+	 echo content >>file &&
+	 git commit -a -m two &&
+	 git push)
+'
+
+test_expect_success 'pulling from local repo' '
+	(cd localclone && git pull) &&
+	test_cmp public/file localclone/file
+'
+
+test_expect_success 'pulling from remote remote' '
+	(cd clone && git pull) &&
+	test_cmp public/file clone/file
+'
+
+test_expect_success 'pushing to local repo' '
+	(cd localclone &&
+	echo content >>file &&
+	git commit -a -m three &&
+	git push) &&
+	compare_refs localclone HEAD server HEAD
+'
+
+# Generally, skip this test.  It demonstrates a now-fixed race in
+# git-remote-testgit, but is too slow to leave in for general use.
+: test_expect_success 'racily pushing to local repo' '
+	test_when_finished "rm -rf server2 localclone2" &&
+	cp -R server server2 &&
+	git clone "testgit::${PWD}/server2" localclone2 &&
+	(cd localclone2 &&
+	echo content >>file &&
+	git commit -a -m three &&
+	GIT_REMOTE_TESTGIT_SLEEPY=2 git push) &&
+	compare_refs localclone2 HEAD server2 HEAD
+'
+
+test_expect_success 'synch with changes from localclone' '
+	(cd clone &&
+	 git pull)
+'
+
+test_expect_success 'pushing remote local repo' '
+	(cd clone &&
+	echo content >>file &&
+	git commit -a -m four &&
+	git push) &&
+	compare_refs clone HEAD server HEAD
+'
+
+test_expect_success 'fetch new branch' '
+	(cd public &&
+	 git checkout -b new &&
+	 echo content >>file &&
+	 git commit -a -m five &&
+	 git push origin new
+	) &&
+	(cd localclone &&
+	 git fetch origin new
+	) &&
+	compare_refs public HEAD localclone FETCH_HEAD
+'
+
+test_expect_success 'fetch multiple branches' '
+	(cd localclone &&
+	 git fetch
+	) &&
+	compare_refs server master localclone refs/remotes/origin/master &&
+	compare_refs server new localclone refs/remotes/origin/new
+'
+
+test_expect_success 'push when remote has extra refs' '
+	(cd clone &&
+	 echo content >>file &&
+	 git commit -a -m six &&
+	 git push
+	) &&
+	compare_refs clone master server master
+'
+
+test_expect_success 'push new branch by name' '
+	(cd clone &&
+	 git checkout -b new-name  &&
+	 echo content >>file &&
+	 git commit -a -m seven &&
+	 git push origin new-name
+	) &&
+	compare_refs clone HEAD server refs/heads/new-name
+'
+
+test_expect_failure 'push new branch with old:new refspec' '
+	(cd clone &&
+	 git push origin new-name:new-refspec
+	) &&
+	compare_refs clone HEAD server refs/heads/new-refspec
+'
+
+test_done
-- 
1.8.0.1
