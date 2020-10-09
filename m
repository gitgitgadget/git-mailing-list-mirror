Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D8FC433DF
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 19:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7909222282
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 19:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388507AbgJITPb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 15:15:31 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:46864 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388498AbgJITP3 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 9 Oct 2020 15:15:29 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8B61A607A4;
        Fri,  9 Oct 2020 19:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1602270927;
        bh=XZDFHesHLSGseGtgyD+FExkFimhOHXMRsOgBi4O50ng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=ZDir/MTW0USgDceFcR8q6cWN0ZIIBZkmUrcWnqn2P4sjP0laQjYaV+TZlLgXpbKy/
         CIm1Nxjb9w+6LcAhz9okp+nTqJkh+Sq6/YQSxkehzo/mvBY1nQEK3GYFEZOI2WCVMC
         2kVjEmOrHde4uG+bBKgay7ThLcZBaP3TswfSXZ4PiuApRVWxfm2lLxitnJJUP9GKd0
         dC8PYPp4sFmoHPGT+z7HqZWDx2c7b1DRk4EcCKVISb9xMl7s6UXSeL8UVMbqS+24kS
         /tHoeFosmUvWdcxa4Lm971LmTnqZpY+tt69TYnIAfw43g68Ste/gf9G5kkkyZ4zfbm
         Eru2cKURraL0BZ8nlXexBO9uHj2EgK6bHoKS40oHjTLWeN7PGjBdgOrbEOEE3YYsyf
         Fa1rZ5A7p2FR3tfE/9AM/c50fJkSxfVnFoaog1rcfL0ngY4qI4tBgEv9V3y0KrD0+Q
         iDAMS9cgIfxhlFp33rNbBLEITrhH1ERWFG44TdQb4CTgrWcMnel
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 2/2] rev-parse: add option for absolute or relative path formatting
Date:   Fri,  9 Oct 2020 19:15:11 +0000
Message-Id: <20201009191511.267461-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <20201009191511.267461-1-sandals@crustytoothpaste.net>
References: <20201009191511.267461-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git rev-parse has several options which print various paths.  Some of
these paths are printed relative to the current working directory, and
some are absolute.

Normally, this is not a problem, but there are times when one wants
paths entirely in one format or another.  This can be done trivially if
the paths are canonical, but canonicalizing paths is not possible on
some shell scripting environments which lack realpath(1) and also in Go,
which lacks functions that properly canonicalize paths on Windows.

To help out the scripter, let's provide an option which turns most of
the paths printed by git rev-parse to be either relative to the current
working directory or absolute and canonical.  Document which options are
affected and which are not so that users are not confused.

This approach is cleaner and tidier than providing duplicates of
existing options which are either relative or absolute.

Note that if the user needs both forms, it is possible to pass an
additional option in the middle of the command line which changes the
behavior of subsequent operations.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-rev-parse.txt |  71 ++++++++++++---------
 builtin/rev-parse.c             | 105 ++++++++++++++++++++++++++++----
 t/t1500-rev-parse.sh            |  57 ++++++++++++++++-
 3 files changed, 190 insertions(+), 43 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 19b12b6d43..6b95292559 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -208,6 +208,15 @@ Options for Files
 	Only the names of the variables are listed, not their value,
 	even if they are set.
 
+--path-format=(absolute|relative)::
+	Controls the behavior of certain other options following it on the command
+	line. If specified as absolute, the paths printed by those options will be
+	absolute and canonical. If specified as relative, the paths will be relative
+	to the current working directory if that is possible.  The default is option
+	specific.
+
+The following options are modified by `--path-format`:
+
 --git-dir::
 	Show `$GIT_DIR` if defined. Otherwise show the path to
 	the .git directory. The path shown, when relative, is
@@ -217,13 +226,42 @@ If `$GIT_DIR` is not defined and the current directory
 is not detected to lie in a Git repository or work tree
 print a message to stderr and exit with nonzero status.
 
