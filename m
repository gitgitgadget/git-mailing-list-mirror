From: larsxschneider@gmail.com
Subject: [PATCH v7 6/7] git-p4: add support for large file systems
Date: Tue, 22 Sep 2015 00:41:12 +0200
Message-ID: <1442875273-48610-7-git-send-email-larsxschneider@gmail.com>
References: <1442875273-48610-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: luke@diamand.org, gitster@pobox.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 22 00:41:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze9mB-0000ft-O9
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 00:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933061AbbIUWlc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Sep 2015 18:41:32 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:34469 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932655AbbIUWl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 18:41:27 -0400
Received: by wicfx3 with SMTP id fx3so167505572wic.1
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 15:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=91mn9mGNXciOoz6TvBf2Wn4v8oUsindzCx04YNpLYLw=;
        b=owVePUHHZF85IJHzT13OM+Og7nZGLdQHz4775gRWbOPmJjc6fRxy5kYP7VQIsVGtYA
         V//X308L7uldPMO9SjeiNIDirW5UyJaDtAgv1uzPWOefM2caxfOC0MBsuyFUn5MEsKmr
         K7ysxJi/7JGhdscIjBMx15vB/mQg1njvFczuebhhhHLBjkmIAq3eReU+sGb/hDcvsUBu
         5qPF7raZztdZF3slDZB3pWx0NSR4zO02R8knJ4dJfFqel1H1NfgRIYG16zHNrezFUphH
         TU+qSu9n9VMERahsFfupGsH5MPRb6ez3IY63tyQ9eK+R//EbDwCdKoZH1O60ckdB0nSA
         ZOWA==
X-Received: by 10.180.108.177 with SMTP id hl17mr15395700wib.45.1442875285971;
        Mon, 21 Sep 2015 15:41:25 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id s16sm121516wik.13.2015.09.21.15.41.24
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Sep 2015 15:41:25 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1442875273-48610-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278355>

=46rom: Lars Schneider <larsxschneider@gmail.com>

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
 Documentation/git-p4.txt   |  32 +++++++++
 git-p4.py                  | 138 +++++++++++++++++++++++++++++++++---
 t/t9823-git-p4-mock-lfs.sh | 170 +++++++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 330 insertions(+), 10 deletions(-)
 create mode 100755 t/t9823-git-p4-mock-lfs.sh

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 12a57d4..19833e6 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -517,6 +517,38 @@ git-p4.pathEncoding::
 	to transcode the paths to UTF-8. As an example, Perforce on Windows
 	often uses =E2=80=9Ccp1252=E2=80=9D to encode path names.
=20
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
index 3931989..7a80ebd 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -22,6 +22,8 @@ import platform
 import re
 import shutil
 import stat
+import zipfile
+import zlib
=20
 try:
     from subprocess import CalledProcessError
@@ -932,6 +934,110 @@ def wildcard_present(path):
     m =3D re.search("[*#@%]", path)
     return m is not None
