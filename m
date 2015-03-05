From: =?windows-1252?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v2] archive-zip: mark text files in archives
Date: Thu, 05 Mar 2015 20:06:02 +0100
Message-ID: <54F8A91A.2000003@web.de>
References: <12g5ss8uqwflv.dlg@nililand.de> <54F77573.80109@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Ulrike Fischer <luatex@nililand.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 05 20:06:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTb6K-0006Dw-P0
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 20:06:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756405AbbCETGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 14:06:24 -0500
Received: from mout.web.de ([212.227.17.11]:64705 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752525AbbCETGX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 14:06:23 -0500
Received: from [192.168.178.27] ([79.250.191.206]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MfHk6-1Y61q60LKk-00Ol6p; Thu, 05 Mar 2015 20:06:16
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <54F77573.80109@web.de>
X-Provags-ID: V03:K0:U4nGaZ/z4Jzm+b1np4yOBdV7gA/jCp5tk5RKXSoghKNmCJdjQKc
 SxGKuDUfT37Y2E+vKKxkGNQm0yTIuaj41bZM7ri0dfZd/zt9oZbD3Eb6ET2LZLwMeWdMhUW
 uljkDkjU7qnwdEKWeMsjGtIGZ5KpWPoGCTGNQYkGeYrxJfnEs3X8Jy56XEce3DEJp8nQbvb
 +dmFfzlK9GpERiSuUU7MA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264860>

Set the text flag for ZIP archive entries that look like text files so
that unzip -a can be used to perform end-of-line conversions.  Info-ZIP
zip does the same.

Detect binary files the same way as git diff and git grep do, namely by
checking for the attribute "diff" and its negation "-diff", and if none
is found by falling back to checking for the presence of NUL bytes in
the first few bytes of the file contents.

7-Zip, Windows' built-in ZIP functionality and Info-ZIP unzip without
the switch -a are not affected by the change and still extract text
files without doing any end-of-line conversions.

NB: The actual end-of-line style used in the archive entries doesn't
matter to unzip -a, as it converts any CR, CRLF and LF to the line end
characters appropriate for the platform it is running on.

Suggested-by: Ulrike Fischer <luatex@nililand.de>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 archive-zip.c          | 25 ++++++++++++++++++++++++-
 t/t5003-archive-zip.sh | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index 4bde019..0f9e87f 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -5,6 +5,8 @@
 #include "archive.h"
 #include "streaming.h"
 #include "utf8.h"
+#include "userdiff.h"
+#include "xdiff-interface.h"
 
 static int zip_date;
 static int zip_time;
@@ -189,6 +191,16 @@ static int has_only_ascii(const char *s)
 	}
 }
 
