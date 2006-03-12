From: Junio C Hamano <junkio@cox.net>
Subject: Re: Possible --remove-empty bug
Date: Sun, 12 Mar 2006 13:31:06 -0800
Message-ID: <7vk6azz6xx.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550603120612k555fc7f3v9d8d17b1bd0b9e41@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Mar 12 22:56:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIY9l-0006MY-9T
	for gcvg-git@gmane.org; Sun, 12 Mar 2006 22:31:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbWCLVbK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Mar 2006 16:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbWCLVbK
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Mar 2006 16:31:10 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:41349 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932220AbWCLVbI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Mar 2006 16:31:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060312212919.GNFF6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 12 Mar 2006 16:29:19 -0500
To: "Marco Costalba" <mcostalba@gmail.com>
In-Reply-To: <e5bfff550603120612k555fc7f3v9d8d17b1bd0b9e41@mail.gmail.com>
	(Marco Costalba's message of "Sun, 12 Mar 2006 15:12:12 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17527>

"Marco Costalba" <mcostalba@gmail.com> writes:

>>>From git-rev-list documentation:
>
> --remove-empty::
> 	Stop when a given path disappears from the tree.
>
> But isn't it to be intended *after* a path disapperas from the tree?

To be honest, I do not know how --remove-empty is intended to
work.  What revision traversal code does and what the above says
are different.

The traversal code goes like this:

	* Start from given commits (both interesting and
          uninteresting), look at still-to-be-procesed commit
          one by one, by calling add_parents_to_list().

          * add_parents_to_list() grows still-to-be-processed
            list; if the current commit is uninteresting, mark its
            parents also uninteresting, and if no interesting
            commit remains in the still-to-be-processed list, we
            are done.  On the other hand, if the current commit is
            interesting, place it to the list of results.

        * After the above traversal is done, the consumer calls
	  get_revision() to retrieve commits from the list of
	  results one-by-one.  We return only interesting ones.

And in add_parents_to_list()

	* if the commit is interesting, and when we are limiting
          by paths, we call try_to_simplify_commit().  This
          checks if the tree associated with the current commit
          is the same as one of its parents' with respect to
          specified paths, and if so pretend that the current
          commit has only that parent and no other.  This can
          make a merge commit to lose other parents that we do
          not inherit the specified paths from.

        * try_to_simplify_commit() looks at each parent, and:

          - if we find a parent that has the same tree (wrt the
            paths we are interested in), we pretend it is the
            sole parent of this commit.

	  - if we find a parent that does not have any of the
            specified paths, we pretend we do not have that
            parent under --remove-empty.

	  - otherwise we do not munge the list of parents.

My understanding of what the code is doing from the above
reading is to lose that empty parent, and it does not have much
to do with stop traversing the ancestry chain at such commit.  I
am not sure that is what was intended...

Maybe something like this is closer to what the documentation
says.

-- >8 --
diff --git a/revision.c b/revision.c
index c8d93ff..03085ff 100644
--- a/revision.c
+++ b/revision.c
@@ -315,9 +315,14 @@ static void try_to_simplify_commit(struc
 			return;
 
 		case TREE_NEW:
-			if (revs->remove_empty_trees && same_tree_as_empty(p->tree)) {
-				*pp = parent->next;
-				continue;
+			if (revs->remove_empty_trees &&
+			    same_tree_as_empty(p->tree)) {
+				/* We are adding all the specified paths from
+				 * this parent, so the parents of it is
+				 * not interesting, but the difference between
+				 * this parent and us still is interesting.
+				 */
+				p->object.flags |= UNINTERESTING;
 			}
 		/* fallthrough */
 		case TREE_DIFFERENT:
