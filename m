From: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: [PATCH v6 3/7] setup: sanity check file size in read_gitfile_gently
Date: Sun, 10 May 2015 22:00:37 +0200
Message-ID: <1431288041-21077-4-git-send-email-erik.elfstrom@gmail.com>
References: <1431288041-21077-1-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 10 22:03:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrXRL-00051n-KF
	for gcvg-git-2@plane.gmane.org; Sun, 10 May 2015 22:03:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbbEJUDD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 May 2015 16:03:03 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:36461 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778AbbEJUDB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2015 16:03:01 -0400
Received: by lagv1 with SMTP id v1so81047240lag.3
        for <git@vger.kernel.org>; Sun, 10 May 2015 13:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=bWr4jWmHRiyJfoiqDdadutChG8FNRmVD689vxtX3XK0=;
        b=v2sJ1KKMP9wdMWGIhC3kzs5O7aDrKJC9UQk8XoLtpJAtlY5eWe+5GFHdXmNNCRX46+
         XyeBu7VgnNRQsxwAGHA1+oL29qjmHjhTOgUVF06vE45cdqAf9sjCrVPRW0ZgaZhMrQMt
         jnXDUR6gNApT8ezrDLgQcc7MZA8UpGgdZZjdlOp8lHoazpJ6wPxhTqMvl9K2068KjQHu
         EsSsa+rnA5uxjZJ51RhWl2VNsI9voIqZHdPmGuObuEf16ypzOHyk6Ec7Fw3u36YAGjKs
         IiGz6q19nE6VkE/fhCs/ExaoJBF5uz/6acFgyNt6LIbVmStnlwALwGx9Cjxlv/etEL7l
         mZyA==
X-Received: by 10.112.159.9 with SMTP id wy9mr5480282lbb.120.1431288180021;
        Sun, 10 May 2015 13:03:00 -0700 (PDT)
Received: from localhost.localdomain (h38n2-lk-d2.ias.bredband.telia.com. [78.72.191.38])
        by mx.google.com with ESMTPSA id k15sm2586218laa.28.2015.05.10.13.02.58
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 10 May 2015 13:02:59 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.60.gf7143f7
In-Reply-To: <1431288041-21077-1-git-send-email-erik.elfstrom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268743>

read_gitfile_gently will allocate a buffer to fit the entire file that
should be read. Add a sanity check of the file size before opening to
avoid allocating a potentially huge amount of memory if we come across
a large file that someone happened to name ".git". The limit is set to
a sufficiently unreasonable size that should never be exceeded by a
genuine .git file.

Signed-off-by: Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com>
---
 cache.h | 1 +
 setup.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/cache.h b/cache.h
index 54c902b..7c8abcb 100644
--- a/cache.h
+++ b/cache.h
@@ -452,6 +452,7 @@ extern const char *get_git_work_tree(void);
 #define READ_GITFILE_ERR_NO_PATH 6
 #define READ_GITFILE_ERR_CANT_VERIFY_PATH 7
 #define READ_GITFILE_ERR_NOT_A_REPO 8
+#define READ_GITFILE_ERR_TOO_LARGE 9
 extern const char *read_gitfile_gently(const char *path, int *return_e=
rror_code);
 #define read_gitfile(path) read_gitfile_gently((path), NULL)
 extern const char *resolve_gitdir(const char *suspect);
diff --git a/setup.c b/setup.c
index b919ea6..bfaf4a6 100644
--- a/setup.c
+++ b/setup.c
@@ -381,6 +381,7 @@ static int check_repository_format_gently(const cha=
r *gitdir, int *nongit_ok)
  */
 const char *read_gitfile_gently(const char *path, int *return_error_co=
de)
 {
+	static const int one_MB =3D 1 << 20;
 	int error_code =3D 0;
 	char *buf =3D NULL;
 	char *dir =3D NULL;
@@ -404,6 +405,11 @@ const char *read_gitfile_gently(const char *path, =
int *return_error_code)
 		error_code =3D READ_GITFILE_ERR_OPEN_FAILED;
 		goto cleanup_return;
 	}
+	if (st.st_size > one_MB) {
+		close(fd);
+		error_code =3D READ_GITFILE_ERR_TOO_LARGE;
+		goto cleanup_return;
+	}
 	buf =3D xmalloc(st.st_size + 1);
 	len =3D read_in_full(fd, buf, st.st_size);
 	close(fd);
@@ -463,6 +469,8 @@ cleanup_return:
 			return NULL;
 		case READ_GITFILE_ERR_OPEN_FAILED:
 			die_errno("Error opening '%s'", path);
+		case READ_GITFILE_ERR_TOO_LARGE:
+			die("Too large to be a .git file: '%s'", path);
 		case READ_GITFILE_ERR_READ_FAILED:
 			die("Error reading %s", path);
 		case READ_GITFILE_ERR_INVALID_FORMAT:
--=20
2.4.0.60.gf7143f7
