From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] checkout: add --sparse for restoring files in sparse checkout mode
Date: Sun, 24 Mar 2013 12:06:23 +0700
Message-ID: <1364101583-6035-1-git-send-email-pclouds@gmail.com>
References: <514C3249.7000100@ivt.baug.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kirill.mueller@ivt.baug.ethz.ch,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 24 06:07:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJd98-0004ck-TE
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 06:07:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961Ab3CXFG3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Mar 2013 01:06:29 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:32909 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812Ab3CXFG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 01:06:28 -0400
Received: by mail-pb0-f46.google.com with SMTP id uo15so3622662pbc.5
        for <git@vger.kernel.org>; Sat, 23 Mar 2013 22:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=aV5xbuwV/k0c9suYc6T7EOVzEIVygYD/NHiSvR+p4zQ=;
        b=vAcqnPCBoLADC68t5EKUkjzCneeqNqmzeGvKGLR2hPjbkwwLdUZU2tfBH6Fgy2qFG+
         vwNMXcvCMzMh/tZZx+Ldgh3tV698g/fjn9XEsGpJKkVEOQ7Bjh23lM80nNedWKQ9/Xt+
         FNsG23LIhsu4KSh3+5IFpgSHTanrYOPilnC4NPyeCIJUJwE9c9MTZXwI06mErGZmwGRz
         pObd8tB61TGzTOOhw2jrJTp9lSHEN4bF/OB8qVUo6SXME5S7D2AZIbZKvwhj3J17JmKo
         3j8t3Am0kVXck6+JMocfT2jRKez8QMmG4UY9pNqfsafXRrgvHsFd9taYMNQbxX1BiIgQ
         FtiQ==
X-Received: by 10.68.47.39 with SMTP id a7mr10710499pbn.155.1364101588087;
        Sat, 23 Mar 2013 22:06:28 -0700 (PDT)
Received: from lanh ([115.74.41.0])
        by mx.google.com with ESMTPS id z1sm8399344pbw.19.2013.03.23.22.06.24
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 23 Mar 2013 22:06:27 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 24 Mar 2013 12:06:27 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <514C3249.7000100@ivt.baug.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218933>

"git checkout -- <paths>" is usually used to restore all modified
files in <paths>. In sparse checkout mode, this command is overloaded
with another meaning: to add back all files in <paths> that are
excluded by sparse patterns.

Add "--sparse" option to do what normal mode does: restore all
modified files and nothing else.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I'm not sure if rejecting --sparse when it has no effects (e.g.
 switching branches or interactive mode) like this patch does is a
 good idea. I think it's good in general to spot unused options. On
 the other hand, people may want to add an alias
 "co =3D checkout --sparse" to make this behavior "default". In that
 case silently ignoring --sparse may be a good idea.

 Documentation/git-checkout.txt       |  7 +++++++
 builtin/checkout.c                   | 18 ++++++++++++++++--
 t/t1011-read-tree-sparse-checkout.sh | 12 ++++++++++++
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkou=
t.txt
index 8edcdca..45a2b53 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -180,6 +180,13 @@ branch by running "git rm -rf ." from the top leve=
l of the working tree.
 Afterwards you will be ready to prepare your new files, repopulating t=
he
 working tree, by copying them from elsewhere, extracting a tarball, et=
c.
=20
+
+--sparse::
+	In sparse checkout mode, `git checkout -- <paths>` would
+	update all entries matched by <paths> regardless sparse
+	patterns. This option only updates entries matched by <paths>
+	and sparse patterns.
+
 -m::
 --merge::
 	When switching branches,
