From: larsxschneider@gmail.com
Subject: [PATCH v5 6/7] git-p4: add support for large file systems
Date: Mon, 14 Sep 2015 15:26:33 +0200
Message-ID: <1442237194-49624-7-git-send-email-larsxschneider@gmail.com>
References: <1442237194-49624-1-git-send-email-larsxschneider@gmail.com>
Cc: gitster@pobox.com, luke@diamand.org,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 14 15:27:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbTnF-0003JS-Bt
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 15:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755003AbbINN1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 09:27:34 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:36419 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754883AbbINN1X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 09:27:23 -0400
Received: by wicgb1 with SMTP id gb1so141880413wic.1
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 06:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5SN21fA8dhGhOA+MU1UhRL7CLK4ezlq1JEj38B0MV5Y=;
        b=sSQuzEMUTXQbKBFlhUgOceptUksxUMo+2KNLjO1ov9mH8rdpE3Mn1gUn2qVtYsDC2M
         xfZGTqyIl1CG3uiVKQ+ydIgv545YqCLkMntlKY7PB9mGyK6lS2/zFeagufM5z7fUBIaj
         Oexkrscuft368EQMVphJHsg2W6Yc4XG9QXNbZQd93hW3wP5A7jta/j5wLK3xZw71+mDi
         90rX9AcW6CF/WmDljm7ve6TK6Qo0KY+hi0XjKuCufZMT8eDUjGAzoFr5FZXDg8x+Yr+W
         OM3EV2MKafMystwEMi+Y3yWSrBJ1EWel7g/z5Y/CYJLi8EGFMGX3WIwP7Kx3FFR+uxod
         3lCQ==
X-Received: by 10.194.248.234 with SMTP id yp10mr30227755wjc.24.1442237242747;
        Mon, 14 Sep 2015 06:27:22 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id xt1sm12578013wjb.32.2015.09.14.06.27.21
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Sep 2015 06:27:22 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1442237194-49624-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277826>

From: Lars Schneider <larsxschneider@gmail.com>

Perforce repositories can contain large (binary) files. Migrating these
repositories to Git generates very large local clones. External storage
systems such as Git LFS [1], Git Fat [2], Git Media [3], git-annex [4]
try to address this problem.

Add a generic mechanism to detect large files based on extension,
uncompressed size, and/or compressed size.

[1] https://git-lfs.github.com/
[2] https://github.com/jedbrown/git-fat
[3] https://github.com/alebedev/git-media
[4] https://git-annex.branchable.com/

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 Documentation/git-p4.txt   |  32 +++++++++++
 git-p4.py                  | 139 +++++++++++++++++++++++++++++++++++++++++----
 t/t9823-git-p4-mock-lfs.sh |  96 +++++++++++++++++++++++++++++++
 3 files changed, 257 insertions(+), 10 deletions(-)
 create mode 100755 t/t9823-git-p4-mock-lfs.sh

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 82aa5d6..3f21e95 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -510,6 +510,38 @@ git-p4.useClientSpec::
 	option '--use-client-spec'.  See the "CLIENT SPEC" section above.
 	This variable is a boolean, not the name of a p4 client.
 
+git-p4.largeFileSystem::
+	Specify the system that is used for large (binary) files. Please note
+	that large file systems do not support the 'git p4 submit' command.
+	Only Git LFS [1] is implemented right now. Download
+	and install the Git LFS command line extension to use this option
+	and configure it like this:
++
+-------------
+git config       git-p4.largeFileSystem GitLFS
+-------------
++
+	[1] https://git-lfs.github.com/
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
+	processed by the large file system. This option might slow down
+	your clone/sync process. By default the threshold is defined in
+	bytes. Add the suffix k, m, or g to change the unit.
+
+git-p4.pushLargeFiles::
+	Boolean variable which defines if large files are automatically
+	pushed to a server.
+
 Submit variables
 ~~~~~~~~~~~~~~~~
 git-p4.detectRenames::
