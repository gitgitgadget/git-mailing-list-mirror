From: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: [PATCH v4 1/5] setup: add gentle version of read_gitfile
Date: Sat, 25 Apr 2015 11:06:37 +0200
Message-ID: <1429952801-2646-2-git-send-email-erik.elfstrom@gmail.com>
References: <1429952801-2646-1-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 25 11:07:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ylw3K-00051K-Jx
	for gcvg-git-2@plane.gmane.org; Sat, 25 Apr 2015 11:07:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757779AbbDYJG7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Apr 2015 05:06:59 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:35508 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757481AbbDYJG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2015 05:06:57 -0400
Received: by lbbuc2 with SMTP id uc2so51994761lbb.2
        for <git@vger.kernel.org>; Sat, 25 Apr 2015 02:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=EbvsIovRi4XF9auVPbIvFmyY/jPJqvmg2AguNFmYysw=;
        b=lxy/ZUaWSu7jVxweAZNzZBqGMr0SX5uoelEfm408XgQIg211qhBLgH+RxgAF+iHvzv
         sTHaMxmjO5MIiB8gki3ldXc8uYSUKfzHzCNRDZL7TUStAaxIqXikXoByKqD8fGF7wCf4
         YPDdtB4BVv5CI3+r+aS6zJDa6g7jbET7qShzPztBEZbr/kGug2W84llt+AkTBNBqWYtw
         0Q2udv9gq6fMMZqp29H/ou35J3cY5walHEk2/D4eoRhyUoLLk4V94/yNtlOguKhQJJc1
         VknvzUj0NjHS+he8qC21RpaHd/cFIcQEEsejBIk/9bdIPX9Yasd6p80WD8q0d4gxTQLJ
         a1ew==
X-Received: by 10.152.116.102 with SMTP id jv6mr2123410lab.50.1429952816035;
        Sat, 25 Apr 2015 02:06:56 -0700 (PDT)
Received: from localhost.localdomain (h38n2-lk-d2.ias.bredband.telia.com. [78.72.191.38])
        by mx.google.com with ESMTPSA id r6sm3249243lbw.10.2015.04.25.02.06.54
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 Apr 2015 02:06:55 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc3.8.g86acfbd
In-Reply-To: <1429952801-2646-1-git-send-email-erik.elfstrom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267782>

read_gitfile will die on most error cases. This makes it unsuitable
for speculative calls. Extract the core logic and provide a gentle
version that returns NULL on failure.

The first usecase of the new gentle version will be to probe for
submodules during git clean.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com>
---
 cache.h |  3 ++-
 setup.c | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++------=
--------
 2 files changed, 67 insertions(+), 18 deletions(-)

diff --git a/cache.h b/cache.h
index 3d3244b..6e29068 100644
--- a/cache.h
+++ b/cache.h
@@ -431,7 +431,8 @@ extern int set_git_dir(const char *path);
 extern const char *get_git_namespace(void);
 extern const char *strip_namespace(const char *namespaced_ref);
 extern const char *get_git_work_tree(void);
-extern const char *read_gitfile(const char *path);
+extern const char *read_gitfile_gently(const char *path, int *return_e=
rror_code);
+#define read_gitfile(path) read_gitfile_gently((path), NULL)
 extern const char *resolve_gitdir(const char *suspect);
 extern void set_git_work_tree(const char *tree);
=20
diff --git a/setup.c b/setup.c
index 979b13f..e1897cc 100644
--- a/setup.c
+++ b/setup.c
@@ -335,35 +335,53 @@ static int check_repository_format_gently(const c=
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
=20
-	if (stat(path, &st))
-		return NULL;
-	if (!S_ISREG(st.st_mode))
-		return NULL;
+	if (stat(path, &st)) {
+		error_code =3D 1;
+		goto cleanup_return;
+	}
+	if (!S_ISREG(st.st_mode)) {
+		error_code =3D 2;
+		goto cleanup_return;
+	}
 	fd =3D open(path, O_RDONLY);
-	if (fd < 0)
-		die_errno("Error opening '%s'", path);
+	if (fd < 0) {
+		error_code =3D 3;
+		goto cleanup_return;
+	}
 	buf =3D xmalloc(st.st_size + 1);
 	len =3D read_in_full(fd, buf, st.st_size);
 	close(fd);
-	if (len !=3D st.st_size)
-		die("Error reading %s", path);
+	if (len !=3D st.st_size) {
+		error_code =3D 4;
+		goto cleanup_return;
+	}
 	buf[len] =3D '\0';
-	if (!starts_with(buf, "gitdir: "))
-		die("Invalid gitfile format: %s", path);
+	if (!starts_with(buf, "gitdir: ")) {
+		error_code =3D 5;
+		goto cleanup_return;
+	}
 	while (buf[len - 1] =3D=3D '\n' || buf[len - 1] =3D=3D '\r')
 		len--;
-	if (len < 9)
-		die("No path in gitfile: %s", path);
+	if (len < 9) {
+		error_code =3D 6;
+		goto cleanup_return;
+	}
 	buf[len] =3D '\0';
 	dir =3D buf + 8;
=20
@@ -378,11 +396,41 @@ const char *read_gitfile(const char *path)
 		buf =3D dir;
 	}
=20
-	if (!is_git_directory(dir))
-		die("Not a git repository: %s", dir);
+	if (!is_git_directory(dir)) {
+		error_code =3D 7;
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
--=20
2.4.0.rc3.8.g4ebd28d
