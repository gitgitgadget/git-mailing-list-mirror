From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/PATCH 2/2] branch: introduce --list argument
Date: Wed, 27 Apr 2011 14:15:19 +0200
Message-ID: <90570cc5b04bf1f73833f365dc58a3d5ae200a21.1303906496.git.git@drmicha.warpmail.net>
References: <cover.1303906496.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 14:15:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF3eV-0000XD-4A
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 14:15:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140Ab1D0MP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 08:15:26 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:43870 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932071Ab1D0MPZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2011 08:15:25 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0E11620D25
	for <git@vger.kernel.org>; Wed, 27 Apr 2011 08:15:25 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Wed, 27 Apr 2011 08:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id:in-reply-to:references; s=smtpout; bh=Dwo03YYqleLYSUqob575FkfDy34=; b=NVISDur+GcfuxsH54ngkuDKpcQj8DH9mG6+Zp1zoU021CmG1QVXZr1m1K4EnBy4GWXR8CmLIo7wqIM3uznLjphWHQw9rw4y3o3Jq54SYd2r+TWeh+enR0Ow7B2cqhDoaQC5/Hg4gmEHYfV5YFGB5Gp73842mI7lDCHvXSJdHpeM=
X-Sasl-enc: 9IFeUQNcndoumb899h8qOcWLWL9Ht9J997wBU/44sTZ5 1303906524
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 82166448947;
	Wed, 27 Apr 2011 08:15:24 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.270.gafca7
In-Reply-To: <cover.1303906496.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172227>

Currently, there is no way to invoke the list mode with a pattern
because this is interpreted as branch creation.

Introduce a --list argument which invokes the list mode.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/branch.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 10292ab..4ccd89c 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -619,7 +619,7 @@ static int opt_parse_merge_filter(const struct option *opt, const char *arg, int
 
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
-	int delete = 0, rename = 0, force_create = 0;
+	int delete = 0, rename = 0, force_create = 0, list = 0;
 	int verbose = 0, abbrev = DEFAULT_ABBREV, detached = 0;
 	int reflog = 0;
 	enum branch_track track;
@@ -658,6 +658,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_BIT('D', NULL, &delete, "delete branch (even if not merged)", 2),
 		OPT_BIT('m', NULL, &rename, "move/rename a branch and its reflog", 1),
 		OPT_BIT('M', NULL, &rename, "move/rename a branch, even if target exists", 2),
+		OPT_BOOLEAN(0, "list", &list, "list branch names"),
 		OPT_BOOLEAN('l', NULL, &reflog, "create the branch's reflog"),
 		OPT__FORCE(&force_create, "force creation (when already exists)"),
 		{
@@ -700,12 +701,15 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options, builtin_branch_usage,
 			     0);
-	if (!!delete + !!rename + !!force_create > 1)
+	if (!!delete + !!rename + !!force_create + !!list > 1)
 		usage_with_options(builtin_branch_usage, options);
 
+	if (argc == 0 || (verbose && argc == 1))
+		list = 1;
+
 	if (delete)
 		return delete_branches(argc, argv, delete > 1, kinds);
-	else if (argc == 0 || (verbose && argc == 1))
+	else if (list)
 		return print_ref_list(kinds, detached, verbose, abbrev, with_commit, argc ? argv[0] : NULL);
 	else if (rename && (argc == 1))
 		rename_branch(head, argv[0], rename > 1);
-- 
1.7.5.270.gafca7
