From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 3/3] checkout: reorder option handling
Date: Wed, 29 Aug 2012 20:55:24 +0700
Message-ID: <1346248524-11616-3-git-send-email-pclouds@gmail.com>
References: <CACsJy8Cjbg2tb_E+D7hMwPZNFWhvEF1eNpf5HUBzJnBoQQaMAg@mail.gmail.com>
 <1346248524-11616-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 29 16:02:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6iqr-0007ak-3r
	for gcvg-git-2@plane.gmane.org; Wed, 29 Aug 2012 16:02:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753799Ab2H2OCa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Aug 2012 10:02:30 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45785 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753779Ab2H2OC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2012 10:02:29 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so1274461pbb.19
        for <git@vger.kernel.org>; Wed, 29 Aug 2012 07:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=deLYbMJEQe52vVB/sxCP9qNq0t2+dNigsNGYllUhU2c=;
        b=f8pEvVBnwmEhCXIlGUL52JPiR6ndalHFKXpj/wgKLd2zWA+xdfd8TX5B+8Sv10ssEd
         oRxpwaA0aziwaHexbfeY0svbBgJjJufw9utIsGg3VnNbqcZVK2FZBffSmjl2X8U/CWbr
         cM7nmrUHVC/rTtYkkBxs37LmdXSvqfhxgyE2baHMoG4+qWejV8KV7MtVjVLrLzbOGhwt
         7b6qyeFFu22vtDCxXcJgDz44yCvKQjWxPKYtOuCZHO/dIJbJ8yk8J/rfyzJgrlGQ/knH
         WGzIN8ssq7TGAulRHj8qSuealv3Gn2JrJjOP++6OG7co2pduNZfv2yWSxnh3Yha2x2j9
         40CQ==
Received: by 10.66.72.197 with SMTP id f5mr3960381pav.20.1346248949051;
        Wed, 29 Aug 2012 07:02:29 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.49.176])
        by mx.google.com with ESMTPS id pj10sm19397980pbb.46.2012.08.29.07.02.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 29 Aug 2012 07:02:28 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 29 Aug 2012 20:56:09 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1346248524-11616-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204480>

checkout operates in three different modes. On top of that it tries to
be smart by guessing the branch name for switching. This results in
messy option handling code. This patch reorders it so that

 - cmd_checkout() is responsible for parsing, preparing input and
   determinining mode

 - Code of each mode is in cmd_checkout_entry() and cmd_switch(),
   where sanity checks are performed per mode

Another slight improvement is always print branch name (or commit
name) when printing errors related ot them. This helps catch the case
where an option is mistaken as branch/commit.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I'm not entirely sure about this chunk

 +	if (opts->track !=3D BRANCH_TRACK_UNSPECIFIED) {
 +		if (opts->new_orphan_branch)
 +			die(_("%s cannot be used with %s"), "--orphan", "-t");
 +		if (opts->force_detach)
 +			die(_("%s cannot be used with %s"), "--detach", "-t");
 +	} else
 +		opts->track =3D git_branch_track;

 If we don't want -t and --orphan/--detach together, then we probably s=
hould ignore
 branch.autosetupmerge when --orphan/--detach is specified.

 I did not unify new_branch, new_branch_force and new_orphan_branch.
 They touch other parts of the code and should probably be done
 separately.

 builtin/checkout.c | 169 ++++++++++++++++++++++++++++++++-------------=
--------
 1 file changed, 101 insertions(+), 68 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 78abaeb..8289bcd 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -930,6 +930,81 @@ static int switch_unborn_to_new_branch(const struc=
t checkout_opts *opts)
 	return status;
 }
