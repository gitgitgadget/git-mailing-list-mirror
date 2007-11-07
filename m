From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH PARSEOPT 2/4] Use OPT_SET_INT and OPT_BIT in builtin-branch
Date: Wed,  7 Nov 2007 11:20:28 +0100
Message-ID: <1194430832-6224-4-git-send-email-madcoder@debian.org>
References: <1194430832-6224-1-git-send-email-madcoder@debian.org>
 <1194430832-6224-2-git-send-email-madcoder@debian.org>
 <1194430832-6224-3-git-send-email-madcoder@debian.org>
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 07 11:21:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipi1l-00018B-Ml
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 11:20:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755217AbXKGKUi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 05:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754253AbXKGKUh
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 05:20:37 -0500
Received: from pan.madism.org ([88.191.52.104]:35300 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751110AbXKGKUf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 05:20:35 -0500
Received: from madism.org (unknown [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 1A02028E25;
	Wed,  7 Nov 2007 11:20:34 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 1C3231CA9E; Wed,  7 Nov 2007 11:20:33 +0100 (CET)
X-Mailer: git-send-email 1.5.3.5.1598.gdef4e
In-Reply-To: <1194430832-6224-3-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63796>

Also remove a spurious after-check on --abbrev (OPT__ABBREV already takes
care of that)
---
 builtin-branch.c |   44 ++++++++++++++++----------------------------
 1 files changed, 16 insertions(+), 28 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 3bf40f1..2694c9c 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -507,48 +507,36 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
-	int delete = 0, force_delete = 0, force_create = 0;
-	int rename = 0, force_rename = 0;
+	int delete = 0, rename = 0, force_create = 0;
 	int verbose = 0, abbrev = DEFAULT_ABBREV, detached = 0;
 	int reflog = 0, track;
-	int kinds = REF_LOCAL_BRANCH, kind_remote = 0, kind_any = 0;
+	int kinds = REF_LOCAL_BRANCH;
 
 	struct option options[] = {
 		OPT_GROUP("Generic options"),
 		OPT__VERBOSE(&verbose),
 		OPT_BOOLEAN( 0 , "track",  &track, "set up tracking mode (see git-pull(1))"),
 		OPT_BOOLEAN( 0 , "color",  &branch_use_color, "use colored output"),
-		OPT_BOOLEAN('r', NULL,     &kind_remote, "act on remote-tracking branches"),
+		OPT_SET_INT('r', NULL,     &kinds, "act on remote-tracking branches",
+			REF_REMOTE_BRANCH),
 		OPT__ABBREV(&abbrev),
 
 		OPT_GROUP("Specific git-branch actions:"),
-		OPT_BOOLEAN('a', NULL,     &kind_any, "list both remote-tracking and local branches"),
-		OPT_BOOLEAN('d', NULL,     &delete, "delete fully merged branch"),
-		OPT_BOOLEAN('D', NULL,     &force_delete, "delete branch (even if not merged)"),
-		OPT_BOOLEAN('l', NULL,     &reflog, "create the branch's reflog"),
-		OPT_BOOLEAN('f', NULL,     &force_create, "force creation (when already exists)"),
-		OPT_BOOLEAN('m', NULL,     &rename, "move/rename a branch and its reflog"),
-		OPT_BOOLEAN('M', NULL,     &force_rename, "move/rename a branch, even if target exists"),
+		OPT_SET_INT('a', NULL, &kinds, "list both remote-tracking and local branches",
+			REF_REMOTE_BRANCH | REF_LOCAL_BRANCH),
+		OPT_BIT('d', NULL, &delete, "delete fully merged branch", 1),
+		OPT_BIT('D', NULL, &delete, "delete branch (even if not merged)", 2),
+		OPT_BIT('m', NULL, &rename, "move/rename a branch and its reflog", 1),
+		OPT_BIT('M', NULL, &rename, "move/rename a branch, even if target exists", 2),
+		OPT_BOOLEAN('l', NULL, &reflog, "create the branch's reflog"),
+		OPT_BOOLEAN('f', NULL, &force_create, "force creation (when already exists)"),
 		OPT_END(),
 	};
 
 	git_config(git_branch_config);
 	track = branch_track;
 	argc = parse_options(argc, argv, options, builtin_branch_usage, 0);
-
-	delete |= force_delete;
-	rename |= force_rename;
-	if (kind_remote)
-		kinds = REF_REMOTE_BRANCH;
-	if (kind_any)
-		kinds = REF_REMOTE_BRANCH | REF_LOCAL_BRANCH;
-	if (abbrev && abbrev < MINIMUM_ABBREV)
-		abbrev = MINIMUM_ABBREV;
-	else if (abbrev > 40)
-		abbrev = 40;
-
-	if ((delete && rename) || (delete && force_create) ||
-	    (rename && force_create))
+	if (!!delete + !!rename + !!force_create > 1)
 		usage_with_options(builtin_branch_usage, options);
 
 	head = resolve_ref("HEAD", head_sha1, 0, NULL);
@@ -564,13 +552,13 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	}
 
 	if (delete)
-		return delete_branches(argc, argv, force_delete, kinds);
+		return delete_branches(argc, argv, delete > 1, kinds);
 	else if (argc == 0)
 		print_ref_list(kinds, detached, verbose, abbrev);
 	else if (rename && (argc == 1))
-		rename_branch(head, argv[0], force_rename);
+		rename_branch(head, argv[0], rename > 1);
 	else if (rename && (argc == 2))
-		rename_branch(argv[0], argv[1], force_rename);
+		rename_branch(argv[0], argv[1], rename > 1);
 	else if (argc <= 2)
 		create_branch(argv[0], (argc == 2) ? argv[1] : head,
 			      force_create, reflog, track);
-- 
1.5.3.5.1598.gdef4e
