From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH 9/9] Add git-check-ignores
Date: Sun,  2 Sep 2012 01:12:11 +0100
Message-ID: <1346544731-938-10-git-send-email-git@adamspiers.org>
References: <1346544731-938-1-git-send-email-git@adamspiers.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 02 02:20:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7xvC-0001VH-Bp
	for gcvg-git-2@plane.gmane.org; Sun, 02 Sep 2012 02:20:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755058Ab2IBATy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Sep 2012 20:19:54 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:55524 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754181Ab2IBATB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2012 20:19:01 -0400
Received: from localhost (f.8.b.2.1.5.e.f.f.f.4.f.0.4.2.0.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:240:f4ff:fe51:2b8f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 028A12E5EF;
	Sun,  2 Sep 2012 01:12:22 +0100 (BST)
X-Mailer: git-send-email 1.7.12.155.ge5750d5.dirty
In-Reply-To: <1346544731-938-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204657>

This works in a similar manner to git-check-attr.  Some code
was reused from add.c by refactoring out into pathspec.c.

Thanks to Jeff King and Junio C Hamano for the idea:
http://thread.gmane.org/gmane.comp.version-control.git/108671/focus=108815

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 .gitignore                             |   1 +
 Documentation/git-check-ignore.txt     |  58 +++++++
 Documentation/gitignore.txt            |   6 +-
 Makefile                               |   1 +
 builtin.h                              |   1 +
 builtin/add.c                          |   2 +-
 builtin/check-ignore.c                 | 150 ++++++++++++++++
 command-list.txt                       |   1 +
 contrib/completion/git-completion.bash |   1 +
 git.c                                  |   1 +
 t/t0007-ignores.sh                     | 301 +++++++++++++++++++++++++++++++++
 11 files changed, 520 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/git-check-ignore.txt
 create mode 100644 builtin/check-ignore.c
 create mode 100755 t/t0007-ignores.sh

diff --git a/.gitignore b/.gitignore
index bb5c91e..0cbe94c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -22,6 +22,7 @@
 /git-bundle
 /git-cat-file
 /git-check-attr
+/git-check-ignore
 /git-check-ref-format
 /git-checkout
 /git-checkout-index
diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-check-ignore.txt
new file mode 100644
index 0000000..3a85dbb
--- /dev/null
+++ b/Documentation/git-check-ignore.txt
@@ -0,0 +1,58 @@
+git-check-ignore(1)
+=================
+
+NAME
+----
+git-check-ignore - Debug gitignore / exclude files
+
+
+SYNOPSIS
+--------
+[verse]
+'git check-ignore' pathname...
+'git check-ignore' --stdin [-z] < <list-of-paths>
+
+DESCRIPTION
+-----------
+
+For each pathname given via the command-line or from a file via
+`--stdin`, this command will list the first exclude pattern found (if
+any) which explicitly excludes or includes that pathname.  Note that
+within any given exclude file, later patterns take precedence over
+earlier ones, so any matching pattern which this command outputs may
+not be the one you would immediately expect.
+
+OPTIONS
+-------
+--stdin::
+	Read file names from stdin instead of from the command-line.
+
+-z::
+	Only meaningful with `--stdin`; paths are separated with a
+	NUL character instead of a linefeed character.
+
+OUTPUT
+------
+
+The output is a series of lines of the form:
+
+<path> COLON SP <type> SP <pattern> SP <source> SP <position> LF
+
+<path> is the path of a file being queried, <type> is either
+'excluded' or 'included' (for patterns prefixed with '!'), <pattern>
+is the matching pattern, <source> is the pattern's source file (either
+as an absolute path or relative to the repository root), and
+<position> is the position of the pattern within that source.
+
+If no pattern matches a given path, nothing will be output for that
+path.
+
+SEE ALSO
+--------
+linkgit:gitignore[5]
+linkgit:gitconfig[5]
+linkgit:git-ls-files[5]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index c1f692a..7ba16fe 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -155,8 +155,10 @@ The second .gitignore prevents git from ignoring
 
 SEE ALSO
 --------
