From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 7/7] Make 'stg pull' use git-fetch and not git-pull.
Date: Tue, 30 Jan 2007 00:05:56 +0100
Message-ID: <20070129230555.7102.93948.stgit@gandelf.nowhere.earth>
References: <20070129230117.7102.64322.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 30 00:34:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBg10-00041G-Ew
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 00:34:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965004AbXA2XeS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 18:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbXA2XeS
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 18:34:18 -0500
Received: from smtp8-g19.free.fr ([212.27.42.65]:53857 "EHLO smtp8-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965004AbXA2XeR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 18:34:17 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp8-g19.free.fr (Postfix) with ESMTP id 2DBAE556B;
	Tue, 30 Jan 2007 00:34:16 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 065D12004;
	Tue, 30 Jan 2007 00:05:56 +0100 (CET)
In-Reply-To: <20070129230117.7102.64322.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38114>


We introduce a new pull-does-rebase setting, as companion to pullcmd.
This allows to use both pullcmd's that need a rebase (like git-fetch)
and pullcmd's that do not (like git-pull).

To be able to rebase, we rely on parent information being available
for the stack.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 examples/gitconfig |    8 +++++++-
 stgit/config.py    |    3 ++-
 stgit/git.py       |   15 ++++++++++-----
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/examples/gitconfig b/examples/gitconfig
index ee68d07..60f6e85 100644
--- a/examples/gitconfig
+++ b/examples/gitconfig
@@ -33,8 +33,14 @@
 	#pager = ~/share/stgit/contrib/diffcol.sh
 	#pager = filterdiff --annotate | colordiff | less -FRX
 
-	# GIT pull command (should take the same arguments as git-pull)
+	# GIT pull command (should take the same arguments as
+	# git-fetch or git-pull).  By default:
+	#pullcmd = git-fetch
+	#pull-does-rebase = yes
+	# Alternative (old behaviour), less intuitive but maybe useful
+	# for some workflows:
 	#pullcmd = git-pull
+	#pull-does-rebase = no
 
 	# The three-way merge tool. Note that the 'output' file contains the
 	# same data as 'branch1'. This is useful for tools that do not take an
diff --git a/stgit/config.py b/stgit/config.py
index 901f600..48b4e2d 100644
--- a/stgit/config.py
+++ b/stgit/config.py
@@ -29,7 +29,8 @@ class GitConfig:
         'stgit.autoresolved':	'no',
         'stgit.smtpserver':	'localhost:25',
         'stgit.smtpdelay':	'5',
-        'stgit.pullcmd':	'git-pull',
+        'stgit.pullcmd':	'git-fetch',
+        'stgit.pull-does-rebase': 'yes',
         'stgit.merger':		'diff3 -L current -L ancestor -L patched -m -E ' \
 				'"%(branch1)s" "%(ancestor)s" "%(branch2)s" > "%(output)s"',
         'stgit.autoimerge':	'no',
diff --git a/stgit/git.py b/stgit/git.py
index 038aaac..e30b959 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -808,18 +808,23 @@ def reset(files = None, tree_id = None, check_out = True):
         __set_head(tree_id)
 
 def pull(repository = 'origin', refspec = None):
-    """Pull changes from the remote repository. At the moment, just
-    use the 'git-pull' command
+    """Pull changes from the remote repository. Uses 'git-fetch'
+    and moves the stack base.
     """
-    # 'git-pull' updates the HEAD
+    # we update the HEAD
     __clear_head_cache()
 
     args = [repository]
     if refspec:
         args.append(refspec)
 
-    if __run(config.get('stgit.pullcmd'), args) != 0:
-        raise GitException, 'Failed "git-pull %s"' % repository
+    command = config.get('stgit.pullcmd')
+    if __run(command, args) != 0:
+        raise GitException, 'Failed "%s %s"' % (command, repository)
+
+    if (config.get('stgit.pull-does-rebase')):
+        # FIXME!
+        reset(tree_id = rev_parse(repository))
 
 def repack():
     """Repack all objects into a single pack
