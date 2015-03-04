From: =?windows-1252?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] archive-zip: add --text parameter
Date: Wed, 04 Mar 2015 22:13:23 +0100
Message-ID: <54F77573.80109@web.de>
References: <12g5ss8uqwflv.dlg@nililand.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: luatex@nililand.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 04 22:33:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTGvM-0007Ks-Ud
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 22:33:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753072AbbCDVdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 16:33:42 -0500
Received: from mout-xforward.web.de ([82.165.159.35]:60715 "EHLO
	mout-xforward.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638AbbCDVdi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 16:33:38 -0500
X-Greylist: delayed 1203 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Mar 2015 16:33:37 EST
Received: from [192.168.178.27] ([79.250.186.137]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MNLFd-1YQmYv0Xlp-006tOE; Wed, 04 Mar 2015 22:13:32
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <12g5ss8uqwflv.dlg@nililand.de>
X-Provags-ID: V03:K0:10e9vbKDiG4YoJgXR9n5E1CxcY/IrPV3ChJa4qZTRoW7HG6lI3F
 l+RJQFz/lCm/s5DErE2eTCTuSufK4TaNgddu2V1/3pr0molLoS0dpfbA5myh2ZvzWRDPybs
 T9TWN1kfKmPP8oMfUHu1wdFzeIM6DOy2PFKhTDcyA5xdUSbtrJGdQaeptDOkGkeEd9uZQXr
 4f1iTlV8CD1gfXllOXjAw==
X-UI-Out-Filterresults: junk:10;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264787>

Entries in a ZIP file can be marked as text files.  Extractors can use
that flag to apply end-of-line conversions.  An example is unzip -a.

git archive currently marks all ZIP file entries as binary files.  This
patch adds the new option --text that can be used to mark non-binary
files or all files as text files, thus enabling the use of unzip -a.

No sign-off, yet, because I'm not sure we really need another option.
E.g. --text=all doesn't seem to be actually useful, but it was easy to
implement.  Info-ZIP's zip always creates archives like --text=auto
does, so perhaps we should make that our default behavior as well?

Changing the default behavior would cause newer versions of git archive
to create different ZIP files than older ones, of course.  This can
break caching and signature checking.

The last time we did that was in 2012 when we added an extended mtime
field (227bf5980), I think.  I don't remember any fallout from that
change, but there was a recent discussion about the stability of
generated tar files, so I'm a bit cautious:

    http://thread.gmane.org/gmane.comp.version-control.git/258516

---
 Documentation/git-archive.txt |  5 ++++
 archive-zip.c                 | 23 ++++++++++++++----
 archive.c                     | 18 ++++++++++++++
 archive.h                     |  7 ++++++
 t/t5003-archive-zip.sh        | 56 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 105 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index cfa1e4e..684ca36 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -93,6 +93,11 @@ zip
 	Highest and slowest compression level.  You can specify any
 	number from 1 to 9 to adjust compression speed and ratio.
 
+--text=<which>::
+	Mark the specfied entries as text files so that `unzip -a`
+	converts end-of-line characters while extracting. The value
+	must be either 'all', 'auto', or 'none' (the default).
+
 
 CONFIGURATION
 -------------
diff --git a/archive-zip.c b/archive-zip.c
index 4bde019..3767940 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -5,6 +5,7 @@
 #include "archive.h"
 #include "streaming.h"
 #include "utf8.h"
+#include "xdiff-interface.h"
 
 static int zip_date;
 static int zip_time;
@@ -210,6 +211,7 @@ static int write_zip_entry(struct archiver_args *args,
 	struct git_istream *stream = NULL;
 	unsigned long flags = 0;
 	unsigned long size;
+	int is_binary = -1;
 
 	crc = crc32(0, NULL, 0);
 
@@ -238,8 +240,14 @@ static int write_zip_entry(struct archiver_args *args,
 		method = 0;
 		attr2 = S_ISLNK(mode) ? ((mode | 0777) << 16) :
 			(mode & 0111) ? ((mode) << 16) : 0;
-		if (S_ISREG(mode) && args->compression_level != 0 && size > 0)
-			method = 8;
+		if (S_ISREG(mode)) {
+			if (args->compression_level != 0 && size > 0)
+				method = 8;
+			if (args->text == ARCHIVE_TEXT_ALL)
+				is_binary = 0;
+			else if (args->text == ARCHIVE_TEXT_NONE)
+				is_binary = 1;
+		}
 
 		if (S_ISREG(mode) && type == OBJ_BLOB && !args->convert &&
 		    size > big_file_threshold) {
@@ -256,6 +264,8 @@ static int write_zip_entry(struct archiver_args *args,
 				return error("cannot read %s",
 					     sha1_to_hex(sha1));
 			crc = crc32(crc, buffer, size);
+			if (is_binary < 0)
+				is_binary = buffer_is_binary(buffer, size);
 			out = buffer;
 		}
 		compressed_size = (method == 0) ? size : 0;
@@ -300,7 +310,6 @@ static int write_zip_entry(struct archiver_args *args,
 	copy_le16(dirent.extra_length, ZIP_EXTRA_MTIME_SIZE);
 	copy_le16(dirent.comment_length, 0);
 	copy_le16(dirent.disk, 0);
-	copy_le16(dirent.attr1, 0);
 	copy_le32(dirent.attr2, attr2);
 	copy_le32(dirent.offset, zip_offset);
 
@@ -328,6 +337,8 @@ static int write_zip_entry(struct archiver_args *args,
 			if (readlen <= 0)
 				break;
 			crc = crc32(crc, buf, readlen);
+			if (is_binary < 0)
+				is_binary = buffer_is_binary(buffer, size);
 			write_or_die(1, buf, readlen);
 		}
 		close_istream(stream);
@@ -361,6 +372,8 @@ static int write_zip_entry(struct archiver_args *args,
 			if (readlen <= 0)
 				break;
 			crc = crc32(crc, buf, readlen);
+			if (is_binary < 0)
+				is_binary = buffer_is_binary(buffer, size);
 
 			zstream.next_in = buf;
 			zstream.avail_in = readlen;
@@ -405,6 +418,8 @@ static int write_zip_entry(struct archiver_args *args,
 	free(deflated);
 	free(buffer);
 
+	copy_le16(dirent.attr1, !is_binary);
+
 	memcpy(zip_dir + zip_dir_offset, &dirent, ZIP_DIR_HEADER_SIZE);
 	zip_dir_offset += ZIP_DIR_HEADER_SIZE;
 	memcpy(zip_dir + zip_dir_offset, path, pathlen);
@@ -466,7 +481,7 @@ static int write_zip_archive(const struct archiver *ar,
 static struct archiver zip_archiver = {
 	"zip",
 	write_zip_archive,
-	ARCHIVER_WANT_COMPRESSION_LEVELS|ARCHIVER_REMOTE
+	ARCHIVER_WANT_COMPRESSION_LEVELS|ARCHIVER_REMOTE|ARCHIVER_TEXT_ATTRIBUTE
 };
 
 void init_zip_archiver(void)
diff --git a/archive.c b/archive.c
index 96057ed..89bd23d 100644
--- a/archive.c
+++ b/archive.c
@@ -417,6 +417,7 @@ static int parse_archive_args(int argc, const char **argv,
 	const char *remote = NULL;
 	const char *exec = NULL;
 	const char *output = NULL;
+	const char *text = NULL;
 	int compression_level = -1;
 	int verbose = 0;
 	int i;
@@ -442,6 +443,8 @@ static int parse_archive_args(int argc, const char **argv,
 		OPT__COMPR_HIDDEN('7', &compression_level, 7),
 		OPT__COMPR_HIDDEN('8', &compression_level, 8),
 		OPT__COMPR('9', &compression_level, N_("compress better"), 9),
+		OPT_STRING(0, "text", &text, N_("which"),
+			N_("specify which files contain text")),
 		OPT_GROUP(""),
 		OPT_BOOL('l', "list", &list,
 			N_("list supported archive formats")),
@@ -493,6 +496,21 @@ static int parse_archive_args(int argc, const char **argv,
 					format, compression_level);
 		}
 	}
+	args->text = ARCHIVE_TEXT_NONE;
+	if (text) {
+		if (!strcmp(text, "auto"))
+			args->text = ARCHIVE_TEXT_AUTO;
+		else if (!strcmp(text, "all"))
+			args->text = ARCHIVE_TEXT_ALL;
+		else if (!strcmp(text, "none"))
+			args->text = ARCHIVE_TEXT_NONE;
+		else
+			die("Unknown argument: --text=%s", text);
+		if (args->text != ARCHIVE_TEXT_NONE &&
+		    !((*ar)->flags & ARCHIVER_TEXT_ATTRIBUTE))
+			die("Argument not supported for format '%s': --text=%s",
+			    format, text);
+	}
 	args->verbose = verbose;
 	args->base = base;
 	args->baselen = strlen(base);
diff --git a/archive.h b/archive.h
index 4a791e1..eabcd11 100644
--- a/archive.h
+++ b/archive.h
@@ -14,11 +14,18 @@ struct archiver_args {
 	unsigned int verbose : 1;
 	unsigned int worktree_attributes : 1;
 	unsigned int convert : 1;
+	unsigned int text : 2;
 	int compression_level;
 };
 
 #define ARCHIVER_WANT_COMPRESSION_LEVELS 1
 #define ARCHIVER_REMOTE 2
+#define ARCHIVER_TEXT_ATTRIBUTE 4
+
+#define ARCHIVE_TEXT_NONE	0
+#define ARCHIVE_TEXT_ALL	1
+#define ARCHIVE_TEXT_AUTO	2
+
 struct archiver {
 	const char *name;
 	int (*write_archive)(const struct archiver *, struct archiver_args *);
diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
index c929db5..4e49aad 100755
--- a/t/t5003-archive-zip.sh
+++ b/t/t5003-archive-zip.sh
@@ -35,12 +35,56 @@ check_zip() {
 	"
 }
 
+zip_text() {
+	option=$1
+	zipfile=text_$1.zip
+	dir=text_$1
+
+	test_expect_success "git archive --format-zip --text=$option" "
+		git archive --format=zip --text=$option HEAD >$zipfile
+	"
+
+	test_expect_success UNZIP " extract ZIP archive with EOL conversion" '
+		(mkdir $dir && cd $dir && "$GIT_UNZIP" -a ../$zipfile)
+	'
+}
+
+check_text_converted() {
+	dir=text_$1
+	filetype=$2
+	extracted=$dir/a/$filetype
+
+	test_expect_success " validate that $filetype files are converted" "
+		test_cmp_bin $extracted.cr $extracted.crlf &&
+		test_cmp_bin $extracted.cr $extracted.lf
+	"
+}
+
+check_text_verbatim() {
+	dir=text_$1
+	filetype=$2
+	extracted=$dir/a/$filetype
+	original=a/$filetype
+
+	test_expect_success " validate that $filetype files are unchanged" "
+		test_cmp_bin $original.cr   $extracted.cr &&
+		test_cmp_bin $original.crlf $extracted.crlf &&
+		test_cmp_bin $original.lf   $extracted.lf
+	"
+}
+
 test_expect_success \
     'populate workdir' \
     'mkdir a &&
      echo simple textfile >a/a &&
      mkdir a/bin &&
      cp /bin/sh a/bin &&
+     printf "text\r"   >a/text.cr &&
+     printf "text\r\n" >a/text.crlf &&
+     printf "text\n"   >a/text.lf &&
+     printf "\0\r"   >a/binary.cr &&
+     printf "\0\r\n" >a/binary.crlf &&
+     printf "\0\n"   >a/binary.lf &&
      printf "A\$Format:%s\$O" "$SUBSTFORMAT" >a/substfile1 &&
      printf "A not substituted O" >a/substfile2 &&
      (p=long_path_to_a_file && cd a &&
@@ -124,4 +168,16 @@ test_expect_success 'git archive --format=zip on large files' '
 
 check_zip large-compressed
 
+zip_text all
+check_text_converted all text
+check_text_converted all binary
+
+zip_text auto
+check_text_converted auto text
+check_text_verbatim auto binary
+
+zip_text none
+check_text_verbatim none text
+check_text_verbatim none binary
+
 test_done
-- 
2.3.1
