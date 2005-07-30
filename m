From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Fix interesting git-rev-list corner case
Date: Sat, 30 Jul 2005 15:10:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507301507390.29650@g5.osdl.org>
References: <Pine.LNX.4.58.0507291542060.29650@g5.osdl.org> <m31x5gob8k.fsf@telia.com>
 <Pine.LNX.4.58.0507300913000.29650@g5.osdl.org> <m3fytwm313.fsf@telia.com>
 <Pine.LNX.4.58.0507301354000.29650@g5.osdl.org> <Pine.LNX.4.58.0507302259140.26128@telia.com>
 <Pine.LNX.4.58.0507301428300.29650@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 31 00:10:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyzXX-0005GM-C0
	for gcvg-git@gmane.org; Sun, 31 Jul 2005 00:10:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbVG3WKd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jul 2005 18:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263105AbVG3WKb
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jul 2005 18:10:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47587 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263003AbVG3WK3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Jul 2005 18:10:29 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6UMALjA013605
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 30 Jul 2005 15:10:21 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6UMAKd9015453;
	Sat, 30 Jul 2005 15:10:20 -0700
To: Peter Osterlund <petero2@telia.com>
In-Reply-To: <Pine.LNX.4.58.0507301428300.29650@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 30 Jul 2005, Linus Torvalds wrote:
> 
> Yup, it's git-merge-base, and it is confused by the same thing that 
> confused git-rev-list.
> 
> Thanks, I'll fix it.

Hmm.. Here's a tentative fix. I'm not really happy with it, and maybe
somebody else can come up with a better one. I think this one ends up
being quite a bit more expensive than the old one (it will look up _all_
common parents that have a child that isn't common, and then select the
newest one of the bunch), but I haven't really thought it through very
much.

I bet there is a smarter way to do this, but this _should_ fix the problem
Peter sees. Peter?

		Linus
---
diff --git a/merge-base.c b/merge-base.c
--- a/merge-base.c
+++ b/merge-base.c
@@ -2,54 +2,50 @@
 #include "cache.h"
 #include "commit.h"
 
-static struct commit *process_list(struct commit_list **list_p, int this_mark,
-				   int other_mark)
-{
-	struct commit *item = (*list_p)->item;
-
-	if (item->object.flags & other_mark) {
-		return item;
-	} else {
-		pop_most_recent_commit(list_p, this_mark);
-	}
-	return NULL;
-}
-
 static struct commit *common_ancestor(struct commit *rev1, struct commit *rev2)
 {
-	struct commit_list *rev1list = NULL;
-	struct commit_list *rev2list = NULL;
+	struct commit_list *list = NULL;
+	struct commit_list *result = NULL;
 
-	commit_list_insert(rev1, &rev1list);
-	rev1->object.flags |= 0x1;
-	commit_list_insert(rev2, &rev2list);
-	rev2->object.flags |= 0x2;
+	if (rev1 == rev2)
+		return rev1;
 
 	parse_commit(rev1);
 	parse_commit(rev2);
 
-	while (rev1list || rev2list) {
-		struct commit *ret;
-		if (!rev1list) {
-			// process 2
-			ret = process_list(&rev2list, 0x2, 0x1);
-		} else if (!rev2list) {
-			// process 1
-			ret = process_list(&rev1list, 0x1, 0x2);
-		} else if (rev1list->item->date < rev2list->item->date) {
-			// process 2
-			ret = process_list(&rev2list, 0x2, 0x1);
-		} else {
-			// process 1
-			ret = process_list(&rev1list, 0x1, 0x2);
+	rev1->object.flags |= 1;
+	rev2->object.flags |= 2;
+	insert_by_date(rev1, &list);
+	insert_by_date(rev2, &list);
+
+	while (list) {
+		struct commit *commit = list->item;
+		struct commit_list *tmp = list, *parents;
+		int flags = commit->object.flags & 3;
+
+		list = list->next;
+		free(tmp);
+		switch (flags) {
+		case 3:
+			insert_by_date(commit, &result);
+			continue;
+		case 0:
+			die("git-merge-base: commit without either parent?");
 		}
-		if (ret) {
-			free_commit_list(rev1list);
-			free_commit_list(rev2list);
-			return ret;
+		parents = commit->parents;
+		while (parents) {
+			struct commit *p = parents->item;
+			parents = parents->next;
+			if ((p->object.flags & flags) == flags)
+				continue;
+			parse_commit(p);
+			p->object.flags |= flags;
+			insert_by_date(p, &list);
 		}
 	}
-	return NULL;
+	if (!result)
+		return NULL;
+	return result->item;
 }
 
 int main(int argc, char **argv)
@@ -64,6 +60,8 @@ int main(int argc, char **argv)
 	}
 	rev1 = lookup_commit_reference(rev1key);
 	rev2 = lookup_commit_reference(rev2key);
+	if (!rev1 || !rev2)
+		return 1;
 	ret = common_ancestor(rev1, rev2);
 	if (!ret)
 		return 1;
