From: larsxschneider@gmail.com
Subject: [PATCH v8 7/7] git-p4: add Git LFS backend for large file system
Date: Sat, 26 Sep 2015 09:55:04 +0200
Message-ID: <1443254104-14966-8-git-send-email-larsxschneider@gmail.com>
References: <1443254104-14966-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 26 09:56:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfkLP-0008MX-DR
	for gcvg-git-2@plane.gmane.org; Sat, 26 Sep 2015 09:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751877AbbIZH41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2015 03:56:27 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:34596 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860AbbIZH40 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2015 03:56:26 -0400
Received: by wicfx3 with SMTP id fx3so47066842wic.1
        for <git@vger.kernel.org>; Sat, 26 Sep 2015 00:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OjJUjn+66Y9p53sBu+Dvc4jTvnwTX2dbTWufv/k6byM=;
        b=IBeRyPFBaYVFn7SPxaPvvX8avYj6IxtvQ0egJarLhQLHTt1L3v+rhFcfDx0luJJ8Dp
         m6sF1gXGrWZJGxr1E+FyYKZMQLFqOQUbn+hRZMmrqmCJepfe/2vW9B8IQfWkXmSQKXrb
         nfL2a1nK1x67LhzVPuwsTxpXl1mHM8SaS9UwVnSOIJ8eA1EttSdchXHQkfQY2L5DQc7S
         Wc41Ryb40mwbSP79MZu/8R2tnfaLe85iuazXxSBD6KhOr4V8af5Kf1X/VWCscSo+jOG1
         iKlMttA6r585C4H7GEA6CGU4w6XxjG1rQM4IyFRMmWvrBKwfERj+k27ID3+mTACZ68NE
         rBkQ==
X-Received: by 10.180.75.176 with SMTP id d16mr8091921wiw.75.1443254185277;
        Sat, 26 Sep 2015 00:56:25 -0700 (PDT)
Received: from localhost.localdomain (tmo-102-235.customers.d1-online.com. [80.187.102.235])
        by smtp.gmail.com with ESMTPSA id it4sm7176613wjb.0.2015.09.26.00.55.56
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 26 Sep 2015 00:56:24 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1443254104-14966-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278693>

From: Lars Schneider <larsxschneider@gmail.com>

Add example implementation including test cases for the large file
system using Git LFS.

Pushing files to the Git LFS server is not tested.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 git-p4.py                 |  72 ++++++++++++
 t/t9824-git-p4-git-lfs.sh | 288 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 360 insertions(+)
 create mode 100755 t/t9824-git-p4-git-lfs.sh

diff --git a/git-p4.py b/git-p4.py
index 3de8505..fddf885 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1038,6 +1038,78 @@ class MockLFS(LargeFileSystem):
             os.makedirs(remotePath)
         shutil.copyfile(localLargeFile, os.path.join(remotePath, os.path.basename(localLargeFile)))
 
+class GitLFS(LargeFileSystem):
+    """Git LFS as backend for the git-p4 large file system.
+       See https://git-lfs.github.com/ for details."""
+
+    def __init__(self, *args):
+        LargeFileSystem.__init__(self, *args)
+        self.baseGitAttributes = []
+
+    def generatePointer(self, contentFile):
+        """Generate a Git LFS pointer for the content. Return LFS Pointer file
+           mode and content which is stored in the Git repository instead of
+           the actual content. Return also the new location of the actual
+           content.
+           """
+        pointerProcess = subprocess.Popen(
+            ['git', 'lfs', 'pointer', '--file=' + contentFile],
+            stdout=subprocess.PIPE
+        )
+        pointerFile = pointerProcess.stdout.read()
+        if pointerProcess.wait():
+            os.remove(contentFile)
+            die('git-lfs pointer command failed. Did you install the extension?')
+        pointerContents = [i+'\n' for i in pointerFile.split('\n')[2:][:-1]]
+        oid = pointerContents[1].split(' ')[1].split(':')[1][:-1]
+        localLargeFile = os.path.join(
+            os.getcwd(),
+            '.git', 'lfs', 'objects', oid[:2], oid[2:4],
+            oid,
+        )
+        # LFS Spec states that pointer files should not have the executable bit set.
+        gitMode = '100644'
+        return (gitMode, pointerContents, localLargeFile)
+
+    def pushFile(self, localLargeFile):
+        uploadProcess = subprocess.Popen(
+            ['git', 'lfs', 'push', '--object-id', 'origin', os.path.basename(localLargeFile)]
+        )
+        if uploadProcess.wait():
+            die('git-lfs push command failed. Did you define a remote?')
+
+    def generateGitAttributes(self):
+        return (
+            self.baseGitAttributes +
+            [
+                '\n',
+                '#\n',
+                '# Git LFS (see https://git-lfs.github.com/)\n',
+                '#\n',
+            ] +
+            ['*.' + f.replace(' ', '[[:space:]]') + ' filter=lfs -text\n'
+                for f in sorted(gitConfigList('git-p4.largeFileExtensions'))
+            ] +
+            ['/' + f.replace(' ', '[[:space:]]') + ' filter=lfs -text\n'
+                for f in sorted(self.largeFiles) if not self.hasLargeFileExtension(f)
+            ]
+        )
+
+    def addLargeFile(self, relPath):
+        LargeFileSystem.addLargeFile(self, relPath)
+        self.writeToGitStream('100644', '.gitattributes', self.generateGitAttributes())
+
+    def removeLargeFile(self, relPath):
+        LargeFileSystem.removeLargeFile(self, relPath)
+        self.writeToGitStream('100644', '.gitattributes', self.generateGitAttributes())
+
+    def processContent(self, git_mode, relPath, contents):
+        if relPath == '.gitattributes':
+            self.baseGitAttributes = contents
+            return (git_mode, self.generateGitAttributes())
+        else:
+            return LargeFileSystem.processContent(self, git_mode, relPath, contents)
+
 class Command:
     def __init__(self):
         self.usage = "usage: %prog [options]"
