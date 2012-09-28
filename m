From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 21/21] git p4: introduce gitConfigBool
Date: Fri, 28 Sep 2012 08:04:25 -0400
Message-ID: <1348833865-6093-22-git-send-email-pw@padd.com>
References: <1348833865-6093-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 14:11:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THZPw-0004kA-B1
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 14:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757683Ab2I1MLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 08:11:31 -0400
Received: from honk.padd.com ([74.3.171.149]:58389 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757676Ab2I1MLa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 08:11:30 -0400
Received: from arf.padd.com (unknown [50.55.148.232])
	by honk.padd.com (Postfix) with ESMTPSA id 42A5C5AF2;
	Fri, 28 Sep 2012 05:11:30 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id E2F9731413; Fri, 28 Sep 2012 08:11:27 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.1.457.g468b3ef
In-Reply-To: <1348833865-6093-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206579>

Make the intent of "--bool" more obvious by returning a direct True
or False value.  Convert a couple non-bool users with obvious bool
intent.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py | 45 ++++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 007ef6b..524df12 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -515,17 +515,25 @@ def gitBranchExists(branch):
 
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
@@ -656,8 +664,7 @@ def p4PathStartsWith(path, prefix):
     #
     # we may or may not have a problem. If you have core.ignorecase=true,
     # we treat DirA and dira as the same directory
-    ignorecase = gitConfig("core.ignorecase", "--bool") == "true"
-    if ignorecase:
+    if gitConfigBool("core.ignorecase"):
         return path.lower().startswith(prefix.lower())
     return path.startswith(prefix)
 
@@ -892,7 +899,7 @@ class P4Submit(Command, P4UserMap):
         self.usage += " [name of git branch to submit into perforce depot]"
         self.origin = ""
         self.detectRenames = False
-        self.preserveUser = gitConfig("git-p4.preserveUser").lower() == "true"
+        self.preserveUser = gitConfigBool("git-p4.preserveUser")
         self.dry_run = False
         self.prepare_p4_only = False
         self.conflict_behavior = None
@@ -1000,7 +1007,7 @@ class P4Submit(Command, P4UserMap):
             (user,email) = self.p4UserForCommit(id)
             if not user:
                 msg = "Cannot find p4 user for email %s in commit %s." % (email, id)
-                if gitConfig('git-p4.allowMissingP4Users').lower() == "true":
+                if gitConfigBool("git-p4.allowMissingP4Users"):
                     print "%s" % msg
                 else:
                     die("Error: %s\nSet git-p4.allowMissingP4Users to true to allow this." % msg)
@@ -1095,7 +1102,7 @@ class P4Submit(Command, P4UserMap):
            message.  Return true if okay to continue with the submit."""
 
         # if configured to skip the editing part, just submit
-        if gitConfig("git-p4.skipSubmitEdit") == "true":
+        if gitConfigBool("git-p4.skipSubmitEdit"):
             return True
 
         # look at the modification time, to check later if the user saved
@@ -1111,7 +1118,7 @@ class P4Submit(Command, P4UserMap):
 
         # If the file was not saved, prompt to see if this patch should
         # be skipped.  But skip this verification step if configured so.
-        if gitConfig("git-p4.skipSubmitEditCheck") == "true":
+        if gitConfigBool("git-p4.skipSubmitEditCheck"):
             return True
 
         # modification time updated means user saved the file
@@ -1211,7 +1218,7 @@ class P4Submit(Command, P4UserMap):
 
             # Patch failed, maybe it's just RCS keyword woes. Look through
             # the patch to see if that's possible.
-            if gitConfig("git-p4.attemptRCSCleanup","--bool") == "true":
+            if gitConfigBool("git-p4.attemptRCSCleanup"):
                 file = None
                 pattern = None
                 kwfiles = {}
@@ -1506,7 +1513,7 @@ class P4Submit(Command, P4UserMap):
             sys.exit(128)
 
         self.useClientSpec = False
-        if gitConfig("git-p4.useclientspec", "--bool") == "true":
+        if gitConfigBool("git-p4.useclientspec"):
             self.useClientSpec = True
         if self.useClientSpec:
             self.clientSpecDirs = getClientSpec()
@@ -1546,7 +1553,7 @@ class P4Submit(Command, P4UserMap):
             commits.append(line.strip())
         commits.reverse()
 
-        if self.preserveUser or (gitConfig("git-p4.skipUserNameCheck") == "true"):
+        if self.preserveUser or gitConfigBool("git-p4.skipUserNameCheck"):
             self.checkAuthorship = False
         else:
             self.checkAuthorship = True
@@ -1582,7 +1589,7 @@ class P4Submit(Command, P4UserMap):
         else:
             self.diffOpts += " -C%s" % detectCopies
 
-        if gitConfig("git-p4.detectCopiesHarder", "--bool") == "true":
+        if gitConfigBool("git-p4.detectCopiesHarder"):
             self.diffOpts += " --find-copies-harder"
 
         #
@@ -1664,7 +1671,7 @@ class P4Submit(Command, P4UserMap):
                                            "--format=format:%h %s",  c])
                 print "You will have to do 'git p4 sync' and rebase."
 
-        if gitConfig("git-p4.exportLabels", "--bool") == "true":
+        if gitConfigBool("git-p4.exportLabels"):
             self.exportLabels = True
 
         if self.exportLabels:
@@ -2757,7 +2764,7 @@ class P4Sync(Command, P4UserMap):
             # will use this after clone to set the variable
             self.useClientSpec_from_options = True
         else:
-            if gitConfig("git-p4.useclientspec", "--bool") == "true":
+            if gitConfigBool("git-p4.useclientspec"):
                 self.useClientSpec = True
         if self.useClientSpec:
             self.clientSpecDirs = getClientSpec()
@@ -2954,7 +2961,7 @@ class P4Sync(Command, P4UserMap):
                             sys.stdout.write("%s " % b)
                         sys.stdout.write("\n")
 
-        if gitConfig("git-p4.importLabels", "--bool") == "true":
+        if gitConfigBool("git-p4.importLabels"):
             self.importLabels = True
 
         if self.importLabels:
-- 
1.7.12.1.403.g28165e1
