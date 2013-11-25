From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 18/28] New var GIT_SHALLOW_FILE to propagate --shallow-file to subprocesses
Date: Mon, 25 Nov 2013 10:55:44 +0700
Message-ID: <1385351754-9954-19-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 25 04:53:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VknEl-00027m-L5
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 04:53:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753630Ab3KYDxR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Nov 2013 22:53:17 -0500
Received: from mail-pd0-f176.google.com ([209.85.192.176]:62940 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753599Ab3KYDxP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Nov 2013 22:53:15 -0500
Received: by mail-pd0-f176.google.com with SMTP id w10so4552673pde.7
        for <git@vger.kernel.org>; Sun, 24 Nov 2013 19:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=HM21v4tACpk5c/Q3og0y+FiZn4L/UnrL4ZSF71gjaus=;
        b=qpxZd5GDL7xnA7MBx8ZXbb2GWM72AZrwNecpzfaxStNPlPiobX8oBhnB10uBroHNhG
         IN7TaJA9nVKsXJVEgtGv1TeyleN/7rnlK4cmvq1jfU2xa5WWlP2ezUTXNYprPYszohZ6
         BzuZA4QNGVz1up7GGqMJ7c/TqXaYomKDdTx59bL1tSkr8vBQ05Hwcnx9/jV2vHaWQppU
         H99USkWMHqVDKkjteghdGUyOfS3CByHu8YMaRdnAYHklyS29Jd264mHGBVfdf0ZPeVWv
         wwLz5+xpNigqgGmhk+fSSU1FnNQ7Ei4SoHkKHxHDy24hjV9rCp6CTwzZ97+YCrUr79Yv
         /ZXw==
X-Received: by 10.66.240.4 with SMTP id vw4mr25717945pac.26.1385351595257;
        Sun, 24 Nov 2013 19:53:15 -0800 (PST)
Received: from lanh ([115.73.213.240])
        by mx.google.com with ESMTPSA id wp8sm69714133pbc.26.2013.11.24.19.53.12
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 24 Nov 2013 19:53:14 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 25 Nov 2013 10:57:48 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238289>

This may be needed when a hook is run after a new shallow pack is
received, but .git/shallow is not settled yet. A temporary shallow
file to plug all loose ends should be used instead. GIT_SHALLOW_FILE
is overriden by --shallow-file.

--shallow-file does not work in this case because the hook may spawn
many git subprocesses and the launch commands do not have
--shallow-file as it's a recent addition.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h       | 1 +
 commit.h      | 2 +-
 environment.c | 6 ++++++
 git.c         | 2 +-
 shallow.c     | 4 +++-
 5 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index ce377e1..185d692 100644
--- a/cache.h
+++ b/cache.h
@@ -354,6 +354,7 @@ static inline enum object_type object_type(unsigned=
 int mode)
 #define DB_ENVIRONMENT "GIT_OBJECT_DIRECTORY"
 #define INDEX_ENVIRONMENT "GIT_INDEX_FILE"
 #define GRAFT_ENVIRONMENT "GIT_GRAFT_FILE"
+#define GIT_SHALLOW_FILE_ENVIRONMENT "GIT_SHALLOW_FILE"
 #define TEMPLATE_DIR_ENVIRONMENT "GIT_TEMPLATE_DIR"
 #define CONFIG_ENVIRONMENT "GIT_CONFIG"
 #define CONFIG_DATA_ENVIRONMENT "GIT_CONFIG_PARAMETERS"
diff --git a/commit.h b/commit.h
index 3af4699..0ff70fa 100644
--- a/commit.h
+++ b/commit.h
@@ -202,7 +202,7 @@ extern int is_repository_shallow(void);
 extern struct commit_list *get_shallow_commits(struct object_array *he=
ads,
 		int depth, int shallow_flag, int not_shallow_flag);
 extern void check_shallow_file_for_update(void);
-extern void set_alternate_shallow_file(const char *path);
+extern void set_alternate_shallow_file(const char *path, int override)=
;
 extern int write_shallow_commits(struct strbuf *out, int use_pack_prot=
ocol,
 				 const struct extra_have_objects *extra);
 extern void setup_alternate_shallow(struct lock_file *shallow_lock,
diff --git a/environment.c b/environment.c
index 0a15349..b73b39d 100644
--- a/environment.c
+++ b/environment.c
@@ -10,6 +10,7 @@
 #include "cache.h"
 #include "refs.h"
 #include "fmt-merge-msg.h"
+#include "commit.h"
=20
 int trust_executable_bit =3D 1;
 int trust_ctime =3D 1;
@@ -97,6 +98,7 @@ const char * const local_repo_env[] =3D {
 	INDEX_ENVIRONMENT,
 	NO_REPLACE_OBJECTS_ENVIRONMENT,
 	GIT_PREFIX_ENVIRONMENT,
+	GIT_SHALLOW_FILE_ENVIRONMENT,
 	NULL
 };
=20
@@ -124,6 +126,7 @@ static char *expand_namespace(const char *raw_names=
pace)
 static void setup_git_env(void)
 {
 	const char *gitfile;
+	const char *shallow_file;
=20
 	git_dir =3D getenv(GIT_DIR_ENVIRONMENT);
 	if (!git_dir)
@@ -147,6 +150,9 @@ static void setup_git_env(void)
 		read_replace_refs =3D 0;
 	namespace =3D expand_namespace(getenv(GIT_NAMESPACE_ENVIRONMENT));
 	namespace_len =3D strlen(namespace);
+	shallow_file =3D getenv(GIT_SHALLOW_FILE_ENVIRONMENT);
+	if (shallow_file)
+		set_alternate_shallow_file(shallow_file, 0);
 }
=20
 int is_bare_repository(void)
diff --git a/git.c b/git.c
index cb5208d..179c4f6 100644
--- a/git.c
+++ b/git.c
@@ -162,7 +162,7 @@ static int handle_options(const char ***argv, int *=
argc, int *envchanged)
 		} else if (!strcmp(cmd, "--shallow-file")) {
 			(*argv)++;
 			(*argc)--;
-			set_alternate_shallow_file((*argv)[0]);
+			set_alternate_shallow_file((*argv)[0], 1);
 			if (envchanged)
 				*envchanged =3D 1;
 		} else if (!strcmp(cmd, "-C")) {
diff --git a/shallow.c b/shallow.c
index 1baf6b5..abb04db 100644
--- a/shallow.c
+++ b/shallow.c
@@ -11,10 +11,12 @@ static int is_shallow =3D -1;
 static struct stat shallow_stat;
 static char *alternate_shallow_file;
=20
-void set_alternate_shallow_file(const char *path)
+void set_alternate_shallow_file(const char *path, int override)
 {
 	if (is_shallow !=3D -1)
 		die("BUG: is_repository_shallow must not be called before set_altern=
ate_shallow_file");
+	if (alternate_shallow_file && !override)
+		return;
 	free(alternate_shallow_file);
 	alternate_shallow_file =3D path ? xstrdup(path) : NULL;
 }
--=20
1.8.2.83.gc99314b
