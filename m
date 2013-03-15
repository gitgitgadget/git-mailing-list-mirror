From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v1 19/45] checkout: convert to use parse_pathspec
Date: Fri, 15 Mar 2013 13:06:34 +0700
Message-ID: <1363327620-29017-20-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 07:26:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGO6C-0005ca-2v
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 07:26:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753176Ab3COG0N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 02:26:13 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:48772 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646Ab3COG0M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 02:26:12 -0400
Received: by mail-ie0-f180.google.com with SMTP id bn7so3915171ieb.25
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 23:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=TWWAbqtK4xHx9e89NhovEuI4eBTotFzLX1ucviRyKxI=;
        b=qx+abi5K4auH257Ir9BrwWLc0Dfb4ZMqu130YDPJfokkkJ5ILnMIIlO4zXboGyY23x
         XGwjJRzFG0VedxYZpK0d0X/Bxf6tStRmPgWv51E12gYJKjwdB2jXfJHjB9pmDvjMcojp
         QKQCqCJEck1mWEHbatrz3uOC8NmFMakq41gjF/rLX231qRE3uXz/w1E/9R2Aic7JGeyQ
         Beo4zYfanBQNPviunbs+R4RzOb7LIN1V/usq5H1aGglGUVSe5889O1jJPRNOhp6Z9kiA
         AWTxVvcpCu/WzpChC9BkyC1aQ/c02+fimo7s34xCPwiP1Z2ycgoGBYumANmVT15ws0VN
         wLcw==
X-Received: by 10.50.53.136 with SMTP id b8mr308690igp.0.1363328770998;
        Thu, 14 Mar 2013 23:26:10 -0700 (PDT)
Received: from tre ([115.74.58.84])
        by mx.google.com with ESMTPS id wn10sm627736igb.2.2013.03.14.23.26.07
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 23:26:10 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 15 Mar 2013 13:09:13 +0700
X-Mailer: git-send-email 1.8.0.rc0.19.g7bbb31d
In-Reply-To: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218206>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index a9c1b5a..8dc5f51 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -45,7 +45,7 @@ struct checkout_opts {
=20
 	int branch_exists;
 	const char *prefix;
-	const char **pathspec;
+	struct pathspec pathspec;
 	struct tree *source_tree;
 };
=20
@@ -256,39 +256,37 @@ static int checkout_paths(const struct checkout_o=
pts *opts,
=20
 	if (opts->patch_mode)
 		return run_add_interactive(revision, "--patch=3Dcheckout",
-					   opts->pathspec);
+					   opts->pathspec.raw);
=20
 	lock_file =3D xcalloc(1, sizeof(struct lock_file));
=20
 	newfd =3D hold_locked_index(lock_file, 1);
-	if (read_cache_preload(opts->pathspec) < 0)
+	if (read_cache_preload(opts->pathspec.raw) < 0)
 		return error(_("corrupt index file"));
=20
 	if (opts->source_tree)
-		read_tree_some(opts->source_tree, opts->pathspec);
+		read_tree_some(opts->source_tree, opts->pathspec.raw);
=20
-	for (pos =3D 0; opts->pathspec[pos]; pos++)
-		;
-	ps_matched =3D xcalloc(1, pos);
+	ps_matched =3D xcalloc(1, opts->pathspec.nr);
=20
 	for (pos =3D 0; pos < active_nr; pos++) {
 		struct cache_entry *ce =3D active_cache[pos];
 		if (opts->source_tree && !(ce->ce_flags & CE_UPDATE))
 			continue;
-		match_pathspec(opts->pathspec, ce->name, ce_namelen(ce), 0, ps_match=
ed);
+		match_pathspec_depth(&opts->pathspec, ce->name, ce_namelen(ce), 0, p=
s_matched);
 	}
=20
-	if (report_path_error(ps_matched, opts->pathspec, opts->prefix))
+	if (report_path_error(ps_matched, opts->pathspec.raw, opts->prefix))
 		return 1;
=20
 	/* "checkout -m path" to recreate conflicted state */
 	if (opts->merge)
-		unmerge_cache(opts->pathspec);
+		unmerge_cache(opts->pathspec.raw);
=20
 	/* Any unmerged paths? */
 	for (pos =3D 0; pos < active_nr; pos++) {
 		struct cache_entry *ce =3D active_cache[pos];
-		if (match_pathspec(opts->pathspec, ce->name, ce_namelen(ce), 0, NULL=
)) {
+		if (match_pathspec_depth(&opts->pathspec, ce->name, ce_namelen(ce), =
0, NULL)) {
 			if (!ce_stage(ce))
 				continue;
 			if (opts->force) {
@@ -315,7 +313,7 @@ static int checkout_paths(const struct checkout_opt=
s *opts,
 		struct cache_entry *ce =3D active_cache[pos];
 		if (opts->source_tree && !(ce->ce_flags & CE_UPDATE))
 			continue;
-		if (match_pathspec(opts->pathspec, ce->name, ce_namelen(ce), 0, NULL=
)) {
+		if (match_pathspec_depth(&opts->pathspec, ce->name, ce_namelen(ce), =
0, NULL)) {
 			if (!ce_stage(ce)) {
 				errs |=3D checkout_entry(ce, &state, NULL);
 				continue;
@@ -960,7 +958,7 @@ static int switch_unborn_to_new_branch(const struct=
 checkout_opts *opts)
 static int checkout_branch(struct checkout_opts *opts,
 			   struct branch_info *new)
 {
-	if (opts->pathspec)
+	if (opts->pathspec.nr)
 		die(_("paths cannot be used with switching branches"));
=20
 	if (opts->patch_mode)
@@ -1110,9 +1108,19 @@ int cmd_checkout(int argc, const char **argv, co=
nst char *prefix)
 	}
=20
 	if (argc) {
-		opts.pathspec =3D get_pathspec(prefix, argv);
+		/*
+		 * In patch mode (opts.patch_mode !=3D 0), we pass the
+		 * pathspec to an external program, git-add--interactive.
+		 * Do not accept any kind of magic that that program
+		 * cannot handle. Magic mask is pretty safe to be
+		 * lifted for new magic when opts.patch_mode =3D=3D 0.
+		 */
+		parse_pathspec(&opts.pathspec,
+			       opts.patch_mode =3D=3D 0 ? 0 :
+			       (PATHSPEC_ALL_MAGIC & ~PATHSPEC_FROMTOP),
+			       0, prefix, argv);
=20
-		if (!opts.pathspec)
+		if (!opts.pathspec.nr)
 			die(_("invalid path specification"));
=20
 		/*
@@ -1144,7 +1152,7 @@ int cmd_checkout(int argc, const char **argv, con=
st char *prefix)
 		strbuf_release(&buf);
 	}
=20
-	if (opts.patch_mode || opts.pathspec)
+	if (opts.patch_mode || opts.pathspec.nr)
 		return checkout_paths(&opts, new.name);
 	else
 		return checkout_branch(&opts, &new);
--=20
1.8.0.rc0.19.g7bbb31d
