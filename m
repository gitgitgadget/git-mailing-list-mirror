From: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: [PATCH v6 7/7] RFC: Change error handling scheme in read_gitfile_gently
Date: Sun, 10 May 2015 22:00:41 +0200
Message-ID: <1431288041-21077-8-git-send-email-erik.elfstrom@gmail.com>
References: <1431288041-21077-1-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 10 22:03:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrXRw-0005I4-AI
	for gcvg-git-2@plane.gmane.org; Sun, 10 May 2015 22:03:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbbEJUDk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 May 2015 16:03:40 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:33600 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbbEJUDj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2015 16:03:39 -0400
Received: by lbbzk7 with SMTP id zk7so81660886lbb.0
        for <git@vger.kernel.org>; Sun, 10 May 2015 13:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Y8uAOcmQUuT+bbThqAaApzSEE7ZykCVvaFn1Iw2zi88=;
        b=xvkVbcWviZBIqrIecoCfMX4pT8WjgBRdg2rqxX1GUm7dWX49+H2d6GqaYTBIFkCuYe
         k0rDP2Kfn4MVkFtenENXE1ROnP1n0TvCh2cP1Qyahcd8XOryJg+FY/OvZZKzoxMxBk7w
         74fez1Di2i0LCPMJ7x0HdXVQWzzetXaOFdu4Sp+XMwXuVXAMgsjZvHDlrxuiQ0zrP7dY
         GqrJQGkSCicab3sVFl700zoTxG+FA9Bn8mCMVzi29zc9yD9aBRI53DndhjJx3iHzheD8
         Asz9vVc/wiVJZuxv9td9b7vY38sGpDcTZG89ta99GGMad7xZFrqB2scfhPwSTcS41ir4
         3HzA==
X-Received: by 10.152.1.227 with SMTP id 3mr5627605lap.61.1431288217883;
        Sun, 10 May 2015 13:03:37 -0700 (PDT)
Received: from localhost.localdomain (h38n2-lk-d2.ias.bredband.telia.com. [78.72.191.38])
        by mx.google.com with ESMTPSA id k15sm2586218laa.28.2015.05.10.13.03.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 10 May 2015 13:03:37 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.60.gf7143f7
In-Reply-To: <1431288041-21077-1-git-send-email-erik.elfstrom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268747>

Signed-off-by: Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com>
---

Since there was a lot of discussion on error reporting strategy on
the previous patch I have done a quick prototype of the theme
proposed by Jonathan Nieder.

I believe the conclusion was to NOT go this route but this way people
get to see an example of what it could look like to make the
discussion and decision a bit easier.

I will either drop this patch or split it up and squash it into the
appropriate commits (along with change requests if any) depending on
the outcome of the review discussion.

 builtin/clean.c |   3 +-
 cache.h         |   5 +--
 setup.c         | 106 +++++++++++++++++++++++++++++++-----------------=
--------
 3 files changed, 63 insertions(+), 51 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index d739dcf..7047d6e 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -162,7 +162,8 @@ static int is_git_repository(struct strbuf *path)
 	if (path->buf[orig_path_len - 1] !=3D '/')
 		strbuf_addch(path, '/');
 	strbuf_addstr(path, ".git");
