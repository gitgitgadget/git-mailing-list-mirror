From: Junio C Hamano <junkio@cox.net>
Subject: Re: [BUG] git-new-workdir doesn't understand packed refs
Date: Wed, 18 Apr 2007 11:42:24 -0700
Message-ID: <7v647th6cv.fsf@assigned-by-dhcp.cox.net>
References: <20070417161720.GA3930@xp.machine.xx>
	<Pine.LNX.4.64.0704172253140.14155@beast.quantumfyre.co.uk>
	<20070418055215.GA32634@xp.machine.xx>
	<7v7isajfl1.fsf@assigned-by-dhcp.cox.net>
	<20070418081122.GB32634@xp.machine.xx>
	<Pine.LNX.4.64.0704181251040.19261@reaper.quantumfyre.co.uk>
	<7vfy6xird9.fsf@assigned-by-dhcp.cox.net>
	<20070418174350.GB5913@xp.machine.xx>
	<7vlkgph7i0.fsf@assigned-by-dhcp.cox.net>
	<20070418183156.GF5913@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Julian Phillips <julian@quantumfyre.co.uk>
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 18 20:42:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeF6r-0003Qy-Gw
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 20:42:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993004AbXDRSm0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 14:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993007AbXDRSm0
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 14:42:26 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:62327 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993004AbXDRSmZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 14:42:25 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070418184225.GOQN1235.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 18 Apr 2007 14:42:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id oiiQ1W00c1kojtg0000000; Wed, 18 Apr 2007 14:42:25 -0400
cc: git@vger.kernel.org
In-Reply-To: <20070418183156.GF5913@xp.machine.xx> (Peter Baumann's message of
	"Wed, 18 Apr 2007 20:31:56 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44927>

Peter Baumann <waste.manager@gmx.de> writes:

<ot>

Getting more and more annoyed by your stupid Mail-Followup-To...
I do *not* want to bother Julian with a message that points out
a flaw (in my opinion) in YOUR reasoning but you are forcing me
to send my message that way, which I have to waste time
correcting every time.  Grumble.

</ot>

> On Wed, Apr 18, 2007 at 11:17:43AM -0700, Junio C Hamano wrote:
>> Peter Baumann <waste.manager@gmx.de> writes:
>> ...
>> > I thought about the case where packed-refs is a symlink to another symlink
>> > and then decided that it's not worth to implement this because a workdir
>> > should be linked to a _repo_ and not another workdir.
>> 
>> That's incredibly weak, as the initial motivation of this patch
>> is that you did not want to say "you should run gc only in the
>> _repo_ not in workdir".
>
> Yes. That's my motivation and it works right now
>
> 	git init a
> 	<hack, hack, hack,>
> 	git commit -a
>
> 	git-new-workdir a b 	# allowed
> 	git-new-workdir a c	# allowed
>
> 	git-new-workdir b d	# NOT ALLOWED

But I do not think you are disallowing it; instead you are
making the same problem appear without telling the user.

Also, how is the above different from this?

	git init a
        cd a ; git gc ; cd ..	# allowed
	git new-workdir a b
	cd b ; git gc ; cd ..	# NOT ALLOWED

You are saying "you should run workdir only in the _repo_ not in
workdir".

As I already said, certain things work differently between a
proper repository and a worktree that borrows .git/refs from a
proper repository, and you always have to know what you are
doing when you use such a setup.  If your goal is to minimize
the difference, I do not think it makes much sense to allow gc
and not allow new-workdir.

On the other hand, if we admit that things work differently, I
think erroring out gc or pack-refs when we see .git/packed-refs
is a symbolic link is much simpler, less error prone and easier
to explain.