=20
+static int cmd_checkout_entry(const struct checkout_opts *opts,
+			      const struct branch_info *new)
+{
+	if (opts->track !=3D BRANCH_TRACK_UNSPECIFIED)
+		die(_("%s cannot be used with updating paths"), "--track");
+
+	if (opts->new_branch_log)
+		die(_("%s cannot be used with updating paths"), "-l");
+
+	if (opts->force && opts->patch_mode)
+		die(_("%s cannot be used with updating paths"), "-f");
+
+	if (opts->force_detach)
+		die(_("%s cannot be used with updating paths"), "--detach");
+
+	if (opts->merge && opts->patch_mode)
+		die(_("%s cannot be used with %s"), "--merge", "--patch");
+
+	if (opts->force && opts->merge)
+		die(_("%s cannot be used with %s"), "-f", "-m");
+
+	if (opts->new_branch)
+		die(_("Cannot update paths and switch to branch '%s' at the same tim=
e."),
+		    opts->new_branch);
+
+	if (opts->patch_mode)
+		return interactive_checkout(new->name, opts->pathspec);
+	else
+		return checkout_paths(opts);
+}
+
+static int cmd_switch(struct checkout_opts *opts,
+		      struct branch_info *new)
+{
+	if (opts->pathspec)
+		die(_("paths cannot be used with switching branches"));
+
+	if (opts->patch_mode)
+		die(_("%s cannot be used with switching branches"),
+		    "--patch");
+
+	if (opts->writeout_stage)
+		die(_("%s cannot be used with switching branches"),
+		    "--ours/--theirs");
+
+	if (opts->force && opts->merge)
+		die(_("%s cannot be used with %s"), "-f", "-m");
+
+	if (opts->force_detach && opts->new_branch)
+		die(_("%s cannot be used with %s"),
+		    "--detach", "-b/-B/--orphan");
+
+	if (opts->track !=3D BRANCH_TRACK_UNSPECIFIED) {
+		if (opts->new_orphan_branch)
+			die(_("%s cannot be used with %s"), "--orphan", "-t");
+		if (opts->force_detach)
+			die(_("%s cannot be used with %s"), "--detach", "-t");
+	} else
+		opts->track =3D git_branch_track;
+
+	if (new->name && !new->commit)
+		die(_("Cannot switch branch to a non-commit '%s'."),
+		    new->name);
+
+	if (!new->commit && opts->new_branch) {
+		unsigned char rev[20];
+		int flag;
+
+		if (!read_ref_full("HEAD", rev, 0, &flag) &&
+		    (flag & REF_ISSYMREF) && is_null_sha1(rev))
+			return switch_unborn_to_new_branch(opts);
+	}
+	return switch_branches(opts, new);
+}
+
 int cmd_checkout(int argc, const char **argv, const char *prefix)
 {
 	struct checkout_opts opts;
@@ -976,26 +1051,22 @@ int cmd_checkout(int argc, const char **argv, co=
nst char *prefix)
 	argc =3D parse_options(argc, argv, prefix, options, checkout_usage,
 			     PARSE_OPT_KEEP_DASHDASH);
=20
-	/* we can assume from now on new_branch =3D !new_branch_force */
-	if (opts.new_branch && opts.new_branch_force)
-		die(_("-B cannot be used with -b"));
+	if (conflict_style) {
+		opts.merge =3D 1; /* implied */
+		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
+	}
+
+	if ((!!opts.new_branch + !!opts.new_branch_force + !!opts.new_orphan_=
branch) > 1)
+		die(_("-b, -B and --orphan are mutually exclusive"));
=20
-	/* copy -B over to -b, so that we can just check the latter */
 	if (opts.new_branch_force)
 		opts.new_branch =3D opts.new_branch_force;
=20
-	if (opts.patch_mode && (opts.track > 0 || opts.new_branch
-			   || opts.new_branch_log || opts.merge || opts.force
-			   || opts.force_detach))
-		die (_("--patch is incompatible with all other options"));
-
-	if (opts.force_detach && (opts.new_branch || opts.new_orphan_branch))
-		die(_("--detach cannot be used with -b/-B/--orphan"));
-	if (opts.force_detach && 0 < opts.track)
-		die(_("--detach cannot be used with -t"));
+	if (opts.new_orphan_branch)
+		opts.new_branch =3D opts.new_orphan_branch;
=20
 	/* --track without -b should DWIM */
-	if (0 < opts.track && !opts.new_branch) {
+	if (opts.track !=3D BRANCH_TRACK_UNSPECIFIED && !opts.new_branch) {
 		const char *argv0 =3D argv[0];
 		if (!argc || !strcmp(argv0, "--"))
 			die (_("--track needs a branch name"));
@@ -1009,22 +1080,6 @@ int cmd_checkout(int argc, const char **argv, co=
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
@@ -1052,62 +1107,40 @@ int cmd_checkout(int argc, const char **argv, c=
onst char *prefix)
 		argc -=3D n;
 	}
=20
-	if (opts.track =3D=3D BRANCH_TRACK_UNSPECIFIED)
-		opts.track =3D git_branch_track;
-
 	if (argc) {
 		opts.pathspec =3D get_pathspec(prefix, argv);
=20
 		if (!opts.pathspec)
 			die(_("invalid path specification"));
=20
-		if (opts.patch_mode)
-			return interactive_checkout(new.name, opts.pathspec);
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
-		return checkout_paths(&opts);
+			die(_("git checkout: --ours/--theirs, --force and --merge are incom=
patible when\n"
+			      "checking out of the index."));
 	}
=20
-	if (opts.patch_mode)
-		return interactive_checkout(new.name, NULL);
-
 	if (opts.new_branch) {
 		struct strbuf buf =3D STRBUF_INIT;
=20
-		opts.branch_exists =3D validate_new_branchname(opts.new_branch, &buf=
,
-							     !!opts.new_branch_force,
-							     !!opts.new_branch_force);
+		opts.branch_exists =3D
+			validate_new_branchname(opts.new_branch, &buf,
+						!!opts.new_branch_force,
+						!!opts.new_branch_force);
=20
 		strbuf_release(&buf);
 	}
=20
-	if (new.name && !new.commit) {
-		die(_("Cannot switch branch to a non-commit."));
-	}
-	if (opts.writeout_stage)
-		die(_("--ours/--theirs is incompatible with switching branches."));
-
-	if (!new.commit && opts.new_branch) {
-		unsigned char rev[20];
-		int flag;
-
-		if (!read_ref_full("HEAD", rev, 0, &flag) &&
-		    (flag & REF_ISSYMREF) && is_null_sha1(rev))
-			return switch_unborn_to_new_branch(&opts);
-	}
-	return switch_branches(&opts, &new);
+	if (opts.patch_mode || opts.pathspec)
+		return cmd_checkout_entry(&opts, &new);
+	else
+		return cmd_switch(&opts, &new);
 }
--=20
1.7.12.rc2.18.g61b472e
