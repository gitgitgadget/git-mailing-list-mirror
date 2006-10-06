From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/2] git-archive --format=zip: add symlink support
Date: Sat, 07 Oct 2006 01:47:35 +0200
Message-ID: <4526EB17.1010309@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Franck Bui-Huu <vagabon.xyz@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 07 01:47:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVzPY-00010t-3M
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 01:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932666AbWJFXrU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 19:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWJFXrU
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 19:47:20 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:33976
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1750705AbWJFXrT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Oct 2006 19:47:19 -0400
Received: from [10.0.1.3] (p508E6834.dip.t-dialin.net [80.142.104.52])
	by neapel230.server4you.de (Postfix) with ESMTP id 61AB11002D;
	Sat,  7 Oct 2006 01:47:18 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
To: Junio C Hamano <junkio@cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28449>

Add symlink support to ZIP file creation, and a few tests.

This implementation sets the "version made by" field
(creator_version) to Unix for symlinks, only; regular files and
directories are still marked as originating from FAT/VFAT/NTFS.

Also set "external file attributes" (attr2) to 0 for regular
files and 16 for directories (FAT attribute), and to the file
mode for symlinks.

We could always set the creator_version to Unix and include the
mode, but then Info-ZIP unzip would set the mode of the extracted
files to *exactly* the value stored in attr2.  The FAT trick
makes it apply the umask instead.  Note: FAT has no executable
bit, so this information is not stored in the ZIP file.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---

I tested this change only using Info-ZIP unzip 5.52 on Linux.  I
wonder what PKZIP or WinZIP would do with symlink entries.

All calls of git-tar-tree in the test script should be converted
to git-archive --format=tar, then the script can be renamed to
t5000-archive.sh.  Later.

 archive-zip.c       |   13 +++++++++----
 t/t5000-tar-tree.sh |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index ae74623..d8317f8 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -145,6 +145,7 @@ static int write_zip_entry(const unsigne
 {
 	struct zip_local_header header;
 	struct zip_dir_header dirent;
+	unsigned long attr2;
 	unsigned long compressed_size;
 	unsigned long uncompressed_size;
 	unsigned long crc;
@@ -172,12 +173,16 @@ static int write_zip_entry(const unsigne
 
 	if (S_ISDIR(mode)) {
 		method = 0;
+		attr2 = 16;
 		result = READ_TREE_RECURSIVE;
 		out = NULL;
 		uncompressed_size = 0;
 		compressed_size = 0;
-	} else if (S_ISREG(mode)) {
-		method = zlib_compression_level == 0 ? 0 : 8;
+	} else if (S_ISREG(mode) || S_ISLNK(mode)) {
+		method = 0;
+		attr2 = S_ISLNK(mode) ? ((mode | 0777) << 16) : 0;
+		if (S_ISREG(mode) && zlib_compression_level != 0)
+			method = 8;
 		result = 0;
 		buffer = read_sha1_file(sha1, type, &size);
 		if (!buffer)
@@ -213,7 +218,7 @@ static int write_zip_entry(const unsigne
 	}
 
 	copy_le32(dirent.magic, 0x02014b50);
-	copy_le16(dirent.creator_version, 0);
+	copy_le16(dirent.creator_version, S_ISLNK(mode) ? 0x0317 : 0);
 	copy_le16(dirent.version, 10);
 	copy_le16(dirent.flags, 0);
 	copy_le16(dirent.compression_method, method);
@@ -227,7 +232,7 @@ static int write_zip_entry(const unsigne
 	copy_le16(dirent.comment_length, 0);
 	copy_le16(dirent.disk, 0);
 	copy_le16(dirent.attr1, 0);
-	copy_le32(dirent.attr2, 0);
+	copy_le32(dirent.attr2, attr2);
 	copy_le32(dirent.offset, zip_offset);
 	memcpy(zip_dir + zip_dir_offset, &dirent, sizeof(struct zip_dir_header));
 	zip_dir_offset += sizeof(struct zip_dir_header);
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 278eb66..cf08e92 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -26,6 +26,7 @@ commit id embedding:
 
 . ./test-lib.sh
 TAR=${TAR:-tar}
+UNZIP=${UNZIP:-unzip}
 
 test_expect_success \
     'populate workdir' \
@@ -95,4 +96,38 @@ test_expect_success \
     'validate file contents with prefix' \
     'diff -r a c/prefix/a'
 
+test_expect_success \
+    'git-archive --format=zip' \
+    'git-archive --format=zip HEAD >d.zip'
+
+test_expect_success \
+    'extract ZIP archive' \
+    '(mkdir d && cd d && $UNZIP ../d.zip)'
+
+test_expect_success \
+    'validate filenames' \
+    '(cd d/a && find .) | sort >d.lst &&
+     diff a.lst d.lst'
+
+test_expect_success \
+    'validate file contents' \
+    'diff -r a d/a'
+
+test_expect_success \
+    'git-archive --format=zip with prefix' \
+    'git-archive --format=zip --prefix=prefix/ HEAD >e.zip'
+
+test_expect_success \
+    'extract ZIP archive with prefix' \
+    '(mkdir e && cd e && $UNZIP ../e.zip)'
+
+test_expect_success \
+    'validate filenames with prefix' \
+    '(cd e/prefix/a && find .) | sort >e.lst &&
+     diff a.lst e.lst'
+
+test_expect_success \
+    'validate file contents with prefix' \
+    'diff -r a e/prefix/a'
+
 test_done
-- 
1.4.2.3.gf59615
