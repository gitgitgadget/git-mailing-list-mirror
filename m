From: larsxschneider@gmail.com
Subject: [PATCH v3 4/5] git-p4: add support for large file systems
Date: Mon,  7 Sep 2015 14:21:17 +0200
Message-ID: <1441628478-86503-5-git-send-email-larsxschneider@gmail.com>
References: <1441628478-86503-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 07 14:21:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYvQU-0000Ce-RN
	for gcvg-git-2@plane.gmane.org; Mon, 07 Sep 2015 14:21:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbbIGMVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2015 08:21:31 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:34686 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbbIGMV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2015 08:21:27 -0400
Received: by wicfx3 with SMTP id fx3so86846796wic.1
        for <git@vger.kernel.org>; Mon, 07 Sep 2015 05:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cHIDAhZpoB1rCMKCzywfECKsC9VxSL22ruOEET+XbAI=;
        b=jcsEti8afMELMlVIqrjGl1dchBw4E9xZq41p2+8YmZHJnj392MXn8Hm4hma9TGeCHS
         gIaKJf29+R78cX/8fYqoXfd+THLgoinBtrnQeoGdMR36hlK5MuS6D7GsA1kea1kkZBWw
         i+NmKc4ShFF7Rvhqg+ex1ETXheYIqKLeW6ed2PdunBgxbdEMppLHfl7a31mT1cwl6d6B
         gKFrsHeZxBCmwQZQ7OMXs3yYTM/QI51fY8Pv2tLpzmomD3YEqGMUpSibeNTd8ApOSJ3x
         zF/Utoi1YgiLpK0GK1cwZFLOWscPIex7VqjTngTKot7x5unuKH1ZC8wwoGH1F8P6VFCR
         iwOg==
X-Received: by 10.180.100.74 with SMTP id ew10mr35070199wib.12.1441628485974;
        Mon, 07 Sep 2015 05:21:25 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id gc19sm2441591wic.19.2015.09.07.05.21.25
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Sep 2015 05:21:25 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1441628478-86503-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277451>

From: Lars Schneider <larsxschneider@gmail.com>

Perforce repositories can contain large (binary) files. Migrating these
repositories to Git generates very large local clones. External storage
systems such as Git LFS [1], Git Fat [2], or Git Media [2] try to
address this problem.

Add a generic mechanism to detect large files based on extension,
uncompressed size, and/or compressed size.

[1] https://git-lfs.github.com/
[2] https://github.com/jedbrown/git-fat
[3] https://github.com/alebedev/git-media

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 Documentation/git-p4.txt |  26 +++++++++++
 git-p4.py                | 114 +++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 131 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 82aa5d6..e0d0239 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -510,6 +510,32 @@ git-p4.useClientSpec::
 	option '--use-client-spec'.  See the "CLIENT SPEC" section above.
 	This variable is a boolean, not the name of a p4 client.
 
+git-p4.largeFileSystem::
+	Specify the system that is used used for large (binary) files.
+	Please note that most of these large file systems depend on the
+	Git clean/smudge filters. These filters are not applied through
+	git-p4. You need to create a fresh clone of the repository after
+	running git-p4.
+
+git-p4.largeFileExtensions::
+	All files matching a file extension in the list will be processed
+	by the large file system. Do not prefix the extensions with '.'.
+
+git-p4.largeFileThreshold::
+	All files with an uncompressed size exceeding the threshold will be
+	processed by the large file system. By default the threshold is
+	defined in bytes. Add the suffix k, m, or g to change the unit.
+
+git-p4.largeFileCompressedThreshold::
+	All files with a compressed size exceeding the threshold will be
+	processed by the large file system. This option might significantly
+	slow down your clone/sync process. By default the threshold is
+	defined in bytes. Add the suffix k, m, or g to change the unit.
+
+git-p4.pushLargeFiles::
+	Boolean variable which defines if large files are automatically
+	pushed to a server.
+
 Submit variables
 ~~~~~~~~~~~~~~~~
 git-p4.detectRenames::
diff --git a/git-p4.py b/git-p4.py
index 90d3b90..06651a8 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -22,6 +22,8 @@ import platform
 import re
 import shutil
 import stat
+import zipfile
+import zlib
 
 try:
     from subprocess import CalledProcessError
@@ -922,6 +924,17 @@ def wildcard_present(path):
     m = re.search("[*#@%]", path)
     return m is not None
 
+def largeFileSystem():
+    try:
+        largeFileSystem = getattr(sys.modules[__name__], gitConfig('git-p4.largeFileSystem'))
+        assert(hasattr(largeFileSystem, "attributeDescription"))
+        assert(hasattr(largeFileSystem, "attributeFilter"))
+        assert(hasattr(largeFileSystem, "generatePointer"))
+        assert(hasattr(largeFileSystem, "pushFile"))
+        return largeFileSystem
+    except AttributeError as e:
+        die('Large file system not supported: %s' % gitConfig('git-p4.largeFileSystem'))
+
 class Command:
     def __init__(self):
         self.usage = "usage: %prog [options]"
@@ -2038,6 +2051,7 @@ class P4Sync(Command, P4UserMap):
         self.clientSpecDirs = None
         self.tempBranches = []
         self.tempBranchLocation = "git-p4-tmp"
