From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2] diff: generate prettier filenames when using GIT_EXTERNAL_DIFF
Date: Mon, 25 May 2009 19:27:11 -0700
Message-ID: <1243304831-94426-1-git-send-email-davvid@gmail.com>
Cc: gitster@pobox.com, johannes.schindelin@gmx.de,
	markus.heidelberg@web.de, nick@incise.org,
	David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 26 04:28:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8mP3-0001rh-Eb
	for gcvg-git-2@gmane.org; Tue, 26 May 2009 04:28:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158AbZEZC2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 22:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751759AbZEZC2U
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 22:28:20 -0400
Received: from mail-pz0-f109.google.com ([209.85.222.109]:59716 "EHLO
	mail-pz0-f109.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbZEZC2T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 22:28:19 -0400
Received: by pzk7 with SMTP id 7so2749032pzk.33
        for <git@vger.kernel.org>; Mon, 25 May 2009 19:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=0LPieDI6u1alWbY/XtnTqT/NTnNcmrFxdHucVHtoVLI=;
        b=s78G+oafpEXTIB017xRaatFyTwrVK2rcvPs1etaDxUZj3hqHXqA4uF+u1WxFo3fnC7
         T/3k5HuwJwL7zo036kdgpHiSzz9ffX3z35LEt3uc+HItSPnCn187nGovRnDbal23yutd
         tbSLEilLwsGlm0hxdtKoEax8Owk4PTB3ouIV0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Dh7+ymm8181C6ICuhbPmjAw8A6GSpiB+qqfVBjxEZw6LflVeScmOPvvbwMyf/h1gH7
         dplh6tBiEBSWi62QVLBySYwHzjGRVmxQ0aFtX64lIoaMoX6HGMDmaM0HnUADY4dW+d0n
         m+cV08FINWyF6PH81ZZLZmEVAQqyHXrcwPvnE=
Received: by 10.142.194.1 with SMTP id r1mr2675470wff.138.1243304899564;
        Mon, 25 May 2009 19:28:19 -0700 (PDT)
Received: from localhost (cpe-76-174-56-199.socal.res.rr.com [76.174.56.199])
        by mx.google.com with ESMTPS id 29sm3939079wfg.28.2009.05.25.19.28.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 May 2009 19:28:19 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.153.g6540
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119992>

Naturally, prep_temp_blob() did not care about filenames.
As a result, scripts that use GIT_EXTERNAL_DIFF ended up
with filenames such as ".diff_XXXXXX".

This specializes the GIT_EXTERNAL_DIFF code to generate
prettier filenames.

Diffing "name.ext" now generates "name.XXXX.ext".
Diffing files with no extension now generates "name_XXXX".

Signed-off-by: David Aguilar <davvid@gmail.com>
---

This includes a mkstemps implementation for cross-platform use.
The git_mkstemps() function was adapted from libguile's GPLv2
mkstemp.c.

The original patch depended on the non-portable mkstemps()
BSD extension =(

 cache.h                  |    2 +
 diff.c                   |   55 ++++++++++++++++++++++++++++++++-----
 path.c                   |   67 ++++++++++++++++++++++++++++++++++++++++++++++
 t/t4020-diff-external.sh |   18 ++++++++++++
 4 files changed, 134 insertions(+), 8 deletions(-)

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
index f06876b..226771d 100644
--- a/diff.c
+++ b/diff.c
@@ -1960,12 +1960,47 @@ static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
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
+		struct strbuf pretty_name = STRBUF_INIT;
+		char *pathdup = xstrdup(path);
+		char *base = basename(pathdup);
+		char *dot = strchr(base, '.');
+		int suffix_len = 0;
+
+		if (dot) {
+			/* path has an extension, e.g. "foo.txt";
+			 * generate "foo.XXXX.txt".
+			 */
+			*dot = '\0';
+			strbuf_addstr(&pretty_name, base);
+			*dot = '.';
+			strbuf_addstr(&pretty_name, ".XXXXXX");
+			suffix_len = strlen(dot);
+			strbuf_addstr(&pretty_name, dot);
+		}
+		else {
+			/* path has no extension, e.g. "Makefile";
+			 * generate "Makefile_XXXX".
+			 */
+			strbuf_addstr(&pretty_name, base);
+			strbuf_addstr(&pretty_name, "_XXXXXX");
+		}
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
@@ -1984,7 +2019,8 @@ static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
 }
 
 static struct diff_tempfile *prepare_temp_file(const char *name,
-		struct diff_filespec *one)
+		struct diff_filespec *one,
+		int pretty_filename)
 {
 	struct diff_tempfile *temp = claim_diff_tempfile();
 
@@ -2025,7 +2061,8 @@ static struct diff_tempfile *prepare_temp_file(const char *name,
 				       (one->sha1_valid ?
 					one->sha1 : null_sha1),
 				       (one->sha1_valid ?
-					one->mode : S_IFLNK));
+					one->mode : S_IFLNK),
+				       pretty_filename);
 		}
 		else {
 			/* we can borrow from the file in the work tree */
@@ -2048,7 +2085,7 @@ static struct diff_tempfile *prepare_temp_file(const char *name,
 		if (diff_populate_filespec(one, 0))
 			die("cannot read data blob for %s", one->path);
 		prep_temp_blob(name, temp, one->data, one->size,
-			       one->sha1, one->mode);
+			       one->sha1, one->mode, pretty_filename);
 	}
 	return temp;
 }
