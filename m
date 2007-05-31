From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 3/4] Make diff flags handling more modular.
Date: Fri, 01 Jun 2007 00:34:33 +0200
Message-ID: <20070531223433.6005.27608.stgit@gandelf.nowhere.earth>
References: <20070531222920.6005.74481.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 01 00:36:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HttGF-0006MX-9j
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 00:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460AbXEaWgs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 May 2007 18:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753976AbXEaWgs
	(ORCPT <rfc822;git-outgoing>); Thu, 31 May 2007 18:36:48 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:51742 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753460AbXEaWgr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2007 18:36:47 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 552A873AE;
	Fri,  1 Jun 2007 00:36:46 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id B84921F157;
	Fri,  1 Jun 2007 00:34:33 +0200 (CEST)
In-Reply-To: <20070531222920.6005.74481.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48827>




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/commands/diff.py   |    7 ++++++-
 stgit/commands/export.py |    8 +++++++-
 stgit/commands/mail.py   |    7 ++++++-
 stgit/git.py             |   12 ++++--------
 4 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/stgit/commands/diff.py b/stgit/commands/diff.py
index f56cbeb..b66c75b 100644
--- a/stgit/commands/diff.py
+++ b/stgit/commands/diff.py
@@ -79,10 +79,15 @@ def func(parser, options, args):
         rev1 = 'HEAD'
         rev2 = None
 
+    if options.binary:
+        diff_flags = [ '--binary' ]
+    else:
+        diff_flags = []
+
     if options.stat:
         out.stdout_raw(git.diffstat(args, git_id(rev1), git_id(rev2)) + '\n')
     else:
         diff_str = git.diff(args, git_id(rev1), git_id(rev2),
-                            binary = options.binary)
+                            diff_flags = diff_flags )
         if diff_str:
             pager(diff_str)
diff --git a/stgit/commands/export.py b/stgit/commands/export.py
index cafcbe3..d6b36a9 100644
--- a/stgit/commands/export.py
+++ b/stgit/commands/export.py
@@ -87,6 +87,11 @@ def func(parser, options, args):
             os.makedirs(dirname)
         series = file(os.path.join(dirname, 'series'), 'w+')
 
+    if options.binary:
+        diff_flags = [ '--binary' ]
+    else:
+        diff_flags = []
+
     applied = crt_series.get_applied()
     if len(args) != 0:
         patches = parse_patches(args, applied)
@@ -175,7 +180,8 @@ def func(parser, options, args):
         # write the diff
         git.diff(rev1 = patch.get_bottom(),
                  rev2 = patch.get_top(),
-                 out_fd = f, binary = options.binary)
+                 out_fd = f,
+                 diff_flags = diff_flags )
         if not options.stdout:
             f.close()
         patch_no += 1
diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index b95014c..7113cff 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -377,6 +377,11 @@ def __build_message(tmpl, patch, patch_nr, total_nr, msg_id, ref_id, options):
     else:
         prefix_str = ''
         
+    if options.binary:
+        diff_flags = [ '--binary' ]
+    else:
+        diff_flags = []
+
     total_nr_str = str(total_nr)
     patch_nr_str = str(patch_nr).zfill(len(total_nr_str))
     if total_nr > 1:
@@ -394,7 +399,7 @@ def __build_message(tmpl, patch, patch_nr, total_nr, msg_id, ref_id, options):
                  'endofheaders': '',
                  'diff':         git.diff(rev1 = git_id('%s//bottom' % patch),
                                           rev2 = git_id('%s//top' % patch),
-                                          binary = options.binary),
+                                          diff_flags = diff_flags ),
                  'diffstat':     git.diffstat(rev1 = git_id('%s//bottom'%patch),
                                               rev2 = git_id('%s//top' % patch)),
                  # for backward template compatibility
diff --git a/stgit/git.py b/stgit/git.py
index 5cdc8cd..7358fae 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -770,27 +770,23 @@ def status(files = None, modified = False, new = False, deleted = False,
             out.stdout('%s' % fs[1])
 
 def diff(files = None, rev1 = 'HEAD', rev2 = None, out_fd = None,
-         binary = False):
+         diff_flags = []):
     """Show the diff between rev1 and rev2
     """
     if not files:
         files = []
 
-    args = []
-    if binary:
-        args.append('--binary')
-
     if rev1 and rev2:
-        diff_str = _output(['git-diff-tree', '-p'] + args
+        diff_str = _output(['git-diff-tree', '-p'] + diff_flags
                            + [rev1, rev2, '--'] + files)
     elif rev1 or rev2:
         refresh_index()
         if rev2:
             diff_str = _output(['git-diff-index', '-p', '-R']
-                               + args + [rev2, '--'] + files)
+                               + diff_flags + [rev2, '--'] + files)
         else:
             diff_str = _output(['git-diff-index', '-p']
-                               + args + [rev1, '--'] + files)
+                               + diff_flags + [rev1, '--'] + files)
     else:
         diff_str = ''
 
