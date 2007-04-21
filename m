From: Junio C Hamano <junkio@cox.net>
Subject: Automated bisect success story
Date: Sat, 21 Apr 2007 13:36:06 -0700
Message-ID: <7vps5xsbwp.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vps5ywouw.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0704201823310.9964@woody.linux-foundation.org>
	<alpine.LFD.0.98.0704201826350.9964@woody.linux-foundation.org>
	<7v7is6wjx6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 21 22:36:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfMJh-0003cB-0Q
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 22:36:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658AbXDUUgJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 16:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752848AbXDUUgI
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 16:36:08 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:42662 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752658AbXDUUgH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 16:36:07 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070421203607.LAQ1268.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sat, 21 Apr 2007 16:36:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id pwc61W00a1kojtg0000000; Sat, 21 Apr 2007 16:36:07 -0400
In-Reply-To: <7v7is6wjx6.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 20 Apr 2007 19:17:09 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45195>

Learning from example by Steven Grimm, let me share a success
story.

Earlier I noticed that "fsck --full" from 'master' took forever
in linux-2.6 repository, but the one from 'maint' finished in 2
to 3 minutes.

We recently had a few enhancements by Christian Couder to
git-bisect, and this was a perfect opportunity to see how well
they worked:

(1) "git bisect start" now takes one bad and then one or more
    good commits, before suggesting the first revision to try.

Traditionally, immediately after you gave a bad and a good
commit, it did a single bisection and then a checkout.  This
avoids repeated bisect computation and checkout when you know
more than one good revisions before starting to bisect, and also
let you bootstrap with a single command (you could instead give
one good commit at a time and then finally a single bad commit
to avoid the waste).

Not only I know 'maint' is good, I also know that the tips of
"foreign projects" merged to git.git, that do not share any
codepath the fsck takes, are irrelevant to the problem.  So I
want to mark tips of commit ancestry I merged from git-gui
projects as good.  Hence:

	$ git bisect start master maint remotes/git-gui/master

Mnemonic.  Start takes a Bad before Goods, because B comes
before G.

(2) "git bisect run <script>" takes a script to judge the
    goodness of the given revision.  Because I know each round
    of test takes around 3 minutes, I wrote a little script to
    automate the process and gave it to "git bisect run":

	$ git bisect run ./+run-script

This ran for a while (I do not know how long it took -- I was
away from the machine and doing other things) and came back with
the "object decoration" one Linus has fixed yesterday with his
patch.

Here is the "+run-script".  I have git.git repository and
linux-2.6 repository next to each other.

-- >8 --
#!/bin/sh

# Build errors are not what I am interested in.
make git-fsck && cd ../linux-2.6 || exit 255

# We are checking if it stops in a reasonable amount of time, so
# let it run in the background...

../git.git/git-fsck --full >:log 2>&1 &

# ... and grab its process ID.
fsck=$!

# ... and then wait for sufficiently long.
sleep 240

# ... and then see if the process is still there.
if kill -0 $fsck
then
	# It is still running -- that is bad.
        # Three-kill is just a ritual and has no real meaning.
        # It is like "sync;sync;sync;reboot".
	kill $fsck; sleep 1; kill $fsck; sleep 1; kill $fsck;
	exit 1
else
	# It has already finished (the $fsck process was no more),
        # and we are happy.
	exit 0
fi
