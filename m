From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC PATCH] git-describe: introduce --first-parent
Date: Tue, 21 Sep 2010 11:35:28 +0200
Message-ID: <7d63bc1d2c7408090501bade7e7f8a9eb43cffb3.1285061563.git.git@drmicha.warpmail.net>
References: <4C987C2E.3060001@drmicha.warpmail.net>
Cc: Joshua Shrader <jshrader83@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 21 11:35:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxzGD-0007tH-PJ
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 11:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757092Ab0IUJfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 05:35:22 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:47764 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757078Ab0IUJfV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Sep 2010 05:35:21 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 08C7E4FC;
	Tue, 21 Sep 2010 05:35:21 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 21 Sep 2010 05:35:21 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=SQrDWNSdbwVQOlMAHp+UKnM1F08=; b=q5DO4/X1MMTnfTQtqo68GtVxhK588xPnaeZ5LqSY7JL4qaDY/a2XtjTw1Ux9hniBhlLmhvFa++d1f6aPcbQobesieHCKBRLRdqVknzdzdcfHhf0R8dBi38WMwEemHvGliua4zdvCgl/K0Y5gI8Ie0TNOUObVn71edp//TSgZuUc=
X-Sasl-enc: kZoieJgyV6xzlusAr0ozASST0LMzHXDn7sgyTqJw9WSh 1285061720
Received: from localhost (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 946955E46BB;
	Tue, 21 Sep 2010 05:35:20 -0400 (EDT)
X-Mailer: git-send-email 1.7.3.234.g7bba3
In-Reply-To: <4C987C2E.3060001@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156703>

so that git-describe searches first-parent history only when looking for
a named commit. This is useful for describing commits by tags on their
"main" (first-parent) branch.

git describe --contains --first-parent is forbidden because git name-rev
(which is called by that) favors first-parent transversal already,
although not strictly so.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Notes:
    Is this considered useful? RFC because of lack of doc and test.
    I consider it easier than (and different from) --match in some cases.

 builtin/describe.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 43caff2..6b2b599 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -22,6 +22,7 @@ static int tags;	/* Allow lightweight tags */
 static int longformat;
 static int abbrev = DEFAULT_ABBREV;
 static int max_candidates = 10;
+static int first_parent;
 static int found_names;
 static const char *pattern;
 static int always;
@@ -302,7 +303,7 @@ static void describe(const char *arg, int last_one)
 			if (!(p->object.flags & SEEN))
 				insert_by_date(p, &list);
 			p->object.flags |= c->object.flags;
-			parents = parents->next;
+			parents = first_parent ? NULL : parents->next;
 		}
 	}
 
@@ -380,6 +381,8 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			   "only consider tags matching <pattern>"),
 		OPT_BOOLEAN(0, "always",     &always,
 			   "show abbreviated commit object as fallback"),
+		OPT_BOOLEAN(0, "first-parent",     &first_parent,
+			   "follow first parents only"),
 		{OPTION_STRING, 0, "dirty",  &dirty, "mark",
 			   "append <mark> on dirty working tree (default: \"-dirty\")",
 		 PARSE_OPT_OPTARG, NULL, (intptr_t) "-dirty"},
@@ -397,6 +400,9 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 	if (longformat && abbrev == 0)
 		die("--long is incompatible with --abbrev=0");
 
+	if (contains && first-parent)
+		die("--contains is incompatible with --first-parent");
+
 	if (contains) {
 		const char **args = xmalloc((7 + argc) * sizeof(char *));
 		int i = 0;
-- 
1.7.3.234.g7bba3