-linkgit:git-rm[1], linkgit:git-update-index[1],
-linkgit:gitrepository-layout[5]
+linkgit:git-rm[1],
+linkgit:git-update-index[1],
+linkgit:gitrepository-layout[5],
+linkgit:git-check-ignore[1]
 
 GIT
 ---
diff --git a/Makefile b/Makefile
index 272ab69..ce5e42f 100644
--- a/Makefile
+++ b/Makefile
@@ -825,6 +825,7 @@ BUILTIN_OBJS += builtin/branch.o
 BUILTIN_OBJS += builtin/bundle.o
 BUILTIN_OBJS += builtin/cat-file.o
 BUILTIN_OBJS += builtin/check-attr.o
+BUILTIN_OBJS += builtin/check-ignore.o
 BUILTIN_OBJS += builtin/check-ref-format.o
 BUILTIN_OBJS += builtin/checkout-index.o
 BUILTIN_OBJS += builtin/checkout.o
diff --git a/builtin.h b/builtin.h
index 8e37752..f812c97 100644
--- a/builtin.h
+++ b/builtin.h
@@ -57,6 +57,7 @@ extern int cmd_cat_file(int argc, const char **argv, const char *prefix);
 extern int cmd_checkout(int argc, const char **argv, const char *prefix);
 extern int cmd_checkout_index(int argc, const char **argv, const char *prefix);
 extern int cmd_check_attr(int argc, const char **argv, const char *prefix);
+extern int cmd_check_ignore(int argc, const char **argv, const char *prefix);
 extern int cmd_check_ref_format(int argc, const char **argv, const char *prefix);
 extern int cmd_cherry(int argc, const char **argv, const char *prefix);
 extern int cmd_cherry_pick(int argc, const char **argv, const char *prefix);
diff --git a/builtin/add.c b/builtin/add.c
index a7ed2ad..af68c32 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -273,7 +273,7 @@ static int add_files(struct dir_struct *dir, int flags)
 		fprintf(stderr, _(ignore_error));
 		for (i = 0; i < dir->ignored_nr; i++)
 			fprintf(stderr, "%s\n", dir->ignored[i]->name);