+--git-common-dir::
+	Show `$GIT_COMMON_DIR` if defined, else `$GIT_DIR`.
+
+--resolve-git-dir <path>::
+	Check if <path> is a valid repository or a gitfile that
+	points at a valid repository, and print the location of the
+	repository.  If <path> is a gitfile then the resolved path
+	to the real repository is printed.
+
+--git-path <path>::
+	Resolve "$GIT_DIR/<path>" and takes other path relocation
+	variables such as $GIT_OBJECT_DIRECTORY,
+	$GIT_INDEX_FILE... into account. For example, if
+	$GIT_OBJECT_DIRECTORY is set to /foo/bar then "git rev-parse
+	--git-path objects/abc" returns /foo/bar/abc.
+
+--show-toplevel::
+	Show the (by default, absolute) path of the top-level directory
+	of the working tree. If there is no working tree, report an error.
+
+--show-superproject-working-tree::
+	Show the absolute path of the root of the superproject's
+	working tree (if exists) that uses the current repository as
+	its submodule.  Outputs nothing if the current repository is
+	not used as a submodule by any project.
+
+--shared-index-path::
+	Show the path to the shared index file in split index mode, or
+	empty if not in split-index mode.
+
+The following options are unaffected by `--path-format`:
+
 --absolute-git-dir::
 	Like `--git-dir`, but its output is always the canonicalized
 	absolute path.
 
---git-common-dir::
-	Show `$GIT_COMMON_DIR` if defined, else `$GIT_DIR`.
-
 --is-inside-git-dir::
 	When the current working directory is below the repository
 	directory print "true", otherwise "false".
@@ -238,19 +276,6 @@ print a message to stderr and exit with nonzero status.
 --is-shallow-repository::
 	When the repository is shallow print "true", otherwise "false".
 
---resolve-git-dir <path>::
-	Check if <path> is a valid repository or a gitfile that
-	points at a valid repository, and print the location of the
-	repository.  If <path> is a gitfile then the resolved path
-	to the real repository is printed.
-
---git-path <path>::
-	Resolve "$GIT_DIR/<path>" and takes other path relocation
-	variables such as $GIT_OBJECT_DIRECTORY,
-	$GIT_INDEX_FILE... into account. For example, if
-	$GIT_OBJECT_DIRECTORY is set to /foo/bar then "git rev-parse
-	--git-path objects/abc" returns /foo/bar/abc.
-
 --show-cdup::
 	When the command is invoked from a subdirectory, show the
 	path of the top-level directory relative to the current
@@ -261,20 +286,6 @@ print a message to stderr and exit with nonzero status.
 	path of the current directory relative to the top-level
 	directory.
 
---show-toplevel::
-	Show the absolute path of the top-level directory of the working
-	tree. If there is no working tree, report an error.
-
---show-superproject-working-tree::
-	Show the absolute path of the root of the superproject's
-	working tree (if exists) that uses the current repository as
-	its submodule.  Outputs nothing if the current repository is
-	not used as a submodule by any project.
-
---shared-index-path::
-	Show the path to the shared index file in split index mode, or
-	empty if not in split-index mode.
-
 --show-object-format[=(storage|input|output)]::
 	Show the object format (hash algorithm) used for the repository
 	for storage inside the `.git` directory, input, or output. For
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index ed200c8af1..ec62b4cd16 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -583,6 +583,76 @@ static void handle_ref_opt(const char *pattern, const char *prefix)
 	clear_ref_exclusion(&ref_excludes);
 }
 
