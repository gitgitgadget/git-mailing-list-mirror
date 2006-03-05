From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: What's in git.git
Date: Sun, 5 Mar 2006 09:53:52 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603050946280.13139@g5.osdl.org>
References: <7vacc5jza6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0603042058250.13139@g5.osdl.org> <7vfylxigxc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 05 18:54:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFxQj-0007Wb-QU
	for gcvg-git@gmane.org; Sun, 05 Mar 2006 18:54:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbWCERx7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 12:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWCERx7
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 12:53:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21172 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751327AbWCERx6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Mar 2006 12:53:58 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k25HrsDZ025762
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 5 Mar 2006 09:53:54 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k25HrqMD031705;
	Sun, 5 Mar 2006 09:53:53 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfylxigxc.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17234>



On Sat, 4 Mar 2006, Junio C Hamano wrote:
> 
> At this point commit is revs->commits->item.  It cannot be
> UNINTERESTING because you make it sure with !revs->limited and
> friends, but I wonder if it can be SHOWN already for some
> reason, in which case returning it is wrong.
> 
> Unlike the earlier special case in rev-list, this special case
> kicks in for the last iteration of repeated calls to
> get_revision() (e.g. third iteration of "rev-list -3")...

Good point. Yes, it needs to check that it's not SHOWN. Might as well 
check against interesting too. Maybe something like this instead?

		Linus

---
diff --git a/revision.c b/revision.c
index a3df810..2a33637 100644
--- a/revision.c
+++ b/revision.c
@@ -684,13 +684,11 @@ static void rewrite_parents(struct commi
 struct commit *get_revision(struct rev_info *revs)
 {
 	struct commit_list *list = revs->commits;
-	struct commit *commit;
 
 	if (!list)
 		return NULL;
 
 	/* Check the max_count ... */
-	commit = list->item;
 	switch (revs->max_count) {
 	case -1:
 		break;
@@ -701,22 +699,28 @@ struct commit *get_revision(struct rev_i
 	}
 
 	do {
-		commit = pop_most_recent_commit(&revs->commits, SEEN);
+		struct commit *commit = revs->commits->item;
+
 		if (commit->object.flags & (UNINTERESTING|SHOWN))
-			continue;
+			goto next;
 		if (revs->min_age != -1 && (commit->date > revs->min_age))
-			continue;
+			goto next;
 		if (revs->max_age != -1 && (commit->date < revs->max_age))
 			return NULL;
 		if (revs->no_merges && commit->parents && commit->parents->next)
-			continue;
+			goto next;
 		if (revs->paths && revs->dense) {
 			if (!(commit->object.flags & TREECHANGE))
-				continue;
+				goto next;
 			rewrite_parents(commit);
 		}
+		/* More to go? */
+		if (revs->max_count)
+			pop_most_recent_commit(&revs->commits, SEEN);
 		commit->object.flags |= SHOWN;
 		return commit;
+next:
+		pop_most_recent_commit(&revs->commits, SEEN);
 	} while (revs->commits);
 	return NULL;
 }
