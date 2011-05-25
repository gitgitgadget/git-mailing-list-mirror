From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 06/10] revert: Separate cmdline parsing from functional code
Date: Wed, 25 May 2011 14:17:01 +0000
Message-ID: <1306333025-29893-7-git-send-email-artagnon@gmail.com>
References: <1306333025-29893-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 25 16:17:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPEts-0003Uq-TQ
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 16:17:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531Ab1EYORU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 10:17:20 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:53758 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932417Ab1EYORS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 10:17:18 -0400
Received: by mail-qw0-f46.google.com with SMTP id 3so3913824qwk.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 07:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=/81fO/DKnl2WzIyCLK1b6BvnVXteEhawiiOBwaEACBs=;
        b=Po8RtHYIexMaqzVho14NOyyBhDQtBuXiq1oPmim/7VNntWeyw+1rvr4DThc+Ld+s6a
         1r+B+kSVO6O0BxEyMjDSyW1cG6g0FFxjBJ7RoLutZaj1yWgBdrj7e+KuT8HVlIs8LJG2
         xaFofnV2YPNnMBgzJwxaxXI8LPylD/STuvCIY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LJTa4DrE4uitmVtT4KfmwmYwIlypCbE+LOiDGoJaLooa2gMX5VtkQ9/L4Sk7MNE8Mj
         cuu25TC/3/2Z+zwOS9cfs+0OS1qXgdGgzhe+JWlw9tHh/5kCePqB0YM6UicYtROLkgIf
         UmGjfDKvfbBfqjbmpH0ZbAEHkSCbUo2TPxqHI=
Received: by 10.224.11.21 with SMTP id r21mr3538379qar.241.1306333038350;
        Wed, 25 May 2011 07:17:18 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id t17sm5285636qcs.35.2011.05.25.07.17.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 May 2011 07:17:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306333025-29893-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174397>

Make cmd_cherry_pick and cmd_revert call parse_args and parse all the
command-line arguments into an opts structure before sending it off to
a simplified pick_commits function.  pick_commits, in turn will set up
the revision walker and call do_pick_commit in a loop- later in the
series, it will serve as the starting point for continuation.

Based-on-patch-by: Christian Couder <chriscool@tuxfamily.org>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 0d6a5a9..9a612c6 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -561,17 +561,12 @@ static void read_and_refresh_cache(const char *me, struct replay_opts *opts)
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
@@ -605,7 +600,10 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 	if (isatty(0))
 		opts.edit = 1;
 	opts.action = REVERT;
-	res = revert_or_cherry_pick(argc, argv, &opts);
+	git_config(git_default_config, NULL);
+	me = "revert";
+	parse_args(argc, argv, &opts);
+	res = pick_commits(&opts);
 	if (res > 0)
 		/* Exit status from conflict */
 		return res;
@@ -622,7 +620,10 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 
 	memset(&opts, 0, sizeof(struct replay_opts));
 	opts.action = CHERRY_PICK;
-	res = revert_or_cherry_pick(argc, argv, &opts);
+	git_config(git_default_config, NULL);
+	me = "cherry-pick";
+	parse_args(argc, argv, &opts);
+	res = pick_commits(&opts);
 	if (res > 0)
 		return res;
 	if (res < 0)
-- 
1.7.5.GIT
