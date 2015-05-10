From: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: [PATCH v6 1/7] setup: add gentle version of is_git_directory
Date: Sun, 10 May 2015 22:00:35 +0200
Message-ID: <1431288041-21077-2-git-send-email-erik.elfstrom@gmail.com>
References: <1431288041-21077-1-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 10 22:02:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrXQn-0004lk-Hj
	for gcvg-git-2@plane.gmane.org; Sun, 10 May 2015 22:02:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbbEJUCb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 May 2015 16:02:31 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:35175 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534AbbEJUCa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2015 16:02:30 -0400
Received: by lbbuc2 with SMTP id uc2so81511721lbb.2
        for <git@vger.kernel.org>; Sun, 10 May 2015 13:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ft698WcskEHdqzIl/nnUOWMINW42ksd2z1hnEgY89bI=;
        b=xElSQZl5o9RKFr50iIoj0ugD+HYUhiVzhyoO2oz5drpsc5ZIwP7V39koCCN3czKB6x
         Pa0XL/fWn5U1l+7/FY1S3YXmNiJFXAbJUZoBQ2kcpkC+yjB1tta3vPnk8759QXJ4k4ys
         2oSprZJBcKCL76xIt/dxcQsnL41sQ8ql1FbtvpcwBjkWtUgQw+bOiXTXZKj7Eh1MNw88
         vo4NDmyph4SLMmxjWjvyN3CVZEltGVHaHhknUltsUevAV4ip6nXrz4r0E5+FBONBggT2
         Z2cB4XtDnJHDUf34eYy4SAk6sD5HMCCFm2+uCjg1OHFTinwuHlfL9ATF3WYPnsPq780B
         RzMQ==
X-Received: by 10.152.5.39 with SMTP id p7mr5617257lap.18.1431288148333;
        Sun, 10 May 2015 13:02:28 -0700 (PDT)
Received: from localhost.localdomain (h38n2-lk-d2.ias.bredband.telia.com. [78.72.191.38])
        by mx.google.com with ESMTPSA id k15sm2586218laa.28.2015.05.10.13.02.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 10 May 2015 13:02:27 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.60.gf7143f7
In-Reply-To: <1431288041-21077-1-git-send-email-erik.elfstrom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268740>

This is a prerequisite for implementing a gentle version of
read_gitfile.

Signed-off-by: Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com>
---
 cache.h |  4 ++++
 setup.c | 44 +++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index b34447f..dd67695 100644
--- a/cache.h
+++ b/cache.h
@@ -431,7 +431,11 @@ extern int is_inside_git_dir(void);
 extern char *git_work_tree_cfg;
 extern int is_inside_work_tree(void);
 extern const char *get_git_dir(void);
+
+#define IS_GIT_DIRECTORY_ERR_PATH_TOO_LONG 1
+extern int is_git_directory_gently(const char *path, int *return_err, =
struct strbuf *err_msg);
 extern int is_git_directory(const char *path);
+
 extern char *get_object_directory(void);
 extern char *get_index_file(void);
 extern char *get_graft_file(void);
diff --git a/setup.c b/setup.c
index 979b13f..62ee88c 100644
--- a/setup.c
+++ b/setup.c
@@ -224,6 +224,18 @@ void verify_non_filename(const char *prefix, const=
 char *arg)
 	    "'git <command> [<revision>...] -- [<file>...]'", arg);
 }
=20
+__attribute((format (printf,4,5)))
+static void set_error(int *return_err, struct strbuf *err_msg, int err=
,
+		      const char *msg, ...)
+{
+	va_list params;
+	va_start(params, msg);
+	if (err_msg)
+		strbuf_vaddf(err_msg, msg, params);
+	va_end(params);
+	if (return_err)
+		*return_err =3D err;
+}
=20
 /*
  * Test if it looks like we're at a git directory.
@@ -235,14 +247,28 @@ void verify_non_filename(const char *prefix, cons=
t char *arg)
  *  - either a HEAD symlink or a HEAD file that is formatted as
  *    a proper "ref:", or a regular file HEAD that has a properly
  *    formatted sha1 object name.
+ *
+ * In the event of an error, return_err will be set to an error code
+ * and err_msg will be set to an error message describing the error
+ * and 0 will be returned. If no error reporting is required, pass
+ * NULL for return_err and/or err_msg.
  */
-int is_git_directory(const char *suspect)
+int is_git_directory_gently(const char *suspect, int *return_err,
+			    struct strbuf *err_msg)
 {
 	char path[PATH_MAX];
 	size_t len =3D strlen(suspect);
=20
-	if (PATH_MAX <=3D len + strlen("/objects"))
-		die("Too long path: %.*s", 60, suspect);
+	if (return_err)
+		*return_err =3D 0;
+
+	if (PATH_MAX <=3D len + strlen("/objects")) {
+		set_error(return_err, err_msg,
+			  IS_GIT_DIRECTORY_ERR_PATH_TOO_LONG,
+			  "Too long path: %.*s", 60, suspect);
+		return 0;
+	}
+
 	strcpy(path, suspect);
 	if (getenv(DB_ENVIRONMENT)) {
 		if (access(getenv(DB_ENVIRONMENT), X_OK))
@@ -265,6 +291,18 @@ int is_git_directory(const char *suspect)
 	return 1;
 }
=20
+int is_git_directory(const char *suspect)
+{
+	int err;
+	int ret;
+	struct strbuf err_msg =3D STRBUF_INIT;
+	ret =3D is_git_directory_gently(suspect, &err, &err_msg);
+	if (err)
+		die("%s", err_msg.buf);
+	/* No need to free err_msg, will only be touched in case of error */
+	return ret;
+}
+
 int is_inside_git_dir(void)
 {
 	if (inside_git_dir < 0)
--=20
2.4.0.60.gf7143f7
