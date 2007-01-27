From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 5/5] Make 'stg pull' use git-fetch and not git-pull.
Date: Sat, 27 Jan 2007 12:21:38 +0100
Message-ID: <20070127112138.16475.92752.stgit@gandelf.nowhere.earth>
References: <20070127104024.16475.81445.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 27 12:23:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAle7-00059K-RC
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 12:23:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240AbXA0LWw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 06:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752252AbXA0LWw
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 06:22:52 -0500
Received: from smtp4-g19.free.fr ([212.27.42.30]:40340 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752247AbXA0LWv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 06:22:51 -0500
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 1A3C08888;
	Sat, 27 Jan 2007 12:22:50 +0100 (CET)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by bylbo.nowhere.earth with esmtp (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1HAleH-0003ZX-5P; Sat, 27 Jan 2007 12:23:09 +0100
In-Reply-To: <20070127104024.16475.81445.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37944>


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
index 5e7b240..e3d9889 100644
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
index f5fbdab..0d4da06 100644
--- a/stgit/config.py
+++ b/stgit/config.py
@@ -65,7 +65,8 @@ def config_setup():
     config.set('stgit', 'autoresolved', 'no')
     config.set('stgit', 'smtpserver', 'localhost:25')
     config.set('stgit', 'smtpdelay', '5')
-    config.set('stgit', 'pullcmd', 'git-pull')
+    config.set('stgit', 'pullcmd', 'git-fetch')
+    config.set('stgit', 'pull-does-rebase', 'yes')
     config.set('stgit', 'merger',
                'diff3 -L current -L ancestor -L patched -m -E ' \
                '"%(branch1)s" "%(ancestor)s" "%(branch2)s" > "%(output)s"')
diff --git a/stgit/git.py b/stgit/git.py
index 3c2c237..82b5bf5 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -806,18 +806,23 @@ def reset(files = None, tree_id = None, check_out = True):
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
 
-    if __run(config.get('stgit', 'pullcmd'), args) != 0:
-        raise GitException, 'Failed "git-pull %s"' % repository
+    command = config.get('stgit', 'pullcmd')
+    if __run(command, args) != 0:
+        raise GitException, 'Failed "%s %s"' % (command, repository)
+
+    if (config.get('stgit', 'pull-does-rebase')):
+        # FIXME!
+        reset(tree_id = rev_parse(repository))
 
 def repack():
     """Repack all objects into a single pack
