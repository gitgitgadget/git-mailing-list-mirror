From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 08/18] revert: Separate cmdline parsing from functional code
Date: Thu, 28 Jul 2011 22:22:21 +0530
Message-ID: <1311871951-3497-9-git-send-email-artagnon@gmail.com>
References: <1311871951-3497-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 18:56:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmTsf-0003lZ-GM
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 18:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755829Ab1G1Q4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 12:56:13 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:64989 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755734Ab1G1Q4M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 12:56:12 -0400
Received: by yia27 with SMTP id 27so1952729yia.19
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 09:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=SxiwAHgHfzF7vmuz76t1qw3DL2i4GFlhPQmHU59VZaU=;
        b=PT54gQDOqRP9Ps1+wgsyRPGLqnqe+soQuZwGbfgpSAcnSuS0bX2W+lhZG9gXmTWV3i
         OlfFQLhPVN8syk+MhO3DFQIGZvbbAw3uCP0iZISnb2Cpu+ib07CCCvz2qwiSkuyKYqyV
         RttDQR5jEv2IeIMtpFRqQM1blsVy47PXFObRc=
Received: by 10.42.125.145 with SMTP id a17mr138015ics.359.1311872171433;
        Thu, 28 Jul 2011 09:56:11 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id ue1sm1497759icb.8.2011.07.28.09.56.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 28 Jul 2011 09:56:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1311871951-3497-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178087>

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
1.7.4.rc1.7.g2cf08.dirty
