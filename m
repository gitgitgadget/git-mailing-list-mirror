From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] First cut at libifying revlist generation
Date: Sun, 26 Feb 2006 19:11:02 -0800
Message-ID: <7vpsl93395.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602251608160.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 27 04:11:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDYn1-0005bP-Jv
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 04:11:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWB0DLH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 22:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbWB0DLH
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 22:11:07 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:6071 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750820AbWB0DLF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2006 22:11:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060227030936.LTKA20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 26 Feb 2006 22:09:36 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602251608160.22647@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 25 Feb 2006 16:19:46 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16823>

Linus Torvalds <torvalds@osdl.org> writes:

> Comments? I think this is safe to apply, because I've done a diff of the 
> old non-split rev-list.c against both the new rev-list.c and revision.c, 
> and all the changes _look_ like just moving things around and taking the 
> new "struct rev_info" into account.

I think you would need something the attached patch, at least.

I have a suspicion that this was your easter egg to see how
careful I am reading what I apply -- and I failed.  Johannes
gets a test-pilot star for this.  This also means we need a bit
better set of tests.

The diff between old rev-list.c and new split files would not
have caught the static variable gotcha.

I am clueless about the "limited = (list && list->next)" part,
but there is only one commit involved hence the test is false
with my testcase "git-rev-list --objects v1.0.0^0..v1.0.0"; I
think the old code said dotdot is a limited case.

---
diff --git a/rev-list.c b/rev-list.c
index d1c52a6..630626e 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -214,8 +214,6 @@ static struct object_list **process_tree
 	return p;
 }
 
-static struct object_list *pending_objects = NULL;
-
 static void show_commit_list(struct commit_list *list)
 {
 	struct object_list *objects = NULL, **p = &objects, *pending;
@@ -226,7 +224,7 @@ static void show_commit_list(struct comm
 		if (process_commit(commit) == STOP)
 			break;
 	}
-	for (pending = pending_objects; pending; pending = pending->next) {
+	for (pending = revs.pending_objects; pending; pending = pending->next) {
 		struct object *obj = pending->item;
 		const char *name = pending->name;
 		if (obj->flags & (UNINTERESTING | SEEN))
@@ -675,7 +673,7 @@ int main(int argc, const char **argv)
 	}
 
 	list = revs.commits;
-	if (list && list->next)
+	if (list)
 		limited = 1;
 
 	if (revs.topo_order)
@@ -689,7 +687,7 @@ int main(int argc, const char **argv)
 		limited = 1;
 		diff_tree_setup_paths(revs.paths);
 	}
-	if (revs.max_age || revs.min_age)
+	if (revs.max_age != -1 || revs.min_age != -1)
 		limited = 1;
 
 	save_commit_buffer = verbose_header;
