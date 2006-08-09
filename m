From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH and RFC] gitweb: Remove --full-history from git_history
Date: Wed, 09 Aug 2006 14:42:13 -0700
Message-ID: <7vk65h1t8q.fsf@assigned-by-dhcp.cox.net>
References: <200608091257.19461.jnareb@gmail.com>
	<20060809192815.GA7954@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 09 23:42:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAvoi-0006b1-V1
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 23:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbWHIVmS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Aug 2006 17:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbWHIVmS
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Aug 2006 17:42:18 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:46840 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751382AbWHIVmR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Aug 2006 17:42:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060809214214.KNAZ554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 9 Aug 2006 17:42:14 -0400
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20060809192815.GA7954@c165.ib.student.liu.se> (Fredrik
	Kuivinen's message of "Wed, 9 Aug 2006 21:28:15 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25149>

Fredrik Kuivinen <freku045@student.liu.se> writes:

> I don't think it was dropped in favor --full-history.

Correct.

The --full-history option is about merge simplification and has
nothing to do with renames.

The thing is, your patch, while I very much liked the direction
it was taking us, was so intrusive that it scared the h*ck out
of me ;-).

>> What is needed by gitweb is for git-rev-list to not only follow revisions
>> of file contents across renames, and return more revisions, 
>
> Note that it is not enough to only return more revisions.
>
> For example, consider the commits (newest commit first)
> A: Rename "bar" to "foo"
> B: No changes to "bar"
> C: No changes to "bar", delete "foo"
> <more commits here>
>
> Then you want "git-rev-list --renames A -- foo" to return A,... not A,C,...

Yes.  For this "following renames for a single file" example, we
should not extend the pathspec which originally starts out as
"foo" to _include_ "bar"; instead it should _replace_, and after
that point we should not care about "foo".

This was another reason I shied away from your patch back then.
We would need to think about interactions between this pathspec
for a single file (which should be switched) and pathspecs for
directories ("more useful form of usage than single file", as
Linus would put it).

I have this vague feeling, without revisiting the code to make
an informed argument, that it might be cleaner and with less
impact (read: smaller chance to break the "directories" usage)
if we special case "follow a single file" case.  I dunno.

Also I was not sure how well your pathspec switching worked
across forks and merges.

                            M bar
           .----------------4------5
          /                         \
 A bar   /    R bar->foo  M foo      \     M foo
 0------1-----2-----------3-----------6----7-------8

Suppose we are at 8 and start digging for the history of "foo".
Our pathspec starts out as "foo" at 8 and stays so until we hit
6.  If the lower branch renamed bar->foo while the upper didn't,
and merge-recursive merged them correctly at 6, we would use
"foo" as pathspec while on the lower branch while traversing 6,
3 and 2 (at that point we switch to "bar").  On the upper
branch, we switch pathspec to "bar" while traversing 6, 5, 4.
When we hit 1, pathspec of both of its children (2 and 4) happen
to match in this example.  But what would we do if for some
reason they didn't?  Do we care?  Is that die("an internal
error")?  I did not have a good anser to that question, and I
still don't.
