Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA69A1F404
	for <e@80x24.org>; Wed, 20 Dec 2017 14:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755389AbdLTOnF (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 09:43:05 -0500
Received: from siwi.pair.com ([209.68.5.199]:23048 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753868AbdLTOm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 09:42:56 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id C07CD845E9;
        Wed, 20 Dec 2017 09:42:55 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 4C5F5845D4;
        Wed, 20 Dec 2017 09:42:55 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 1/4] status: add --no-ahead-behind to porcelain V2
Date:   Wed, 20 Dec 2017 14:42:42 +0000
Message-Id: <20171220144245.39401-2-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171220144245.39401-1-git@jeffhostetler.com>
References: <20171220144245.39401-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach "status --porcelain=v2 --branch" to omit "# branch.ab x y"
when "--no-ahead-behind" argument is used.

This allows the user to omit the (possibly extremely expensive)
ahead/behind computation when not needed.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/config.txt     |  5 +++++
 Documentation/git-status.txt | 10 ++++++++++
 builtin/commit.c             |  6 ++++++
 t/t7064-wtstatus-pv2.sh      | 23 +++++++++++++++++++++++
 wt-status.c                  | 11 ++++++++++-
 wt-status.h                  |  1 +
 6 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9593bfa..9ccdf2b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3082,6 +3082,11 @@ status.submoduleSummary::
 	submodule summary' command, which shows a similar output but does
 	not honor these settings.
 
+status.noaheadbehind::
+	Do not compute ahead/behind counts for a branch relative to its
+	upstream branch.  This can be used to avoid a possibly very
+	expensive computation on extremely large repositories.
+
 stash.showPatch::
 	If this is set to true, the `git stash show` command without an
 	option will show the stash entry in patch form.  Defaults to false.
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 9f3a78a..6ce8cf8 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -111,6 +111,13 @@ configuration variable documented in linkgit:git-config[1].
 	without options are equivalent to 'always' and 'never'
 	respectively.
 
+--no-ahead-behind::
+	Do not compute ahead/behind counts for the current branch relative
+	to the upstream branch.  This can be used to avoid a possibly very
+	expensive computation on extremely large repositories.
++
+	In porcelain V2 format, the 'branch.ab' line will not be present.
+
 <pathspec>...::
 	See the 'pathspec' entry in linkgit:gitglossary[7].
 
@@ -253,6 +260,9 @@ information about the current branch.
 					     the commit is present.
     ------------------------------------------------------------
 
+If `--no-ahead-behind` is given or 'status.noaheadbehind' is set, the
+'branch.ab' line will not be present.
+
 ### Changed Tracked Entries
 
 Following the headers, a series of lines are printed for tracked
diff --git a/builtin/commit.c b/builtin/commit.c
index be370f6..99ca5cb 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1335,6 +1335,10 @@ static int git_status_config(const char *k, const char *v, void *cb)
 			return error(_("Invalid untracked files mode '%s'"), v);
 		return 0;
 	}
+	if (!strcmp(k, "status.noaheadbehind")) {
+		s->no_ahead_behind = git_config_bool(k, v);
+		return 0;
+	}
 	return git_diff_ui_config(k, v, NULL);
 }
 
@@ -1369,6 +1373,8 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		  N_("ignore changes to submodules, optional when: all, dirty, untracked. (Default: all)"),
 		  PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
 		OPT_COLUMN(0, "column", &s.colopts, N_("list untracked files in columns")),
+		OPT_BOOL(0, "no-ahead-behind", &s.no_ahead_behind,
+			 N_("omit branch ahead/behind counts")),
 		OPT_END(),
 	};
 
diff --git a/t/t7064-wtstatus-pv2.sh b/t/t7064-wtstatus-pv2.sh
index e319fa2..4be2b20 100755
--- a/t/t7064-wtstatus-pv2.sh
+++ b/t/t7064-wtstatus-pv2.sh
@@ -390,6 +390,29 @@ test_expect_success 'verify upstream fields in branch header' '
 	)
 '
 
+test_expect_success 'verify --no-ahead-behind omits branch.ab' '
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
+		EOF
+
+		git status --no-ahead-behind --porcelain=v2 --branch --untracked-files=all >actual &&
+		test_cmp expect actual &&
+
+		git -c status.noaheadbehind=true status --porcelain=v2 --branch --untracked-files=all >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'create and add submodule, submodule appears clean (A. S...)' '
 	git checkout master &&
 	git clone . sub_repo &&
diff --git a/wt-status.c b/wt-status.c
index 94e5eba..1bc53e1 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1889,6 +1889,8 @@ static void wt_porcelain_print(struct wt_status *s)
  *                 <eol> ::= NUL when -z,
  *                           LF when NOT -z.
  *
+ * When 'status.noaheadbehind' is true or '--no-ahead-behind'
+ * is given on the command line, the 'branch.ab' line is omitted.
  */
 static void wt_porcelain_v2_print_tracking(struct wt_status *s)
 {
@@ -1928,7 +1930,14 @@ static void wt_porcelain_v2_print_tracking(struct wt_status *s)
 		/* Lookup stats on the upstream tracking branch, if set. */
 		branch = branch_get(branch_name);
 		base = NULL;
-		ab_info = (stat_tracking_info(branch, &nr_ahead, &nr_behind, &base) == 0);
+
+		if (s->no_ahead_behind) {
+			base = branch_get_upstream(branch, NULL);
+			ab_info = 0;
+		} else {
+			ab_info = (stat_tracking_info(branch, &nr_ahead, &nr_behind, &base) == 0);
+		}
+
 		if (base) {
 			base = shorten_unambiguous_ref(base, 0);
 			fprintf(s->fp, "# branch.upstream %s%c", base, eol);
diff --git a/wt-status.h b/wt-status.h
index 64f4d33..8708977 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -80,6 +80,7 @@ struct wt_status {
 	int show_branch;
 	int show_stash;
 	int hints;
+	int no_ahead_behind;
 
 	enum wt_status_format status_format;
 	unsigned char sha1_commit[GIT_MAX_RAWSZ]; /* when not Initial */
-- 
2.9.3

