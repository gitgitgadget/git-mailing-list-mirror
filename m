From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] Rework of the 'stg pull' policy.
Date: Wed, 21 Feb 2007 00:16:11 +0100
Message-ID: <20070220231407.3194.1053.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 21 00:48:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJeiF-0006YK-S7
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 00:48:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161095AbXBTXry (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 18:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161091AbXBTXry
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 18:47:54 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:60262 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161095AbXBTXrx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 18:47:53 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id BF6DA59C6F;
	Wed, 21 Feb 2007 00:47:51 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 2E7701F084;
	Wed, 21 Feb 2007 00:16:12 +0100 (CET)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40265>


This patch changes the way "stg pull" behaviour is selected, by
replacing stgit.pull-does-rebase and stgit.pullcmd with
stgit.pull-policy, stgit.pullcmd and stgit.fetchcmd.  In the standard
case, only pull-policy needs to be set.

Those 3 config variables are also available per-branch as
branch.*.stgit.<name>.

This patch also add a set of tests for the fetch-rebase policy,
including interferences with "stg commit" occuring with 0.12.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

This is an implementation of the solution described in my previous
mail.

 examples/gitconfig           |   17 ++++++----
 stgit/commands/pull.py       |   23 +++++++++++--
 stgit/config.py              |    5 ++-
 stgit/git.py                 |   19 +++++++++++
 t/t2100-pull-policy-fetch.sh |   72 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 123 insertions(+), 13 deletions(-)

diff --git a/examples/gitconfig b/examples/gitconfig
index 4e775fc..637f153 100644
--- a/examples/gitconfig
+++ b/examples/gitconfig
@@ -33,14 +33,19 @@
 	#pager = ~/share/stgit/contrib/diffcol.sh
 	#pager = filterdiff --annotate | colordiff | less -FRX
 
-	# GIT pull command (should take the same arguments as
+	# GIT pull and fetch commands (should take the same arguments as
 	# git-fetch or git-pull).  By default:
-	#pullcmd = git-fetch
-	#pull-does-rebase = yes
-	# Alternative (old behaviour), less intuitive but maybe useful
-	# for some workflows:
 	#pullcmd = git-pull
-	#pull-does-rebase = no
+	#fetchcmd = git-fetch
+
+	# "stg pull" policy.  This is the repository default, which can be
+	# overriden on a per-branch basis using branch.*.stgit.pull-policy
+	# By default:
+	#pull-policy = pull
+	# To support remote rewinding parent branches:
+	#pull-policy = fetch-rebase
+	# To support local parent branches:
+	#pull-policy = rebase
 
 	# The three-way merge tool. Note that the 'output' file contains the
 	# same data as 'branch1'. This is useful for tools that do not take an
diff --git a/stgit/commands/pull.py b/stgit/commands/pull.py
index 990244e..e4a2b62 100644
--- a/stgit/commands/pull.py
+++ b/stgit/commands/pull.py
@@ -64,14 +64,29 @@ def func(parser, options, args):
     check_conflicts()
     check_head_top_equal()
 
-    must_rebase = (config.get('stgit.pull-does-rebase') == 'yes')
+    policy = config.get('branch.%s.stgit.pull-policy' % crt_series.get_branch()) or \
+             config.get('stgit.pull-policy')
+    if policy == 'pull':
+        must_rebase = 0
+    elif policy == 'fetch-rebase':
+        must_rebase = 1
+    elif policy == 'rebase':
+        must_rebase = 1
+    else:
+        raise config.ConfigException, 'Unsupported pull-policy "%s"' % policy
+
     applied = prepare_rebase(real_rebase=must_rebase, force=options.force)
 
     # pull the remote changes
-    print 'Pulling from "%s"...' % repository
-    git.fetch(repository)
-    if must_rebase:
+    if policy == 'pull':
+        print 'Pulling from "%s"...' % repository
+        git.pull(repository)
+    elif policy == 'fetch-rebase':
+        print 'Fetching from "%s"...' % repository
+        git.fetch(repository)
         rebase(git.fetch_head())
+    elif policy == 'rebase':
+        rebase(crt_series.get_parent_branch())
 
     post_rebase(applied, options.nopush, options.merged)
 
diff --git a/stgit/config.py b/stgit/config.py
index fb38932..b016fbd 100644
--- a/stgit/config.py
+++ b/stgit/config.py
@@ -29,8 +29,9 @@ class GitConfig:
         'stgit.autoresolved':	'no',
         'stgit.smtpserver':	'localhost:25',
         'stgit.smtpdelay':	'5',
-        'stgit.pullcmd':	'git-fetch',
-        'stgit.pull-does-rebase': 'yes',
+        'stgit.pullcmd':	'git-pull',
+        'stgit.fetchcmd':	'git-fetch',
+        'stgit.pull-policy':	'pull',
         'stgit.merger':		'diff3 -L current -L ancestor -L patched -m -E ' \
 				'"%(branch1)s" "%(ancestor)s" "%(branch2)s" > "%(output)s"',
         'stgit.autoimerge':	'no',
diff --git a/stgit/git.py b/stgit/git.py
index 46ba5c8..458eb97 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -817,7 +817,24 @@ def fetch(repository = 'origin', refspec = None):
     if refspec:
         args.append(refspec)
 
-    command = config.get('stgit.pullcmd')
+    command = config.get('branch.%s.stgit.fetchcmd' % get_head_file()) or \
+              config.get('stgit.fetchcmd')
+    if __run(command, args) != 0:
+        raise GitException, 'Failed "%s %s"' % (command, repository)
+
+def pull(repository = 'origin', refspec = None):
+    """Fetches changes from the remote repository, using 'git-pull'
+    by default.
+    """
+    # we update the HEAD
+    __clear_head_cache()
+
+    args = [repository]
+    if refspec:
+        args.append(refspec)
+
+    command = config.get('branch.%s.stgit.pullcmd' % get_head_file()) or \
+              config.get('stgit.pullcmd')
     if __run(command, args) != 0:
         raise GitException, 'Failed "%s %s"' % (command, repository)
 
diff --git a/t/t2100-pull-policy-fetch.sh b/t/t2100-pull-policy-fetch.sh
new file mode 100755
index 0000000..e1398a3
--- /dev/null
+++ b/t/t2100-pull-policy-fetch.sh
@@ -0,0 +1,72 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Yann Dirson
+#
+
+test_description='Excercise pull-policy "fetch-rebase".'
+
+. ./test-lib.sh
+
+# don't need this repo, but better not drop it, see t1100
+#rm -rf .git
+
+# Need a repo to clone
+test_create_repo upstream
+
+test_expect_success \
+    'Setup upstream repo, clone it, and add patches to the clone' \
+    '
+    (cd upstream && stg init) &&
+    stg clone upstream clone &&
+    (cd clone &&
+     git repo-config branch.master.stgit.pull-policy fetch-rebase &&
+     git repo-config --list &&
+     stg new c1 -m c1 &&
+     echo a > file && stg add file && stg refresh
+    )
+    '
+
+test_expect_success \
+    'Add non-rewinding commit upstream and pull it from clone' \
+    '
+    (cd upstream && stg new u1 -m u1 &&
+     echo a > file2 && stg add file2 && stg refresh) &&
+    (cd clone && stg pull) &&
+    test -e clone/file2
+    '
+
+# note: with pre-1.5 Git the clone is not automatically recorded
+# as rewinding, and thus heads/origin is not moved, but the stack
+# is still correctly rebased
+test_expect_success \
+    'Rewind/rewrite upstream commit and pull it from clone' \
+    '
+    (cd upstream && echo b >> file2 && stg refresh) &&
+    (cd clone && stg pull) &&
+    test `wc -l <clone/file2` = 2
+    '
+
+# this one ensures the guard against commits does not unduly trigger
+test_expect_success \
+    'Rewind/rewrite upstream commit and fetch it from clone before pulling' \
+    '
+    (cd upstream && echo c >> file2 && stg refresh) &&
+    (cd clone && git fetch && stg pull) &&
+    test `wc -l <clone/file2` = 3
+    '
+
+# this one exercises the guard against commits
+# (use a new file to avoid mistaking a conflict for a success)
+test_expect_success \
+    'New upstream commit and commit a patch in clone' \
+    '
+    (cd upstream && stg new u2 -m u2 &&
+     echo a > file3 && stg add file3 && stg refresh) &&
+    (cd clone && stg commit && stg new c2 -m c2 &&
+     echo a >> file && stg refresh)
+    '
+test_expect_failure \
+    'Try to  and commit a patch in clone' \
+    '(cd clone && stg pull)'
+
+test_done