diff --git a/git-p4.py b/git-p4.py
index b465356..bfe71b5 100755
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
@@ -932,6 +934,111 @@ def wildcard_present(path):
     m = re.search("[*#@%]", path)
     return m is not None
 
+class LargeFileSystem(object):
+    """Base class for large file system support."""
+
+    def __init__(self, writeToGitStream):
+        self.largeFiles = set()
+        self.writeToGitStream = writeToGitStream
+
+    def generatePointer(self, cloneDestination, contentFile):
+        """Return the content of a pointer file that is stored in Git instead of
+           the actual content."""
+        assert False, "Method 'generatePointer' required in " + self.__class__.__name__
+
+    def pushFile(self, localLargeFile):
+        """Push the actual content which is not stored in the Git repository to
+           a server."""
+        assert False, "Method 'pushFile' required in " + self.__class__.__name__
+
+    def hasLargeFileExtension(self, relPath):
+        return reduce(
+            lambda a, b: a or b,
+            [relPath.endswith('.' + e) for e in gitConfigList('git-p4.largeFileExtensions')],
+            False
+        )
+
+    def generateTempFile(self, contents):
+        contentFile = tempfile.NamedTemporaryFile(prefix='git-p4-large-file', delete=False)
+        for d in contents:
+            contentFile.write(d)
+        contentFile.flush()
+        contentFile.close()
+        return contentFile.name
+
+    def exceedsLargeFileThreshold(self, relPath, contents):
+        if gitConfigInt('git-p4.largeFileThreshold'):
+            contentsSize = sum(len(d) for d in contents)
+            if contentsSize > gitConfigInt('git-p4.largeFileThreshold'):
+                return True
+        if gitConfigInt('git-p4.largeFileCompressedThreshold'):
+            contentsSize = sum(len(d) for d in contents)
+            if contentsSize <= gitConfigInt('git-p4.largeFileCompressedThreshold'):
+                return False
+            contentTempFile = self.generateTempFile(contents)
+            compressedContentFile = tempfile.NamedTemporaryFile(prefix='git-p4-large-file', delete=False)
+            zf = zipfile.ZipFile(compressedContentFile.name, mode='w')
+            zf.write(contentTempFile, compress_type=zipfile.ZIP_DEFLATED)
+            zf.close()
+            compressedContentsSize = zf.infolist()[0].compress_size
+            os.remove(contentTempFile)
+            os.remove(compressedContentFile.name)
+            if compressedContentsSize > gitConfigInt('git-p4.largeFileCompressedThreshold'):
+                return True
+        return False
+
+    def addLargeFile(self, relPath):
+        self.largeFiles.add(relPath)
+
+    def removeLargeFile(self, relPath):
+        self.largeFiles.remove(relPath)
+
+    def isLargeFile(self, relPath):
+        return relPath in self.largeFiles
+
+    def processContent(self, cloneDestination, git_mode, relPath, contents):
+        """Processes the content of git fast import. This method decides if a
+           file is stored in the large file system and handles all necessary
+           steps."""
+        if self.exceedsLargeFileThreshold(relPath, contents) or self.hasLargeFileExtension(relPath):
+            contentTempFile = self.generateTempFile(contents)
+            (git_mode, contents, localLargeFile) = self.generatePointer(cloneDestination, contentTempFile)
+
+            # Move temp file to final location in large file system
+            largeFileDir = os.path.dirname(localLargeFile)
+            if not os.path.isdir(largeFileDir):
+                os.makedirs(largeFileDir)
+            shutil.move(contentTempFile, localLargeFile)
+            self.addLargeFile(relPath)
+            if gitConfigBool('git-p4.pushLargeFiles'):
+                self.pushFile(localLargeFile)
+            if verbose:
+                sys.stderr.write("%s moved to large file system (%s)\n" % (relPath, localLargeFile))
+        return (git_mode, contents)
+
+class MockLFS(LargeFileSystem):
+    """Mock large file system for testing."""
+
+    def generatePointer(self, cloneDestination, contentFile):
+        """The pointer content is the original content prefixed with "pointer-".
+           The local filename of the large file storage is derived from the file content.
+           """
+        with open(contentFile, 'r') as f:
+            content = next(f)
+            gitMode = '100644'
+            pointerContents = 'pointer-' + content
+            localLargeFile = os.path.join(cloneDestination, '.git', 'mock-storage', 'local', content[:-1])
+            return (gitMode, pointerContents, localLargeFile)
+
+    def pushFile(self, localLargeFile):
+        """The remote filename of the large file storage is the same as the local
+           one but in a different directory.
+           """
+        remotePath = os.path.join(os.path.dirname(localLargeFile), '..', 'remote')
+        if not os.path.exists(remotePath):
+            os.makedirs(remotePath)
+        shutil.copyfile(localLargeFile, os.path.join(remotePath, os.path.basename(localLargeFile)))
+
 class Command:
     def __init__(self):
         self.usage = "usage: %prog [options]"
