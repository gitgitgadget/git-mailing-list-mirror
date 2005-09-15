From: Linus Torvalds <torvalds@osdl.org>
Subject: Re-organize "git-rev-list --objects" logic
Date: Thu, 15 Sep 2005 15:14:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509151507380.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Sep 16 00:15:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EG20A-0006VQ-7o
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 00:14:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932605AbVIOWOj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 18:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932607AbVIOWOj
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 18:14:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6051 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932605AbVIOWOj (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2005 18:14:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8FMEUBo024453
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 15 Sep 2005 15:14:30 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8FMETQ3028098;
	Thu, 15 Sep 2005 15:14:29 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8646>


The logic to calculate the full object list used to be very inter-twined 
with the logic that looked up the commits.

For no good reason - it's actually a lot simpler to just do that logic 
as a separate pass.

This improves performance a bit, and uses slightly less memory in my 
tests, but more importantly it makes the code simpler to work with and 
follow what it does.

The performance win is less than I had hoped for, but I get:

Before:

	[torvalds@g5 linux]$ /usr/bin/time git-rev-list --objects v2.6.12..HEAD | wc -l
	13.64user 0.42system 0:14.13elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
	0inputs+0outputs (0major+47947minor)pagefaults 0swaps
	58945

After:

	[torvalds@g5 linux]$ /usr/bin/time git-rev-list --objects v2.6.12..HEAD | wc -l
	11.80user 0.36system 0:12.16elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
	0inputs+0outputs (0major+42684minor)pagefaults 0swaps
	58945

ie it improved by 2 seconds, and took a 5000+ fewer pages (hey, that's 
20MB out of 174MB to go). And got the same number of objects (in theory, 
the more expensive one might find some more shared objects to avoid. In 
practice it obviously doesn't).

I know how to make it use _lots_ less memory, which will probably speed it 
up. But that's for another time, and I'd prefer to see this go in first.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
----

diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -231,8 +231,6 @@ static void mark_parents_uninteresting(s
 {
 	struct commit_list *parents = commit->parents;
 
-	if (tree_objects)
-		mark_tree_uninteresting(commit->tree);
 	while (parents) {
 		struct commit *commit = parents->item;
 		commit->object.flags |= UNINTERESTING;
@@ -272,29 +270,6 @@ static int everybody_uninteresting(struc
 			continue;
 		return 0;
 	}
-
-	/*
-	 * Ok, go back and mark all the edge trees uninteresting,
-	 * since otherwise we can have situations where a parent
-	 * that was marked uninteresting (and we never even had
-	 * to look at) had lots of objects that we don't want to
-	 * include.
-	 *
-	 * NOTE! This still doesn't mean that the object list is
-	 * "correct", since we may end up listing objects that
-	 * even older commits (that we don't list) do actually
-	 * reference, but it gets us to a minimal list (or very
-	 * close) in practice.
-	 */
-	if (!tree_objects)
-		return 1;
-
-	while (orig) {
-		struct commit *commit = orig->item;
-		if (!parse_commit(commit) && commit->tree)
-			mark_tree_uninteresting(commit->tree);
-		orig = orig->next;
-	}
 	return 1;
 }
 
@@ -370,6 +345,19 @@ static struct commit_list *find_bisectio
 	return best;
 }
 
+static void mark_edges_uninteresting(struct commit_list *list)
+{
+	for ( ; list; list = list->next) {
+		struct commit_list *parents = list->item->parents;
+
+		for ( ; parents; parents = parents->next) {
+			struct commit *commit = parents->item;
+			if (commit->object.flags & UNINTERESTING)
+				mark_tree_uninteresting(commit->tree);
+		}
+	}
+}
+
 static struct commit_list *limit_list(struct commit_list *list)
 {
 	struct commit_list *newlist = NULL;
@@ -388,6 +376,8 @@ static struct commit_list *limit_list(st
 		}
 		p = &commit_list_insert(commit, p)->next;
 	}
+	if (tree_objects)
+		mark_edges_uninteresting(newlist);
 	if (bisect_list)
 		newlist = find_bisection(newlist);
 	return newlist;
