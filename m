From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/3] checkout: reorder option handling
Date: Tue, 28 Aug 2012 20:49:07 +0700
Message-ID: <1346161748-25651-3-git-send-email-pclouds@gmail.com>
References: <7vr4qroel6.fsf@alter.siamese.dyndns.org>
 <1346161748-25651-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 28 15:56:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6MHD-0007pG-H3
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 15:56:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547Ab2H1N4H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Aug 2012 09:56:07 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51758 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414Ab2H1Nzk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Aug 2012 09:55:40 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so9402403pbb.19
        for <git@vger.kernel.org>; Tue, 28 Aug 2012 06:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=BpvYz6pstO4/FZ6gb9hHAYZNdT3RV44mJthOHvr+tPQ=;
        b=zaNAJlq9z3WMq2zmEX3Eh0hsPs92D9WUDUZlvUpOCtEV7O+6gt0H2acRpJqWQq2Sqi
         sdsGRPnGPXxo2+qii00aCSM+bhTH+76SByrjpihrkfyVpnmEpMKFcJA1zmI8qTmp0P3V
         +l7/Udq8bSpj4tnMp+7Q2wc8LinQSfb1HpSknga8cM7gfbPgL5kJxMReXXixDLkwKEE5
         mHLU8mvnxwqm4FSo+R9CtWUCV9/Ndw8ZET0RjrgBaJsWg69MRzje0U8IVtu7GD2SKUqw
         Iu1vqkpNh38rI15cc0RJSjAm9xsQ63S9Be7pxWYKaMUiDHYFOdv341wp48UyfNu0KWbc
         D99A==
Received: by 10.68.217.69 with SMTP id ow5mr42612476pbc.35.1346162140320;
        Tue, 28 Aug 2012 06:55:40 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.35.79])
        by mx.google.com with ESMTPS id kp3sm17074540pbc.64.2012.08.28.06.55.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 28 Aug 2012 06:55:39 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 28 Aug 2012 20:49:27 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1346161748-25651-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204426>

checkout operates in three different modes. On top of that it tries to
be smart by guessing the branch name for switching. This results in
messy option handling code. This patch reorders it so:

 - easy option handling comes first
 - the big chunk of branch name guessing comes next
 - mode detection comes last. Once the mode is known, check again to
   see if users specify any incompatible options
 - the actual action is done

Another slight improvement is always print branch name (or commit
name) when printing errors related ot them. This helps catch the case
where an option is mistaken as branch/commit.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c | 153 +++++++++++++++++++++++++++++++--------------=
--------
 1 file changed, 89 insertions(+), 64 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 3e3f086..3f1a436 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -760,8 +760,7 @@ static int git_checkout_config(const char *var, con=
st char *value, void *cb)
 	return git_xmerge_config(var, value, NULL);
 }
=20
-static int interactive_checkout(const char *revision, const char **pat=
hspec,
-				struct checkout_opts *opts)
+static int interactive_checkout(const char *revision, const char **pat=
hspec)
 {
 	return run_add_interactive(revision, "--patch=3Dcheckout", pathspec);
 }
@@ -937,6 +936,7 @@ int cmd_checkout(int argc, const char **argv, const=
 char *prefix)
 	char *conflict_style =3D NULL;
 	int patch_mode =3D 0;
 	int dwim_new_local_branch =3D 1;