@@ -1105,6 +1212,9 @@ class P4Submit(Command, P4UserMap):
         self.p4HasMoveCommand = p4_has_move_command()
         self.branch = None
 
+        if gitConfig('git-p4.largeFileSystem'):
+            die("Large file system not supported for git-p4 submit command. Please remove it from config.")
+
     def check(self):
         if len(p4CmdList("opened ...")) > 0:
             die("You have files opened with perforce! Close them before starting the sync.")
@@ -2057,6 +2167,12 @@ class P4Sync(Command, P4UserMap):
                 lambda git_mode, relPath, contents: self.writeToGitStream(git_mode, relPath, contents)
             )
 
+        if gitConfig('git-p4.largeFileSystem'):
+            largeFileSystemConstructor = globals()[gitConfig('git-p4.largeFileSystem')]
+            self.largeFileSystem = largeFileSystemConstructor(
+                lambda git_mode, relPath, contents: self.writeToGitStream(git_mode, relPath, contents)
+            )
+
         if gitConfig("git-p4.syncFromOrigin") == "false":
             self.syncWithOrigin = False
 
@@ -2176,6 +2292,13 @@ class P4Sync(Command, P4UserMap):
 
         return branches
 
+    def writeToGitStream(self, gitMode, relPath, contents):
+        self.gitStream.write('M %s inline %s\n' % (gitMode, relPath))
+        self.gitStream.write('data %d\n' % sum(len(d) for d in contents))
+        for d in contents:
+            self.gitStream.write(d)
+        self.gitStream.write('\n')
+
     # output one file from the P4 stream
     # - helper for streamP4Files
 
@@ -2246,17 +2369,10 @@ class P4Sync(Command, P4UserMap):
             text = regexp.sub(r'$\1$', text)
             contents = [ text ]
 
-        self.gitStream.write("M %s inline %s\n" % (git_mode, relPath))
+        if self.largeFileSystem:
+            (git_mode, contents) = self.largeFileSystem.processContent(self.cloneDestination, git_mode, relPath, contents)
 
-        # total length...
-        length = 0
-        for d in contents:
-            length = length + len(d)
-
-        self.gitStream.write("data %d\n" % length)
-        for d in contents:
-            self.gitStream.write(d)
-        self.gitStream.write("\n")
+        self.writeToGitStream(git_mode, relPath, contents)
 
     def streamOneP4Deletion(self, file):
         relPath = self.stripRepoPath(file['path'], self.branchPrefixes)
@@ -2265,6 +2381,9 @@ class P4Sync(Command, P4UserMap):
             sys.stdout.flush()
         self.gitStream.write("D %s\n" % relPath)
 
