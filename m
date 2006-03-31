From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC 2/2] Make path-limiting be incremental when possible.
Date: Thu, 30 Mar 2006 22:16:08 -0800
Message-ID: <7vr74jxhp3.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0603301648530.27203@g5.osdl.org>
	<Pine.LNX.4.64.0603301652531.27203@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 31 08:16:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FPCvh-0002en-EA
	for gcvg-git@gmane.org; Fri, 31 Mar 2006 08:16:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbWCaGQO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Mar 2006 01:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbWCaGQO
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Mar 2006 01:16:14 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:11909 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751067AbWCaGQN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Mar 2006 01:16:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060331061610.HPSE20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 31 Mar 2006 01:16:10 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603301652531.27203@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 30 Mar 2006 17:05:25 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18217>

Linus Torvalds <torvalds@osdl.org> writes:

> The reason I put "RFC" in the subject line is that while I've validated it 
> various ways, like doing
>
> 	git-rev-list HEAD -- drivers/char/ | md5sum 
>
> before-and-after on the kernel archive, it's "git-rev-list" after all. In 
> other words, it's that really really subtle and complex central piece of 
> software. So while I think this is important and should go in asap, I also 
> think it should get lots of testing and eyeballs looking at the code.

Let me make sure I understand what is going on.

Currently, limit_list(), which is called when revs->limited is
set, serves two different purposes:

 * traverse the ancestry chain and mark ancestors of
   uninteresting commits also uninteresting;

 * "simplify" each commit that is still interesting, by
   comparing the tree object of it and its parents.

We used to call limit_list() when we are limiting the commits by
paths, because that was what the latter does as a side effect of
add_parents_to_list().  You made it streamable by moving the
call to get_revision() and not calling limit_list() when you do
not have other reasons to call it.

You currently do not do this streaming optimization when you
have to show simplified parents, because the streaming version
traverses ancestry chain one step at a time as it goes, and you
cannot obviously see who the final "fake" parent is until you
simplify the parents enouogh.

Now, I have some observations, not necessarily limited to this
patch but also to the code from the "master" version.

 * get_commit_reference() sets "limited" when the user gives ^exclude
   commit.  no question about this --- we would need to see the
   reachability in this case.

 * when we are going to sort the result we are going to show,
   we set "limited" -- we cannot sort without knowing the set we
   are sorting.

 * giving commit timestamp limits via --max-age, --min-age
   etc. sets "limited".  I have doubts about this.  We currently
   look at the commit timestamp in limit_list() and mark a
   commit old enough to be "uninteresting" -- which makes
   ancestor of such commit also uninteresting.  Similarly
   commits that are too young are not pushed into the result.

   There is a filter in get_revision() to omit ineligible
   commits by time range already, so I wonder if we can remove
   that code from limit_list() and not set "limited" when these
   timestamp ranges are given.  This would let us stream even
   more.

   Admittably, ancestors of an old commit had better be even
   older, so marking them uninteresting to stop the traversal
   early is a good way to optimize the full-traversal case, but
   not having to call limit_list() would help streaming usage.

   Also I have doubts about correctness issue about the max-age
   handling.  Is it correct to mark a commit that is old enough
   to be uninteresting, implying that its ancestors are all
   uninteresting?  With clock skew among people, it is possible
   to make a merge commit that has parents one of which is "in
   the future".

 * As to handling of --unpacked, exactly the same comment as
   "max-age" applies, but it might be even worse.  Marking an
   unpacked one "uninteresting" means if a packed commit refers
   to loose commit, the loose one will be also marked
   uninteresting, I think.

"--objects --unpacked" is an idiom to repack objects that are
still loose, but I suspect it would do interesting thing if the
commit is in a pack but its trees and blobs are still loose.  Am
I confused, or have I just spotted a potential (but hard to
trigger) bug?


--
diff --git a/revision.c b/revision.c
index 0e3f074..a55c0d1 100644
--- a/revision.c
+++ b/revision.c
@@ -404,10 +404,6 @@ static void limit_list(struct rev_info *
 		list = list->next;
 		free(entry);
 
-		if (revs->max_age != -1 && (commit->date < revs->max_age))
-			obj->flags |= UNINTERESTING;
-		if (revs->unpacked && has_sha1_pack(obj->sha1))
-			obj->flags |= UNINTERESTING;
 		add_parents_to_list(revs, commit, &list);
 		if (obj->flags & UNINTERESTING) {
 			mark_parents_uninteresting(commit);
@@ -415,8 +411,6 @@ static void limit_list(struct rev_info *
 				break;
 			continue;
 		}
-		if (revs->min_age != -1 && (commit->date > revs->min_age))
-			continue;
 		p = &commit_list_insert(commit, p)->next;
 	}
 	if (revs->boundary) {
@@ -543,32 +537,26 @@ int setup_revisions(int argc, const char
 			}
 			if (!strncmp(arg, "--max-age=", 10)) {
 				revs->max_age = atoi(arg + 10);
-				revs->limited = 1;
 				continue;
 			}
 			if (!strncmp(arg, "--min-age=", 10)) {
 				revs->min_age = atoi(arg + 10);
-				revs->limited = 1;
 				continue;
 			}
 			if (!strncmp(arg, "--since=", 8)) {
 				revs->max_age = approxidate(arg + 8);
-				revs->limited = 1;
 				continue;
 			}
 			if (!strncmp(arg, "--after=", 8)) {
 				revs->max_age = approxidate(arg + 8);
-				revs->limited = 1;
 				continue;
 			}
 			if (!strncmp(arg, "--before=", 9)) {
 				revs->min_age = approxidate(arg + 9);
-				revs->limited = 1;
 				continue;
 			}
 			if (!strncmp(arg, "--until=", 8)) {
 				revs->min_age = approxidate(arg + 8);
-				revs->limited = 1;
 				continue;
 			}
 			if (!strcmp(arg, "--all")) {
@@ -635,7 +623,6 @@ int setup_revisions(int argc, const char
 			}
 			if (!strcmp(arg, "--unpacked")) {
 				revs->unpacked = 1;
-				revs->limited = 1;
 				continue;
 			}
 			*unrecognized++ = arg;
@@ -786,7 +773,9 @@ struct commit *get_revision(struct rev_i
 		if (revs->min_age != -1 && (commit->date > revs->min_age))
 			continue;
 		if (revs->max_age != -1 && (commit->date < revs->max_age))
-			return NULL;
+			continue;
+		if (revs->unpacked && has_sha1_pack(commit->object.sha1))
+			continue;
 		if (revs->no_merges &&
 		    commit->parents && commit->parents->next)
 			continue;
