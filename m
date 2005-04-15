From: Junio C Hamano <junkio@cox.net>
Subject: Re: Merge with git-pasky II.
Date: Fri, 15 Apr 2005 15:41:07 -0700
Message-ID: <7vvf6nfyt8.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org>
	<7v64ypsqev.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
	<7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net>
	<20050414121624.GZ25711@pasky.ji.cz>
	<7vll7lqlbg.fsf@assigned-by-dhcp.cox.net>
	<20050414193507.GA22699@pasky.ji.cz>
	<7vmzs1osv1.fsf@assigned-by-dhcp.cox.net>
	<20050414233159.GX22699@pasky.ji.cz>
	<7vwtr4ibkt.fsf@assigned-by-dhcp.cox.net>
	<20050415204033.GG7417@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 00:38:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMZRU-0002I7-4p
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 00:37:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbVDOWlN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 18:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbVDOWlN
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 18:41:13 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:5059 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261992AbVDOWlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2005 18:41:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050415224108.OHWI2123.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 15 Apr 2005 18:41:08 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050415204033.GG7417@pasky.ji.cz> (Petr Baudis's message of
 "Fri, 15 Apr 2005 22:40:33 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

PB> I can't see the conflicts between what I want and what Linus wants.
PB> After all, Linus says that I can use the directory cache in any way I
PB> please (well, the user can, but I'm speaking for him ;-). So I'm doing
PB> so, and with your tool I would get into problems, since it is suddenly
PB> imposing a policy on what should be in the index.

I think our misunderstanding is coming from the use of the word
"merge tree".  I think you have been assuming that I wanted you
to run "merge-trees -o ,,merge" --- which would certainly cause
me to muck with your dircache there.  I totally agree with you
that that is a *BAD* *THING*.  No question there.

However, my assumption has been different.  I was assuming that
you would run "merge-trees -o merge~tree" (i.e. different from
your "merge tree"), so that you can get the merge results in a
form parsable by you.  And then, using that information, you can
make your changes in ,,merge.  After you are done with that
information, you can remove "merge~trees", of course.

The format I chose for the "merge result in a form parsable by
you" happens to be a dircache in "merge~tree", with minimum
number of files checked out when merge cannot be automatically
done safely.  In the simplest case of not having any conflicting
merge between $C and $merged, Cogito can immediately run
write-tree in "merge~tree" (not ,,merge) to obtain its tree-ID
$T, so that it can feed it to diff-tree to compare it with
whatever tree state Cogito wants to apply the merges between $C
and $merged to.

I still do not understand what you do in ,,merge directory, but
here is one way you can update the user working directory
in-place without having a ,,merge directory [*2*].  You can run
your "git diff" between $C and $T [*1*].  The result is the diff
you need to apply on top of your user's working files.  If the
user does not like the result of running that diff, it can
easily be reversed.

If a manual merge were needed between $C and $merged, Cogito
could guide the user through that manual edit in "merge~tree",
and run update-cache on those hand merged files in "merge~tree",
before running write-tree in "merge~tree" to obtain $T; after
that, everything else is the same.

You make interesting points in other parts of your message I
need to regurgitate for a while, so I would not comment on them
in this message.

[Footnote]

*1* I really like the convenience of being able to use tree-ID
and commit-ID interchangeably there.  Thanks.

*2* I understand that this would change the user's "git-tools"
experience a bit.  The user will not be told to "go to ,,merge
and commit there which will reflected back to your working tree"
anymore.  Instead the merge happens in-place.  Committing, not
committing, or further hand-fixing the merge is up to the user.
I suspect this change might even be for the better.

