From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/PATCH 2/2] branch: allow -f with -m and -d
Date: Thu,  4 Dec 2014 14:26:45 +0100
Message-ID: <7b1ae15228841d3eaed739e89295ec10a2be45fa.1417699299.git.git@drmicha.warpmail.net>
References: <cover.1417699299.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 04 14:27:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwWQu-0005nv-NI
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 14:27:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbaLDN0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 08:26:52 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:42653 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754013AbaLDN0v (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Dec 2014 08:26:51 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 849A320ABA
	for <git@vger.kernel.org>; Thu,  4 Dec 2014 08:26:50 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Thu, 04 Dec 2014 08:26:50 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:subject:date
	:message-id:in-reply-to:references; s=smtpout; bh=rUDIDk57AItsrm
	22jSL0A1crD9A=; b=OGSvXRtmW4gUcYmNzDjINQEOoILBdPcGCvdC4wWMe2djrL
	7t8WsQ+mkzLza25QB1Faga8HFEEOVtSob+95NeA7/ZbriNuXx9AuV+NwrPLbw2fS
	92Gw0RStREBed1yJJw0/pf6cg2i5yM0yYvrdP7Z1OUvttgrV5HYvLLfQbBSew=
X-Sasl-enc: YcSh6AqbSKOytcC8/WZIBc2BoWUj3/LGNJIcC+XXG7Xe 1417699610
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 216736801AA;
	Thu,  4 Dec 2014 08:26:50 -0500 (EST)
X-Mailer: git-send-email 2.2.0.rc3.286.g888a711
In-Reply-To: <cover.1417699299.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260757>

-f/--force is the standard way to force an action, and is used by branch
for the recreation of existing branches, but not for deleting unmerged
branches nor for renaming to an existing branch.

Make "-m -f" equivalent to "-M" and "-d -f" equivalent to" -D", i.e.
allow -f/--force to be used with -m/-d also.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/branch.c  | 9 +++++++--
 t/t3200-branch.sh | 5 +++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 3b79c50..8ea04d7 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -848,7 +848,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('l', "create-reflog", &reflog, N_("create the branch's reflog")),
 		OPT_BOOL(0, "edit-description", &edit_description,
 			 N_("edit the description for the branch")),
-		OPT__FORCE(&force_create, N_("force creation (when already exists)")),
+		OPT__FORCE(&force_create, N_("force creation, move/rename, deletion")),
 		{
 			OPTION_CALLBACK, 0, "no-merged", &merge_filter_ref,
 			N_("commit"), N_("print only not merged branches"),
@@ -891,7 +891,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (with_commit || merge_filter != NO_FILTER)
 		list = 1;
 
-	if (!!delete + !!rename + !!force_create + !!new_upstream +
+	if (!!delete + !!rename + !!new_upstream +
 	    list + unset_upstream > 1)
 		usage_with_options(builtin_branch_usage, options);
 
@@ -904,6 +904,11 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		colopts = 0;
 	}
 
+	if (force_create) {
+		delete *= 2;
+		rename *= 2;
+	}
+
 	if (delete) {
 		if (!argc)
 			die(_("branch name required"));
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 0b3b8f5..ddea498 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -106,6 +106,11 @@ test_expect_success 'git branch -M o/q o/p should work when o/p exists' '
 	git branch -M o/q o/p
 '
 
+test_expect_success 'git branch -m -f o/q o/p should work when o/p exists' '
+	git branch o/q &&
+	git branch -m -f o/q o/p
+'
+
 test_expect_success 'git branch -m q r/q should fail when r exists' '
 	git branch q &&
 	git branch r &&
-- 
2.2.0.rc3.286.g888a711
