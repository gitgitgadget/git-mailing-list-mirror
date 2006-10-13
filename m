From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-pickaxe: blame rewritten.
Date: Fri, 13 Oct 2006 13:31:35 -0700
Message-ID: <7vd58wc5zs.fsf@assigned-by-dhcp.cox.net>
References: <7v7iz5rk4b.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610120854440.3952@g5.osdl.org>
	<7viripnyfh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 13 22:31:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYTgy-0002uP-Bq
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 22:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882AbWJMUbh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Oct 2006 16:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751884AbWJMUbh
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Oct 2006 16:31:37 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:8943 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751882AbWJMUbg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Oct 2006 16:31:36 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061013203136.GGJN18985.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Fri, 13 Oct 2006 16:31:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ZwXe1V00q1kojtg0000000
	Fri, 13 Oct 2006 16:31:39 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7viripnyfh.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 12 Oct 2006 12:09:38 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28859>

Junio C Hamano <junkio@cox.net> writes:

>> (I'd actually also like to have a range-modifier, so that I could do
>>
>> 	git annotate --since=2.weeks.ago v2.6.18.. <path>
>>
>> that didn't go back beyond a certain point,...
>
> I am not sure about revision bottom (v.2.6.18..) offhand, but
> the age limit (--since=2.weeks) should be trivial.
>
> Inside pass_blame() while we iterate over the parents of the
> suspect we are looking at, you can skip the parent if it is
> older than the age limit, or an ancestor of revision bottom,
> like this:
>
> --- l/builtin-pickaxe.c
> +++ k/builtin-pickaxe.c
> @@ -450,6 +450,12 @@ static void pass_blame(struct scoreboard
>  	     parent = parent->next, parent_ix++) {
>  		if (parse_commit(parent->item))
>  			continue;
> +
> +		if (parent is older than age limit)
> +			continue;
> +		if (parent is an ancestor of revision bottom)
> +			continue;
> +
>  		porigin = find_origin(sb, parent->item, origin->path);
>  		if (!porigin)
>  			porigin = find_rename(sb, parent->item, origin);
>

This is not quite right.  The above code tries to avoid passing
blames to the boundary revisions, so "v2.6.18.." makes every old
line to be blamed on one revision after v2.6.18, which might be
technically correct but not what we want.

Instead, we should pass blame, and then prevent boundary
revisions to pass blame further down.  The code in "pu" today
has seen slight restructure of this part and this change should
be easier to implement there, something along the lines of...

--- l/builtin-pickaxe.c
+++ k/builtin-pickaxe.c
@@ -450,8 +450,7 @@ static int pass_blame_to_parent(struct s
 }
 
 #define MAXPARENT 16
-static void pass_blame(struct scoreboard *sb, struct origin *origin,
-		       struct rev_info *revs)
+static void pass_blame(struct scoreboard *sb, struct origin *origin)
 {
 	int i, parent_ix;
 	struct commit *commit = origin->commit;
@@ -469,10 +468,6 @@ static void pass_blame(struct scoreboard
 
 		if (parse_commit(p))
 			continue;
-		if (p->object.flags & UNINTERESTING)
-			continue;
-		if (revs->max_age != -1 && p->date  < revs->max_age)
-			continue;
 
 		porigin = find_origin(sb, parent->item, origin->path);
 		if (!porigin)
@@ -516,6 +511,7 @@ static void assign_blame(struct scoreboa
 	while (1) {
 		int i;
 		struct origin *suspect = NULL;
+		struct commit *commit;
 
 		/* find one suspect to break down */
 		for (i = 0; !suspect && i < sb->num_entries; i++) {
@@ -525,7 +521,10 @@ static void assign_blame(struct scoreboa
 		if (!suspect)
 			return; /* all done */
 
-		pass_blame(sb, suspect, revs);
+		commit = suspect->commit;
+		if (!(commit->object.flags & UNINTERESTING) &&
+		    !(revs->max_age != -1 && commit->date  < revs->max_age))
+			pass_blame(sb, suspect, revs);
 
 		/* Take responsibility for the remaining entries */
 		for (i = 0; i < sb->num_entries; i++)
