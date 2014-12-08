From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 2/2] branch: allow -f with -m and -d
Date: Mon,  8 Dec 2014 17:28:45 +0100
Message-ID: <80b7cc5312666af6136d641a24e42aed78636724.1418055912.git.git@drmicha.warpmail.net>
References: <xmqqbnniq8k8.fsf@gitster.dls.corp.google.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 08 17:28:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy1BC-00056B-Uo
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 17:28:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752477AbaLHQ2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 11:28:53 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:50530 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750908AbaLHQ2u (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Dec 2014 11:28:50 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id A89B6201C5
	for <git@vger.kernel.org>; Mon,  8 Dec 2014 11:28:49 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Mon, 08 Dec 2014 11:28:49 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id:in-reply-to:references:in-reply-to:references; s=
	smtpout; bh=wwJQYtKq10ItDO2rKPEb7MziIno=; b=ZPNojUMGFQi1SyW1v6sg
	w+k0gFyDXlk0A8KBP6cOI8PRS6rqeGynKDSQvC2Fwra+ccBtZLS1RsIe76VXDvGT
	Q7tbnfhbnKgkDyZuTbp5Ut34RfizSiQ4nHX1fXMuMAnHX3BAt/A/nJZ723nnv9Zp
	HzneccIUQ35F3Ts+O4Af06Y=
X-Sasl-enc: YsotgOtHEEQBvI5QNX9svD+48TPnNLDI7VIVzIJiUlRH 1418056129
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 472E26801E0;
	Mon,  8 Dec 2014 11:28:49 -0500 (EST)
X-Mailer: git-send-email 2.2.0.345.g7041aac
In-Reply-To: <xmqqbnniq8k8.fsf@gitster.dls.corp.google.com>
In-Reply-To: <cover.1418055912.git.git@drmicha.warpmail.net>
References: <cover.1418055912.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261075>

-f/--force is the standard way to force an action, and is used by branch
for the recreation of existing branches, but not for deleting unmerged
branches nor for renaming to an existing branch.

Make "-m -f" equivalent to "-M" and "-d -f" equivalent to" -D", i.e.
allow -f/--force to be used with -m/-d also.

For the list modes, "-f" is simply ignored.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/branch.c  | 13 +++++++++----
 t/t3200-branch.sh |  5 +++++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 3b79c50..dc6f0b2 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -800,7 +800,7 @@ static int edit_branch_description(const char *branch_name)
 
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
-	int delete = 0, rename = 0, force_create = 0, list = 0;
+	int delete = 0, rename = 0, force = 0, list = 0;
 	int verbose = 0, abbrev = -1, detached = 0;
 	int reflog = 0, edit_description = 0;
 	int quiet = 0, unset_upstream = 0;
@@ -848,7 +848,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('l', "create-reflog", &reflog, N_("create the branch's reflog")),
 		OPT_BOOL(0, "edit-description", &edit_description,
 			 N_("edit the description for the branch")),
-		OPT__FORCE(&force_create, N_("force creation (when already exists)")),
+		OPT__FORCE(&force, N_("force creation, move/rename, deletion")),
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
 
+	if (force) {
+		delete *= 2;
+		rename *= 2;
+	}
+
 	if (delete) {
 		if (!argc)
 			die(_("branch name required"));
@@ -1020,7 +1025,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 		branch_existed = ref_exists(branch->refname);
 		create_branch(head, argv[0], (argc == 2) ? argv[1] : head,
-			      force_create, reflog, 0, quiet, track);
+			      force, reflog, 0, quiet, track);
 
 		/*
 		 * We only show the instructions if the user gave us
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
2.2.0.345.g7041aac
