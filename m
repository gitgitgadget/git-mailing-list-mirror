From: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: [PATCH v6 2/7] setup: add gentle version of read_gitfile
Date: Sun, 10 May 2015 22:00:36 +0200
Message-ID: <1431288041-21077-3-git-send-email-erik.elfstrom@gmail.com>
References: <1431288041-21077-1-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 10 22:03:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrXRD-0004xi-Mr
	for gcvg-git-2@plane.gmane.org; Sun, 10 May 2015 22:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654AbbEJUCz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 May 2015 16:02:55 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:34569 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541AbbEJUCy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2015 16:02:54 -0400
Received: by lbcga7 with SMTP id ga7so81730928lbc.1
        for <git@vger.kernel.org>; Sun, 10 May 2015 13:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=YcD7A104Aacz5vE1Ex9duNTsPiD80sKnhmCCPybH5WY=;
        b=Dj/dmrx5l53cNKjdGt/SdIAIkV6xPgbD3WKIOGD7tMmtcIUMzpzGOQ0Os04NyvPVSg
         tePZHZgDCDrpwRAr4Ohr/zstu/d0dSVeBcmzRSqi4I76ilDQTpBHzsshqQiPqN5pw3vo
         BWgZRzXqPATiDCijXTzx9l65WW9ZaMZ3QxCNG/OQbAPcevclhEJHLGXYBn7qz2aWADat
         vTLrUX4FsBMyHi5HA0avegfHW4nmd8TGuNUvlHsNNkY+wyOuBLuf6bPNlkrmBizmMMnZ
         ik7YOx1bJ8qsw7/vFpGdrZwV+Qel2e6wXp3XzMlpang5dCf+DLccd+JVkmi7Nnk0VwbM
         g8uA==
X-Received: by 10.112.142.232 with SMTP id rz8mr5444419lbb.74.1431288172667;
        Sun, 10 May 2015 13:02:52 -0700 (PDT)
Received: from localhost.localdomain (h38n2-lk-d2.ias.bredband.telia.com. [78.72.191.38])
        by mx.google.com with ESMTPSA id k15sm2586218laa.28.2015.05.10.13.02.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 10 May 2015 13:02:51 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.60.gf7143f7
In-Reply-To: <1431288041-21077-1-git-send-email-erik.elfstrom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268742>

read_gitfile will die on most error cases. This makes it unsuitable
for speculative calls. Extract the core logic and provide a gentle
version that returns NULL on failure.

The first usecase of the new gentle version will be to probe for
submodules during git clean.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com>
---
 cache.h | 12 ++++++++-
 setup.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++++----=
--------
 2 files changed, 86 insertions(+), 18 deletions(-)

diff --git a/cache.h b/cache.h
index dd67695..54c902b 100644
--- a/cache.h
+++ b/cache.h
@@ -443,7 +443,17 @@ extern int set_git_dir(const char *path);
 extern const char *get_git_namespace(void);
 extern const char *strip_namespace(const char *namespaced_ref);
 extern const char *get_git_work_tree(void);
-extern const char *read_gitfile(const char *path);
+
+#define READ_GITFILE_ERR_STAT_FAILED 1
+#define READ_GITFILE_ERR_NOT_A_FILE 2
+#define READ_GITFILE_ERR_OPEN_FAILED 3
+#define READ_GITFILE_ERR_READ_FAILED 4
+#define READ_GITFILE_ERR_INVALID_FORMAT 5
+#define READ_GITFILE_ERR_NO_PATH 6
+#define READ_GITFILE_ERR_CANT_VERIFY_PATH 7
+#define READ_GITFILE_ERR_NOT_A_REPO 8
+extern const char *read_gitfile_gently(const char *path, int *return_e=
rror_code);
+#define read_gitfile(path) read_gitfile_gently((path), NULL)
 extern const char *resolve_gitdir(const char *suspect);
 extern void set_git_work_tree(const char *tree);
=20
diff --git a/setup.c b/setup.c
index 62ee88c..b919ea6 100644
--- a/setup.c
+++ b/setup.c
@@ -373,35 +373,55 @@ static int check_repository_format_gently(const c=
har *gitdir, int *nongit_ok)
 /*
  * Try to read the location of the git directory from the .git file,
  * return path to git directory if found.
+ *
+ * On failure, if return_error_code is not NULL, return_error_code
+ * will be set to an error code and NULL will be returned. If
+ * return_error_code is NULL the function will die instead (for most
+ * cases).
  */
