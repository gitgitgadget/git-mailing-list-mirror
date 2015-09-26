From: larsxschneider@gmail.com
Subject: [PATCH v8 6/7] git-p4: add support for large file systems
Date: Sat, 26 Sep 2015 09:55:03 +0200
Message-ID: <1443254104-14966-7-git-send-email-larsxschneider@gmail.com>
References: <1443254104-14966-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 26 09:56:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfkKs-0007TH-As
	for gcvg-git-2@plane.gmane.org; Sat, 26 Sep 2015 09:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856AbbIZHz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2015 03:55:56 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:34306 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751826AbbIZHzx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2015 03:55:53 -0400
Received: by wicfx3 with SMTP id fx3so47058298wic.1
        for <git@vger.kernel.org>; Sat, 26 Sep 2015 00:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/9T7z9uemk/bgN7/x6gJoqvAhJDDU1BaV0oD1kJee4s=;
        b=EHLGun+vyGvp7nTprh14JoVgbjp9y8Jf7i0hTrJAvO3UPQZv7+WvifVmolSTHr9T8E
         reHnDJXzbWxQRSX2FGT4YEYDh6amepZov8powl1qNBHrXVWvqDY2iueg/tfLyifJ6gyp
         gfEtbrnHaJvxoTvxZM4B3mEGHZr3svd+R/KeWPSTxKGYestlh1vuYPycJybGkVTOV0ru
         HEP9MgzYY9RCdfHrXyTZbIec6+icG3xvVmeIeqSngIiJuLxsfZZaJ2nk5bBITHNjjBTj
         Gl+p4p+0yZUMMQp+rqsqxYdoJezDrQ5jfHhTdQdAxPsHQ5qzb2XqGSuumd1iC0YdCIJt
         W+vw==
X-Received: by 10.194.113.101 with SMTP id ix5mr12116522wjb.66.1443254151682;
        Sat, 26 Sep 2015 00:55:51 -0700 (PDT)
Received: from localhost.localdomain (tmo-102-235.customers.d1-online.com. [80.187.102.235])
        by smtp.gmail.com with ESMTPSA id it4sm7176613wjb.0.2015.09.26.00.55.37
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 26 Sep 2015 00:55:51 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1443254104-14966-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278692>

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

Conflicts:
	Documentation/git-p4.txt
	git-p4.py
---
 Documentation/git-p4.txt   |  32 ++++++++
 git-p4.py                  | 139 +++++++++++++++++++++++++++++---
 t/t9823-git-p4-mock-lfs.sh | 192 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 353 insertions(+), 10 deletions(-)
 create mode 100755 t/t9823-git-p4-mock-lfs.sh

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 82aa5d6..f34d16d 100644
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
+git-p4.largeFilePush::
+	Boolean variable which defines if large files are automatically
+	pushed to a server.
+
 Submit variables
 ~~~~~~~~~~~~~~~~
 git-p4.detectRenames::
diff --git a/git-p4.py b/git-p4.py
index 6b1e395..3de8505 100755
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
@@ -932,6 +934,110 @@ def wildcard_present(path):
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
+    def processContent(self, git_mode, relPath, contents):
+        """Processes the content of git fast import. This method decides if a
+           file is stored in the large file system and handles all necessary
+           steps."""
+        if self.exceedsLargeFileThreshold(relPath, contents) or self.hasLargeFileExtension(relPath):
+            contentTempFile = self.generateTempFile(contents)
+            (git_mode, contents, localLargeFile) = self.generatePointer(contentTempFile)
+
+            # Move temp file to final location in large file system
+            largeFileDir = os.path.dirname(localLargeFile)
+            if not os.path.isdir(largeFileDir):
+                os.makedirs(largeFileDir)
+            shutil.move(contentTempFile, localLargeFile)
+            self.addLargeFile(relPath)
+            if gitConfigBool('git-p4.largeFilePush'):
+                self.pushFile(localLargeFile)
+            if verbose:
+                sys.stderr.write("%s moved to large file system (%s)\n" % (relPath, localLargeFile))
+        return (git_mode, contents)
+
+class MockLFS(LargeFileSystem):
+    """Mock large file system for testing."""
+
+    def generatePointer(self, contentFile):
+        """The pointer content is the original content prefixed with "pointer-".
+           The local filename of the large file storage is derived from the file content.
+           """
+        with open(contentFile, 'r') as f:
+            content = next(f)
+            gitMode = '100644'
+            pointerContents = 'pointer-' + content
+            localLargeFile = os.path.join(os.getcwd(), '.git', 'mock-storage', 'local', content[:-1])
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
@@ -1105,6 +1211,9 @@ class P4Submit(Command, P4UserMap):
         self.p4HasMoveCommand = p4_has_move_command()
         self.branch = None
 
