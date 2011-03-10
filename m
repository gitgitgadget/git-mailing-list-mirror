From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 08/10] log --cherry: a synonym
Date: Thu, 10 Mar 2011 15:45:01 +0100
Message-ID: <e5a72f0ddc0ddc9b6087c08143b188043f3bea1f.1299767413.git.git@drmicha.warpmail.net>
References: <4D78AC8B.7010308@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 10 15:49:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxhB8-0007ob-PO
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 15:49:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752827Ab1CJOs4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 09:48:56 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:42888 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752575Ab1CJOsz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Mar 2011 09:48:55 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C0D5C20D31;
	Thu, 10 Mar 2011 09:48:54 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 10 Mar 2011 09:48:54 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=nvwqcoOGisW6BjT5P3ElfwKr4iE=; b=McpTz8SigtNPf53yvWmVjoOlJVS1otgAiidcSM99CeWQ+tfwGYHRRkvP6J5Ytrl5pomzRrrUOEhmNlCMHS5QEaEHSW8gbytIll1n8YvHvRNm6/KC7hPe15QGxM2rTlSK3iSLl563UQMAl6nfJuiN/1rpqCAYwGDaY4t9oAgw7Tw=
X-Sasl-enc: s6zZ/faqgxUV0s+tdi3sdd2EEN+Yrd6imjm8vHx2y5wp 1299768534
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 24C06446B47;
	Thu, 10 Mar 2011 09:48:54 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.317.gf445f
In-Reply-To: <4D78AC8B.7010308@drmicha.warpmail.net>
In-Reply-To: <cover.1299767412.git.git@drmicha.warpmail.net>
References: <cover.1299767412.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168822>

At the Porcelain level, because by definition there are many more contributors
than integrators, it makes sense to give a handy short-hand for --right-only
used with --cherry-mark and --no-merges.  Make it so.

In other words, this provides "git cherry with rev-list interface".

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/rev-list-options.txt |    8 ++++++++
 revision.c                         |   13 +++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

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
index 864bc9b..4881263 100644
--- a/revision.c
+++ b/revision.c
@@ -1288,16 +1288,25 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
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
+		revs->cherry_pick = 1;
+		revs->right_only = 1;
+		revs->no_merges = 1;
+		revs->limited = 1;
 	} else if (!strcmp(arg, "--count")) {
 		revs->count = 1;
 	} else if (!strcmp(arg, "--cherry-mark")) {
-		if (revs->cherry_pick && !revs->cherry-mark)
+		if (revs->cherry_pick && !revs->cherry_mark)
 			die("--cherry-mark is incompatible with --cherry-pick");
 		revs->cherry_mark = 1;
 		revs->cherry_pick = 1;
-- 
1.7.4.1.317.gf445f
