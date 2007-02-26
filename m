From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] Factorize editor handling.
Date: Mon, 26 Feb 2007 20:48:12 +0100
Message-ID: <20070226194812.28907.80551.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 26 20:48:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLlps-0000vf-OS
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 20:48:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752467AbXBZTsV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 14:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752465AbXBZTsV
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 14:48:21 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:59168 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752467AbXBZTsU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 14:48:20 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 06F1159E77;
	Mon, 26 Feb 2007 20:48:19 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 01AEE1F084;
	Mon, 26 Feb 2007 20:48:12 +0100 (CET)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40650>


At the same time we trap the editor error for all editor calls, not
just when called from "stg mail".  We may want to define a new
exception for this though.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/commands/mail.py |   17 +----------------
 stgit/stack.py         |   14 +-------------
 stgit/utils.py         |   23 ++++++++++++++++++++++-
 3 files changed, 24 insertions(+), 30 deletions(-)

diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index 762829c..151a408 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -272,22 +272,7 @@ def __edit_message(msg):
     f.write(msg)
     f.close()
 
-    # the editor
-    editor = config.get('stgit.editor')
-    if editor:
-        pass
-    elif 'EDITOR' in os.environ:
-        editor = os.environ['EDITOR']
-    else:
-        editor = 'vi'
-    editor += ' %s' % fname
-
-    print 'Invoking the editor: "%s"...' % editor,
-    sys.stdout.flush()
-    err = os.system(editor)
-    if err:
-        raise CmdException, 'editor failed, exit code: %d' % err
-    print 'done'
+    call_editor(fname)
 
     # read the message back
     f = file(fname)
diff --git a/stgit/stack.py b/stgit/stack.py
index 99f10e5..feb77e3 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -91,19 +91,7 @@ def edit_file(series, line, comment, show_patch = True):
     print >> f, __comment_prefix, 'vi: set textwidth=75 filetype=diff nobackup:'
     f.close()
 
-    # the editor
-    editor = config.get('stgit.editor')
-    if editor:
-        pass
-    elif 'EDITOR' in os.environ:
-        editor = os.environ['EDITOR']
-    else:
-        editor = 'vi'
-    editor += ' %s' % fname
-
-    print 'Invoking the editor: "%s"...' % editor,
-    sys.stdout.flush()
-    print 'done (exit code: %d)' % os.system(editor)
+    call_editor(fname)
 
     f = file(fname, 'r+')
 
diff --git a/stgit/utils.py b/stgit/utils.py
index 67431ec..d7d4777 100644
--- a/stgit/utils.py
+++ b/stgit/utils.py
@@ -1,7 +1,8 @@
 """Common utility functions
 """
 
-import errno, os, os.path
+import errno, os, os.path, sys
+from stgit.config import config
 
 __copyright__ = """
 Copyright (C) 2005, Catalin Marinas <catalin.marinas@gmail.com>
@@ -152,3 +153,23 @@ def rename(basedir, file1, file2):
     create_dirs(os.path.dirname(full_file2))
     os.rename(os.path.join(basedir, file1), full_file2)
     remove_dirs(basedir, os.path.dirname(file1))
+
+def call_editor(filename):
+    """Run the editor on the specified filename."""
+
+    # the editor
+    editor = config.get('stgit.editor')
+    if editor:
+        pass
+    elif 'EDITOR' in os.environ:
+        editor = os.environ['EDITOR']
+    else:
+        editor = 'vi'
+    editor += ' %s' % filename
+
+    print 'Invoking the editor: "%s"...' % editor,
+    sys.stdout.flush()
+    err = os.system(editor)
+    if err:
+        raise Exception, 'editor failed, exit code: %d' % err
+    print 'done'
