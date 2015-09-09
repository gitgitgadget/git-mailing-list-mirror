From: larsxschneider@gmail.com
Subject: [PATCH v4 4/5] git-p4: add support for large file systems
Date: Wed,  9 Sep 2015 13:59:09 +0200
Message-ID: <1441799950-54633-5-git-send-email-larsxschneider@gmail.com>
References: <1441799950-54633-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 09 13:59:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZe2a-0001Xg-FT
	for gcvg-git-2@plane.gmane.org; Wed, 09 Sep 2015 13:59:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753563AbbIIL7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2015 07:59:46 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:38686 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752887AbbIIL7R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2015 07:59:17 -0400
Received: by wiclk2 with SMTP id lk2so18887616wic.1
        for <git@vger.kernel.org>; Wed, 09 Sep 2015 04:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NPIMNK6WfuyozrxBBValkdaK4QSY1eWnIWuK7yIUNKk=;
        b=U6IBrPoIDzb6hN5UkjzwEIMvmanMMbdJTZcAMvR84vi4oMN+oq0yOEqg4Ve3EorN/p
         0S5QYvXrVYqUl9fVxKZPm7hbSh5vurgE7hBAcQDcyR3rh4FeSC7Yr4/xyvfuLvUld8c8
         CVlzQ1lGwTKrSyygSMH2S39iddiGYKOQ2OAYk/iUGw3b6/RMDJRy5GVP2XCUFxQF4i5V
         25F1fGIlEzEIHSW0we27ZU1sSQcipHZnSK5FG7y2no2i0Xk4Ts4oyj9Wk8YIhLfkNPQc
         PA/u+b6ASFY25qeAz494DYo96OAW8OtUUVwsy5y6pLZG9qJ/ftNSG04IOrP+Fy652+u/
         0q4A==
X-Received: by 10.194.93.198 with SMTP id cw6mr59769383wjb.113.1441799956146;
        Wed, 09 Sep 2015 04:59:16 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id u1sm3498338wiz.22.2015.09.09.04.59.15
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Sep 2015 04:59:15 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1441799950-54633-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277551>

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
 Documentation/git-p4.txt   |  26 ++++++++
 git-p4.py                  | 150 ++++++++++++++++++++++++++++++++++++++++++---
 t/t9823-git-p4-mock-lfs.sh | 106 ++++++++++++++++++++++++++++++++
 3 files changed, 273 insertions(+), 9 deletions(-)
 create mode 100755 t/t9823-git-p4-mock-lfs.sh

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
index 90d3b90..ada4174 100755
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
@@ -922,6 +924,50 @@ def wildcard_present(path):
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
+class MockLFS:
+    """Mock large file system for testing."""
+
+    @staticmethod
+    def attributeDescription():
+        return 'Mock LFS'
+
+    @staticmethod
+    def attributeFilter():
+        return 'mock'
+
+    @staticmethod
+    def generatePointer(cloneDestination, contentFile):
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
+    @staticmethod
+    def pushFile(localLargeFile):
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
@@ -2038,6 +2084,7 @@ class P4Sync(Command, P4UserMap):
         self.clientSpecDirs = None
         self.tempBranches = []
         self.tempBranchLocation = "git-p4-tmp"
+        self.largeFiles = set()
 
         if gitConfig("git-p4.syncFromOrigin") == "false":
             self.syncWithOrigin = False
@@ -2158,6 +2205,88 @@ class P4Sync(Command, P4UserMap):
 
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
+            contentsSize = sum(len(d) for d in contents)
+            if contentsSize <= gitConfigInt('git-p4.largeFileCompressedThreshold'):
+                return False
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
+        (git_mode, contents, localLargeFile) = \
+            largeFileSystem().generatePointer(self.cloneDestination, contentFile.name)
+        # Move temp file to final location in large file system
+        largeFileDir = os.path.dirname(localLargeFile)
+        if not os.path.isdir(largeFileDir):
+            os.makedirs(largeFileDir)
+        shutil.move(contentFile.name, localLargeFile)
+        if verbose:
+            sys.stderr.write("%s moved to large file system (%s)\n" % (relPath, localLargeFile))
+
+        if gitConfigBool('git-p4.pushLargeFiles'):
+            largeFileSystem().pushFile(localLargeFile)
+
+        self.largeFiles.add(relPath)
+        self.writeGitAttributesToStream()
+        return (git_mode, contents)
+
     # output one file from the P4 stream
     # - helper for streamP4Files
 
@@ -2226,17 +2355,16 @@ class P4Sync(Command, P4UserMap):
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
@@ -2244,6 +2372,10 @@ class P4Sync(Command, P4UserMap):
             sys.stderr.write("delete %s\n" % relPath)
         self.gitStream.write("D %s\n" % relPath)
 
+        if relPath in self.largeFiles:
+            self.largeFiles.remove(relPath)
+            self.writeGitAttributesToStream()
+
     # handle another chunk of streaming data
     def streamP4FilesCb(self, marshalled):
 
diff --git a/t/t9823-git-p4-mock-lfs.sh b/t/t9823-git-p4-mock-lfs.sh
new file mode 100755
index 0000000..6e4fd54
--- /dev/null
+++ b/t/t9823-git-p4-mock-lfs.sh
@@ -0,0 +1,106 @@
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
+		test_file_count_in_dir ".git/mock-storage/remote" 2 &&
+
+		cat >expect <<-\EOF &&
+
+		#
+		# Mock LFS
+		#
+		/file2.dat filter=mock -text
+		/file4.bin filter=mock -text
+		/path[:space:]with[:space:]spaces/file3.bin filter=mock -text
+		EOF
+		test_path_is_file .gitattributes &&
+		test_cmp expect .gitattributes
+	)
+'
+
+test_expect_success 'Clone repo with existing .gitattributes file' '
+	client_view "//depot/... //client/..." &&
+	(
+		cd "$cli" &&
+
+		echo "*.txt text" >.gitattributes &&
+		p4 add .gitattributes &&
+		p4 submit -d "Add .gitattributes"
+	) &&
+
+	test_must_fail git p4 clone --use-client-spec --destination="$git" //depot 2>errs &&
+	grep ".gitattributes already exists in P4." errs
+'
+
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done
-- 
2.5.1