+static int entry_is_binary(const char *path, const void *buffer, size_t size)
+{
+	struct userdiff_driver *driver = userdiff_find_by_path(path);
+	if (!driver)
+		driver = userdiff_find_by_name("default");
+	if (driver->binary != -1)
+		return driver->binary;
+	return buffer_is_binary(buffer, size);
+}
+
 #define STREAM_BUFFER_SIZE (1024 * 16)
 
 static int write_zip_entry(struct archiver_args *args,
@@ -210,6 +222,8 @@ static int write_zip_entry(struct archiver_args *args,
 	struct git_istream *stream = NULL;
 	unsigned long flags = 0;
 	unsigned long size;
+	int is_binary = -1;
+	const char *path_without_prefix = path + args->baselen;
 
 	crc = crc32(0, NULL, 0);
 
@@ -256,6 +270,8 @@ static int write_zip_entry(struct archiver_args *args,
 				return error("cannot read %s",
 					     sha1_to_hex(sha1));
 			crc = crc32(crc, buffer, size);
+			is_binary = entry_is_binary(path_without_prefix,
+						    buffer, size);
 			out = buffer;
 		}
 		compressed_size = (method == 0) ? size : 0;
@@ -300,7 +316,6 @@ static int write_zip_entry(struct archiver_args *args,
 	copy_le16(dirent.extra_length, ZIP_EXTRA_MTIME_SIZE);
 	copy_le16(dirent.comment_length, 0);
 	copy_le16(dirent.disk, 0);
-	copy_le16(dirent.attr1, 0);
 	copy_le32(dirent.attr2, attr2);
 	copy_le32(dirent.offset, zip_offset);
 
@@ -328,6 +343,9 @@ static int write_zip_entry(struct archiver_args *args,
 			if (readlen <= 0)
 				break;
 			crc = crc32(crc, buf, readlen);
+			if (is_binary == -1)
+				is_binary = entry_is_binary(path_without_prefix,
+							    buf, readlen);
 			write_or_die(1, buf, readlen);
 		}
 		close_istream(stream);
@@ -361,6 +379,9 @@ static int write_zip_entry(struct archiver_args *args,
 			if (readlen <= 0)
 				break;
 			crc = crc32(crc, buf, readlen);
+			if (is_binary == -1)
+				is_binary = entry_is_binary(path_without_prefix,
+							    buf, readlen);
 
 			zstream.next_in = buf;
 			zstream.avail_in = readlen;
@@ -405,6 +426,8 @@ static int write_zip_entry(struct archiver_args *args,
 	free(deflated);
 	free(buffer);
 
+	copy_le16(dirent.attr1, !is_binary);
+
 	memcpy(zip_dir + zip_dir_offset, &dirent, ZIP_DIR_HEADER_SIZE);
 	zip_dir_offset += ZIP_DIR_HEADER_SIZE;
 	memcpy(zip_dir + zip_dir_offset, path, pathlen);
diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
index c929db5..14744b2 100755
--- a/t/t5003-archive-zip.sh
+++ b/t/t5003-archive-zip.sh
@@ -33,6 +33,37 @@ check_zip() {
 	test_expect_success UNZIP " validate file contents" "
 		diff -r a ${dir_with_prefix}a
 	"
+
+	dir=eol_$1
+	dir_with_prefix=$dir/$2
+	extracted=${dir_with_prefix}a
+	original=a
+
+	test_expect_success UNZIP " extract ZIP archive with EOL conversion" '
+		(mkdir $dir && cd $dir && "$GIT_UNZIP" -a ../$zipfile)
+	'
+
+	test_expect_success UNZIP " validate that text files are converted" "
+		test_cmp_bin $extracted/text.cr $extracted/text.crlf &&
+		test_cmp_bin $extracted/text.cr $extracted/text.lf
+	"
+
+	test_expect_success UNZIP " validate that binary files are unchanged" "
+		test_cmp_bin $original/binary.cr   $extracted/binary.cr &&
+		test_cmp_bin $original/binary.crlf $extracted/binary.crlf &&
+		test_cmp_bin $original/binary.lf   $extracted/binary.lf
+	"
+
+	test_expect_success UNZIP " validate that diff files are converted" "
+		test_cmp_bin $extracted/diff.cr $extracted/diff.crlf &&
+		test_cmp_bin $extracted/diff.cr $extracted/diff.lf
+	"
+
+	test_expect_success UNZIP " validate that -diff files are unchanged" "
+		test_cmp_bin $original/nodiff.cr   $extracted/nodiff.cr &&
+		test_cmp_bin $original/nodiff.crlf $extracted/nodiff.crlf &&
+		test_cmp_bin $original/nodiff.lf   $extracted/nodiff.lf
+	"
 }
 
 test_expect_success \
@@ -41,6 +72,18 @@ test_expect_success \
      echo simple textfile >a/a &&
      mkdir a/bin &&
      cp /bin/sh a/bin &&
+     printf "text\r"	>a/text.cr &&
+     printf "text\r\n"	>a/text.crlf &&
+     printf "text\n"	>a/text.lf &&
+     printf "text\r"	>a/nodiff.cr &&
+     printf "text\r\n"	>a/nodiff.crlf &&
+     printf "text\n"	>a/nodiff.lf &&
+     printf "\0\r"	>a/binary.cr &&
+     printf "\0\r\n"	>a/binary.crlf &&
+     printf "\0\n"	>a/binary.lf &&
+     printf "\0\r"	>a/diff.cr &&
+     printf "\0\r\n"	>a/diff.crlf &&
+     printf "\0\n"	>a/diff.lf &&
      printf "A\$Format:%s\$O" "$SUBSTFORMAT" >a/substfile1 &&
      printf "A not substituted O" >a/substfile2 &&
      (p=long_path_to_a_file && cd a &&
@@ -66,7 +109,9 @@ test_expect_success 'add files to repository' '
 	GIT_COMMITTER_DATE="2005-05-27 22:00" git commit -m initial
 '
 
-test_expect_success 'setup export-subst' '
+test_expect_success 'setup export-subst and diff attributes' '
+	echo "a/nodiff.* -diff" >>.git/info/attributes &&
+	echo "a/diff.* diff" >>.git/info/attributes &&
 	echo "substfile?" export-subst >>.git/info/attributes &&
 	git log --max-count=1 "--pretty=format:A${SUBSTFORMAT}O" HEAD \
 		>a/substfile1
-- 
2.3.1
