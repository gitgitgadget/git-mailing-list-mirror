From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 2/2] diff: generate prettier filenames when using GIT_EXTERNAL_DIFF
Date: Wed, 27 May 2009 23:11:17 -0700
Message-ID: <1243491077-27738-2-git-send-email-davvid@gmail.com>
References: <1243491077-27738-1-git-send-email-davvid@gmail.com>
Cc: gitster@pobox.com, markus.heidelberg@web.de, jnareb@gmail.com,
	j.sixt@viscovery.net, David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 28 08:11:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9YqB-0004B4-Ku
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 08:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758093AbZE1GLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 02:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757437AbZE1GLj
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 02:11:39 -0400
Received: from mail-px0-f123.google.com ([209.85.216.123]:45595 "EHLO
	mail-px0-f123.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830AbZE1GLi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 02:11:38 -0400
Received: by mail-px0-f123.google.com with SMTP id 29so808509pxi.33
        for <git@vger.kernel.org>; Wed, 27 May 2009 23:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=NBNxTKJuDJ2lsUaNHrlfT1UCRCkFwAlBCcKxaZa1eh4=;
        b=RiBS9Zw+3ELBjX/8tL4sSjGw32W+99LVFwdZjxT5Sq9eZ6M6Uchrhg3rVDbY7bg1F3
         xkpQTCo6hEMMJUO9gfKlura8aWVHN4b8iw/w0wfgCVhUrd3JNEgyevmmvczUcpyeilG5
         PdD4M0EiDGkVaNxvYJHXc6Q5gDC8u+9Jq3OPE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VRfdc/fGYxt165tlZKagaMNlRBfjwD7rns1HBpnQN7374jHVMr9tAZ8pDFjteOYY+L
         YnSAPebwkfM9TmzrXYnkGWM+g1MZrli3EO77XTbzgk61hP3AGwUmRpl3atkVit53zXxW
         nfjxjDUErUkNVJWRTUO9osnM6Wq2e2OxMvv+k=
Received: by 10.114.145.7 with SMTP id s7mr773027wad.86.1243491099831;
        Wed, 27 May 2009 23:11:39 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id k21sm15084370waf.24.2009.05.27.23.11.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 May 2009 23:11:39 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.169.g33fd
In-Reply-To: <1243491077-27738-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120156>

Naturally, prep_temp_blob() did not care about filenames.
As a result, scripts that use GIT_EXTERNAL_DIFF ended up
with filenames such as ".diff_XXXXXX".

This specializes the GIT_EXTERNAL_DIFF code to generate
user-friendly filenames when creating temporary files.

Diffing "name.ext" now generates "XXXXXX_name.ext".

Signed-off-by: David Aguilar <davvid@gmail.com>
---

This includes Hannes' suggestion to avoid basename()
for Windows portability.

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
1.6.3.1.30.g55524
