From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/20] dir.c: optionally compute sha-1 of a .gitignore file
Date: Wed,  7 May 2014 21:51:44 +0700
Message-ID: <1399474320-6840-5-git-send-email-pclouds@gmail.com>
References: <1399474320-6840-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 07 16:52:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi3Ct-0005bD-OC
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 16:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755781AbaEGOwY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 10:52:24 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:50199 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbaEGOwX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 10:52:23 -0400
Received: by mail-pa0-f52.google.com with SMTP id kx10so1311901pab.11
        for <git@vger.kernel.org>; Wed, 07 May 2014 07:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2O4x+Q+qqXzH+8f5T40BtVTz4PtF4VK7dzZ4HP7f2kQ=;
        b=cHv3U1ccRU1tt3WyJXofdlhVRw8wpqnJH0+DeQmtOFd3wFncqZIdzJMo1jw8/xxG5a
         /spCvZfRznXAYnABTufujUm698tAobTAlMLNaUhGdpA+Sdo+cEJIjRm468seK6DdCWKM
         NXbh2ha8R6qNcEjXrrpSCPtojxhCPzc5U3zqttYN9mbDk/9e8mGLtxBW54GmtNqSmc/h
         YVVoKAUSutAjX8VwEovoDzkvVsH0sGJJuOmA/YE15Ry0G95slAjw0t8nUdKYAzT7vn4+
         b6UjGD0UFxZB6gQRkDXZSDNx/hf/Ce9QXto+HpDuYh513XqcLVhwAbU5xWyXsQpxGpeF
         40Lw==
X-Received: by 10.66.246.229 with SMTP id xz5mr19791917pac.119.1399474342569;
        Wed, 07 May 2014 07:52:22 -0700 (PDT)
Received: from lanh ([115.73.204.3])
        by mx.google.com with ESMTPSA id tf10sm3632499pbc.70.2014.05.07.07.52.19
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 07 May 2014 07:52:21 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 07 May 2014 21:52:23 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1399474320-6840-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248309>

This is not used anywhere yet. But the goal is to compare quickly if a
.gitignore file has changed when one has SHA-1 of the old .gitignore.
---
 dir.c | 51 ++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/dir.c b/dir.c
index c081754..e2edeca 100644
--- a/dir.c
+++ b/dir.c
@@ -466,7 +466,8 @@ void add_exclude(const char *string, const char *base,
 	x->el = el;
 }
 
-static void *read_skip_worktree_file_from_index(const char *path, size_t *size)
+static void *read_skip_worktree_file_from_index(const char *path, size_t *size,
+						unsigned char *sha1)
 {
 	int pos, len;
 	unsigned long sz;
@@ -485,6 +486,8 @@ static void *read_skip_worktree_file_from_index(const char *path, size_t *size)
 		return NULL;
 	}
 	*size = xsize_t(sz);
+	if (sha1)
+		hashcpy(sha1, active_cache[pos]->sha1);
 	return data;
 }
 
@@ -525,11 +528,14 @@ static void trim_trailing_spaces(char *buf)
 		buf[last_space] = '\0';
 }
 
-int add_excludes_from_file_to_list(const char *fname,
-				   const char *base,
-				   int baselen,
-				   struct exclude_list *el,
-				   int check_index)
+static int add_excludes(const char *fname,
+			const char *base,
+			int baselen,
+			struct exclude_list *el,
+			int check_index,
+			unsigned char *sha1,
+			struct stat_data *ref_stat,
+			const unsigned char *ref_sha1)
 {
 	struct stat st;
 	int fd, i, lineno = 1;
@@ -543,9 +549,13 @@ int add_excludes_from_file_to_list(const char *fname,
 		if (0 <= fd)
 			close(fd);
 		if (!check_index ||
-		    (buf = read_skip_worktree_file_from_index(fname, &size)) == NULL)
+		    (buf = read_skip_worktree_file_from_index(fname, &size, sha1)) == NULL)
 			return -1;
+		if (ref_stat)
+			memset(ref_stat, 0, sizeof(*ref_stat));
 		if (size == 0) {
+			if (sha1)
+				hashcpy(sha1, EMPTY_BLOB_SHA1_BIN);
 			free(buf);
 			return 0;
 		}
@@ -556,6 +566,10 @@ int add_excludes_from_file_to_list(const char *fname,
 	} else {
 		size = xsize_t(st.st_size);
 		if (size == 0) {
+			if (ref_stat)
+				fill_stat_data(ref_stat, &st);
+			if (sha1)
+				hashcpy(sha1, EMPTY_BLOB_SHA1_BIN);
 			close(fd);
 			return 0;
 		}
@@ -567,6 +581,21 @@ int add_excludes_from_file_to_list(const char *fname,
 		}
 		buf[size++] = '\n';
 		close(fd);
+		if (sha1) {
+			int pos;
+			if (!ref_stat &&
+			    (pos = cache_name_pos(fname, strlen(fname))) >= 0 &&
+			    !ce_stage(active_cache[pos]) &&
+			    ce_uptodate(active_cache[pos]))
+				hashcpy(sha1, active_cache[pos]->sha1);
+			else if (ref_stat && !match_stat_data(ref_stat, &st)) {
+				if (ref_sha1 != sha1) /* support ref_sha1 == sha1 */
+					hashcpy(sha1, ref_sha1);
+			} else
+				hash_sha1_file(buf, size, "blob", sha1);
+		}
+		if (ref_stat)
+			fill_stat_data(ref_stat, &st);
 	}
 
 	el->filebuf = buf;
@@ -585,6 +614,14 @@ int add_excludes_from_file_to_list(const char *fname,
 	return 0;
 }
 
+int add_excludes_from_file_to_list(const char *fname, const char *base, int baselen,
+				   struct exclude_list *el, int check_index)
+{
+	return add_excludes(fname, base, baselen, el, check_index,
+			    NULL, NULL, NULL);
+}
+
+
 struct exclude_list *add_exclude_list(struct dir_struct *dir,
 				      int group_type, const char *src)
 {
-- 
1.9.1.346.ga2b5940
