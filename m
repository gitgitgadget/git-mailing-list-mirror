From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 27/46] Convert run_add_interactive to use struct pathspec
Date: Sun, 14 Jul 2013 15:35:50 +0700
Message-ID: <1373790969-13000-28-git-send-email-pclouds@gmail.com>
References: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 14 10:39:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyHpe-0002gf-6N
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 10:39:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394Ab3GNIi6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jul 2013 04:38:58 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:44343 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383Ab3GNIi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 04:38:57 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so10286451pbc.21
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 01:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=6UIXgbNZ6tbekiHkDDGdxovmWMY0S6bfwpToMgbECNU=;
        b=Sef3Mx3PjeFjvcbtq94YrCDeQs3ZSHWwTlTcE1J2Yv1JoAXCJVikRjEP4eCJrZl/4y
         crYJrfpWEcCuyOVJ28Kin8aMUyziI2wVYG1c2V1CHUwVGAHT010VJuxBAGy2jMAs87en
         m7giXGYvgcFJm/TWStaIbZyeG8/yRu7o3pFNsbJRtQwofv7F178rpC2IiSQ0RrGyWc0U
         5QP1lCQEJsVWoRRWpyz+vID2usvfmg1b/6aL6g5KnTxSQFVB9sVuZtwLf+Squ4dK1cdf
         szz0W+VEpKD0YcQ40o6kgg4yZNTvD+DzGKtr+Ird/5DQ/nmACC6Zt89fgiUcYfGfj/XJ
         DFgg==
X-Received: by 10.68.103.131 with SMTP id fw3mr22533229pbb.65.1373791137067;
        Sun, 14 Jul 2013 01:38:57 -0700 (PDT)
Received: from lanh ([115.73.210.100])
        by mx.google.com with ESMTPSA id zf3sm23165642pac.9.2013.07.14.01.38.54
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 01:38:56 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 14 Jul 2013 15:39:08 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230339>

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
index 9a7235e..d039fc9 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -244,16 +244,12 @@ static void refresh(int verbose, const char **pat=
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
@@ -261,11 +257,9 @@ int run_add_interactive(const char *revision, cons=
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
@@ -280,17 +274,17 @@ int interactive_add(int argc, const char **argv, =
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
index 2f0fb8d..5d31767 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -257,7 +257,7 @@ static int checkout_paths(const struct checkout_opt=
s *opts,
=20
 	if (opts->patch_mode)
 		return run_add_interactive(revision, "--patch=3Dcheckout",
-					   opts->pathspec.raw);
+					   &opts->pathspec);
=20
 	lock_file =3D xcalloc(1, sizeof(struct lock_file));
=20
@@ -1159,10 +1159,9 @@ int cmd_checkout(int argc, const char **argv, co=
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
index 313b296..9bef869 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -219,9 +219,9 @@ static void parse_args(struct pathspec *pathspec,
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
@@ -299,7 +299,7 @@ int cmd_reset(int argc, const char **argv, const ch=
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
index 4d452dc..1f1350c 100644
--- a/commit.h
+++ b/commit.h
@@ -194,7 +194,7 @@ int in_merge_bases_many(struct commit *, int, struc=
t commit **);
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
1.8.2.83.gc99314b
