From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v4 2/2] diff: generate pretty filenames in prep_temp_blob()
Date: Thu, 28 May 2009 17:49:24 -0700
Message-ID: <1243558164-74756-2-git-send-email-davvid@gmail.com>
References: <1243558164-74756-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, peff@peff.net, markus.heidelberg@web.de,
	jnareb@gmail.com, j.sixt@viscovery.net,
	David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri May 29 02:49:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9qI1-00052g-Bw
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 02:49:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752612AbZE2Ate (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 20:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752547AbZE2Ate
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 20:49:34 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:61319 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318AbZE2Atd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 20:49:33 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1775024rvb.1
        for <git@vger.kernel.org>; Thu, 28 May 2009 17:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=/mJgUWg7TAI6IxEufpeVkvBPSYj25llyGPqwwSw/M9k=;
        b=NH9Pvm2iSnax0tRihrCDaoUoL0fcDWV6yCr/E6p93TTzXFx4CmGlNdKbKmCMALrzrx
         gkd8FOt79rjK4Aqo8TSdMaTKB2Yt8r5jmpiJJlEq4z5D0Y9eXV/ToOZ2MEuda7OuR1vp
         bZlsCc8YSQaXU4GrBqv+hPNHs7o9aYWiJJ69c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bW4zSY1I85dUhOVC2PScHCDF7E/Uc+UUWhzhclKXIpLxEz2wVae250RlHgCkiQqqNW
         forWHM6KgI+QvKFkgrnPakP/N4V+rqUGHznaooCZXKiZrRWpj5G8YuUAJYyttxb7k5dl
         gDGIU+nMSAQaj0OG5u9Z7HEWcv0kRdYqwFZgo=
Received: by 10.141.2.18 with SMTP id e18mr957880rvi.140.1243558175613;
        Thu, 28 May 2009 17:49:35 -0700 (PDT)
Received: from localhost (wdas-1.disneyanimation.com [12.188.26.1])
        by mx.google.com with ESMTPS id g14sm1955919rvb.42.2009.05.28.17.49.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 May 2009 17:49:34 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.169.g33fd
In-Reply-To: <1243558164-74756-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120243>

Naturally, prep_temp_blob() did not care about filenames.
As a result, scripts that used GIT_EXTERNAL_DIFF or textconv
ended up with filenames such as ".diff_XXXXXX".

This modifies prep_temp_blob() to generate user-friendly
filenames when creating temporary files.

Diffing "name.ext" now generates "XXXXXX_name.ext".

Signed-off-by: David Aguilar <davvid@gmail.com>
Tested-by: Johannes Sixt <j6t@kdbg.org> (Windows)
---

This includes Peff's suggestion to make this the
default behavior.

Peff mentioned that: "Switching to user-friendly
temp filenames for textconv was on my todo list".

This patch accomplishes exactly that for both
textconv and GIT_EXTERNAL_DIFF.

 cache.h                  |    2 ++
 diff.c                   |   19 ++++++++++++++++++-
 path.c                   |   16 ++++++++++++++++
 t/t4020-diff-external.sh |    9 +++++++++
 4 files changed, 45 insertions(+), 1 deletions(-)

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
index dcfbcb0..85503ce 100644
--- a/diff.c
+++ b/diff.c
@@ -1964,8 +1964,24 @@ static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
 {
 	int fd;
 	struct strbuf buf = STRBUF_INIT;
+	struct strbuf template = STRBUF_INIT;
+	char *basename = ((char*)path) + strlen(path) - 1;
+
+	/* Windows lacks basename() */
+	while(*basename && basename > path) {
+		basename--;
+		if (is_dir_sep(*basename)) {
+			basename++;
+			break;
+		}
+	}
+
+	/* Generate "XXXXXX_basename.ext" */
+	strbuf_addstr(&template, "XXXXXX_");
+	strbuf_addstr(&template, basename);
 
-	fd = git_mkstemp(temp->tmp_path, PATH_MAX, ".diff_XXXXXX");
+	fd = git_mkstemps(temp->tmp_path, PATH_MAX, template.buf,
+			strlen(basename) + 1);
 	if (fd < 0)
 		die("unable to create temp-file: %s", strerror(errno));
 	if (convert_to_working_tree(path,
@@ -1981,6 +1997,7 @@ static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
 	temp->hex[40] = 0;
 	sprintf(temp->mode, "%06o", mode);
 	strbuf_release(&buf);
+	strbuf_release(&template);
 }
 
 static struct diff_tempfile *prepare_temp_file(const char *name,
diff --git a/path.c b/path.c
index 8a0a674..047fdb0 100644
--- a/path.c
+++ b/path.c
@@ -139,6 +139,22 @@ int git_mkstemp(char *path, size_t len, const char *template)
 	return mkstemp(path);
 }
 
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
 
 int validate_headref(const char *path)
 {
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
1.6.1.3