-const char *read_gitfile(const char *path)
+const char *read_gitfile_gently(const char *path, int *return_error_co=
de)
 {
-	char *buf;
-	char *dir;
+	int error_code =3D 0;
+	char *buf =3D NULL;
+	char *dir =3D NULL;
 	const char *slash;
 	struct stat st;
 	int fd;
 	ssize_t len;
+	int is_git_dir;
+	struct strbuf err_msg =3D STRBUF_INIT;
=20
-	if (stat(path, &st))
-		return NULL;
-	if (!S_ISREG(st.st_mode))
-		return NULL;
+	if (stat(path, &st)) {
+		error_code =3D READ_GITFILE_ERR_STAT_FAILED;
+		goto cleanup_return;
+	}
+	if (!S_ISREG(st.st_mode)) {
+		error_code =3D READ_GITFILE_ERR_NOT_A_FILE;
+		goto cleanup_return;
+	}
 	fd =3D open(path, O_RDONLY);
-	if (fd < 0)
-		die_errno("Error opening '%s'", path);
+	if (fd < 0) {
+		error_code =3D READ_GITFILE_ERR_OPEN_FAILED;
+		goto cleanup_return;
+	}
 	buf =3D xmalloc(st.st_size + 1);
 	len =3D read_in_full(fd, buf, st.st_size);
 	close(fd);
-	if (len !=3D st.st_size)
-		die("Error reading %s", path);
+	if (len !=3D st.st_size) {
+		error_code =3D READ_GITFILE_ERR_READ_FAILED;
+		goto cleanup_return;
+	}
 	buf[len] =3D '\0';
-	if (!starts_with(buf, "gitdir: "))
-		die("Invalid gitfile format: %s", path);
+	if (!starts_with(buf, "gitdir: ")) {
+		error_code =3D READ_GITFILE_ERR_INVALID_FORMAT;
+		goto cleanup_return;
+	}
 	while (buf[len - 1] =3D=3D '\n' || buf[len - 1] =3D=3D '\r')
 		len--;
-	if (len < 9)
-		die("No path in gitfile: %s", path);
+	if (len < 9) {
+		error_code =3D READ_GITFILE_ERR_NO_PATH;
+		goto cleanup_return;
+	}
 	buf[len] =3D '\0';
 	dir =3D buf + 8;
=20
@@ -416,11 +436,49 @@ const char *read_gitfile(const char *path)
 		buf =3D dir;
 	}
=20
-	if (!is_git_directory(dir))
-		die("Not a git repository: %s", dir);
+	is_git_dir =3D is_git_directory_gently(dir, &error_code, &err_msg);
+	if (error_code) {
+		error_code =3D READ_GITFILE_ERR_CANT_VERIFY_PATH;
+		goto cleanup_return;
+	}
+	if (!is_git_dir) {
+		error_code =3D READ_GITFILE_ERR_NOT_A_REPO;
+		goto cleanup_return;
+	}
 	path =3D real_path(dir);
=20
+cleanup_return:
 	free(buf);
+
+	if (return_error_code)
+		*return_error_code =3D error_code;
+
+	if (error_code) {
+		if (return_error_code)
+			return NULL;
+
+		switch (error_code) {
+		case READ_GITFILE_ERR_STAT_FAILED:
+		case READ_GITFILE_ERR_NOT_A_FILE:
+			return NULL;
+		case READ_GITFILE_ERR_OPEN_FAILED:
+			die_errno("Error opening '%s'", path);
+		case READ_GITFILE_ERR_READ_FAILED:
+			die("Error reading %s", path);
+		case READ_GITFILE_ERR_INVALID_FORMAT:
+			die("Invalid gitfile format: %s", path);
+		case READ_GITFILE_ERR_NO_PATH:
+			die("No path in gitfile: %s", path);
+		case READ_GITFILE_ERR_CANT_VERIFY_PATH:
+			die("%s", err_msg.buf);
+		case READ_GITFILE_ERR_NOT_A_REPO:
+			die("Not a git repository: %s", dir);
+		default:
+			assert(0);
+		}
+	}
+
+	strbuf_release(&err_msg);
 	return path;
 }
=20
--=20
2.4.0.60.gf7143f7
