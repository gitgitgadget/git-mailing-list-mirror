From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 04/14] Add new simplified git-remote-testgit
Date: Fri,  2 Nov 2012 03:02:08 +0100
Message-ID: <1351821738-17526-5-git-send-email-felipe.contreras@gmail.com>
References: <1351821738-17526-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 02 03:03:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TU6b9-0000fm-Ub
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 03:03:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965700Ab2KBCCq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2012 22:02:46 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43159 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762642Ab2KBCCp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2012 22:02:45 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1234245bkc.19
        for <git@vger.kernel.org>; Thu, 01 Nov 2012 19:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=INKrwiMQQIVzaq+P31vivNl5dO87CxnWjm0wvAogFk4=;
        b=DzR/2swdIMvcKC2ig0+KKXNjWuOpuoO2fy97y4dQK0k3v+1ZvswPAG1XyEBHtHIFRN
         AwWyVDs0UsRpbuJsQxUTmsQes0Oain1BVmyJ58cisES4lMbe1o0DtrsfA/Ni+FwOsAbb
         PRuyzDcK6smg5IWcZ3dX/9hMNFQBajI2Q+OrAppyRzgyMKsRvdIXZTrM2IIRVtZo3fi1
         PEp4xWKFo90nVWRPwupJ8pxcioQcjBiBkRyl3ShkSGRBXcpHvUHosc+eXtfln2Rrah3K
         tnnsqqeNBrUn7eeNKHeXW3x3IhfXi8MDJFlhT9e+PVmOgRXfPksiNaB3jIEYrhv0rRwM
         M+lQ==
Received: by 10.205.128.148 with SMTP id he20mr21389bkc.99.1351821764683;
        Thu, 01 Nov 2012 19:02:44 -0700 (PDT)
Received: from localhost (ip-109-43-0-51.web.vodafone.de. [109.43.0.51])
        by mx.google.com with ESMTPS id s20sm5784054bkw.15.2012.11.01.19.02.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Nov 2012 19:02:43 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351821738-17526-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208901>

It's way simpler. It exerceises the same features of remote helpers.
It's easy to read and understand. It doesn't depend on python.

It does _not_ exercise the python remote helper framework; there's
another tool and another test for that.

For now let's just copy the old remote-helpers test script, although
some of those tests don't make sense for this testgit (they still pass).

In addition, this script would be able to test other features not
currently being tested.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-remote-testgit.txt |   2 +-
 git-remote-testgit                   |  62 ++++++++++++++++
 t/t5801-remote-helpers.sh            | 134 +++++++++++++++++++++++++++++++++++
 3 files changed, 197 insertions(+), 1 deletion(-)
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
index 0000000..6650402
--- /dev/null
+++ b/git-remote-testgit
@@ -0,0 +1,62 @@
+#!/bin/bash
+# Copyright (c) 2012 Felipe Contreras
+
+alias="$1"
+url="$2"
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
+test -e "$gitmarks" || echo -n > "$gitmarks"
+test -e "$testgitmarks" || echo -n > "$testgitmarks"
+
+while read line; do
+    case "$line" in
+    capabilities)
+        echo 'import'
+        echo 'export'
+        echo "refspec $refspec"
+        echo "*import-marks $gitmarks"
+        echo "*export-marks $gitmarks"
+        echo
+        ;;
+    list)
+        git for-each-ref --format='? %(refname)' 'refs/heads/'
+        head=$(git symbolic-ref HEAD)
+        echo "@$head HEAD"
+        echo
+        ;;
+    import*)
+        # read all import lines
+        while true; do
+            ref="${line#* }"
+            refs="$refs $ref"
+            read line
+            test "${line%% *}" != "import" && break
+        done
+
+        echo "feature import-marks=$gitmarks"
+        echo "feature export-marks=$gitmarks"
+        git fast-export --use-done-feature --{import,export}-marks="$testgitmarks" $refs | \
+            sed -e "s#refs/heads/#${prefix}/heads/#g"
+        ;;
+    export)
+        git fast-import --{import,export}-marks="$testgitmarks" --quiet
+        echo
+        ;;
+    '')
+        exit
+        ;;
+    esac
+done
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
new file mode 100755
index 0000000..67bc8eb
--- /dev/null
+++ b/t/t5801-remote-helpers.sh
@@ -0,0 +1,134 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Sverre Rabbelier
+#
+
+test_description='Test remote-helper import and export commands'
+
+. ./test-lib.sh
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
1.8.0
