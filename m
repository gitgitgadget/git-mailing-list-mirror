From: Junio C Hamano <junkio@cox.net>
Subject: Re: git merge performance problem..
Date: Sat, 15 Jul 2006 23:57:28 -0700
Message-ID: <7vsll2jauf.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0607151445270.5623@g5.osdl.org>
	<7v7j2eme3u.fsf@assigned-by-dhcp.cox.net>
	<7vlkqukwhb.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0607152136010.2438@evo.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 16 08:57:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G20ZK-0006no-W1
	for gcvg-git@gmane.org; Sun, 16 Jul 2006 08:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbWGPG5a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Jul 2006 02:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbWGPG5a
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Jul 2006 02:57:30 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:57229 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751494AbWGPG5a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jul 2006 02:57:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060716065729.UURB11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 16 Jul 2006 02:57:29 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607152136010.2438@evo.osdl.org> (Linus Torvalds's
	message of "Sat, 15 Jul 2006 21:43:49 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23946>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sat, 15 Jul 2006, Junio C Hamano wrote:
>> Junio C Hamano <junkio@cox.net> writes:
>> >
>> > The code is to cull redundant parents primarily in octopus and
>> > is not strictly necessary.
>> 
>> Wrong.  The commit log says it was to remove redundant parents;
>> I think this as a reaction after seeing a few incorrectly made
>> merge commits in the kernel archive.
>
> Arguing with yourself? ;)

Yes, I was kind of tired ;-)

> And your patch will obviously fix it (by not calling git-show-branch at 
> all), but I'm still left wondering why git-show-branch took that long in 
> the first place. Half a minute when traversing the whole commit history 
> only takes three seconds (as per my previous email)?
>
> Now, as long as nothing I use actually ends up using git-show-branch, I 
> won't care, but maybe a sign that something else can be improved?

I instrumented builtin-show-branch.c::join_revs() and
commit.c::merge-bases(), and run another problematic case
between commits 1d3737 and 7f2857.  They traverse exactly the
same commits in the same order.  After all in two head case they
are essentially the same algorithm, modulo that the heuristics
with horizon effect has not been removed from join_revs() yet.

Similarly, "merge-base --all" vs "show-branch --merge-base"
between these commits has the same issue.  Although they
traverse exactly the same set of commits, the former takes 10x
longer for some reason.

And (drumroll please), thanks to gprof, the guilty party turns
out to be insert_by_date() in mark_seen().

I think this will fix both problems.

-- >8 --
show-branch: fix performance problem.

The core function used in show-branch, join_revs(), was supposed
to be exactly the same algorithm as merge_bases(), except that
it was a version enhanced for use with more than two heads.
However, it needed to mark and keep a list of all the commits it
has seen, because it needed them for its semi-graphical output.
The function to implement this list, mark_seen(), stupidly used
insert_by_date(), when it did not need to keep the list sorted
during its processing.  This made "show-branch --merge-base"
more than 20x slower compared to "merge-base --all" in some
cases (e.g. between b5032a5 and 48ce8b0 in the Linux 2.6 kernel
archive).  The performance of "show-branch --independent"
suffered from the same reason.

This patch sorts the resulting list after the list traversal
just once to fix these problems.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 260cb22..3d240ca 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -172,7 +172,7 @@ static void name_commits(struct commit_l
 static int mark_seen(struct commit *commit, struct commit_list **seen_p)
 {
 	if (!commit->object.flags) {
-		insert_by_date(commit, seen_p);
+		commit_list_insert(commit, seen_p);
 		return 1;
 	}
 	return 0;
@@ -218,9 +218,8 @@ static void join_revs(struct commit_list
 	 * Postprocess to complete well-poisoning.
 	 *
 	 * At this point we have all the commits we have seen in
-	 * seen_p list (which happens to be sorted chronologically but
-	 * it does not really matter).  Mark anything that can be
-	 * reached from uninteresting commits not interesting.
+	 * seen_p list.  Mark anything that can be reached from
+	 * uninteresting commits not interesting.
 	 */
 	for (;;) {
 		int changed = 0;
@@ -701,6 +700,8 @@ int cmd_show_branch(int ac, const char *
 	if (0 <= extra)
 		join_revs(&list, &seen, num_rev, extra);
 
+	sort_by_date(&seen);
+
 	if (merge_base)
 		return show_merge_base(seen, num_rev);
 
