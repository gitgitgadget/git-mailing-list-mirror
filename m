From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 21/21] git p4: introduce gitConfigBool
Date: Sat, 26 Jan 2013 22:11:24 -0500
Message-ID: <1359256284-5660-22-git-send-email-pw@padd.com>
References: <1359256284-5660-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 27 04:18:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzIle-0007XC-5z
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 04:18:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755463Ab3A0DS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 22:18:29 -0500
Received: from honk.padd.com ([74.3.171.149]:44490 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755433Ab3A0DS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 22:18:28 -0500
Received: from arf.padd.com (unknown [50.52.174.88])
	by honk.padd.com (Postfix) with ESMTPSA id DB1B82F3F;
	Sat, 26 Jan 2013 19:18:27 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 23ED522838; Sat, 26 Jan 2013 22:18:25 -0500 (EST)
X-Mailer: git-send-email 1.8.1.1.517.gf5c753f
In-Reply-To: <1359256284-5660-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214672>

Make the intent of "--bool" more obvious by returning a direct True
or False value.  Convert a couple non-bool users with obvious bool
intent.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py | 45 ++++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index ff3e8c9..955a5dd 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -561,17 +561,25 @@ def gitBranchExists(branch):
 
 _gitConfig = {}
 
-def gitConfig(key, args=None): # set args to "--bool", for instance
+def gitConfig(key):
     if not _gitConfig.has_key(key):
-        cmd = [ "git", "config" ]
-        if args:
-            assert(args == "--bool")
-            cmd.append(args)
-        cmd.append(key)
+        cmd = [ "git", "config", key ]
         s = read_pipe(cmd, ignore_error=True)
         _gitConfig[key] = s.strip()
     return _gitConfig[key]
 
+def gitConfigBool(key):
+    """Return a bool, using git config --bool.  It is True only if the
+       variable is set to true, and False if set to false or not present
+       in the config."""
+
+    if not _gitConfig.has_key(key):
+        cmd = [ "git", "config", "--bool", key ]
+        s = read_pipe(cmd, ignore_error=True)
+        v = s.strip()
+        _gitConfig[key] = v == "true"
+    return _gitConfig[key]
+
 def gitConfigList(key):
     if not _gitConfig.has_key(key):
         s = read_pipe(["git", "config", "--get-all", key], ignore_error=True)
@@ -722,8 +730,7 @@ def p4PathStartsWith(path, prefix):
     #
     # we may or may not have a problem. If you have core.ignorecase=true,
     # we treat DirA and dira as the same directory
-    ignorecase = gitConfig("core.ignorecase", "--bool") == "true"
-    if ignorecase:
+    if gitConfigBool("core.ignorecase"):
         return path.lower().startswith(prefix.lower())
     return path.startswith(prefix)
 
@@ -959,7 +966,7 @@ class P4Submit(Command, P4UserMap):
         self.usage += " [name of git branch to submit into perforce depot]"
         self.origin = ""
         self.detectRenames = False
-        self.preserveUser = gitConfig("git-p4.preserveUser").lower() == "true"
+        self.preserveUser = gitConfigBool("git-p4.preserveUser")
         self.dry_run = False
         self.prepare_p4_only = False
         self.conflict_behavior = None
@@ -1068,7 +1075,7 @@ class P4Submit(Command, P4UserMap):
             (user,email) = self.p4UserForCommit(id)
             if not user:
                 msg = "Cannot find p4 user for email %s in commit %s." % (email, id)
-                if gitConfig('git-p4.allowMissingP4Users').lower() == "true":
+                if gitConfigBool("git-p4.allowMissingP4Users"):
                     print "%s" % msg
                 else:
                     die("Error: %s\nSet git-p4.allowMissingP4Users to true to allow this." % msg)
@@ -1163,7 +1170,7 @@ class P4Submit(Command, P4UserMap):
            message.  Return true if okay to continue with the submit."""
 
         # if configured to skip the editing part, just submit
-        if gitConfig("git-p4.skipSubmitEdit") == "true":
+        if gitConfigBool("git-p4.skipSubmitEdit"):
             return True
 
         # look at the modification time, to check later if the user saved
@@ -1179,7 +1186,7 @@ class P4Submit(Command, P4UserMap):
 
         # If the file was not saved, prompt to see if this patch should
         # be skipped.  But skip this verification step if configured so.
-        if gitConfig("git-p4.skipSubmitEditCheck") == "true":
+        if gitConfigBool("git-p4.skipSubmitEditCheck"):
             return True
 
         # modification time updated means user saved the file
@@ -1279,7 +1286,7 @@ class P4Submit(Command, P4UserMap):
 
             # Patch failed, maybe it's just RCS keyword woes. Look through
             # the patch to see if that's possible.
-            if gitConfig("git-p4.attemptRCSCleanup","--bool") == "true":
+            if gitConfigBool("git-p4.attemptRCSCleanup"):
                 file = None
                 pattern = None
                 kwfiles = {}
@@ -1574,7 +1581,7 @@ class P4Submit(Command, P4UserMap):
             sys.exit(128)
 
         self.useClientSpec = False
-        if gitConfig("git-p4.useclientspec", "--bool") == "true":
+        if gitConfigBool("git-p4.useclientspec"):
             self.useClientSpec = True
         if self.useClientSpec:
             self.clientSpecDirs = getClientSpec()
@@ -1614,7 +1621,7 @@ class P4Submit(Command, P4UserMap):
             commits.append(line.strip())
         commits.reverse()
 
-        if self.preserveUser or (gitConfig("git-p4.skipUserNameCheck") == "true"):
+        if self.preserveUser or gitConfigBool("git-p4.skipUserNameCheck"):
             self.checkAuthorship = False
         else:
             self.checkAuthorship = True
@@ -1650,7 +1657,7 @@ class P4Submit(Command, P4UserMap):
         else:
             self.diffOpts += " -C%s" % detectCopies
 
-        if gitConfig("git-p4.detectCopiesHarder", "--bool") == "true":
+        if gitConfigBool("git-p4.detectCopiesHarder"):
             self.diffOpts += " --find-copies-harder"
 
         #
@@ -1734,7 +1741,7 @@ class P4Submit(Command, P4UserMap):
                                            "--format=format:%h %s",  c])
                 print "You will have to do 'git p4 sync' and rebase."
 
-        if gitConfig("git-p4.exportLabels", "--bool") == "true":
+        if gitConfigBool("git-p4.exportLabels"):
             self.exportLabels = True
 
         if self.exportLabels:
@@ -2834,7 +2841,7 @@ class P4Sync(Command, P4UserMap):
             # will use this after clone to set the variable
             self.useClientSpec_from_options = True
         else:
-            if gitConfig("git-p4.useclientspec", "--bool") == "true":
+            if gitConfigBool("git-p4.useclientspec"):
                 self.useClientSpec = True
         if self.useClientSpec:
             self.clientSpecDirs = getClientSpec()
@@ -3074,7 +3081,7 @@ class P4Sync(Command, P4UserMap):
                             sys.stdout.write("%s " % b)
                         sys.stdout.write("\n")
 
-        if gitConfig("git-p4.importLabels", "--bool") == "true":
+        if gitConfigBool("git-p4.importLabels"):
             self.importLabels = True
 
         if self.importLabels:
-- 
1.8.1.1.460.g6fa8886
