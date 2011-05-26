From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 06/10] revert: Separate cmdline parsing from functional code
Date: Thu, 26 May 2011 15:53:49 +0000
Message-ID: <1306425233-504-7-git-send-email-artagnon@gmail.com>
References: <1306333025-29893-1-git-send-email-artagnon@gmail.com>
 <1306425233-504-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 17:54:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPct9-0001N6-Ep
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 17:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757889Ab1EZPyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 11:54:09 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:62865 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757266Ab1EZPyH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 11:54:07 -0400
Received: by mail-qw0-f46.google.com with SMTP id 3so441172qwk.19
        for <git@vger.kernel.org>; Thu, 26 May 2011 08:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=swm03JcpoaxtR22nzqO2wDb8fbSn9jjVI07vK87ACRk=;
        b=ARbZ0MOIRgtIKJrTsTt2TAGEFAbAZ+jt0IazBuK+fTZPmlssCWvwL2XN4zfGOFsXS2
         LN6v/xLPQXYba4GforEVUGGrU/qUvrL6JOjNAIFJFu3hPSwWWOFACewt8uyJuJdya2S0
         kK1ytU0/U2iuAzQwT1fidzSHQkHjjdsD9YZXU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=GAgw+MCmLGj6VEb+yEh0Q/Mcl4tgG8YfPTwEETwm3RgKME+poS1LJwEJ1ChrveMk4P
         6g9/qOQTFIeXFmJAmieg9Ni8/wCa+9OObed7XxfTOlO+RGZ5W/IZHbCJfuwpnzJcIS+s
         Ln6TiQgjVQ7aqH8P6wz5VNCJWyCJIgmz5M0FE=
Received: by 10.224.172.142 with SMTP id l14mr702764qaz.165.1306425247277;
        Thu, 26 May 2011 08:54:07 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id j18sm513435qck.27.2011.05.26.08.54.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 26 May 2011 08:54:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306425233-504-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174528>

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
index cc2fa73..2e5f260 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -550,17 +550,12 @@ static void read_and_refresh_cache(const char *me, struct replay_opts *opts)
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
@@ -594,7 +589,10 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
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
@@ -611,7 +609,10 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 
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
