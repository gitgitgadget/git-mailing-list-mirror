From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v2 14/14] Add git-check-ignore sub-command
Date: Thu, 20 Sep 2012 20:46:23 +0100
Message-ID: <1348170383-15751-15-git-send-email-git@adamspiers.org>
References: <7vvcfwf937.fsf@alter.siamese.dyndns.org>
 <1348170383-15751-1-git-send-email-git@adamspiers.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 20 21:47:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEmiZ-0000ut-Nm
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 21:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135Ab2ITTrF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 15:47:05 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:46206 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755022Ab2ITTqj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 15:46:39 -0400
Received: from localhost (f.8.b.2.1.5.e.f.f.f.4.f.0.4.2.0.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:240:f4ff:fe51:2b8f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id E84EB2E5EA;
	Thu, 20 Sep 2012 20:46:36 +0100 (BST)
X-Mailer: git-send-email 1.7.12.147.g6d168f4
In-Reply-To: <1348170383-15751-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206085>

This works in a similar manner to git-check-attr.  Some code
was reused from add.c by refactoring out into pathspec.c.

Thanks to Jeff King and Junio C Hamano for the idea:
http://thread.gmane.org/gmane.comp.version-control.git/108671/focus=108815

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 .gitignore                             |   1 +
 Documentation/git-check-ignore.txt     |  85 +++++
 Documentation/gitignore.txt            |   6 +-
 Makefile                               |   1 +
 builtin.h                              |   1 +
 builtin/check-ignore.c                 | 167 ++++++++++
 command-list.txt                       |   1 +
 contrib/completion/git-completion.bash |   1 +
 git.c                                  |   1 +
 t/t0007-ignores.sh                     | 587 +++++++++++++++++++++++++++++++++
 t/t9902-completion.sh                  |  24 +-
 11 files changed, 861 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/git-check-ignore.txt
 create mode 100644 builtin/check-ignore.c
 create mode 100755 t/t0007-ignores.sh

diff --git a/.gitignore b/.gitignore
index a188a82..11cd975 100644
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
index 0000000..2de4e17
--- /dev/null
+++ b/Documentation/git-check-ignore.txt
@@ -0,0 +1,85 @@
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
+'git check-ignore' [options] pathname...
+'git check-ignore' [options] --stdin < <list-of-paths>
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
+-q, --quiet::
+	Don't output anything, just set exit status.  This is only
+	valid with a single pathname.
+
+-v, --verbose::
+	Also output details about the matching pattern (if any)
+	for each given pathname.
+
+--stdin::
+	Read file names from stdin instead of from the command-line.
+
+-z::
+	The output format is modified to be machine-parseable (see
+	below).  If `--stdin` is also given, input paths are separated
+	with a NUL character instead of a linefeed character.
+
+OUTPUT
+------
+
+By default, any of the given pathnames which match an ignore pattern
+will be output, one per line.  If no pattern matches a given path,
+nothing will be output for that path; this means that path will not be
+ignored.
+
+If `--verbose` is specified, the output is a series of lines of the form:
+
+<source> <COLON> <linenum> <COLON> <pattern> <HT> <pathname>
+
+<pathname> is the path of a file being queried, <pattern> is the
+matching pattern, <source> is the pattern's source file, and <linenum>
+is the line number of the pattern within that source.  If the pattern
+contained a `!` prefix or `/` suffix, it will be preserved in the
+output.  <source> will be an absolute path when referring to the file
+configured by `core.excludesfile`, or relative to the repository root
+when referring to `.git/info/exclude` or a per-directory exclude file.
+
+If `-z` is specified, the output is a series of lines of the form:
+
+EXIT STATUS
+-----------
+
+0::
+	One or more of the provided paths is ignored.
+
+1::
+	None of the provided paths are ignored.
+
+128::
+	A fatal error was encountered.
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
index 9a4bf9e..2d78b83 100644
--- a/Makefile
+++ b/Makefile
@@ -834,6 +834,7 @@ BUILTIN_OBJS += builtin/branch.o
 BUILTIN_OBJS += builtin/bundle.o
 BUILTIN_OBJS += builtin/cat-file.o
 BUILTIN_OBJS += builtin/check-attr.o
+BUILTIN_OBJS += builtin/check-ignore.o
 BUILTIN_OBJS += builtin/check-ref-format.o
 BUILTIN_OBJS += builtin/checkout-index.o
 BUILTIN_OBJS += builtin/checkout.o
diff --git a/builtin.h b/builtin.h
index 95116b8..7519f81 100644
--- a/builtin.h
+++ b/builtin.h
@@ -55,6 +55,7 @@ extern int cmd_cat_file(int argc, const char **argv, const char *prefix);
 extern int cmd_checkout(int argc, const char **argv, const char *prefix);
 extern int cmd_checkout_index(int argc, const char **argv, const char *prefix);
 extern int cmd_check_attr(int argc, const char **argv, const char *prefix);
+extern int cmd_check_ignore(int argc, const char **argv, const char *prefix);
 extern int cmd_check_ref_format(int argc, const char **argv, const char *prefix);
 extern int cmd_cherry(int argc, const char **argv, const char *prefix);
 extern int cmd_cherry_pick(int argc, const char **argv, const char *prefix);
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
new file mode 100644
index 0000000..74ea2fc
--- /dev/null
+++ b/builtin/check-ignore.c
@@ -0,0 +1,167 @@
+#include "builtin.h"
+#include "cache.h"
+#include "dir.h"
+#include "quote.h"
+#include "pathspec.h"
+#include "parse-options.h"
+
+static int quiet, verbose, stdin_paths;
+static const char * const check_ignore_usage[] = {
+"git check-ignore [options] pathname...",
+"git check-ignore [options] --stdin < <list-of-paths>",
+NULL
+};
+
+static int null_term_line;
+
+static const struct option check_ignore_options[] = {
+	OPT__QUIET(&quiet, N_("suppress progress reporting")),
+	OPT__VERBOSE(&verbose, N_("be verbose")),
+	OPT_GROUP(""),
+	OPT_BOOLEAN(0, "stdin", &stdin_paths,
+		    N_("read file names from stdin")),
+	OPT_BOOLEAN('z', NULL, &null_term_line,
+		    N_("input paths are terminated by a null character")),
+	OPT_END()
+};
+
+static void output_exclude(const char *path, struct exclude *exclude)
+{
+	char *bang = exclude->to_exclude ? "" : "!";
+	char *dir  = (exclude->flags & EXC_FLAG_MUSTBEDIR) ? "/" : "";
+	if (!null_term_line) {
+		if (!verbose) {
+			write_name_quoted(path, stdout, '\n');
+		} else {
+			quote_c_style(exclude->src, NULL, stdout, 0);
+			printf(":%d:%s%s%s\t",
+			       exclude->srcpos,
+			       bang, exclude->pattern, dir);
+			quote_c_style(path, NULL, stdout, 0);
+			fputc('\n', stdout);
+		}
+	} else {
+		if (!verbose) {
+			printf("%s%c", path, '\0');
+		} else {
+			printf("%s%c%d%c%s%s%s%c%s%c",
+			       exclude->src, '\0',
+			       exclude->srcpos, '\0',
+			       bang, exclude->pattern, dir, '\0',
+			       path, '\0');
+		}
+	}
+}
+
+static int check_ignore(const char *prefix, const char **pathspec)
+{
+	struct dir_struct dir;
+	const char *path;
+	char *seen = NULL;
+	int num_ignored = 0;
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
+			full_path = treat_gitlink(full_path);
+			validate_path(prefix, full_path);
+			if (!seen[i] && path[0]) {
+				int dtype = DT_UNKNOWN;
+				exclude = last_exclude_matching_path(&check, full_path,
+								     -1, &dtype);
+				if (exclude) {
+					if (!quiet)
+						output_exclude(path, exclude);
+					num_ignored++;
+				}
+			}
+		}
+		free(seen);
+		free_directory(&dir);
+		path_exclude_check_clear(&check);
+	} else {
+		printf("no pathspec\n");
+	}
+	return num_ignored;
+}
+
+static int check_ignore_stdin_paths(const char *prefix)
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
+	int num_ignored = check_ignore(prefix, (const char **)pathspec);
+	maybe_flush_or_die(stdout, "attribute to stdout");
+	strbuf_release(&buf);
+	strbuf_release(&nbuf);
+	free(pathspec);
+	return num_ignored;
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
+			die(_("cannot specify pathnames with --stdin"));
+	} else {
+		if (null_term_line)
+			die(_("-z only makes sense with --stdin"));
+		if (argc == 0)
+			die(_("no path specified"));
+	}
+	if (quiet) {
+		if (argc > 1)
+			die(_("--quiet is only valid with a single pathname"));
+		if (verbose)
+			die(_("cannot have both --quiet and --verbose"));
+	}
+
+	int num_ignored = 0;
+	if (stdin_paths) {
+		num_ignored = check_ignore_stdin_paths(prefix);
+	} else {
+		num_ignored = check_ignore(prefix, argv);
+		maybe_flush_or_die(stdout, "ignore to stdout");
+	}
+
+	return num_ignored > 0 ? 0 : 1;
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
index be800e0..1efd366 100644
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
index 0000000..a0f571e
--- /dev/null
+++ b/t/t0007-ignores.sh
@@ -0,0 +1,587 @@
+#!/bin/sh
+
+test_description=check-ignore
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
+expect_in () {
+	dest="$HOME/expected-$1" text="$2"
+	if test -z "$text"
+	then
+		>"$dest" # avoid newline
+	else
+		echo -e "$text" >"$dest"
+	fi
+}
+
+expect () {
+	expect_in stdout "$1"
+}
+
+expect_from_stdin () {
+	cat >"$HOME/expected-stdout"
+}
+
+test_stderr () {
+	expected="$1"
+	expect_in stderr "$1" &&
+	test_cmp "$HOME/expected-stderr" "$HOME/stderr"
+}
+
+stderr_contains () {
+	regexp="$1"
+	if grep -q "$regexp" "$HOME/stderr"
+	then
+		return 0
+	else
+		echo "didn't find /$regexp/ in $HOME/stderr"
+		cat "$HOME/stderr"
+		return 1
+	fi
+}
+
+stderr_empty_on_success () {
+	expect_code="$1"
+	if test $expect_code = 0
+	then
+		test_stderr ""
+	else
+		# If we expect failure then stderr might or might not be empty
+		# due to --quiet - the caller can check its contents
+		return 0
+	fi
+}
+
+test_check_ignore () {
+	args="$1" expect_code="${2:-0}" global_args="$3"
+
+	init_vars &&
+	rm -f "$HOME/stdout" "$HOME/stderr" "$HOME/cmd" &&
+	echo $(which git) $global_args check-ignore $quiet_opt $verbose_opt $args \
+		>"$HOME/cmd" &&
+	pwd >"$HOME/pwd" &&
+	test_expect_code "$expect_code" \
+		git $global_args check-ignore $quiet_opt $verbose_opt $args \
+		>"$HOME/stdout" 2>"$HOME/stderr" &&
+	test_cmp "$HOME/expected-stdout" "$HOME/stdout" &&
+	stderr_empty_on_success "$expect_code"
+}
+
+test_expect_success_multi () {
+	testname="$1" expect_verbose="$2" code="$3"
+
+	expect=$( echo "$expect_verbose" | sed -e 's/.*	//' )
+
+	test_expect_success "$testname" "
+		expect '$expect' &&
+		$code
+	"
+
+	for quiet_opt in '-q' '--quiet'
+	do
+		test_expect_success "$testname${quiet_opt:+ with $quiet_opt}" "
+			expect '' &&
+			$code
+		"
+	done
+	quiet_opt=
+
+	for verbose_opt in '-v' '--verbose'
+	do
+		test_expect_success "$testname${verbose_opt:+ with $verbose_opt}" "
+			expect '$expect_verbose' &&
+			$code
+		"
+	done
+	verbose_opt=
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
+	cat <<-\EOF >.gitignore &&
+		one
+	EOF
+	cat <<-\EOF >a/.gitignore &&
+		two*
+		*three
+	EOF
+	cat <<-\EOF >a/b/.gitignore &&
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
+	cat <<-\EOF >"$global_excludes" &&
+		globalone
+		!globaltwo
+		globalthree
+	EOF
+	cat <<-\EOF >>.git/info/exclude
+		per-repo
+	EOF
+'
+
+############################################################################
+#
+# test invalid inputs
+
+test_expect_success_multi 'empty command line' '' '
+	test_check_ignore "" 128 &&
+	stderr_contains "fatal: no path specified"
+'
+
+test_expect_success '-q with multiple args' '
+	expect "" &&
+	test_check_ignore "-q one two" 128 &&
+	stderr_contains "fatal: --quiet is only valid with a single pathname"
+'
+
+test_expect_success '--quiet with multiple args' '
+	expect "" &&
+	test_check_ignore "--quiet one two" 128 &&
+	stderr_contains "fatal: --quiet is only valid with a single pathname"
+'
+
+for verbose_opt in '-v' '--verbose'
+do
+	for quiet_opt in '-q' '--quiet'
+	do
+		test_expect_success "$quiet_opt $verbose_opt" "
+			expect '' &&
+			test_check_ignore '$quiet_opt $verbose_opt foo' 128 &&
+			stderr_contains 'fatal: cannot have both --quiet and --verbose'
+		"
+	done
+done
+
+test_expect_success '--quiet with multiple args' '
+	expect "" &&
+	test_check_ignore "--quiet one two" 128 &&
+	stderr_contains "fatal: --quiet is only valid with a single pathname"
+'
+
+test_expect_success_multi 'erroneous use of --' '' '
+	test_check_ignore "--" 128 &&
+	stderr_contains "fatal: no path specified"
+'
+
+test_expect_success_multi '--stdin with superfluous arg' '' '
+	test_check_ignore "--stdin foo" 128 &&
+	stderr_contains "fatal: cannot specify pathnames with --stdin"
+'
+
+test_expect_success_multi '--stdin -z with superfluous arg' '' '
+	test_check_ignore "--stdin -z foo" 128 &&
+	stderr_contains "fatal: cannot specify pathnames with --stdin"
+'
+
+test_expect_success_multi '-z without --stdin' '' '
+	test_check_ignore "-z" 128 &&
+	stderr_contains "fatal: -z only makes sense with --stdin"
+'
+
+test_expect_success_multi '-z without --stdin and superfluous arg' '' '
+	test_check_ignore "-z foo" 128 &&
+	stderr_contains "fatal: -z only makes sense with --stdin"
+'
+
+test_expect_success_multi 'needs work tree' '' '
+	(
+		cd .git &&
+		test_check_ignore "foo" 128
+	) &&
+	stderr_contains "fatal: This operation must be run in a work tree"
+'
+
+############################################################################
+#
+# test standard ignores
+
+test_expect_success_multi "top-level not ignored" '' '
+	test_check_ignore "foo" 1
+'
+
+test_expect_success_multi "top-level ignored" \
+	'.gitignore:1:one	one' '
+	test_check_ignore "one"
+'
+
+test_expect_success_multi 'sub-directory ignore from top' \
+	'.gitignore:1:one	a/one' '
+	test_check_ignore "a/one"
+'
+
+test_expect_success 'sub-directory local ignore' '
+	expect "a/3-three" &&
+	test_check_ignore "a/3-three a/three-not-this-one"
+'
+
+test_expect_success 'sub-directory local ignore with --verbose'  '
+	expect "a/.gitignore:2:*three	a/3-three" &&
+	test_check_ignore "--verbose a/3-three a/three-not-this-one"
+'
+
+test_expect_success 'local ignore inside a sub-directory' '
+	expect "3-three" &&
+	(
+		cd a &&
+		test_check_ignore "3-three three-not-this-one"
+	)
+'
+test_expect_success 'local ignore inside a sub-directory with --verbose' '
+	expect "a/.gitignore:2:*three	3-three" &&
+	(
+		cd a &&
+		test_check_ignore "--verbose 3-three three-not-this-one"
+	)
+'
+
+test_expect_success_multi 'nested include' \
+	'a/b/.gitignore:8:!on*	a/b/one' '
+	test_check_ignore "a/b/one"
+'
+
+############################################################################
+#
+# test ignored sub-directories
+
+test_expect_success_multi 'ignored sub-directory' \
+	'a/b/.gitignore:5:ignored-dir/	a/b/ignored-dir' '
+	test_check_ignore "a/b/ignored-dir"
+'
+
+test_expect_success 'multiple files inside ignored sub-directory' '
+	expect_from_stdin <<-\EOF &&
+		a/b/ignored-dir/foo
+		a/b/ignored-dir/twoooo
+		a/b/ignored-dir/seven
+	EOF
+	test_check_ignore "a/b/ignored-dir/foo a/b/ignored-dir/twoooo a/b/ignored-dir/seven"
+'
+
+test_expect_success 'multiple files inside ignored sub-directory with -v' '
+	expect_from_stdin <<-\EOF &&
+		a/b/.gitignore:5:ignored-dir/	a/b/ignored-dir/foo
+		a/b/.gitignore:5:ignored-dir/	a/b/ignored-dir/twoooo
+		a/b/.gitignore:5:ignored-dir/	a/b/ignored-dir/seven
+	EOF
+	test_check_ignore "-v a/b/ignored-dir/foo a/b/ignored-dir/twoooo a/b/ignored-dir/seven"
+'
+
+test_expect_success 'cd to ignored sub-directory' '
+	expect_from_stdin <<-\EOF &&
+		foo
+		twoooo
+		../one
+		seven
+		../../one
+	EOF
+	(
+		cd a/b/ignored-dir &&
+		test_check_ignore "foo twoooo ../one seven ../../one"
+	)
+'
+
+test_expect_success 'cd to ignored sub-directory with -v' '
+	expect_from_stdin <<-\EOF &&
+		a/b/.gitignore:5:ignored-dir/	foo
+		a/b/.gitignore:5:ignored-dir/	twoooo
+		a/b/.gitignore:8:!on*	../one
+		a/b/.gitignore:5:ignored-dir/	seven
+		.gitignore:1:one	../../one
+	EOF
+	(
+		cd a/b/ignored-dir &&
+		test_check_ignore "-v foo twoooo ../one seven ../../one"
+	)
+'
+
+############################################################################
+#
+# test handling of symlinks
+
+test_expect_success_multi 'symlink' '' '
+	test_check_ignore "a/symlink" 1
+'
+
+test_expect_success_multi 'beyond a symlink' '' '
+	test_check_ignore "a/symlink/foo" 128 &&
+	test_stderr "fatal: '\''a/symlink/foo'\'' is beyond a symbolic link"
+'
+
+test_expect_success_multi 'beyond a symlink from subdirectory' '' '
+	(
+		cd a &&
+		test_check_ignore "symlink/foo" 128
+	) &&
+	test_stderr "fatal: '\''symlink/foo'\'' is beyond a symbolic link"
+'
+
+############################################################################
+#
+# test handling of submodules
+
+test_expect_success_multi 'submodule' '' '
+	test_check_ignore "a/submodule/one" 128 &&
+	test_stderr "fatal: Path '\''a/submodule/one'\'' is in submodule '\''a/submodule'\''"
+'
+
+test_expect_success_multi 'submodule from subdirectory' '' '
+	(
+		cd a &&
+		test_check_ignore "submodule/one" 128
+	) &&
+	test_stderr "fatal: Path '\''a/submodule/one'\'' is in submodule '\''a/submodule'\''"
+'
+
+############################################################################
+#
+# test handling of global ignore files
+
+test_expect_success 'global ignore not yet enabled' '
+	expect_from_stdin <<-\EOF &&
+		.git/info/exclude:7:per-repo	per-repo
+		a/.gitignore:2:*three	a/globalthree
+		.git/info/exclude:7:per-repo	a/per-repo
+	EOF
+	test_check_ignore "-v globalone per-repo a/globalthree a/per-repo not-ignored a/globaltwo"
+'
+
+test_expect_success 'global ignore' '
+	enable_global_excludes &&
+	expect_from_stdin <<-\EOF &&
+		globalone
+		per-repo
+		globalthree
+		a/globalthree
+		a/per-repo
+		globaltwo
+	EOF
+	test_check_ignore "globalone per-repo globalthree a/globalthree a/per-repo not-ignored globaltwo"
+'
+
+test_expect_success 'global ignore with -v' '
+	enable_global_excludes &&
+	expect_from_stdin <<-EOF &&
+		$global_excludes:1:globalone	globalone
+		.git/info/exclude:7:per-repo	per-repo
+		$global_excludes:3:globalthree	globalthree
+		a/.gitignore:2:*three	a/globalthree
+		.git/info/exclude:7:per-repo	a/per-repo
+		$global_excludes:2:!globaltwo	globaltwo
+	EOF
+	test_check_ignore "-v globalone per-repo globalthree a/globalthree a/per-repo not-ignored globaltwo"
+'
+
+############################################################################
+#
+# test --stdin
+
+cat <<-\EOF >stdin
+	one
+	not-ignored
+	a/one
+	a/not-ignored
+	a/b/on
+	a/b/one
+	a/b/one one
+	"a/b/one two"
+	"a/b/one\"three"
+	a/b/not-ignored
+	a/b/two
+	a/b/twooo
+	globaltwo
+	a/globaltwo
+	a/b/globaltwo
+	b/globaltwo
+EOF
+cat <<-\EOF >expected-default
+	one
+	a/one
+	a/b/on
+	a/b/one
+	a/b/one one
+	a/b/one two
+	"a/b/one\"three"
+	a/b/two
+	a/b/twooo
+	globaltwo
+	a/globaltwo
+	a/b/globaltwo
+	b/globaltwo
+EOF
+cat <<-EOF >expected-verbose
+	.gitignore:1:one	one
+	.gitignore:1:one	a/one
+	a/b/.gitignore:8:!on*	a/b/on
+	a/b/.gitignore:8:!on*	a/b/one
+	a/b/.gitignore:8:!on*	a/b/one one
+	a/b/.gitignore:8:!on*	a/b/one two
+	a/b/.gitignore:8:!on*	"a/b/one\"three"
+	a/b/.gitignore:9:!two	a/b/two
+	a/.gitignore:1:two*	a/b/twooo
+	$global_excludes:2:!globaltwo	globaltwo
+	$global_excludes:2:!globaltwo	a/globaltwo
+	$global_excludes:2:!globaltwo	a/b/globaltwo
+	$global_excludes:2:!globaltwo	b/globaltwo
+EOF
+
+sed -e 's/^"//' -e 's/\\//' -e 's/"$//' stdin | \
+	tr "\n" "\0" >stdin0
+sed -e 's/^"//' -e 's/\\//' -e 's/"$//' expected-default | \
+	tr "\n" "\0" >expected-default0
+sed -e 's/	"/	/' -e 's/\\//' -e 's/"$//' expected-verbose | \
+	tr ":\t\n" "\0" >expected-verbose0
+
+test_expect_success '--stdin' '
+	expect_from_stdin <expected-default &&
+	test_check_ignore "--stdin" <stdin
+'
+
+test_expect_success '--stdin -q' '
+	expect "" &&
+	test_check_ignore "-q --stdin" <stdin
+'
+
+test_expect_success '--stdin -v' '
+	expect_from_stdin <expected-verbose &&
+	test_check_ignore "-v --stdin" <stdin
+'
+
+for opts in '--stdin -z' '-z --stdin'
+do
+	test_expect_success "$opts" "
+		expect_from_stdin <expected-default0 &&
+		test_check_ignore '$opts' <stdin0
+	"
+
+	test_expect_success "$opts -q" "
+		expect "" &&
+		test_check_ignore '-q $opts' <stdin0
+	"
+
+	test_expect_success "$opts -v" "
+		expect_from_stdin <expected-verbose0 &&
+		test_check_ignore '-v $opts' <stdin0
+	"
+done
+
+cat <<-\EOF >stdin
+	../one
+	../not-ignored
+	one
+	not-ignored
+	b/on
+	b/one
+	b/one one
+	"b/one two"
+	"b/one\"three"
+	b/two
+	b/not-ignored
+	b/twooo
+	../globaltwo
+	globaltwo
+	b/globaltwo
+	../b/globaltwo
+EOF
+cat <<-\EOF >expected-default
+	../one
+	one
+	b/on
+	b/one
+	b/one one
+	b/one two
+	"b/one\"three"
+	b/two
+	b/twooo
+	../globaltwo
+	globaltwo
+	b/globaltwo
+	../b/globaltwo
+EOF
+cat <<-EOF >expected-verbose
+	.gitignore:1:one	../one
+	.gitignore:1:one	one
+	a/b/.gitignore:8:!on*	b/on
+	a/b/.gitignore:8:!on*	b/one
+	a/b/.gitignore:8:!on*	b/one one
+	a/b/.gitignore:8:!on*	b/one two
+	a/b/.gitignore:8:!on*	"b/one\"three"
+	a/b/.gitignore:9:!two	b/two
+	a/.gitignore:1:two*	b/twooo
+	$global_excludes:2:!globaltwo	../globaltwo
+	$global_excludes:2:!globaltwo	globaltwo
+	$global_excludes:2:!globaltwo	b/globaltwo
+	$global_excludes:2:!globaltwo	../b/globaltwo
+EOF
+
+sed -e 's/^"//' -e 's/\\//' -e 's/"$//' stdin | \
+	tr "\n" "\0" >stdin0
+sed -e 's/^"//' -e 's/\\//' -e 's/"$//' expected-default | \
+	tr "\n" "\0" >expected-default0
+sed -e 's/	"/	/' -e 's/\\//' -e 's/"$//' expected-verbose | \
+	tr ":\t\n" "\0" >expected-verbose0
+
+test_expect_success '--stdin from subdirectory' '
+	expect_from_stdin <expected-default &&
+	(
+		cd a &&
+		test_check_ignore "--stdin" <../stdin
+	)
+'
+
+test_expect_success '--stdin from subdirectory with -v' '
+	expect_from_stdin <expected-verbose &&
+	(
+		cd a &&
+		test_check_ignore "--stdin -v" <../stdin
+	)
+'
+
+for opts in '--stdin -z' '-z --stdin'
+do
+	test_expect_success "$opts from subdirectory" '
+		expect_from_stdin <expected-default0 &&
+		(
+			cd a &&
+			test_check_ignore "'"$opts"'" <../stdin0
+		)
+	'
+
+	test_expect_success "$opts from subdirectory with -v" '
+		expect_from_stdin <expected-verbose0 &&
+		(
+			cd a &&
+			test_check_ignore "'"$opts"' -v" <../stdin0
+		)
+	'
+done
+
+
+test_done
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 92d7eb4..cce51ac 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -213,19 +213,19 @@ test_expect_success 'general options' '
 '
 
 test_expect_success 'general options plus command' '
-	test_completion "git --version check" "checkout " &&
-	test_completion "git --paginate check" "checkout " &&
-	test_completion "git --git-dir=foo check" "checkout " &&
-	test_completion "git --bare check" "checkout " &&
+	test_completion "git --version checko" "checkout " &&
+	test_completion "git --paginate checko" "checkout " &&
+	test_completion "git --git-dir=foo checko" "checkout " &&
+	test_completion "git --bare checko" "checkout " &&
 	test_completion "git --help des" "describe " &&
-	test_completion "git --exec-path=foo check" "checkout " &&
-	test_completion "git --html-path check" "checkout " &&
-	test_completion "git --no-pager check" "checkout " &&
-	test_completion "git --work-tree=foo check" "checkout " &&
-	test_completion "git --namespace=foo check" "checkout " &&
-	test_completion "git --paginate check" "checkout " &&
-	test_completion "git --info-path check" "checkout " &&
-	test_completion "git --no-replace-objects check" "checkout "
+	test_completion "git --exec-path=foo checko" "checkout " &&
+	test_completion "git --html-path checko" "checkout " &&
+	test_completion "git --no-pager checko" "checkout " &&
+	test_completion "git --work-tree=foo checko" "checkout " &&
+	test_completion "git --namespace=foo checko" "checkout " &&
+	test_completion "git --paginate checko" "checkout " &&
+	test_completion "git --info-path checko" "checkout " &&
+	test_completion "git --no-replace-objects checko" "checkout "
 '
 
 test_done
-- 
1.7.12.147.g6d168f4