=20
+class LargeFileSystem(object):
+    """Base class for large file system support."""
+
+    def __init__(self, writeToGitStream):
+        self.largeFiles =3D set()
+        self.writeToGitStream =3D writeToGitStream
+
+    def generatePointer(self, cloneDestination, contentFile):
+        """Return the content of a pointer file that is stored in Git =
instead of
+           the actual content."""
+        assert False, "Method 'generatePointer' required in " + self._=
_class__.__name__
+
+    def pushFile(self, localLargeFile):
+        """Push the actual content which is not stored in the Git repo=
sitory to
+           a server."""
+        assert False, "Method 'pushFile' required in " + self.__class_=
_.__name__
+
+    def hasLargeFileExtension(self, relPath):
+        return reduce(
+            lambda a, b: a or b,
+            [relPath.endswith('.' + e) for e in gitConfigList('git-p4.=
largeFileExtensions')],
+            False
+        )
+
+    def generateTempFile(self, contents):
+        contentFile =3D tempfile.NamedTemporaryFile(prefix=3D'git-p4-l=
arge-file', delete=3DFalse)
+        for d in contents:
+            contentFile.write(d)
+        contentFile.close()
+        return contentFile.name
+
+    def exceedsLargeFileThreshold(self, relPath, contents):
+        if gitConfigInt('git-p4.largeFileThreshold'):
+            contentsSize =3D sum(len(d) for d in contents)
+            if contentsSize > gitConfigInt('git-p4.largeFileThreshold'=
):
+                return True
+        if gitConfigInt('git-p4.largeFileCompressedThreshold'):
+            contentsSize =3D sum(len(d) for d in contents)
+            if contentsSize <=3D gitConfigInt('git-p4.largeFileCompres=
sedThreshold'):
+                return False
+            contentTempFile =3D self.generateTempFile(contents)
+            compressedContentFile =3D tempfile.NamedTemporaryFile(pref=
ix=3D'git-p4-large-file', delete=3DFalse)
+            zf =3D zipfile.ZipFile(compressedContentFile.name, mode=3D=
'w')
+            zf.write(contentTempFile, compress_type=3Dzipfile.ZIP_DEFL=
ATED)
+            zf.close()
+            compressedContentsSize =3D zf.infolist()[0].compress_size
+            os.remove(contentTempFile)
+            os.remove(compressedContentFile.name)
+            if compressedContentsSize > gitConfigInt('git-p4.largeFile=
CompressedThreshold'):
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
+    def processContent(self, cloneDestination, git_mode, relPath, cont=
ents):
+        """Processes the content of git fast import. This method decid=
es if a
+           file is stored in the large file system and handles all nec=
essary
+           steps."""
+        if self.exceedsLargeFileThreshold(relPath, contents) or self.h=
asLargeFileExtension(relPath):
+            contentTempFile =3D self.generateTempFile(contents)
+            (git_mode, contents, localLargeFile) =3D self.generatePoin=
ter(cloneDestination, contentTempFile)
+
+            # Move temp file to final location in large file system
+            largeFileDir =3D os.path.dirname(localLargeFile)
+            if not os.path.isdir(largeFileDir):
+                os.makedirs(largeFileDir)
+            shutil.move(contentTempFile, localLargeFile)
+            self.addLargeFile(relPath)
+            if gitConfigBool('git-p4.pushLargeFiles'):
+                self.pushFile(localLargeFile)
+            if verbose:
+                sys.stderr.write("%s moved to large file system (%s)\n=
" % (relPath, localLargeFile))
+        return (git_mode, contents)
+
+class MockLFS(LargeFileSystem):
+    """Mock large file system for testing."""
+
+    def generatePointer(self, cloneDestination, contentFile):
+        """The pointer content is the original content prefixed with "=
pointer-".
+           The local filename of the large file storage is derived fro=
m the file content.
+           """
+        with open(contentFile, 'r') as f:
+            content =3D next(f)
+            gitMode =3D '100644'
+            pointerContents =3D 'pointer-' + content
+            localLargeFile =3D os.path.join(cloneDestination, '.git', =
'mock-storage', 'local', content[:-1])
+            return (gitMode, pointerContents, localLargeFile)
+
+    def pushFile(self, localLargeFile):
+        """The remote filename of the large file storage is the same a=
s the local
+           one but in a different directory.
+           """
+        remotePath =3D os.path.join(os.path.dirname(localLargeFile), '=
=2E.', 'remote')
+        if not os.path.exists(remotePath):
+            os.makedirs(remotePath)
+        shutil.copyfile(localLargeFile, os.path.join(remotePath, os.pa=
th.basename(localLargeFile)))
+
 class Command:
     def __init__(self):
         self.usage =3D "usage: %prog [options]"
@@ -1105,6 +1211,9 @@ class P4Submit(Command, P4UserMap):
         self.p4HasMoveCommand =3D p4_has_move_command()
         self.branch =3D None
=20
+        if gitConfig('git-p4.largeFileSystem'):
+            die("Large file system not supported for git-p4 submit com=
mand. Please remove it from config.")
+
     def check(self):
         if len(p4CmdList("opened ...")) > 0:
             die("You have files opened with perforce! Close them befor=
e starting the sync.")
@@ -2064,6 +2173,12 @@ class P4Sync(Command, P4UserMap):
                 lambda git_mode, relPath, contents: self.writeToGitStr=
eam(git_mode, relPath, contents)
             )
=20
+        if gitConfig('git-p4.largeFileSystem'):
+            largeFileSystemConstructor =3D globals()[gitConfig('git-p4=
=2ElargeFileSystem')]
+            self.largeFileSystem =3D largeFileSystemConstructor(
+                lambda git_mode, relPath, contents: self.writeToGitStr=
eam(git_mode, relPath, contents)
+            )
+
         if gitConfig("git-p4.syncFromOrigin") =3D=3D "false":
             self.syncWithOrigin =3D False
=20
@@ -2183,6 +2298,13 @@ class P4Sync(Command, P4UserMap):
=20
         return branches
=20
+    def writeToGitStream(self, gitMode, relPath, contents):
+        self.gitStream.write('M %s inline %s\n' % (gitMode, relPath))
+        self.gitStream.write('data %d\n' % sum(len(d) for d in content=
s))
+        for d in contents:
+            self.gitStream.write(d)
+        self.gitStream.write('\n')
+
     # output one file from the P4 stream
     # - helper for streamP4Files
=20
@@ -2263,17 +2385,10 @@ class P4Sync(Command, P4UserMap):
             if self.verbose:
                 print 'Path with non-ASCII characters detected. Used %=
s to encode: %s ' % (encoding, relPath)
=20
-        self.gitStream.write("M %s inline %s\n" % (git_mode, relPath))
+        if self.largeFileSystem:
+            (git_mode, contents) =3D self.largeFileSystem.processConte=
nt(self.cloneDestination, git_mode, relPath, contents)
=20
-        # total length...
-        length =3D 0
-        for d in contents:
-            length =3D length + len(d)
-
-        self.gitStream.write("data %d\n" % length)
-        for d in contents:
-            self.gitStream.write(d)
-        self.gitStream.write("\n")
+        self.writeToGitStream(git_mode, relPath, contents)
=20
     def streamOneP4Deletion(self, file):
         relPath =3D self.stripRepoPath(file['path'], self.branchPrefix=
es)
@@ -2282,6 +2397,9 @@ class P4Sync(Command, P4UserMap):
             sys.stdout.flush()
         self.gitStream.write("D %s\n" % relPath)
=20
+        if self.largeFileSystem and self.largeFileSystem.isLargeFile(r=
elPath):
+            self.largeFileSystem.removeLargeFile(relPath)
+
     # handle another chunk of streaming data
     def streamP4FilesCb(self, marshalled):
=20
diff --git a/t/t9823-git-p4-mock-lfs.sh b/t/t9823-git-p4-mock-lfs.sh
new file mode 100755
index 0000000..5684ee3
--- /dev/null
+++ b/t/t9823-git-p4-mock-lfs.sh
@@ -0,0 +1,170 @@
+#!/bin/sh
+
+test_description=3D'Clone repositories and store files in Mock LFS'
+
+. ./lib-git-p4.sh
+
+test_file_is_not_in_mock_lfs () {
+	FILE=3D"$1" &&
+	CONTENT=3D"$2" &&
+	echo "$CONTENT" >expect_content &&
+	test_path_is_file "$FILE" &&
+	test_cmp expect_content "$FILE"
+}
+
+test_file_is_in_mock_lfs () {
+	FILE=3D"$1" &&
+	CONTENT=3D"$2" &&
+	LOCAL_STORAGE=3D".git/mock-storage/local/$CONTENT" &&
+	SERVER_STORAGE=3D".git/mock-storage/remote/$CONTENT" &&
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
+	FILE=3D"$1" &&
+	CONTENT=3D"$2" &&
+	LOCAL_STORAGE=3D".git/mock-storage/local/$CONTENT" &&
+	SERVER_STORAGE=3D".git/mock-storage/remote/$CONTENT" &&
+	echo "pointer-$CONTENT" >expect_pointer &&
+	echo "$CONTENT" >expect_content &&
+	! test_path_is_file "$FILE" &&
+	test_path_is_file "$LOCAL_STORAGE" &&
+	test_path_is_file "$SERVER_STORAGE" &&
+	test_cmp expect_content "$LOCAL_STORAGE" &&
+	test_cmp expect_content "$SERVER_STORAGE"
+}
+
+test_file_count_in_dir () {
+	DIR=3D"$1" &&
+	EXPECTED_COUNT=3D"$2" &&
+	find "$DIR" -type f >actual &&
+	test_line_count =3D $EXPECTED_COUNT actual
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
+		p4 submit -d "Add another binary file with same content and spaces i=
n path" &&
+
+		echo "content 4 bin 26 bytes XX" >file4.bin &&
+		p4 add file4.bin &&
+		p4 submit -d "Add another binary file with different content"
+	)
+'
+
+test_expect_success 'Store files in Mock LFS based on size (>24 bytes)=
' '
+	client_view "//depot/... //client/..." &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git init . &&
+		git config git-p4.useClientSpec true &&
+		git config git-p4.largeFileSystem MockLFS &&
+		git config git-p4.largeFileThreshold 24 &&
+		git config git-p4.pushLargeFiles True &&
+		git p4 clone --destination=3D"$git" //depot@all &&
+
+		test_file_is_not_in_mock_lfs file1.txt "content 1 txt 23 bytes" &&
+		test_file_is_in_mock_lfs file2.dat "content 2-3 bin 25 bytes" &&
+		test_file_is_in_mock_lfs "path with spaces/file3.bin" "content 2-3 b=
in 25 bytes" &&
+		test_file_is_in_mock_lfs file4.bin "content 4 bin 26 bytes XX" &&
+
+		test_file_count_in_dir ".git/mock-storage/local" 2 &&
+		test_file_count_in_dir ".git/mock-storage/remote" 2
+	)
+'
+
+test_expect_success 'Store files in Mock LFS based on extension (dat)'=
 '
+	client_view "//depot/... //client/..." &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git init . &&
+		git config git-p4.useClientSpec true &&
+		git config git-p4.largeFileSystem MockLFS &&
+		git config git-p4.largeFileExtensions dat &&
+		git config git-p4.pushLargeFiles True &&
+		git p4 clone --destination=3D"$git" //depot@all &&
+
+		test_file_is_not_in_mock_lfs file1.txt "content 1 txt 23 bytes" &&
+		test_file_is_in_mock_lfs file2.dat "content 2-3 bin 25 bytes" &&
+		test_file_is_not_in_mock_lfs "path with spaces/file3.bin" "content 2=
-3 bin 25 bytes" &&
+		test_file_is_not_in_mock_lfs file4.bin "content 4 bin 26 bytes XX" &=
&
+
+		test_file_count_in_dir ".git/mock-storage/local" 1 &&
+		test_file_count_in_dir ".git/mock-storage/remote" 1
+	)
+'
+
+test_expect_success 'Remove file from repo and store files in Mock LFS=
 based on size (>24 bytes)' '
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
+		git config git-p4.pushLargeFiles True &&
+		git p4 clone --destination=3D"$git" //depot@all &&
+
+		test_file_is_not_in_mock_lfs file1.txt "content 1 txt 23 bytes" &&
+		test_file_is_in_mock_lfs file2.dat "content 2-3 bin 25 bytes" &&
+		test_file_is_in_mock_lfs "path with spaces/file3.bin" "content 2-3 b=
in 25 bytes" &&
+		test_file_is_deleted_in_mock_lfs file4.bin "content 4 bin 26 bytes X=
X" &&
+
+		test_file_count_in_dir ".git/mock-storage/local" 2 &&
+		test_file_count_in_dir ".git/mock-storage/remote" 2
+	)
+'
+
+test_expect_success 'Run git p4 submit in repo configured with large f=
ile system' '
+	client_view "//depot/... //client/..." &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git init . &&
+		git config git-p4.useClientSpec true &&
+		git config git-p4.largeFileSystem MockLFS &&
+		git config git-p4.largeFileThreshold 24 &&
+		git config git-p4.pushLargeFiles True &&
+		git p4 clone --destination=3D"$git" //depot@all &&
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
--=20
2.5.1
