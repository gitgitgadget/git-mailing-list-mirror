From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 2/2] Use canonical command name in help message.
Date: Mon, 12 Feb 2007 22:08:29 +0100
Message-ID: <20070212210829.28413.16922.stgit@gandelf.nowhere.earth>
References: <20070212210628.28413.87407.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 12 22:09:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGiQq-0003UQ-M7
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 22:09:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965416AbXBLVJu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 16:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965413AbXBLVJu
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 16:09:50 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:47449 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965416AbXBLVJt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 16:09:49 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp5-g19.free.fr (Postfix) with ESMTP id B02DE279CB;
	Mon, 12 Feb 2007 22:09:48 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 807CE1F01C;
	Mon, 12 Feb 2007 22:08:29 +0100 (CET)
In-Reply-To: <20070212210628.28413.87407.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39440>


Let's expand shortcut command names in help messages, in all 3 forms
("help foo", "--help foo" and "foo --help").

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/main.py |   44 ++++++++++++++++++++++++--------------------
 1 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/stgit/main.py b/stgit/main.py
index 2da6bbc..f1b47f2 100644
--- a/stgit/main.py
+++ b/stgit/main.py
@@ -29,27 +29,31 @@ import stgit.commands
 class Commands(dict):
     """Commands class. It performs on-demand module loading
     """
+    def canonical_cmd(self, key):
+        """Return the canonical name for a possibly-shortenned
+        command name.
+        """
+        candidates = [cmd for cmd in self.keys() if cmd.startswith(key)]
+
+        if not candidates:
+            print >> sys.stderr, 'Unknown command: %s' % key
+            print >> sys.stderr, '  Try "%s help" for a list of ' \
+                  'supported commands' % prog
+            sys.exit(1)
+        elif len(candidates) > 1:
+            print >> sys.stderr, 'Ambiguous command: %s' % key
+            print >> sys.stderr, '  Candidates are: %s' \
+                  % ', '.join(candidates)
+            sys.exit(1)
+
+        return candidates[0]
+        
     def __getitem__(self, key):
         """Return the command python module name based.
         """
         global prog
 
-        cmd_mod = self.get(key)
-        if not cmd_mod:
-            candidates = [cmd for cmd in self.keys() if cmd.startswith(key)]
-
-            if not candidates:
-                print >> sys.stderr, 'Unknown command: %s' % key
-                print >> sys.stderr, '  Try "%s help" for a list of ' \
-                      'supported commands' % prog
-                sys.exit(1)
-            elif len(candidates) > 1:
-                print >> sys.stderr, 'Ambiguous command: %s' % key
-                print >> sys.stderr, '  Candidates are: %s' \
-                      % ', '.join(candidates)
-                sys.exit(1)
-
-            cmd_mod = self.get(candidates[0])
+        cmd_mod = self.get(key) or self.get(self.canonical_cmd(key))
             
         __import__('stgit.commands.' + cmd_mod)
         return getattr(stgit.commands, cmd_mod)
@@ -202,15 +206,15 @@ def main():
     cmd = sys.argv[1]
 
     if cmd in ['-h', '--help']:
-        if len(sys.argv) >= 3 and sys.argv[2] in commands:
-            cmd = sys.argv[2]
+        if len(sys.argv) >= 3:
+            cmd = commands.canonical_cmd(sys.argv[2])
             sys.argv[2] = '--help'
         else:
             print_help()
             sys.exit(0)
     if cmd == 'help':
         if len(sys.argv) == 3 and not sys.argv[2] in ['-h', '--help']:
-            cmd = sys.argv[2]
+            cmd = commands.canonical_cmd(sys.argv[2])
             if not cmd in commands:
                 print >> sys.stderr, '%s help: "%s" command unknown' \
                       % (prog, cmd)
@@ -236,7 +240,7 @@ def main():
         sys.exit(0)
 
     # re-build the command line arguments
-    sys.argv[0] += ' %s' % cmd
+    sys.argv[0] += ' %s' % commands.canonical_cmd(cmd)
     del(sys.argv[1])
 
     command = commands[cmd]
