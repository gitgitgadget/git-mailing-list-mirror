From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-pickaxe: blame rewritten.
Date: Thu, 12 Oct 2006 12:09:38 -0700
Message-ID: <7viripnyfh.fsf@assigned-by-dhcp.cox.net>
References: <7v7iz5rk4b.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610120854440.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 12 22:23:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GY5w9-0005lR-Hq
	for gcvg-git@gmane.org; Thu, 12 Oct 2006 21:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWJLTJl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 15:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbWJLTJl
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 15:09:41 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:61434 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751148AbWJLTJj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Oct 2006 15:09:39 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061012190939.RSVP13992.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Thu, 12 Oct 2006 15:09:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ZX9U1V00C1kojtg0000000
	Thu, 12 Oct 2006 15:09:28 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610120854440.3952@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 12 Oct 2006 08:58:54 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28794>

Linus Torvalds <torvalds@osdl.org> writes:

> Btw, could we please get rid of this horrible command line syntax.
>
> Pretty much _every_ other git command takes the form
>
> 	git cmd [<rev>] [--] <path>
>
> but for some reason annotate and blame (and now pickaxe) do it the wrong 
> way around, and do
>
> 	git cmd [--] <path> [<rev>]
>
> which is just irritating to somebody who has grown very used to being able 
> to specify revisions first.

Side note: I do not intend to keep it named pickaxe -- only
while it is in "pu".

I think we could support all of them to retain backward
compatibility:

	git blame [-options] <path> [<rev>]		(*1*)
	git blame [-options] -- <path> [<rev>]		(*2*)
	git blame [-options] [<rev>] [--] <path>	(*3*)

(*1*) Only for path that does not start with a '-'; we should
      tighten the input to make sure <path> lstat()'s fine
      (which we currently do with pickaxe), <path> cannot be
      interpreted as a valud rev, and when <rev> is given, <rev>
      does not lstat() Ok, to avoid ambiguity.  Other cases we
      should require the newer format with explicit -- (*3*).

(*2*) Backward compatible canoncal format.  The above comment
      for validation does not apply, as (*3*) never has more
      than one path for 'annotate/blame/pickaxe'

(*3*) The canonical format for ohter git commands.  Without
      an explicit --, <rev> should not lstat() Ok, and <path>
      should, to avoid ambiguity.

> (I'd actually also like to have a range-modifier, so that I could do
>
> 	git annotate --since=2.weeks.ago v2.6.18.. <path>
>
> that didn't go back beyond a certain point,...

I am not sure about revision bottom (v.2.6.18..) offhand, but
the age limit (--since=2.weeks) should be trivial.

Inside pass_blame() while we iterate over the parents of the
suspect we are looking at, you can skip the parent if it is
older than the age limit, or an ancestor of revision bottom,
like this:

--- l/builtin-pickaxe.c
+++ k/builtin-pickaxe.c
@@ -450,6 +450,12 @@ static void pass_blame(struct scoreboard
 	     parent = parent->next, parent_ix++) {
 		if (parse_commit(parent->item))
 			continue;
+
+		if (parent is older than age limit)
+			continue;
+		if (parent is an ancestor of revision bottom)
+			continue;
+
 		porigin = find_origin(sb, parent->item, origin->path);
 		if (!porigin)
 			porigin = find_rename(sb, parent->item, origin);


I think we can get away by checking if the parent _is_ the
revision bottom (or one of the bottoms, if you say "--not
v2.6.18 v2.6.17.13") instead of doing "is it an ancestor" check,
in practice.  But that is not correct when a merge is involved.