+	const char **pathspec =3D NULL;
 	struct option options[] =3D {
 		OPT__QUIET(&opts.quiet, "suppress progress reporting"),
 		OPT_STRING('b', NULL, &opts.new_branch, "branch",
@@ -976,23 +976,45 @@ int cmd_checkout(int argc, const char **argv, con=
st char *prefix)
 	argc =3D parse_options(argc, argv, prefix, options, checkout_usage,
 			     PARSE_OPT_KEEP_DASHDASH);
=20
-	/* we can assume from now on new_branch =3D !new_branch_force */
-	if (opts.new_branch && opts.new_branch_force)
-		die(_("-B cannot be used with -b"));
-
-	/* copy -B over to -b, so that we can just check the latter */
-	if (opts.new_branch_force)
-		opts.new_branch =3D opts.new_branch_force;
-
-	if (patch_mode && (opts.track > 0 || opts.new_branch
-			   || opts.new_branch_log || opts.merge || opts.force
-			   || opts.force_detach))
-		die (_("--patch is incompatible with all other options"));
-
+	/* Easy mode-independent incompatible checks */
 	if (opts.force_detach && (opts.new_branch || opts.new_orphan_branch))
 		die(_("--detach cannot be used with -b/-B/--orphan"));
 	if (opts.force_detach && 0 < opts.track)
 		die(_("--detach cannot be used with -t"));
+	if (opts.force && opts.merge)
+		die(_("git checkout: -f and -m are incompatible"));
+
+	if (conflict_style) {
+		opts.merge =3D 1; /* implied */
+		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
+	}
+
+	/*
+	 * opts.new_branch calculation, it could be from -b or -B or
+	 * --track or --orphan or other command line arguments.
+	 *
+	 * The following code until new branch validation should not
+	 * update any fields in opts but opts.new_branch.
+	 */
+	if (opts.new_branch_force) {
+		/* we can assume from now on new_branch =3D !new_branch_force */
+		if (opts.new_branch)
+			die(_("New branch '%s' is already specified by other options"),
+			    opts.new_branch);
+
+		/* copy -B over to -b, so that we can just check the latter */
+		if (opts.new_branch_force)
+			opts.new_branch =3D opts.new_branch_force;
+	}
+
+	if (opts.new_orphan_branch) {
+		if (opts.track > 0)
+			die(_("--orphan cannot be used with -t"));
+		if (opts.new_branch)
+			die(_("New branch '%s' is already specified by other options"),
+			    opts.new_branch);
+		opts.new_branch =3D opts.new_orphan_branch;
+	}
=20
 	/* --track without -b should DWIM */
 	if (0 < opts.track && !opts.new_branch) {
@@ -1009,22 +1031,6 @@ int cmd_checkout(int argc, const char **argv, co=
nst char *prefix)
 		opts.new_branch =3D argv0 + 1;
 	}
=20
-	if (opts.new_orphan_branch) {
-		if (opts.new_branch)
-			die(_("--orphan and -b|-B are mutually exclusive"));
-		if (opts.track > 0)
-			die(_("--orphan cannot be used with -t"));
-		opts.new_branch =3D opts.new_orphan_branch;
-	}
-
-	if (conflict_style) {
-		opts.merge =3D 1; /* implied */
-		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
-	}
-
-	if (opts.force && opts.merge)
-		die(_("git checkout: -f and -m are incompatible"));
-
 	/*
 	 * Extract branch name from command line arguments, so
 	 * all that is left is pathspecs.
@@ -1050,39 +1056,29 @@ int cmd_checkout(int argc, const char **argv, c=
onst char *prefix)
 		argc -=3D n;
 	}
=20
-	if (opts.track =3D=3D BRANCH_TRACK_UNSPECIFIED)
-		opts.track =3D git_branch_track;
-
+	/* After DWIM, these must be pathspec */
 	if (argc) {
-		const char **pathspec =3D get_pathspec(prefix, argv);
+		pathspec =3D get_pathspec(prefix, argv);
=20
 		if (!pathspec)
 			die(_("invalid path specification"));
=20
-		if (patch_mode)
-			return interactive_checkout(new.name, pathspec, &opts);
-
-		/* Checkout paths */
-		if (opts.new_branch) {
-			if (argc =3D=3D 1) {
-				die(_("git checkout: updating paths is incompatible with switching=
 branches.\nDid you intend to checkout '%s' which can not be resolved a=
s commit?"), argv[0]);
-			} else {
-				die(_("git checkout: updating paths is incompatible with switching=
 branches."));
-			}
-		}
+		/* Try to give more helpful suggestion, new_branch &&
+		   argc > 1 will be caught later */
+		if (opts.new_branch && argc =3D=3D 1)
+			die(_("Cannot update paths and switch to branch '%s' at the same ti=
me.\n"
+			      "Did you intend to checkout '%s' which can not be resolved as=
 commit?"),
+			    opts.new_branch, argv[0]);
=20
 		if (opts.force_detach)
 			die(_("git checkout: --detach does not take a path argument"));
=20
 		if (1 < !!opts.writeout_stage + !!opts.force + !!opts.merge)
-			die(_("git checkout: --ours/--theirs, --force and --merge are incom=
patible when\nchecking out of the index."));
-
-		return checkout_paths(source_tree, pathspec, prefix, &opts);
+			die(_("git checkout: --ours/--theirs, --force and --merge are incom=
patible when\n"
+			      "checking out of the index."));
 	}
=20
-	if (patch_mode)
-		return interactive_checkout(new.name, NULL, &opts);
-
+	/* new branch calculation done, validate it */
 	if (opts.new_branch) {
 		struct strbuf buf =3D STRBUF_INIT;
=20
@@ -1093,19 +1089,48 @@ int cmd_checkout(int argc, const char **argv, c=
onst char *prefix)
 		strbuf_release(&buf);
 	}
=20
-	if (new.name && !new.commit) {
-		die(_("Cannot switch branch to a non-commit."));
-	}
-	if (opts.writeout_stage)
-		die(_("--ours/--theirs is incompatible with switching branches."));
+	if (patch_mode || pathspec) { /* checking out entries */
+		if (opts.track > 0)
+			die(_("%s cannot be used while checking out paths"),
+			    "--track");
+		if (opts.new_branch_log)
+			die(_("%s cannot be used while checking out paths"),
+			    "-l");
+		if (opts.merge && patch_mode)
+			die(_("--merge cannot be used with --patch"));
+		if (opts.force && patch_mode)
+			die(_("%s cannot be used while checking out paths"),
+			    "-f");
+		if (opts.force_detach)
+			die(_("%s cannot be used while checking out paths"),
+			    "--detach");
+		if (opts.new_branch)
+			die(_("Cannot update paths and switch to branch '%s' at the same ti=
me."),
+			    opts.new_branch);
+
+		if (patch_mode)
+			return interactive_checkout(new.name, pathspec);
+		else
+			return checkout_paths(source_tree, pathspec, prefix, &opts);
+	} else {		/* switch branch */
+		if (new.name && !new.commit)
+			die(_("Cannot switch branch to a non-commit '%s'."),
+			    new.name);
=20
-	if (!new.commit && opts.new_branch) {
-		unsigned char rev[20];
-		int flag;
+		if (opts.writeout_stage)
+			die(_("--ours/--theirs is incompatible with switching branches."));
=20
-		if (!read_ref_full("HEAD", rev, 0, &flag) &&
-		    (flag & REF_ISSYMREF) && is_null_sha1(rev))
-			return switch_unborn_to_new_branch(&opts);
+		if (opts.track =3D=3D BRANCH_TRACK_UNSPECIFIED)
+			opts.track =3D git_branch_track;
+
+		if (!new.commit && opts.new_branch) {
+			unsigned char rev[20];
+			int flag;
+
+			if (!read_ref_full("HEAD", rev, 0, &flag) &&
+			    (flag & REF_ISSYMREF) && is_null_sha1(rev))
+				return switch_unborn_to_new_branch(&opts);
+		}
+		return switch_branches(&opts, &new);
 	}
-	return switch_branches(&opts, &new);
 }
--=20
1.7.12.rc2.18.g61b472e
