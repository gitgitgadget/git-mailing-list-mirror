From: Pavel Roskin <proski@gnu.org>
Subject: RFC: Running StGIT in subdirectories
Date: Fri, 27 Jan 2006 01:33:14 -0500
Message-ID: <1138343594.1801.32.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jan 27 07:33:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F2NAl-0003fj-Vd
	for gcvg-git@gmane.org; Fri, 27 Jan 2006 07:33:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWA0GdV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jan 2006 01:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWA0GdV
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jan 2006 01:33:21 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:33204 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750750AbWA0GdV
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2006 01:33:21 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1F2NAH-0004xU-G5
	for git@vger.kernel.org; Fri, 27 Jan 2006 01:32:57 -0500
Received: from proski by dv.roinet.com with local (Exim 4.60)
	(envelope-from <proski@dv.roinet.com>)
	id 1F2NAZ-0000nR-3X; Fri, 27 Jan 2006 01:33:15 -0500
To: Catalin Marinas <catalin.marinas@gmail.com>,
	git <git@vger.kernel.org>
X-Mailer: Evolution 2.5.4 (2.5.4-10) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15177>

Hello!

This was intended as a patch, but I feel it needs to be discussed.
StGIT, as it stands now, is quite unaware of the fact that the current
directory may not match the top-level directory of the repository.

It works in most cases because git takes care of the issue, or because
StGIT is operating on repository wide objects (patches).  But in some
cases, StGIT fails or produces unexpected results.  My first encounter
was "stg refresh":

[proski@dv doc]$ stg refresh
Refreshing patch "docs"...error: doc/doc/Makefile: does not exist and --remove not passed
fatal: Unable to process file doc/Makefile
stg refresh: Failed git-update-index

What's worse is "stg export" creating patches that only cover changes
under the current directory.  I think the patches should be complete
unless the user requests otherwise.

Fortunately, it seems that most commands are doing the right thing, and
some commands are actually useful in subdirectories (e.g. add and rm).
I think it should be possible to fix the remaining commands or (in cases
when user's expectations are unclear) to disable them in subdirectories,
at least by default.

Here's the patch for "stg refresh".  It also introduces a function to
get the relative patch of the current directory.

Since the output of git-update-index uses path from the top, the path to
the current directory needs to be stripped from it.  I wonder if it's a
bug in git-update-index, by the way.

I'm a Python beginner.  I think there should be a way to avoid creating
a new list fsrel.  Also, I only want to replace the first occurrence of
rel_path, and only if it's in the beginning of the filename.  Maybe I
need regex for that?  Or maybe slicing would work?
Until it's done properly, it's not a 100% correct patch, but it's
working for me.

---
[PATCH] Add support for running "stg refresh" in subdirectories.

git-diff-index uses full path from the top of the repository in all
filenames it prints.  The path to the current directory needs to be
stripped.

Only files under the current directory will be refreshed.
---

 stgit/git.py |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/stgit/git.py b/stgit/git.py
index 582e803..045866e 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -90,6 +90,17 @@ def get_base_dir():
     else:
         return _output_one_line('git-rev-parse --git-dir')
 
+__rel_path = None
+
+def get_rel_path():
+    """Return path of the current directory relative to the top
+    """
+    global __rel_path
+
+    if not __rel_path:
+        __rel_path = _output_one_line('git-rev-parse --show-prefix')
+    return __rel_path
+
 def get_commit(id_hash):
     """Commit objects factory. Save/look-up them in the __commits
     dictionary
@@ -207,8 +218,9 @@ def __tree_status(files = None, tree_id 
     # the rest
     for line in _output_lines(['git-diff-index', tree_id] + files):
         fs = tuple(line.rstrip().split(' ',4)[-1].split('\t',1))
-        if fs[1] not in conflicts:
-            cache_files.append(fs)
+        fsrel = (fs[0], fs[1].replace(get_rel_path(), ''))
+        if fsrel[1] not in conflicts:
+            cache_files.append(fsrel)
 
     return cache_files
 

-- 
Regards,
Pavel Roskin