+enum format_type {
+	/* We would like a relative path. */
+	FORMAT_RELATIVE,
+	/* We would like a canonical absolute path. */
+	FORMAT_CANONICAL,
+	/* We would like the default behavior. */
+	FORMAT_DEFAULT,
+};
+
+enum default_type {
+	/* Our default is a relative path. */
+	DEFAULT_RELATIVE,
+	/* Our default is a relative path if there's a shared root. */
+	DEFAULT_RELATIVE_IF_SHARED,
+	/* Our default is a canonical absolute path. */
+	DEFAULT_CANONICAL,
+	/* Our default is not to modify the item. */
+	DEFAULT_UNMODIFIED,
+};
+
+static void print_path(const char *path, const char *prefix, enum format_type format, enum default_type def)
+{
+	char *cwd = NULL;
+	/*
+	 * We don't ever produce a relative path if prefix is NULL, so set the
+	 * prefix to the current directory so that we can produce a relative
+	 * path whenever possible.  If we're using RELATIVE_IF_SHARED mode, then
+	 * we want an absolute path unless the two share a common prefix, so don't
+	 * set it in that case, since doing so causes a relative path to always
+	 * be produced if possible.
+	 */
+	if (!prefix && (format != FORMAT_DEFAULT || def != DEFAULT_RELATIVE_IF_SHARED))
+		prefix = cwd = xgetcwd();
+	if (format == FORMAT_DEFAULT && def == DEFAULT_UNMODIFIED) {
+		puts(path);
+	} else if (format == FORMAT_RELATIVE ||
+		  (format == FORMAT_DEFAULT && def == DEFAULT_RELATIVE)) {
+		/*
+		 * In order for relative_path to work as expected, we need to
+		 * make sure that both paths are absolute paths.  If we don't,
+		 * we can end up with an unexpected absolute path that the user
+		 * didn't want.
+		 */
+		struct strbuf buf = STRBUF_INIT, realbuf = STRBUF_INIT, prefixbuf = STRBUF_INIT;
+		if (!is_absolute_path(path)) {
+			if (!strbuf_realpath_missing(&realbuf, path))
+				die(_("Unable to resolve path '%s'"), path);
+			path = realbuf.buf;
+		}
+		if (!is_absolute_path(prefix)) {
+			if (!strbuf_realpath_missing(&prefixbuf, prefix))
+				die(_("Unable to resolve path '%s'"), path);
+			prefix = prefixbuf.buf;
+		}
+		puts(relative_path(path, prefix, &buf));
+		strbuf_release(&buf);
+	} else if (format == FORMAT_DEFAULT && def == DEFAULT_RELATIVE_IF_SHARED) {
+		struct strbuf buf = STRBUF_INIT;
+		puts(relative_path(path, prefix, &buf));
+		strbuf_release(&buf);
+	} else {
+		struct strbuf buf = STRBUF_INIT;
+		if (!strbuf_realpath_missing(&buf, path))
+			die(_("Unable to resolve path '%s'"), path);
+		puts(buf.buf);
+		strbuf_release(&buf);
+	}
+	free(cwd);
+}
+
 int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 {
 	int i, as_is = 0, verify = 0, quiet = 0, revs_count = 0, type = 0;
@@ -595,6 +665,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 	struct object_context unused;
 	struct strbuf buf = STRBUF_INIT;
 	const int hexsz = the_hash_algo->hexsz;
+	enum format_type format = FORMAT_DEFAULT;
 
 	if (argc > 1 && !strcmp("--parseopt", argv[1]))
 		return cmd_parseopt(argc - 1, argv + 1, prefix);
@@ -650,8 +721,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 			if (!argv[i + 1])
 				die("--git-path requires an argument");
 			strbuf_reset(&buf);
-			puts(relative_path(git_path("%s", argv[i + 1]),
-					   prefix, &buf));
+			print_path(git_path("%s", argv[i + 1]), prefix, format, DEFAULT_RELATIVE_IF_SHARED);
 			i++;
 			continue;
 		}
@@ -683,6 +753,16 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 					show_file(arg, 0);
 				continue;
 			}
