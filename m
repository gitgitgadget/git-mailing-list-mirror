From: larsxschneider@gmail.com
Subject: [RFC PATCH] git-p4: add option to store files in Git LFS on import
Date: Fri, 28 Aug 2015 14:24:51 +0200
Message-ID: <1440764691-62254-2-git-send-email-larsxschneider@gmail.com>
References: <1440764691-62254-1-git-send-email-larsxschneider@gmail.com>
Cc: Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org, luke@diamand.org, technoweenie@github.com
X-From: git-owner@vger.kernel.org Fri Aug 28 14:25:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVIiL-0001Nh-53
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 14:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbbH1MY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 08:24:57 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:35935 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963AbbH1MY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 08:24:56 -0400
Received: by wicfv10 with SMTP id fv10so6843721wic.1
        for <git@vger.kernel.org>; Fri, 28 Aug 2015 05:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lFngny8XEmcEF6Ptdf/HlXI7dBkEEZkoxomiVB/hfkQ=;
        b=JPyPSsV8v5RYJd8xulcABBORaeiWv31H5YPvyWDC4OjZGj097UeOy0V3+hzqiptX1L
         MtsCkpnXl1AcS9fcW2xGu0lwSmk/E5dX20sTy4MGdlfN/DdahRUujxmtn5jmUkntkiix
         QyWU9SYry9pZ4HW5fvfscIN/1hsRUizo6F7qRK2uHg9DNRtOomXcxjTfpA4JtX1vMj8o
         mBOwe6qztQ+4IfhI/KLhTsJAbR2nmsgQ6qPDzFw87javjPV03zVf4cRMdALa7C51LGkT
         vzpsjmptK/U2xkhvv2ippTyiGNp6EYw/eCxU1GQUUyrkG3Dfr/9i04b4uc2Xo324dNYO
         18FA==
X-Received: by 10.180.11.207 with SMTP id s15mr4402478wib.75.1440764694795;
        Fri, 28 Aug 2015 05:24:54 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id d7sm3548733wiz.22.2015.08.28.05.24.54
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Aug 2015 05:24:54 -0700 (PDT)
X-Mailer: git-send-email 1.9.5 (Apple Git-50.3)
In-Reply-To: <1440764691-62254-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276720>

From: Lars Schneider <larsxschneider@gmail.com>

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 Documentation/git-p4.txt |  12 ++
 git-p4.py                |  94 ++++++++++++++--
 t/t9822-git-p4-lfs.sh    | 277 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 374 insertions(+), 9 deletions(-)
 create mode 100755 t/t9822-git-p4-lfs.sh

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 82aa5d6..a188840 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -252,6 +252,18 @@ Git repository:
 	Use a client spec to find the list of interesting files in p4.
 	See the "CLIENT SPEC" section below.
 
+--use-lfs-if-size-exceeds <n>::
+	Store files that have an uncompressed size exceeding 'n' bytes in 
+	Git LFS. Download and install the Git LFS command line extension to
+	use that option.
+	More info here: https://git-lfs.github.com/
+
+--use-lfs-for-extension <extension>::
+	Store files with 'extension' in Git LFS. Do not prefix the extensions
+	with a '.'. You can use this option multiple times. Download and 
+	install the Git LFS command line extension to use that option.
+	More info here: https://git-lfs.github.com/
+
 -/ <path>::
 	Exclude selected depot paths when cloning or syncing.
 
diff --git a/git-p4.py b/git-p4.py
index 073f87b..e031021 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -22,6 +22,7 @@ import platform
 import re
 import shutil
 import stat
+import errno
 
 try:
     from subprocess import CalledProcessError
@@ -104,6 +105,16 @@ def chdir(path, is_client_path=False):
         path = os.getcwd()
     os.environ['PWD'] = path
 
+def mkdir_p(path):
+    # Copied from http://stackoverflow.com/questions/600268/mkdir-p-functionality-in-python
+    try:
+        os.makedirs(path)
+    except OSError as exc: # Python >2.5
+        if exc.errno == errno.EEXIST and os.path.isdir(path):
+            pass
+        else:
+            raise
+
 def die(msg):
     if verbose:
         raise Exception(msg)
@@ -1994,6 +2005,11 @@ class P4Sync(Command, P4UserMap):
                 optparse.make_option("-/", dest="cloneExclude",
                                      action="append", type="string",
                                      help="exclude depot path"),
