From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/POC 7/7] init: add --split-repo with the same functionality as git-new-workdir
Date: Wed, 11 Dec 2013 21:15:33 +0700
Message-ID: <1386771333-32574-8-git-send-email-pclouds@gmail.com>
References: <1386771333-32574-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 11 15:11:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqkVi-0007uy-Da
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 15:11:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993Ab3LKOL3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Dec 2013 09:11:29 -0500
Received: from mail-pb0-f54.google.com ([209.85.160.54]:58973 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350Ab3LKOL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 09:11:29 -0500
Received: by mail-pb0-f54.google.com with SMTP id un15so10037461pbc.13
        for <git@vger.kernel.org>; Wed, 11 Dec 2013 06:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=rzGtd8re0QwMe5U7EYWmKuMODetrGb8w01bhQa2N11s=;
        b=DOZVtIgtyift+MIm3kPqwoc2xA5j6S6jrb6mFqDcYmBjVyeJpIshSloVdoW6u67Pl3
         gpH7GVQrkyW7Zf7wxycB0XY+bezRaSVM/l4pU/Syod4t5t4bnN5KF39VMRd/yM5mpP06
         J82Bvtls2XpGeuIQSu/w6uzx7I/MnEgcmlY+V99eHI4uu/odgYa0cFyeyLS8kBbcQGMd
         PlaN5E1qdQl4N/7gqDNAhYUSwytog8ah7MgmaLvEbQbMfgrhoSDaUsKSxJNr0azlBv4R
         3U3nAbuwNyfgoVWLmKsVhzU8FKQf0scb2fFKrjLeLcrDA1whiTJTZQvUb01Yrxq2xHp3
         UTFA==
X-Received: by 10.68.138.226 with SMTP id qt2mr1830831pbb.65.1386771088501;
        Wed, 11 Dec 2013 06:11:28 -0800 (PST)
Received: from lanh ([115.73.201.231])
        by mx.google.com with ESMTPSA id oc9sm2684991pbb.10.2013.12.11.06.11.25
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 11 Dec 2013 06:11:27 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 11 Dec 2013 21:16:17 +0700
X-Mailer: git-send-email 1.8.5.1.77.g42c48fa
In-Reply-To: <1386771333-32574-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239201>

"git init --split-repo abc" will create abc/.git file with the content

gitsuper: `git rev-parse --git-dir`
gitdir: abc

and a new directory in current .git/repos/abc with a valid HEAD.

This is enough to start checking out and do stuff. We should probably
take a branch name and check that branch out though. If that's the
case, this feature may better be parked in "git checkout" instead of
here..

So far it's not any better than git-new-workdir, except that info from
all worktrees created this way is centralized in the super repo's
=2Egit/repos, which makes it possible to ensure what worktree does not
step on one another. In particular:

 - If a worktree updates a ref, we could check if any other worktrees
   are also checking out that ref. Detach those worktrees.

 - prune/gc should be taught about the extra HEADs in .git/repos. fsck
   on the super repo should be taught about extra indexes in
   .git/repos

 - ...

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/init-db.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 78aa387..9c7139a 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -426,6 +426,38 @@ int init_db(const char *template_dir, unsigned int=
 flags)
 	return 0;
 }
=20
+static int create_new_worktree(const char *path)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	const char *name;
+	unsigned char sha1[20];
+	FILE *fp;
+
+	for (name =3D path + strlen(path) - 1; name > path; name--)
+		if (is_dir_sep(*name)) {
+			name++;
+			break;
+		}
+
+	strbuf_addf(&sb, "%s/.git", path);
+	safe_create_leading_directories_const(sb.buf);
+	fp =3D fopen(sb.buf, "w");
+	fprintf(fp, "gitsuper: %s\ngitdir: %s\n",
+		real_path(get_git_dir()), name);
+	fclose(fp);
+	safe_create_leading_directories_const(git_path("repos/%s/HEAD",
+						       name));
+	fp =3D fopen(git_path("repos/%s/HEAD", name), "w");
+	get_sha1("HEAD", sha1);
+	fprintf(fp, "%s\n", sha1_to_hex(sha1));
+	fclose(fp);
+#if 0
+	chdir(path);
+	system("git reset --hard");
+#endif
+	return 0;
+}
+
 static int guess_repository_type(const char *git_dir)
 {
 	char cwd[PATH_MAX];
@@ -481,6 +513,7 @@ int cmd_init_db(int argc, const char **argv, const =
char *prefix)
 	const char *work_tree;
 	const char *template_dir =3D NULL;
 	unsigned int flags =3D 0;
+	int split_repo =3D 0;
 	const struct option init_db_options[] =3D {
 		OPT_STRING(0, "template", &template_dir, N_("template-directory"),
 				N_("directory from which templates will be used")),
@@ -491,6 +524,7 @@ int cmd_init_db(int argc, const char **argv, const =
char *prefix)
 			N_("specify that the git repository is to be shared amongst several=
 users"),
 			PARSE_OPT_OPTARG | PARSE_OPT_NONEG, shared_callback, 0},
 		OPT_BIT('q', "quiet", &flags, N_("be quiet"), INIT_DB_QUIET),
+		OPT_BOOL(0, "split-repo", &split_repo, N_("git-new-workdir")),
 		OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
 			   N_("separate git dir from working tree")),
 		OPT_END()
@@ -498,6 +532,14 @@ int cmd_init_db(int argc, const char **argv, const=
 char *prefix)
=20
 	argc =3D parse_options(argc, argv, prefix, init_db_options, init_db_u=
sage, 0);
=20
+	if (split_repo) {
+		if (real_git_dir)
+			die(_("--split-repo and --separate-git-dir are incompatible"));
+		if (!argv[0])
+			die(_("--split-repo requires a path"));
+		return create_new_worktree(argv[0]);
+	}
+
 	if (real_git_dir && !is_absolute_path(real_git_dir))
 		real_git_dir =3D xstrdup(real_path(real_git_dir));
=20
--=20
1.8.5.1.77.g42c48fa
