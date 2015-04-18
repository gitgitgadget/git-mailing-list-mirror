From: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: [PATCH/RFC v3 1/4] setup: add gentle version of read_gitfile
Date: Sat, 18 Apr 2015 22:41:09 +0200
Message-ID: <1429389672-30209-2-git-send-email-erik.elfstrom@gmail.com>
References: <1429389672-30209-1-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 18 22:41:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjZYl-0005hc-VC
	for gcvg-git-2@plane.gmane.org; Sat, 18 Apr 2015 22:41:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753160AbbDRUlp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Apr 2015 16:41:45 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:36749 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752033AbbDRUlo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2015 16:41:44 -0400
Received: by lbbqq2 with SMTP id qq2so105356739lbb.3
        for <git@vger.kernel.org>; Sat, 18 Apr 2015 13:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=RiCVkXKopIy0kJ0wlUQvIoAqghS4WbLHaPM+k0kuufk=;
        b=sfLI+7la082827gqiX71a8iGEF+aAIXcN8V9Qd86BrboZsey3hG7NlPxtKlwnPO/Vn
         nhRr3Ibyk1ZrBu5f95KqiGZIygr3/oAfKIMSdEYhIdjQqz+E64DByR59U7fZYMQiT91V
         d/oqRMhnBBhLhkJI1RKjbu9KhPViRFeovvX9QH0SSaqh+Gw3N0Bs5BjOcz3gyziiNx1r
         i+TmWSwWZPglNh5tYlDQ66BEtgc0F6nRkma1A2kt1uDVZX5J+fgA/sXFQrkMdtdbLyCO
         3OSINLHY1rEOKIEEwowlvSVAt54ZR0gyaNpZ0tnsPjK+FPY/k5nbzaSFznGefr49lRhO
         +klw==
X-Received: by 10.112.199.195 with SMTP id jm3mr9576914lbc.38.1429389702464;
        Sat, 18 Apr 2015 13:41:42 -0700 (PDT)
Received: from localhost.localdomain (h38n2-lk-d2.ias.bredband.telia.com. [78.72.191.38])
        by mx.google.com with ESMTPSA id sh6sm3249256lbb.31.2015.04.18.13.41.41
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Apr 2015 13:41:41 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc2.5.g2871d5e
In-Reply-To: <1429389672-30209-1-git-send-email-erik.elfstrom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267423>

read_gitfile will die on most error cases. This makes it unsuitable
for speculative calls. Extract the core logic and provide a gentle
version that returns NULL on failure.

The first usecase of the new gentle version will be to probe for
submodules during git clean.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com>
---
If this is going to be used for speculative probing should there
be a sanity check before:
	buf =3D xmalloc(st.st_size + 1);
	len =3D read_in_full(fd, buf, st.st_size);
Something like:
	if (st.st_size > PATH_MAX*2) {
		error =3D N;
		goto cleanup_return;
	{
What do you think?

 cache.h |  1 +
 setup.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++-------=
--------
 2 files changed, 74 insertions(+), 21 deletions(-)

diff --git a/cache.h b/cache.h
index 3d3244b..9d9199d 100644
--- a/cache.h
+++ b/cache.h
@@ -432,6 +432,7 @@ extern const char *get_git_namespace(void);
 extern const char *strip_namespace(const char *namespaced_ref);
 extern const char *get_git_work_tree(void);
 extern const char *read_gitfile(const char *path);
+extern const char *read_gitfile_gently(const char *path);
 extern const char *resolve_gitdir(const char *suspect);
 extern void set_git_work_tree(const char *tree);
=20
diff --git a/setup.c b/setup.c
index 979b13f..a33b293 100644
--- a/setup.c
+++ b/setup.c
@@ -332,38 +332,46 @@ static int check_repository_format_gently(const c=
har *gitdir, int *nongit_ok)
 	return 0;
 }
=20
-/*
- * Try to read the location of the git directory from the .git file,
- * return path to git directory if found.
- */
-const char *read_gitfile(const char *path)
+static const char *read_gitfile_gently_or_non_gently(const char *path,=
 int gently)
 {
-	char *buf;
+	int error =3D 0;
+	char *buf =3D NULL;
 	char *dir;
 	const char *slash;
 	struct stat st;
 	int fd;
 	ssize_t len;
-
-	if (stat(path, &st))
-		return NULL;
-	if (!S_ISREG(st.st_mode))
-		return NULL;
+	if (stat(path, &st)) {
+		error =3D 1;
+		goto cleanup_return;
+	}
+	if (!S_ISREG(st.st_mode)) {
+		error =3D 2;
+		goto cleanup_return;
+	}
 	fd =3D open(path, O_RDONLY);
-	if (fd < 0)
-		die_errno("Error opening '%s'", path);
+	if (fd < 0) {
+		error =3D 3;
+		goto cleanup_return;
+	}
 	buf =3D xmalloc(st.st_size + 1);
 	len =3D read_in_full(fd, buf, st.st_size);
 	close(fd);
-	if (len !=3D st.st_size)
-		die("Error reading %s", path);
+	if (len !=3D st.st_size) {
+		error =3D 4;
+		goto cleanup_return;
+	}
 	buf[len] =3D '\0';
-	if (!starts_with(buf, "gitdir: "))
-		die("Invalid gitfile format: %s", path);
+	if (!starts_with(buf, "gitdir: ")) {
+		error =3D 5;
+		goto cleanup_return;
+	}
 	while (buf[len - 1] =3D=3D '\n' || buf[len - 1] =3D=3D '\r')
 		len--;
-	if (len < 9)
-		die("No path in gitfile: %s", path);
+	if (len < 9) {
+		error =3D 6;
+		goto cleanup_return;
+	}
 	buf[len] =3D '\0';
 	dir =3D buf + 8;
=20
@@ -378,14 +386,58 @@ const char *read_gitfile(const char *path)
 		buf =3D dir;
 	}
=20
-	if (!is_git_directory(dir))
-		die("Not a git repository: %s", dir);
+	if (!is_git_directory(dir)) {
+		error =3D 7;
+		goto cleanup_return;
+	}
 	path =3D real_path(dir);
=20
+cleanup_return:
 	free(buf);
+
+	if (error) {
+		if (gently)
+			return NULL;
+
+		switch (error) {
+		case 1: // failed to stat
+		case 2: // not regular file
+			return NULL;
+		case 3:
+			die_errno("Error opening '%s'", path);
+		case 4:
+			die("Error reading %s", path);
+		case 5:
+			die("Invalid gitfile format: %s", path);
+		case 6:
+			die("No path in gitfile: %s", path);
+		case 7:
+			die("Not a git repository: %s", dir);
+		default:
+			assert(0);
+		}
+	}
+
 	return path;
 }
=20
+/*
+ * Try to read the location of the git directory from the .git file,
+ * return path to git directory if found, die on (most) failures.
+ */
+const char *read_gitfile(const char *path)
+{
+	return read_gitfile_gently_or_non_gently(path, 0);
+}
+
+/*
+ * Same as read_gitfile but return NULL on failure.
+ */
+const char *read_gitfile_gently(const char *path)
+{
+	return read_gitfile_gently_or_non_gently(path, 1);
+}
+
 static const char *setup_explicit_git_dir(const char *gitdirenv,
 					  struct strbuf *cwd,
 					  int *nongit_ok)
--=20
2.4.0.rc2.5.g2871d5e
