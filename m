From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Lose perl dependency. (fwd)
Date: Sat, 20 Jan 2007 10:31:01 -0800
Message-ID: <7vwt3h7dp6.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0701181149260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<45AF5F83.6090207@fs.ei.tum.de>
	<Pine.LNX.4.63.0701181441010.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vps9ag58g.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701200052210.12889@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vvej2bkn2.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701200213020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vfya69xym.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701201025070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 19:31:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8Kzf-0003PA-Oy
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 19:31:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965284AbXATSbF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Jan 2007 13:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965263AbXATSbF
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jan 2007 13:31:05 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:51763 "EHLO
	fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965284AbXATSbD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jan 2007 13:31:03 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070120183102.ISLK18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Sat, 20 Jan 2007 13:31:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id DWXK1W00a1kojtg0000000; Sat, 20 Jan 2007 13:31:19 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37279>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I think there are two very valid ways.  You determine what you
>> would spit out as if there is no --reverse, and then reverse the
>> result, or you do not limit with them to get everthing, reverse
>> the result and do the counting limit on that reversed list.
> ...
>> I do not think you would need to artificially make it limited like your 
>> patch does if you go this route
>
> Why? To see the last commit (which should be output first), I _have_ to 
> traverse them first, before reversing the order. I thought revs->limited 
> does exactly that -- traverse all commits first. Am I mistaken?

I think you are talking about the second semantics; I was
talking about the first one.  In other words, the one whose
semantics of:

	$ git log --max-count=10 --skip=5 --reverse HEAD

is to first internally run

	$ git log --max-count=10 --skip=5 HEAD

then reverse the resulting 10 commits and spit them out.

Now, "git log --max-count=10 --skip=5" does not need to call
limit_list().  It needs to traverse the usual date-sorted
revs->commits for fifteen rounds.

Looking at your patch again,...

@@ -1155,6 +1160,8 @@ void prepare_revision_walk(struct rev_info *revs)
 		sort_in_topological_order_fn(&revs->commits, revs->lifo,
 					     revs->topo_setter,
 					     revs->topo_getter);
+	if (revs->reverse)
+		revs->commits = reverse_commit_list(revs->commits);
 }
 
 static int rewrite_one(struct rev_info *revs, struct commit **pp)

This makes the code traverse and grab everything and then
reverse; the later get_revision() -> get_revision_1() loop skips
5, returns 10 and then finally stops.  In other words, this
gives 10 old commits counting from the 6th oldest one in the
history.

If we prefer the first semantics, we do not have to traverse and
grab everything.  That is what I was getting at.

That is, something like this, with your option parsing change
(modulo we _might_ want to explicitly mark some of the users
incompatible), addition of reverse field to struct rev_info,
moving reverse_commit_list() to a more public place, but without
making the reverse to imply limited traversal.

diff --git a/revision.c b/revision.c
index f2ddd95..161c4c0 100644
--- a/revision.c
+++ b/revision.c
@@ -1274,6 +1274,14 @@ struct commit *get_revision(struct rev_info *revs)
 {
 	struct commit *c = NULL;
 
+	if (revs->reverse) {
+		/* we were asked to reverse, but haven't reversed the
+		 * result, yet, so do it here once
+		 */
+		revs->commits = reverse_commit_list(revs->commits);
+		revs->reverse = 0;
+	}
+
 	if (0 < revs->skip_count) {
 		while ((c = get_revision_1(revs)) != NULL) {
 			if (revs->skip_count-- <= 0)
