From: larsxschneider@gmail.com
Subject: [PATCH v3 5/5] git-p4: add Git LFS backend for large file system
Date: Mon,  7 Sep 2015 14:21:18 +0200
Message-ID: <1441628478-86503-6-git-send-email-larsxschneider@gmail.com>
References: <1441628478-86503-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 07 14:21:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYvQe-0000L3-EC
	for gcvg-git-2@plane.gmane.org; Mon, 07 Sep 2015 14:21:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbbIGMVf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2015 08:21:35 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:37858 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbbIGMV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2015 08:21:28 -0400
Received: by wicfx3 with SMTP id fx3so82146169wic.0
        for <git@vger.kernel.org>; Mon, 07 Sep 2015 05:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y2K6cSiJ33O34PH9JypeV11V6u++FifX2nkSOFRDC4A=;
        b=rsFyV/PxBtaXtJAFZOsDkvZ6pB1jlrN9AgBB/3kqY+xnJteVNpWcCZ0q07mpx7VTBJ
         A0wY7oZ4MgQYqMNGVhRifZvsKOCVn7zKAFMXNVsExYJGofgyxMMMQ8VR8TKHT/JE5zMA
         W0mH8/71vZ8F/qNjUmCFn15aqI+5OTu/1eR/YNeeWRs+dqCTThKhJztE8mYLT/Y0NnMn
         OC/Npnmke5h1nTNUBfjcecFQ2/2MrTpNwTyRTL8On/3AqaVdpbux/ikpGJKVjL+a8old
         HQvlCqYKnn6LvuINVtKhVMr4I6obNJqi8Y2DWljbfwgYgk8MKFlMUXHy8enI9jCQT0UU
         jQuA==
X-Received: by 10.180.99.39 with SMTP id en7mr32662220wib.49.1441628486690;
        Mon, 07 Sep 2015 05:21:26 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id gc19sm2441591wic.19.2015.09.07.05.21.25
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Sep 2015 05:21:26 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1441628478-86503-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277455>

From: Lars Schneider <larsxschneider@gmail.com>

Add example implementation including test cases for the large file
system using Git LFS.

Pushing files to the Git LFS server is not tested.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 Documentation/git-p4.txt |   4 +-
 git-p4.py                |  52 ++++++++++
 t/t9823-git-p4-lfs.sh    | 263 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 318 insertions(+), 1 deletion(-)
 create mode 100755 t/t9823-git-p4-lfs.sh

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
index 06651a8..d24d84f 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -935,6 +935,58 @@ def largeFileSystem():
     except AttributeError as e:
         die('Large file system not supported: %s' % gitConfig('git-p4.largeFileSystem'))
 
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
+        oidPath = os.path.join(
+            cloneDestination,
+            '.git', 'lfs', 'objects', oid[:2], oid[2:4],
+            oid,
+        )
+        # LFS Spec states that pointer files should not have the executable bit set.
+        gitMode = '100644'
+        return (gitMode, pointerContents, oidPath)
+
+    @staticmethod
+    def pushFile(contentFile):
+        """Push the actual content which is not stored in the Git repository to
+        a server."""
+        uploadProcess = subprocess.Popen(
+            ['git', 'lfs', 'push', '--object-id', 'origin', os.path.basename(contentFile)]
+        )
+        if uploadProcess.wait():
+            die('git-lfs push command failed. Did you define a remote?')
+
 class Command:
     def __init__(self):
         self.usage = "usage: %prog [options]"
