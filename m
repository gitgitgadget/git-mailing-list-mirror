From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH v2] parse-opt: migrate builtin-apply.
Date: Sat, 27 Dec 2008 15:22:44 +0100
Message-ID: <1230387764-11230-1-git-send-email-vmiklos@frugalware.org>
References: <20081227140533.GX21154@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 27 15:22:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGa3U-0008UF-67
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 15:22:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753931AbYL0OUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Dec 2008 09:20:54 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753926AbYL0OUx
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Dec 2008 09:20:53 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:34723 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753909AbYL0OUw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Dec 2008 09:20:52 -0500
Received: from vmobile.example.net (dsl5401C137.pool.t-online.hu [84.1.193.55])
	by yugo.frugalware.org (Postfix) with ESMTPA id 7A931446CDF;
	Sat, 27 Dec 2008 15:20:49 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id DFA0619DBE1; Sat, 27 Dec 2008 15:22:44 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc1.35.gae26e.dirty
In-Reply-To: <20081227140533.GX21154@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104006>

The only incompatible change is that the user how have to use '--'
before a patch named --build-fake-ancestor=3Dsomething.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

Diffstat against v1:

 builtin-apply.c |  125 +++++++++++++----------------------------------=
--------
 1 files changed, 29 insertions(+), 96 deletions(-)

due to the removal of option_parse_stat, option_parse_numstat,
option_parse_summary, option_parse_check, option_parse_index,
option_parse_cached, option_parse_ancestor and option_parse_reject.

 Documentation/git-apply.txt |    4 +-
 builtin-apply.c             |  293 ++++++++++++++++++++++++-----------=
--------
 2 files changed, 167 insertions(+), 130 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index e726510..9400f6a 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git apply' [--stat] [--numstat] [--summary] [--check] [--index]
-	  [--apply] [--no-add] [--build-fake-ancestor <file>] [-R | --reverse=
]
+	  [--apply] [--no-add] [--build-fake-ancestor=3D<file>] [-R | --rever=
se]
 	  [--allow-binary-replacement | --binary] [--reject] [-z]
 	  [-pNUM] [-CNUM] [--inaccurate-eof] [--recount] [--cached]
 	  [--whitespace=3D<nowarn|warn|fix|error|error-all>]
@@ -64,7 +64,7 @@ OPTIONS
 	cached data, apply the patch, and store the result in the index,
 	without using the working tree. This implies '--index'.
=20
---build-fake-ancestor <file>::
+--build-fake-ancestor=3D<file>::
 	Newer 'git-diff' output has embedded 'index information'
 	for each blob to help identify the original version that
 	the patch applies to.  When this flag is given, and if
diff --git a/builtin-apply.c b/builtin-apply.c
index 07244b0..98a988c 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -14,6 +14,7 @@
 #include "builtin.h"
 #include "string-list.h"
 #include "dir.h"
