From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH v7a 9/9] diff --stat: add config option to limit graph width
Date: Thu,  1 Mar 2012 13:26:46 +0100
Message-ID: <1330604806-30288-9-git-send-email-zbyszek@in.waw.pl>
References: <7vfwdts6wj.fsf@alter.siamese.dyndns.org>
 <1330604806-30288-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pclouds@gmail.com, j.sixt@viscovery.net,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 01 13:31:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S35Ai-0007JH-NP
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 13:31:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030852Ab2CAMbS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Mar 2012 07:31:18 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:55399 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030848Ab2CAMbO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 07:31:14 -0500
Received: from optyk25.fuw.edu.pl ([193.0.81.79] helo=ameba.fuw.edu.pl)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1S35A8-00026K-Sw; Thu, 01 Mar 2012 13:31:13 +0100
X-Mailer: git-send-email 1.7.9.2.399.gdf4d.dirty
In-Reply-To: <1330604806-30288-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191927>

Config option diff.statGraphWidth=3D<width> is equivalent to
--stat-graph-width=3D<width>, except that the config option is ignored
by format-patch.

=46or the graph-width limiting to be usable, it should happen
'automatically' once configured, hence the config option.
Nevertheless, graph width limiting only makes sense when used on a
wide terminal, so it should not influence the output of format-patch,
which adheres to the 80-column standard.

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/diff-config.txt          |    4 ++++
 Documentation/diff-options.txt         |   16 +++++++++-------
 builtin/diff.c                         |    3 ++-
 builtin/log.c                          |    1 +
 builtin/merge.c                        |    1 +
 contrib/completion/git-completion.bash |    1 +
 diff.c                                 |    8 ++++++++
 t/t4052-stat-output.sh                 |    6 ++++++
 8 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.=
txt
index 1aed79e..6aa1be0 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -52,6 +52,10 @@ directories with less than 10% of the total amount o=
f changed files,
 and accumulating child directory counts in the parent directories:
 `files,10,cumulative`.
=20
+diff.statGraphWidth::
+	Limit the width of the graph part in --stat output. If set, applies
+	to all commands generating --stat outuput except format-patch.
+
 diff.external::
 	If this config variable is set, diff generation is not
 	performed using the internal diff machinery, but using the
diff --git a/Documentation/diff-options.txt b/Documentation/diff-option=
s.txt
index d34efd5..87f0a5f 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -54,13 +54,15 @@ endif::git-format-patch[]
=20
 --stat[=3D<width>[,<name-width>[,<count>]]]::
 	Generate a diffstat. By default, as much space as necessary
-	will be used for the filename part, and the rest for
-	the graph part. Maximum width defaults to terminal width,
-	or 80 columns if not connected to a terminal, and can be
-	overriden by `<width>`. The width of the filename part can be
-	limited by giving another width `<name-width>` after a comma.
-	The width of the graph part can be limited by using
-	`--stat-graph-width=3D<width>`.
+	will be used for the filename part, and the rest for the graph
+	part. Maximum width defaults to terminal width, or 80 columns
+	if not connected to a terminal, and can be overriden by
+	`<width>`. The width of the filename part can be limited by
+	giving another width `<name-width>` after a comma. The width
+	of the graph part can be limited by using
+	`--stat-graph-width=3D<width>` (affects all commands generating
+	a stat graph) or by setting `diff.statGraphWidth=3D<width>`
+	(does not affect `git format-patch`).
 	By giving a third parameter `<count>`, you can limit the
 	output to the first `<count>` lines, followed by `...` if
 	there are more.
diff --git a/builtin/diff.c b/builtin/diff.c
index 81b6bae..424c815 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -285,8 +285,9 @@ int cmd_diff(int argc, const char **argv, const cha=
r *prefix)
 	/* Otherwise, we are doing the usual "git" diff */
 	rev.diffopt.skip_stat_unmatch =3D !!diff_auto_refresh_index;
