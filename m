From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 9/9] revert: simplify communicating command-line arguments
Date: Fri,  9 Dec 2011 21:12:06 +0530
Message-ID: <1323445326-24637-10-git-send-email-artagnon@gmail.com>
References: <1323445326-24637-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 09 16:43:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ2c1-0001Cs-SL
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 16:43:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754565Ab1LIPnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 10:43:43 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45239 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754480Ab1LIPnm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 10:43:42 -0500
Received: by mail-iy0-f174.google.com with SMTP id c1so4391329iak.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 07:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=xtyhTjXT7oNzGygBTDSNHfTU0trKly8xQnn1y1tzzG4=;
        b=mXpoZor9bG+IJiBDQVpezX2sY6bm56G8EIdVRB7Pk3Ymw2AtOBX53+tdBA9mEjJC6N
         9owjk3mpBClu7ukYH/l1xfMtOqIbfx45/wyQQZJDOePuCnxax3TfDkYxiNypLkZkbXOi
         Jnqa9CF8X4CzQr1ja/gwoszXjs34LBdT684O4=
Received: by 10.42.153.5 with SMTP id k5mr2883715icw.46.1323445422407;
        Fri, 09 Dec 2011 07:43:42 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id a2sm18298821igj.7.2011.12.09.07.43.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 09 Dec 2011 07:43:41 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1323445326-24637-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186647>

From: Jonathan Nieder <jrnieder@gmail.com>

Since 7e2bfd3f (revert: allow cherry-picking more than one commit,
2010-07-02), the pick/revert machinery has kept track of the set of
commits to be cherry-picked or reverted using commit_argc and
commit_argv variables, storing the corresponding command-line
parameters.

Future callers as other commands are built in (am, rebase, sequencer)
may find it easier to pass rev-list options to this machinery in
already-parsed form.  So, teach cmd_cherry_pick and cmd_revert to
parse the rev-list arguments in advance and pass the commit set to
pick_revisions() as a "struct rev_info".

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Acked-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/revert.c                |   53 +++++++++++++++++++++-----------------
 t/t3510-cherry-pick-sequence.sh |   11 ++++++++
 2 files changed, 40 insertions(+), 24 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index e2355d8..8d86bfd 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -66,13 +66,14 @@ struct replay_opts {
 	int allow_rerere_auto;
 
 	int mainline;
-	int commit_argc;
-	const char **commit_argv;
 
 	/* Merge strategy */
 	const char *strategy;
 	const char **xopts;
 	size_t xopts_nr, xopts_alloc;
+
+	/* Only used by REPLAY_NONE */
+	struct rev_info *revs;
 };
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
@@ -175,9 +176,9 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 			die(_("program error"));
 	}
 
-	opts->commit_argc = parse_options(argc, argv, NULL, options, usage_str,
-					PARSE_OPT_KEEP_ARGV0 |
-					PARSE_OPT_KEEP_UNKNOWN);
+	argc = parse_options(argc, argv, NULL, options, usage_str,
+			PARSE_OPT_KEEP_ARGV0 |
+			PARSE_OPT_KEEP_UNKNOWN);
 
 	/* Check for incompatible subcommands */
 	verify_opt_mutually_compatible(me,
@@ -219,9 +220,6 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 				NULL);
 	}
 
-	else if (opts->commit_argc < 2)
-		usage_with_options(usage_str, options);
-
 	if (opts->allow_ff)
 		verify_opt_compatible(me, "--ff",
 				"--signoff", opts->signoff,
@@ -229,7 +227,20 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 				"-x", opts->record_origin,
 				"--edit", opts->edit,
 				NULL);
-	opts->commit_argv = argv;
+
+	if (opts->subcommand == REPLAY_NONE) {
+		opts->revs = xmalloc(sizeof(*opts->revs));
+		init_revisions(opts->revs, NULL);
+		opts->revs->no_walk = 1;
+		if (argc < 2)
+			usage_with_options(usage_str, options);
+		argc = setup_revisions(argc, argv, opts->revs, NULL);
+	} else
+		opts->revs = NULL;
+
+	/* Forbid stray command-line arguments */
+	if (argc > 1)
+		usage_with_options(usage_str, options);
 }
 
 struct commit_message {
@@ -638,23 +649,15 @@ static int do_pick_commit(struct commit *commit, enum replay_action action,
 	return res;
 }
 
-static void prepare_revs(struct rev_info *revs, struct replay_opts *opts)
+static void prepare_revs(struct replay_opts *opts)
 {
-	int argc;
-
-	init_revisions(revs, NULL);
-	revs->no_walk = 1;
 	if (opts->action != REPLAY_REVERT)
-		revs->reverse = 1;
+		opts->revs->reverse ^= 1;
 
-	argc = setup_revisions(opts->commit_argc, opts->commit_argv, revs, NULL);
-	if (argc > 1)
-		usage(*revert_or_cherry_pick_usage(opts));
-
-	if (prepare_revision_walk(revs))
+	if (prepare_revision_walk(opts->revs))
 		die(_("revision walk setup failed"));
 
-	if (!revs->commits)
+	if (!opts->revs->commits)
 		die(_("empty commit set passed"));
 }
 
@@ -851,14 +854,13 @@ static void read_populate_opts(struct replay_opts **opts_ptr)
 static void walk_revs_populate_todo(struct replay_insn_list **todo_list,
 				struct replay_opts *opts)
 {
-	struct rev_info revs;
 	struct commit *commit;
 	struct replay_insn_list **next;
 
-	prepare_revs(&revs, opts);
+	prepare_revs(opts);
 
 	next = todo_list;
-	while ((commit = get_revision(&revs)))
+	while ((commit = get_revision(opts->revs)))
 		next = replay_insn_list_append(opts->action, commit, next);
 }
 
@@ -1051,6 +1053,9 @@ static int pick_revisions(struct replay_opts *opts)
 	struct replay_insn_list *todo_list = NULL;
 	unsigned char sha1[20];
 
+	if (opts->subcommand == REPLAY_NONE)
+		assert(opts->revs);
+
 	read_and_refresh_cache(opts);
 
 	/*
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index aee869d..1f4685a 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -414,4 +414,15 @@ test_expect_success 'mixed pick and revert instructions' '
 	test_cmp expect actual
 '
 
+test_expect_success 'empty commit set' '
+	pristine_detach initial &&
+	test_expect_code 128 git cherry-pick base..base
+'
+
+test_expect_success 'commit set passed through --all' '
+	pristine_detach initial &&
+	test_expect_code 1 git cherry-pick --all &&
+	git cherry-pick --continue
+'
+
 test_done
-- 
1.7.7.3
