From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 27/45] Convert run_add_interactive to use struct pathspec
Date: Wed, 20 Mar 2013 19:16:18 +0700
Message-ID: <1363781779-14947-6-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
 <1363781779-14947-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 20 13:17:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIHxO-0003WC-L2
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 13:17:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933813Ab3CTMQ6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Mar 2013 08:16:58 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:33046 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933759Ab3CTMQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 08:16:57 -0400
Received: by mail-pb0-f41.google.com with SMTP id um15so1319340pbc.14
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 05:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=5Y60wY+7Da5og3EA66Uou92OPtxRVQKPDJl6p9SYcC8=;
        b=zy0q9n6pZX5JsnkwrEfDirGJBk1JLAUOzD6KXKbBzziZ38mXAS5BxZ3yK5z+AEjFzk
         mw7PqRYL8iFJWUNVddFmj3RMOkhiSEdu/ZuvAAGbGKYAo1+Z/XgeU5XjvmCDwFlWls5v
         ka3gEhrdhhPXNtCEaxrjuSE9nF1AnGtwcOXsB6jN7FVWRbzVbR3lB9u7LSvAxeiYrQ/x
         xsZiD37Yr+5mp2mpUQkfLc2OgFSbY0YdJ5J895/3silJqIxWAVrES0pAZ/j1H/6P/s/q
         K3M2xMyXY/Wonzzp5NocZ/1ETKMNyLv9SpNHR3W90Niwsna1nTWU/tzOtUUMXYMdjRf1
         Iv7g==
X-Received: by 10.68.136.138 with SMTP id qa10mr8617657pbb.20.1363781817369;
        Wed, 20 Mar 2013 05:16:57 -0700 (PDT)
Received: from lanh ([115.74.40.216])
        by mx.google.com with ESMTPS id wi7sm2073398pac.9.2013.03.20.05.16.54
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 20 Mar 2013 05:16:56 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 20 Mar 2013 19:16:52 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1363781779-14947-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218593>

This passes the pathspec, more or less unmodified, to
git-add--interactive. The command itself does not process pathspec. It
simply passes the pathspec to other builtin commands. So if all those
commands support pathspec, we're good.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/add.c      | 26 ++++++++++----------------
 builtin/checkout.c |  9 ++++-----
 builtin/reset.c    |  8 ++++----
 commit.h           |  2 +-
 4 files changed, 19 insertions(+), 26 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index ec6fbe3..2b20d7d 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -139,16 +139,12 @@ static void refresh(int verbose, const char **pat=
hspec)
 }
=20
 int run_add_interactive(const char *revision, const char *patch_mode,
-			const char **pathspec)
+			const struct pathspec *pathspec)
 {
-	int status, ac, pc =3D 0;
+	int status, ac, i;
 	const char **args;
=20
-	if (pathspec)
-		while (pathspec[pc])
-			pc++;
-
-	args =3D xcalloc(sizeof(const char *), (pc + 5));
+	args =3D xcalloc(sizeof(const char *), (pathspec->nr + 6));
 	ac =3D 0;
 	args[ac++] =3D "add--interactive";
 	if (patch_mode)
@@ -156,11 +152,9 @@ int run_add_interactive(const char *revision, cons=
t char *patch_mode,
 	if (revision)
 		args[ac++] =3D revision;
 	args[ac++] =3D "--";
-	if (pc) {
-		memcpy(&(args[ac]), pathspec, sizeof(const char *) * pc);
-		ac +=3D pc;
-	}
-	args[ac] =3D NULL;
+	for (i =3D 0; i < pathspec->nr; i++)
+		/* pass original pathspec, to be re-parsed */
+		args[ac++] =3D pathspec->items[i].original;
=20
 	status =3D run_command_v_opt(args, RUN_GIT_CMD);
 	free(args);
@@ -175,17 +169,17 @@ int interactive_add(int argc, const char **argv, =
const char *prefix, int patch)
 	 * git-add--interactive itself does not parse pathspec. It
 	 * simply passes the pathspec to other builtin commands. Let's
 	 * hope all of them support all magic, or we'll need to limit
-	 * the magic here. There is still a problem with prefix. But
-	 * that'll be worked on later on.
+	 * the magic here.
 	 */
 	parse_pathspec(&pathspec, PATHSPEC_ALL_MAGIC & ~PATHSPEC_FROMTOP,
 		       PATHSPEC_PREFER_FULL |
-		       PATHSPEC_SYMLINK_LEADING_PATH,
+		       PATHSPEC_SYMLINK_LEADING_PATH |
+		       PATHSPEC_PREFIX_ORIGIN,
 		       prefix, argv);
=20
 	return run_add_interactive(NULL,
 				   patch ? "--patch" : NULL,
-				   pathspec.raw);
+				   &pathspec);
 }