diff --git a/t/t9823-git-p4-lfs.sh b/t/t9823-git-p4-lfs.sh
new file mode 100755
index 0000000..4d58cac
--- /dev/null
+++ b/t/t9823-git-p4-lfs.sh
@@ -0,0 +1,263 @@
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
+test_file_in_lfs() {
+	FILE=$1
+	SIZE=$2
+	EXPECTED_CONTENT=$3
+	test_path_is_file $FILE &&
+	test_line_count = 3 $FILE &&
+	cat $FILE | grep "size $SIZE" &&
+	HASH=$(cat $FILE | grep "oid sha256:" | sed -e 's/oid sha256://g') &&
+	LFS_FILE=".git/lfs/objects/${HASH:0:2}/${HASH:2:2}/$HASH"
+	test_path_is_file $LFS_FILE &&
+	echo $EXPECTED_CONTENT >expect
+	test_cmp expect $LFS_FILE
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
+		echo "txt 7b" >file1.txt &&
+		p4 add file1.txt &&
+		echo "bin 13 bytes" >file2.dat &&
+		p4 add file2.dat &&
+		p4 submit -d "Add text and binary file" &&
+
+		mkdir "path with spaces" &&
+		echo "bin 13 bytes" >"path with spaces/file3.bin" &&
+		p4 add "path with spaces/file3.bin" &&
+		p4 submit -d "Add another binary file with same content and spaces in path" &&
+
+		echo "bin 14 bytesx" >file4.bin &&
+		p4 add file4.bin &&
+		p4 submit -d "Add another binary file with different content"
+	)
+'
+
+test_expect_success 'Store files in LFS based on size (>12 bytes)' '
+	client_view "//depot/... //client/..." &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git init . &&
+		git config git-p4.largeFileSystem GitLFS &&
+		git config git-p4.largeFileThreshold 12 &&
+		git p4 clone --use-client-spec --destination="$git" //depot@all &&
+
+		test_file_in_lfs file2.dat 13 "bin 13 bytes" &&
+		test_file_in_lfs "path with spaces/file3.bin" 13 "bin 13 bytes" &&
+		test_file_in_lfs file4.bin 14 "bin 14 bytesx" &&
+
+		find ".git/lfs/objects" -type f >actual &&
+		test_line_count = 2 actual &&
+
+		cat >expect <<-\EOF &&
+
+		#
+		# Git LFS (see https://git-lfs.github.com/)
+		#
+		/file2.dat filter=lfs -text
+		/path[:space:]with[:space:]spaces/file3.bin filter=lfs -text
+		/file4.bin filter=lfs -text
+		EOF
+		test_path_is_file .gitattributes &&
+		test_cmp expect .gitattributes
+	)
+'
+
+test_expect_success 'Store files in LFS based on size (>13 bytes)' '
+	client_view "//depot/... //client/..." &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git init . &&
+		git config git-p4.largeFileSystem GitLFS &&
+		git config git-p4.largeFileThreshold 13 &&
+		git p4 clone --use-client-spec --destination="$git" //depot@all &&
+
+		test_file_in_lfs file4.bin 14 "bin 14 bytesx" &&
+
+		find ".git/lfs/objects" -type f >actual &&
+		test_line_count = 1 actual &&
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
+		git config git-p4.largeFileSystem GitLFS &&
+		git config git-p4.largeFileExtensions dat &&
+		git p4 clone --use-client-spec --destination="$git" //depot@all &&
+
+		test_file_in_lfs file2.dat 13 "bin 13 bytes" &&
+
+		find ".git/lfs/objects" -type f >actual &&
+		test_line_count = 1 actual &&
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
+test_expect_success 'Store files in LFS based on size (>13 bytes) and extension (dat)' '
+	client_view "//depot/... //client/..." &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git init . &&
+		git config git-p4.largeFileSystem GitLFS &&
+		git config git-p4.largeFileExtensions dat &&
+		git config git-p4.largeFileThreshold 13 &&
+		git p4 clone --use-client-spec --destination="$git" //depot@all &&
+
+		test_file_in_lfs file2.dat 13 "bin 13 bytes" &&
+		test_file_in_lfs file4.bin 14 "bin 14 bytesx" &&
+
+		find ".git/lfs/objects" -type f >actual &&
+		test_line_count = 2 actual &&
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
+test_expect_success 'Remove file from repo and store files in LFS based on size (>12 bytes)' '
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
+		git config git-p4.largeFileSystem GitLFS &&
+		git config git-p4.largeFileThreshold 12 &&
+		git p4 clone --use-client-spec --destination="$git" //depot@all &&
+
+		test_file_in_lfs file2.dat 13 "bin 13 bytes" &&
+		test_file_in_lfs "path with spaces/file3.bin" 13 "bin 13 bytes" &&
+		! test_path_is_file file4.bin &&
+
+		find ".git/lfs/objects" -type f >actual &&
+		# 3 is correct here as some commits in the tree still reference the deleted file
+		test_line_count = 3 actual
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
+test_expect_success 'Add big files to repo and store files in LFS based on compressed size (>19 bytes)' '
+	client_view "//depot/... //client/..." &&
+	(
+		cd "$cli" &&
+		echo "bin 24 bytesxxxxxxxxxxx" >file5.bin &&
+		p4 add file5.bin &&
+		p4 submit -d "Add another binary file with different content" &&
+
+		echo "bin 34 bytesxxxxxxxxxxxzzzzzzzzzz" >file6.bin &&
+		p4 add file6.bin &&
+		p4 submit -d "Add another binary file with different content"
+	) &&
+
+	client_view "//depot/... //client/..." &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git init . &&
+		git config git-p4.largeFileSystem GitLFS &&
+		git config git-p4.largeFileCompressedThreshold 19 &&
+		# We only import HEAD here ("@all" is missing!)
+		git p4 clone --use-client-spec --destination="$git" //depot &&
+
+		test_file_in_lfs file6.bin 13 "bin 34 bytesxxxxxxxxxxxzzzzzzzzzz" &&
+
+		find ".git/lfs/objects" -type f >actual &&
+		test_line_count = 1 actual
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