+#include "parse-options.h"
=20
 /*
  *  --check turns on checking that the working tree matches the
@@ -46,8 +47,10 @@ static int no_add;
 static const char *fake_ancestor;
 static int line_termination =3D '\n';
 static unsigned long p_context =3D ULONG_MAX;
-static const char apply_usage[] =3D
-"git apply [--stat] [--numstat] [--summary] [--check] [--index] [--cac=
hed] [--apply] [--no-add] [--index-info] [--allow-binary-replacement] [=
--reverse] [--reject] [--verbose] [-z] [-pNUM] [-CNUM] [--whitespace=3D=
<nowarn|warn|fix|error|error-all>] <patch>...";
+static const char * const apply_usage[] =3D {
+	"git apply [--stat] [--numstat] [--summary] [--check] [--index] [--ca=
ched] [--apply] [--no-add] [--index-info] [--allow-binary-replacement] =
[--reverse] [--reject] [--verbose] [-z] [-pNUM] [-CNUM] [--whitespace=3D=
<nowarn|warn|fix|error|error-all>] <patch>...",
+	NULL
+};
=20
 static enum ws_error_action {
 	nowarn_ws_error,
@@ -61,6 +64,8 @@ static int applied_after_fixing_ws;
 static const char *patch_input_file;
 static const char *root;
 static int root_len;
+static int read_stdin =3D 1;
+static int options;
=20
 static void parse_whitespace_option(const char *option)
 {
@@ -3135,150 +3140,182 @@ static int git_apply_config(const char *var, =
const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
=20
+static int option_parse_stdin(const struct option *opt,
+			      const char *arg, int unset)
+{
+	int *errs =3D opt->value;
+
+	*errs |=3D apply_patch(0, "<stdin>", options);
+	read_stdin =3D 0;
+	return 0;
+}
+
+static int option_parse_exclude(const struct option *opt,
+				const char *arg, int unset)
+{
+	add_name_limit(arg, 1);
+	return 0;
+}
+
+static int option_parse_include(const struct option *opt,
+				const char *arg, int unset)
+{
+	add_name_limit(arg, 0);
+	has_include =3D 1;
+	return 0;
+}
+
+static int option_parse_p(const struct option *opt,
+			  const char *arg, int unset)
+{
+	p_value =3D atoi(arg);
+	p_value_known =3D 1;
+	return 0;
+}
+
+static int option_parse_z(const struct option *opt,
+			  const char *arg, int unset)
+{
+	if (unset)
+		line_termination =3D '\n';
+	else
+		line_termination =3D 0;
+	return 0;
+}
+
+static int option_parse_whitespace(const struct option *opt,
+				   const char *arg, int unset)
+{
+	const char **whitespace_option =3D opt->value;
+
+	*whitespace_option =3D arg;
+	parse_whitespace_option(arg);
+	return 0;
+}
+
+static int option_parse_inaccurate(const struct option *opt,
+				   const char *arg, int unset)
+{
+	options |=3D INACCURATE_EOF;
+	return 0;
+}
+
+static int option_parse_recount(const struct option *opt,
+				const char *arg, int unset)
+{
+	options |=3D RECOUNT;
+	return 0;
+}
+
+static int option_parse_directory(const struct option *opt,
+				  const char *arg, int unset)
+{
+	root_len =3D strlen(arg);
+	if (root_len && arg[root_len - 1] !=3D '/') {
+		char *new_root;
+		root =3D new_root =3D xmalloc(root_len + 2);
+		strcpy(new_root, arg);
+		strcpy(new_root + root_len++, "/");
+	} else
+		root =3D arg;
+	return 0;
+}
=20
 int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 {
 	int i;
-	int read_stdin =3D 1;
-	int options =3D 0;
 	int errs =3D 0;
 	int is_not_gitdir;
+	int binary;
+	int force_apply =3D 0;
=20
 	const char *whitespace_option =3D NULL;
=20
+	struct option builtin_apply_options[] =3D {
+		{ OPTION_CALLBACK, '-', NULL, &errs, NULL,
+			"read the patch from the standard input",
+			PARSE_OPT_NOARG, option_parse_stdin },
+		{ OPTION_CALLBACK, 0, "exclude", NULL, "path",
+			"don=B4t apply changes matching the given path",
+			0, option_parse_exclude },
+		{ OPTION_CALLBACK, 0, "include", NULL, "path",
+			"apply changes matching the given path",
+			0, option_parse_include },
+		{ OPTION_CALLBACK, 'p', NULL, NULL, "num",
+			"remove <num> leading slashes from traditional diff paths",
+			0, option_parse_p },
+		OPT_BOOLEAN(0, "no-add", &no_add,
+			"ignore additions made by the patch"),
+		OPT_BOOLEAN(0, "stat", &diffstat,
+			"instead of applying the patch, output diffstat for the input"),
+		OPT_BOOLEAN(0, "allow-binary-replacement", &binary,
+			"now no-op"),
+		OPT_BOOLEAN(0, "binary", &binary,
+			"now no-op"),
+		OPT_BOOLEAN(0, "numstat", &numstat,
+			"shows number of added and deleted lines in decimal notation"),
+		OPT_BOOLEAN(0, "summary", &summary,
+			"instead of applying the patch, output a summary for the input"),
+		OPT_BOOLEAN(0, "check", &check,
+			"instead of applying the patch, see if the patch is applicable"),
+		OPT_BOOLEAN(0, "index", &check_index,
+			"make sure the patch is applicable to the current index"),
+		OPT_BOOLEAN(0, "cached", &cached,
+			"apply a patch without touching the working tree"),
+		OPT_BOOLEAN(0, "apply", &force_apply,
+			"also apply the patch (use with --stat/--summary/--check)"),
+		OPT_STRING(0, "build-fake-ancestor", &fake_ancestor, "file",
+			"build a temporary index based on embedded index information"),
+		{ OPTION_CALLBACK, 'z', NULL, NULL, NULL,
+			"paths are separated with NUL character",
+			PARSE_OPT_NOARG, option_parse_z },
+		OPT_INTEGER('C', NULL, &p_context,
+				"ensure at least <n> lines of context match"),
+		{ OPTION_CALLBACK, 0, "whitespace", &whitespace_option, "action",
+			"detect new or modified lines that have whitespace errors",
+			0, option_parse_whitespace },
+		OPT_BOOLEAN('R', "reverse", &apply_in_reverse,
+			"apply the patch in reverse"),
+		OPT_BOOLEAN(0, "unidiff-zero", &unidiff_zero,
+			"don't expect at least one line of context"),
+		OPT_BOOLEAN(0, "reject", &apply_with_reject,
+			"leave the rejected hunks in corresponding *.rej files"),
+		OPT__VERBOSE(&apply_verbosely),
+		{ OPTION_CALLBACK, 0, "inaccurate-eof", NULL, NULL,
+			"tolerate incorrectly detected missing new-line at the end of file"=
,
+			PARSE_OPT_NOARG, option_parse_inaccurate },
+		{ OPTION_CALLBACK, 0, "recount", NULL, NULL,
+			"do not trust the line counts in the hunk headers",
+			PARSE_OPT_NOARG, option_parse_recount },
+		{ OPTION_CALLBACK, 0, "directory", NULL, "root",
+			"prepend <root> to all filenames",
+			0, option_parse_directory },
+		OPT_END()
+	};
+
 	prefix =3D setup_git_directory_gently(&is_not_gitdir);
 	prefix_length =3D prefix ? strlen(prefix) : 0;
 	git_config(git_apply_config, NULL);
 	if (apply_default_whitespace)
 		parse_whitespace_option(apply_default_whitespace);
=20
-	for (i =3D 1; i < argc; i++) {
+	argc =3D parse_options(argc, argv, builtin_apply_options,
+			apply_usage, 0);
+	if (apply_with_reject)
+		apply =3D apply_verbosely =3D 1;
+	if (!force_apply && (diffstat || numstat || summary || check || fake_=
ancestor))
+		apply =3D 0;
+	if (check_index && is_not_gitdir)
+		die("--index outside a repository");
+	if (cached) {
+		if (is_not_gitdir)
+			die("--cached outside a repository");
+		check_index =3D 1;
+	}
+	for (i =3D 0; i < argc; i++) {
 		const char *arg =3D argv[i];
-		char *end;
 		int fd;
=20
-		if (!strcmp(arg, "-")) {
-			errs |=3D apply_patch(0, "<stdin>", options);
-			read_stdin =3D 0;
-			continue;
-		}
-		if (!prefixcmp(arg, "--exclude=3D")) {
-			add_name_limit(arg + 10, 1);
-			continue;
-		}
-		if (!prefixcmp(arg, "--include=3D")) {
-			add_name_limit(arg + 10, 0);
-			has_include =3D 1;
-			continue;
-		}
-		if (!prefixcmp(arg, "-p")) {
-			p_value =3D atoi(arg + 2);
-			p_value_known =3D 1;
-			continue;
-		}
-		if (!strcmp(arg, "--no-add")) {
-			no_add =3D 1;
-			continue;
-		}
-		if (!strcmp(arg, "--stat")) {
-			apply =3D 0;
-			diffstat =3D 1;
-			continue;
-		}
-		if (!strcmp(arg, "--allow-binary-replacement") ||
-		    !strcmp(arg, "--binary")) {
-			continue; /* now no-op */
-		}
-		if (!strcmp(arg, "--numstat")) {
-			apply =3D 0;
-			numstat =3D 1;
-			continue;
-		}
-		if (!strcmp(arg, "--summary")) {
-			apply =3D 0;
-			summary =3D 1;
-			continue;
-		}
-		if (!strcmp(arg, "--check")) {
-			apply =3D 0;
-			check =3D 1;
-			continue;
-		}
-		if (!strcmp(arg, "--index")) {
-			if (is_not_gitdir)
-				die("--index outside a repository");
-			check_index =3D 1;
-			continue;
-		}
-		if (!strcmp(arg, "--cached")) {
-			if (is_not_gitdir)
-				die("--cached outside a repository");
-			check_index =3D 1;
-			cached =3D 1;
-			continue;
-		}
-		if (!strcmp(arg, "--apply")) {
-			apply =3D 1;
-			continue;
-		}
-		if (!strcmp(arg, "--build-fake-ancestor")) {
-			apply =3D 0;
-			if (++i >=3D argc)
-				die ("need a filename");
-			fake_ancestor =3D argv[i];
-			continue;
-		}
-		if (!strcmp(arg, "-z")) {
-			line_termination =3D 0;
-			continue;
-		}
-		if (!prefixcmp(arg, "-C")) {
-			p_context =3D strtoul(arg + 2, &end, 0);
-			if (*end !=3D '\0')
-				die("unrecognized context count '%s'", arg + 2);
-			continue;
-		}
-		if (!prefixcmp(arg, "--whitespace=3D")) {
-			whitespace_option =3D arg + 13;
-			parse_whitespace_option(arg + 13);
-			continue;
-		}
-		if (!strcmp(arg, "-R") || !strcmp(arg, "--reverse")) {
-			apply_in_reverse =3D 1;
-			continue;
-		}
-		if (!strcmp(arg, "--unidiff-zero")) {
-			unidiff_zero =3D 1;
-			continue;
-		}
-		if (!strcmp(arg, "--reject")) {
-			apply =3D apply_with_reject =3D apply_verbosely =3D 1;
-			continue;
-		}
-		if (!strcmp(arg, "-v") || !strcmp(arg, "--verbose")) {
-			apply_verbosely =3D 1;
-			continue;
-		}
-		if (!strcmp(arg, "--inaccurate-eof")) {
-			options |=3D INACCURATE_EOF;
-			continue;
-		}
-		if (!strcmp(arg, "--recount")) {
-			options |=3D RECOUNT;
-			continue;
-		}
-		if (!prefixcmp(arg, "--directory=3D")) {
-			arg +=3D strlen("--directory=3D");
-			root_len =3D strlen(arg);
-			if (root_len && arg[root_len - 1] !=3D '/') {
-				char *new_root;
-				root =3D new_root =3D xmalloc(root_len + 2);
-				strcpy(new_root, arg);
-				strcpy(new_root + root_len++, "/");
-			} else
-				root =3D arg;
-			continue;
-		}
 		if (0 < prefix_length)
 			arg =3D prefix_filename(prefix, prefix_length, arg);
=20
--=20
1.6.1.rc1.35.gae26e.dirty
