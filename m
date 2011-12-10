From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/7] revert: pass around rev-list args in already-parsed form
Date: Sat, 10 Dec 2011 06:58:25 -0600
Message-ID: <20111210125825.GD22035@elie.hsd1.il.comcast.net>
References: <CALkWK0=45OwcBoH2TorsgwTbaXjnffVuh0mGxh2+ShN9cuF-=A@mail.gmail.com>
 <20111120094650.GB2278@elie.hsd1.il.comcast.net>
 <20111122111207.GA7399@elie.hsd1.il.comcast.net>
 <20111122112001.GF7399@elie.hsd1.il.comcast.net>
 <7vr50zd5x0.fsf@alter.siamese.dyndns.org>
 <20111123012721.GA14217@elie.hsd1.il.comcast.net>
 <4ECCB3A2.5030102@viscovery.net>
 <20111123100452.GA30629@elie.hsd1.il.comcast.net>
 <4ECCC935.7010407@viscovery.net>
 <20111210124644.GA22035@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sat Dec 10 13:58:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZMVf-0003so-Dp
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 13:58:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226Ab1LJM6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Dec 2011 07:58:31 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59806 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751186Ab1LJM6a (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 07:58:30 -0500
Received: by iaeh11 with SMTP id h11so198943iae.19
        for <git@vger.kernel.org>; Sat, 10 Dec 2011 04:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=iBxH1JAdndXGFtOosoT2izI6gtXu/fbqfBruKHvvS5U=;
        b=I+ir45Xc5b90GAAF6yBoSDMg/H799+WkQBiJbKcXhkk1ry4sxJYcGfpWak2seAUKRr
         QyxYUt6AxHjRJESNJ8r8JfEUea3zPbiYbmlmu/aJ5PQupyjh3fLsfbUqJXcnVCYV0ru+
         LMHUMcLQxkLZHMvlXg09SrHiUgp38go8voBko=
Received: by 10.50.94.170 with SMTP id dd10mr7413751igb.41.1323521909895;
        Sat, 10 Dec 2011 04:58:29 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id h9sm23194691ibh.11.2011.12.10.04.58.28
        (version=SSLv3 cipher=OTHER);
        Sat, 10 Dec 2011 04:58:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111210124644.GA22035@elie.hsd1.il.comcast.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186772>

Date: Sat, 13 Aug 2011 12:06:23 -0500

Since 7e2bfd3f (revert: allow cherry-picking more than one commit,
2010-07-02), the pick/revert machinery has kept track of the set of
commits to be cherry-picked or reverted using commit_argc and
commit_argv variables, storing the corresponding command-line
parameters.

Future callers as other commands are built in (am, rebase, sequencer)
may find it easier to pass rev-list options to this machinery in
already-parsed form.  Teach cmd_cherry_pick and cmd_revert to parse
the rev-list arguments in advance and pass the commit set to
pick_revisions() as a rev_info structure.

Original patch by Jonathan, tweaks and test from Ram.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Improved-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c                |   53 +++++++++++++++++++++-----------------
 t/t3510-cherry-pick-sequence.sh |    5 +++
 2 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index a43b4d85..71570357 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -60,13 +60,14 @@ struct replay_opts {
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
@@ -169,9 +170,9 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
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
@@ -213,9 +214,6 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 				NULL);
 	}
 
-	else if (opts->commit_argc < 2)
-		usage_with_options(usage_str, options);
-
 	if (opts->allow_ff)
 		verify_opt_compatible(me, "--ff",
 				"--signoff", opts->signoff,
@@ -223,7 +221,20 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 				"-x", opts->record_origin,
 				"--edit", opts->edit,
 				NULL);
-	opts->commit_argv = argv;
+
+	if (opts->subcommand != REPLAY_NONE) {
+		opts->revs = NULL;
+	} else {
+		opts->revs = xmalloc(sizeof(*opts->revs));
+		init_revisions(opts->revs, NULL);
+		opts->revs->no_walk = 1;
+		if (argc < 2)
+			usage_with_options(usage_str, options);
+		argc = setup_revisions(argc, argv, opts->revs, NULL);
+	}
+
+	if (argc > 1)
+		usage_with_options(usage_str, options);
 }
 
 struct commit_message {
@@ -631,23 +642,15 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 	return res;
 }
 
-static void prepare_revs(struct rev_info *revs, struct replay_opts *opts)
+static void prepare_revs(struct replay_opts *opts)
 {
-	int argc;
-
-	init_revisions(revs, NULL);
-	revs->no_walk = 1;
 	if (opts->action != REVERT)
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
 
@@ -844,14 +847,13 @@ static void read_populate_opts(struct replay_opts **opts_ptr)
 static void walk_revs_populate_todo(struct commit_list **todo_list,
 				struct replay_opts *opts)
 {
-	struct rev_info revs;
 	struct commit *commit;
 	struct commit_list **next;
 
-	prepare_revs(&revs, opts);
+	prepare_revs(opts);
 
 	next = todo_list;
-	while ((commit = get_revision(&revs)))
+	while ((commit = get_revision(opts->revs)))
 		next = commit_list_append(commit, next);
 }
 
@@ -1075,6 +1077,9 @@ static int pick_revisions(struct replay_opts *opts)
 	struct commit_list *todo_list = NULL;
 	unsigned char sha1[20];
 
+	if (opts->subcommand == REPLAY_NONE)
+		assert(opts->revs);
+
 	read_and_refresh_cache(opts);
 
 	/*
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 4d1883b7..56c95ec1 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -461,4 +461,9 @@ test_expect_success 'malformed instruction sheet 2' '
 	test_must_fail git cherry-pick --continue
 '
 
+test_expect_success 'empty commit set' '
+	pristine_detach initial &&
+	test_expect_code 128 git cherry-pick base..base
+'
+
 test_done
-- 
1.7.8.rc3
