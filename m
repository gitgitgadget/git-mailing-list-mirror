From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 08/13] revert: Separate cmdline parsing from functional code
Date: Tue, 21 Jun 2011 13:04:44 +0000
Message-ID: <1308661489-20080-9-git-send-email-artagnon@gmail.com>
References: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 21 15:05:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ0eB-00065X-4I
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 15:05:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756688Ab1FUNFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 09:05:24 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:34073 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756519Ab1FUNFH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 09:05:07 -0400
Received: by vws1 with SMTP id 1so1674354vws.19
        for <git@vger.kernel.org>; Tue, 21 Jun 2011 06:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=yNAIjjw/4rwtcrEPDZGTFLzbAWJ9jqMc4hWzPtEB2OE=;
        b=R6B1vtnlb5uIxw9Jkap+5m9tZf4Fgnuz2WtPPOnVEoNH8NNs/OhVmzvrEqUYKYhR6z
         0yXvdpZibrMmMipOnKN97A4QbwziWyPi3enMBjRIr6+KBI5iEB112EWoux4zm3VxRtUQ
         p3IItpZhvN6INv4MttuxKMb3h77Psr+he8XpY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WKGTJdBfHrzZgivSYqj2XRrFOZtCwV0mDdv7yd7M2mMB9srzuHoR+BEYJTtnUyHS9Y
         8PH39yXQFk3ym+CSkKC59ARQnDppjpGeSsmtahG6wCxaPwxxRAqnHTZ+050g2JOS8i/x
         BkYigCIBqVqF5iXXrJJF69GVSqW+oVYm6j+4w=
Received: by 10.52.93.140 with SMTP id cu12mr5616223vdb.230.1308661507330;
        Tue, 21 Jun 2011 06:05:07 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id k9sm1575853vbn.0.2011.06.21.06.05.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 21 Jun 2011 06:05:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176147>

Currently, revert_or_cherry_pick does too many things including
argument parsing and setting up to pick the commits; this doesn't make
a good API.  Simplify and rename the function to pick_commits, so that
it just has the responsibility of setting up the revision walker and
calling do_pick_commit in a loop.  Transfer the remaining work to its
callers cmd_cherry_pick and cmd_revert.  Later in the series,
pick_commits will serve as the starting point for continuation.

Inspired-by: Christian Couder <chriscool@tuxfamily.org>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index e2e290c..93e0531 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -551,17 +551,12 @@ static void read_and_refresh_cache(const char *me, struct replay_opts *opts)
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
@@ -595,7 +590,10 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
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
@@ -612,7 +610,10 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 
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
