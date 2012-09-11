From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/2] git-describe: introduce --first-parent
Date: Tue, 11 Sep 2012 15:51:51 +0200
Message-ID: <b5a771de4f84b6f6ae82b736c834d105aa98f87f.1347370970.git.git@drmicha.warpmail.net>
References: <cover.1347370970.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 11 15:52:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBQso-0001KM-0K
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 15:52:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757723Ab2IKNv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 09:51:57 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39909 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757566Ab2IKNv4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Sep 2012 09:51:56 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id D9C2721790
	for <git@vger.kernel.org>; Tue, 11 Sep 2012 09:51:55 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 11 Sep 2012 09:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=XQ2uzusEOIf8dznHGnA4TiDDh
	bQ=; b=VaXcxe9VwZHEsWK6j25K0AVpHTF+Bvr1z2FF+jBmpQ1tM1P+2bBzpwTBc
	7TJQG6Zw9EMrvlx0bstP9rNTW7w08PGTi05c6TzdujI8zSYDZXx/ootk2Le87jWi
	lyNUQ1idpnuNeZRGO18s0nNx17t37KDk6rzc4Id50us8kJFTgQ=
X-Sasl-enc: sZOtfeoIMC7Q1y/9CLHXOlbNV2W6rblySYc5RQ8u97CC 1347371515
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 72EB28E03CD;
	Tue, 11 Sep 2012 09:51:55 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.463.gbd9d638
In-Reply-To: <cover.1347370970.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205228>

so that git-describe searches first-parent history only when looking for
a named commit. This is useful for describing commits by tags on their
"main" (first-parent) branch; for example, on git.git:

git describe 22ffc39
v1.7.2.3-223-g22ffc39

git describe --first-parent 22ffc39
v1.7.2-104-g22ffc39

git describe --contains --first-parent is forbidden because git name-rev
(which is called by that) favors first-parent transversal already,
although not strictly so.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/describe.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 9fe11ed..aa60f5c 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -25,6 +25,7 @@ static int abbrev = -1; /* unspecified */
 static int max_candidates = 10;
 static struct hash_table names;
 static int have_util;
+static int first_parent;
 static const char *pattern;
 static int always;
 static const char *dirty;
@@ -336,7 +337,7 @@ static void describe(const char *arg, int last_one)
 			if (!(p->object.flags & SEEN))
 				commit_list_insert_by_date(p, &list);
 			p->object.flags |= c->object.flags;
-			parents = parents->next;
+			parents = first_parent ? NULL : parents->next;
 		}
 	}
 
@@ -414,6 +415,8 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			   N_("only consider tags matching <pattern>")),
 		OPT_BOOLEAN(0, "always",     &always,
 			   N_("show abbreviated commit object as fallback")),
+		OPT_BOOLEAN(0, "first-parent",     &first_parent,
+			   "follow first parents only"),
 		{OPTION_STRING, 0, "dirty",  &dirty, N_("mark"),
 			   N_("append <mark> on dirty working tree (default: \"-dirty\")"),
 		 PARSE_OPT_OPTARG, NULL, (intptr_t) "-dirty"},
@@ -435,6 +438,9 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 	if (longformat && abbrev == 0)
 		die(_("--long is incompatible with --abbrev=0"));
 
+	if (contains && first_parent)
+		die(_("--contains is incompatible with --first-parent"));
+
 	if (contains) {
 		const char **args = xmalloc((7 + argc) * sizeof(char *));
 		int i = 0;
-- 
1.7.12.463.gbd9d638
