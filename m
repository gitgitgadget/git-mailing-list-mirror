From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v5 3/3] diff: generate pretty filenames in prep_temp_blob()
Date: Fri, 29 May 2009 19:18:10 -0700
Message-ID: <1243649890-4522-3-git-send-email-davvid@gmail.com>
References: <1243649890-4522-1-git-send-email-davvid@gmail.com>
 <1243649890-4522-2-git-send-email-davvid@gmail.com>
Cc: gitster@pobox.com, peff@peff.net, markus.heidelberg@web.de,
	jnareb@gmail.com, j.sixt@viscovery.net,
	David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 30 04:20:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAEBG-0005Vv-M5
	for gcvg-git-2@gmane.org; Sat, 30 May 2009 04:20:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753330AbZE3CSX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 22:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753356AbZE3CSW
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 22:18:22 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:57308 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753101AbZE3CSU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 22:18:20 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1967900rvb.1
        for <git@vger.kernel.org>; Fri, 29 May 2009 19:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=4ax1kfk/sqKG472C1iXZwiN4Ay8l1KqOUTg9Gi73JhQ=;
        b=Yoc45oZ8yRBC6DiofnYoCp/9nq0Z1ojvTFTRRiJ4TPzT/+/kXjlQbubc0zTn4qcMd7
         1mY/2i55i26TR2AdS3xdHJYD/VN93tfPrkRkh5r7y3Tkv6Fdy1IaAIuBZFDxt3tfZobX
         ATACymwrHWHE7jBLrQfmZpjeUz9VV+7MMQapg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=RAWe/JOgVYXPZXQq65zBWtJy+vWuhsMw3CDjeoGACRnBtFzHHfRuOWoixHxnfWELXc
         9ZhCXpphSBI/TD7w5o2cQv6LlEYa+tXSpMjyVC9Omo5T1Mp2rGN1SP9XkTnBCKK6RuUX
         cOSnT2b6867/Uri8DFMXXBSxrJ8Iqwfvtq8UY=
Received: by 10.141.48.6 with SMTP id a6mr2054727rvk.161.1243649902560;
        Fri, 29 May 2009 19:18:22 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id j15sm3171940waf.16.2009.05.29.19.18.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 May 2009 19:18:21 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.178.g4daa97
In-Reply-To: <1243649890-4522-2-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120336>

Naturally, prep_temp_blob() did not care about filenames.
As a result, GIT_EXTERNAL_DIFF and textconv generated
filenames such as ".diff_XXXXXX".

This modifies prep_temp_blob() to generate user-friendly
filenames when creating temporary files.

Diffing "name.ext" now generates "XXXXXX_name.ext".

Signed-off-by: David Aguilar <davvid@gmail.com>
---

The difference since v4 is that find_basename() was
factored out into its own function.

 cache.h                  |    2 ++
 diff.c                   |   10 +++++++++-
 path.c                   |   16 ++++++++++++++++
 t/t4020-diff-external.sh |    9 +++++++++
 4 files changed, 36 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index 08b6f42..337458d 100644
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
index dcfbcb0..7edee28 100644
--- a/diff.c
+++ b/diff.c
@@ -1964,8 +1964,15 @@ static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
 {
 	int fd;
 	struct strbuf buf = STRBUF_INIT;
+	struct strbuf template = STRBUF_INIT;
+	const char *basename = find_basename(path);
 
-	fd = git_mkstemp(temp->tmp_path, PATH_MAX, ".diff_XXXXXX");
+	/* Generate "XXXXXX_basename.ext" */
+	strbuf_addstr(&template, "XXXXXX_");
+	strbuf_addstr(&template, basename);
+
+	fd = git_mkstemps(temp->tmp_path, PATH_MAX, template.buf,
+			strlen(basename) + 1);
 	if (fd < 0)
 		die("unable to create temp-file: %s", strerror(errno));
 	if (convert_to_working_tree(path,
@@ -1981,6 +1988,7 @@ static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
 	temp->hex[40] = 0;
 	sprintf(temp->mode, "%06o", mode);
 	strbuf_release(&buf);
+	strbuf_release(&template);
 }
 
 static struct diff_tempfile *prepare_temp_file(const char *name,
diff --git a/path.c b/path.c
index 7a2fe14..4f7fe8f 100644
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
1.6.3.1.178.g4daa97
