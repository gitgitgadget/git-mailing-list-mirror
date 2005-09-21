From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Make time-based commit filtering work with topological ordering
Date: Tue, 20 Sep 2005 17:55:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509201745050.2553@g5.osdl.org>
References: <Pine.LNX.4.58.0509201358200.2553@g5.osdl.org>
 <7vpsr31ii7.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0509201543140.2553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 21 02:56:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHstx-0006nG-6k
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 02:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbVIUAzy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 20:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbVIUAzy
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 20:55:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24460 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750853AbVIUAzx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Sep 2005 20:55:53 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8L0tlBo025426
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 20 Sep 2005 17:55:48 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8L0tkC6017094;
	Tue, 20 Sep 2005 17:55:47 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.58.0509201543140.2553@g5.osdl.org>
X-Spam-Status: No, hits=0.358 required=5 tests=ORDER_NOW
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.117 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9026>



On Tue, 20 Sep 2005, Linus Torvalds wrote:
> 
> Merge-order doesn't use the normal limit rules, but does its own home-brew
> limiting.  It could do the date-limiting on its own, if it wanted to, but 
> I doubt it would make sense.

Actually, looking closely, merge-order actually had it's own hack in the 
old filter_commit() code to make it work sanely. 

This is an updated patch that allows merge-order to continue to work. 

		Linus

---
Subject: Make time-based commit filtering work with topological ordering

The trick is to consider the time-based filtering a limiter, the same way
we do for release ranges.

That means that the time-based filtering runs _before_ the topological
sorting, which makes it meaningful again. It also simplifies the code
logic.

This makes "gitk" useful with time ranges.

[ Second version: --merge-order now unaffected by the re-org ]

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -86,7 +86,7 @@ static int filter_commit(struct commit *
 		return CONTINUE;
 	if (max_age != -1 && (commit->date < max_age)) {
 		stop_traversal=1;
-		return merge_order?CONTINUE:STOP;
+		return CONTINUE;
 	}
 	if (max_count != -1 && !max_count--)
 		return STOP;
@@ -374,6 +374,8 @@ static struct commit_list *limit_list(st
 		struct commit *commit = pop_most_recent_commit(&list, SEEN);
 		struct object *obj = &commit->object;
 
+		if (max_age != -1 && (commit->date < max_age))
+			obj->flags |= UNINTERESTING;
 		if (unpacked && has_sha1_pack(obj->sha1))
 			obj->flags |= UNINTERESTING;
 		if (obj->flags & UNINTERESTING) {
@@ -382,6 +384,8 @@ static struct commit_list *limit_list(st
 				break;
 			continue;
 		}
+		if (min_age != -1 && (commit->date > min_age))
+			continue;
 		p = &commit_list_insert(commit, p)->next;
 	}
 	if (tree_objects)
@@ -494,10 +498,12 @@ int main(int argc, char **argv)
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
