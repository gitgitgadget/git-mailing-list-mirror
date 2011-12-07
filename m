From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 5/5] revert: simplify communicating command-line arguments
Date: Wed,  7 Dec 2011 12:07:57 +0530
Message-ID: <1323239877-24101-6-git-send-email-artagnon@gmail.com>
References: <1323239877-24101-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 07:39:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYBA8-0000Op-Pe
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 07:39:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116Ab1LGGjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 01:39:25 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51429 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751826Ab1LGGjX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 01:39:23 -0500
Received: by mail-iy0-f174.google.com with SMTP id c1so437161iak.19
        for <git@vger.kernel.org>; Tue, 06 Dec 2011 22:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=F84CAr2KN/YRbIdOK7MlYuFq++mxqAY1bTwJ3F0Xnn0=;
        b=CSFfqqNsMTkoiCfvKvVlKUOIY6BJXgpTnr5JOnV2YPzcWoRDFRmwpnYH1lYmXQYhH4
         dGTnKs5Oo4BIp6C5f8xGut1BeyiuV8tP4nJ8pYPvkt7cNJTMtGbcN1Ux6vlsjf8q93k9
         81u3qU/vHO0RmNYukgJ4TScMM46wUk//UcCh0=
Received: by 10.50.163.97 with SMTP id yh1mr18560506igb.37.1323239962830;
        Tue, 06 Dec 2011 22:39:22 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id eb23sm3166839ibb.2.2011.12.06.22.39.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 06 Dec 2011 22:39:20 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1323239877-24101-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186430>

From: Jonathan Nieder <jrnieder@gmail.com>

Currently, command-line arguments are communicated using (argc, argv)
until a prepare_revs() turns it into a terse structure.  However,
since we plan to expose the cherry-picking machinery through a public
API in the future, we want callers to be able to call in with a
filled-in structure.  For the revert builtin, this means that the
chief argument parser, parse_args(), should parse into such a
structure.  Make this change.

[rr: minor improvements, commit message]

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/revert.c |   53 +++++++++++++++++++++++++++++------------------------
 1 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index f2bf198..3b25a0c 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -59,13 +59,14 @@ struct replay_opts {
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
@@ -168,9 +169,9 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
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
@@ -212,9 +213,6 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 				NULL);
 	}
 
-	else if (opts->commit_argc < 2)
-		usage_with_options(usage_str, options);
-
 	if (opts->allow_ff)
 		verify_opt_compatible(me, "--ff",
 				"--signoff", opts->signoff,
@@ -222,7 +220,20 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
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
@@ -631,23 +642,15 @@ static int do_pick_commit(struct commit *commit, enum replay_action action,
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
 
@@ -837,14 +840,13 @@ static void read_populate_opts(struct replay_opts **opts_ptr)
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
 
@@ -1037,6 +1039,9 @@ static int pick_revisions(struct replay_opts *opts)
 	struct replay_insn_list *todo_list = NULL;
 	unsigned char sha1[20];
 
+	if (opts->subcommand == REPLAY_NONE)
+		assert(opts->revs);
+
 	read_and_refresh_cache(opts);
 
 	/*
-- 
1.7.7.3