diff --git a/builtin/checkout.c b/builtin/checkout.c
index a9c1b5a..3a32145 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -35,6 +35,7 @@ struct checkout_opts {
 	int force_detach;
 	int writeout_stage;
 	int overwrite_ignore;
+	int sparse;
=20
 	const char *new_branch;
 	const char *new_branch_force;
@@ -224,7 +225,7 @@ static int checkout_paths(const struct checkout_opt=
s *opts,
 	struct checkout state;
 	static char *ps_matched;
 	unsigned char rev[20];
-	int flag;
+	int flag, sparse;
 	struct commit *head;
 	int errs =3D 0;
 	int stage =3D opts->writeout_stage;
@@ -254,9 +255,13 @@ static int checkout_paths(const struct checkout_op=
ts *opts,
 		die(_("Cannot update paths and switch to branch '%s' at the same tim=
e."),
 		    opts->new_branch);
=20
-	if (opts->patch_mode)
+	if (opts->patch_mode) {
+		if (opts->sparse !=3D -1)
+			die(_("--[no-]sparse cannot be used in interactive mode"));
 		return run_add_interactive(revision, "--patch=3Dcheckout",
 					   opts->pathspec);
+	}
+	sparse =3D opts->sparse !=3D -1 ? opts->sparse : 0;
=20
 	lock_file =3D xcalloc(1, sizeof(struct lock_file));
=20
@@ -275,6 +280,8 @@ static int checkout_paths(const struct checkout_opt=
s *opts,
 		struct cache_entry *ce =3D active_cache[pos];
 		if (opts->source_tree && !(ce->ce_flags & CE_UPDATE))
 			continue;
+		if (sparse && ce_skip_worktree(ce))
+			continue;
 		match_pathspec(opts->pathspec, ce->name, ce_namelen(ce), 0, ps_match=
ed);
 	}
=20
@@ -315,6 +322,8 @@ static int checkout_paths(const struct checkout_opt=
s *opts,
 		struct cache_entry *ce =3D active_cache[pos];
 		if (opts->source_tree && !(ce->ce_flags & CE_UPDATE))
 			continue;
+		if (sparse && ce_skip_worktree(ce))
+			continue;
 		if (match_pathspec(opts->pathspec, ce->name, ce_namelen(ce), 0, NULL=
)) {
 			if (!ce_stage(ce)) {
 				errs |=3D checkout_entry(ce, &state, NULL);
@@ -963,6 +972,9 @@ static int checkout_branch(struct checkout_opts *op=
ts,
 	if (opts->pathspec)
 		die(_("paths cannot be used with switching branches"));
=20
+	if (opts->sparse !=3D -1)
+		die(_("--[no-]sparse can only be used with paths"));
+
 	if (opts->patch_mode)
 		die(_("'%s' cannot be used with switching branches"),
 		    "--patch");
@@ -1029,6 +1041,7 @@ int cmd_checkout(int argc, const char **argv, con=
st char *prefix)
 		OPT_STRING(0, "conflict", &conflict_style, N_("style"),
 			   N_("conflict style (merge or diff3)")),
 		OPT_BOOLEAN('p', "patch", &opts.patch_mode, N_("select hunks interac=
tively")),
+		OPT_BOOL(0, "sparse", &opts.sparse, N_("limit pathspecs to sparse en=
tries only")),
 		{ OPTION_BOOLEAN, 0, "guess", &dwim_new_local_branch, NULL,
 		  N_("second guess 'git checkout no-such-branch'"),
 		  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
@@ -1039,6 +1052,7 @@ int cmd_checkout(int argc, const char **argv, con=
st char *prefix)
 	memset(&new, 0, sizeof(new));
 	opts.overwrite_ignore =3D 1;
 	opts.prefix =3D prefix;
+	opts.sparse =3D -1;
=20
 	gitmodules_config();
 	git_config(git_checkout_config, &opts);
diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-s=
parse-checkout.sh
index 5c0053a..1441fbe 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -250,4 +250,16 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_success 'checkout --sparse' '
+	echo "*" >.git/info/sparse-checkout &&
+	git checkout -f top &&
+	test -f init.t &&
+	echo sub >.git/info/sparse-checkout &&
+	git checkout &&
+	echo modified >> sub/added &&
+	git checkout --sparse . &&
+	! test -f init.t &&
+	git diff --exit-code HEAD
+'
+
 test_done
--=20
1.8.2.83.gc99314b
