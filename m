From: Linus Torvalds <torvalds@osdl.org>
Subject: Make time-based commit filtering work with topological ordering
Date: Tue, 20 Sep 2005 14:00:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509201358200.2553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Sep 20 23:04:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHpEr-0002fp-1V
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 23:01:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965159AbVITVBJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 17:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965157AbVITVBI
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 17:01:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48331 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965159AbVITVBH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Sep 2005 17:01:07 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8KL11Bo013785
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 20 Sep 2005 14:01:01 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8KL0xf5005824;
	Tue, 20 Sep 2005 14:01:00 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.117 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9021>


The trick is to consider the time-based filtering a limiter, the same way 
we do for release ranges.

That means that the time-based filtering runs _before_ the topological 
sorting, which makes it meaningful again. It also simplifies the code 
logic.

This makes "gitk" useful with time ranges.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -82,12 +82,6 @@ static int filter_commit(struct commit *
 		return STOP;
 	if (commit->object.flags & (UNINTERESTING|SHOWN))
 		return CONTINUE;
-	if (min_age != -1 && (commit->date > min_age))
-		return CONTINUE;
-	if (max_age != -1 && (commit->date < max_age)) {
-		stop_traversal=1;
-		return merge_order?CONTINUE:STOP;
-	}
 	if (max_count != -1 && !max_count--)
 		return STOP;
 	if (no_merges && (commit->parents && commit->parents->next))
@@ -374,6 +368,8 @@ static struct commit_list *limit_list(st
 		struct commit *commit = pop_most_recent_commit(&list, SEEN);
 		struct object *obj = &commit->object;
 
+		if (max_age != -1 && (commit->date < max_age))
+			obj->flags |= UNINTERESTING;
 		if (unpacked && has_sha1_pack(obj->sha1))
 			obj->flags |= UNINTERESTING;
 		if (obj->flags & UNINTERESTING) {
@@ -382,6 +378,8 @@ static struct commit_list *limit_list(st
 				break;
 			continue;
 		}
+		if (min_age != -1 && (commit->date > min_age))
+			continue;
 		p = &commit_list_insert(commit, p)->next;
 	}
 	if (tree_objects)
@@ -494,10 +492,12 @@ int main(int argc, char **argv)
 		}
 		if (!strncmp(arg, "--max-age=", 10)) {
 			max_age = atoi(arg + 10);
+			limited = 1;
 			continue;
 		}
 		if (!strncmp(arg, "--min-age=", 10)) {
 			min_age = atoi(arg + 10);
+			limited = 1;
 			continue;
 		}
 		if (!strcmp(arg, "--header")) {
