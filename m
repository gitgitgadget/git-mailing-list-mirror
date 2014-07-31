From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 1/3] lockfile.c: remove PATH_MAX limitation (except in resolve_symlink)
Date: Thu, 31 Jul 2014 20:43:32 +0700
Message-ID: <1406814214-21725-2-git-send-email-pclouds@gmail.com>
References: <1405858399-23082-1-git-send-email-pclouds@gmail.com>
 <1406814214-21725-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, ramsay@ramsay1.demon.co.uk,
	yuelinho777@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 15:43:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCqe1-0004Wa-Fc
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 15:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbaGaNnk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Jul 2014 09:43:40 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:63656 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702AbaGaNnj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 09:43:39 -0400
Received: by mail-pa0-f53.google.com with SMTP id rd3so3633049pab.26
        for <git@vger.kernel.org>; Thu, 31 Jul 2014 06:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=sV+NZ9sPhohAaU1dQy02yc2xIEGOItlkVo9CivjseBw=;
        b=bnH46awBCZsiT2k4Y/8AI+R6E7oGx+t99I7Xkj63emj/wSxrH1rVqumLgVHFzPho+l
         lu/guVUEdzfS7dC18v3Q7/F1zycnf8V+uGKIuSQkFIrRiaeNcBmxdyFhAOj8AwQcvP+g
         vX2rWOhP2VgNI0tedk3wQNiCr/ZroeKz20crgz1Wgc+vtltg5fYd6uEOMoc2jH7zT9fM
         0dxypgPjdA4ZzGQzfxYWqCYRg5ylKzQ8FcN9CXiKIVISs+KBRNfzpQyJm+8gDUQzAIUv
         +Z8To+Vn+Nv2W1eYwyb+VdKIJMp9rZecG9Bsbbl+2luxtnF9zfQDPy8f+9RXOyFZbwEx
         /Gjw==
X-Received: by 10.68.189.137 with SMTP id gi9mr4365680pbc.87.1406814218776;
        Thu, 31 Jul 2014 06:43:38 -0700 (PDT)
Received: from lanh ([115.73.244.27])
        by mx.google.com with ESMTPSA id x15sm5601133pbt.52.2014.07.31.06.43.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jul 2014 06:43:38 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 31 Jul 2014 20:43:43 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1406814214-21725-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254571>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h    |  2 +-
 lockfile.c | 56 ++++++++++++++++++++++++++++++++----------------------=
--
 2 files changed, 33 insertions(+), 25 deletions(-)

diff --git a/cache.h b/cache.h
index cc46be4..0d8dce7 100644
--- a/cache.h
+++ b/cache.h
@@ -539,7 +539,7 @@ struct lock_file {
 	int fd;
 	pid_t owner;
 	char on_list;
-	char filename[PATH_MAX];
+	char *filename;
 };
 #define LOCK_DIE_ON_ERROR 1
 #define LOCK_NODEREF 2
diff --git a/lockfile.c b/lockfile.c
index 8fbcb6a..968b28f 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -7,13 +7,19 @@
 static struct lock_file *lock_file_list;
 static const char *alternate_index_output;
=20
+static void clear_filename(struct lock_file *lk)
+{
+	free(lk->filename);
+	lk->filename =3D NULL;
+}
+
 static void remove_lock_file(void)
 {
 	pid_t me =3D getpid();
=20
 	while (lock_file_list) {
 		if (lock_file_list->owner =3D=3D me &&
-		    lock_file_list->filename[0]) {
+		    lock_file_list->filename) {
 			if (lock_file_list->fd >=3D 0)
 				close(lock_file_list->fd);
 			unlink_or_warn(lock_file_list->filename);
@@ -77,10 +83,16 @@ static char *last_path_elm(char *p)
  * Always returns p.
  */
=20
-static char *resolve_symlink(char *p, size_t s)
+static char *resolve_symlink(const char *in)
 {
+	static char p[PATH_MAX];
+	size_t s =3D sizeof(p);
 	int depth =3D MAXDEPTH;
=20
+	if (strlen(in) >=3D sizeof(p))
+		return NULL;
+	strcpy(p, in);
+
 	while (depth--) {
 		char link[PATH_MAX];
 		int link_len =3D readlink(p, link, sizeof(link));
@@ -124,17 +136,12 @@ static char *resolve_symlink(char *p, size_t s)
=20
 static int lock_file(struct lock_file *lk, const char *path, int flags=
)
 {
-	/*
-	 * subtract 5 from size to make sure there's room for adding
-	 * ".lock" for the lock file name
-	 */
-	static const size_t max_path_len =3D sizeof(lk->filename) - 5;
-
-	if (strlen(path) >=3D max_path_len)
+	int len;
+	if (!(flags & LOCK_NODEREF) && !(path =3D resolve_symlink(path)))
 		return -1;
+	len =3D strlen(path) + 5; /* .lock */
+	lk->filename =3D xmallocz(len);
 	strcpy(lk->filename, path);
-	if (!(flags & LOCK_NODEREF))
-		resolve_symlink(lk->filename, max_path_len);
 	strcat(lk->filename, ".lock");
 	lk->fd =3D open(lk->filename, O_RDWR | O_CREAT | O_EXCL, 0666);
 	if (0 <=3D lk->fd) {
@@ -153,7 +160,7 @@ static int lock_file(struct lock_file *lk, const ch=
ar *path, int flags)
 				     lk->filename);
 	}
 	else
-		lk->filename[0] =3D 0;
+		clear_filename(lk);
 	return lk->fd;
 }
=20
@@ -231,16 +238,17 @@ int close_lock_file(struct lock_file *lk)
=20
 int commit_lock_file(struct lock_file *lk)
 {
-	char result_file[PATH_MAX];
-	size_t i;
-	if (lk->fd >=3D 0 && close_lock_file(lk))
+	char *result_file;
+	if ((lk->fd >=3D 0 && close_lock_file(lk)) || !lk->filename)
 		return -1;
-	strcpy(result_file, lk->filename);
-	i =3D strlen(result_file) - 5; /* .lock */
-	result_file[i] =3D 0;
-	if (rename(lk->filename, result_file))
+	result_file =3D xmemdupz(lk->filename,
+			       strlen(lk->filename) - 5 /* .lock */);
+	if (rename(lk->filename, result_file)) {
+		free(result_file);
 		return -1;
-	lk->filename[0] =3D 0;
+	}
+	free(result_file);
+	clear_filename(lk);
 	return 0;
 }
=20
@@ -260,11 +268,11 @@ void set_alternate_index_output(const char *name)
 int commit_locked_index(struct lock_file *lk)
 {
 	if (alternate_index_output) {
-		if (lk->fd >=3D 0 && close_lock_file(lk))
+		if ((lk->fd >=3D 0 && close_lock_file(lk)) || !lk->filename)
 			return -1;
 		if (rename(lk->filename, alternate_index_output))
 			return -1;
-		lk->filename[0] =3D 0;
+		clear_filename(lk);
 		return 0;
 	}
 	else
@@ -273,10 +281,10 @@ int commit_locked_index(struct lock_file *lk)
=20
 void rollback_lock_file(struct lock_file *lk)
 {
-	if (lk->filename[0]) {
+	if (lk->filename) {
 		if (lk->fd >=3D 0)
 			close(lk->fd);
 		unlink_or_warn(lk->filename);
 	}
-	lk->filename[0] =3D 0;
+	clear_filename(lk);
 }
--=20
2.1.0.rc0.78.gc0d8480
