Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D43D41F424
	for <e@80x24.org>; Thu, 21 Dec 2017 19:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754983AbdLUTJX (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Dec 2017 14:09:23 -0500
Received: from siwi.pair.com ([209.68.5.199]:46524 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752483AbdLUTJT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Dec 2017 14:09:19 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id CEE57844E7;
        Thu, 21 Dec 2017 14:09:18 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 54C63844E1;
        Thu, 21 Dec 2017 14:09:18 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v2 3/5] status: add --[no-]ahead-behind to porcelain V2 output
Date:   Thu, 21 Dec 2017 19:09:07 +0000
Message-Id: <20171221190909.62995-4-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171221190909.62995-1-git@jeffhostetler.com>
References: <20171221190909.62995-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach "status --porcelain=v2 --branch" to omit detailed ahead/behind
information when "--no-ahead-behind" argument is used.

When "--no-ahead-behind" is given, the existing "branch.ab x y" line
is replaced with a new "branch.qab eq|neq" line.

This allows the user to omit the (possibly extremely expensive)
ahead/behind computation when not wanted.  In its place, a single
equal/not-equal line is reported.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/git-status.txt | 11 ++++++--
 builtin/commit.c             | 19 ++++++++++++++
 t/t7064-wtstatus-pv2.sh      | 60 ++++++++++++++++++++++++++++++++++++++++++++
 wt-status.c                  | 24 ++++++++++++++----
 wt-status.h                  |  2 ++
 5 files changed, 109 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 9f3a78a..d0e5f89 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -111,6 +111,12 @@ configuration variable documented in linkgit:git-config[1].
 	without options are equivalent to 'always' and 'never'
 	respectively.
 
+--ahead-behind::
+--no-ahead-behind::
+	Display or do not display detailed ahead/behind counts for the branch
+	relative to its upstream branch.  Defaults to true.  Overrides the
+	value of "core.aheadbehind".
+
 <pathspec>...::
 	See the 'pathspec' entry in linkgit:gitglossary[7].
 
@@ -242,7 +248,8 @@ don't recognize.
 ### Branch Headers
 
 If `--branch` is given, a series of header lines are printed with
-information about the current branch.
+information about the current branch.  If `--no-ahead-behind` is given,
+the branch.ab line is replaced with the branch.qab line.
 
     Line                                     Notes
     ------------------------------------------------------------
@@ -250,7 +257,7 @@ information about the current branch.
     # branch.head <branch> | (detached)      Current branch.
     # branch.upstream <upstream_branch>      If upstream is set.
     # branch.ab +<ahead> -<behind>           If upstream is set and
-					     the commit is present.
+    # branch.qab eq | neq                    the commit is present.
     ------------------------------------------------------------
 
 ### Changed Tracked Entries
diff --git a/builtin/commit.c b/builtin/commit.c
index be370f6..d6e2717 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -141,6 +141,7 @@ static int sequencer_in_use;
 static int use_editor = 1, include_status = 1;
 static int show_ignored_in_status, have_option_m;
 static struct strbuf message = STRBUF_INIT;
+static int ahead_behind_opt = -1;
 
 static enum wt_status_format status_format = STATUS_FORMAT_UNSPECIFIED;
 
@@ -1369,6 +1370,8 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		  N_("ignore changes to submodules, optional when: all, dirty, untracked. (Default: all)"),
 		  PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
 		OPT_COLUMN(0, "column", &s.colopts, N_("list untracked files in columns")),
+		OPT_BOOL(0, "ahead-behind", &ahead_behind_opt,
+			 N_("compute branch ahead/behind values")),
 		OPT_END(),
 	};
 
@@ -1389,6 +1392,21 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		       PATHSPEC_PREFER_FULL,
 		       prefix, argv);
 
+	/*
+	 * Porcelain formats only look at the --[no-]ahead-behind command
+	 * line argument and DO NOT look at the config setting.  Non-porcelain
+	 * formats use both.
+	 */
+	if (status_format == STATUS_FORMAT_PORCELAIN ||
+	    status_format == STATUS_FORMAT_PORCELAIN_V2) {
+		if (ahead_behind_opt < 0)
+			ahead_behind_opt = ABF_FULL;
+	} else {
+		if (ahead_behind_opt < 0)
+			ahead_behind_opt = core_ahead_behind;
+	}
+	s.ab_flags = ((ahead_behind_opt) ? ABF_FULL : ABF_QUICK);
+
 	read_cache_preload(&s.pathspec);
 	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, &s.pathspec, NULL, NULL);
 
@@ -1667,6 +1685,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	s.commit_template = 1;
 	status_format = STATUS_FORMAT_NONE; /* Ignore status.short */
 	s.colopts = 0;
+	s.ab_flags = core_ahead_behind;
 
 	if (get_oid("HEAD", &oid))
 		current_head = NULL;
diff --git a/t/t7064-wtstatus-pv2.sh b/t/t7064-wtstatus-pv2.sh
index e319fa2..e132183 100755
--- a/t/t7064-wtstatus-pv2.sh
+++ b/t/t7064-wtstatus-pv2.sh
@@ -390,6 +390,66 @@ test_expect_success 'verify upstream fields in branch header' '
 	)
 '
 
