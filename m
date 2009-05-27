From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 2/2] diff: generate prettier filenames when using GIT_EXTERNAL_DIFF
Date: Tue, 26 May 2009 20:19:24 -0700
Message-ID: <1243394364-13772-2-git-send-email-davvid@gmail.com>
References: <1243394364-13772-1-git-send-email-davvid@gmail.com>
Cc: gitster@pobox.com, johannes.schindelin@gmx.de,
	markus.heidelberg@web.de, nick@incise.org,
	David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 27 05:19:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M99g6-0006KG-Kh
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 05:19:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756341AbZE0DTg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2009 23:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756051AbZE0DTg
	(ORCPT <rfc822;git-outgoing>); Tue, 26 May 2009 23:19:36 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:10663 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756087AbZE0DTd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2009 23:19:33 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1368059rvb.1
        for <git@vger.kernel.org>; Tue, 26 May 2009 20:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=eKqqrceWGvhXGlAqs5L4GUgXLbDXY4EPUCDDpfTqFgY=;
        b=Gkf20hjrtoTdcZeLM2YSbhDVB1bBAOyy9JIsX4tdh0X/XT2qRujiG8ID70tBCFtk+T
         B7mdXx9ZUWCcLlsZ8ulBaQ8igwoIMydkdlG8nBCl49WZx7aYnJzmyb9b0Z41+JGkdZFs
         rurfoGhwRTCEUJLZwnt+QQzMypQeerJzlAMss=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=XaoOkJuz0f0qyI4UJR5rrbMnXvb06uIDpXFINCZ0UzpBnWfx+Z5kL4yDTxSj7kmmt0
         /uNsDLjjpfNJJ/gg8PrV6FZdkLvFGm+RPF2v3uUMGiW45JbY2aRdDHySnQFEoeLvI+Sd
         ulFoqVIQLehEDJPKItT4JCHtB6ctz06532xsU=
Received: by 10.141.75.12 with SMTP id c12mr3542524rvl.276.1243394375645;
        Tue, 26 May 2009 20:19:35 -0700 (PDT)
Received: from localhost (wdas-1.disneyanimation.com [12.188.26.1])
        by mx.google.com with ESMTPS id b39sm1729671rvf.1.2009.05.26.20.19.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 May 2009 20:19:35 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.169.g33fd
In-Reply-To: <1243394364-13772-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120022>

Naturally, prep_temp_blob() did not care about filenames.
As a result, scripts that use GIT_EXTERNAL_DIFF ended up
with filenames such as ".diff_XXXXXX".

This specializes the GIT_EXTERNAL_DIFF code to generate
user-friendly filenames when creating temporary files.

Diffing "name.ext" now generates "XXXXXX_name.ext".

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 cache.h                  |    2 ++
 diff.c                   |   40 ++++++++++++++++++++++++++++++++--------
 path.c                   |   19 +++++++++++++++++++
 t/t4020-diff-external.sh |   18 ++++++++++++++++++
 4 files changed, 71 insertions(+), 8 deletions(-)

diff --git a/cache.h b/cache.h
index b8503ad..871c984 100644
--- a/cache.h
+++ b/cache.h
@@ -614,6 +614,8 @@ extern int is_empty_blob_sha1(const unsigned char *sha1);
 
 int git_mkstemp(char *path, size_t n, const char *template);
 
+int git_mkstemps(char *path, size_t n, const char *template, int suffix_len);
+
 /*
  * NOTE NOTE NOTE!!
  *
diff --git a/diff.c b/diff.c
index dcfbcb0..23c52f5 100644
--- a/diff.c
+++ b/diff.c
@@ -13,6 +13,7 @@
 #include "utf8.h"
 #include "userdiff.h"
 #include "sigchain.h"
+#include <libgen.h>
 
 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
@@ -1960,12 +1961,31 @@ static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
 			   void *blob,
 			   unsigned long size,
 			   const unsigned char *sha1,
-			   int mode)
+			   int mode,
+			   int pretty_filename)
 {
 	int fd;
 	struct strbuf buf = STRBUF_INIT;
 
-	fd = git_mkstemp(temp->tmp_path, PATH_MAX, ".diff_XXXXXX");
+	if (pretty_filename) {
+		/* Generate "XXXXXX_filename" */
+		struct strbuf pretty_name = STRBUF_INIT;
+		char *pathdup = xstrdup(path);
+		char *base = basename(pathdup);
+		int suffix_len = strlen(base) + 1;
+
+		strbuf_addstr(&pretty_name, "XXXXXX_");
+		strbuf_addstr(&pretty_name, base);
+
+		fd = git_mkstemps(temp->tmp_path, PATH_MAX,
+			pretty_name.buf, suffix_len);
+
+		free(pathdup);
+		strbuf_release(&pretty_name);
+	}
+	else {
+		fd = git_mkstemp(temp->tmp_path, PATH_MAX, ".diff_XXXXXX");
+	}
 	if (fd < 0)
 		die("unable to create temp-file: %s", strerror(errno));
 	if (convert_to_working_tree(path,
@@ -1984,7 +2004,8 @@ static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
 }
 
 static struct diff_tempfile *prepare_temp_file(const char *name,
-		struct diff_filespec *one)
+		struct diff_filespec *one,
+		int pretty_filename)
 {
 	struct diff_tempfile *temp = claim_diff_tempfile();
 
@@ -2021,7 +2042,8 @@ static struct diff_tempfile *prepare_temp_file(const char *name,
 				       (one->sha1_valid ?
 					one->sha1 : null_sha1),
 				       (one->sha1_valid ?
-					one->mode : S_IFLNK));
+					one->mode : S_IFLNK),
+				       pretty_filename);
 			strbuf_release(&sb);
 		}
 		else {
@@ -2045,7 +2067,7 @@ static struct diff_tempfile *prepare_temp_file(const char *name,
 		if (diff_populate_filespec(one, 0))
 			die("cannot read data blob for %s", one->path);
 		prep_temp_blob(name, temp, one->data, one->size,
-			       one->sha1, one->mode);
+			       one->sha1, one->mode, pretty_filename);
 	}
 	return temp;
 }
@@ -2071,8 +2093,9 @@ static void run_external_diff(const char *pgm,
 	if (one && two) {
 		struct diff_tempfile *temp_one, *temp_two;
 		const char *othername = (other ? other : name);
-		temp_one = prepare_temp_file(name, one);
-		temp_two = prepare_temp_file(othername, two);
+		int pretty_filename = 1;
+		temp_one = prepare_temp_file(name, one, pretty_filename);
+		temp_two = prepare_temp_file(othername, two, pretty_filename);
 		*arg++ = pgm;
 		*arg++ = name;
 		*arg++ = temp_one->name;
@@ -3574,8 +3597,9 @@ static char *run_textconv(const char *pgm, struct diff_filespec *spec,
 	const char **arg = argv;
 	struct child_process child;
 	struct strbuf buf = STRBUF_INIT;
+	int pretty_filename = 0;
 
-	temp = prepare_temp_file(spec->path, spec);
+	temp = prepare_temp_file(spec->path, spec, pretty_filename);
 	*arg++ = pgm;
 	*arg++ = temp->name;
 	*arg = NULL;
diff --git a/path.c b/path.c
index 8a0a674..090b490 100644
--- a/path.c
+++ b/path.c
@@ -140,6 +140,25 @@ int git_mkstemp(char *path, size_t len, const char *template)
 }
 
 
+
+/* git_mkstemps() - create tmp file with suffix honoring TMPDIR variable. */
+int git_mkstemps(char *path, size_t len, const char *template, int suffix_len)
+{
+	const char *tmp;
+	size_t n;
+
+	tmp = getenv("TMPDIR");
+	if (!tmp)
+		tmp = "/tmp";
+	n = snprintf(path, len, "%s/%s", tmp, template);
+	if (len <= n) {
+		errno = ENAMETOOLONG;
+		return -1;
+	}
+	return mkstemps(path, suffix_len);
+}
+
+
 int validate_headref(const char *path)
 {
 	struct stat st;
diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index 0720001..602d932 100755
--- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -136,6 +136,24 @@ test_expect_success 'GIT_EXTERNAL_DIFF with more than one changed files' '
 	GIT_EXTERNAL_DIFF=echo git diff
 '
 
+test_expect_success 'GIT_EXTERNAL_DIFF generates pretty paths with no ext' '
+	touch filenoext &&
+	git add filenoext &&
+	echo no extension > filenoext &&
+	GIT_EXTERNAL_DIFF=echo git diff filenoext | grep _filenoext &&
+	git update-index --force-remove filenoext &&
+	rm filenoext
+'
+
+test_expect_success 'GIT_EXTERNAL_DIFF generates pretty paths with ext' '
+	touch file.ext &&
+	git add file.ext &&
+	echo with extension > file.ext &&
+	GIT_EXTERNAL_DIFF=echo git diff file.ext | grep ......_file\.ext &&
+	git update-index --force-remove file.ext &&
+	rm file.ext
+'
+
 echo "#!$SHELL_PATH" >fake-diff.sh
 cat >> fake-diff.sh <<\EOF
 cat $2 >> crlfed.txt
-- 
1.6.3.1.169.g33fd
