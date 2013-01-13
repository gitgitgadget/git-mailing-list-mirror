From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 12/31] checkout: convert to use parse_pathspec
Date: Sun, 13 Jan 2013 19:35:20 +0700
Message-ID: <1358080539-17436-13-git-send-email-pclouds@gmail.com>
References: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 13:37:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuMoY-0006pN-Vo
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 13:37:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755091Ab3AMMhE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 07:37:04 -0500
Received: from mail-da0-f53.google.com ([209.85.210.53]:62664 "EHLO
	mail-da0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755078Ab3AMMhD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 07:37:03 -0500
Received: by mail-da0-f53.google.com with SMTP id x6so1414432dac.40
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 04:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=79og8F+skQMe4THV6TVqkvjjKunoGsgc4k1OSZwRnF8=;
        b=HrqGDIAbL/PMH5ZZYYh09p24tHjx6ojqSlxS7OQlVlHqzRW5kopgVLmyzTaw56VBQk
         n6Tf60jxlcy0yUj1wRDVtT1di8eJsBowMIqoNoLXO5unZTCQw4+NRl71HQcjRQ8FXNFs
         h5fmDTe1BQIeevDgited7bzbZtkShEkG/bmJpgLL+bvw/qqT8Wx6kV6pDhYgla05+6Az
         P0DpPhYAuK/2vpZ3rhSA/rhHfF2bGHTDqCh5Gkyys0CaIwkyswUPFbWQmnBr7qBxrIma
         QD39duVfo0cZv76NbOUP1ekI5/RKzHhKDI4dDoNvgbqspAWqvl7Fb8vg9a3VaF5rHpKK
         p6CA==
X-Received: by 10.66.81.199 with SMTP id c7mr211264656pay.39.1358080622731;
        Sun, 13 Jan 2013 04:37:02 -0800 (PST)
Received: from lanh ([115.74.52.72])
        by mx.google.com with ESMTPS id s7sm6763842paz.7.2013.01.13.04.36.59
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 04:37:02 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jan 2013 19:37:17 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213352>

This commit introduces a subtle bug:

- when match_pathspec() returns seen[], it follows the order of the
  input "const char **pathspec", which is now pathspec.raw[]

- when match_pathspec() returns seen[], it follows the order of
  pathspec.items[]

- due to 86e4ca6 (tree_entry_interesting(): fix depth limit with
  overlapping pathspecs - 2010-12-15), pathspec.items[] is sorted, but
  pathspec.raw[] is NOT.

by converting from match_pathspec() to match_pathspec_depth(), we also
have to switch the original path array. Unfortunately we can't because
this array is processed by report_path_error() and it's also used by
builtin/ls-files.c, which still uses the old indexing.

The bug causes wrong error messages (e.g. if the first pathspec is
faulty, it may report the second..) The bug will be dealt with after
ls-files is converted.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index a9c1b5a..3e60f2e 100644
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
@@ -1110,9 +1108,16 @@ int cmd_checkout(int argc, const char **argv, co=
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
+		parse_pathspec(&opts.pathspec, PATHSPEC_FROMTOP, 0, prefix, argv);
=20
-		if (!opts.pathspec)
+		if (!opts.pathspec.nr)
 			die(_("invalid path specification"));
=20
 		/*
@@ -1144,7 +1149,7 @@ int cmd_checkout(int argc, const char **argv, con=
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
1.8.0.rc2.23.g1fb49df
