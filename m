From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/PATCH 1/2] branch: allow pattern arguments
Date: Wed, 27 Apr 2011 14:15:18 +0200
Message-ID: <2d9a4893bd2ac8a402526c9876fa1a15f7cd8191.1303906496.git.git@drmicha.warpmail.net>
References: <cover.1303906496.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 14:15:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF3eU-0000XD-JB
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 14:15:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758928Ab1D0MPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 08:15:25 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:50649 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758821Ab1D0MPX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2011 08:15:23 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3A0C620D31
	for <git@vger.kernel.org>; Wed, 27 Apr 2011 08:15:23 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute6.internal (MEProxy); Wed, 27 Apr 2011 08:15:23 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id:in-reply-to:references; s=smtpout; bh=bzqwbynhEA5tBK3viKyZKFwovMI=; b=bUXtEKZgCJBlhJGG+ug2DDH40FCWEc0BrBbOSHj6zudaAUtsETNqsvkssWMrHw3gOduZlH5MAtqOVfalkA9NnOHXsR0JhSQt9eXPLfLbhotpEpdvQxPLbxIUmB49aOPP3cU2VMVapWRNj6rCRBwOUjyqpgCyFacTc6dRep85rl4=
X-Sasl-enc: wokGBdvvwIJxy50wMvvjmfdLgsIwZ3Y7BhsWgWwTfFlZ 1303906522
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 90B46400F0D;
	Wed, 27 Apr 2011 08:15:22 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.270.gafca7
In-Reply-To: <cover.1303906496.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172228>

Allow pattern arguments for the list mode just like for git tag -l.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/branch.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 9cca1b9..10292ab 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -260,6 +260,7 @@ static char *resolve_symref(const char *src, const char *prefix)
 
 struct append_ref_cb {
 	struct ref_list *ref_list;
+	const char *pattern;
 	int ret;
 };
 
@@ -297,6 +298,9 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 	if ((kind & ref_list->kinds) == 0)
 		return 0;
 
+	if (cb->pattern && fnmatch(cb->pattern, refname, 0))
+		return 0;
+
 	commit = NULL;
 	if (ref_list->verbose || ref_list->with_commit || merge_filter != NO_FILTER) {
 		commit = lookup_commit_reference_gently(sha1, 1);
@@ -494,7 +498,7 @@ static void show_detached(struct ref_list *ref_list)
 	}
 }
 
-static int print_ref_list(int kinds, int detached, int verbose, int abbrev, struct commit_list *with_commit)
+static int print_ref_list(int kinds, int detached, int verbose, int abbrev, struct commit_list *with_commit, const char *pattern)
 {
 	int i;
 	struct append_ref_cb cb;
@@ -508,6 +512,7 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 	if (merge_filter != NO_FILTER)
 		init_revisions(&ref_list.revs, NULL);
 	cb.ref_list = &ref_list;
+	cb.pattern = pattern;
 	cb.ret = 0;
 	for_each_rawref(append_ref, &cb);
 	if (merge_filter != NO_FILTER) {
@@ -525,7 +530,7 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 	qsort(ref_list.list, ref_list.index, sizeof(struct ref_item), ref_cmp);
 
 	detached = (detached && (kinds & REF_LOCAL_BRANCH));
-	if (detached)
+	if (detached && (!pattern || !fnmatch(pattern, "HEAD", 0)))
 		show_detached(&ref_list);
 
 	for (i = 0; i < ref_list.index; i++) {
@@ -700,8 +705,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 	if (delete)
 		return delete_branches(argc, argv, delete > 1, kinds);
-	else if (argc == 0)
-		return print_ref_list(kinds, detached, verbose, abbrev, with_commit);
+	else if (argc == 0 || (verbose && argc == 1))
+		return print_ref_list(kinds, detached, verbose, abbrev, with_commit, argc ? argv[0] : NULL);
 	else if (rename && (argc == 1))
 		rename_branch(head, argv[0], rename > 1);
 	else if (rename && (argc == 2))
-- 
1.7.5.270.gafca7