+        if self.largeFileSystem and self.largeFileSystem.isLargeFile(relPath):
+            self.largeFileSystem.removeLargeFile(relPath)
+
     # handle another chunk of streaming data
     def streamP4FilesCb(self, marshalled):
 
diff --git a/t/t9823-git-p4-mock-lfs.sh b/t/t9823-git-p4-mock-lfs.sh
new file mode 100755
index 0000000..8582857
--- /dev/null
+++ b/t/t9823-git-p4-mock-lfs.sh
@@ -0,0 +1,96 @@
+#!/bin/sh
+
+test_description='Clone repositories and store files in Mock LFS'
+
+. ./lib-git-p4.sh
+
+test_file_in_mock () {
+	FILE="$1"
+	CONTENT="$2"
+	LOCAL_STORAGE=".git/mock-storage/local/$CONTENT"
+	SERVER_STORAGE=".git/mock-storage/remote/$CONTENT"
+	echo "pointer-$CONTENT" >expect_pointer
+	echo "$CONTENT" >expect_content
+	test_path_is_file "$FILE" &&
+	test_path_is_file "$LOCAL_STORAGE" &&
+	test_path_is_file "$SERVER_STORAGE" &&
+	test_cmp expect_pointer "$FILE" &&
+	test_cmp expect_content "$LOCAL_STORAGE" &&
+	test_cmp expect_content "$SERVER_STORAGE"
+}
+
+test_file_count_in_dir () {
+	DIR="$1"
+	EXPECTED_COUNT="$2"
+	find "$DIR" -type f >actual
+	test_line_count = $EXPECTED_COUNT actual
+}
+
+test_expect_success 'start p4d' '
+	start_p4d
+'
+
+test_expect_success 'Create repo with binary files' '
+	client_view "//depot/... //client/..." &&
+	(
+		cd "$cli" &&
+
+		echo "content 1 txt 23 bytes" >file1.txt &&
+		p4 add file1.txt &&
+		echo "content 2-3 bin 25 bytes" >file2.dat &&
+		p4 add file2.dat &&
+		p4 submit -d "Add text and binary file" &&
+
+		mkdir "path with spaces" &&
+		echo "content 2-3 bin 25 bytes" >"path with spaces/file3.bin" &&
+		p4 add "path with spaces/file3.bin" &&
+		p4 submit -d "Add another binary file with same content and spaces in path" &&
+
+		echo "content 4 bin 26 bytes XX" >file4.bin &&
+		p4 add file4.bin &&
+		p4 submit -d "Add another binary file with different content"
+	)
+'
+
+test_expect_success 'Store files in Mock based on size (>24 bytes)' '
+	client_view "//depot/... //client/..." &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git init . &&
+		git config git-p4.useClientSpec true &&
+		git config git-p4.largeFileSystem MockLFS &&
+		git config git-p4.largeFileThreshold 24 &&
+		git config git-p4.pushLargeFiles True &&
+		git p4 clone --destination="$git" //depot@all &&
+
+		test_file_in_mock file2.dat "content 2-3 bin 25 bytes" &&
+		test_file_in_mock "path with spaces/file3.bin" "content 2-3 bin 25 bytes" &&
+		test_file_in_mock file4.bin "content 4 bin 26 bytes XX" &&
+
+		test_file_count_in_dir ".git/mock-storage/local" 2 &&
+		test_file_count_in_dir ".git/mock-storage/remote" 2
+	)
+'
+
+test_expect_success 'Run git p4 submit in repo configured with large file system' '
+	client_view "//depot/... //client/..." &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git init . &&
+		git config git-p4.useClientSpec true &&
+		git config git-p4.largeFileSystem MockLFS &&
+		git config git-p4.largeFileThreshold 24 &&
+		git config git-p4.pushLargeFiles True &&
+		git p4 clone --destination="$git" //depot@all &&
+
+		test_must_fail git p4 submit
+	)
+'
+
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done
-- 
2.5.1
