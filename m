From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 08/18] revert: Separate cmdline parsing from functional code
Date: Thu,  4 Aug 2011 16:09:06 +0530
Message-ID: <1312454356-3070-9-git-send-email-artagnon@gmail.com>
References: <1312454356-3070-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 04 12:43:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QovOT-0007A1-Ne
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 12:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753904Ab1HDKnD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 06:43:03 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:62187 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753480Ab1HDKnA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 06:43:00 -0400
Received: by mail-yi0-f46.google.com with SMTP id 27so962642yia.19
        for <git@vger.kernel.org>; Thu, 04 Aug 2011 03:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=kDyJbOUdaQmxDYQLEIFYXiC9eiCBLOaAUcdChW14DZs=;
        b=PON5o6iNNQWfMDt4bmE1XlBbDUc8KiKeAALcdSA3wb70GK8bEWFhtXbVsj37KsGiy5
         J8xTH8wIhUxAOnNMFWsOsUWTtX7ieW1FYbRn4iq5uR5VaqiFDW89ph4dTX2/7uDBry8D
         4UAPvNqx3S5jjs9osj2RBdPBUZk7Gmh0i70eY=
Received: by 10.142.61.7 with SMTP id j7mr684541wfa.266.1312454580024;
        Thu, 04 Aug 2011 03:43:00 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id m7sm2090440pbk.6.2011.08.04.03.42.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Aug 2011 03:42:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1312454356-3070-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178724>

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
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/revert.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 50f72de..90fe2ef 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -563,16 +563,12 @@ static void read_and_refresh_cache(struct replay_opts *opts)
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
@@ -605,7 +601,9 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 	if (isatty(0))
 		opts.edit = 1;
 	opts.action = REVERT;
-	return revert_or_cherry_pick(argc, argv, &opts);
+	git_config(git_default_config, NULL);
+	parse_args(argc, argv, &opts);
+	return pick_commits(&opts);
 }
 
 int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
@@ -614,5 +612,7 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 
 	memset(&opts, 0, sizeof(opts));
 	opts.action = CHERRY_PICK;
-	return revert_or_cherry_pick(argc, argv, &opts);
+	git_config(git_default_config, NULL);
+	parse_args(argc, argv, &opts);
+	return pick_commits(&opts);
 }
-- 
1.7.6.351.gb35ac.dirty
