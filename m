From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] grep: Add the option '--open-files-in-pager'
Date: Fri, 4 Jun 2010 19:53:22 -0500
Message-ID: <20100605005322.GB8774@progeny.tock>
References: <20100605005116.GA8774@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 05 02:53:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKhdh-00048D-3W
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 02:53:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548Ab0FEAxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jun 2010 20:53:24 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41623 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932500Ab0FEAxX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 20:53:23 -0400
Received: by iwn37 with SMTP id 37so1624796iwn.19
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 17:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=NXmFhe92xyNoa6pB89CveMLrU7yWe21hnjHLq/pnPeQ=;
        b=dkq3WHd1R4GelNmiZ9/5I/n7YoTmb6rJ9CdJN9/2/oy9PgqJcEOni+B+bPRngVrmB+
         TS7heBBIU4RzQmHImKZmiB8o562wgqBzcgkjAG8pBQ/e/DHUANCgXDFDUs2orqLTn+t/
         O6f9Oufc7l24onE7Ud2YV1DxyUAbgkBoYtZoA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=P5ztWUYJAYmAhXK5c4tjktg6r6eWOFFjesQwZh6TTQBvL7FSfq1/l16BHzbzItpEVq
         Wbvh7r9IIih9EbNXZf2B3ptC6uWMPstlLGhAGQLorelJsB4940OJB8spaE7XyFCXglTA
         dnA8fL6C5muJ4FAj0hrAvY2taQU0AU1RmDkK8=
Received: by 10.231.49.6 with SMTP id t6mr1586086ibf.144.1275699202310;
        Fri, 04 Jun 2010 17:53:22 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id r12sm7800748ibi.2.2010.06.04.17.53.20
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 04 Jun 2010 17:53:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100605005116.GA8774@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148443>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This adds an option to open the matching files in the pager, and if the
pager happens to be "less" (or "vi") and there is only one grep pattern,
it also jumps to the first match right away.

The short option was chose as '-O' to avoid clashes with GNU grep's
options (as suggested by Junio).

So, 'git grep -O abc' is a short form for 'less +/abc $(grep -l abc)'
except that it works also with spaces in file names, and it does not
start the pager if there was no matching file.

[jn: rebased and added tests; with error handling fix from Junio
squashed in]

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-grep.txt         |    8 ++
 builtin/grep.c                     |   83 ++++++++++++++++++-
 git.c                              |    2 +-
 t/lib-pager.sh                     |   15 ++++
 t/t7006-pager.sh                   |   16 +---
 t/{t7002-grep.sh => t7810-grep.sh} |    0
 t/t7811-grep-open.sh               |  154 ++++++++++++++++++++++++++++++++++++
 7 files changed, 261 insertions(+), 17 deletions(-)
 create mode 100644 t/lib-pager.sh
 rename t/{t7002-grep.sh => t7810-grep.sh} (100%)
 create mode 100644 t/t7811-grep-open.sh

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 4b32322..8fdd8e1 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -14,6 +14,7 @@ SYNOPSIS
 	   [-E | --extended-regexp] [-G | --basic-regexp]
 	   [-F | --fixed-strings] [-n]
 	   [-l | --files-with-matches] [-L | --files-without-match]
+	   [-O | --open-files-in-pager]
 	   [-z | --null]
 	   [-c | --count] [--all-match] [-q | --quiet]
 	   [--max-depth <depth>]
@@ -104,6 +105,13 @@ OPTIONS
 	For better compatibility with 'git diff', `--name-only` is a
 	synonym for `--files-with-matches`.
 
+-O::
+--open-files-in-pager::
+	Open the matching files in the pager (not the output of 'grep').
+	If the pager happens to be "less" or "vi", and the user
+	specified only one pattern, the first file is positioned at
+	the first match automatically.
+
 -z::
 --null::
 	Output \0 instead of the character that normally follows a
diff --git a/builtin/grep.c b/builtin/grep.c
index b194ea3..bc6c2ea 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -11,6 +11,8 @@
 #include "tree-walk.h"
 #include "builtin.h"
 #include "parse-options.h"
+#include "string-list.h"
+#include "run-command.h"
 #include "userdiff.h"
 #include "grep.h"
 #include "quote.h"
@@ -556,7 +558,34 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 	}
 }
 