-	if (read_gitfile_gently(path->buf, &gitfile_error) || is_git_director=
y(path->buf))
+	if (read_gitfile_gently(path->buf, &gitfile_error, NULL) ||
+	    is_git_directory(path->buf))
 		ret =3D 1;
 	if (gitfile_error =3D=3D READ_GITFILE_ERR_OPEN_FAILED ||
 	    gitfile_error =3D=3D READ_GITFILE_ERR_READ_FAILED ||
diff --git a/cache.h b/cache.h
index 7c8abcb..76d311a 100644
--- a/cache.h
+++ b/cache.h
@@ -453,8 +453,9 @@ extern const char *get_git_work_tree(void);
 #define READ_GITFILE_ERR_CANT_VERIFY_PATH 7
 #define READ_GITFILE_ERR_NOT_A_REPO 8
 #define READ_GITFILE_ERR_TOO_LARGE 9
-extern const char *read_gitfile_gently(const char *path, int *return_e=
rror_code);
-#define read_gitfile(path) read_gitfile_gently((path), NULL)
+extern const char *read_gitfile_gently(const char *path, int *return_e=
rr, struct strbuf *err_msg);
+extern const char *read_gitfile(const char *path);
+
 extern const char *resolve_gitdir(const char *suspect);
 extern void set_git_work_tree(const char *tree);
=20
diff --git a/setup.c b/setup.c
index bfaf4a6..49274b3 100644
--- a/setup.c
+++ b/setup.c
@@ -374,15 +374,16 @@ static int check_repository_format_gently(const c=
har *gitdir, int *nongit_ok)
  * Try to read the location of the git directory from the .git file,
  * return path to git directory if found.
  *
- * On failure, if return_error_code is not NULL, return_error_code
- * will be set to an error code and NULL will be returned. If
- * return_error_code is NULL the function will die instead (for most
- * cases).
+ * In the event of an error, return_err will be set to an error code
+ * and err_msg will be set to an error message describing the error
+ * and NULL will be returned. If no error reporting is required, pass
+ * NULL for return_err and/or err_msg.
  */
-const char *read_gitfile_gently(const char *path, int *return_error_co=
de)
+const char *read_gitfile_gently(const char *path, int *return_err,
+				struct strbuf *err_msg)
 {
 	static const int one_MB =3D 1 << 20;
-	int error_code =3D 0;
+	const char *ret =3D NULL;
 	char *buf =3D NULL;
 	char *dir =3D NULL;
 	const char *slash;
@@ -390,42 +391,59 @@ const char *read_gitfile_gently(const char *path,=
 int *return_error_code)
 	int fd;
 	ssize_t len;
 	int is_git_dir;
-	struct strbuf err_msg =3D STRBUF_INIT;
+	int is_git_dir_err;
+
+	if (return_err)
+		*return_err =3D 0;
=20
 	if (stat(path, &st)) {
-		error_code =3D READ_GITFILE_ERR_STAT_FAILED;
+		set_error(return_err, err_msg,
+			  READ_GITFILE_ERR_STAT_FAILED,
+			  "Could not stat: '%s'", path);
 		goto cleanup_return;
 	}
 	if (!S_ISREG(st.st_mode)) {
-		error_code =3D READ_GITFILE_ERR_NOT_A_FILE;
+		set_error(return_err, err_msg,
+			  READ_GITFILE_ERR_NOT_A_FILE,
+			  "Not a file: '%s'", path);
 		goto cleanup_return;
 	}
 	fd =3D open(path, O_RDONLY);
 	if (fd < 0) {
-		error_code =3D READ_GITFILE_ERR_OPEN_FAILED;
+		set_error(return_err, err_msg,
+			  READ_GITFILE_ERR_OPEN_FAILED,
+			  "Error opening '%s'", path);
 		goto cleanup_return;
 	}
 	if (st.st_size > one_MB) {
 		close(fd);
-		error_code =3D READ_GITFILE_ERR_TOO_LARGE;
+		set_error(return_err, err_msg,
+			  READ_GITFILE_ERR_TOO_LARGE,
+			  "Too large to be a .git file: '%s'", path);
 		goto cleanup_return;
 	}
 	buf =3D xmalloc(st.st_size + 1);
 	len =3D read_in_full(fd, buf, st.st_size);
 	close(fd);
 	if (len !=3D st.st_size) {
-		error_code =3D READ_GITFILE_ERR_READ_FAILED;
+		set_error(return_err, err_msg,
+			  READ_GITFILE_ERR_READ_FAILED,
+			  "Error reading %s", path);
 		goto cleanup_return;
 	}
 	buf[len] =3D '\0';
 	if (!starts_with(buf, "gitdir: ")) {
-		error_code =3D READ_GITFILE_ERR_INVALID_FORMAT;
+		set_error(return_err, err_msg,
+			  READ_GITFILE_ERR_INVALID_FORMAT,
+			  "Invalid gitfile format: %s", path);
 		goto cleanup_return;
 	}
 	while (buf[len - 1] =3D=3D '\n' || buf[len - 1] =3D=3D '\r')
 		len--;
 	if (len < 9) {
-		error_code =3D READ_GITFILE_ERR_NO_PATH;
+		set_error(return_err, err_msg,
+			  READ_GITFILE_ERR_NO_PATH,
+			  "No path in gitfile: %s", path);
 		goto cleanup_return;
 	}
 	buf[len] =3D '\0';
@@ -442,52 +460,44 @@ const char *read_gitfile_gently(const char *path,=
 int *return_error_code)
 		buf =3D dir;
 	}
=20
-	is_git_dir =3D is_git_directory_gently(dir, &error_code, &err_msg);
-	if (error_code) {
-		error_code =3D READ_GITFILE_ERR_CANT_VERIFY_PATH;
+	is_git_dir =3D is_git_directory_gently(dir, &is_git_dir_err, err_msg)=
;
+	if (is_git_dir_err) {
+		if (return_err)
+			*return_err =3D READ_GITFILE_ERR_CANT_VERIFY_PATH;
 		goto cleanup_return;
 	}
 	if (!is_git_dir) {
-		error_code =3D READ_GITFILE_ERR_NOT_A_REPO;
+		set_error(return_err, err_msg,
+			  READ_GITFILE_ERR_NOT_A_REPO,
+			  "Not a git repository: %s", dir);
 		goto cleanup_return;
 	}
-	path =3D real_path(dir);
+	ret =3D real_path(dir);
=20
 cleanup_return:
 	free(buf);
+	return ret;
+}
=20
-	if (return_error_code)
-		*return_error_code =3D error_code;
+const char *read_gitfile(const char *path)
+{
+	int err;
+	const char *ret;
+	struct strbuf err_msg =3D STRBUF_INIT;
=20
-	if (error_code) {
-		if (return_error_code)
-			return NULL;
+	ret =3D read_gitfile_gently(path, &err, &err_msg);
=20
-		switch (error_code) {
-		case READ_GITFILE_ERR_STAT_FAILED:
-		case READ_GITFILE_ERR_NOT_A_FILE:
-			return NULL;
-		case READ_GITFILE_ERR_OPEN_FAILED:
-			die_errno("Error opening '%s'", path);
-		case READ_GITFILE_ERR_TOO_LARGE:
-			die("Too large to be a .git file: '%s'", path);
-		case READ_GITFILE_ERR_READ_FAILED:
-			die("Error reading %s", path);
-		case READ_GITFILE_ERR_INVALID_FORMAT:
-			die("Invalid gitfile format: %s", path);
-		case READ_GITFILE_ERR_NO_PATH:
-			die("No path in gitfile: %s", path);
-		case READ_GITFILE_ERR_CANT_VERIFY_PATH:
-			die("%s", err_msg.buf);
-		case READ_GITFILE_ERR_NOT_A_REPO:
-			die("Not a git repository: %s", dir);
-		default:
-			assert(0);
-		}
+	switch (err) {
+	case 0: /* No need to free err_msg, will only be
+		 * touched in case of error */
+		return ret;
+	case READ_GITFILE_ERR_STAT_FAILED:
+	case READ_GITFILE_ERR_NOT_A_FILE:
+		strbuf_release(&err_msg);
+		return NULL;
+	default:
+		die("%s", err_msg.buf);
 	}
-
-	strbuf_release(&err_msg);
-	return path;
 }
=20
 static const char *setup_explicit_git_dir(const char *gitdirenv,
--=20
2.4.0.60.gf7143f7
