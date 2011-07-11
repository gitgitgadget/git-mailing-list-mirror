From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 08/17] revert: Separate cmdline parsing from functional code
Date: Mon, 11 Jul 2011 14:53:59 +0000
Message-ID: <1310396048-24925-9-git-send-email-artagnon@gmail.com>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 11 16:55:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgHtF-0005dD-T6
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 16:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757888Ab1GKOzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 10:55:00 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:60018 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757823Ab1GKOyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 10:54:25 -0400
Received: by mail-vw0-f46.google.com with SMTP id 1so2748281vws.19
        for <git@vger.kernel.org>; Mon, 11 Jul 2011 07:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Y5P9pxiXq8lZ5+GuBMtr4Ev63iVJQZW3JUih1xwh1yA=;
        b=CmXL+jQu8G9dIC4p5jXdVc+CY9M6nR67zbq5yID1iDi0+vE7SL5dufv026lCxj2R5x
         Zl7QkFM7Q47W1vHqjHuFiS18O0ugdY6lihny+eZ9txgHrzW6TaTJBpcP1g+viZNeiuAZ
         YWT37v3yzSHOAsAp2Zb75vnDCsb7ADTIHbPEo=
Received: by 10.52.187.65 with SMTP id fq1mr2275361vdc.454.1310396065305;
        Mon, 11 Jul 2011 07:54:25 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id b9sm4510527vdk.25.2011.07.11.07.54.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Jul 2011 07:54:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176857>

Currently, revert_or_cherry_pick does too many things including
argument parsing and setting up to pick the commits; this doesn't make
a good API.  Simplify and rename the function to pick_commits, so that
it just has the responsibility of setting up the revision walker and
calling do_pick_commit in a loop.  Transfer the remaining work to its
callers cmd_cherry_pick and cmd_revert.  Later in the series,
pick_commits will serve as the starting point for continuing the
cherry-pick or revert.

Inspired-by: Christian Couder <chriscool@tuxfamily.org>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index a95cfbb..da55ba4 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -546,17 +546,12 @@ static void read_and_refresh_cache(const char *me, struct replay_opts *opts)
 	rollback_lock_file(&index_lock);
 }
 
-static int revert_or_cherry_pick(int argc, const char **argv,
-				struct replay_opts *opts)
+static int pick_commits(struct replay_opts *opts)
 {
 	struct rev_info revs;
 	struct commit *commit;
 
-	git_config(git_default_config, NULL);
-	me = opts->action == REVERT ? "revert" : "cherry-pick";
 	setenv(GIT_REFLOG_ACTION, me, 0);
-	parse_args(argc, argv, opts);
-
 	if (opts->allow_ff) {
 		if (opts->signoff)
 			die(_("cherry-pick --ff cannot be used with --signoff"));
@@ -590,7 +585,10 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 	if (isatty(0))
 		opts.edit = 1;
 	opts.action = REVERT;
-	res = revert_or_cherry_pick(argc, argv, &opts);
+	git_config(git_default_config, NULL);
+	me = "revert";
+	parse_args(argc, argv, &opts);
+	res = pick_commits(&opts);
 	if (res < 0)
 		die(_("revert failed"));
 	return res;
@@ -603,7 +601,10 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 
 	memset(&opts, 0, sizeof(struct replay_opts));
 	opts.action = CHERRY_PICK;
-	res = revert_or_cherry_pick(argc, argv, &opts);
+	git_config(git_default_config, NULL);
+	me = "cherry-pick";
+	parse_args(argc, argv, &opts);
+	res = pick_commits(&opts);
 	if (res < 0)
 		die(_("cherry-pick failed"));
 	return res;
-- 
1.7.5.GIT
