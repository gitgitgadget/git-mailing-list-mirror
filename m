From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 24/45] reset: convert to use parse_pathspec
Date: Sun,  9 Jun 2013 13:25:57 +0700
Message-ID: <1370759178-1709-25-git-send-email-pclouds@gmail.com>
References: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 08:27:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlZ69-0000u1-OS
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 08:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752321Ab3FIG10 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 02:27:26 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:48695 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752293Ab3FIG1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 02:27:25 -0400
Received: by mail-pd0-f176.google.com with SMTP id t12so1547993pdi.35
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 23:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=hEvLOik1SCiJ3gkeBVp6VAkqKyk7XOOeq9dWgMdvf98=;
        b=dDRnRgtzfho7eDY3q4wfRx+upblGvu//rhG2tPxlSY1Cwxl2tbPJwfPoZPTSdsSQmS
         iIqMa/tJROvUIzZ/VpzvjOKeWkeBEYZooHMD7JzR4M0O6NTl1ldSi7Erp/BQeU6pLmej
         vKwkSgmTAHl60IGz+Xp2Shx3m8T48jE/oqZr6X090uCrX0CNFbRr48J71A2FuWKQlMZE
         bY8HiN8iDcSqmh1pTQ3saOOXzSz0lJibcVUvmI6AV0zavfxGZ5ziEMoqsvfeIg68WOzd
         LXhF/lZlXEd42hLe3WhKvPTDK7c0ndIbpZJfUE5uRjp2c3fON88k6mgCzQfhpi0+tZ0M
         8Iaw==
X-Received: by 10.66.117.98 with SMTP id kd2mr9037147pab.160.1370759244641;
        Sat, 08 Jun 2013 23:27:24 -0700 (PDT)
Received: from lanh ([115.73.237.130])
        by mx.google.com with ESMTPSA id eq4sm10218344pad.16.2013.06.08.23.27.21
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 23:27:24 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Jun 2013 13:28:56 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226916>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/reset.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 6032131..da7282e 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -171,7 +171,10 @@ static void die_if_unmerged_cache(int reset_type)
=20
 }
=20
-static const char **parse_args(const char **argv, const char *prefix, =
const char **rev_ret)
+static void parse_args(struct pathspec *pathspec,
+		       const char **argv, const char *prefix,
+		       int patch_mode,
+		       const char **rev_ret)
 {
 	const char *rev =3D "HEAD";
 	unsigned char unused[20];
@@ -213,7 +216,10 @@ static const char **parse_args(const char **argv, =
const char *prefix, const char
 		}
 	}
 	*rev_ret =3D rev;
-	return argv[0] ? get_pathspec(prefix, argv) : NULL;
+	parse_pathspec(pathspec,
+		       patch_mode ? PATHSPEC_ALL_MAGIC & ~PATHSPEC_FROMTOP : 0,
+		       PATHSPEC_PREFER_FULL,
+		       prefix, argv);
 }
=20
 static int update_refs(const char *rev, const unsigned char *sha1)
@@ -243,7 +249,7 @@ int cmd_reset(int argc, const char **argv, const ch=
ar *prefix)
 	int patch_mode =3D 0, unborn;
 	const char *rev;
 	unsigned char sha1[20];
-	const char **pathspec =3D NULL;
+	struct pathspec pathspec;
 	const struct option options[] =3D {
 		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
 		OPT_SET_INT(0, "mixed", &reset_type,
@@ -263,13 +269,13 @@ int cmd_reset(int argc, const char **argv, const =
char *prefix)
=20
 	argc =3D parse_options(argc, argv, prefix, options, git_reset_usage,
 						PARSE_OPT_KEEP_DASHDASH);
-	pathspec =3D parse_args(argv, prefix, &rev);
+	parse_args(&pathspec, argv, prefix, patch_mode, &rev);
=20
 	unborn =3D !strcmp(rev, "HEAD") && get_sha1("HEAD", sha1);
 	if (unborn) {
 		/* reset on unborn branch: treat as reset to empty tree */
 		hashcpy(sha1, EMPTY_TREE_SHA1_BIN);
-	} else if (!pathspec) {
+	} else if (!pathspec.nr) {
 		struct commit *commit;
 		if (get_sha1_committish(rev, sha1))
 			die(_("Failed to resolve '%s' as a valid revision."), rev);
@@ -290,13 +296,13 @@ int cmd_reset(int argc, const char **argv, const =
char *prefix)
 	if (patch_mode) {
 		if (reset_type !=3D NONE)
 			die(_("--patch is incompatible with --{hard,mixed,soft}"));
-		return run_add_interactive(sha1_to_hex(sha1), "--patch=3Dreset", pat=
hspec);
+		return run_add_interactive(sha1_to_hex(sha1), "--patch=3Dreset", pat=
hspec.raw);
 	}
=20
 	/* git reset tree [--] paths... can be used to
 	 * load chosen paths from the tree into the index without
 	 * affecting the working tree nor HEAD. */
-	if (pathspec) {
+	if (pathspec.nr) {
 		if (reset_type =3D=3D MIXED)
 			warning(_("--mixed with paths is deprecated; use 'git reset -- <pat=
hs>' instead."));
 		else if (reset_type !=3D NONE)
@@ -323,7 +329,7 @@ int cmd_reset(int argc, const char **argv, const ch=
ar *prefix)
 		struct lock_file *lock =3D xcalloc(1, sizeof(struct lock_file));
 		int newfd =3D hold_locked_index(lock, 1);
 		if (reset_type =3D=3D MIXED) {
-			if (read_from_tree(pathspec, sha1))
+			if (read_from_tree(pathspec.raw, sha1))
 				return 1;
 		} else {
 			int err =3D reset_index(sha1, reset_type, quiet);
@@ -344,7 +350,7 @@ int cmd_reset(int argc, const char **argv, const ch=
ar *prefix)
 			die(_("Could not write new index file."));
 	}
=20
-	if (!pathspec && !unborn) {
+	if (!pathspec.nr && !unborn) {
 		/* Any resets without paths update HEAD to the head being
 		 * switched to, saving the previous head in ORIG_HEAD before. */
 		update_ref_status =3D update_refs(rev, sha1);
@@ -352,7 +358,7 @@ int cmd_reset(int argc, const char **argv, const ch=
ar *prefix)
 		if (reset_type =3D=3D HARD && !update_ref_status && !quiet)
 			print_new_head_line(lookup_commit_reference(sha1));
 	}
-	if (!pathspec)
+	if (!pathspec.nr)
 		remove_branch_state();
=20
 	return update_ref_status;
--=20
1.8.2.83.gc99314b
