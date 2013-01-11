From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 08/21] checkout: convert to use parse_pathspec
Date: Fri, 11 Jan 2013 18:21:02 +0700
Message-ID: <1357903275-16804-9-git-send-email-pclouds@gmail.com>
References: <1357903275-16804-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 11 12:22:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ttcgc-0006yJ-Bp
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 12:22:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752237Ab3AKLVu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jan 2013 06:21:50 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:57349 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432Ab3AKLVt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 06:21:49 -0500
Received: by mail-pa0-f53.google.com with SMTP id hz1so962584pad.40
        for <git@vger.kernel.org>; Fri, 11 Jan 2013 03:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=K70xj+y5eW2sZaLLCx4fI/QwTpWZJLTel8vp6H8tLiw=;
        b=WR1s+Z1aZVyQLsFqJvwXv1wtfQkd0kpVZt0/TYX+uxYY6ur9WXJmN2ecQQhHXpw7ms
         f6Ih9yRl7H3twJj8DLGMh6IhBzNg9STw/VIwiwqe9ZwZaBZNe84Pr7LXiYSOkfr40u8z
         iS31jKO+W0GMCtb1IzU7IPGv9vVRyhmVOrNYa3jundbTe7BmVdOIBE6CzmNMjvehhzeo
         6bBD/aXEHEFHvthlubNdZc07B+bG+x/bXZSmcilszR3T6Y0Zj1tm+e3oqhMyoSwFjZWH
         7HJPIP4xyByAE7N6Ha4K9rWL2tjP9xkYhhLuI6SA5dslPBp1f7u+iNwiJ94RanpedEwJ
         yD9Q==
X-Received: by 10.66.80.70 with SMTP id p6mr206349774pax.23.1357903309287;
        Fri, 11 Jan 2013 03:21:49 -0800 (PST)
Received: from lanh ([115.74.46.148])
        by mx.google.com with ESMTPS id qr8sm2632316pbc.64.2013.01.11.03.21.46
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jan 2013 03:21:48 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 11 Jan 2013 18:22:04 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357903275-16804-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213200>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index a9c1b5a..da25298 100644
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
@@ -1110,9 +1108,9 @@ int cmd_checkout(int argc, const char **argv, con=
st char *prefix)
 	}
=20
 	if (argc) {
-		opts.pathspec =3D get_pathspec(prefix, argv);
+		parse_pathspec(&opts.pathspec, PATHSPEC_FROMTOP, 0, prefix, argv);
=20
-		if (!opts.pathspec)
+		if (!opts.pathspec.nr)
 			die(_("invalid path specification"));
=20
 		/*
@@ -1144,7 +1142,7 @@ int cmd_checkout(int argc, const char **argv, con=
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
