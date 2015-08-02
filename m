From: larsxschneider@gmail.com
Subject: [PATCH] git-p4: fix faulty paths for case insensitive systems
Date: Sun,  2 Aug 2015 17:15:17 +0200
Message-ID: <1438528517-5028-2-git-send-email-larsxschneider@gmail.com>
References: <1438528517-5028-1-git-send-email-larsxschneider@gmail.com>
Cc: pw@padd.com, torarvid@gmail.com, ksaitoh560@gmail.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 02 17:15:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLuzN-0004Cr-VY
	for gcvg-git-2@plane.gmane.org; Sun, 02 Aug 2015 17:15:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbbHBPPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Aug 2015 11:15:46 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34753 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234AbbHBPPp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Aug 2015 11:15:45 -0400
Received: by wibud3 with SMTP id ud3so107917324wib.1
        for <git@vger.kernel.org>; Sun, 02 Aug 2015 08:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9pkqAj+lWnFvlx2ZBKQpen9xaBUC0UPC22QOqw/8iBQ=;
        b=hpQsexk4N7H140gB+aazY6o+1kTQSDWdI3Kb7bRaCbmQNPabvi4nHdxFZhlKYjpHFm
         jphsGYDr0GtVOAXfnWQMr84ZhdxAqHOpjIztc4ilmbITJXqMm7flSJZlkrF+Q1oesXjY
         2aFFxMs9jt+zeJW8jIrIeN5y6F/xwm33hEUSQ0ZfK8NRlk7KEF3ciODAWiNH0gICzh3R
         BU0uUbGkgLLqdhAVx+5CkP0C+DMKbvc6Rilx3Sm36wmKdofaqOa7EnUePL92RvF7OWND
         VPWwMpICdAEUb9rldu9yZCGpvnegiAy2iY8iiTvEAs6iBAPDo1Fi8rjjv4GvLuSTHM7m
         hp0Q==
X-Received: by 10.180.182.33 with SMTP id eb1mr24401927wic.8.1438528543680;
        Sun, 02 Aug 2015 08:15:43 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id dz4sm8617349wib.17.2015.08.02.08.15.42
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 02 Aug 2015 08:15:43 -0700 (PDT)
X-Mailer: git-send-email 1.9.5 (Apple Git-50.3)
In-Reply-To: <1438528517-5028-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275140>

From: Lars Schneider <larsxschneider@gmail.com>

PROBLEM:
We run P4 servers on Linux and P4 clients on Windows. For an unknown
reason the file path for a number of files in P4 does not match the
directory path with respect to case sensitivity.

E.g. `p4 files` might return
//depot/path/to/file1
//depot/PATH/to/file2

If you use P4/P4V then these files end up in the same directory, e.g.
//depot/path/to/file1
//depot/path/to/file2

If you use git-p4 then all files not matching the correct file path
(e.g. `file2`) will be ignored.

SOLUTION:
Identify files that are different with respect to case sensitivity.
If there are any then run `p4 dirs` to build up a dictionary
containing the correct cases for each path. Upon `clone` this
dictionary is used to fix the paths. All this is only applied if the
git config "core.ignorecase" is set.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 git-p4.py | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 77 insertions(+), 4 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 549022e..692f1f4 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1859,7 +1859,7 @@ class View(object):
                 (self.client_prefix, clientFile))
         return clientFile[len(self.client_prefix):]
 
-    def update_client_spec_path_cache(self, files):
+    def update_client_spec_path_cache(self, files, fixPathCase = None):
         """ Caching file paths by "p4 where" batch query """
 
         # List depot file paths exclude that already cached
@@ -1878,6 +1878,8 @@ class View(object):
             if "unmap" in res:
                 # it will list all of them, but only one not unmap-ped
                 continue
+            if fixPathCase:
+                res['depotFile'] = fixPathCase(res['depotFile'])
             self.client_spec_path_cache[res['depotFile']] = self.convert_client_path(res["clientFile"])
 
         # not found files or unmap files set to ""
@@ -1973,7 +1975,8 @@ class P4Sync(Command, P4UserMap):
         files = []
         fnum = 0
         while commit.has_key("depotFile%s" % fnum):
-            path =  commit["depotFile%s" % fnum]
+            path = commit["depotFile%s" % fnum]
+            path = self.fixPathCase(path)
 
             if [p for p in self.cloneExclude
                 if p4PathStartsWith(path, p)]:
@@ -2037,7 +2040,9 @@ class P4Sync(Command, P4UserMap):
         branches = {}
         fnum = 0
         while commit.has_key("depotFile%s" % fnum):
