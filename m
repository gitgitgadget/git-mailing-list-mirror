From: larsxschneider@gmail.com
Subject: [PATCH v4 5/5] git-p4: add Git LFS backend for large file system
Date: Wed,  9 Sep 2015 13:59:10 +0200
Message-ID: <1441799950-54633-6-git-send-email-larsxschneider@gmail.com>
References: <1441799950-54633-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 09 14:00:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZe2Y-0001Xg-Sy
	for gcvg-git-2@plane.gmane.org; Wed, 09 Sep 2015 13:59:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753562AbbIIL7m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2015 07:59:42 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:33513 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752907AbbIIL7S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2015 07:59:18 -0400
Received: by wiclk2 with SMTP id lk2so154285514wic.0
        for <git@vger.kernel.org>; Wed, 09 Sep 2015 04:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mB25NcUO079UHow06MKrP6p3Y8wweNmaXqyPdM/Q8b0=;
        b=PIeB1KaQgAoENaMVmevipxMBCJi6A1/Ex4gCUSBxG+hGagvGF1FpB7bB2xm1R8WKbP
         bj7g2NIoA+sH7S8CQxUooUaeUpIpTasr6rexVf30/Pr5evHxPP5JheLPOtg0Br8RKZJ7
         5OPP16SaXk01GzUE1QDmE30PE1pTOlsXWpj8KKVZKZhmb4z1lszqPMqA6NOhzvfdpguR
         tsa/9QgI+tplT6cTdMgyEHirJFU7Jb+siBKYMgZY05dVCvsIimg6NNALszMPC/HJ6kr+
         dJqfN1ZeYW+bD9MHgFF3B0AQOalkSl0W/pfrQ/cYZyvw8hCm8tDCf6PU9QvYwLg2wclP
         UaXA==
X-Received: by 10.194.87.69 with SMTP id v5mr55516442wjz.140.1441799956981;
        Wed, 09 Sep 2015 04:59:16 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id u1sm3498338wiz.22.2015.09.09.04.59.16
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Sep 2015 04:59:16 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1441799950-54633-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277552>

From: Lars Schneider <larsxschneider@gmail.com>

Add example implementation including test cases for the large file
system using Git LFS.

Pushing files to the Git LFS server is not tested.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 Documentation/git-p4.txt  |   4 +-
 git-p4.py                 |  52 ++++++++++
 t/t9824-git-p4-git-lfs.sh | 249 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 304 insertions(+), 1 deletion(-)
 create mode 100755 t/t9824-git-p4-git-lfs.sh

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index e0d0239..3168a64 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -515,7 +515,9 @@ git-p4.largeFileSystem::
 	Please note that most of these large file systems depend on the
 	Git clean/smudge filters. These filters are not applied through
 	git-p4. You need to create a fresh clone of the repository after
-	running git-p4.
+	running git-p4. Only Git LFS [1] is supported right now. Download
+	and install the Git LFS command line extension to use this option.
+	[1] https://git-lfs.github.com/
 
 git-p4.largeFileExtensions::
 	All files matching a file extension in the list will be processed
diff --git a/git-p4.py b/git-p4.py
index ada4174..58bdaf1 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -968,6 +968,58 @@ class MockLFS:
             os.makedirs(remotePath)
         shutil.copyfile(localLargeFile, os.path.join(remotePath, os.path.basename(localLargeFile)))
 
+class GitLFS:
+    """Git LFS as backend for the git-p4 large file system.
+       See https://git-lfs.github.com/ for details."""
+
+    @staticmethod
+    def attributeDescription():
+        """Return a description which is used to mark LFS entries in the
+           .gitattributes file."""
+        return 'Git LFS (see https://git-lfs.github.com/)'
+
+    @staticmethod
+    def attributeFilter():
+        """Return the name of the filter which is used for LFS entries in the
+           .gitattributes file."""
+        return 'lfs'
+
+    @staticmethod
+    def generatePointer(cloneDestination, contentFile):
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
+            cloneDestination,
+            '.git', 'lfs', 'objects', oid[:2], oid[2:4],
+            oid,
+        )
+        # LFS Spec states that pointer files should not have the executable bit set.
+        gitMode = '100644'
+        return (gitMode, pointerContents, localLargeFile)
+
+    @staticmethod
+    def pushFile(localLargeFile):
+        """Push the actual content which is not stored in the Git repository to
+        a server."""
+        uploadProcess = subprocess.Popen(
+            ['git', 'lfs', 'push', '--object-id', 'origin', os.path.basename(localLargeFile)]
+        )
+        if uploadProcess.wait():
+            die('git-lfs push command failed. Did you define a remote?')
+
 class Command:
     def __init__(self):
         self.usage = "usage: %prog [options]"
diff --git a/t/t9824-git-p4-git-lfs.sh b/t/t9824-git-p4-git-lfs.sh
new file mode 100755
index 0000000..f46768f
--- /dev/null
+++ b/t/t9824-git-p4-git-lfs.sh
@@ -0,0 +1,249 @@
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
+	FILE="$1"
+	SIZE="$2"
+	EXPECTED_CONTENT="$3"
+	cat "$FILE" | grep "size $SIZE"
+	HASH=$(cat "$FILE" | grep "oid sha256:" | sed -e 's/oid sha256://g')
+	LFS_FILE=".git/lfs/objects/${HASH:0:2}/${HASH:2:2}/$HASH"
+	echo $EXPECTED_CONTENT >expect
+	test_path_is_file "$FILE" &&
+	test_path_is_file "$LFS_FILE" &&
+	test_cmp expect "$LFS_FILE"
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
+		/path[:space:]with[:space:]spaces/file3.bin filter=lfs -text
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
+		! test_path_is_file file4.bin &&
+		test_file_count_in_dir ".git/lfs/objects" 2 &&
+
+		cat >expect <<-\EOF &&
+
+		#
+		# Git LFS (see https://git-lfs.github.com/)
+		#
+		/file2.dat filter=lfs -text
+		/path[:space:]with[:space:]spaces/file3.bin filter=lfs -text
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
