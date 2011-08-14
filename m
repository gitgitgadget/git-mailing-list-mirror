From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 5/7] revert: Make the argument parser responsible for setup_revisions
Date: Sun, 14 Aug 2011 14:03:07 +0530
Message-ID: <1313310789-10216-6-git-send-email-artagnon@gmail.com>
References: <1313310789-10216-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 14 10:36:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsWBi-0000Xd-DQ
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 10:36:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752498Ab1HNIgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Aug 2011 04:36:50 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50515 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752398Ab1HNIgt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2011 04:36:49 -0400
Received: by gya6 with SMTP id 6so2749677gya.19
        for <git@vger.kernel.org>; Sun, 14 Aug 2011 01:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=6nGnWv8ZpphffMzvsPIdoiaZaMJ67NjkBF7WjLJT5Ew=;
        b=VIyDzPfOjPF1hiew+CsE7E9jxsppscRTL8Ga1qToA2mQ744fQGV8xVXQck9NVG5CTh
         P3X1w2fVfTpWnnFlJNeJ5b8Rsu5/qOAcES+FhH87HKU/FoxR47CXS/rT7cRkzw/ux4W5
         4ZSS33Jpp5HMI9YmGy1UPpPgskvG8RTbPc3hY=
Received: by 10.142.193.3 with SMTP id q3mr1161268wff.243.1313311008565;
        Sun, 14 Aug 2011 01:36:48 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id 14sm2642752wfl.5.2011.08.14.01.36.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Aug 2011 01:36:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1313310789-10216-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179309>

Currently, prepare_revs calls setup_revisions with the (argc, argv) in
the opts structure filled in by parse_args.  As a result, prepare_revs
has to take up the responsibility of erroring out and printing usage
information when (argc, argv) is malformed.  Since parse_args is doing
this for other kinds of parse errors anyway, give it the task of
calling setup_revisions as well.

Based-on-patch-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   53 +++++++++++++++++++++++++++++------------------------
 1 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 8faca07..e8bdeea 100644
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
@@ -163,9 +164,9 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
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
@@ -200,9 +201,6 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 				NULL);
 	}
 
-	else if (opts->commit_argc < 2)
-		usage_with_options(usage_str, options);
-
 	if (opts->allow_ff)
 		verify_opt_compatible(me, "--ff",
 				"--signoff", opts->signoff,
@@ -210,7 +208,20 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
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
@@ -612,23 +623,15 @@ static int do_pick_commit(struct commit *commit, enum replay_action action,
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
 
@@ -823,14 +826,13 @@ static void read_populate_opts(struct replay_opts **opts_ptr)
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
 
@@ -954,6 +956,9 @@ static int pick_revisions(struct replay_opts *opts)
 	struct replay_insn_list *todo_list = NULL;
 	unsigned char sha1[20];
 
+	if (opts->subcommand == REPLAY_NONE)
+		assert(opts->revs);
+
 	read_and_refresh_cache(opts);
 
 	/*
-- 
1.7.6.351.gb35ac.dirty
