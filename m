From: Junio C Hamano <junkio@cox.net>
Subject: Re: confusion over the new branch and merge config
Date: Tue, 02 Jan 2007 12:04:33 -0800
Message-ID: <7v1wmdure6.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0612211555210.18171@xanadu.home>
	<7vd56cam66.fsf@assigned-by-dhcp.cox.net>
	<20061223051210.GA29814@segfault.peff.net>
	<7vbqlvuoi4.fsf@assigned-by-dhcp.cox.net>
	<7vbqlvrldk.fsf@assigned-by-dhcp.cox.net>
	<20070102144940.GA23932@coredump.intra.peff.net>
	<7vps9xwd01.fsf@assigned-by-dhcp.cox.net>
	<20070102173410.GA25325@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 02 21:04:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1psF-0002Uj-2v
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 21:04:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754850AbXABUEg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 15:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754861AbXABUEg
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 15:04:36 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:34428 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754851AbXABUEf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 15:04:35 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070102200434.WVTS7494.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Tue, 2 Jan 2007 15:04:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 6L3m1W00h1kojtg0000000; Tue, 02 Jan 2007 15:03:47 -0500
To: Jeff King <peff@peff.net>
In-Reply-To: <20070102173410.GA25325@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 2 Jan 2007 12:34:11 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35810>

Jeff King <peff@peff.net> writes:

> On Tue, Jan 02, 2007 at 09:32:30AM -0800, Junio C Hamano wrote:
>
>> If we are to worry about, and I think we might have to, I think
>> not worrying about mergelocal and not accepting the name of
>> local tracking branch is the only sensible thing to do.
>
> Sorry, I don't see the problem with mergelocal. Can you elaborate?

I might have misread what you meant by mergeLocal, and you might
be trying to introduce a default for "git merge" so that without
anything on the command line "git merge" would merge something
locally available depending on which branch you are on.

But I did not think of that, and thought you were saying "look
at branch.*.mergelocal (if exists) in the same place we look at
branch.*.merge in the current code, and just like the latter is
used to match up with the remote refname we just fetched, use
the former to match the local tracking branches, to decide what
to merge".  And if that is what you meant by mergelocal, I do
not see much advantage in that approach -- that is what I meant
in the response.  The remote name is available whether you use
tracking branches locally or not, so using that to specify the
merge operation that happens after a 'pull' is more consistent,
less confusing, and matches the long-hand "git pull $URL
remote-branch" a lot better than having another configuration
that can be used only half the time.

Some people repeatedly argued that remote branch names do not
matter.  I think they are wrong and are missing the point of
distributedness of git.  You are fetching from there, so you
need to know the name the other end gives them in the first
place.  But much more importantly, the fact you are fetching
from there means some other people could also be fetching from
the same place.  Now how would you discuss what that common
repository recently placed on that branch?  You would not use
the local tracking branch name which _is_ meaningless to the
other person.  You use the remote name.

For example, I have a separate repository (that happens to be
checked out in Meta/ subdirectory of my main working area, so
its control files are in Meta/.git repository) to keep things
that I push to my 'todo' branch.  After I push the updates to
'todo' out to kernel.org from that repository, I usually fetch
from kernel.org into that repository, so that I can later see up
to which one I have already pushed out.  I am old fashioned and
still use remotes and non 'separate-remote' layout for this:

	URL: kernel.org:/pub/scm/git/git.git
        Push: refs/heads/master:refs/heads/todo
        Pull: refs/heads/todo:refs/heads/ko

As you can see from the above, my 'ko' is the local tracking
branch, and 'master' in that repository is what is known as
'todo' to the public.  But when I talk about what I have in that
branch, I would never say 'master' nor 'ko' -- people would not
care how I call that branch locally in my private repository.
What's private is private and does not matter to others.
Instead I would say something like "my 'todo' branch has drafts
for v1.5.0 release notes these days".

What does this all mean?  It means that remote branch names
matter more when you are talking about external communication.
And "git pull" (more so for "git fetch") is all about external
communication.

Obviously, the local names should matter more when you are doing
local operations.  So if you are using mergeLocal to give a
shorthand to "git merge" that does not explicitly say what to
merge, the above discussion does not apply.  But if that is the
case, mergeLocal should also not affect the selection of
branches to be merged when "git pull" happens from a remote
either.
