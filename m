From: Junio C Hamano <junkio@cox.net>
Subject: Re: A note on merging conflicts..
Date: Sat, 01 Jul 2006 13:14:59 -0700
Message-ID: <7vpsgpccak.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org>
	<7vy7vedntn.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606302046230.12404@g5.osdl.org>
	<20060701150926.GA25800@lsrfire.ath.cx>
	<7vfyhldvd2.fsf@assigned-by-dhcp.cox.net>
	<44A6CD1D.2000600@lsrfire.ath.cx>
	<Pine.LNX.4.64.0607011301480.12404@g5.osdl.org>
	<7vveqhccnk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jul 01 22:15:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fwlrw-0002UP-Sc
	for gcvg-git@gmane.org; Sat, 01 Jul 2006 22:15:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbWGAUPE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Jul 2006 16:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751924AbWGAUPC
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Jul 2006 16:15:02 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:2278 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751825AbWGAUPB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jul 2006 16:15:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060701201500.CBUT6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 1 Jul 2006 16:15:00 -0400
To: git@vger.kernel.org
In-Reply-To: <7vveqhccnk.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 01 Jul 2006 13:07:11 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23064>

Junio C Hamano <junkio@cox.net> writes:

> Linus Torvalds <torvalds@osdl.org> writes:
>
>> On Sat, 1 Jul 2006, Rene Scharfe wrote:
>>> 
>>> I wonder why the two clear_commit_marks() calls at the end of
>>> get_merge_bases() are not sufficient, though.
>>
>> Why does that thing check for "parent->object.parsed"?
>
> Oh, I thought I fixed that up when I merged.  Sorry.
>
>> Also, it only clears commit marks if they are contiguous, but some commit 
>> marking may not be dense (eg, the "UNINTERESTING" mark may have been set 
>> by (PARENT1 && PARENT2) triggering, but is not set in the commits that 
>> reach it.
>
> That is true.

I'll be offline for a few hours, but if anybody is inclined to
fix this up, I'd appreciate it to be based on top of 7c6f8aa
commit (which is the tip of js/merge-base topic branch).

Perhaps as a starter (not even compile tested)... 

diff --git a/commit.c b/commit.c
index 0431027..23ac210 100644
--- a/commit.c
+++ b/commit.c
@@ -397,13 +397,13 @@ void clear_commit_marks(struct commit *c
 {
 	struct commit_list *parents;
 
-	parents = commit->parents;
+	if (!commit)
+		return;
 	commit->object.flags &= ~mark;
+	parents = commit->parents;
 	while (parents) {
 		struct commit *parent = parents->item;
-		if (parent && parent->object.parsed &&
-		    (parent->object.flags & mark))
-			clear_commit_marks(parent, mark);
+		clear_commit_marks(parent, mark);
 		parents = parents->next;
 	}
 }
@@ -1012,7 +1012,8 @@ static void mark_reachable_commits(struc
 	}
 }
 
-struct commit_list *get_merge_bases(struct commit *rev1, struct commit *rev2)
+struct commit_list *get_merge_bases(struct commit *rev1, struct commit *rev2,
+				    int cleanup_needed)
 {
 	struct commit_list *list = NULL;
 	struct commit_list *result = NULL;
@@ -1081,8 +1082,10 @@ struct commit_list *get_merge_bases(stru
 	}
 
 	/* reset flags */
-	clear_commit_marks(rev1, PARENT1 | PARENT2 | UNINTERESTING);
-	clear_commit_marks(rev2, PARENT1 | PARENT2 | UNINTERESTING);
+	if (cleanup_needed) {
+		clear_commit_marks(rev1, PARENT1 | PARENT2 | UNINTERESTING);
+		clear_commit_marks(rev2, PARENT1 | PARENT2 | UNINTERESTING);
+	}
 
 	return result;
 }
diff --git a/commit.h b/commit.h
index 89b9dad..53bc697 100644
--- a/commit.h
+++ b/commit.h
@@ -105,6 +105,6 @@ struct commit_graft *read_graft_line(cha
 int register_commit_graft(struct commit_graft *, int);
 int read_graft_file(const char *graft_file);
 
-extern struct commit_list *get_merge_bases(struct commit *rev1, struct commit *rev2);
+extern struct commit_list *get_merge_bases(struct commit *rev1, struct commit *rev2, int cleanup_needed);
 
 #endif /* COMMIT_H */
diff --git a/merge-base.c b/merge-base.c
index b41f76c..59f723f 100644
--- a/merge-base.c
+++ b/merge-base.c
@@ -6,7 +6,7 @@ static int show_all = 0;
 
 static int merge_base(struct commit *rev1, struct commit *rev2)
 {
-	struct commit_list *result = get_merge_bases(rev1, rev2);
+	struct commit_list *result = get_merge_bases(rev1, rev2, 0);
 
 	if (!result)
 		return 1;