=20
-	/* Scale to real terminal size */
+	/* Scale to real terminal size and respect statGraphWidth config */
 	rev.diffopt.stat_width =3D -1;
+	rev.diffopt.stat_graph_width =3D -1;
=20
 	/* Default to let external and textconv be used */
 	DIFF_OPT_SET(&rev.diffopt, ALLOW_EXTERNAL);
diff --git a/builtin/log.c b/builtin/log.c
index 075a427..8a47012 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -78,6 +78,7 @@ static void cmd_log_init_defaults(struct rev_info *re=
v)
 	rev->verbose_header =3D 1;
 	DIFF_OPT_SET(&rev->diffopt, RECURSIVE);
 	rev->diffopt.stat_width =3D -1; /* use full terminal width */
+	rev->diffopt.stat_graph_width =3D -1; /* respect statGraphWidth confi=
g */
 	rev->abbrev_commit =3D default_abbrev_commit;
 	rev->show_root_diff =3D default_show_root;
 	rev->subject_prefix =3D fmt_patch_subject_prefix;
diff --git a/builtin/merge.c b/builtin/merge.c
index b1cd90c..34a5034 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -400,6 +400,7 @@ static void finish(struct commit *head_commit,
 		struct diff_options opts;
 		diff_setup(&opts);
 		opts.stat_width =3D -1; /* use full terminal width */
+		opts.stat_graph_width =3D -1; /* respect statGraphWidth config */
 		opts.output_format |=3D
 			DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
 		opts.detect_rename =3D DIFF_DETECT_RENAME;
diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 78be195..bacf403 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2118,6 +2118,7 @@ _git_config ()
 		core.whitespace
 		core.worktree
 		diff.autorefreshindex
+		diff.statGraphWidth
 		diff.external
 		diff.ignoreSubmodules
 		diff.mnemonicprefix
diff --git a/diff.c b/diff.c
index 8f2abc8..4525cda 100644
--- a/diff.c
+++ b/diff.c
@@ -31,6 +31,7 @@ static const char *external_diff_cmd_cfg;
 int diff_auto_refresh_index =3D 1;
 static int diff_mnemonic_prefix;
 static int diff_no_prefix;
+static int diff_stat_graph_width;
 static int diff_dirstat_permille_default =3D 30;
 static struct diff_options default_diff_options;
=20
@@ -156,6 +157,10 @@ int git_diff_ui_config(const char *var, const char=
 *value, void *cb)
 		diff_no_prefix =3D git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "diff.statgraphwidth")) {
+		diff_stat_graph_width =3D git_config_int(var, value);
+		return 0;
+	}
 	if (!strcmp(var, "diff.external"))
 		return git_config_string(&external_diff_cmd_cfg, var, value);
 	if (!strcmp(var, "diff.wordregex"))
@@ -1398,6 +1403,9 @@ static void show_stats(struct diffstat_t *data, s=
truct diff_options *options)
 	else
 		width =3D options->stat_width ? options->stat_width : 80;
=20
+	if (options->stat_graph_width =3D=3D -1)
+		options->stat_graph_width =3D diff_stat_graph_width;
+
 	/*
 	 * Guarantee 3/8*16=3D=3D6 for the graph part
 	 * and 5/8*16=3D=3D10 for the filename part
diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index 3d823af..328aa8f 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
@@ -112,6 +112,12 @@ do
 		grep " | " output >actual &&
 		test_cmp "$expect" actual
 	'
+
+	test_expect_success "$cmd $verb statGraphWidth config" '
+		git -c diff.statGraphWidth=3D26 $cmd $args >output
+		grep " | " output >actual &&
+		test_cmp "$expect" actual
+	'
 done <<\EOF
 ignores expect80 format-patch -1 --stdout
 respects expect40 diff HEAD^ HEAD --stat
--=20
1.7.9.2.399.gdf4d.dirty
