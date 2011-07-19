From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 09/18] revert: Separate cmdline parsing from functional code
Date: Tue, 19 Jul 2011 22:47:47 +0530
Message-ID: <1311095876-3098-10-git-send-email-artagnon@gmail.com>
References: <1311095876-3098-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 19 19:19:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjDxL-0003Eb-1K
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 19:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603Ab1GSRTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 13:19:25 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:48493 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073Ab1GSRTY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 13:19:24 -0400
Received: by mail-pz0-f46.google.com with SMTP id 3so5220029pzk.5
        for <git@vger.kernel.org>; Tue, 19 Jul 2011 10:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=/dRfI07eLWufcesam4DarLiYeeP9PlVTHW9JwOEonUs=;
        b=I1iT4T9200eOk4yrfN6zCSmET5FKaYlAF3YDwTfSW/O7Ou2Ai3RsKS1T4rI/WLWACb
         CVmtEwtM5Pt1098MJfmg6vLcRoU4EywVDg9yWHoWZJK7TSS2QO2tXZol2Z9+yq6AXIWi
         TvNveVjZutyFBWVMAsFs4f1/CrwbDnarvileo=
Received: by 10.142.157.12 with SMTP id f12mr3561642wfe.6.1311095964741;
        Tue, 19 Jul 2011 10:19:24 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id r12sm4276415wfe.1.2011.07.19.10.19.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Jul 2011 10:19:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1311095876-3098-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177475>

Currently, revert_or_cherry_pick sets up a default git config, parses
command-line arguments, before preparing to pick commits.  This makes
for a bad API as the central worry of callers is to assert whether or
not a conflict occured while cherry picking.  The current API is like:

if (revert_or_cherry_pick(argc, argv, opts) < 0)
   print "Something failed, we're not sure what"

Simplify and rename revert_or_cherry_pick to pick_commits so that it
only has the responsibility of setting up the revision walker and
picking commits in a loop.  Transfer the remaining work to its
callers.  Now, the API is simplified as:

if (parse_args(argc, argv, opts) < 0)
   print "Can't parse arguments"
if (pick_commits(opts) < 0)
   print "Error encountered in picking machinery"

Later in the series, pick_commits will also serve as the starting
point for continuing a cherry-pick or revert.

Inspired-by: Christian Couder <chriscool@tuxfamily.org>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index c118fd3..047b0aa 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -558,16 +558,12 @@ static void read_and_refresh_cache(struct replay_opts *opts)
 	rollback_lock_file(&index_lock);
 }
 
-static int revert_or_cherry_pick(int argc, const char **argv,
-				struct replay_opts *opts)
+static int pick_commits(struct replay_opts *opts)
 {
 	struct rev_info revs;
 	struct commit *commit;
 
-	git_config(git_default_config, NULL);
 	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
-	parse_args(argc, argv, opts);
-
 	if (opts->allow_ff) {
 		if (opts->signoff)
 			die(_("cherry-pick --ff cannot be used with --signoff"));
@@ -601,7 +597,9 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 	if (isatty(0))
 		opts.edit = 1;
 	opts.action = REVERT;
-	res = revert_or_cherry_pick(argc, argv, &opts);
+	git_config(git_default_config, NULL);
+	parse_args(argc, argv, &opts);
+	res = pick_commits(&opts);
 	if (res < 0)
 		die(_("revert failed"));
 	return res;
@@ -614,7 +612,9 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 
 	memset(&opts, 0, sizeof(struct replay_opts));
 	opts.action = CHERRY_PICK;
-	res = revert_or_cherry_pick(argc, argv, &opts);
+	git_config(git_default_config, NULL);
+	parse_args(argc, argv, &opts);
+	res = pick_commits(&opts);
 	if (res < 0)
 		die(_("cherry-pick failed"));
 	return res;
-- 
1.7.4.rc1.7.g2cf08.dirty
