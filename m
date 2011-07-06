From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 08/14] revert: Separate cmdline parsing from functional code
Date: Wed,  6 Jul 2011 07:54:22 +0000
Message-ID: <1309938868-2028-9-git-send-email-artagnon@gmail.com>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 06 09:54:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeMwg-0005vT-5o
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 09:54:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752494Ab1GFHyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 03:54:44 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:48564 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362Ab1GFHyn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 03:54:43 -0400
Received: by mail-qy0-f174.google.com with SMTP id 29so1924487qyk.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 00:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Sp2QNE+gWOJsK+/rNCEKRNJn/NfJnhGwl+8n6MODcZY=;
        b=eUU7sC5L/B2rAXmaPdNF0OmmaKnxlsRJOexnpcNFBhlcNn+5QYPMrXT+E/i+rp+6at
         ZosDq0GB7Efm4x/DG8shkv2J028fLRualAC0vLHqA78KtsEohPiiUbP7Vc/eRUiDlamZ
         dIQaQgEGf51AqlSC0+XFY0hNfR1i3t0gxnMJ4=
Received: by 10.224.71.20 with SMTP id f20mr6449869qaj.247.1309938883165;
        Wed, 06 Jul 2011 00:54:43 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id e18sm6212790qcs.5.2011.07.06.00.54.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jul 2011 00:54:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176653>

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
index f34e51f..e3a7c9e 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -555,17 +555,12 @@ static void read_and_refresh_cache(const char *me, struct replay_opts *opts)
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
@@ -599,7 +594,10 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 	if (isatty(0))
 		opts.edit = 1;
 	opts.action = REVERT;
-	res = revert_or_cherry_pick(argc, argv, &opts);
+	git_config(git_default_config, NULL);
+	me = "revert";
+	parse_args(argc, argv, &opts);
+	res = pick_commits(&opts);
 	if (res < 0)
 		die(_("%s failed"), me);
 	return res;
@@ -612,7 +610,10 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 
 	memset(&opts, 0, sizeof(struct replay_opts));
 	opts.action = CHERRY_PICK;
-	res = revert_or_cherry_pick(argc, argv, &opts);
+	git_config(git_default_config, NULL);
+	me = "cherry-pick";
+	parse_args(argc, argv, &opts);
+	res = pick_commits(&opts);
 	if (res < 0)
 		die(_("%s failed"), me);
 	return res;
-- 
1.7.5.GIT
