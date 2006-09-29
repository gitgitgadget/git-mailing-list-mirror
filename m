From: Junio C Hamano <junkio@cox.net>
Subject: Re: git and time
Date: Thu, 28 Sep 2006 19:28:05 -0700
Message-ID: <7virj7qudm.fsf@assigned-by-dhcp.cox.net>
References: <20060929002748.GA11055@thunk.org>
	<20060929014430.44203.qmail@web51006.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 29 04:28:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT86r-0006QV-Ud
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 04:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161270AbWI2C2K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 22:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161275AbWI2C2K
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 22:28:10 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:31401 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1161270AbWI2C2H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 22:28:07 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060929022806.JFCR13992.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Thu, 28 Sep 2006 22:28:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id U2U81V00a1kojtg0000000
	Thu, 28 Sep 2006 22:28:08 -0400
To: Matthew L Foster <mfoster167@yahoo.com>
In-Reply-To: <20060929014430.44203.qmail@web51006.mail.yahoo.com> (Matthew
	L. Foster's message of "Thu, 28 Sep 2006 18:44:30 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28082>

Matthew L Foster <mfoster167@yahoo.com> writes:

> Ok, I was wondering about that. In your example above the
> internally unnecessary timestamp will be from Linus' private
> repo, not master.kernel.org's?

Yes, and it is stronger than that.  If somebody did a sata
patch, sent that to Jeff over e-mail, and if the patch was
accepted, Jeff will make a commit in his private repository,
recording local time on his machine.  Later Linus may pull from
Jeff and the commit object is transferred during that.

To Linus, the time he first saw the commit was the time he
pulled from Jeff, so being able to tell when it came into his
repository may help him if he pulled from other people too and
then suddenly realizes his sata disk does not respond at all.

He COULD say "it was working yesterday, I pulled from Jeff 3
hours ago, and then David 2 hours ago, I did not do my own
development during that time.  Did the breakage come when I
pulled from Jeff or when I pulled from David?"  ref-log would
let him do something like:

	git checkout -b trythis master@{4.hours.ago}

to make sure the state before he pulled from Jeff was a working
state and then still on the trythis branch he cuold do

	git reset --hard master@{2.hours.30.minutes.ago}

to see if the state after he pulled from Jeff was broken.

	Side note: in reality he does not have to care.  He can
	just bisect it without using any of his "pull boundary"
	time.

So that was discussion about the time Linus first saw the
commit.  What about us, general public?  Until Linus pushes out
the merge result, we would not see it.  Anyway, eventually he
will push his tip of the branch out to kernel.org and rsync will
mirror to public git:// and gitweb machines.

What's the local time the general public sees the commit for the
first time?  It's (forgetting for now the rsync mirroring delay)
the time Linus pushed the tip of the branch out.  Along with all
other hundreds of commits he acquired since the last time he
pushed his tree out.

It is sometimes useful to know when a particular commit has
become available to the general public.  I do not think anybody
is denying it.

But it is a completely separate issue if it is useful to label
the commits that happened to be pushed out together at the same
time with the same timestamp on the gitweb short-log page (or
short-log corner on the summary page).  Most of the time you
will see commits pushed out by the same push operation and
having exactly the same timestamp.  That's not very useful way
to present the information.

	Side note: some commits arrive kernel.org machine
	earlier than others because Linus does not have infinite
	bandwidth to kernel.org, but these hundreds of commits
	become visible to the general public exactly the same
	time, because we send them and as the last operation we
	update the tip of the branch.  So you cannot even say
	"record the time down to the second they arrived the
	kernel.org repository" -- until the branch tip is
	updated the general public cannot see them so the
	arrival time (mtime of .git/objects/??/???...?? files)
	does not even matter.

If somebody feels strongly about it, I would suggest adding that
information on the commit page of gitweb, where the program
needs to deal with only one commit.  That would help somebody
who is interested in _one_ particular commit and wants to know
when it has become available to the general public.

-
