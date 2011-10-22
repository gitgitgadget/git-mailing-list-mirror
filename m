From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 5/5] revert: simplify communicating command-line arguments
Date: Sun, 23 Oct 2011 00:43:46 +0530
Message-ID: <1319310826-508-6-git-send-email-artagnon@gmail.com>
References: <1319310826-508-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 22 21:17:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHh45-0003ch-KL
	for gcvg-git-2@lo.gmane.org; Sat, 22 Oct 2011 21:17:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752680Ab1JVTRA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Oct 2011 15:17:00 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57530 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319Ab1JVTRA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Oct 2011 15:17:00 -0400
Received: by mail-gy0-f174.google.com with SMTP id 13so4735110gyb.19
        for <git@vger.kernel.org>; Sat, 22 Oct 2011 12:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=2f0CnmYDllf1zg2rpfnuMba1xUIWlQ9pYZ3IpjnxLDw=;
        b=q6MLFXQhIN8FPnFbaT+W/Yij8CM2WSZMAxz2A5UPgENAvFRGAwE9TRje70CeBAIy7F
         TCRS54JrQHL9SEOGBBZwhKzlgmqCKrwLnCcwIt+D81Qcoc9gF9SeRPxKMzRuLeWtree/
         EGXoJVLbE4a/ppV+YuVt+fxDFUs+XUOaoIr1E=
Received: by 10.68.26.193 with SMTP id n1mr30180741pbg.125.1319311019291;
        Sat, 22 Oct 2011 12:16:59 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id e10sm36939881pbq.10.2011.10.22.12.16.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 22 Oct 2011 12:16:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1319310826-508-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184117>

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
index 8c3e4fc..df9459b 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -54,13 +54,14 @@ struct replay_opts {
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
@@ -161,9 +162,9 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
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
@@ -198,9 +199,6 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 				NULL);
 	}
 
-	else if (opts->commit_argc < 2)
-		usage_with_options(usage_str, options);
-
 	if (opts->allow_ff)
 		verify_opt_compatible(me, "--ff",
 				"--signoff", opts->signoff,
@@ -208,7 +206,20 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
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
@@ -614,23 +625,15 @@ static int do_pick_commit(struct commit *commit, enum replay_action action,
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
 
@@ -818,14 +821,13 @@ static void read_populate_opts(struct replay_opts **opts_ptr)
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
 
@@ -949,6 +951,9 @@ static int pick_revisions(struct replay_opts *opts)
 	struct replay_insn_list *todo_list = NULL;
 	unsigned char sha1[20];
 
+	if (opts->subcommand == REPLAY_NONE)
+		assert(opts->revs);
+
 	read_and_refresh_cache(opts);
 
 	/*
-- 
1.7.6.351.gb35ac.dirty