-		fprintf(stderr, _("Use -f if you really want to add them.\n"));
+		fprintf(stderr, _("Use -f if you really want to add them, or git check-ignore to see\nwhy they're ignored.\n"));
 		die(_("no files added"));
 	}
 
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
new file mode 100644
index 0000000..146c00b
--- /dev/null
+++ b/builtin/check-ignore.c
@@ -0,0 +1,150 @@
+#include "builtin.h"
+#include "cache.h"
+#include "dir.h"
+#include "quote.h"
+#include "pathspec.h"
+#include "parse-options.h"
+
+static int stdin_paths;
+static const char * const check_ignore_usage[] = {
+"git check-ignore pathname...",
+"git check-ignore --stdin [-z] < <list-of-paths>",
+NULL
+};
+
+static int null_term_line;
+
+static const struct option check_ignore_options[] = {
+	OPT_BOOLEAN(0 , "stdin", &stdin_paths, "read file names from stdin"),
+	OPT_BOOLEAN('z', NULL, &null_term_line,
+		"input paths are terminated by a null character"),
+	OPT_END()
+};
+
+static void output_exclude(const char *path, struct exclude *exclude)
+{
+	char *type = exclude->to_exclude ? "excluded" : "included";
+	char *bang = exclude->to_exclude ? "" : "!";
+	char *dir  = (exclude->flags & EXC_FLAG_MUSTBEDIR) ? "/" : "";
+	printf(_("%s: %s %s%s%s "), path, type, bang, exclude->pattern, dir);
+	if (exclude->srcpos > 0) {
+		printf("%s %d", exclude->src, exclude->srcpos);
+	}
+	else {
+		/* Exclude was from CLI parameter.  This code path is
+		 * currently impossible to hit, but later on we might
+		 * want to add ignore tracing to other commands such
+		 * as git clean, which does accept --exclude.
+		 */
+		/* printf("%s %d", exclude->src, -exclude->srcpos); */
+	}
+	printf("\n");
+}
+
+static void check_ignore(const char *prefix, const char **pathspec)
+{
+	struct dir_struct dir;
+	const char *path;
+	char *seen = NULL;
+
+	/* read_cache() is only necessary so we can watch out for submodules. */
+	if (read_cache() < 0)
+		die(_("index file corrupt"));
+
+	memset(&dir, 0, sizeof(dir));
+	dir.flags |= DIR_COLLECT_IGNORED;
+	setup_standard_excludes(&dir);
+
+	if (pathspec) {
+		int i;
+		struct path_exclude_check check;
+		struct exclude *exclude;
+
+		path_exclude_check_init(&check, &dir);
+		if (!seen)
+			seen = find_used_pathspec(pathspec);
+		for (i = 0; pathspec[i]; i++) {
+			path = pathspec[i];
+			char *full_path =
+				prefix_path(prefix, prefix ? strlen(prefix) : 0, path);
+			treat_gitlink(full_path);
+			validate_path(prefix, full_path);
+			if (!seen[i] && path[0]) {
+				int dtype = DT_UNKNOWN;
+				exclude = path_excluded_1(&check, full_path, -1, &dtype);
+				if (exclude) {
+					output_exclude(path, exclude);
+				}
+			}
+		}
+		free(seen);
+		free_directory(&dir);
+		path_exclude_check_clear(&check);
+	}
+	else {
+		printf("no pathspec\n");
+	}
+}
+
+static void check_ignore_stdin_paths(const char *prefix)
+{
+	struct strbuf buf, nbuf;
+	char **pathspec = NULL;
+	size_t nr = 0, alloc = 0;
+	int line_termination = null_term_line ? 0 : '\n';
+
+	strbuf_init(&buf, 0);
+	strbuf_init(&nbuf, 0);
+	while (strbuf_getline(&buf, stdin, line_termination) != EOF) {
+		if (line_termination && buf.buf[0] == '"') {
+			strbuf_reset(&nbuf);
+			if (unquote_c_style(&nbuf, buf.buf, NULL))
+				die("line is badly quoted");
+			strbuf_swap(&buf, &nbuf);
+		}
+		ALLOC_GROW(pathspec, nr + 1, alloc);
+		pathspec[nr] = xcalloc(strlen(buf.buf) + 1, sizeof(*buf.buf));
+		strcpy(pathspec[nr++], buf.buf);
+	}
+	ALLOC_GROW(pathspec, nr + 1, alloc);
+	pathspec[nr] = NULL;
+	check_ignore(prefix, (const char **)pathspec);
+	maybe_flush_or_die(stdout, "attribute to stdout");
+	strbuf_release(&buf);
+	strbuf_release(&nbuf);
+	free(pathspec);
+}
+
+static NORETURN void error_with_usage(const char *msg)
+{
+	error("%s", msg);
+	usage_with_options(check_ignore_usage, check_ignore_options);
+}
+
+int cmd_check_ignore(int argc, const char **argv, const char *prefix)
+{
+	git_config(git_default_config, NULL);
+
+	argc = parse_options(argc, argv, prefix, check_ignore_options,
+			     check_ignore_usage, 0);
+
+	if (stdin_paths) {
+		if (0 < argc)
+			error_with_usage("Can't specify files with --stdin");
+	} else {
+		if (null_term_line)
+			error_with_usage("-z only makes sense with --stdin");
+
+		if (argc == 0)
+			error_with_usage("No path specified");
+	}
+
+	if (stdin_paths)
+		check_ignore_stdin_paths(prefix);
+	else {
+		check_ignore(prefix, argv);
+		maybe_flush_or_die(stdout, "ignore to stdout");
+	}
+
+	return 0;
+}
diff --git a/command-list.txt b/command-list.txt
index 7e8cfec..bf83303 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -12,6 +12,7 @@ git-branch                              mainporcelain common
 git-bundle                              mainporcelain
 git-cat-file                            plumbinginterrogators
 git-check-attr                          purehelpers