+        self.largeFiles = set()
 
         if gitConfig("git-p4.syncFromOrigin") == "false":
             self.syncWithOrigin = False
@@ -2158,6 +2172,85 @@ class P4Sync(Command, P4UserMap):
 
         return branches
 
+    def writeToGitStream(self, gitMode, relPath, contents):
+        self.gitStream.write('M %s inline %s\n' % (gitMode, relPath))
+        self.gitStream.write('data %d\n' % sum(len(d) for d in contents))
+        for d in contents:
+            self.gitStream.write(d)
+        self.gitStream.write('\n')
+
+    def writeGitAttributesToStream(self):
+        self.writeToGitStream(
+            '100644',
+            '.gitattributes',
+            [
+                '\n',
+                '#\n',
+                '# %s\n' % largeFileSystem().attributeDescription(),
+                '#\n',
+            ] +
+            ['*.' + f.replace(' ', '[:space:]') + ' filter=%s -text\n'
+                % largeFileSystem().attributeFilter()
+                for f in sorted(gitConfigList("git-p4.largeFileExtensions"))
+            ] +
+            ['/' + f.replace(' ', '[:space:]') + ' filter=%s -text\n'
+                % largeFileSystem().attributeFilter()
+                for f in sorted(self.largeFiles) if not self.hasLargeFileExtension(f)
+            ]
+        )
+
+    def hasLargeFileExtension(self, relPath):
+        return reduce(
+            lambda a, b: a or b,
+            [relPath.endswith('.' + e) for e in gitConfigList('git-p4.largeFileExtensions')],
+            False
+        )
+
+    def exceedsLargeFileThreshold(self, relPath, contents):
+        if gitConfigInt('git-p4.largeFileThreshold'):
+            contentsSize = sum(len(d) for d in contents)
+            if contentsSize > gitConfigInt('git-p4.largeFileThreshold'):
+                return True
+        if gitConfigInt('git-p4.largeFileCompressedThreshold'):
+            contentFile = tempfile.NamedTemporaryFile(prefix='git-p4-large-file', delete=False)
+            for d in contents:
+                contentFile.write(d)
+            contentFile.flush()
+            compressedContentFile = tempfile.NamedTemporaryFile(prefix='git-p4-large-file', delete=False)
+            zf = zipfile.ZipFile(compressedContentFile.name, mode='w')
+            zf.write(contentFile.name, compress_type=zipfile.ZIP_DEFLATED)
+            zf.close()
+            compressedContentsSize = zf.infolist()[0].compress_size
+            os.remove(contentFile.name)
+            os.remove(compressedContentFile.name)
+            if compressedContentsSize > gitConfigInt('git-p4.largeFileCompressedThreshold'):
+                return True
+        return False
+
+    def moveToLargeFileSystem(self, relPath, contents):
+        # Write P4 content to temp file
+        contentFile = tempfile.NamedTemporaryFile(prefix='git-p4-large-file', delete=False)
+        for d in contents:
+            contentFile.write(d)
+        contentFile.flush()
+        contentFile.close()
+        (git_mode, contents, largeFileTarget) = \
+            largeFileSystem().generatePointer(self.cloneDestination, contentFile.name)
+        # Move temp file to final location in large file system
+        largeFileDir = os.path.dirname(largeFileTarget)
+        if not os.path.isdir(largeFileDir):
+            os.makedirs(largeFileDir)
+        shutil.move(contentFile.name, largeFileTarget)
+        if verbose:
+            sys.stderr.write("%s moved to large file system (%s)\n" % (relPath, largeFileTarget))
+
+        if gitConfigBool('git-p4.pushLargeFiles'):
+            largeFileSystem().pushFile(largeFileTarget)
+
+        self.largeFiles.add(relPath)
+        self.writeGitAttributesToStream()
+        return (git_mode, contents)
+
     # output one file from the P4 stream
     # - helper for streamP4Files
 
@@ -2226,17 +2319,16 @@ class P4Sync(Command, P4UserMap):
             text = regexp.sub(r'$\1$', text)
             contents = [ text ]
 
-        self.gitStream.write("M %s inline %s\n" % (git_mode, relPath))
+        if relPath == '.gitattributes':
+            die('.gitattributes already exists in P4.')
 
-        # total length...
-        length = 0
-        for d in contents:
-            length = length + len(d)
+        if (gitConfig('git-p4.largeFileSystem') and
+            (   self.exceedsLargeFileThreshold(relPath, contents) or
+                self.hasLargeFileExtension(relPath)
+            )):
+            (git_mode, contents) = self.moveToLargeFileSystem(relPath, contents)
 
-        self.gitStream.write("data %d\n" % length)
-        for d in contents:
-            self.gitStream.write(d)
-        self.gitStream.write("\n")
+        self.writeToGitStream(git_mode, relPath, contents)
 
     def streamOneP4Deletion(self, file):
         relPath = self.stripRepoPath(file['path'], self.branchPrefixes)
@@ -2244,6 +2336,10 @@ class P4Sync(Command, P4UserMap):
             sys.stderr.write("delete %s\n" % relPath)
         self.gitStream.write("D %s\n" % relPath)
 
+        if relPath in self.largeFiles:
+            self.largeFiles.remove(relPath)
+            self.writeGitAttributesToStream()
+
     # handle another chunk of streaming data
     def streamP4FilesCb(self, marshalled):
 
-- 
2.5.1
