From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 04/11] revert: Separate cmdline argument handling from the functional code
Date: Sun, 10 Apr 2011 20:41:50 +0530
Message-ID: <1302448317-32387-5-git-send-email-artagnon@gmail.com>
References: <1302448317-32387-1-git-send-email-artagnon@gmail.com>
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 10 17:13:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8wKQ-0008E4-BR
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 17:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754942Ab1DJPNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2011 11:13:24 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58633 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753691Ab1DJPNX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 11:13:23 -0400
Received: by mail-iw0-f174.google.com with SMTP id 34so4864294iwn.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 08:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=lPOi6bbGAwd2cR0v89rNgPxR3Z3I6ng+0mcdpiIYpHY=;
        b=KwHxfVSCqF+PqOB3wghAWKXoqUakvOEVVw8pHUnpT5L26q+Z8UFkQxqyrtTRQY49P6
         Ti2TuMMYmIkWIZ7+JJhL8bPZpNomVp8vfGDin/7qZB0UHgfUNj+EmybBJip61eUfL5yk
         2H1oN1nuLJHOwyNTaWs3izJKjED4Bg86LARBs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=GAGc3I0l2eUXgr0i6eX5dzG3xGfogtKwUl91T1ysgrnv9kuYYnFINKbvLyUdzhWIH8
         0bkrDyZ8x1U8V7PtilfO6twQqe6Ms3m747YNp9mj3vTiWDY0+4yxPYp1xrDVfxpTFuXI
         SQcKNH9cGPuYxOZH+D10RWJHR8LDemGaTcvFg=
Received: by 10.43.63.212 with SMTP id xf20mr2292886icb.265.1302448403373;
        Sun, 10 Apr 2011 08:13:23 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id f28sm3367928ibh.67.2011.04.10.08.13.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 10 Apr 2011 08:13:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1302448317-32387-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171258>

Based-on-patch-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   23 ++++++++++++++---------
 1 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 2b33220..9381541 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -578,18 +578,12 @@ static int read_and_refresh_cache(void)
 	return 0;
 }
 
-static int revert_or_cherry_pick(int argc, const char **argv)
+static int pick_commits(void)
 {
 	struct rev_info revs;
 	struct commit *commit;
-	const char *me;
 	int res;
 
-	git_config(git_default_config, NULL);
-	me = (cmd_opts.action == REVERT ? "revert" : "cherry-pick");
-	setenv(GIT_REFLOG_ACTION, me, 0);
-	parse_args(argc, argv);
-
 	if (cmd_opts.allow_ff) {
 		if (cmd_opts.signoff)
 			die(_("cherry-pick --ff cannot be used with --signoff"));
@@ -616,12 +610,23 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 {
 	if (isatty(0))
 		cmd_opts.edit = 1;
+
+	git_config(git_default_config, NULL);
+	memset(&cmd_opts, 0, sizeof(cmd_opts));
 	cmd_opts.action = REVERT;
-	return revert_or_cherry_pick(argc, argv);
+	setenv(GIT_REFLOG_ACTION, "revert", 0);
+	parse_args(argc, argv);
+
+	return pick_commits();
 }
 
 int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 {
+	git_config(git_default_config, NULL);
+	memset(&cmd_opts, 0, sizeof(cmd_opts));
 	cmd_opts.action = CHERRY_PICK;
-	return revert_or_cherry_pick(argc, argv);
+	setenv(GIT_REFLOG_ACTION, "cherry-pick", 0);
+	parse_args(argc, argv);
+
+	return pick_commits();
 }
-- 
1.7.4.rc1.7.g2cf08.dirty