@@ -2074,8 +2111,9 @@ static void run_external_diff(const char *pgm,
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
@@ -3577,8 +3615,9 @@ static char *run_textconv(const char *pgm, struct diff_filespec *spec,
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
index 8a0a674..3022caf 100644
--- a/path.c
+++ b/path.c
@@ -12,6 +12,8 @@
  */
 #include "cache.h"
 
+#define GIT_MKSTEMPS_MAX 16384
+
 static char bad_path[] = "/bad-path/";
 
 static char *get_pathname(void)
@@ -140,6 +142,71 @@ int git_mkstemp(char *path, size_t len, const char *template)
 }
 
 
+
+/* git_mkstemps() - create tmp file with suffix honoring TMPDIR variable.
+ * This is adapted from libguile's GPLv2 mkstemp.c.
+ */
+int git_mkstemps(char *path, size_t len, const char *template, int suffix_len)
+{
+	static const char letters[] =
+		"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
+		"0123456789_";
+	const char *tmp;
+	size_t i, n;
+	size_t path_len, letters_len;
+	struct timeval tv;
+	uint64_t value, v;
+	int fd, count;
+
+	tmp = getenv("TMPDIR");
+	if (!tmp)
+		tmp = "/tmp";
+	n = snprintf(path, len, "%s/%s", tmp, template);
+	if (len <= n) {
+		errno = ENAMETOOLONG;
+		return -1;
+	}
+
+	letters_len = strlen(letters);
+	path_len = n - suffix_len;
+
+	if (path_len < 0 || strlen(template) - suffix_len < 6) {
+		errno = EINVAL;
+		return -1;
+	}
+
+	if (strncmp(path + path_len - 6, "XXXXXX", 6)) {
+		errno = EINVAL;
+		return -1;
+	}
+
+	/* Replace template's XXXXXX characters with randomness.
+	 * Try GIT_MKSTEMPS_MAX different filenames.
+	 */
+	gettimeofday(&tv, NULL);
+	value = ((size_t)(tv.tv_usec << 16)) ^ tv.tv_sec ^ getpid();
+
+	for (count = 0; count < GIT_MKSTEMPS_MAX; ++count) {
+		v = value;
+		for (i = path_len-1; i > path_len - 1 - 6; --i) {
+			*(path+i) = letters[v % letters_len];
+			v /= letters_len;
+		}
+		fd = open(path, O_CREAT | O_EXCL | O_RDWR, 0600);
+		if (fd > 0)
+			return fd;
+
+		/* This is a random value.  It is only necessary that
+		 * the next value generated by adding 7777 is different
+		 * modulus 2^32.
+		 */
+		value += 7777;
+	}
+	errno = EINVAL;
+	return -1;
+}
+
+
 int validate_headref(const char *path)
 {
 	struct stat st;
diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index 0720001..a9fdcb0 100755
--- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -136,6 +136,24 @@ test_expect_success 'GIT_EXTERNAL_DIFF with more than one changed files' '
 	GIT_EXTERNAL_DIFF=echo git diff
 '
 
+test_expect_success 'GIT_EXTERNAL_DIFF generates pretty paths with no ext' '
+	touch filenoext &&
+	git add filenoext &&
+	echo no extension > filenoext &&
+	GIT_EXTERNAL_DIFF=echo git diff filenoext | grep filenoext_ &&
+	git update-index --force-remove filenoext &&
+	rm filenoext
+'
+
+test_expect_success 'GIT_EXTERNAL_DIFF generates pretty paths with ext' '
+	touch file.ext &&
+	git add file.ext &&
+	echo with extension > file.ext &&
+	GIT_EXTERNAL_DIFF=echo git diff file.ext | grep file\.......\.ext &&
+	git update-index --force-remove file.ext &&
+	rm file.ext
+'
+
 echo "#!$SHELL_PATH" >fake-diff.sh
 cat >> fake-diff.sh <<\EOF
 cat $2 >> crlfed.txt
-- 
1.6.3.1.153.g6540