+        if gitConfig('git-p4.largeFileSystem'):
+            die("Large file system not supported for git-p4 submit command. Please remove it from config.")
+
     def check(self):
         if len(p4CmdList("opened ...")) > 0:
             die("You have files opened with perforce! Close them before starting the sync.")
@@ -2048,6 +2157,13 @@ class P4Sync(Command, P4UserMap):
         self.clientSpecDirs = None
         self.tempBranches = []
         self.tempBranchLocation = "git-p4-tmp"
+        self.largeFileSystem = None
+
+        if gitConfig('git-p4.largeFileSystem'):
+            largeFileSystemConstructor = globals()[gitConfig('git-p4.largeFileSystem')]
+            self.largeFileSystem = largeFileSystemConstructor(
+                lambda git_mode, relPath, contents: self.writeToGitStream(git_mode, relPath, contents)
+            )
 
         if gitConfig("git-p4.syncFromOrigin") == "false":
             self.syncWithOrigin = False
@@ -2168,6 +2284,13 @@ class P4Sync(Command, P4UserMap):
 
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
 
@@ -2238,17 +2361,10 @@ class P4Sync(Command, P4UserMap):
             text = regexp.sub(r'$\1$', text)
             contents = [ text ]
 
-        self.gitStream.write("M %s inline %s\n" % (git_mode, relPath))
+        if self.largeFileSystem:
+            (git_mode, contents) = self.largeFileSystem.processContent(git_mode, relPath, contents)
 
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
@@ -2257,6 +2373,9 @@ class P4Sync(Command, P4UserMap):
             sys.stdout.flush()
         self.gitStream.write("D %s\n" % relPath)
 
+        if self.largeFileSystem and self.largeFileSystem.isLargeFile(relPath):
+            self.largeFileSystem.removeLargeFile(relPath)
+
     # handle another chunk of streaming data
     def streamP4FilesCb(self, marshalled):
 
