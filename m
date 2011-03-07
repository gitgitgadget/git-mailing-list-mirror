From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 8/9] log --cherry: a synonym
Date: Mon,  7 Mar 2011 13:31:42 +0100
Message-ID: <83edad511550713d81a7aedec9fb852c117556fc.1299499429.git.git@drmicha.warpmail.net>
References: <cover.1299499429.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 07 13:35:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwZf7-0003Ub-98
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 13:35:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753383Ab1CGMfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2011 07:35:36 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:60286 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752548Ab1CGMf0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Mar 2011 07:35:26 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 8C7E12081A;
	Mon,  7 Mar 2011 07:35:26 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 07 Mar 2011 07:35:26 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=rkk/2y+pTQVePJ/6Bufc4dg5aig=; b=X4xAfDRTQ7KDMRktAcoGfnN47PPzT2e4jxRj2kIq4RM1LVTW9uWn4jimBnliHyaijr58DYB0nwvSi02gEZXgqLNVJ48o1F1C7UAhOHzvJHO/nHFKWMev3ZECbUDrIfAcB2Gf9ayHrY38CKMME3PgKX5nFL6TmwwRolAFJTiCL0I=
X-Sasl-enc: NFZvTGCvMJYodx5KEFtPi5nUzg6KLNeUlQA+ry5FhmE7 1299501326
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0CB43403291;
	Mon,  7 Mar 2011 07:35:25 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.299.g567d7.dirty
In-Reply-To: <cover.1299499429.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168584>

At the porcelain level, because by definition there are many more contributors
than integrators, it makes sense to give a handy short-hand for --right-only
used with --cherry-mark and --no-merges.  Make it so.

In other words, this provides "git cherry with rev-list interface".

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/rev-list-options.txt |    8 ++++++++
 revision.c                         |   10 +++++++++-
 2 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 4755b83..95d209c 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -337,6 +337,14 @@ commits from `B` which are in `A` or are patch-equivalent to a commit in
 More precisely, `--cherry-pick --right-only --no-merges` gives the exact
 list.
 
+--cherry::
+
+	A synonym for `--right-only --cherry-mark --no-merges`; useful to
+	limit the output to the commits on our side and mark those that
+	have been applied to the other side of a forked history with
+	`git log --cherry upstream...mybranch`, similar to
+	`git cherry upstream mybranch`.
+
 -g::
 --walk-reflogs::
 
diff --git a/revision.c b/revision.c
index 3da403e..61f571e 100644
--- a/revision.c
+++ b/revision.c
@@ -1289,12 +1289,20 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->left_right = 1;
 	} else if (!strcmp(arg, "--left-only")) {
 		if (revs->right_only)
-			die("--left-only is incompatible with --right-only");
+			die("--left-only is incompatible with --right-only"
+			    " or --cherry");
 		revs->left_only = 1;
 	} else if (!strcmp(arg, "--right-only")) {
 		if (revs->left_only)
 			die("--right-only is incompatible with --left-only");
 		revs->right_only = 1;
+	} else if (!strcmp(arg, "--cherry")) {
+		if (revs->left_only)
+			die("--cherry is incompatible with --left-only");
+		revs->cherry_mark = 1;
+		revs->right_only = 1;
+		revs->no_merges = 1;
+		revs->limited = 1;
 	} else if (!strcmp(arg, "--count")) {
 		revs->count = 1;
 	} else if (!strcmp(arg, "--cherry-mark")) {
-- 
1.7.4.1.299.g567d7.dirty