diff --git a/t/t9824-git-p4-git-lfs.sh b/t/t9824-git-p4-git-lfs.sh
new file mode 100755
index 0000000..0b664a3
--- /dev/null
+++ b/t/t9824-git-p4-git-lfs.sh
@@ -0,0 +1,288 @@
+#!/bin/sh
+
+test_description='Clone repositories and store files in Git LFS'
+
+. ./lib-git-p4.sh
+
+git lfs help >/dev/null 2>&1 || {
+	skip_all='skipping git p4 Git LFS tests; Git LFS not found'
+	test_done
+}
+
+test_file_in_lfs () {
+	FILE="$1" &&
+	SIZE="$2" &&
+	EXPECTED_CONTENT="$3" &&
+	cat "$FILE" | grep "size $SIZE" &&
+	HASH=$(cat "$FILE" | grep "oid sha256:" | sed -e "s/oid sha256://g") &&
+	LFS_FILE=".git/lfs/objects/$(echo "$HASH" | cut -c1-2)/$(echo "$HASH" | cut -c3-4)/$HASH" &&
+	echo $EXPECTED_CONTENT >expect &&
+	test_path_is_file "$FILE" &&
+	test_path_is_file "$LFS_FILE" &&
+	test_cmp expect "$LFS_FILE"
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
+test_expect_success 'Store files in LFS based on size (>24 bytes)' '
+	client_view "//depot/... //client/..." &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git init . &&
+		git config git-p4.useClientSpec true &&
+		git config git-p4.largeFileSystem GitLFS &&
+		git config git-p4.largeFileThreshold 24 &&
+		git p4 clone --destination="$git" //depot@all &&
+
+		test_file_in_lfs file2.dat 25 "content 2-3 bin 25 bytes" &&
+		test_file_in_lfs "path with spaces/file3.bin" 25 "content 2-3 bin 25 bytes" &&
+		test_file_in_lfs file4.bin 26 "content 4 bin 26 bytes XX" &&
+
+		test_file_count_in_dir ".git/lfs/objects" 2 &&
+
+		cat >expect <<-\EOF &&
+
+		#
+		# Git LFS (see https://git-lfs.github.com/)
+		#
+		/file2.dat filter=lfs -text
+		/file4.bin filter=lfs -text
+		/path[[:space:]]with[[:space:]]spaces/file3.bin filter=lfs -text
+		EOF
+		test_path_is_file .gitattributes &&
+		test_cmp expect .gitattributes
+	)
+'
+
+test_expect_success 'Store files in LFS based on size (>25 bytes)' '
+	client_view "//depot/... //client/..." &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git init . &&
+		git config git-p4.useClientSpec true &&
+		git config git-p4.largeFileSystem GitLFS &&
+		git config git-p4.largeFileThreshold 25 &&
+		git p4 clone --destination="$git" //depot@all &&
+
+		test_file_in_lfs file4.bin 26 "content 4 bin 26 bytes XX" &&
+		test_file_count_in_dir ".git/lfs/objects" 1 &&
+
+		cat >expect <<-\EOF &&
+
+		#
+		# Git LFS (see https://git-lfs.github.com/)
+		#
+		/file4.bin filter=lfs -text
+		EOF
+		test_path_is_file .gitattributes &&
+		test_cmp expect .gitattributes
+	)
+'
+
+test_expect_success 'Store files in LFS based on extension (dat)' '
+	client_view "//depot/... //client/..." &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git init . &&
+		git config git-p4.useClientSpec true &&
+		git config git-p4.largeFileSystem GitLFS &&
+		git config git-p4.largeFileExtensions dat &&
+		git p4 clone --destination="$git" //depot@all &&
+
+		test_file_in_lfs file2.dat 25 "content 2-3 bin 25 bytes" &&
+		test_file_count_in_dir ".git/lfs/objects" 1 &&
+
+		cat >expect <<-\EOF &&
+
+		#
+		# Git LFS (see https://git-lfs.github.com/)
+		#
+		*.dat filter=lfs -text
+		EOF
+		test_path_is_file .gitattributes &&
+		test_cmp expect .gitattributes
+	)
+'
+
+test_expect_success 'Store files in LFS based on size (>25 bytes) and extension (dat)' '
+	client_view "//depot/... //client/..." &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git init . &&
+		git config git-p4.useClientSpec true &&
+		git config git-p4.largeFileSystem GitLFS &&
+		git config git-p4.largeFileExtensions dat &&
+		git config git-p4.largeFileThreshold 25 &&
+		git p4 clone --destination="$git" //depot@all &&
+
+		test_file_in_lfs file2.dat 25 "content 2-3 bin 25 bytes" &&
+		test_file_in_lfs file4.bin 26 "content 4 bin 26 bytes XX" &&
+		test_file_count_in_dir ".git/lfs/objects" 2 &&
+
+		cat >expect <<-\EOF &&
+
+		#
+		# Git LFS (see https://git-lfs.github.com/)
+		#
+		*.dat filter=lfs -text
+		/file4.bin filter=lfs -text
+		EOF
+		test_path_is_file .gitattributes &&
+		test_cmp expect .gitattributes
+	)
+'
+
+test_expect_success 'Remove file from repo and store files in LFS based on size (>24 bytes)' '
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
+		git config git-p4.largeFileSystem GitLFS &&
+		git config git-p4.largeFileThreshold 24 &&
+		git p4 clone --destination="$git" //depot@all &&
+
+		test_file_in_lfs file2.dat 25 "content 2-3 bin 25 bytes" &&
+		test_file_in_lfs "path with spaces/file3.bin" 25 "content 2-3 bin 25 bytes" &&
+		test_path_is_missing file4.bin &&
+		test_file_count_in_dir ".git/lfs/objects" 2 &&
+
+		cat >expect <<-\EOF &&
+
+		#
+		# Git LFS (see https://git-lfs.github.com/)
+		#
+		/file2.dat filter=lfs -text
+		/path[[:space:]]with[[:space:]]spaces/file3.bin filter=lfs -text
+		EOF
+		test_path_is_file .gitattributes &&
+		test_cmp expect .gitattributes
+	)
+'
+
+test_expect_success 'Add .gitattributes and store files in LFS based on size (>24 bytes)' '
+	client_view "//depot/... //client/..." &&
+	(
+		cd "$cli" &&
+		echo "*.txt text" >.gitattributes &&
+		p4 add .gitattributes &&
+		p4 submit -d "Add .gitattributes"
+	) &&
+
+	client_view "//depot/... //client/..." &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git init . &&
+		git config git-p4.useClientSpec true &&
+		git config git-p4.largeFileSystem GitLFS &&
+		git config git-p4.largeFileThreshold 24 &&
+		git p4 clone --destination="$git" //depot@all &&
+
+		test_file_in_lfs file2.dat 25 "content 2-3 bin 25 bytes" &&
+		test_file_in_lfs "path with spaces/file3.bin" 25 "content 2-3 bin 25 bytes" &&
+		test_path_is_missing file4.bin &&
+		test_file_count_in_dir ".git/lfs/objects" 2 &&
+
+		cat >expect <<-\EOF &&
+		*.txt text
+
+		#
+		# Git LFS (see https://git-lfs.github.com/)
+		#
+		/file2.dat filter=lfs -text
+		/path[[:space:]]with[[:space:]]spaces/file3.bin filter=lfs -text
+		EOF
+		test_path_is_file .gitattributes &&
+		test_cmp expect .gitattributes
+	)
+'
+
+test_expect_success 'Add big files to repo and store files in LFS based on compressed size (>28 bytes)' '
+	client_view "//depot/... //client/..." &&
+	(
+		cd "$cli" &&
+		echo "content 5 bin 40 bytes XXXXXXXXXXXXXXXX" >file5.bin &&
+		p4 add file5.bin &&
+		p4 submit -d "Add file with small footprint after compression" &&
+
+		echo "content 6 bin 39 bytes XXXXXYYYYYZZZZZ" >file6.bin &&
+		p4 add file6.bin &&
+		p4 submit -d "Add file with large footprint after compression"
+	) &&
+
+	client_view "//depot/... //client/..." &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git init . &&
+		git config git-p4.useClientSpec true &&
+		git config git-p4.largeFileSystem GitLFS &&
+		git config git-p4.largeFileCompressedThreshold 28 &&
+		# We only import HEAD here ("@all" is missing!)
+		git p4 clone --destination="$git" //depot &&
+
+		test_file_in_lfs file6.bin 13 "content 6 bin 39 bytes XXXXXYYYYYZZZZZ"
+		test_file_count_in_dir ".git/lfs/objects" 1 &&
+
+		cat >expect <<-\EOF &&
+		*.txt text
+
+		#
+		# Git LFS (see https://git-lfs.github.com/)
+		#
+		/file6.bin filter=lfs -text
+		EOF
+		test_path_is_file .gitattributes &&
+		test_cmp expect .gitattributes
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
