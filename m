From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH/RFD 2/2] revision.c: introduce --merges to undo --no-merges
Date: Thu, 17 Mar 2011 12:33:58 +0100
Message-ID: <4033daed8fe7990d7ff5334fcbb5235d86e39b3b.1300359256.git.git@drmicha.warpmail.net>
References: <cover.1300359256.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 17 12:37:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0BWU-0007am-0C
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 12:37:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006Ab1CQLhf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 07:37:35 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:51890 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753992Ab1CQLhc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Mar 2011 07:37:32 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 9226620ABD
	for <git@vger.kernel.org>; Thu, 17 Mar 2011 07:37:32 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 17 Mar 2011 07:37:32 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id:in-reply-to:references; s=smtpout; bh=B82EEToJSax2OE9P7W1xmxBrZWY=; b=JEtu8q3gf0agVC08MU9TMCJ3saWSzrqSZ65MaE0mzVEnBrMRWq9USd30J9/4VqhcPdTGfRuQtNg8BopLT7lYpWatlao0OLO0xwNcfKYxtFLmZq6niOsq7svf1bDhyUGsxGJsIIOufQBaFSjTLZYg+ACu96+JaFxkpospQ9uVcs4=
X-Sasl-enc: 84LN1XtKja1tNf7vr0F/GmgpKY/zQ0LSh7xWZo6wOwjt 1300361851
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id EB62844512A;
	Thu, 17 Mar 2011 07:37:31 -0400 (EDT)
X-Mailer: git-send-email 1.7.4.1.464.gf81ff
In-Reply-To: <cover.1300359256.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169239>

Introduce "--merges" as an option to undo "--no-merges". This is useful
whenever you want to override a default such as those from
"format-patch", "--cherry" or aliases which may use "--no-merges".

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-rev-list.txt         |    1 +
 Documentation/rev-list-options.txt     |    4 +++-
 contrib/completion/git-completion.bash |    2 +-
 revision.c                             |    2 ++
 4 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 020e585..6379f21 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -15,6 +15,7 @@ SYNOPSIS
 	     [ \--min-age=<timestamp> ]
 	     [ \--sparse ]
 	     [ \--merges-only ]
+	     [ \--merges ]
 	     [ \--no-merges ]
 	     [ \--first-parent ]
 	     [ \--remove-empty ]
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 78ea305..e11145b 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -74,9 +74,11 @@ endif::git-rev-list[]
 
 	Print only merge commits.
 
+--merges::
 --no-merges::
 
-	Do not print commits with more than one parent.
+	Do resp. do not print commits with more than one parent.
+	For most commands, `--merges` is the default.
 
 --first-parent::
 	Follow only the first parent commit upon seeing a merge
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 298dddc..db56153 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1570,7 +1570,7 @@ _git_ls_tree ()
 __git_log_common_options="
 	--not --all
 	--branches --tags --remotes
-	--first-parent --merges-only --no-merges
+	--first-parent --merges-only --merges --no-merges
 	--max-count=
 	--max-age= --since= --after=
 	--min-age= --until= --before=
diff --git a/revision.c b/revision.c
index bd2fedd..a9ec574 100644
--- a/revision.c
+++ b/revision.c
@@ -1278,6 +1278,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->remove_empty_trees = 1;
 	} else if (!strcmp(arg, "--merges-only")) {
 		revs->merges_only = 1;
+	} else if (!strcmp(arg, "--merges")) {
+		revs->no_merges = 0;
 	} else if (!strcmp(arg, "--no-merges")) {
 		revs->no_merges = 1;
 	} else if (!strcmp(arg, "--boundary")) {
-- 
1.7.4.1.464.gf81ff