diff --git a/t/t9823-git-p4-mock-lfs.sh b/t/t9823-git-p4-mock-lfs.sh
new file mode 100755
index 0000000..1f2dc36
--- /dev/null
+++ b/t/t9823-git-p4-mock-lfs.sh
@@ -0,0 +1,192 @@
+#!/bin/sh
+
+test_description='Clone repositories and store files in Mock LFS'
+
+. ./lib-git-p4.sh
+
+test_file_is_not_in_mock_lfs () {
+	FILE="$1" &&
+	CONTENT="$2" &&
+	echo "$CONTENT" >expect_content &&
+	test_path_is_file "$FILE" &&
+	test_cmp expect_content "$FILE"
+}
+
+test_file_is_in_mock_lfs () {
+	FILE="$1" &&
+	CONTENT="$2" &&
+	LOCAL_STORAGE=".git/mock-storage/local/$CONTENT" &&
+	SERVER_STORAGE=".git/mock-storage/remote/$CONTENT" &&
+	echo "pointer-$CONTENT" >expect_pointer &&
+	echo "$CONTENT" >expect_content &&
+	test_path_is_file "$FILE" &&
+	test_path_is_file "$LOCAL_STORAGE" &&
+	test_path_is_file "$SERVER_STORAGE" &&
+	test_cmp expect_pointer "$FILE" &&
+	test_cmp expect_content "$LOCAL_STORAGE" &&
+	test_cmp expect_content "$SERVER_STORAGE"
+}
+
+test_file_is_deleted_in_mock_lfs () {
+	FILE="$1" &&
+	CONTENT="$2" &&
+	LOCAL_STORAGE=".git/mock-storage/local/$CONTENT" &&
+	SERVER_STORAGE=".git/mock-storage/remote/$CONTENT" &&
+	echo "pointer-$CONTENT" >expect_pointer &&
+	echo "$CONTENT" >expect_content &&
+	test_path_is_missing "$FILE" &&
+	test_path_is_file "$LOCAL_STORAGE" &&
+	test_path_is_file "$SERVER_STORAGE" &&
+	test_cmp expect_content "$LOCAL_STORAGE" &&
+	test_cmp expect_content "$SERVER_STORAGE"
+}
+
+test_file_count_in_dir () {
+	DIR="$1" &&
+	EXPECTED_COUNT="$2" &&
+	find "$DIR" -type f >actual &&
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
+test_expect_success 'Store files in Mock LFS based on size (>24 bytes)' '
+	client_view "//depot/... //client/..." &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git init . &&
+		git config git-p4.useClientSpec true &&
+		git config git-p4.largeFileSystem MockLFS &&
+		git config git-p4.largeFileThreshold 24 &&
+		git config git-p4.largeFilePush True &&
+		git p4 clone --destination="$git" //depot@all &&
+
+		test_file_is_not_in_mock_lfs file1.txt "content 1 txt 23 bytes" &&
+		test_file_is_in_mock_lfs file2.dat "content 2-3 bin 25 bytes" &&
+		test_file_is_in_mock_lfs "path with spaces/file3.bin" "content 2-3 bin 25 bytes" &&
+		test_file_is_in_mock_lfs file4.bin "content 4 bin 26 bytes XX" &&
+
+		test_file_count_in_dir ".git/mock-storage/local" 2 &&
+		test_file_count_in_dir ".git/mock-storage/remote" 2
+	)
+'
+
+test_expect_success 'Store files in Mock LFS based on extension (dat)' '
+	client_view "//depot/... //client/..." &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git init . &&
+		git config git-p4.useClientSpec true &&
+		git config git-p4.largeFileSystem MockLFS &&
+		git config git-p4.largeFileExtensions dat &&
+		git config git-p4.largeFilePush True &&
+		git p4 clone --destination="$git" //depot@all &&
+
+		test_file_is_not_in_mock_lfs file1.txt "content 1 txt 23 bytes" &&
+		test_file_is_in_mock_lfs file2.dat "content 2-3 bin 25 bytes" &&
+		test_file_is_not_in_mock_lfs "path with spaces/file3.bin" "content 2-3 bin 25 bytes" &&
+		test_file_is_not_in_mock_lfs file4.bin "content 4 bin 26 bytes XX" &&
+
+		test_file_count_in_dir ".git/mock-storage/local" 1 &&
+		test_file_count_in_dir ".git/mock-storage/remote" 1
+	)
+'
+
+test_expect_success 'Store files in Mock LFS based on extension (dat) and use git p4 sync and no client spec' '
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git init &&
+		git config git-p4.useClientSpec true &&
+		git config git-p4.largeFileSystem MockLFS &&
+		git config git-p4.largeFileExtensions dat &&
+		git config git-p4.largeFilePush True &&
+		git p4 sync //depot &&
+		git checkout p4/master &&
+
+		test_file_is_not_in_mock_lfs file1.txt "content 1 txt 23 bytes" &&
+		test_file_is_in_mock_lfs file2.dat "content 2-3 bin 25 bytes" &&
+		test_file_is_not_in_mock_lfs "path with spaces/file3.bin" "content 2-3 bin 25 bytes" &&
+		test_file_is_not_in_mock_lfs file4.bin "content 4 bin 26 bytes XX" &&
+
+		test_file_count_in_dir ".git/mock-storage/local" 1 &&
+		test_file_count_in_dir ".git/mock-storage/remote" 1
+	)
+'
+
+test_expect_success 'Remove file from repo and store files in Mock LFS based on size (>24 bytes)' '
+	client_view "//depot/... //client/..." &&
+	(
+		cd "$cli" &&
+		p4 delete file4.bin &&
+		p4 submit -d "Remove file"
+	) &&
+
+	client_view "//depot/... //client/..." &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git init . &&
+		git config git-p4.useClientSpec true &&
+		git config git-p4.largeFileSystem MockLFS &&
+		git config git-p4.largeFileThreshold 24 &&
+		git config git-p4.largeFilePush True &&
+		git p4 clone --destination="$git" //depot@all &&
+
+		test_file_is_not_in_mock_lfs file1.txt "content 1 txt 23 bytes" &&
+		test_file_is_in_mock_lfs file2.dat "content 2-3 bin 25 bytes" &&
+		test_file_is_in_mock_lfs "path with spaces/file3.bin" "content 2-3 bin 25 bytes" &&
+		test_file_is_deleted_in_mock_lfs file4.bin "content 4 bin 26 bytes XX" &&
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
+		git config git-p4.largeFilePush True &&
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