-            path =  commit["depotFile%s" % fnum]
+            path = commit["depotFile%s" % fnum]
+            path = self.fixPathCase(path)
+
             found = [p for p in self.depotPaths
                      if p4PathStartsWith(path, p)]
             if not found:
@@ -2164,6 +2169,10 @@ class P4Sync(Command, P4UserMap):
             if marshalled["code"] == "error":
                 if "data" in marshalled:
                     err = marshalled["data"].rstrip()
+
+        if "depotFile" in marshalled:
+            marshalled['depotFile'] = self.fixPathCase(marshalled['depotFile'])
+
         if err:
             f = None
             if self.stream_have_file_info:
@@ -2238,6 +2247,7 @@ class P4Sync(Command, P4UserMap):
 
             # do the last chunk
             if self.stream_file.has_key('depotFile'):
+                self.stream_file['depotFile'] = self.fixPathCase(self.stream_file['depotFile'])
                 self.streamOneP4File(self.stream_file, self.stream_contents)
 
     def make_email(self, userid):
@@ -2295,7 +2305,8 @@ class P4Sync(Command, P4UserMap):
                 sys.stderr.write("Ignoring file outside of prefix: %s\n" % f['path'])
 
         if self.clientSpecDirs:
-            self.clientSpecDirs.update_client_spec_path_cache(files)
+            self.clientSpecDirs.update_client_spec_path_cache(
+                files, lambda x: self.fixPathCase(x))
 
         self.gitStream.write("commit %s\n" % branch)
 #        gitStream.write("mark :%s\n" % details["change"])
@@ -2759,6 +2770,63 @@ class P4Sync(Command, P4UserMap):
             print "IO error with git fast-import. Is your git version recent enough?"
             print self.gitError.read()
 
+    def fixPathCase(self, path):
+        if self.caseCorrectedPaths:
+            components = path.split('/')
+            filename = components.pop()
+            dirname = '/'.join(components).lower() + '/'
+            if dirname in self.caseCorrectedPaths:
+                path = self.caseCorrectedPaths[dirname] + filename
+        return path
+
+    def generatePathCaseDict(self, depotPaths):
+        # Query all files and generate a list of all used paths
+        # e.g. this files list:
+        # //depot/path/to/file1
+        # //depot/PATH/to/file2
+        #
+        # result in this path list:
+        # //depot/
+        # //depot/PATH/
+        # //depot/path/
+        # //depot/PATH/to/
+        # //depot/path/to/
+        p4_paths = set()
+        for p in depotPaths:
+            for f in p4CmdList(["files", p+"..."]):
+                components = f["depotFile"].split('/')[0:-1]
+                for i in range(3, len(components)+1):
+                    p4_paths.add('/'.join(components[0:i]) + '/')
+        p4_paths = sorted(list(p4_paths), key=len)
+
+        if len(p4_paths) > len(set([p.lower() for p in p4_paths])):
+            print "ATTENTION: File paths with different case variations detected. Fixing may take a while..."
+            found_variations = True
+            while found_variations:
+                for path in p4_paths:
+                    found_variations = False
+                    path_variations = [p for p in p4_paths if p.lower() == path.lower()]
+
+                    if len(path_variations) > 1:
+                        print  "%i different case variations for path '%s' detected." % (len(path_variations), path)
+                        # If we detect path variations (e.g. //depot/path and //depot/PATH) then we query P4 to list
+                        # the subdirectories of the parent (e.g //depot/*). P4 will return these subdirectories with
+                        # the correct case.
+                        parent_path = '/'.join(path.split('/')[0:-2])
+                        case_ok_paths = [p["dir"] + '/' for p in p4CmdList(["dirs", "-D", parent_path + '/*'])]
+
+                        # Replace all known paths with the case corrected path from P4 dirs command
+                        for case_ok_path in case_ok_paths:
+                            pattern = re.compile("^" + case_ok_path, re.IGNORECASE)
+                            p4_paths = sorted(list(set([pattern.sub(case_ok_path, p) for p in p4_paths])), key=len)
+
+                        found_variations = True
+                        break
+            return dict((p.lower(), p) for p in p4_paths)
+        else:
+            if self.verbose:
+                print "All file paths have consistent case"
+            return None
 
     def run(self, args):
         self.depotPaths = []
@@ -2930,6 +2998,11 @@ class P4Sync(Command, P4UserMap):
 
         self.depotPaths = newPaths
 
+        if gitConfigBool("core.ignorecase"):
+            self.caseCorrectedPaths = self.generatePathCaseDict(self.depotPaths)
+        else:
+            self.caseCorrectedPaths = None
+
         # --detect-branches may change this for each branch
         self.branchPrefixes = self.depotPaths
 
-- 
1.9.5 (Apple Git-50.3)
