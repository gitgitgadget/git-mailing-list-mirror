From: Ronald Weiss <weiss.ronald@gmail.com>
Subject: [PATCH v2] commit: add --ignore-submodules[=<when>] parameter
Date: Mon, 31 Mar 2014 01:43:50 +0200
Message-ID: <5338AC36.6000109@gmail.com>
References: <CABxC_L92v=cV=+e_DNa0L6f21LB0BRP5duai2h_heGJN_PRoUQ@mail.gmail.com>	<5335A78C.60401@web.de> <CABxC_L-4=qcZiix05dL8GrDJXv=19fw4yB0qFzRRfw=G=_Gxbg@mail.gmail.com> <53374E49.9000702@gmail.com> <533874F9.3090802@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>, Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 31 01:48:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUPSa-00047K-1z
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 01:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754235AbaC3XsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2014 19:48:09 -0400
Received: from mail-we0-f175.google.com ([74.125.82.175]:42994 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753614AbaC3Xnx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2014 19:43:53 -0400
Received: by mail-we0-f175.google.com with SMTP id q58so4117141wes.34
        for <git@vger.kernel.org>; Sun, 30 Mar 2014 16:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=cUPheeFcgEgzqrY4NsAf96lM8KhiDlQH9/08E/wn188=;
        b=Awxn5Y+5PPBpBZlbTiwGBdIDRzoOQERCnX4Vgo+9syNLJ3fJswS5+IQk53nRwSPWLG
         5ddRN5IE02xlV1BUM2zPGmP7WqKWLg0xaJRwbtQWBZzdI3eEtw/VZho+Gr7F++cLFe+9
         8gaw8MCFL+hyU8BLyYNkhpdyJN8X9ZR70amROLzu0Je08c/uIIO9qUb0JhfdDYlTUQrd
         SBIoVBNiIw5gmJjbHXqOcq7ZamHPYI0oir+hVkSR6iN3ptZaQKfpr6i4tLOMn8+0qqMB
         NTmN0NFbQypIwsSf6qMcwhlOuNK3dJ44VSpC+ZFwd+iNuO1+FyugkMNc5Ew30RcPkRG2
         A14A==
X-Received: by 10.180.103.227 with SMTP id fz3mr7999619wib.29.1396223032053;
        Sun, 30 Mar 2014 16:43:52 -0700 (PDT)
Received: from [10.0.1.226] (chello089173067059.chello.sk. [89.173.67.59])
        by mx.google.com with ESMTPSA id w12sm28946785eez.36.2014.03.30.16.43.50
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 30 Mar 2014 16:43:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <533874F9.3090802@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245488>

Git commit honors the 'ignore' setting from .gitmodules or .git/config,
but didn't allow to override it from command line, like other commands do.

Useful <when> values for commit are 'all' (default) or 'none'. The others
('dirty' and 'untracked') have same effect as 'none', as commit is only
interested in whether the submodule's HEAD differs from what is commited
in the superproject.

Changes in add.c and cache.h (and related compilo fix in checkout.c) are
needed to make it work for "commit -a" too.

Signed-off-by: Ronald Weiss <weiss.ronald@gmail.com>
---
On 30. 3. 2014 21:48, Jens Lehmann wrote:
> Looking good so far, but we definitely need tests for this new option.

I added two simple tests (one for --ignore-submodules=all, another one
for =none). But I am sure the tests could be written better, by someone
more proficient in Git than I am.

The tests immediately revealed, that the patch was not complete. It
didn't work with commit message given on command line (-m). To make
that work, I had to also patch the index_differs_from function in
diff-lib.c.

> But I wonder if it would make more sense to start by teaching the
> --ignore-submodules option to git add. Then this patch could reuse
> that for commit -a.

That sounds reasonable, however I don't think that any code from my
patch would be affected, or would it? IOW, would commit really "reuse"
anything? If not (or not much), there is probably no point in
postponing this patch, support for git add may be added later.


 Documentation/git-commit.txt        |  6 ++++++
 builtin/add.c                       | 16 +++++++++++----
 builtin/checkout.c                  |  2 +-
 builtin/commit.c                    | 10 ++++++++--
 cache.h                             |  2 +-
 diff-lib.c                          |  7 ++++++-
 diff.h                              |  3 ++-
 sequencer.c                         |  4 ++--
 t/t7513-commit-ignore-submodules.sh | 39 +++++++++++++++++++++++++++++++++++++
 9 files changed, 77 insertions(+), 12 deletions(-)
 create mode 100644 t/t7513-commit-ignore-submodules.sh

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 1a7616c..c8839c8 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -13,6 +13,7 @@ SYNOPSIS
 	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
 	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
 	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
+	   [--ignore-submodules[=<when>]]
 	   [-i | -o] [-S[<keyid>]] [--] [<file>...]
 
 DESCRIPTION
@@ -271,6 +272,11 @@ The possible options are:
 The default can be changed using the status.showUntrackedFiles
 configuration variable documented in linkgit:git-config[1].
 
+--ignore-submodules[=<when>]::
+	Can be used to override any settings of the 'ignore' option
+	in linkgit:git-config[1] or linkgit:gitmodules[5].
+	<when> can be either "none" or "all", which is the default.
+
 -v::
 --verbose::
 	Show unified diff between the HEAD commit and what
diff --git a/builtin/add.c b/builtin/add.c
index 672adc0..1086294 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -168,7 +168,8 @@ static void update_callback(struct diff_queue_struct *q,
 
 static void update_files_in_cache(const char *prefix,
 				  const struct pathspec *pathspec,
-				  struct update_callback_data *data)
+				  struct update_callback_data *data,
+				  const char *ignore_submodules_arg)
 {
 	struct rev_info rev;
 
@@ -180,17 +181,24 @@ static void update_files_in_cache(const char *prefix,
 	rev.diffopt.format_callback = update_callback;
 	rev.diffopt.format_callback_data = data;
 	rev.max_count = 0; /* do not compare unmerged paths with stage #2 */
+
+	if (ignore_submodules_arg) {
+		DIFF_OPT_SET(&rev.diffopt, OVERRIDE_SUBMODULE_CONFIG);
+		handle_ignore_submodules_arg(&rev.diffopt, ignore_submodules_arg);
+	}
+
 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
 }
 
 int add_files_to_cache(const char *prefix,
-		       const struct pathspec *pathspec, int flags)
+		       const struct pathspec *pathspec, int flags,
+		       const char *ignore_submodules_arg)
 {
 	struct update_callback_data data;
 
 	memset(&data, 0, sizeof(data));
 	data.flags = flags;
-	update_files_in_cache(prefix, pathspec, &data);
+	update_files_in_cache(prefix, pathspec, &data, ignore_submodules_arg);
 	return !!data.add_errors;
 }
 
@@ -576,7 +584,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		memset(&pathspec, 0, sizeof(pathspec));
 	}
 	update_data.flags = flags & ~ADD_CACHE_IMPLICIT_DOT;