=20
 static int edit_patch(int argc, const char **argv, const char *prefix)
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 3c19cb4..2ddff95 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -256,7 +256,7 @@ static int checkout_paths(const struct checkout_opt=
s *opts,
=20
 	if (opts->patch_mode)
 		return run_add_interactive(revision, "--patch=3Dcheckout",
-					   opts->pathspec.raw);
+					   &opts->pathspec);
=20
 	lock_file =3D xcalloc(1, sizeof(struct lock_file));
=20
@@ -1115,10 +1115,9 @@ int cmd_checkout(int argc, const char **argv, co=
nst char *prefix)
 		 * cannot handle. Magic mask is pretty safe to be
 		 * lifted for new magic when opts.patch_mode =3D=3D 0.
 		 */
-		parse_pathspec(&opts.pathspec,
-			       opts.patch_mode =3D=3D 0 ? 0 :
-			       (PATHSPEC_ALL_MAGIC & ~PATHSPEC_FROMTOP),
-			       0, prefix, argv);
+		parse_pathspec(&opts.pathspec, 0,
+			       opts.patch_mode ? PATHSPEC_PREFIX_ORIGIN : 0,
+			       prefix, argv);
=20
 		if (!opts.pathspec.nr)
 			die(_("invalid path specification"));
diff --git a/builtin/reset.c b/builtin/reset.c
index da7282e..1c8e4a5 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -216,9 +216,9 @@ static void parse_args(struct pathspec *pathspec,
 		}
 	}
 	*rev_ret =3D rev;
-	parse_pathspec(pathspec,
-		       patch_mode ? PATHSPEC_ALL_MAGIC & ~PATHSPEC_FROMTOP : 0,
-		       PATHSPEC_PREFER_FULL,
+	parse_pathspec(pathspec, 0,
+		       PATHSPEC_PREFER_FULL |
+		       (patch_mode ? PATHSPEC_PREFIX_ORIGIN : 0),
 		       prefix, argv);
 }
=20
@@ -296,7 +296,7 @@ int cmd_reset(int argc, const char **argv, const ch=
ar *prefix)
 	if (patch_mode) {
 		if (reset_type !=3D NONE)
 			die(_("--patch is incompatible with --{hard,mixed,soft}"));
-		return run_add_interactive(sha1_to_hex(sha1), "--patch=3Dreset", pat=
hspec.raw);
+		return run_add_interactive(sha1_to_hex(sha1), "--patch=3Dreset", &pa=
thspec);
 	}
=20
 	/* git reset tree [--] paths... can be used to
diff --git a/commit.h b/commit.h
index 4138bb4..9448fda 100644
--- a/commit.h
+++ b/commit.h
@@ -179,7 +179,7 @@ int in_merge_bases(struct commit *, struct commit *=
);
=20
 extern int interactive_add(int argc, const char **argv, const char *pr=
efix, int patch);
 extern int run_add_interactive(const char *revision, const char *patch=
_mode,
-			       const char **pathspec);
+			       const struct pathspec *pathspec);
=20
 static inline int single_parent(struct commit *commit)
 {
--=20
1.8.0.rc0.19.g7bbb31d
