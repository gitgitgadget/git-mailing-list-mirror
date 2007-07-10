From: Junio C Hamano <gitster@pobox.com>
Subject: Re: how to combine two clones in a collection
Date: Tue, 10 Jul 2007 00:17:33 -0700
Message-ID: <7v3azwsp6a.fsf@assigned-by-dhcp.cox.net>
References: <20070709222250.GA8007@piper.oerlikon.madduck.net>
	<alpine.LFD.0.999.0707091923300.3412@woody.linux-foundation.org>
	<20070710062104.GA22603@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Tue Jul 10 09:17:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I89yh-0003AW-Rp
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 09:17:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754715AbXGJHRg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 03:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752107AbXGJHRg
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 03:17:36 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:57892 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769AbXGJHRf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 03:17:35 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070710071733.BMMW22777.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Tue, 10 Jul 2007 03:17:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id MjHa1X0041kojtg0000000; Tue, 10 Jul 2007 03:17:34 -0400
In-Reply-To: <20070710062104.GA22603@piper.oerlikon.madduck.net> (martin
	f. krafft's message of "Tue, 10 Jul 2007 08:21:04 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52049>

martin f krafft <madduck@madduck.net> writes:

> Thanks, Linus, for your time in answering my questions. I have some
> more comments and questions in reply. I hope I am coherent enough,
> this subject matter doesn't exactly flow off my tongue with ease
> yet...
>
> also sprach Linus Torvalds <torvalds@linux-foundation.org> [2007.07.10.0435 +0200]:
>> I really _think_ that what you want is to just use separate
>> branches, if I understand correctly. That makes it really easy to
>> just have both lines of development (both the "trunk" and your
>> "debian" one) in one git repository.
>
> It does mean, however, that I duplicate the upstream into my repo,
> and thus into the published repo at git.debian.org, because I cannot
> just publish a single branch ('debian') in such a way that people
> could clone it and still be able to build the package against
> upstream (which they'd have to obtain for themselves), right?

I've seen two kinds of debianized source tree.  One kind has
changes already applied to the pristine source outside debian/
subdirectory, and debian/rules does the debian specific
customized build, install and packaging.  The other kind does
not have _any_ change to the pristine except it has debian/
subdirectory and the first thing debian/rules does is to apply
patches to pristine from patch files kept in debian/
subdirectory.  The answer largely depends on which arrangement
you have in mind for your package.

For the former kind, It is unavoidable for people to get your
(slightly modified) upstream source from you --- there is
nowhere else that stores what you changed.  Extracting the
vanilla pristine and debian/ separately would not cut it.  For
such an arrangement, "upstream" (or "pristine") branch would
contain everything you get from your upstream tarball (or SVN)
without any of Debianization changes (you can still have generic
"fixes and enhancements" of your own there to be fed upstream).
Your "master" (you could call it "debianization") branch will
fork off of that branch, and the first commit on that branch
would add debian/ subdirectory.  All the debianization
modification to the upstream, if needed, also go to this branch.
Your users will clone and pull from your "master" and do
"fakeroot debian/rules binary" or whatever, and all is good.

For the latter, since the changes from upstream is isolated to
your additional debian/ subdirectory, you could arrange your
repository like this, even without using the subproject support:

	.git/
        .gitignore (perhaps untracked)
        Makefile (upstream)
        foo.c (upstream)
        ...
        debian/.git
        debian/rules (yours)
        debian/control (yours)
        ...

Then, have the top-level .git/ repository control pristine
upstream sources from SVN (you may want to add .gitignore to
ignore debian/ subdirectory).  In debian/, you create another
independent repository, and maintain _ONLY_ debianization.  You
could even publish only that repository to your users without
publishing the upstream sources, if they know which version of
upstream source to use.

I tend to prefer the former, from the end user's point of view.
