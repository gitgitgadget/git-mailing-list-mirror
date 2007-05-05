From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 2/2] Copy patchlogs when cloning a stack or picking a patch.
Date: Sat, 05 May 2007 16:00:28 +0200
Message-ID: <20070505140028.5194.46650.stgit@gandelf.nowhere.earth>
References: <20070505135830.5194.90861.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 05 18:01:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkMhP-0007qT-8m
	for gcvg-git@gmane.org; Sat, 05 May 2007 18:01:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423283AbXEEQBK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 May 2007 12:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423399AbXEEQBJ
	(ORCPT <rfc822;git-outgoing>); Sat, 5 May 2007 12:01:09 -0400
Received: from postfix1-g20.free.fr ([212.27.60.42]:49985 "EHLO
	postfix1-g20.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423398AbXEEQBA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2007 12:01:00 -0400
Received: from smtp3-g19.free.fr (smtp3-g19.free.fr [212.27.42.29])
	by postfix1-g20.free.fr (Postfix) with ESMTP id C7096F27B90
	for <git@vger.kernel.org>; Sat,  5 May 2007 16:02:10 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id DC3EA5F298;
	Sat,  5 May 2007 16:01:09 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id BF31F1F15F;
	Sat,  5 May 2007 16:00:28 +0200 (CEST)
In-Reply-To: <20070505135830.5194.90861.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46260>


This will allow to keep patch history accross those operations, and
see when they diverged when looking at the respective patchlogs.  With
more work, that will allow to locate the common ancestor when sync'ing
a patch across branches.

The work on "pick" can still be improved: currently the patchlog is
preserved on "pick patch[@branch][//top]", but we could make it work
for //top.old as well (or any rev in the patchlog when we'll be able
to name those).

Patchlog preservation in pick can only work when referencing a patch
by name.  When picking an arbitrary commit we could also improve
things by recording a "pick" operation instead of a "new".

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/commands/pick.py |   31 ++++++++++++++++++++++++++-----
 stgit/stack.py         |   22 +++++++++++++++-------
 2 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/stgit/commands/pick.py b/stgit/commands/pick.py
index 4eb79a3..4ef9860 100644
--- a/stgit/commands/pick.py
+++ b/stgit/commands/pick.py
@@ -21,6 +21,7 @@ from optparse import OptionParser, make_option
 from stgit.commands.common import *
 from stgit.utils import *
 from stgit import stack, git
+from stgit.stack import Series
 
 
 help = 'import a patch from a different branch or a commit object'
@@ -118,11 +119,31 @@ def func(parser, options, args):
         print 'Importing commit %s...' % commit_id,
         sys.stdout.flush()
 
-        crt_series.new_patch(patchname, message = message, can_edit = False,
-                             unapplied = True, bottom = bottom, top = top,
-                             author_name = author_name,
-                             author_email = author_email,
-                             author_date = author_date)
+        newpatch = crt_series.new_patch(patchname, message = message, can_edit = False,
+                                        unapplied = True, bottom = bottom, top = top,
+                                        author_name = author_name,
+                                        author_email = author_email,
+                                        author_date = author_date)
+        # find a patchlog to fork from
+        (refpatchname, refbranchname, refpatchid) = parse_rev(commit_str)
+        if refpatchname and not refpatchid and \
+               (not refpatchid or refpatchid == 'top'):
+            # FIXME: should also support picking //top.old
+            if refbranchname:
+                # assume the refseries is OK, since we already resolved
+                # commit_str to a git_id
+                refseries = Series(refbranchname)
+            else:
+                refseries = crt_series
+            patch = refseries.get_patch(refpatchname)
+            if patch.get_log():
+                print"log was %s" % newpatch.get_log()
+                print "setting log to %s\n" %  patch.get_log()
+                newpatch.set_log(patch.get_log())
+                print"log is now %s" % newpatch.get_log()
+            else:
+                print "no log for %s\n" % patchname
+ 
         if not options.unapplied:
             modified = crt_series.push_patch(patchname)
         else:
diff --git a/stgit/stack.py b/stgit/stack.py
index b0a01dd..044348a 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -23,6 +23,7 @@ import sys, os, re
 from stgit.utils import *
 from stgit import git, basedir, templates
 from stgit.config import config
+from shutil import copyfile
 
 
 # stack exception class
@@ -628,13 +629,18 @@ class Series(StgitObject):
             patches = applied = unapplied = []
         for p in patches:
             patch = self.get_patch(p)
-            new_series.new_patch(p, message = patch.get_description(),
-                                 can_edit = False, unapplied = True,
-                                 bottom = patch.get_bottom(),
-                                 top = patch.get_top(),
-                                 author_name = patch.get_authname(),
-                                 author_email = patch.get_authemail(),
-                                 author_date = patch.get_authdate())
+            newpatch = new_series.new_patch(p, message = patch.get_description(),
+                                            can_edit = False, unapplied = True,
+                                            bottom = patch.get_bottom(),
+                                            top = patch.get_top(),
+                                            author_name = patch.get_authname(),
+                                            author_email = patch.get_authemail(),
+                                            author_date = patch.get_authdate())
+            if patch.get_log():
+                print "setting log to %s" %  patch.get_log()
+                newpatch.set_log(patch.get_log())
+            else:
+                print "no log for %s" % patchname
 
         # fast forward the cloned series to self's top
         new_series.forward_patches(applied)
@@ -865,6 +871,8 @@ class Series(StgitObject):
             if refresh:
                 self.refresh_patch(cache_update = False, log = 'new')
 
+        return patch
+
     def delete_patch(self, name):
         """Deletes a patch
         """
