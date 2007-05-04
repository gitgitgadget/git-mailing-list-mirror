From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT RFC PATCH] Activate rename detection by default.
Date: Sat, 05 May 2007 01:54:33 +0200
Message-ID: <20070504235413.29479.13640.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 05 01:56:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk7dC-0002Op-Dy
	for gcvg-git@gmane.org; Sat, 05 May 2007 01:56:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767926AbXEDXzS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 19:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767921AbXEDXzR
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 19:55:17 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:34725 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767923AbXEDXzO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 19:55:14 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 90EC338C8;
	Sat,  5 May 2007 01:55:12 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 6E09F1F15A;
	Sat,  5 May 2007 01:54:33 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46230>


This patch uses -M when generating diffs, which then looks fine, just
like any other git-generated diff.

While I was at it, I also added -M when calling "stg files" or "stg
status".  While we need that for completeness, we currently just
display the raw git-diff-tree output, and it may break some scripts.
We may also want to make it more human-readable (not sure how, esp. if
we want to remain machine-parsable).

It also raises the issue of whether to activate this by default or not
(mostly in status and files), and how to select this behaviour -
something which will possibly be needed to be decided before
introducing -C and --find-copies-harder, which would be useful as
well, the latter being definitely a candidate to be off by default.

That gives:

$ ./stg status
? contrib/stg-push-force
R100 README     README2
M stgit/git.py

$ ./stg files sink 
R056 Documentation/stg-bury.txt Documentation/stg-sink.txt
M Documentation/stg.txt
M contrib/stgit-completion.bash
R093 stgit/commands/bury.py     stgit/commands/sink.py
M stgit/main.py

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 README2      |    0 
 stgit/git.py |   12 ++++++------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/README b/README2
similarity index 100%
rename from README
rename to README2
diff --git a/stgit/git.py b/stgit/git.py
index d7eb48e..ed09eca 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -255,7 +255,7 @@ def __tree_status(files = None, tree_id = 'HEAD', unknown = False,
     cache_files += [('C', filename) for filename in conflicts]
 
     # the rest
-    for line in _output_lines(['git-diff-index', tree_id, '--'] + files):
+    for line in _output_lines(['git-diff-index', '-M', tree_id, '--'] + files):
         fs = tuple(line.rstrip().split(' ',4)[-1].split('\t',1))
         if fs[1] not in conflicts:
             cache_files.append(fs)
@@ -774,13 +774,13 @@ def diff(files = None, rev1 = 'HEAD', rev2 = None, out_fd = None):
         files = []
 
     if rev1 and rev2:
-        diff_str = _output(['git-diff-tree', '-p', rev1, rev2, '--'] + files)
+        diff_str = _output(['git-diff-tree', '-M', '-p', rev1, rev2, '--'] + files)
     elif rev1 or rev2:
         refresh_index()
         if rev2:
-            diff_str = _output(['git-diff-index', '-p', '-R', rev2, '--'] + files)
+            diff_str = _output(['git-diff-index', '-M', '-p', '-R', rev2, '--'] + files)
         else:
-            diff_str = _output(['git-diff-index', '-p', rev1, '--'] + files)
+            diff_str = _output(['git-diff-index', '-M', '-p', rev1, '--'] + files)
     else:
         diff_str = ''
 
@@ -808,7 +808,7 @@ def files(rev1, rev2):
     """
 
     result = ''
-    for line in _output_lines('git-diff-tree -r %s %s' % (rev1, rev2)):
+    for line in _output_lines('git-diff-tree -M -r %s %s' % (rev1, rev2)):
         result += '%s %s\n' % tuple(line.rstrip().split(' ',4)[-1].split('\t',1))
 
     return result.rstrip()
@@ -826,7 +826,7 @@ def barefiles(rev1, rev2):
 def pretty_commit(commit_id = 'HEAD'):
     """Return a given commit (log + diff)
     """
-    return _output(['git-diff-tree', '--cc', '--always', '--pretty', '-r',
+    return _output(['git-diff-tree', '-M', '--cc', '--always', '--pretty', '-r',
                     commit_id])
 
 def checkout(files = None, tree_id = None, force = False):
