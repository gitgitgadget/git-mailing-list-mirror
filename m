From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 1/2] Changed rebasing safety check to look for reachability of
	stack base (gna bug #9181).
Date: Sun, 03 Jun 2007 15:41:52 +0200
Message-ID: <20070603134152.1681.82748.stgit@gandelf.nowhere.earth>
References: <20070603133006.1681.1742.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 03 15:42:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuqLG-0006Sf-P0
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 15:41:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbXFCNly (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 09:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbXFCNlx
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 09:41:53 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:47633 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750883AbXFCNlx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 09:41:53 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id F1AB55A22C;
	Sun,  3 Jun 2007 15:41:51 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 9FBF51F019;
	Sun,  3 Jun 2007 15:41:52 +0200 (CEST)
In-Reply-To: <20070603133006.1681.1742.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48995>




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/commands/common.py |   23 +++++++++++++++--------
 stgit/commands/pull.py   |   12 ++++--------
 stgit/commands/rebase.py |    2 +-
 stgit/git.py             |    6 ++++++
 stgit/stack.py           |    1 -
 5 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index 22c78ae..a3df2a2 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -318,13 +318,22 @@ def address_or_alias(addr_str):
                  for addr in addr_str.split(',')]
     return ', '.join([addr for addr in addr_list if addr])
 
-def prepare_rebase(real_rebase, force=None):
+def prepare_rebase(force=None):
     if not force:
-        # Be sure we won't loose results of stg-(un)commit by error.
-        # Do not require an existing orig-base for compatibility with 0.12 and earlier.
-        origbase = crt_series._get_field('orig-base')
-        if origbase and crt_series.get_base() != origbase:
-            raise CmdException, 'Rebasing would possibly lose data'
+        # Be sure we won't loose results of stg-commit by error.
+        # Note: checking for refs/bases should not be necessary with
+        # repo format version 2, but better safe than sorry.
+        branchname = crt_series.get_branch()
+        # references for anything but the current stack
+        refs = [ref for ref in git.all_refs()
+                if ref != 'refs/heads/'+branchname
+                and ref != 'refs/bases/'+branchname
+                and not re.match('^refs/patches/%s/'%branchname, ref)]
+        stray_commits = git._output_lines(['git-rev-list',
+                                           crt_series.get_base(),
+                                           '--not'] + refs)
+        if len(stray_commits) != 0:
+            raise CmdException, 'Rebasing would make the following commits below the stack base unreachable: %s' % stray_commits
 
     # pop all patches
     applied = crt_series.get_applied()
@@ -343,8 +352,6 @@ def rebase(target):
     out.done()
 
 def post_rebase(applied, nopush, merged):
-    # memorize that we rebased to here
-    crt_series._set_field('orig-base', git.get_head())
     # push the patches back
     if not nopush:
         push_patches(applied, merged)
diff --git a/stgit/commands/pull.py b/stgit/commands/pull.py
index beaa7b5..bacd5fc 100644
--- a/stgit/commands/pull.py
+++ b/stgit/commands/pull.py
@@ -77,16 +77,12 @@ def func(parser, options, args):
     check_conflicts()
     check_head_top_equal()
 
-    if policy == 'pull':
-        must_rebase = 0
-    elif policy == 'fetch-rebase':
-        must_rebase = 1
-    elif policy == 'rebase':
-        must_rebase = 1
-    else:
+    if (policy != 'pull') \
+           and (policy != 'fetch-rebase') \
+           and (policy != 'rebase'):
         raise GitConfigException, 'Unsupported pull-policy "%s"' % policy
 
-    applied = prepare_rebase(real_rebase=must_rebase, force=options.force)
+    applied = prepare_rebase(force=options.force)
 
     # pull the remote changes
     if policy == 'pull':
diff --git a/stgit/commands/rebase.py b/stgit/commands/rebase.py
index d132b60..13933d6 100644
--- a/stgit/commands/rebase.py
+++ b/stgit/commands/rebase.py
@@ -52,7 +52,7 @@ def func(parser, options, args):
     check_conflicts()
     check_head_top_equal()
 
-    applied = prepare_rebase(real_rebase=True, force=options.force)
+    applied = prepare_rebase(force=options.force)
     rebase(args[0])
     post_rebase(applied, options.nopush, options.merged)
 
diff --git a/stgit/git.py b/stgit/git.py
index 4bc41aa..bec691b 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -1070,3 +1070,9 @@ def fetch_head():
 
     # here we are sure to have a single fetch_head
     return fetch_head
+
+def all_refs():
+    """Return a list of all refs in the current repository.
+    """
+
+    return [line.split()[1] for line in _output_lines(['git-show-ref'])]
diff --git a/stgit/stack.py b/stgit/stack.py
index 7a06458..45fd98a 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -588,7 +588,6 @@ class Series(StgitObject):
         self.create_empty_field('applied')
         self.create_empty_field('unapplied')
         os.makedirs(self.__refs_dir)
-        self._set_field('orig-base', git.get_head())
 
         config.set(format_version_key(self.get_branch()), str(FORMAT_VERSION))
 
