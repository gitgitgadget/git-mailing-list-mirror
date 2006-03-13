From: Junio C Hamano <junkio@cox.net>
Subject: Re: Possible --remove-empty bug
Date: Sun, 12 Mar 2006 17:08:58 -0800
Message-ID: <7vlkvfw3px.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550603120612k555fc7f3v9d8d17b1bd0b9e41@mail.gmail.com>
	<7vk6azz6xx.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603121450210.3618@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marco Costalba <mcostalba@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 13 02:09:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIbYb-0008Qz-Co
	for gcvg-git@gmane.org; Mon, 13 Mar 2006 02:09:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbWCMBJF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Mar 2006 20:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWCMBJF
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Mar 2006 20:09:05 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:24061 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932315AbWCMBJE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Mar 2006 20:09:04 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060313010457.LTGW20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 12 Mar 2006 20:04:57 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17531>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sun, 12 Mar 2006, Junio C Hamano wrote:
>> 
>> To be honest, I do not know how --remove-empty is intended to
>> work.
>
> It's supposed to stop traversing the tree once a pathname disappears.

Then what we should simplify is the parent commit that does not
have those pathnames (i.e. remove parents from that parent
commit).  In other words, currently the code removes the parent
commit that makes the tree disappear, but we would want to keep
that parent, remove the grandparents, and then mark the parent
uninteresting.

-- >8 --
[PATCH] revision traversal: --remove-empty fix (take #2).

Marco Costalba reports that --remove-empty omits the commit that
created paths we are interested in.  try_to_simplify_commit()
logic was dropping a parent we introduced those paths against,
which I think is not what we meant.  Instead, this makes such
parent parentless.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

diff --git a/revision.c b/revision.c
index c8d93ff..73fba5d 100644
--- a/revision.c
+++ b/revision.c
@@ -315,9 +315,18 @@ static void try_to_simplify_commit(struc
 			return;
 
 		case TREE_NEW:
-			if (revs->remove_empty_trees && same_tree_as_empty(p->tree)) {
-				*pp = parent->next;
-				continue;
+			if (revs->remove_empty_trees &&
+			    same_tree_as_empty(p->tree)) {
+				/* We are adding all the specified
+				 * paths from this parent, so the
+				 * history beyond this parent is not
+				 * interesting.  Remove its parents
+				 * (they are grandparents for us).
+				 * IOW, we pretend this parent is a
+				 * "root" commit.
+				 */
+				parse_commit(p);
+				p->parents = NULL;
 			}
 		/* fallthrough */
 		case TREE_DIFFERENT:
