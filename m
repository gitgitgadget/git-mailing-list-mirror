From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v3 2/2] diff: generate prettier filenames when using GIT_EXTERNAL_DIFF
Date: Thu, 28 May 2009 02:43:51 -0700
Message-ID: <1243503831-17993-2-git-send-email-davvid@gmail.com>
References: <1243503831-17993-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, j.sixt@viscovery.net,
	markus.heidelberg@web.de, jnareb@gmail.com,
	David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu May 28 11:44:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9cA0-0004El-Dt
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 11:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753626AbZE1JoO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 05:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbZE1JoM
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 05:44:12 -0400
Received: from mail-pz0-f177.google.com ([209.85.222.177]:39339 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934AbZE1JoK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 05:44:10 -0400
Received: by pzk7 with SMTP id 7so4126598pzk.33
        for <git@vger.kernel.org>; Thu, 28 May 2009 02:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=eqVTTtfqv2uhIFhYPWfLNVNw7BGuLcAiWd+lzyaftpk=;
        b=nlroKjSai2Ykf2myLopEK0gmI2llZBnLPpqL60PGjUsV2B31mMFexGV4zP0xek6BF/
         SkmdDyz/Ky2QdMylMzEUhNv8SNpIiAshzPeL4WoCHBBQ0GwwQ5zZUAHZ9MLO8ZrDmwz6
         EfDoWjVd9/JuuQ+IqXHMPceMk6DWhScx9PBlE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tjIcpWVbf42jfYSwdPyVbY6TcfZv7cFcQe3tISPKupp3yXg94tLnhZy1S5sqK+xcwg
         3ZY9/GrMWpOOI2qoMoV/FRCy/Hse7XYwIGXFQnY1puIEvTMKlVYSqwJ9KVutkUziVUID
         JfhNi1PWud0gFPvd/AOvZT85IXKVPMuj9BnxM=
Received: by 10.115.18.3 with SMTP id v3mr995681wai.32.1243503851616;
        Thu, 28 May 2009 02:44:11 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id m30sm12910949wag.53.2009.05.28.02.44.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 May 2009 02:44:10 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.169.g33fd
In-Reply-To: <1243503831-17993-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120180>

Naturally, prep_temp_blob() did not care about filenames.
As a result, scripts that use GIT_EXTERNAL_DIFF ended up
with filenames such as ".diff_XXXXXX".

This specializes the GIT_EXTERNAL_DIFF code to generate
user-friendly filenames when creating temporary files.

Diffing "name.ext" now generates "XXXXXX_name.ext".

Signed-off-by: David Aguilar <davvid@gmail.com>
Tested-by: Johannes Sixt <j6t@kdbg.org> (Windows)
---
 cache.h                  |    2 ++
 diff.c                   |   45 +++++++++++++++++++++++++++++++++++++--------
 path.c                   |   19 +++++++++++++++++++
 t/t4020-diff-external.sh |    9 +++++++++
 4 files changed, 67 insertions(+), 8 deletions(-)

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
index dcfbcb0..60f07a0 100644
--- a/diff.c
+++ b/diff.c
@@ -1960,12 +1960,37 @@ static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
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
+		char *basename = ((char*)path) + strlen(path) - 1;
+
+		/* Windows lacks basename() */
+		while(*basename && basename > path) {
+			basename--;
+			if (is_dir_sep(*basename)) {
+				basename++;
+				break;
+			}
+		}
+
+		strbuf_addstr(&pretty_name, "XXXXXX_");
+		strbuf_addstr(&pretty_name, basename);
+
+		fd = git_mkstemps(temp->tmp_path, PATH_MAX,
+			pretty_name.buf, strlen(basename) + 1);
+
+		strbuf_release(&pretty_name);
+	}
+	else {
+		fd = git_mkstemp(temp->tmp_path, PATH_MAX, ".diff_XXXXXX");
+	}
 	if (fd < 0)
 		die("unable to create temp-file: %s", strerror(errno));
 	if (convert_to_working_tree(path,
@@ -1984,7 +2009,8 @@ static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
 }
 
 static struct diff_tempfile *prepare_temp_file(const char *name,
-		struct diff_filespec *one)
+		struct diff_filespec *one,
+		int pretty_filename)
 {
 	struct diff_tempfile *temp = claim_diff_tempfile();
 
@@ -2021,7 +2047,8 @@ static struct diff_tempfile *prepare_temp_file(const char *name,
 				       (one->sha1_valid ?
 					one->sha1 : null_sha1),
 				       (one->sha1_valid ?
-					one->mode : S_IFLNK));
+					one->mode : S_IFLNK),
+				       pretty_filename);
 			strbuf_release(&sb);
 		}
 		else {
@@ -2045,7 +2072,7 @@ static struct diff_tempfile *prepare_temp_file(const char *name,
 		if (diff_populate_filespec(one, 0))
 			die("cannot read data blob for %s", one->path);
 		prep_temp_blob(name, temp, one->data, one->size,
-			       one->sha1, one->mode);
+			       one->sha1, one->mode, pretty_filename);
 	}
 	return temp;
 }
@@ -2071,8 +2098,9 @@ static void run_external_diff(const char *pgm,
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
@@ -3574,8 +3602,9 @@ static char *run_textconv(const char *pgm, struct diff_filespec *spec,
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
index 0720001..4ea42e0 100755
--- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -136,6 +136,15 @@ test_expect_success 'GIT_EXTERNAL_DIFF with more than one changed files' '
 	GIT_EXTERNAL_DIFF=echo git diff
 '
 
+test_expect_success 'GIT_EXTERNAL_DIFF generates pretty paths' '
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