-static int grep_cache(struct grep_opt *opt, const char **paths, int cached)
+static void append_path(struct grep_opt *opt, const void *data, size_t len)
+{
+	struct string_list *path_list = opt->output_priv;
+
+	if (len == 1 && *(const char *)data == '\0')
+		return;
+	string_list_append(xstrndup(data, len), path_list);
+}
+
+static void run_pager(struct grep_opt *opt, const char *prefix)
+{
+	struct string_list *path_list = opt->output_priv;
+	const char **argv = xmalloc(sizeof(const char *) * (path_list->nr + 1));
+	int i, status;
+
+	for (i = 0; i < path_list->nr; i++)
+		argv[i] = path_list->items[i].string;
+	argv[path_list->nr] = NULL;
+
+	if (prefix && chdir(prefix))
+		error("Failed to chdir: %s", prefix);
+	status = run_command_v_opt(argv, RUN_USING_SHELL);
+	if (status)
+		exit(status);
+}
+
+static int grep_cache(struct grep_opt *opt, const char **paths,
+		      int cached, int show_in_pager, const char *prefix)
 {
 	int hit = 0;
 	int nr;
@@ -590,6 +619,8 @@ static int grep_cache(struct grep_opt *opt, const char **paths, int cached)
 		if (hit && opt->status_only)
 			break;
 	}
+	if (hit && show_in_pager)
+		run_pager(opt, prefix);
 	free_grep_patterns(opt);
 	return hit;
 }
@@ -675,7 +706,8 @@ static int grep_object(struct grep_opt *opt, const char **paths,
 	die("unable to grep from object of type %s", typename(obj->type));
 }
 
-static int grep_directory(struct grep_opt *opt, const char **paths)
+static int grep_directory(struct grep_opt *opt, const char **paths,
+			  int show_in_pager, const char *prefix)
 {
 	struct dir_struct dir;
 	int i, hit = 0;
@@ -689,6 +721,8 @@ static int grep_directory(struct grep_opt *opt, const char **paths)
 		if (hit && opt->status_only)
 			break;
 	}
+	if (hit && show_in_pager)
+		run_pager(opt, prefix);
 	free_grep_patterns(opt);
 	return hit;
 }
@@ -782,9 +816,11 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	int cached = 0;
 	int seen_dashdash = 0;
 	int external_grep_allowed__ignored;
+	int show_in_pager = 0;
 	struct grep_opt opt;
 	struct object_array list = { 0, 0, NULL };
 	const char **paths = NULL;
+	struct string_list path_list = { NULL, 0, 0, 0 };
 	int i;
 	int dummy;
 	int nongit = 0, use_index = 1;
@@ -868,6 +904,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN(0, "all-match", &opt.all_match,
 			"show only matches from files that match all patterns"),
 		OPT_GROUP(""),
+		OPT_BOOLEAN('O', "open-files-in-pager", &show_in_pager,
+			"show matching files in the pager"),
 		OPT_BOOLEAN(0, "ext-grep", &external_grep_allowed__ignored,
 			    "allow calling of grep(1) (ignored by this build)"),
 		{ OPTION_CALLBACK, 0, "help-all", &options, NULL, "show usage",
@@ -943,6 +981,20 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		argc--;
 	}
 
+	if (show_in_pager) {
+		const char *pager = git_pager(1);
+		if (!pager) {
+			show_in_pager = 0;
+		} else {
+			opt.name_only = 1;
+			opt.null_following_name = 1;
+			opt.output_priv = &path_list;
+			opt.output = append_path;
+			string_list_append(pager, &path_list);
+			use_threads = 0;
+		}
+	}
+
 	if (!opt.pattern_list)
 		die("no pattern given.");
 	if (!opt.fixed && opt.ignore_case)
@@ -999,13 +1051,36 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		paths[1] = NULL;
 	}
 
