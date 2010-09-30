From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [WIP PATCH] revision-walk: --parent option to find children of a parent
Date: Thu, 30 Sep 2010 12:30:46 +0200
Message-ID: <99aa4cd5a60b2b2d3eae962acb8a49c2a62a8f77.1285842569.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 30 12:30:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1GPW-0004a9-6j
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 12:30:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501Ab0I3Kah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 06:30:37 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:34866 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751165Ab0I3Kag (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Sep 2010 06:30:36 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0FB4BBCF
	for <git@vger.kernel.org>; Thu, 30 Sep 2010 06:30:36 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 30 Sep 2010 06:30:36 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id; s=smtpout; bh=AGYhd1t8MzHCv4HS1i3sJfaNqxk=; b=bms1q5bEZbpTGutHq2YHyzU7R94ntU/cmCSAZO/nLYyVJj+s+F+Mh0WZq23lwcoNKfhzLqfY7BFbCBeooJF1g3j91rjFLZ4L7Ggo5njRukooFgde4eJlP298WPOu6L9k/BmFEycaJBzZBhlJNKUXb8HFC3IXcwdmhqjW90ojk8M=
X-Sasl-enc: +UqPTDTItkeyIFYASBF6gs6tM2kPg6pDLFVrq55DYCFU 1285842635
Received: from localhost (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 810315E6058;
	Thu, 30 Sep 2010 06:30:35 -0400 (EDT)
X-Mailer: git-send-email 1.7.3.98.g5ad7d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157636>

Introduce a new --parent=<commit> option for the revision walker which
limits the commits to those which have <commit> as one of their parents.

This allows to check, e.g., whether <commit> is a fork point.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
This is heavily WIP/RFC for the obvious reasons, but also these:

Currently, multiple --parent options are ORed. I'm still unsure whether that or ANDing
is more useful. ANDing can always be done cheaply by rev-listing with one
--parent and then checking the result commits. ORing, otoh can be achieved only
by doing multiple rev-list runs (unless it is implemented as it is, of course)..

As a consequence (of the decision for ORing), I don't limit automatically by
^<commit>. I should probably do that automatically for the single --parent
option case, it's a huge speed-up.

 revision.c |   18 ++++++++++++++++++
 revision.h |    3 +++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/revision.c b/revision.c
index b1c1890..db56cf6 100644
--- a/revision.c
+++ b/revision.c
@@ -1149,6 +1149,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 {
 	const char *arg = argv[0];
 	const char *optarg;
+	unsigned char sha1[20];
 	int argcount;
 
 	/* pseudo revision arguments */
@@ -1247,6 +1248,15 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--parents")) {
 		revs->rewrite_parents = 1;
 		revs->print_parents = 1;
+	} else if ((argcount = parse_long_opt("parent", argv, &optarg))) {
+		struct commit *a;
+		if (get_sha1(optarg, sha1))
+			return error("Not a valid object name: %s", optarg);
+		a = lookup_commit_reference(sha1);
+		if (!a)
+			return error("Couldn't look up commit object for '%s'", optarg);
+		commit_list_insert(a, &(revs->parent_list));
+		return argcount;
 	} else if (!strcmp(arg, "--dense")) {
 		revs->dense = 1;
 	} else if (!strcmp(arg, "--sparse")) {
@@ -1989,6 +1999,14 @@ enum commit_action get_commit_action(struct rev_info *revs, struct commit *commi
 		return commit_ignore;
 	if (revs->merges_only && !(commit->parents && commit->parents->next))
 		return commit_ignore;
+	if (revs->parent_list) {
+		struct commit_list *a, *b;
+		for (b = revs->parent_list; b; b = b->next)
+			for (a = commit->parents; a; a = a->next)
+				if (!hashcmp(b->item->object.sha1, a->item->object.sha1))
+					return commit_show;
+		return commit_ignore;
+	}
 	if (!commit_match(commit, revs))
 		return commit_ignore;
 	if (revs->prune && revs->dense) {
diff --git a/revision.h b/revision.h
index 05659c6..e424a53 100644
--- a/revision.h
+++ b/revision.h
@@ -111,6 +111,9 @@ struct rev_info {
 	int		no_inline;
 	int		show_log_size;
 
+	/* Filter by parents */
+	struct commit_list *parent_list;
+
 	/* Filter by commit log message */
 	struct grep_opt	grep_filter;
 
-- 
1.7.3.98.g5ad7d
