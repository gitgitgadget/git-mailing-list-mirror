From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/3] checkout: move branch guessing code out as a separate function
Date: Tue, 28 Aug 2012 20:49:08 +0700
Message-ID: <1346161748-25651-4-git-send-email-pclouds@gmail.com>
References: <7vr4qroel6.fsf@alter.siamese.dyndns.org>
 <1346161748-25651-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 28 15:56:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6MHE-0007pG-63
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 15:56:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844Ab2H1N4I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Aug 2012 09:56:08 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:49265 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472Ab2H1Nzs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Aug 2012 09:55:48 -0400
Received: by dady13 with SMTP id y13so3328586dad.19
        for <git@vger.kernel.org>; Tue, 28 Aug 2012 06:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=AwQxryelykhLvEjFSzzqquoDcyKffGjYLc2Qd+lenc4=;
        b=NZ+XnM/2ZkdWwTU0d1aCSBJLtHZz4MiPzJOjDbaaqv5zF4azYavVxwzzYxm4NBwUxW
         PvJtqh36WA4xzap6InPsl6tswy2/lFzXzcjEP4BILpRKNqtsjlZ00nZAW5rlenvfEQf9
         89cxm0k+GZoJXhgFqpdvlj6C4N2/q+yIWByP1nxKpHhQkOVz9U+uDl1+iVyvGXof+h+v
         pFfs5xaHAH+/emfV5XkTpl99hiK2YfG0NiVeDY0Q64FwvTa170/RLeXtIuZt3PtJfHt3
         8pWUTysGFGQ7jmr7GmKj5s7MlbMydGYGVyfE/D9lMfTjhg7bCqxR8tBZDSDAgAsVzKjD
         CCqA==
Received: by 10.66.9.2 with SMTP id v2mr37751365paa.65.1346162148513;
        Tue, 28 Aug 2012 06:55:48 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.35.79])
        by mx.google.com with ESMTPS id rn4sm17081528pbb.51.2012.08.28.06.55.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 28 Aug 2012 06:55:47 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 28 Aug 2012 20:49:35 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1346161748-25651-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204427>

This makes cmd_checkout() shorter, therefore easier to get the big
picture.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 In general I like it, except that parse_branchname_arg() pulls so many
 options from cmd_checkout(). I would rather have update_new_branch()
 that only takes "struct checkout_opts *" and returns a new branch. So
 I'm not sure if we should do this. If we do, perhaps we can merge it
 into the previous patch.

 builtin/checkout.c | 184 ++++++++++++++++++++++++++++-----------------=
--------
 1 file changed, 96 insertions(+), 88 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 3f1a436..e9d503d 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -914,6 +914,99 @@ static int parse_branchname_arg(int argc, const ch=
ar **argv,
 	return argcount;
 }
