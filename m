From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Bisect: add checks at the beginning of "git bisect run".
Date: Wed, 28 Mar 2007 23:06:42 -0700
Message-ID: <7virck8txp.fsf@assigned-by-dhcp.cox.net>
References: <20070327064957.34dad72a.chriscool@tuxfamily.org>
	<200703280952.57058.chriscool@tuxfamily.org>
	<7vbqidls13.fsf@assigned-by-dhcp.cox.net>
	<200703290702.47972.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Mar 29 08:07:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWnmn-0006wF-Rs
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 08:07:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251AbXC2GGo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 02:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753185AbXC2GGn
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 02:06:43 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:64308 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753251AbXC2GGn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 02:06:43 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070329060642.PHKJ373.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Thu, 29 Mar 2007 02:06:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id gW6i1W00E1kojtg0000000; Thu, 29 Mar 2007 02:06:42 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43403>

Christian Couder <chriscool@tuxfamily.org> writes:

> So while we are at it, what about a new subcommand "git bisect test" that 
> could be used like this:

You are using it as a building block for nightly script, so
there are already certain logic around the call to "git bisect"
in your script.  I do not think we would necessarily want more
subcommands to "git bisect", unless the new subcommands truly is
generally applicable.

Unlike "run", "test" expects a workflow where there always is
one recent good_rev and there might be at most one single
breakage introduced since the last nightly build.  For that
particular use case, it might be handier to be able to write a
single line:

> git bisect test good_rev my_script

compared to:

> my_script || {
> 	git bisect start &&
> 	git bisect bad &&
> 	git bisect good good_rev &&
> 	git bisect run my_script
> }

but it is not useful for use case other than that.  Maybe we
already know more than one good commits that are on the side
branch to limit the bisect space in project specific way.

The thing is, the more you add policy to a building block, the
less generally useful the building block becomes.  The reason I
took "git bisect run" is because for the simplest use case, it
can be used without writing a specialized "run script" (you can
give "make test" to it, for example).  And more importantly, in
the case of "run", there is not much policy involved.  It is a
good command to have in a building block because what it does is
purely to automate what the user would perform mechanically by
hand anyway.  One thing I would want is to keep the bisect
subcommands to the minimum, so that people can easily use it as
a building block in their automation, without having to hunt
through many workflow-specific subcommands that do not suit
their particular needs.  Catering to their particular needs are
better handled in their scripts, including your "I have one
known good commit, I do not know if the tip is good, and I want
to dig down from the tip only when the tip is bad" case.

If you want to add value to bisect, here are two I can think of,
one almost trivial, and the other a bit harder.

(1) One bad commit is fundamentally needed for bisect to run,
    and if we beforehand know more good commits, we can narrow
    the bisect space down without doing the whole tree checkout
    every time we give good commits.  I think it may be a good
    idea to have:

	git bisect start [$bad [$good1 $good2...]] [-- <paths>...]

    as a short-hand for this command sequence:

	git bisect start
        git bisect bad $bad
        git bisect good $good1 $good2...

    That would be a good script-shorterner, without limiting it to
    any specific use scenario.

(2) There is no technical reason to have a good commit for
    bisect to run, other than you _often_ do not want the first
    mid-point checkout before you give good ones to it.  But
    sometimes, you may not know even if something _ever_ worked,
    IOW, even the root commit might not be good.  In such a
    case, being able to bisect having only one bad commit and no
    good commit would be handy.  For this, bisect_next_check
    needs to be tweaked.  Probably a transcript for such a
    feature would go like this:

	$ git bisect start
        $ git bisect bad HEAD
        $ git bisect next ; echo $?
        You need to give me at least one good and one bad revisions,
	with "git bisect good" and "git bisect bad".
	1
	$ git bisect next --without-good
	Bisecting: 4321 revisions left to test after this
	[deadcafedeadcafedeadcafedeadcafedeadcafe] an ancient commit
	$ git bisect bad
	Bisecting: 2152 revisions left to test after this
	[edeadcafedeadcafedeadcafedeadcafedeadcaf] a more ancient commit