+	if (show_in_pager && (cached || list.nr))
+		die("--open-files-in-pager only works on the worktree");
+
+	if (show_in_pager && opt.pattern_list && !opt.pattern_list->next) {
+		const char *pager = path_list.items[0].string;
+		int len = strlen(pager);
+
+		if (len > 4 && is_dir_sep(pager[len - 5]))
+			pager += len - 4;
+
+		if (!strcmp("less", pager) || !strcmp("vi", pager)) {
+			struct strbuf buf = STRBUF_INIT;
+			strbuf_addf(&buf, "+/%s%s",
+					strcmp("less", pager) ? "" : "*",
+					opt.pattern_list->pattern);
+			string_list_append(buf.buf, &path_list);
+			strbuf_detach(&buf, NULL);
+		}
+	}
+
+	if (!show_in_pager)
+		setup_pager();
+
 	if (!use_index) {
 		int hit;
 		if (cached)
 			die("--cached cannot be used with --no-index.");
 		if (list.nr)
 			die("--no-index cannot be used with revs.");
-		hit = grep_directory(&opt, paths);
+		hit = grep_directory(&opt, paths, show_in_pager, prefix);
 		if (use_threads)
 			hit |= wait_all();
 		return !hit;
@@ -1016,7 +1091,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		if (!cached)
 			setup_work_tree();
 
-		hit = grep_cache(&opt, paths, cached);
+		hit = grep_cache(&opt, paths, cached, show_in_pager, prefix);
 		if (use_threads)
 			hit |= wait_all();
 		return !hit;
diff --git a/git.c b/git.c
index 99f0363..265fa09 100644
--- a/git.c
+++ b/git.c
@@ -329,7 +329,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "fsck-objects", cmd_fsck, RUN_SETUP },
 		{ "gc", cmd_gc, RUN_SETUP },
 		{ "get-tar-commit-id", cmd_get_tar_commit_id },
-		{ "grep", cmd_grep, USE_PAGER },
+		{ "grep", cmd_grep },
 		{ "hash-object", cmd_hash_object },
 		{ "help", cmd_help },
 		{ "index-pack", cmd_index_pack },
