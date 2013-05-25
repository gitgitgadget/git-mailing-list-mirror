From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 18/48] remote-hg: always point HEAD to master
Date: Fri, 24 May 2013 21:29:34 -0500
Message-ID: <1369449004-17981-19-git-send-email-felipe.contreras@gmail.com>
References: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:32:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4Hr-00022Y-5y
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755211Ab3EYCcj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:32:39 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:55947 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755068Ab3EYCci (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:32:38 -0400
Received: by mail-oa0-f53.google.com with SMTP id g12so6856755oah.40
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=qhPIC5A2lPFvbfDSZe88Ziu9NP6fZwwy+V5iavvghlM=;
        b=U5ndk60wa8oD4M2UXin8L2fbb6jflvCszwCOPUA6dDEgNuegFFCu732tLoY7Hd0Fyq
         a4YHgvknr160SoDxht8o0hy3PmjW+m/W9IcDIniuzJbSyVY9o6hu58ZRIL9gp2NPZLTm
         abB3pX/cIZCPY3V/nHIiv2PNMd4kDObYgAJfYg6Gzn4L0pDjCkVVhlpqv21gYUnXh7Hc
         esQse4kwsp+U1TRvhCaqW5iG1kS4VL3gG2QgX1lkCb0IALJEULVCeKCZH4YinAeZ+WtC
         QMX33XRAOA5T7Ssl+NPpgLHO3/ksXt7uh9xBPlt1rSfkx1cCAwPF9JC26/PZVzJGQODm
         dwvQ==
X-Received: by 10.182.102.234 with SMTP id fr10mr13172523obb.85.1369449157819;
        Fri, 24 May 2013 19:32:37 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id nt17sm20017054obb.13.2013.05.24.19.32.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:32:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225432>

Mercurial always checks out the 'default' branch, so there's no point in
complicating our lives trying to do something fancier, which causes
different behavior depending on whether the repository is local or
remote.

So let's always use 'default' (which we translate to 'master'), unless
we are in hg-git mode, which expects us to use the 'master' bookmark
instead.

Also, update the tests that used to check for different checkout
behaviors to simply check that the refs are there, remove unnecessary
ones, and fix the ones that expect something different.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg     | 30 ++++++++++++---------------
 contrib/remote-helpers/test-hg-bidi.sh   |  9 ++++----
 contrib/remote-helpers/test-hg-hg-git.sh |  4 +++-
 contrib/remote-helpers/test-hg.sh        | 35 ++++++--------------------------
 4 files changed, 26 insertions(+), 52 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 48edf3b..7c859b8 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -560,22 +560,16 @@ def get_branch_tip(repo, branch):
     return heads[0]
 
 def list_head(repo, cur):
-    global g_head, bmarks
+    global g_head, bmarks, fake_bmark
 
-    head = bookmarks.readcurrent(repo)
-    if head:
-        node = repo[head]
-    else:
-        # fake bookmark from current branch
-        head = cur
-        node = repo['.']
-        if not node:
-            node = repo['tip']
-        if not node:
-            return
-        if head == 'default':
-            head = 'master'
-        bmarks[head] = node
+    if 'default' not in repo:
+        # empty repo
+        return
+
+    node = repo['default']
+    head = 'master' if not 'master' in bmarks else 'default'
+    fake_bmark = head
+    bmarks[head] = node
 
     head = gitref(head)
     print "@refs/heads/%s HEAD" % head
@@ -910,8 +904,8 @@ def do_export(parser):
         if old == new:
             continue
 
-        if bmark == 'master' and 'master' not in parser.repo._bookmarks:
-            # fake bookmark
+        if bmark == fake_bmark or \
+                bmark == 'master' and 'master' not in parser.repo._bookmarks:
             print "ok %s" % ref
             continue
         elif bookmarks.pushbookmark(parser.repo, bmark, old, new):
@@ -946,6 +940,7 @@ def main(args):
     global track_branches, force_push, is_tmp
     global parsed_tags
     global filenodes
+    global fake_bmark
 
     alias = args[1]
     url = args[2]
@@ -979,6 +974,7 @@ def main(args):
     marks = None
     parsed_tags = {}
     filenodes = {}
+    fake_bmark = None
 
     repo = get_repo(url, alias)
     prefix = 'refs/hg/%s' % alias
diff --git a/contrib/remote-helpers/test-hg-bidi.sh b/contrib/remote-helpers/test-hg-bidi.sh
index 88a33e6..86a3f10 100755
--- a/contrib/remote-helpers/test-hg-bidi.sh
+++ b/contrib/remote-helpers/test-hg-bidi.sh
@@ -29,7 +29,6 @@ git_clone () {
 hg_clone () {
 	(
 	hg init $2 &&
-	hg -R $2 bookmark -i master &&
 	cd $1 &&
 	git push -q "hg::../$2" 'refs/tags/*:refs/tags/*' 'refs/heads/*:refs/heads/*'
 	) &&
@@ -49,8 +48,7 @@ hg_push () {
 }
 
 hg_log () {
-	hg -R $1 log --graph --debug >log &&
-	grep -v 'tag: *default/' log
+	hg -R $1 log --graph --debug
 }
 
 setup () {
@@ -66,6 +64,7 @@ setup () {
 	echo "graphlog ="
 	) >> "$HOME"/.hgrc &&
 	git config --global remote-hg.hg-git-compat true
+	git config --global remote-hg.track-branches true
 
 	HGEDITOR=/usr/bin/true
 	GIT_AUTHOR_DATE="2007-01-01 00:00:00 +0230"
@@ -189,7 +188,7 @@ test_expect_success 'hg branch' '
 	hg_clone gitrepo hgrepo &&
 
 	cd hgrepo &&
-	hg -q co master &&
+	hg -q co default &&
 	hg mv alpha beta &&
 	hg -q commit -m "rename alpha to beta" &&
 	hg branch gamma | grep -v "permanent and global" &&
@@ -225,7 +224,7 @@ test_expect_success 'hg tags' '
 	hg_clone gitrepo hgrepo &&
 
 	cd hgrepo &&
-	hg co master &&
+	hg co default &&
 	hg tag alpha
 	) &&
 
diff --git a/contrib/remote-helpers/test-hg-hg-git.sh b/contrib/remote-helpers/test-hg-hg-git.sh
index e503293..9cb95d8 100755
--- a/contrib/remote-helpers/test-hg-hg-git.sh
+++ b/contrib/remote-helpers/test-hg-hg-git.sh
@@ -27,7 +27,8 @@ fi
 
 # clone to a git repo with git
 git_clone_git () {
-	git clone -q "hg::$1" $2
+	git clone -q "hg::$1" $2 &&
+	(cd $2 && git checkout master && git branch -D default)
 }
 
 # clone to an hg repo with git
@@ -63,6 +64,7 @@ hg_push_git () {
 	cd $2
 	git checkout -q -b tmp &&
 	git fetch -q "hg::../$1" 'refs/tags/*:refs/tags/*' 'refs/heads/*:refs/heads/*' &&
+	git branch -D default &&
 	git checkout -q @{-1} &&
 	git branch -q -D tmp 2> /dev/null || true
 	)
diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 431a5d1..78af45d 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -21,15 +21,8 @@ if ! "$PYTHON_PATH" -c 'import mercurial'; then
 fi
 
 check () {
-	(
-	cd $1 &&
-	git log --format='%s' -1 &&
-	git symbolic-ref HEAD
-	) > actual &&
-	(
-	echo $2 &&
-	echo "refs/heads/$3"
-	) > expected &&
+	echo $3 > expected &&
+	git --git-dir=$1/.git log --format='%s' -1 $2 > actual
 	test_cmp expected actual
 }
 
@@ -56,7 +49,7 @@ test_expect_success 'cloning' '
 	) &&
 
 	git clone "hg::hgrepo" gitrepo &&
-	check gitrepo zero master
+	check gitrepo HEAD zero
 '
 
 test_expect_success 'cloning with branches' '
@@ -70,12 +63,7 @@ test_expect_success 'cloning with branches' '
 	) &&
 
 	git clone "hg::hgrepo" gitrepo &&
-	check gitrepo next next &&
-
-	(cd hgrepo && hg checkout default) &&
-
-	git clone "hg::hgrepo" gitrepo2 &&
-	check gitrepo2 zero master
+	check gitrepo origin/branches/next next
 '
 
 test_expect_success 'cloning with bookmarks' '
@@ -83,25 +71,14 @@ test_expect_success 'cloning with bookmarks' '
 
 	(
 	cd hgrepo &&
+	hg checkout default &&
 	hg bookmark feature-a &&
 	echo feature-a > content &&
 	hg commit -m feature-a
 	) &&
 
 	git clone "hg::hgrepo" gitrepo &&
-	check gitrepo feature-a feature-a
-'
-
-test_expect_success 'cloning with detached head' '
-	test_when_finished "rm -rf gitrepo*" &&
-
-	(
-	cd hgrepo &&
-	hg update -r 0
-	) &&
-
-	git clone "hg::hgrepo" gitrepo &&
-	check gitrepo zero master
+	check gitrepo origin/feature-a feature-a
 '
 
 test_expect_success 'update bookmark' '
-- 
1.8.3.rc3.312.g47657de