+                optparse.make_option("--use-lfs-if-size-exceeds", dest="lfsMinimumFileSize", type="int",
+                                     help="Use LFS to store files bigger than the given threshold in bytes."),
+                optparse.make_option("--use-lfs-for-extension", dest="lfsFileExtensions",
+                                     action="append", type="string",
+                                     help="Use LFS to store files with the given file extension(s)."),
         ]
         self.description = """Imports from Perforce into a git repository.\n
     example:
@@ -2025,6 +2041,9 @@ class P4Sync(Command, P4UserMap):
         self.clientSpecDirs = None
         self.tempBranches = []
         self.tempBranchLocation = "git-p4-tmp"
+        self.lfsFiles = []
+        self.lfsMinimumFileSize = None
+        self.lfsFileExtensions = []
 
         if gitConfig("git-p4.syncFromOrigin") == "false":
             self.syncWithOrigin = False
@@ -2145,6 +2164,63 @@ class P4Sync(Command, P4UserMap):
 
         return branches
 
+    def writeToGitStream(self, gitMode, relPath, contents):
+        self.gitStream.write('M %s inline %s\n' % (gitMode, relPath))
+        self.gitStream.write('data %d\n' % sum(len(d) for d in contents))
+        for d in contents:
+            self.gitStream.write(d)
+        self.gitStream.write('\n')
+
+    def writeGitAttributesToStream(self):
+        gitAttributes = [f + ' filter=lfs -text\n' for f in self.lfsFiles if not self.hasFileLFSExtension(f)]
+        self.writeToGitStream(
+            '100644',
+            '.gitattributes',
+            ['*.' + f + ' filter=lfs -text\n' for f in self.lfsFileExtensions] +
+            [f + ' filter=lfs -text\n' for f in self.lfsFiles if not self.hasFileLFSExtension(f)]
+        )
+
+    def hasFileLFSExtension(self, relPath):
+        return reduce(
+            lambda a, b: a or b,
+            [relPath.endswith('.' + e) for e in self.lfsFileExtensions],
+            False
+        )
+
+    def isFileLargerThanLFSTreshold(self, relPath, contents):
+        return self.lfsMinimumFileSize and sum(len(d) for d in contents) >= self.lfsMinimumFileSize
+
+    def generateLFSPointerFile(self, relPath, contents):
+        # Write P4 content to temp file
+        p4ContentTempFile = tempfile.NamedTemporaryFile(prefix='git-lfs', delete=False)
+        for d in contents:
+            p4ContentTempFile.write(d)
+        p4ContentTempFile.flush()
+
+        # Generate LFS pointer file based on P4 content
+        lfsProcess = subprocess.Popen(
+            ['git', 'lfs', 'pointer', '--file=' + p4ContentTempFile.name],
+            stdout=subprocess.PIPE
+        )
+        lfsPointerFile = lfsProcess.stdout.read()
+        if lfsProcess.wait():
+            die('git-lfs command failed. Did you install the extension?')
+        contents = [i+'\n' for i in lfsPointerFile.split('\n')[2:][:-1]]
+
+        # Write P4 content to LFS
+        oid = contents[1].split(' ')[1].split(':')[1][:-1]
+        oidPath = os.path.join(self.cloneDestination, '.git', 'lfs', 'objects', oid[:2], oid[2:4])
+        mkdir_p(oidPath)
+        shutil.move(p4ContentTempFile.name, os.path.join(oidPath, oid))
+
+        # Update Git attributes
+        self.lfsFiles.append(relPath)
+        self.writeGitAttributesToStream()
+
+        # LFS Spec states that pointer files should not have the executable bit set.
+        gitMode = '100644'
+        return (gitMode, contents)
+
     # output one file from the P4 stream
     # - helper for streamP4Files
 
@@ -2213,17 +2289,13 @@ class P4Sync(Command, P4UserMap):
             text = regexp.sub(r'$\1$', text)
             contents = [ text ]
 
-        self.gitStream.write("M %s inline %s\n" % (git_mode, relPath))
+        if relPath == '.gitattributes':
+            die('.gitattributes already exists in P4.')
 
-        # total length...
-        length = 0
-        for d in contents:
-            length = length + len(d)
+        if self.isFileLargerThanLFSTreshold(relPath, contents) or self.hasFileLFSExtension(relPath):
+            (git_mode, contents) = self.generateLFSPointerFile(relPath, contents)
 
-        self.gitStream.write("data %d\n" % length)
-        for d in contents:
-            self.gitStream.write(d)
-        self.gitStream.write("\n")
+        self.writeToGitStream(git_mode, relPath, contents)
 
     def streamOneP4Deletion(self, file):
         relPath = self.stripRepoPath(file['path'], self.branchPrefixes)
@@ -2231,6 +2303,10 @@ class P4Sync(Command, P4UserMap):
             sys.stderr.write("delete %s\n" % relPath)
         self.gitStream.write("D %s\n" % relPath)
 
+        if relPath in self.lfsFiles:
+            self.lfsFiles.remove(relPath)
+            self.writeGitAttributesToStream()
+
     # handle another chunk of streaming data
     def streamP4FilesCb(self, marshalled):
 
diff --git a/t/t9822-git-p4-lfs.sh b/t/t9822-git-p4-lfs.sh
new file mode 100755
index 0000000..b27bf29
--- /dev/null
+++ b/t/t9822-git-p4-lfs.sh
@@ -0,0 +1,277 @@
+#!/bin/sh
+
+test_description='Clone repositories and store files in LFS'
+
+( git lfs help ) >/dev/null 2>&1 || {
+	skip_all='skipping git p4 LFS tests; no git lfs'
+	test_done
+}
+
+. ./lib-git-p4.sh
+
+test_expect_success 'start p4d' '
+	start_p4d
+'
+
+test_expect_success 'Create repo with binary files' '
+	client_view "//depot/... //client/..." &&
+	(
+		cd "$cli" &&
+		echo "text" >file.txt &&
+		echo "bin 13 bytes" >file.dat &&
+		p4 add file.txt &&
+		p4 add file.dat &&
+		p4 submit -d "Add text and binary file" &&
+		echo "bin 13 bytes" >file2.bin &&
+		p4 add file2.bin &&
+		p4 submit -d "Add another binary file with same content"
+		echo "bin 14 bytess" >file3.bin &&
+		p4 add file3.bin &&
+		p4 submit -d "Add another binary file with different content"
+	)
+'
+
+test_expect_success 'Store files in LFS based on size (10 bytes)' '
+	client_view "//depot/... //client/..." &&
+	git p4 clone --use-client-spec --use-lfs-if-size-exceeds=10 --destination="$git" //depot@all &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+
+		cat >expect <<-\EOF &&
+		.git/lfs/objects/d4/43/d443795c1aa3ff7e62afd89d6a86bb84ceba0305f6c22151aa8ee95077a39101
+		.git/lfs/objects/e5/fe/e5fec48503cd7b85eb9ffaea3311cde2fe9542078b9640369032b26bb5403fff
+		EOF
+		find ".git/lfs/objects" -type f >actual &&
+		test_cmp expect actual &&
+
+		cat >expect <<-\EOF &&
+		version https://git-lfs.github.com/spec/v1
+		oid sha256:d443795c1aa3ff7e62afd89d6a86bb84ceba0305f6c22151aa8ee95077a39101
+		size 13
+		EOF
+		cat file.dat >actual &&
+		test_cmp expect actual &&
+
+		cat >expect <<-\EOF &&
+		version https://git-lfs.github.com/spec/v1
+		oid sha256:d443795c1aa3ff7e62afd89d6a86bb84ceba0305f6c22151aa8ee95077a39101
+		size 13
+		EOF
+		cat file2.bin >actual &&
+		test_cmp expect actual &&
+
+		cat >expect <<-\EOF &&
+		version https://git-lfs.github.com/spec/v1
+		oid sha256:e5fec48503cd7b85eb9ffaea3311cde2fe9542078b9640369032b26bb5403fff
+		size 14
+		EOF
+		cat file3.bin >actual &&
+		test_cmp expect actual &&
+
+		cat >expect <<-\EOF &&
+		file.dat filter=lfs -text
+		file2.bin filter=lfs -text
+		file3.bin filter=lfs -text
+		EOF
+		cat .gitattributes >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'Store files in LFS based on size (14 bytes)' '
+	client_view "//depot/... //client/..." &&
+	git p4 clone --use-client-spec --use-lfs-if-size-exceeds=14 --destination="$git" //depot@all &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+
+		cat >expect <<-\EOF &&
+		.git/lfs/objects/e5/fe/e5fec48503cd7b85eb9ffaea3311cde2fe9542078b9640369032b26bb5403fff
+		EOF
+		find ".git/lfs/objects" -type f >actual &&
+		test_cmp expect actual &&
+
+		cat >expect <<-\EOF &&
+		bin 13 bytes
+		EOF
+		cat file.dat >actual &&
+		test_cmp expect actual &&
+
+		cat >expect <<-\EOF &&
+		bin 13 bytes
+		EOF
+		cat file2.bin >actual &&
+		test_cmp expect actual &&
+
+		cat >expect <<-\EOF &&
+		version https://git-lfs.github.com/spec/v1
+		oid sha256:e5fec48503cd7b85eb9ffaea3311cde2fe9542078b9640369032b26bb5403fff
+		size 14
+		EOF
+		cat file3.bin >actual &&
+		test_cmp expect actual &&
+
+		cat >expect <<-\EOF &&
+		file3.bin filter=lfs -text
+		EOF
+		cat .gitattributes >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'Store files in LFS based on extension (dat)' '
+	client_view "//depot/... //client/..." &&
+	git p4 clone --use-client-spec --use-lfs-for-extension=dat --destination="$git" //depot@all &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+
+		cat >expect <<-\EOF &&
+		.git/lfs/objects/d4/43/d443795c1aa3ff7e62afd89d6a86bb84ceba0305f6c22151aa8ee95077a39101
+		EOF
+		find ".git/lfs/objects" -type f >actual &&
+		test_cmp expect actual &&
+
+		cat >expect <<-\EOF &&
+		version https://git-lfs.github.com/spec/v1
+		oid sha256:d443795c1aa3ff7e62afd89d6a86bb84ceba0305f6c22151aa8ee95077a39101
+		size 13
+		EOF
+		cat file.dat >actual &&
+		test_cmp expect actual &&
+
+		cat >expect <<-\EOF &&
+		bin 13 bytes
+		EOF
+		cat file2.bin >actual &&
+		test_cmp expect actual &&
+
+		cat >expect <<-\EOF &&
+		bin 14 bytess
+		EOF
+		cat file3.bin >actual &&
+		test_cmp expect actual &&
+
+		cat >expect <<-\EOF &&
+		*.dat filter=lfs -text
+		EOF
+		cat .gitattributes >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'Store files in LFS based on size (14 bytes) and extension (dat)' '
+	client_view "//depot/... //client/..." &&
+	git p4 clone \
+		--use-client-spec \
+		--use-lfs-if-size-exceeds=14 \
+		--use-lfs-for-extension=dat \
+		--destination="$git" //depot@all &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+
+		cat >expect <<-\EOF &&
+		.git/lfs/objects/d4/43/d443795c1aa3ff7e62afd89d6a86bb84ceba0305f6c22151aa8ee95077a39101
+		.git/lfs/objects/e5/fe/e5fec48503cd7b85eb9ffaea3311cde2fe9542078b9640369032b26bb5403fff
+		EOF
+		find ".git/lfs/objects" -type f >actual &&
+		test_cmp expect actual &&
+
+		cat >expect <<-\EOF &&
+		version https://git-lfs.github.com/spec/v1
+		oid sha256:d443795c1aa3ff7e62afd89d6a86bb84ceba0305f6c22151aa8ee95077a39101
+		size 13
+		EOF
+		cat file.dat >actual &&
+		test_cmp expect actual &&
+
+		cat >expect <<-\EOF &&
+		bin 13 bytes
+		EOF
+		cat file2.bin >actual &&
+		test_cmp expect actual &&
+
+		cat >expect <<-\EOF &&
+		version https://git-lfs.github.com/spec/v1
+		oid sha256:e5fec48503cd7b85eb9ffaea3311cde2fe9542078b9640369032b26bb5403fff
+		size 14
+		EOF
+		cat file3.bin >actual &&
+		test_cmp expect actual &&
+
+		cat >expect <<-\EOF &&
+		*.dat filter=lfs -text
+		file3.bin filter=lfs -text
+		EOF
+		cat .gitattributes >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'Remove file from repo and store files in LFS based on size (10 bytes)' '
+	client_view "//depot/... //client/..." &&
+	(
+		cd "$cli" &&
+		p4 delete file3.bin &&
+		p4 submit -d "Remove file"
+	) &&
+
+	git p4 clone --use-client-spec --use-lfs-if-size-exceeds=10 --destination="$git" //depot@all &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+
+		# Note that file3 remains here as it referenced in the history
+		cat >expect <<-\EOF &&
+		.git/lfs/objects/d4/43/d443795c1aa3ff7e62afd89d6a86bb84ceba0305f6c22151aa8ee95077a39101
+		.git/lfs/objects/e5/fe/e5fec48503cd7b85eb9ffaea3311cde2fe9542078b9640369032b26bb5403fff
+		EOF
+		find ".git/lfs/objects" -type f >actual &&
+		test_cmp expect actual &&
+
+		cat >expect <<-\EOF &&
+		version https://git-lfs.github.com/spec/v1
+		oid sha256:d443795c1aa3ff7e62afd89d6a86bb84ceba0305f6c22151aa8ee95077a39101
+		size 13
+		EOF
+		cat file.dat >actual &&
+		test_cmp expect actual &&
+
+		cat >expect <<-\EOF &&
+		version https://git-lfs.github.com/spec/v1
+		oid sha256:d443795c1aa3ff7e62afd89d6a86bb84ceba0305f6c22151aa8ee95077a39101
+		size 13
+		EOF
+		cat file2.bin >actual &&
+		test_cmp expect actual &&
+
+		cat >expect <<-\EOF &&
+		file.dat filter=lfs -text
+		file2.bin filter=lfs -text
+		EOF
+		cat .gitattributes >actual &&
+		test_cmp expect actual
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
1.9.5 (Apple Git-50.3)