diff --git a/t/lib-pager.sh b/t/lib-pager.sh
new file mode 100644
index 0000000..f8c6025
--- /dev/null
+++ b/t/lib-pager.sh
@@ -0,0 +1,15 @@
+#!/bin/sh
+
+test_expect_success 'determine default pager' '
+	test_might_fail git config --unset core.pager &&
+	less=$(
+		unset PAGER GIT_PAGER;
+		git var GIT_PAGER
+	) &&
+	test -n "$less"
+'
+
+if expr "$less" : '^[a-z][a-z]*$' >/dev/null
+then
+	test_set_prereq SIMPLEPAGER
+fi
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 3bc7a2a..fc993fc 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -3,6 +3,7 @@
 test_description='Test automatic use of a pager.'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-pager.sh
 
 cleanup_fail() {
 	echo >&2 cleanup failed
@@ -158,21 +159,12 @@ test_expect_success 'color when writing to a file intended for a pager' '
 	colorful colorful.log
 '
 
-test_expect_success 'determine default pager' '
-	unset PAGER GIT_PAGER &&
-	test_might_fail git config --unset core.pager ||
-	cleanup_fail &&
-
-	less=$(git var GIT_PAGER) &&
-	test -n "$less"
-'
-
-if expr "$less" : '^[a-z][a-z]*$' >/dev/null && test_have_prereq TTY
+if test_have_prereq SIMPLEPAGER && test_have_prereq TTY
 then
-	test_set_prereq SIMPLEPAGER
+	test_set_prereq SIMPLEPAGERTTY
 fi
 
-test_expect_success SIMPLEPAGER 'default pager is used by default' '
+test_expect_success SIMPLEPAGERTTY 'default pager is used by default' '
 	unset PAGER GIT_PAGER &&
 	test_might_fail git config --unset core.pager &&
 	rm -f default_pager_used ||
diff --git a/t/t7002-grep.sh b/t/t7810-grep.sh
similarity index 100%
rename from t/t7002-grep.sh
rename to t/t7810-grep.sh
diff --git a/t/t7811-grep-open.sh b/t/t7811-grep-open.sh
new file mode 100644
index 0000000..72e4023
--- /dev/null
+++ b/t/t7811-grep-open.sh
@@ -0,0 +1,154 @@
+#!/bin/sh
+
+test_description='git grep --open-files-in-pager
+'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-pager.sh
+unset PAGER GIT_PAGER
+
+test_expect_success 'setup' '
+	test_commit initial grep.h "
+enum grep_pat_token {
+	GREP_PATTERN,
+	GREP_PATTERN_HEAD,
+	GREP_PATTERN_BODY,
+	GREP_AND,
+	GREP_OPEN_PAREN,
+	GREP_CLOSE_PAREN,
+	GREP_NOT,
+	GREP_OR,
+};" &&
+
+	test_commit add-user revision.c "
+	}
+	if (seen_dashdash)
+		read_pathspec_from_stdin(revs, &sb, prune);
+	strbuf_release(&sb);
+}
+
+static void add_grep(struct rev_info *revs, const char *ptn, enum grep_pat_token what)
+{
+	append_grep_pattern(&revs->grep_filter, ptn, \"command line\", 0, what);
+" &&
+
+	mkdir subdir &&
+	test_commit subdir subdir/grep.c "enum grep_pat_token" &&
+
+	test_commit uninteresting unrelated "hello, world" &&
+
+	echo GREP_PATTERN >untracked
+'
+
+test_expect_success SIMPLEPAGER 'git grep -O' '
+	cat >$less <<-\EOF &&
+	#!/bin/sh
+	printf "%s\n" "$@" >pager-args
+	EOF
+	chmod +x $less &&
+	cat >expect.less <<-\EOF &&
+	+/*GREP_PATTERN
+	grep.h
+	EOF
+	echo grep.h >expect.notless &&
+	>empty &&
+
+	PATH=.:$PATH git grep -O GREP_PATTERN >out &&
+	{
+		test_cmp expect.less pager-args ||
+		test_cmp expect.notless pager-args
+	} &&
+	test_cmp empty out
+'
+
+test_expect_success 'git grep -O --cached' '
+	test_must_fail git grep --cached -O GREP_PATTERN >out 2>msg &&
+	grep open-files-in-pager msg
+'
+
+test_expect_success 'git grep -O --no-index' '
+	rm -f expect.less pager-args out &&
+	cat >expect <<-\EOF &&
+	grep.h
+	untracked
+	EOF
+	>empty &&
+
+	(
+		GIT_PAGER='\''printf "%s\n" >pager-args'\'' &&
+		export GIT_PAGER &&
+		git grep --no-index -O GREP_PATTERN >out
+	) &&
+	test_cmp expect pager-args &&
+	test_cmp empty out
+'
+
+test_expect_success 'setup: fake "less"' '
+	cat >less <<-\EOF
+	#!/bin/sh
+	printf "%s\n" "$@" >actual
+	EOF
+'
+
+test_expect_success 'git grep -O jumps to line in less' '
+	cat >expect <<-\EOF &&
+	+/*GREP_PATTERN
+	grep.h
+	EOF
+	>empty &&
+
+	GIT_PAGER=./less git grep -O GREP_PATTERN >out
+	test_cmp expect actual &&
+	test_cmp empty out
+'
+
+test_expect_success 'modified file' '
+	rm -f actual &&
+	cat >less <<-\EOF &&
+	#!/bin/sh
+	printf "%s\n" "$@" >actual
+	EOF
+	chmod +x $less &&
+	cat >expect <<-\EOF &&
+	+/*enum grep_pat_token
+	grep.h
+	revision.c
+	subdir/grep.c
+	unrelated
+	EOF
+	>empty &&
+
+	echo "enum grep_pat_token" >unrelated &&
+	test_when_finished "git checkout HEAD unrelated" &&
+	GIT_PAGER=./less git grep -F -O "enum grep_pat_token" >out &&
+	test_cmp expect actual &&
+	test_cmp empty out
+'
+
+test_expect_success 'run from subdir' '
+	rm -f actual &&
+	echo grep.c >expect &&
+	>empty &&
+
+	(
+		cd subdir &&
+		export GIT_PAGER &&
+		GIT_PAGER='\''printf "%s\n" >../args'\'' &&
+		git grep -O "enum grep_pat_token" >../out
+		GIT_PAGER="pwd >../dir; :" &&
+		git grep -O "enum grep_pat_token" >../out2
+	) &&
+	case $(cat dir) in
+	*subdir)
+		: good
+		;;
+	*)
+		false
+		;;
+	esac &&
+	test_cmp expect args &&
+	test_cmp empty out &&
+	test_cmp empty out2
+'
+
+test_done
-- 
1.7.1
