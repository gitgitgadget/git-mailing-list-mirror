From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v1 27/45] Convert run_add_interactive to use struct pathspec
Date: Fri, 15 Mar 2013 13:06:42 +0700
Message-ID: <1363327620-29017-28-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 07:27:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGO79-0006h1-Pv
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 07:27:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061Ab3COG1I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 02:27:08 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:64934 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507Ab3COG1G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 02:27:06 -0400
Received: by mail-ie0-f175.google.com with SMTP id c12so3915241ieb.6
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 23:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=5HdIoFQHqO11qv0zf9JiITO0VI4pCg7QgyT8Q9QYt0M=;
        b=BRNVTIjBc3i7DpEUdrLzbNsq9blgMRhV+rdrCAzBdUr2NCfXuzwLuJ71EG5zE67CDm
         i/aGnxtd5gZg9ycV/Whp+E37nu5s2Y/oOVmDO81iuKSgMZ/aWcYfFCHK6xw/37wb79z+
         sGYKnGDgVN+hBZa0O0zq/jlxfZ8CkSrrQAKCtQ9IabP9xjpmRHbNHyNlbCuEYY/K+nPz
         JNINQJ1lsGwuqEw+Tx3CdbQD3X8Wsq9Ux542gX6jin9lOXZkoIsw000ejMBC6FvBDNp9
         AVM6u/K7Zq9oZrQHSdkPh1RVRCWFfutjKLvTWx5sj4PRcwwB0B4gH2plSHpLgDy2UCPo
         3KnA==
X-Received: by 10.50.209.4 with SMTP id mi4mr490131igc.40.1363328826407;
        Thu, 14 Mar 2013 23:27:06 -0700 (PDT)
Received: from tre ([115.74.58.84])
        by mx.google.com with ESMTPS id ua6sm633796igb.0.2013.03.14.23.27.03
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 23:27:05 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 15 Mar 2013 13:10:08 +0700
X-Mailer: git-send-email 1.8.0.rc0.19.g7bbb31d
In-Reply-To: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218214>

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
index da7282e..7c6e8b6 100644
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
+		       patch_mode ? PATHSPEC_PREFIX_ORIGIN : 0,
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
