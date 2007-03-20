From: Junio C Hamano <junkio@cox.net>
Subject: Re: git push to a non-bare repository
Date: Mon, 19 Mar 2007 17:49:30 -0700
Message-ID: <7vodmod9id.fsf@assigned-by-dhcp.cox.net>
References: <vpq648ye9w6.fsf@olympe.imag.fr>
	<20070319020053.GA11371@thunk.org>
	<7vr6rmm1y9.fsf@assigned-by-dhcp.cox.net>
	<20070319022143.GF20658@spearce.org>
	<20070319024744.GD11371@thunk.org>
	<20070319025603.GG20658@spearce.org>
	<20070319032130.GF11371@thunk.org>
	<20070319035351.GI20658@spearce.org> <45FF2393.6070700@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Theodore Tso <tytso@mit.edu>, git <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Tue Mar 20 01:49:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTSXg-0007VH-3K
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 01:49:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbXCTAtd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 20:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965582AbXCTAtd
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 20:49:33 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:45626 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964844AbXCTAtc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 20:49:32 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070320004932.CUDA2807.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Mon, 19 Mar 2007 20:49:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id copX1W0081kojtg0000000; Mon, 19 Mar 2007 20:49:31 -0400
In-Reply-To: <45FF2393.6070700@vilain.net> (Sam Vilain's message of "Tue, 20
	Mar 2007 11:58:11 +1200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42685>

Sam Vilain <sam@vilain.net> writes:

> Shawn O. Pearce wrote:
>> receive-pack isn't updating the HEAD reflog as its updating the
>> actual branch, not HEAD.  If you pushed instead to HEAD you should
>> see the HEAD reflog entry too.
>
> What about splitting HEAD when you push to the underlying branch, and
> making HEAD a non-symref?

I do not think any of the complication is needed, and I think
somebody mentioned a good example, which is a firewalled host
that can only be pushed into.  In that example, even though he
knows he could fetch in reverse direction in the ideal world,
the network configuration does not let him do so, hence need for
a push.

To deal with that sanely, people who push between non bare
repositories can just forget about pushing into branch heads.

Instead, they can arrange their pushes to be a true mirror image
of their fetch that they wish could do.  To illustrate:

On repo A that can only be pushed into, if you _could_ fetch
from repo B, you would:

	$ git fetch B

with something like this:

	[remote "B"] fetch = refs/heads/*:refs/remotes/B/*

But unfortunately because you can only push into A from B, you would
run this on B instead:

	$ git push A

with:

	[remote "A"] push = refs/heads/*:refs/remotes/B/*

And after you perform your push, you come to the machine with
repo A on it, and remembering that what you did was a mirror
image of "git fetch B", you would:

	$ git merge remotes/B/master

and you are done.

In other words, don't think of refs/remotes/B as something that
is for the use of "git fetch".  Its purpose is to track the
remote repository B's heads.  You maintain that hierarchy by
issuing fetch in repository A.  You can issue push in repository
B to do so as well.

I push into a live repository almost every day.  My typical day
concludes like this:

	gitster$ git push kernel-org-private
        gitster$ ssh kernel.org
        kernel.org$ git merge origin
        kernel.org$ Meta/Doit -pedantic &
        kernel.org$ exit
        ... go drink my tea ...

where

 (1) gitster is my private development machine
 (2) kernel.org is a machine made available to me by friendly
     k.org folks
 (3) Meta is a checkout of my 'todo' branch and 
 (4) Doit is a script to build all four public branches.

I always leave 'master' checked out on my kernel.org repository,
and the push from my private machine is done with (I still use
the non separate-remote layout):

	Push: refs/heads/master:refs/heads/origin
	Push: refs/heads/next:refs/heads/next
	Push: +refs/heads/pu:refs/heads/pu
	Push: refs/heads/maint:refs/heads/maint

So the first thing I do after logging in to kernel.org machine
is to run "git merge origin" to bring the 'master' up-to-date.
If you think of 'push' being mirror image of 'fetch' you would
understand why.  It is like issuing "git fetch" on kernel.org
machine to retrive the hot-off-the-press from my private machine
and then "git merge" it (usually "git pull" would do that as a
single step).

However, sometimes I accidentally leave 'next' checked out.  If
I find out that I left non 'master' checked out, I would do "git
reset --hard HEAD" before doing anything else, and I do not want
my push to sometimes result in detached HEAD and sometimes not.
I do not want to lose the information which branch I was on last
(because the next thing I would do is on which branch Meta/Doit
failed).  If I _were_ annoyed enough by sometimes mistakenly
pushing into the live branch, I would switch to separate remote
layout and push into remotes/origin/* hierarchy, and there will
be truly nothing to worry about after that point.
