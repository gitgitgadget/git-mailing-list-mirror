Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46A411F406
	for <e@80x24.org>; Tue,  9 Jan 2018 18:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934980AbeAISuc (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 13:50:32 -0500
Received: from siwi.pair.com ([209.68.5.199]:42244 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932279AbeAISub (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 13:50:31 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id AAC2A84512;
        Tue,  9 Jan 2018 13:50:30 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id F3512844DA;
        Tue,  9 Jan 2018 13:50:29 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v5 2/4] status: add --[no-]ahead-behind to status and commit for V2 format.
Date:   Tue,  9 Jan 2018 18:50:16 +0000
Message-Id: <20180109185018.69164-3-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180109185018.69164-1-git@jeffhostetler.com>
References: <20180109185018.69164-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach "git status" and "git commit" to accept "--no-ahead-behind"
and "--ahead-behind" arguments to request quick or full ahead/behind
reporting.

When "--no-ahead-behind" is given, the existing porcelain V2 line
"branch.ab +x -y" is replaced with a new "branch.ab +? -?" line.
This indicates that the branch and its upstream are or are not equal
without the expense of computing the full ahead/behind values.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/git-status.txt |  5 ++++
 builtin/commit.c             |  7 +++++
 remote.c                     |  2 ++
 remote.h                     |  5 ++--
 t/t7064-wtstatus-pv2.sh      | 62 ++++++++++++++++++++++++++++++++++++++++++++
 wt-status.c                  | 30 ++++++++++++++-------
 wt-status.h                  |  2 ++
 7 files changed, 102 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 9f3a78a..603bf40 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -111,6 +111,11 @@ configuration variable documented in linkgit:git-config[1].
 	without options are equivalent to 'always' and 'never'
 	respectively.
 
+--ahead-behind::
+--no-ahead-behind::
+	Display or do not display detailed ahead/behind counts for the
+	branch relative to its upstream branch.  Defaults to true.
+
 <pathspec>...::
 	See the 'pathspec' entry in linkgit:gitglossary[7].
 
diff --git a/builtin/commit.c b/builtin/commit.c
index be370f6..cfe7c62 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1137,6 +1137,9 @@ static void finalize_deferred_config(struct wt_status *s)
 		s->show_branch = status_deferred_config.show_branch;
 	if (s->show_branch < 0)
 		s->show_branch = 0;
+
+	if (s->ahead_behind_flags == AHEAD_BEHIND_UNSPECIFIED)
+		s->ahead_behind_flags = AHEAD_BEHIND_FULL;
 }
 
 static int parse_and_validate_options(int argc, const char *argv[],
@@ -1351,6 +1354,8 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 			 N_("show branch information")),
 		OPT_BOOL(0, "show-stash", &s.show_stash,
 			 N_("show stash information")),
+		OPT_BOOL(0, "ahead-behind", &s.ahead_behind_flags,
+			 N_("compute full ahead/behind values")),
 		{ OPTION_CALLBACK, 0, "porcelain", &status_format,
 		  N_("version"), N_("machine-readable output"),
 		  PARSE_OPT_OPTARG, opt_parse_porcelain },
@@ -1628,6 +1633,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT(0, "short", &status_format, N_("show status concisely"),
 			    STATUS_FORMAT_SHORT),
 		OPT_BOOL(0, "branch", &s.show_branch, N_("show branch information")),
+		OPT_BOOL(0, "ahead-behind", &s.ahead_behind_flags,
+			 N_("compute full ahead/behind values")),
 		OPT_SET_INT(0, "porcelain", &status_format,
 			    N_("machine-readable output"), STATUS_FORMAT_PORCELAIN),
 		OPT_SET_INT(0, "long", &status_format,
diff --git a/remote.c b/remote.c
index 23177f5..2486afb 100644
--- a/remote.c
+++ b/remote.c
@@ -2028,6 +2028,8 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 		return 0;
 	if (abf == AHEAD_BEHIND_QUICK)
 		return 1;
+	if (abf != AHEAD_BEHIND_FULL)
+		BUG("stat_tracking_info: invalid abf '%d'", abf);
 
 	/* Run "rev-list --left-right ours...theirs" internally... */
 	argv_array_push(&argv, ""); /* ignored */
diff --git a/remote.h b/remote.h
index 00932f5..27feb63 100644
--- a/remote.h
+++ b/remote.h
@@ -257,8 +257,9 @@ enum match_refs_flags {
 
 /* Flags for --ahead-behind option. */
 enum ahead_behind_flags {
-	AHEAD_BEHIND_QUICK = 0,  /* just eq/neq reporting */
-	AHEAD_BEHIND_FULL  = 1,  /* traditional a/b reporting */
+	AHEAD_BEHIND_UNSPECIFIED = -1,
+	AHEAD_BEHIND_QUICK       =  0,  /* just eq/neq reporting */
+	AHEAD_BEHIND_FULL        =  1,  /* traditional a/b reporting */
 };
 
 /* Reporting of tracking info */
diff --git a/t/t7064-wtstatus-pv2.sh b/t/t7064-wtstatus-pv2.sh
index e319fa2..8f79532 100755
--- a/t/t7064-wtstatus-pv2.sh
+++ b/t/t7064-wtstatus-pv2.sh
@@ -390,6 +390,68 @@ test_expect_success 'verify upstream fields in branch header' '
 	)
 '
 
+test_expect_success 'verify --[no-]ahead-behind with V2 format' '
+	git checkout master &&
+	test_when_finished "rm -rf sub_repo" &&
+	git clone . sub_repo &&
+	(
+		## Confirm local master tracks remote master.
+		cd sub_repo &&
+		HUF=$(git rev-parse HEAD) &&
+
+		# Confirm --no-ahead-behind reports traditional branch.ab with 0/0 for equal branches.
+		cat >expect <<-EOF &&
+		# branch.oid $HUF
+		# branch.head master
+		# branch.upstream origin/master
+		# branch.ab +0 -0
+		EOF
+
+		git status --no-ahead-behind --porcelain=v2 --branch --untracked-files=all >actual &&
+		test_cmp expect actual &&
+
+		# Confirm --ahead-behind reports traditional branch.ab with 0/0.
+		cat >expect <<-EOF &&
+		# branch.oid $HUF
+		# branch.head master
+		# branch.upstream origin/master
+		# branch.ab +0 -0
+		EOF
+
+		git status --ahead-behind --porcelain=v2 --branch --untracked-files=all >actual &&
+		test_cmp expect actual &&
+
+		## Test non-equal ahead/behind.
+		echo xyz >file_xyz &&
+		git add file_xyz &&
+		git commit -m xyz &&
+
+		HUF=$(git rev-parse HEAD) &&
+
+		# Confirm --no-ahead-behind reports branch.ab with ?/? for non-equal branches.
+		cat >expect <<-EOF &&
+		# branch.oid $HUF
+		# branch.head master
+		# branch.upstream origin/master
+		# branch.ab +? -?
+		EOF
+
+		git status --no-ahead-behind --porcelain=v2 --branch --untracked-files=all >actual &&
+		test_cmp expect actual &&
+
+		# Confirm --ahead-behind reports traditional branch.ab with 1/0.
+		cat >expect <<-EOF &&
+		# branch.oid $HUF
+		# branch.head master
+		# branch.upstream origin/master
+		# branch.ab +1 -0
+		EOF
+
+		git status --ahead-behind --porcelain=v2 --branch --untracked-files=all >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'create and add submodule, submodule appears clean (A. S...)' '
 	git checkout master &&
 	git clone . sub_repo &&
diff --git a/wt-status.c b/wt-status.c
index 8f7fdc6..3fcab57 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -136,6 +136,7 @@ void wt_status_prepare(struct wt_status *s)
 	s->ignored.strdup_strings = 1;
 	s->show_branch = -1;  /* unspecified */
 	s->show_stash = 0;
+	s->ahead_behind_flags = AHEAD_BEHIND_UNSPECIFIED;
 	s->display_comment_prefix = 0;
 }
 
@@ -1878,18 +1879,19 @@ static void wt_porcelain_print(struct wt_status *s)
  *
  *    <upstream> ::= the upstream branch name, when set.
  *
- *       <ahead> ::= integer ahead value, when upstream set
- *                   and the commit is present (not gone).
- *
- *      <behind> ::= integer behind value, when upstream set
- *                   and commit is present.
+ *       <ahead> ::= integer ahead value or '?'.
  *
+ *      <behind> ::= integer behind value or '?'.
  *
  * The end-of-line is defined by the -z flag.
  *
  *                 <eol> ::= NUL when -z,
  *                           LF when NOT -z.
  *
+ * When an upstream is set and present, the 'branch.ab' line will
+ * be printed with the ahead/behind counts for the branch and the
+ * upstream.  When AHEAD_BEHIND_QUICK is requested and the branches
+ * are different, '?' will be substituted for the actual count.
  */
 static void wt_porcelain_v2_print_tracking(struct wt_status *s)
 {
@@ -1929,15 +1931,25 @@ static void wt_porcelain_v2_print_tracking(struct wt_status *s)
 		/* Lookup stats on the upstream tracking branch, if set. */
 		branch = branch_get(branch_name);
 		base = NULL;
-		ab_info = (stat_tracking_info(branch, &nr_ahead, &nr_behind,
-					      &base, AHEAD_BEHIND_FULL) >= 0);
+		ab_info = stat_tracking_info(branch, &nr_ahead, &nr_behind,
+					     &base, s->ahead_behind_flags);
 		if (base) {
 			base = shorten_unambiguous_ref(base, 0);
 			fprintf(s->fp, "# branch.upstream %s%c", base, eol);
 			free((char *)base);
 
-			if (ab_info)
-				fprintf(s->fp, "# branch.ab +%d -%d%c", nr_ahead, nr_behind, eol);
+			if (ab_info > 0) {
+				/* different */
+				if (nr_ahead || nr_behind)
+					fprintf(s->fp, "# branch.ab +%d -%d%c",
+						nr_ahead, nr_behind, eol);
+				else
+					fprintf(s->fp, "# branch.ab +? -?%c",
+						eol);
+			} else if (!ab_info) {
+				/* same */
+				fprintf(s->fp, "# branch.ab +0 -0%c", eol);
+			}
 		}
 	}
 
diff --git a/wt-status.h b/wt-status.h
index 64f4d33..b450b53 100644
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
+	enum ahead_behind_flags ahead_behind_flags;
 
 	enum wt_status_format status_format;
 	unsigned char sha1_commit[GIT_MAX_RAWSZ]; /* when not Initial */
-- 
2.9.3

