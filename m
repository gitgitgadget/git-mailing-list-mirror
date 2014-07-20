From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/2] lockfile.c: remove PATH_MAX limitation (except in resolve_symlink)
Date: Sun, 20 Jul 2014 19:13:18 +0700
Message-ID: <1405858399-23082-1-git-send-email-pclouds@gmail.com>
References: <1405688937-22925-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 20 14:15:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8q1Q-0005gC-DF
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jul 2014 14:15:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbaGTMPH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Jul 2014 08:15:07 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:44041 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbaGTMPG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2014 08:15:06 -0400
Received: by mail-pa0-f45.google.com with SMTP id eu11so8088943pac.18
        for <git@vger.kernel.org>; Sun, 20 Jul 2014 05:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=te82lIFJBne7KLF+9ZeUJZtknDHFYHwz5zXw9IgKqaY=;
        b=z13dO3QTgr5w2UHHE2hH+hHq6Gmy3HlOciUskuEboskTAMkdiv91ANTEhDZXQCepCf
         QZD0CxzwDMJ8tg2XIkuZpz4JLVXxyvbaBYU3UNHl1RT181UDhkPihvhj2c+Ab+zZNoJO
         uXLqEagfbzK/lxb6JuSuz8wkhhbBqVDkuQHYy8PyCUdsJXx6JAqPu5IYTUTJrnkzJaNH
         JHVDY8gDu8mH10BonaR16H7BH+8xZPxqsLx0VGnvAYn6hZvVpRMGZ2PusIS6dY1s8nxI
         xYR7XQ9d4ltp+jRQv9kWNviuWXK2eUCoJ8eNzikGvWpmjqwcHdw8HI23qi/38YVwI+Ym
         4wOA==
X-Received: by 10.70.128.164 with SMTP id np4mr297706pdb.168.1405858504604;
        Sun, 20 Jul 2014 05:15:04 -0700 (PDT)
Received: from lanh ([115.73.231.7])
        by mx.google.com with ESMTPSA id rc3sm11099544pbc.5.2014.07.20.05.15.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jul 2014 05:15:03 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 20 Jul 2014 19:14:58 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1405688937-22925-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253919>

Something extra is, because struct lock_file is usually used as static
variables in many places. This patch reduces bss section by about 80k
bytes (or 23%) on Linux.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 This helps remove the length check in v1 of the next patch.

 cache.h    |  2 +-
 lockfile.c | 56 ++++++++++++++++++++++++++++++++----------------------=
--
 2 files changed, 33 insertions(+), 25 deletions(-)

diff --git a/cache.h b/cache.h
index 44aa439..9ecb636 100644
--- a/cache.h
+++ b/cache.h
@@ -554,7 +554,7 @@ struct lock_file {
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
1.9.1.346.ga2b5940
