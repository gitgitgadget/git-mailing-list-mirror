From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 20/27] use new wrapper write_file() for simple file writing
Date: Sat,  1 Mar 2014 19:12:56 +0700
Message-ID: <1393675983-3232-21-git-send-email-pclouds@gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
 <1393675983-3232-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 13:24:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJixR-00034G-Fh
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 13:23:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753120AbaCAMXu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Mar 2014 07:23:50 -0500
Received: from mail-pd0-f172.google.com ([209.85.192.172]:45727 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752899AbaCAMWw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 07:22:52 -0500
Received: by mail-pd0-f172.google.com with SMTP id p10so1857955pdj.17
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 04:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=BrWYlENfT3Rltg4LQPMiv2Ls2kQqBfnnzaniHwuK3+k=;
        b=W6EmSyOuAl8ovfGPVTQo2l6dQXe6PybW9zMKuLXdpWeT38dhUymYS6duYz0o0zFi5G
         HdF2EBVa7uzMc9OXAsCoatC5/jxEZaisxlYXvjEVMn9WV2GCHhIfeIJQqWb5aLxRB+69
         bytAVyRaHKIcrc8Ndmw2MdkXj6ptbgYvi/2WXwVQyVNr6RCa+YTJhog12J6NAGCteEdF
         riAGejTfudmM07yw3h+M4aUN3GpwxpQbTQFXQhoyajobZqlW/NGeJ/35IrFdN2A3/Jyz
         oGtM7FPJGFwLKMmKbasnAY15znpwaOlqHoO/KeJEGOIJCcXWco0CZpV1fVQpinauY+wd
         Wgdg==
X-Received: by 10.68.231.35 with SMTP id td3mr9094763pbc.137.1393676572473;
        Sat, 01 Mar 2014 04:22:52 -0800 (PST)
Received: from lanh ([115.73.238.45])
        by mx.google.com with ESMTPSA id q7sm15916492pbc.20.2014.03.01.04.22.49
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 01 Mar 2014 04:22:51 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 01 Mar 2014 19:23:17 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243093>

This fixes common problems in these code about error handling,
forgetting to close the file handle after fprintf() fails, or not
printing out the error string..

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/branch.c  |  4 +---
 builtin/init-db.c |  7 +------
 daemon.c          | 11 +----------
 submodule.c       |  9 ++-------
 transport.c       |  8 +++-----
 5 files changed, 8 insertions(+), 31 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index b4d7716..3eebdbc 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -754,7 +754,6 @@ static const char edit_description[] =3D "BRANCH_DE=
SCRIPTION";
=20
 static int edit_branch_description(const char *branch_name)
 {
-	FILE *fp;
 	int status;
 	struct strbuf buf =3D STRBUF_INIT;
 	struct strbuf name =3D STRBUF_INIT;
@@ -767,8 +766,7 @@ static int edit_branch_description(const char *bran=
ch_name)
 		    "  %s\n"
 		    "Lines starting with '%c' will be stripped.\n",
 		    branch_name, comment_line_char);
-	fp =3D fopen(git_path(edit_description), "w");
-	if ((fwrite(buf.buf, 1, buf.len, fp) < buf.len) || fclose(fp)) {
+	if (write_file(git_path(edit_description), 0, "%s", buf.buf)) {
 		strbuf_release(&buf);
 		return error(_("could not write branch description template: %s"),
 			     strerror(errno));
diff --git a/builtin/init-db.c b/builtin/init-db.c
index c7c76bb..081e512 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -342,7 +342,6 @@ int set_git_dir_init(const char *git_dir, const cha=
r *real_git_dir,
 static void separate_git_dir(const char *git_dir)
 {
 	struct stat st;
-	FILE *fp;
=20
 	if (!stat(git_link, &st)) {
 		const char *src;
@@ -358,11 +357,7 @@ static void separate_git_dir(const char *git_dir)
 			die_errno(_("unable to move %s to %s"), src, git_dir);
 	}
=20
-	fp =3D fopen(git_link, "w");
-	if (!fp)
-		die(_("Could not create git link %s"), git_link);
-	fprintf(fp, "gitdir: %s\n", git_dir);
-	fclose(fp);
+	write_file(git_link, 1, "gitdir: %s\n", git_dir);
 }
=20
 int init_db(const char *template_dir, unsigned int flags)
diff --git a/daemon.c b/daemon.c
index 503e039..b880d30 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1122,15 +1122,6 @@ static void daemonize(void)
 }
 #endif
=20
-static void store_pid(const char *path)
-{
-	FILE *f =3D fopen(path, "w");
-	if (!f)
-		die_errno("cannot open pid file '%s'", path);
-	if (fprintf(f, "%"PRIuMAX"\n", (uintmax_t) getpid()) < 0 || fclose(f)=
 !=3D 0)
-		die_errno("failed to write pid file '%s'", path);
-}
-
 static int serve(struct string_list *listen_addr, int listen_port,
     struct credentials *cred)
 {
@@ -1339,7 +1330,7 @@ int main(int argc, char **argv)
 		sanitize_stdfds();
=20
 	if (pid_file)
-		store_pid(pid_file);
+		write_file(pid_file, 1, "%"PRIuMAX"\n", (uintmax_t) getpid());
=20
 	/* prepare argv for serving-processes */
 	cld_argv =3D xmalloc(sizeof (char *) * (argc + 2));
diff --git a/submodule.c b/submodule.c
index 613857e..fe5748d 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1135,16 +1135,11 @@ void connect_work_tree_and_git_dir(const char *=
work_tree, const char *git_dir)
 	struct strbuf file_name =3D STRBUF_INIT;
 	struct strbuf rel_path =3D STRBUF_INIT;
 	const char *real_work_tree =3D xstrdup(real_path(work_tree));
-	FILE *fp;
=20
 	/* Update gitfile */
 	strbuf_addf(&file_name, "%s/.git", work_tree);
-	fp =3D fopen(file_name.buf, "w");
-	if (!fp)
-		die(_("Could not create git link %s"), file_name.buf);
-	fprintf(fp, "gitdir: %s\n", relative_path(git_dir, real_work_tree,
-						  &rel_path));
-	fclose(fp);
+	write_file(file_name.buf, 1, "gitdir: %s\n",
+		   relative_path(git_dir, real_work_tree, &rel_path));
=20
 	/* Update core.worktree setting */
 	strbuf_reset(&file_name);
diff --git a/transport.c b/transport.c
index ca7bb44..2df8a15 100644
--- a/transport.c
+++ b/transport.c
@@ -294,7 +294,6 @@ static int write_one_ref(const char *name, const un=
signed char *sha1,
 {
 	struct strbuf *buf =3D data;
 	int len =3D buf->len;
-	FILE *f;
=20
 	/* when called via for_each_ref(), flags is non-zero */
 	if (flags && !starts_with(name, "refs/heads/") &&
@@ -303,10 +302,9 @@ static int write_one_ref(const char *name, const u=
nsigned char *sha1,
=20
 	strbuf_addstr(buf, name);
 	if (safe_create_leading_directories(buf->buf) ||
-			!(f =3D fopen(buf->buf, "w")) ||
-			fprintf(f, "%s\n", sha1_to_hex(sha1)) < 0 ||
-			fclose(f))
-		return error("problems writing temporary file %s", buf->buf);
+	    write_file(buf->buf, 0, "%s\n", sha1_to_hex(sha1)))
+		return error("problems writing temporary file %s: %s",
+			     buf->buf, strerror(errno));
 	strbuf_setlen(buf, len);
 	return 0;
 }
--=20
1.9.0.40.gaa8c3ea