+git-check-ignore                        purehelpers
 git-checkout                            mainporcelain common
 git-checkout-index                      plumbingmanipulators
 git-check-ref-format                    purehelpers
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 222b804..26d798f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -594,6 +594,7 @@ __git_list_porcelain_commands ()
 		archimport)       : import;;
 		cat-file)         : plumbing;;
 		check-attr)       : plumbing;;
+		check-ignore)     : plumbing;;
 		check-ref-format) : plumbing;;
 		checkout-index)   : plumbing;;
 		commit-tree)      : plumbing;;
diff --git a/git.c b/git.c
index 8788b32..6caf78a 100644
--- a/git.c
+++ b/git.c
@@ -338,6 +338,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "bundle", cmd_bundle, RUN_SETUP_GENTLY },
 		{ "cat-file", cmd_cat_file, RUN_SETUP },
 		{ "check-attr", cmd_check_attr, RUN_SETUP },
+		{ "check-ignore", cmd_check_ignore, RUN_SETUP | NEED_WORK_TREE },
 		{ "check-ref-format", cmd_check_ref_format },
 		{ "checkout", cmd_checkout, RUN_SETUP | NEED_WORK_TREE },
 		{ "checkout-index", cmd_checkout_index,
diff --git a/t/t0007-ignores.sh b/t/t0007-ignores.sh
new file mode 100755
index 0000000..4407634
--- /dev/null
+++ b/t/t0007-ignores.sh
@@ -0,0 +1,301 @@
+#!/bin/sh
+
+test_description=gitignores
+
+. ./test-lib.sh
+
+init_vars () {
+	global_excludes="$HOME/global-excludes"
+}
+
+enable_global_excludes () {
+	init_vars
+	git config core.excludesfile "$global_excludes"
+}
+
+ignore_check () {
+	paths="$1" expected="$2" global_args="$3"
+
+	if test -z "$expected"; then
+	    >"$HOME/expected" # avoid newline
+	else
+	    echo "$expected" >"$HOME/expected"
+	fi &&
+	run_check_ignore "$paths" "$global_args"
+}
+
+expect () {
+	echo "$*" >"$HOME/expected"
+}
+
+run_check_ignore () {
+	args="$1" global_args="$2"
+
+	init_vars &&
+	rm -f "$HOME/stdout" "$HOME/stderr" "$HOME/cmd" &&
+	echo `which git` $global_args check-ignore $args >"$HOME/cmd" &&
+	pwd >"$HOME/pwd" &&
+	git $global_args check-ignore $args >"$HOME/stdout" 2>"$HOME/stderr" &&
+	test_cmp "$HOME/expected" "$HOME/stdout" &&
+	test_line_count = 0 "$HOME/stderr"
+}
+
+test_expect_success 'setup' '
+	init_vars
+	mkdir -p a/b/ignored-dir a/submodule b &&
+	ln -s b a/symlink &&
+	(
+		cd a/submodule &&
+		git init &&
+		echo a > a &&
+		git add a &&
+		git commit -m"commit in submodule"
+	) &&
+	git add a/submodule &&
+	cat <<-EOF >.gitignore &&
+		one
+	EOF
+	cat <<-EOF >a/.gitignore &&
+		two*
+		*three
+	EOF
+	cat <<-EOF >a/b/.gitignore &&
+		four
+		five
+		# this comment should affect the line numbers
+		six
+		ignored-dir/
+		# and so should this blank line:
+
+		!on*
+		!two
+	EOF
+	echo "seven" >a/b/ignored-dir/.gitignore &&
+	test -n "$HOME" &&
+	cat <<-EOF >"$global_excludes"
+		globalone
+		!globaltwo
+		globalthree
+	EOF
+'
+
+test_expect_success 'empty command line' '
+	test_must_fail git check-ignore 2>"$HOME/stderr" &&
+	grep -q "error: No path specified" "$HOME/stderr"
+'
+
+test_expect_success 'erroneous use of --' '
+	test_must_fail git check-ignore -- 2>"$HOME/stderr" &&
+	grep -q "error: No path specified" "$HOME/stderr"
+'
+
+test_expect_success '--stdin with superfluous arg' '
+	test_must_fail git check-ignore --stdin foo 2>"$HOME/stderr" &&
+	grep -q "Can'\''t specify files with --stdin" "$HOME/stderr"
+'
+
+test_expect_success '--stdin -z with superfluous arg' '
+	test_must_fail git check-ignore --stdin -z foo 2>"$HOME/stderr" &&
+	grep -q "Can'\''t specify files with --stdin" "$HOME/stderr"
+'
+
+test_expect_success '-z without --stdin' '
+	test_must_fail git check-ignore -z 2>"$HOME/stderr" &&
+	grep -q "error: -z only makes sense with --stdin" "$HOME/stderr"
+'
+
+test_expect_success '-z without --stdin and superfluous arg' '
+	test_must_fail git check-ignore -z foo 2>"$HOME/stderr" &&
+	grep -q "error: -z only makes sense with --stdin" "$HOME/stderr"
+'
+
+test_expect_success 'needs work tree' '
+	(
+		cd .git &&
+		test_must_fail git check-ignore foo 2>"$HOME/stderr"
+	) &&
+	grep -q "fatal: This operation must be run in a work tree" "$HOME/stderr"
+
+'
+test_expect_success 'top-level not ignored' '
+	ignore_check foo ""
+'
+
+test_expect_success 'top-level ignored' '
+	ignore_check one "one: excluded one .gitignore 1"
+'
+
+test_expect_success 'sub-directory ignore from top' '
+	expect "a/one: excluded one .gitignore 1" &&
+	run_check_ignore a/one
+'
+
+test_expect_success 'sub-directory local ignore' '
+	expect "a/3-three: excluded *three a/.gitignore 2" &&
+	run_check_ignore "a/3-three a/three-not-this-one"
+'
+
+test_expect_success 'sub-directory local ignore inside a' '
+	expect "3-three: excluded *three a/.gitignore 2" &&
+	(
+		cd a &&
+		run_check_ignore "3-three three-not-this-one"
+	)
+'
+
+test_expect_success 'nested include' '
+	expect "a/b/one: included !on* a/b/.gitignore 8" &&
+	run_check_ignore "a/b/one"
+'
+
+test_expect_success 'ignored sub-directory' '
+	expect "a/b/ignored-dir: excluded ignored-dir/ a/b/.gitignore 5" &&
+	run_check_ignore "a/b/ignored-dir"
+'
+
+test_expect_success 'multiple files inside ignored sub-directory' '
+	cat <<-EOF >"$HOME/expected" &&
+		a/b/ignored-dir/foo: excluded ignored-dir/ a/b/.gitignore 5
+		a/b/ignored-dir/twoooo: excluded ignored-dir/ a/b/.gitignore 5
+		a/b/ignored-dir/seven: excluded ignored-dir/ a/b/.gitignore 5
+	EOF
+	run_check_ignore "a/b/ignored-dir/foo a/b/ignored-dir/twoooo a/b/ignored-dir/seven"
+'
+
+test_expect_success 'cd to ignored sub-directory' '
+	cat <<-EOF >"$HOME/expected" &&
+		foo: excluded ignored-dir/ a/b/.gitignore 5
+		twoooo: excluded ignored-dir/ a/b/.gitignore 5
+		../one: included !on* a/b/.gitignore 8
+		seven: excluded ignored-dir/ a/b/.gitignore 5
+		../../one: excluded one .gitignore 1
+	EOF
+	(
+		cd a/b/ignored-dir &&
+		run_check_ignore "foo twoooo ../one seven ../../one"
+	)
+'
+
+test_expect_success 'symlink' '
+	ignore_check "a/symlink" ""
+'
+
+test_expect_success 'beyond a symlink' '
+	test_must_fail git check-ignore "a/symlink/foo"
+'
+
+test_expect_success 'beyond a symlink from subdirectory' '
+	(
+		cd a &&
+		test_must_fail git check-ignore "symlink/foo"
+	)
+'
+
+test_expect_success 'submodule' '
+	test_must_fail git check-ignore "a/submodule/one" 2>"$HOME/stderr" &&
+	expect "fatal: Path '\''a/submodule/one'\'' is in submodule '\''a/submodule'\''" &&
+	test_cmp "$HOME/expected" "$HOME/stderr"
+'
+
+test_expect_success 'submodule from subdirectory' '
+	(
+		cd a &&
+		test_must_fail git check-ignore "submodule/one" 2>"$HOME/stderr"
+	) &&
+	expect "fatal: Path '\''a/submodule/one'\'' is in submodule '\''a/submodule'\''" &&
+	test_cmp "$HOME/expected" "$HOME/stderr"
+'
+
+test_expect_success 'global ignore not yet enabled' '
+	expect "a/globalthree: excluded *three a/.gitignore 2" &&
+	run_check_ignore "globalone a/globalthree a/globaltwo"
+'
+
+test_expect_success 'global ignore' '
+	enable_global_excludes &&
+	cat <<-EOF >"$HOME/expected" &&
+		globalone: excluded globalone $global_excludes 1
+		globalthree: excluded globalthree $global_excludes 3
+		a/globalthree: excluded *three a/.gitignore 2
+		globaltwo: included !globaltwo $global_excludes 2
+	EOF
+	run_check_ignore "globalone globalthree a/globalthree globaltwo"
+'
+
+test_expect_success '--stdin' '
+	cat <<-EOF >in.txt &&
+		one
+		a/one
+		a/b/on
+		a/b/one
+		a/b/two
+		a/b/twooo
+		globaltwo
+		a/globaltwo
+		a/b/globaltwo
+		b/globaltwo
+	EOF
+	cat <<-EOF >"$HOME/expected" &&
+		one: excluded one .gitignore 1
+		a/one: excluded one .gitignore 1
+		a/b/on: included !on* a/b/.gitignore 8
+		a/b/one: included !on* a/b/.gitignore 8
+		a/b/two: included !two a/b/.gitignore 9
+		a/b/twooo: excluded two* a/.gitignore 1
+		globaltwo: included !globaltwo $global_excludes 2
+		a/globaltwo: included !globaltwo $global_excludes 2
+		a/b/globaltwo: included !globaltwo $global_excludes 2
+		b/globaltwo: included !globaltwo $global_excludes 2
+	EOF
+	run_check_ignore --stdin < in.txt
+'
+
+test_expect_success '--stdin -z' '
+	tr "\n" "\0" < in.txt | run_check_ignore "--stdin -z"
+'
+
+test_expect_success '-z --stdin' '
+	tr "\n" "\0" < in.txt | run_check_ignore "-z --stdin"
+'
+
+test_expect_success '--stdin from subdirectory' '
+	cat <<-EOF >in.txt &&
+		../one
+		one
+		b/on
+		b/one
+		b/two
+		b/twooo
+		../globaltwo
+		globaltwo
+		b/globaltwo
+		../b/globaltwo
+	EOF
+	cat <<-EOF >"$HOME/expected" &&
+		../one: excluded one .gitignore 1
+		one: excluded one .gitignore 1
+		b/on: included !on* a/b/.gitignore 8
+		b/one: included !on* a/b/.gitignore 8
+		b/two: included !two a/b/.gitignore 9
+		b/twooo: excluded two* a/.gitignore 1
+		../globaltwo: included !globaltwo $global_excludes 2
+		globaltwo: included !globaltwo $global_excludes 2
+		b/globaltwo: included !globaltwo $global_excludes 2
+		../b/globaltwo: included !globaltwo $global_excludes 2
+	EOF
+	(
+		cd a &&
+		run_check_ignore --stdin < ../in.txt
+	)
+'
+
+test_expect_success '--stdin -z from subdirectory' '
+	tr "\n" "\0" < in.txt | ( cd a && run_check_ignore "--stdin -z" )
+'
+
+test_expect_success '-z --stdin from subdirectory' '
+	tr "\n" "\0" < in.txt | ( cd a && run_check_ignore "-z --stdin" )
+'
+
+
+test_done
-- 
1.7.12.155.ge5750d5.dirty
