From: Linus Torvalds <torvalds@osdl.org>
Subject: Speed up git-merge-base a lot
Date: Wed, 10 Aug 2005 16:26:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508101615520.3295@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 11 01:29:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2zyM-0000KV-Rt
	for gcvg-git@gmane.org; Thu, 11 Aug 2005 01:27:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932601AbVHJX0j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Aug 2005 19:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932602AbVHJX0i
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Aug 2005 19:26:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:904 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932601AbVHJX0h (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Aug 2005 19:26:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7ANQXjA008314
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 10 Aug 2005 16:26:33 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7ANQWa6018358;
	Wed, 10 Aug 2005 16:26:32 -0700
To: Junio C Hamano <junkio@cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.41__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



In commit 4f7eb2e5a351e0d1f19fd4eab7e92834cc4528c2 I fixed git-merge-base 
getting confused by datestamps that caused it to traverse things in a 
non-obvious order.

However, my fix was a very brute-force one, and it had some really
horrible implications for more complex trees with lots of parallell
development. It might end up traversing all the way to the root commit.

Now, normally that isn't that horrible: it's used mainly for merging, and 
the bad cases really tend to happen fairly rarely, so if it takes a few 
seconds, we're not in too bad shape.

However, gitk will also do the git-merge-base for every merge it shows,
because it basically re-does the trivial merge in order to show the
"interesting" parts. And there we'd really like the result to be
instantaneous.

This patch does that by walking the tree more completely, and using the 
same heuristic as git-rev-list to decide "ok, the rest is uninteresting".

In one - hopefully fairly extreme - case, it made a git-merge-base go from
just under five seconds(!) to a tenth of a second on my machine.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/merge-base.c b/merge-base.c
--- a/merge-base.c
+++ b/merge-base.c
@@ -2,6 +2,22 @@
 #include "cache.h"
 #include "commit.h"
 
+#define PARENT1 1
+#define PARENT2 2
+#define UNINTERESTING 4
+
+static int interesting(struct commit_list *list)
+{
+	while (list) {
+		struct commit *commit = list->item;
+		list = list->next;
+		if (commit->object.flags & UNINTERESTING)
+			continue;
+		return 1;
+	}
+	return 0;
+}
+
 static struct commit *common_ancestor(struct commit *rev1, struct commit *rev2)
 {
 	struct commit_list *list = NULL;
@@ -18,19 +34,18 @@ static struct commit *common_ancestor(st
 	insert_by_date(rev1, &list);
 	insert_by_date(rev2, &list);
 
-	while (list) {
+	while (interesting(list)) {
 		struct commit *commit = list->item;
 		struct commit_list *tmp = list, *parents;
-		int flags = commit->object.flags & 3;
+		int flags = commit->object.flags & 7;
 
 		list = list->next;
 		free(tmp);
-		switch (flags) {
-		case 3:
+		if (flags == 3) {
 			insert_by_date(commit, &result);
-			continue;
-		case 0:
-			die("git-merge-base: commit without either parent?");
+
+			/* Mark children of a found merge uninteresting */
+			flags |= UNINTERESTING;
 		}
 		parents = commit->parents;
 		while (parents) {
