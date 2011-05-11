From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/8] revert: Separate cmdline argument handling from the functional code
Date: Wed, 11 May 2011 13:30:18 +0530
Message-ID: <1305100822-20470-5-git-send-email-artagnon@gmail.com>
References: <1305100822-20470-1-git-send-email-artagnon@gmail.com>
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 11 18:28:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKCH4-00007y-0Y
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 18:28:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757579Ab1EKQ1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2011 12:27:23 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:36090 "EHLO
	smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757392Ab1EKQ1V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2011 12:27:21 -0400
X-IronPort-AV: E=Sophos;i="4.64,351,1301875200"; 
   d="scan'208";a="697931719"
Received: from smtp-in-5102.iad5.amazon.com ([10.218.9.29])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 May 2011 08:02:00 +0000
Received: from ramkum.desktop.amazon.com (ramkum.desktop.amazon.com [172.25.205.64])
	by smtp-in-5102.iad5.amazon.com (8.13.8/8.13.8) with ESMTP id p4B81u6T024405;
	Wed, 11 May 2011 08:01:58 GMT
Received: by ramkum.desktop.amazon.com (Postfix, from userid 272482)
	id 98987754831; Wed, 11 May 2011 13:30:22 +0530 (IST)
X-Mailer: git-send-email 1.7.5.GIT
In-Reply-To: <1305100822-20470-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173406>

Reading the Git configuration, setting environment variables, parsing
command-line arguments, and populating the options structure should be
done in cmd_cherry_pick/ cmd_revert.  The job pick_commits of
simplified into setting up the revision walker and calling
do_pick_commit in a loop- later in the series, it will handle
failures, and serve as the starting point for continuation.

Based-on-patch-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 This patch is fairly straightforward.

 builtin/revert.c |   22 ++++++++++++----------
 1 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 8550927..288c898 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -603,19 +603,12 @@ static int read_and_refresh_cache(struct replay_opts *opts)
 	return 0;
 }
 
-static int revert_or_cherry_pick(int argc, const char **argv,
-				struct replay_opts *opts)
+static int pick_commits(struct replay_opts *opts)
 {
 	struct rev_info revs;
 	struct commit *commit;
-	const char *me;
 	int res;
 
-	git_config(git_default_config, NULL);
-	me = (opts->action == REVERT ? "revert" : "cherry-pick");
-	setenv(GIT_REFLOG_ACTION, me, 0);
-	parse_args(argc, argv, opts);
-
 	if (opts->allow_ff) {
 		if (opts->signoff)
 			die(_("cherry-pick --ff cannot be used with --signoff"));
@@ -642,18 +635,27 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 {
 	struct replay_opts opts;
 
+	git_config(git_default_config, NULL);
 	memset(&opts, 0, sizeof(struct replay_opts));
 	if (isatty(0))
 		opts.edit = 1;
+
 	opts.action = REVERT;
-	return revert_or_cherry_pick(argc, argv, &opts);
+	setenv(GIT_REFLOG_ACTION, "revert", 0);
+	parse_args(argc, argv, &opts);
+
+	return pick_commits(&opts);
 }
 
 int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 {
 	struct replay_opts opts;
 
+	git_config(git_default_config, NULL);
 	memset(&opts, 0, sizeof(struct replay_opts));
 	opts.action = CHERRY_PICK;
-	return revert_or_cherry_pick(argc, argv, &opts);
+	setenv(GIT_REFLOG_ACTION, "cherry-pick", 0);
+	parse_args(argc, argv, &opts);
+
+	return pick_commits(&opts);
 }
-- 
1.7.5.GIT