+			if (opt_with_value(arg, "--path-format", &arg)) {
+				if (!strcmp(arg, "absolute")) {
+					format = FORMAT_CANONICAL;
+				} else if (!strcmp(arg, "relative")) {
+					format = FORMAT_RELATIVE;
+				} else {
+					die("unknown argument to --path-format: %s", arg);
+				}
+				continue;
+			}
 			if (!strcmp(arg, "--default")) {
 				def = argv[++i];
 				if (!def)
@@ -803,7 +883,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 			if (!strcmp(arg, "--show-toplevel")) {
 				const char *work_tree = get_git_work_tree();
 				if (work_tree)
-					puts(work_tree);
+					print_path(work_tree, prefix, format, DEFAULT_CANONICAL);
 				else
 					die("this operation must be run in a work tree");
 				continue;
@@ -811,7 +891,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 			if (!strcmp(arg, "--show-superproject-working-tree")) {
 				struct strbuf superproject = STRBUF_INIT;
 				if (get_superproject_working_tree(&superproject))
-					puts(superproject.buf);
+					print_path(superproject.buf, prefix, format, DEFAULT_CANONICAL);
 				strbuf_release(&superproject);
 				continue;
 			}
@@ -846,16 +926,18 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
 				char *cwd;
 				int len;
+				enum format_type wanted = format;
 				if (arg[2] == 'g') {	/* --git-dir */
 					if (gitdir) {
-						puts(gitdir);
+						print_path(gitdir, prefix, format, DEFAULT_UNMODIFIED);
 						continue;
 					}
 					if (!prefix) {
-						puts(".git");
+						print_path(".git", prefix, format, DEFAULT_UNMODIFIED);
 						continue;
 					}
 				} else {		/* --absolute-git-dir */
+					wanted = FORMAT_CANONICAL;
 					if (!gitdir && !prefix)
 						gitdir = ".git";
 					if (gitdir) {
@@ -868,14 +950,14 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				}
 				cwd = xgetcwd();
 				len = strlen(cwd);
-				printf("%s%s.git\n", cwd, len && cwd[len-1] != '/' ? "/" : "");
+				strbuf_reset(&buf);
+				strbuf_addf(&buf, "%s%s.git", cwd, len && cwd[len-1] != '/' ? "/" : "");
 				free(cwd);
+				print_path(buf.buf, prefix, wanted, DEFAULT_CANONICAL);
 				continue;
 			}
 			if (!strcmp(arg, "--git-common-dir")) {
-				strbuf_reset(&buf);
-				puts(relative_path(get_git_common_dir(),
-						   prefix, &buf));
+				print_path(get_git_common_dir(), prefix, format, DEFAULT_RELATIVE_IF_SHARED);
 				continue;
 			}
 			if (!strcmp(arg, "--is-inside-git-dir")) {
@@ -905,8 +987,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				if (the_index.split_index) {
 					const struct object_id *oid = &the_index.split_index->base_oid;
 					const char *path = git_path("sharedindex.%s", oid_to_hex(oid));
-					strbuf_reset(&buf);
-					puts(relative_path(path, prefix, &buf));
+					print_path(path, prefix, format, DEFAULT_RELATIVE);
 				}
 				continue;
 			}
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 408b97d5af..51d7d40ec1 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -3,6 +3,16 @@
 test_description='test git rev-parse'
 . ./test-lib.sh
 
+test_one () {
+	dir="$1" &&
+	expect="$2" &&
+	shift &&
+	shift &&
+	echo "$expect" >expect &&
+	git -C "$dir" rev-parse "$@" >actual &&
+	test_cmp expect actual
+}
+
 # usage: [options] label is-bare is-inside-git is-inside-work prefix git-dir absolute-git-dir
 test_rev_parse () {
 	d=
@@ -60,7 +70,13 @@ ROOT=$(pwd)
 
 test_expect_success 'setup' '
 	mkdir -p sub/dir work &&
-	cp -R .git repo.git
+	cp -R .git repo.git &&
+	git checkout -B main &&
+	test_commit abc &&
+	git checkout -b side &&
+	test_commit def &&
+	git checkout main &&
+	git worktree add worktree side
 '
 
 test_rev_parse toplevel false false true '' .git "$ROOT/.git"
@@ -88,6 +104,45 @@ test_rev_parse -C work -g ../repo.git -b t 'GIT_DIR=../repo.git, core.bare = tru
 
 test_rev_parse -C work -g ../repo.git -b u 'GIT_DIR=../repo.git, core.bare undefined' false false true ''
 
+test_expect_success 'rev-parse --path-format=absolute' '
+	test_one "." "$ROOT/.git" --path-format=absolute --git-dir &&
+	test_one "." "$ROOT/.git" --path-format=absolute --git-common-dir &&
+	test_one "sub/dir" "$ROOT/.git" --path-format=absolute --git-dir &&
+	test_one "sub/dir" "$ROOT/.git" --path-format=absolute --git-common-dir &&
+	test_one "worktree" "$ROOT/.git/worktrees/worktree" --path-format=absolute --git-dir &&
+	test_one "worktree" "$ROOT/.git" --path-format=absolute --git-common-dir &&
+	test_one "." "$ROOT" --path-format=absolute --show-toplevel &&
+	test_one "." "$ROOT/.git/objects" --path-format=absolute --git-path objects &&
+	test_one "." "$ROOT/.git/objects/foo/bar/baz" --path-format=absolute --git-path objects/foo/bar/baz
+'
+
+test_expect_success 'rev-parse --path-format=relative' '
+	test_one "." ".git" --path-format=relative --git-dir &&
+	test_one "." ".git" --path-format=relative --git-common-dir &&
+	test_one "sub/dir" "../../.git" --path-format=relative --git-dir &&
+	test_one "sub/dir" "../../.git" --path-format=relative --git-common-dir &&
+	test_one "worktree" "../.git/worktrees/worktree" --path-format=relative --git-dir &&
+	test_one "worktree" "../.git" --path-format=relative --git-common-dir &&
+	test_one "." "./" --path-format=relative --show-toplevel &&
+	test_one "." ".git/objects" --path-format=relative --git-path objects &&
+	test_one "." ".git/objects/foo/bar/baz" --path-format=relative --git-path objects/foo/bar/baz
+'
+
+test_expect_success '--path-format=relative does not affect --absolute-git-dir' '
+	git rev-parse --path-format=relative --absolute-git-dir >actual &&
+	echo "$ROOT/.git" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '--path-format can change in the middle of the command line' '
+	git rev-parse --path-format=absolute --git-dir --path-format=relative --git-path objects/foo/bar >actual &&
+	cat >expect <<-EOF &&
+	$ROOT/.git
+	.git/objects/foo/bar
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'git-common-dir from worktree root' '
 	echo .git >expect &&
 	git rev-parse --git-common-dir >actual &&
