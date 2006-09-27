From: Junio C Hamano <junkio@cox.net>
Subject: Re: git and time
Date: Tue, 26 Sep 2006 18:11:02 -0700
Message-ID: <7vodt2nmft.fsf@assigned-by-dhcp.cox.net>
References: <20060926233321.GA17084@coredump.intra.peff.net>
	<20060927002745.15344.qmail@web51005.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 27 03:11:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSNx8-0004Ik-BR
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 03:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbWI0BLH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 21:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbWI0BLH
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 21:11:07 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:30427 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932201AbWI0BLE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 21:11:04 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060927011103.DCFY26416.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Tue, 26 Sep 2006 21:11:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id TDB01V0051kojtg0000000
	Tue, 26 Sep 2006 21:11:00 -0400
To: Matthew L Foster <mfoster167@yahoo.com>
In-Reply-To: <20060927002745.15344.qmail@web51005.mail.yahoo.com> (Matthew
	L. Foster's message of "Tue, 26 Sep 2006 17:27:45 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27845>

Matthew L Foster <mfoster167@yahoo.com> writes:

>> PS Nit: Git doesn't work with changesets, it works with snapshots,
>> building a directed graph of snapshots. Maybe that is the source of your
>> confusion
>
> It's true I don't know much about git, what is the difference
> between a changeset and a snapshot?  Are you saying timestamps
> should be tracked separately or tracked by an scm system built
> on top of git? Does/should git care about the when of a
> snapshot?

I do not know what Jeff meant by snapshot vs changeset, so I
would not comment on this part.

> Perhaps my question is directed more toward gitweb.cgi, it
> seems to me the timestamp of when a snapshot was merged into
> this repository should somehow be tracked and that is what
> gitweb.cgi should default to display. For example, if someone
> wants to know if security bugfix X was merged into linus'
> kernel tree they also want to know when that happened, don't
> they?

Each commit object in git records two timestamps.  When the
author made that change, and when the change was made into a
commit object in _some_ repository.  I _think_ gitweb shows the
latter, but I haven't checked, so Jakub is CC'ed.

What you want to know, when a particular change has become part
of the history of one branch in one repository, is not something
a git commit object records.  Enough people wanted to know that
information, so ref-log was introduced.  When it is enabled on a
branch, ref-log records when the tip of the branch changed from
what commit to what other commit.  But it primarily is meant to
answer this question: "what commit was at the tip of this branch
at time T?"

So if Linus had enabled ref-log in his public repository, and if
gitweb knew to look at ref-log, then gitweb _could_ iterate over
ref-log records for the "master" branch of Linus's repository,
find the earliest one that makes the tip of the "master" branch
a descendant of that security fix X, and report the time of that
change.  It could certainly do that.

I have to warn you that this is fairly expensive, and also I
happen to know that Linus does not have ref-log enabled on his
public repository.

Having said that, I doubt the question "when did Linus's tree
saw this security fix X commit?" has much practical value.  For
one thing, the time he merges the side branch that has the
security fix and the time he pushes out the resulting mess^Wtree
out to the public repository is different.  After pushed out to
the public repository, it takes time for that to mirror out for
public view.  From the consumer's point of view, the time it
finishes mirroring out _is_ the only timestamp that matters, but
that mirroing happens outside of git so even if ref-log showed
timestamp from the repository Linus pushes to, it would not
reflect the time the general public first saw "Linus's official
version that contained that fix".

What people would often want to know is "Does v2.6.18-rc5
include that fix?" which is a similar but different question.
This is something gitweb _could_ answer without using ref-log,
and gitk already knows how to answer it.

I somehow thought that it was possible to get "the latest tag
that precedes this commit" (aka "git describe") for each commit
by visiting its commitdiff_plain page, but I do not see it now.
Can somebody tell me if I am hallucinating?