-	update_files_in_cache(prefix, &pathspec, &update_data);
+	update_files_in_cache(prefix, &pathspec, &update_data, NULL);
 
 	exit_status |= !!update_data.add_errors;
 	if (add_new_files)
diff --git a/builtin/checkout.c b/builtin/checkout.c
index ada51fa..22a4b48 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -525,7 +525,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			 * entries in the index.
 			 */
 
-			add_files_to_cache(NULL, NULL, 0);
+			add_files_to_cache(NULL, NULL, 0, NULL);
 			/*
 			 * NEEDSWORK: carrying over local changes
 			 * when branches have different end-of-line
diff --git a/builtin/commit.c b/builtin/commit.c
index 26b2986..b3fb28e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -360,7 +360,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
 	 */
 	if (all || (also && pathspec.nr)) {
 		fd = hold_locked_index(&index_lock, 1);
-		add_files_to_cache(also ? prefix : NULL, &pathspec, 0);
+		add_files_to_cache(also ? prefix : NULL, &pathspec, 0, ignore_submodule_arg);
 		refresh_cache_or_die(refresh_flags);
 		update_main_cache_tree(WRITE_TREE_SILENT);
 		if (write_cache(fd, active_cache, active_nr) ||
@@ -827,7 +827,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		if (get_sha1(parent, sha1))
 			commitable = !!active_nr;
 		else
-			commitable = index_differs_from(parent, 0);
+			commitable = index_differs_from(parent, 0, ignore_submodule_arg);
 	}
 	strbuf_release(&committer_ident);
 
@@ -1492,6 +1492,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "amend", &amend, N_("amend previous commit")),
 		OPT_BOOL(0, "no-post-rewrite", &no_post_rewrite, N_("bypass post-rewrite hook")),
 		{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, N_("mode"), N_("show untracked files, optional modes: all, normal, no. (Default: all)"), PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
+		{ OPTION_STRING, 0, "ignore-submodules", &ignore_submodule_arg, N_("when"),
+		  N_("ignore changes to submodules, optional when: all, none. (Default: all)"),
+		  PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
 		/* end commit contents options */
 
 		OPT_HIDDEN_BOOL(0, "allow-empty", &allow_empty,
@@ -1531,6 +1534,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	argc = parse_and_validate_options(argc, argv, builtin_commit_options,
 					  builtin_commit_usage,
 					  prefix, current_head, &s);
+
+	s.ignore_submodule_arg = ignore_submodule_arg;
+
 	if (dry_run)
 		return dry_run_commit(argc, argv, prefix, current_head, &s);
 	index_file = prepare_index(argc, argv, prefix, current_head, 0);
diff --git a/cache.h b/cache.h
index ebe9a40..5ef8dd6 100644
--- a/cache.h
+++ b/cache.h
@@ -1282,7 +1282,7 @@ void packet_trace_identity(const char *prog);
  * return 0 if success, 1 - if addition of a file failed and
  * ADD_FILES_IGNORE_ERRORS was specified in flags
  */
-int add_files_to_cache(const char *prefix, const struct pathspec *pathspec, int flags);
+int add_files_to_cache(const char *prefix, const struct pathspec *pathspec, int flags, const char *ignore_submodules_arg);
 
 /* diff.c */
 extern int diff_auto_refresh_index;
diff --git a/diff-lib.c b/diff-lib.c
index 2eddc66..fec5ad4 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -508,7 +508,8 @@ int do_diff_cache(const unsigned char *tree_sha1, struct diff_options *opt)
 	return 0;
 }
 
-int index_differs_from(const char *def, int diff_flags)
+int index_differs_from(const char *def, int diff_flags,
+		       const char *ignore_submodules_arg)
 {
 	struct rev_info rev;
 	struct setup_revision_opt opt;
@@ -520,6 +521,10 @@ int index_differs_from(const char *def, int diff_flags)
 	DIFF_OPT_SET(&rev.diffopt, QUICK);
 	DIFF_OPT_SET(&rev.diffopt, EXIT_WITH_STATUS);
 	rev.diffopt.flags |= diff_flags;
+	if (ignore_submodules_arg) {
+		DIFF_OPT_SET(&rev.diffopt, OVERRIDE_SUBMODULE_CONFIG);
+		handle_ignore_submodules_arg(&rev.diffopt, ignore_submodules_arg);
+	}
 	run_diff_index(&rev, 1);
 	if (rev.pending.alloc)
 		free(rev.pending.objects);
diff --git a/diff.h b/diff.h
index ce123fa..0ac869b 100644
--- a/diff.h
+++ b/diff.h
@@ -334,7 +334,8 @@ extern int diff_result_code(struct diff_options *, int);
 
 extern void diff_no_index(struct rev_info *, int, const char **, const char *);
 
-extern int index_differs_from(const char *def, int diff_flags);
+extern int index_differs_from(const char *def, int diff_flags,
+			      const char *ignore_submodules_arg);
 
 extern size_t fill_textconv(struct userdiff_driver *driver,
 			    struct diff_filespec *df,
diff --git a/sequencer.c b/sequencer.c
index 90cac7b..de9edec 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -496,7 +496,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		unborn = get_sha1("HEAD", head);
 		if (unborn)
 			hashcpy(head, EMPTY_TREE_SHA1_BIN);
-		if (index_differs_from(unborn ? EMPTY_TREE_SHA1_HEX : "HEAD", 0))
+		if (index_differs_from(unborn ? EMPTY_TREE_SHA1_HEX : "HEAD", 0, NULL))
 			return error_dirty_index(opts);
 	}
 	discard_cache();
@@ -1042,7 +1042,7 @@ static int sequencer_continue(struct replay_opts *opts)
 		if (ret)
 			return ret;
 	}
-	if (index_differs_from("HEAD", 0))
+	if (index_differs_from("HEAD", 0, NULL))
 		return error_dirty_index(opts);
 	todo_list = todo_list->next;
 	return pick_commits(todo_list, opts);
diff --git a/t/t7513-commit-ignore-submodules.sh b/t/t7513-commit-ignore-submodules.sh
new file mode 100644
index 0000000..a3a68ce
--- /dev/null
+++ b/t/t7513-commit-ignore-submodules.sh
@@ -0,0 +1,39 @@
+#!/bin/sh
+
+test_description='git commit --ignore-submodules'
+
+. ./test-lib.sh
+
+test_expect_success 'create submodule' '
+	test_create_repo sm && (
+		cd sm &&
+		>foo &&
+		git add foo &&
+		git commit -m "Add foo"
+	) &&
+	git submodule add ./sm &&
+	git commit -m "Add sm"
+'
+
+update_sm () {
+	(cd sm &&
+		echo bar >> foo &&
+		git add foo &&
+		git commit -m "Updated foo"
+	)
+}
+
+test_expect_success 'commit -a --ignore-submodules=all ignores dirty submodule' '
+	update_sm &&
+	test_must_fail git commit -a --ignore-submodules=all -m "Update sm"
+'
+
+test_expect_success 'commit -a --ignore-submodules=none overrides ignore=all setting' '
+	update_sm &&
+	git config submodule.sm.ignore all &&
+	git commit -a -m "Update sm" &&
+	git diff-index --exit-code --cached --ignore-submodules=none HEAD &&
+	git diff-files --exit-code --ignore-submodules=none
+'
+
+test_done
-- 
1.9.0
 
