From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v7 3/3] diff: generate pretty filenames in prep_temp_blob()
Date: Sun, 31 May 2009 01:35:52 -0700
Message-ID: <1243758952-28972-3-git-send-email-davvid@gmail.com>
References: <1243758952-28972-1-git-send-email-davvid@gmail.com>
 <1243758952-28972-2-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, peff@peff.net, markus.heidelberg@web.de,
	jnareb@gmail.com, j.sixt@viscovery.net,
	David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun May 31 10:37:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAgYF-0001sf-Os
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 10:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756807AbZEaIgB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 04:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756745AbZEaIf7
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 04:35:59 -0400
Received: from rv-out-0506.google.com ([209.85.198.225]:12477 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753233AbZEaIf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 04:35:56 -0400
Received: by rv-out-0506.google.com with SMTP id f6so503802rvb.5
        for <git@vger.kernel.org>; Sun, 31 May 2009 01:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=2eAWZN4etzS3c8ie6eg+GpGkVFzVoMyrQ6rgJSdI7k8=;
        b=MjPLSDQ7Y4XkqX3TSvex54pMup6tm/l/qpogz0vdYfqy+mIcAxKEMaqq0OpqWfXNSl
         0gaJeGwUR3VCwNcbF2fK9jskCmInfW2UeWoeNF0JMLwph3Awjskv/pxyFNdwm2eFv5QH
         mmCvCpLbCGnj6cYIbxwMY4o0r7qRRdj1vXmc4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=t1z5zQWokiTb7fMbLmnUbY/Pmh6M0AMto/s+aSsZB/Vo3YACvDsQefiCLqwXyFtwO+
         SuPD41NuF9nrpntvtJ/qDGk/j+nNCFPqM8ZC+AaZXwOnGBeuLvnGKJRucYuyvDYUk0D2
         icZDa9WRqkVGPVvueIED0PcmWg9GjCG1hZWVs=
Received: by 10.141.2.18 with SMTP id e18mr4164882rvi.127.1243758958321;
        Sun, 31 May 2009 01:35:58 -0700 (PDT)
Received: from localhost (cpe-76-87-90-126.socal.res.rr.com [76.87.90.126])
        by mx.google.com with ESMTPS id l28sm4374653waf.54.2009.05.31.01.35.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 31 May 2009 01:35:57 -0700 (PDT)
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <1243758952-28972-2-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120388>

Naturally, prep_temp_blob() did not care about filenames.
As a result, GIT_EXTERNAL_DIFF and textconv generated
filenames such as ".diff_XXXXXX".

This modifies prep_temp_blob() to generate user-friendly
filenames when creating temporary files.

Diffing "name.ext" now generates "XXXXXX_name.ext".

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 cache.h                  |    2 ++
 diff.c                   |   12 +++++++++++-
 path.c                   |   16 ++++++++++++++++
 t/t4020-diff-external.sh |    9 +++++++++
 4 files changed, 38 insertions(+), 1 deletions(-)

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
index dcfbcb0..4d0a5b9 100644
--- a/diff.c
+++ b/diff.c
@@ -1964,8 +1964,16 @@ static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
 {
 	int fd;
 	struct strbuf buf = STRBUF_INIT;
+	struct strbuf template = STRBUF_INIT;
+	char *path_dup = xstrdup(path);
+	const char *base = basename(path_dup);
 
-	fd = git_mkstemp(temp->tmp_path, PATH_MAX, ".diff_XXXXXX");
+	/* Generate "XXXXXX_basename.ext" */
+	strbuf_addstr(&template, "XXXXXX_");
+	strbuf_addstr(&template, base);
+
+	fd = git_mkstemps(temp->tmp_path, PATH_MAX, template.buf,
+			strlen(base) + 1);
 	if (fd < 0)
 		die("unable to create temp-file: %s", strerror(errno));
 	if (convert_to_working_tree(path,
@@ -1981,6 +1989,8 @@ static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
 	temp->hex[40] = 0;
 	sprintf(temp->mode, "%06o", mode);
 	strbuf_release(&buf);
+	strbuf_release(&template);
+	free(path_dup);
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