=20
+static const char *update_new_branch(const struct checkout_opts *opts,
+				     int argc, const char **argv,
+				     const char *prefix, const char ***pathspec,
+				     int dwim_ok,
+				     struct branch_info *new,
+				     struct tree **source_tree,
+				     unsigned char *rev)
+{
+	const char *branch =3D opts->new_branch;
+
+	if (opts->new_branch_force) {
+		/* we can assume from now on new_branch =3D !new_branch_force */
+		if (branch)
+			die(_("New branch '%s' is already specified by other options"),
+			    branch);
+
+		/* copy -B over to -b, so that we can just check the latter */
+		if (opts->new_branch_force)
+			branch =3D opts->new_branch_force;
+	}
+
+	if (opts->new_orphan_branch) {
+		if (opts->track > 0)
+			die(_("--orphan cannot be used with -t"));
+		if (branch)
+			die(_("New branch '%s' is already specified by other options"),
+			    branch);
+		branch =3D opts->new_orphan_branch;
+	}
+
+	/* --track without -b should DWIM */
+	if (0 < opts->track && !branch) {
+		const char *argv0 =3D argv[0];
+		if (!argc || !strcmp(argv0, "--"))
+			die (_("--track needs a branch name"));
+		if (!prefixcmp(argv0, "refs/"))
+			argv0 +=3D 5;
+		if (!prefixcmp(argv0, "remotes/"))
+			argv0 +=3D 8;
+		argv0 =3D strchr(argv0, '/');
+		if (!argv0 || !argv0[1])
+			die (_("Missing branch name; try -b"));
+		branch =3D argv0 + 1;
+	}
+
+	/*
+	 * Extract branch name from command line arguments, so
+	 * all that is left is pathspecs.
+	 *
+	 * Handle
+	 *
+	 *  1) git checkout <tree> -- [<paths>]
+	 *  2) git checkout -- [<paths>]
+	 *  3) git checkout <something> [<paths>]
+	 *
+	 * including "last branch" syntax and DWIM-ery for names of
+	 * remote branches, erroring out for invalid or ambiguous cases.
+	 */
+	if (argc) {
+		dwim_ok =3D dwim_ok &&
+			opts->track =3D=3D BRANCH_TRACK_UNSPECIFIED &&
+			!branch;
+		int n =3D parse_branchname_arg(argc, argv, dwim_ok,
+					     new, source_tree, rev, &branch);
+		argv +=3D n;
+		argc -=3D n;
+	}
+
+	/* After DWIM, these must be pathspec */
+	if (argc) {
+		*pathspec =3D get_pathspec(prefix, argv);
+
+		if (!*pathspec)
+			die(_("invalid path specification"));
+
+		/* Try to give more helpful suggestion, new_branch &&
+		   argc > 1 will be caught later */
+		if (branch && argc =3D=3D 1)
+			die(_("Cannot update paths and switch to branch '%s' at the same ti=
me.\n"
+			      "Did you intend to checkout '%s' which can not be resolved as=
 commit?"),
+			    branch, argv[0]);
+
+		if (opts->force_detach)
+			die(_("git checkout: --detach does not take a path argument"));
+
+		if (1 < !!opts->writeout_stage + !!opts->force + !!opts->merge)
+			die(_("git checkout: --ours/--theirs, --force and --merge are incom=
patible when\n"
+			      "checking out of the index."));
+	}
+
+	return branch;
+}
+
 static int switch_unborn_to_new_branch(const struct checkout_opts *opt=
s)
 {
 	int status;
@@ -989,94 +1082,9 @@ int cmd_checkout(int argc, const char **argv, con=
st char *prefix)
 		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
 	}
=20
-	/*
-	 * opts.new_branch calculation, it could be from -b or -B or
-	 * --track or --orphan or other command line arguments.
-	 *
-	 * The following code until new branch validation should not
-	 * update any fields in opts but opts.new_branch.
-	 */
-	if (opts.new_branch_force) {
-		/* we can assume from now on new_branch =3D !new_branch_force */
-		if (opts.new_branch)
-			die(_("New branch '%s' is already specified by other options"),
-			    opts.new_branch);
-
-		/* copy -B over to -b, so that we can just check the latter */
-		if (opts.new_branch_force)
-			opts.new_branch =3D opts.new_branch_force;
-	}
-
-	if (opts.new_orphan_branch) {
-		if (opts.track > 0)
-			die(_("--orphan cannot be used with -t"));
-		if (opts.new_branch)
-			die(_("New branch '%s' is already specified by other options"),
-			    opts.new_branch);
-		opts.new_branch =3D opts.new_orphan_branch;
-	}
-
-	/* --track without -b should DWIM */
-	if (0 < opts.track && !opts.new_branch) {
-		const char *argv0 =3D argv[0];
-		if (!argc || !strcmp(argv0, "--"))
-			die (_("--track needs a branch name"));
-		if (!prefixcmp(argv0, "refs/"))
-			argv0 +=3D 5;
-		if (!prefixcmp(argv0, "remotes/"))
-			argv0 +=3D 8;
-		argv0 =3D strchr(argv0, '/');
-		if (!argv0 || !argv0[1])
-			die (_("Missing branch name; try -b"));
-		opts.new_branch =3D argv0 + 1;
-	}
-
-	/*
-	 * Extract branch name from command line arguments, so
-	 * all that is left is pathspecs.
-	 *
-	 * Handle
-	 *
-	 *  1) git checkout <tree> -- [<paths>]
-	 *  2) git checkout -- [<paths>]
-	 *  3) git checkout <something> [<paths>]
-	 *
-	 * including "last branch" syntax and DWIM-ery for names of
-	 * remote branches, erroring out for invalid or ambiguous cases.
-	 */
-	if (argc) {
-		int dwim_ok =3D
-			!patch_mode &&
-			dwim_new_local_branch &&
-			opts.track =3D=3D BRANCH_TRACK_UNSPECIFIED &&
-			!opts.new_branch;
-		int n =3D parse_branchname_arg(argc, argv, dwim_ok,
-				&new, &source_tree, rev, &opts.new_branch);
-		argv +=3D n;
-		argc -=3D n;
-	}
-
-	/* After DWIM, these must be pathspec */
-	if (argc) {
-		pathspec =3D get_pathspec(prefix, argv);
-
-		if (!pathspec)
-			die(_("invalid path specification"));
-
-		/* Try to give more helpful suggestion, new_branch &&
-		   argc > 1 will be caught later */
-		if (opts.new_branch && argc =3D=3D 1)
-			die(_("Cannot update paths and switch to branch '%s' at the same ti=
me.\n"
-			      "Did you intend to checkout '%s' which can not be resolved as=
 commit?"),
-			    opts.new_branch, argv[0]);
-
-		if (opts.force_detach)
-			die(_("git checkout: --detach does not take a path argument"));
-
-		if (1 < !!opts.writeout_stage + !!opts.force + !!opts.merge)
-			die(_("git checkout: --ours/--theirs, --force and --merge are incom=
patible when\n"
-			      "checking out of the index."));
-	}
+	opts.new_branch =3D update_new_branch(&opts, argc, argv, prefix, &pat=
hspec,
+					    !patch_mode && dwim_new_local_branch,
+					    &new, &source_tree, rev);
=20
 	/* new branch calculation done, validate it */
 	if (opts.new_branch) {
--=20
1.7.12.rc2.18.g61b472e
