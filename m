From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 21/31] use new wrapper write_file() for simple file writing
Date: Sun, 13 Jul 2014 11:50:58 +0700
Message-ID: <1405227068-25506-22-git-send-email-pclouds@gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
 <1405227068-25506-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 13 06:55:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6Bob-00014H-5C
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 06:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752961AbaGMEzF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jul 2014 00:55:05 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:39743 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752939AbaGMEzC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 00:55:02 -0400
Received: by mail-pa0-f41.google.com with SMTP id fb1so3623982pad.28
        for <git@vger.kernel.org>; Sat, 12 Jul 2014 21:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=uHp55lMZQ2KLu4GTDXcL4BY4cIMtUlbew/bb1AhrmVc=;
        b=Cc3WG0vsjg7eVX3Vb9pwllfY5dgsVob1qq4WEyTpDPrF32JSe7GkMVxXbAV06LK0Kq
         T6VXwe8v6DLCjOz2AbUb22Rb5tXTCUhlG7PDK6SrKz+85Hx9ps9g3zXFl7qYluVhoUql
         uGge1OE3bjDwz4ZJK6aT4me5j8uhsf1RTN6j5fTq3V6gQ7foDIur3YBgI78fqLdbVw3c
         ghZDBnaqRixkLhUfOHK/2eQWviR5v3LO8f4NT+Ym3t2Gvvr4woYmFv1CSSPtK6xDNrTW
         hpkKVYrcTSP+MrCS1+kHFzk4axzaZz5vONFpwuC4ds8W5wtCJpuPRBSVsJkQRSw7fGEA
         mkjQ==
X-Received: by 10.66.220.169 with SMTP id px9mr8648099pac.79.1405227302307;
        Sat, 12 Jul 2014 21:55:02 -0700 (PDT)
Received: from lanh ([115.73.227.1])
        by mx.google.com with ESMTPSA id op6sm9077596pdb.71.2014.07.12.21.54.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jul 2014 21:55:01 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jul 2014 11:55:02 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1405227068-25506-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253424>

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
index 0591b22..e4265a1 100644
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
index 56f85e2..ce8416a 100644
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
index 1eb6631..dd638a9 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1094,15 +1094,6 @@ static struct credentials *prepare_credentials(c=
onst char *user_name,
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
@@ -1313,7 +1304,7 @@ int main(int argc, char **argv)
 		sanitize_stdfds();
=20
 	if (pid_file)
-		store_pid(pid_file);
+		write_file(pid_file, 1, "%"PRIuMAX"\n", (uintmax_t) getpid());
=20
 	/* prepare argv for serving-processes */
 	cld_argv =3D xmalloc(sizeof (char *) * (argc + 2));
diff --git a/submodule.c b/submodule.c
index b80ecac..b7b6059 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1112,16 +1112,11 @@ void connect_work_tree_and_git_dir(const char *=
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
index 59c9727..1b779bb 100644
--- a/transport.c
+++ b/transport.c
@@ -296,7 +296,6 @@ static int write_one_ref(const char *name, const un=
signed char *sha1,
 {
 	struct strbuf *buf =3D data;
 	int len =3D buf->len;
-	FILE *f;
=20
 	/* when called via for_each_ref(), flags is non-zero */
 	if (flags && !starts_with(name, "refs/heads/") &&
@@ -305,10 +304,9 @@ static int write_one_ref(const char *name, const u=
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
1.9.1.346.ga2b5940