+test_expect_success 'verify --no-ahead-behind generates branch.qab' '
+	git checkout master &&
+	test_when_finished "rm -rf sub_repo" &&
+	git clone . sub_repo &&
+	(
+		## Confirm local master tracks remote master.
+		cd sub_repo &&
+		HUF=$(git rev-parse HEAD) &&
+
+		cat >expect <<-EOF &&
+		# branch.oid $HUF
+		# branch.head master
+		# branch.upstream origin/master
+		# branch.qab eq
+		EOF
+
+		git status --no-ahead-behind --porcelain=v2 --branch --untracked-files=all >actual &&
+		test_cmp expect actual &&
+
+		cat >expect <<-EOF &&
+		# branch.oid $HUF
+		# branch.head master
+		# branch.upstream origin/master
+		# branch.ab +0 -0
+		EOF
+
+		# V2 does not use the config setting, only the command line argument.
+		git -c core.aheadbehind=false status --porcelain=v2 --branch --untracked-files=all >actual &&
+		test_cmp expect actual
+
+		## Test ahead/behind.
+		echo xyz >file_xyz &&
+		git add file_xyz &&
+		git commit -m xyz &&
+
+		HUF=$(git rev-parse HEAD) &&
+
+		cat >expect <<-EOF &&
+		# branch.oid $HUF
+		# branch.head master
+		# branch.upstream origin/master
+		# branch.qab neq
+		EOF
+
+		git status --no-ahead-behind --porcelain=v2 --branch --untracked-files=all >actual &&
+		test_cmp expect actual &&
+
+		cat >expect <<-EOF &&
+		# branch.oid $HUF
+		# branch.head master
+		# branch.upstream origin/master
+		# branch.ab +1 -0
+		EOF
+
+		# V2 does not use the config setting, only the command line argument.
+		git -c core.aheadbehind=false status --porcelain=v2 --branch --untracked-files=all >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'create and add submodule, submodule appears clean (A. S...)' '
 	git checkout master &&
 	git clone . sub_repo &&
diff --git a/wt-status.c b/wt-status.c
index 80c23ba..d03b47a 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1867,6 +1867,12 @@ static void wt_porcelain_print(struct wt_status *s)
  *   [# branch.upstream <upstream><eol>
  *   [# branch.ab +<ahead> -<behind><eol>]]
  *
+ * When the '--no-ahead-behind' parameter is given and an upstream
+ * is set and present, the branch.ab line is omitted and the following
+ * line is added (for quick ahead/behind):
+ *
+ *   [# branch.qab <equal><eol>]
+ *
  *      <commit> ::= the current commit hash or the the literal
  *                   "(initial)" to indicate an initialized repo
  *                   with no commits.
@@ -1883,6 +1889,8 @@ static void wt_porcelain_print(struct wt_status *s)
  *      <behind> ::= integer behind value, when upstream set
  *                   and commit is present.
  *
+ *       <equal> ::= literal string "eq" or "neq".
+ *
  *
  * The end-of-line is defined by the -z flag.
  *
@@ -1896,7 +1904,7 @@ static void wt_porcelain_v2_print_tracking(struct wt_status *s)
 	const char *base;
 	const char *branch_name;
 	struct wt_status_state state;
-	int have_ab_info, nr_ahead, nr_behind;
+	int nr_ahead, nr_behind, sti;
 	char eol = s->null_termination ? '\0' : '\n';
 
 	memset(&state, 0, sizeof(state));
@@ -1928,15 +1936,21 @@ static void wt_porcelain_v2_print_tracking(struct wt_status *s)
 		/* Lookup stats on the upstream tracking branch, if set. */
 		branch = branch_get(branch_name);
 		base = NULL;
-		have_ab_info = (stat_tracking_info(branch, &nr_ahead,
-						   &nr_behind, &base, ABF_FULL) >= 0);
+		sti = stat_tracking_info(branch, &nr_ahead, &nr_behind, &base,
+					 s->ab_flags);
 		if (base) {
 			base = shorten_unambiguous_ref(base, 0);
 			fprintf(s->fp, "# branch.upstream %s%c", base, eol);
 			free((char *)base);
 
-			if (have_ab_info)
-				fprintf(s->fp, "# branch.ab +%d -%d%c", nr_ahead, nr_behind, eol);
+			if (sti >= 0) {
+				if (s->ab_flags == ABF_FULL)
+					fprintf(s->fp, "# branch.ab +%d -%d%c",
+						nr_ahead, nr_behind, eol);
+				else
+					fprintf(s->fp, "# branch.qab %s%c",
+						(sti ? "neq" : "eq"), eol);
+			}
 		}
 	}
 
diff --git a/wt-status.h b/wt-status.h
index 64f4d33..5075d95 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -5,6 +5,7 @@
 #include "string-list.h"
 #include "color.h"
 #include "pathspec.h"
+#include "remote.h"
 
 struct worktree;
 
@@ -80,6 +81,7 @@ struct wt_status {
 	int show_branch;
 	int show_stash;
 	int hints;
+	enum ahead_behind_flags ab_flags;
 
 	enum wt_status_format status_format;
 	unsigned char sha1_commit[GIT_MAX_RAWSZ]; /* when not Initial */
-- 
2.9.3

