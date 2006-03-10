From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-rev-list bug?
Date: Fri, 10 Mar 2006 01:59:06 -0800
Message-ID: <7v4q26zklx.fsf@assigned-by-dhcp.cox.net>
References: <b0943d9e0603080819i227c637fo@mail.gmail.com>
	<7vacc0iten.fsf@assigned-by-dhcp.cox.net>
	<7vmzfy1zjb.fsf@assigned-by-dhcp.cox.net>
	<7virqmzlhb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Catalin Marinas" <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 10 10:59:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHeOv-0006l0-Pz
	for gcvg-git@gmane.org; Fri, 10 Mar 2006 10:59:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752195AbWCJJ7K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Mar 2006 04:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752200AbWCJJ7K
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Mar 2006 04:59:10 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:8383 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1752195AbWCJJ7J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Mar 2006 04:59:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060310095540.UBJO17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 10 Mar 2006 04:55:40 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7virqmzlhb.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 10 Mar 2006 01:40:16 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17466>

Junio C Hamano <junkio@cox.net> writes:

> I am wondering why try_to_simplify_commit() skips parents marked
> with UNINTERESTING.  I think this is causing a problem Catalin
> found with rev-list.
> ...
> The attached patch seems to fix it (without losing the logic to
> omit tree comparison with UNINTERESTING parent, which I do not
> quite understand).

Actually the previous patch is not right either.  If I ask "what
changes path B between commit#1..commit#4", it would still omit
commit#2.

It should not matter if the parent is uninteresting while
checking if a commit touches the specified path.  The attached
patch which replaces the previous botched one does exactly that.

It however has a side effect -- uninteresting commits were never
parsed here, but now they get parsed.  I am not sure if there
are correctness implications...

---
diff --git a/revision.c b/revision.c
index 713f27e..9d0934a 100644
--- a/revision.c
+++ b/revision.c
@@ -296,11 +296,6 @@ static void try_to_simplify_commit(struc
 	while ((parent = *pp) != NULL) {
 		struct commit *p = parent->item;
 
-		if (p->object.flags & UNINTERESTING) {
-			pp = &parent->next;
-			continue;
-		}
-
 		parse_commit(p);
 		switch (compare_tree(p->tree, commit->tree)) {
 		case TREE_SAME:
