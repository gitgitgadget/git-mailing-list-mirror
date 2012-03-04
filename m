From: Seth Robertson <in-gitvger@baka.org>
Subject: Re: Announcing 3 git docs: Best Practices, fixing mistakes, post-production editing
Date: Sun, 04 Mar 2012 14:20:01 -0500
Message-ID: <201203041920.q24JK15L024778@no.baka.org>
References: <201202281304.q1SD4U8W018223@no.baka.org>
        <20120228225205.GA23804@sigill.intra.peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 04 20:20:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4Gyc-0001vS-EX
	for gcvg-git-2@plane.gmane.org; Sun, 04 Mar 2012 20:20:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754754Ab2CDTUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Mar 2012 14:20:07 -0500
Received: from tsutomu.baka.org ([66.114.72.182]:53464 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754750Ab2CDTUG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2012 14:20:06 -0500
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id q24JK1fE021810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 4 Mar 2012 14:20:01 -0500
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id q24JK15L024778;
	Sun, 4 Mar 2012 14:20:01 -0500
In-reply-to: <20120228225205.GA23804@sigill.intra.peff.net>
Comments: In reply to a message from "Jeff King <peff@peff.net>" dated "Tue, 28 Feb 2012 17:52:05 -0500."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192169>


First, I'd like to thank you for your comments.  They certainly
improved the document and made me think and experiment.

In message <20120228225205.GA23804@sigill.intra.peff.net>, Jeff King writes:

    On Tue, Feb 28, 2012 at 08:04:30AM -0500, Seth Robertson wrote:

    > [section Don't Panic, subsection Lost and Found]
    >
    > Dangling Commit
    >
    > These are the most likely candidates for finding lost data. A dangling
    > commit is a commit no longer reachable by any branch or tag. This can
    > happen due to resets and rebases and are normal. git show SHA will let
    > you inspect them.

    Resets and rebases record the commits in the reflog (at the very least
    in the HEAD reflog), and should generally not be the cause of dangling
    commits (the objects should usually expire in the same "git gc" that
    expires the reflog entries). I suspect a more common cause is deleting
    branches, which leaves no reflog (the commits may be in the HEAD reflog
    if they were ever checked out, though).

I get them all of time and I never delete branches.

    It's somewhat minor; the overall advice ("do not worry about dangling
    commits") holds. But it might be worth pointing out that the method for
    recovering an accidentally deleted branch is usually:

      1. look in the HEAD reflog
      2. if you can't find it there, try dangling commits

My understanding is that if a commit gets packed, it sticks around for
a few weeks longer than the reflog since the clock gets reset when it
gets evicted from a pack.

    > [section Do make useful commit messages]

    This talks about formatting, but not about content. I have long wanted
    to write a nice essay on what should go into a good commit message, but
    when I've tried it ends up very specific to the project, the type of
    commit, and the individual change. I wonder if anybody knows of
    something good you could link to.

I'd certainly like to see such a thing.  I did touch on the subject
further when I started talking about integration with bug tracking
systems.

    > [section On Sausage Making]
    >
    > Some people like to hide the sausage making, or in other words pretend to
    > the outside world that their commits sprung full-formed in utter
    > perfection into their git repository. Certain large public projects
    > demand this, others demand smushing all work into one large commit, and
    > still others do not care.
    >
    > A good reason to hide the sausage making is if you feel you may be
    > cherry-picking commits a lot (though this too is often a sign of bad
    > workflow). Having one or a small number of commits to pick is much
    > easier than having to find one commit here, one there, and half of this
    > other one. The latter approach makes your problem much much harder and
    > typically will lead to merge conflicts when the donor branch is finally
    > merged in.
    >
    > Another good reason is to ensure each commit compiles and/or passes
    > regression tests, and represents a different easily understood concept
    > (important for archeology). The former allows git-bisect to chose any
    > commit and have a good chance of that commit doing something useful, and
    > the latter allows for easy change review, understanding, and
    > cherry-picking.

    This is a nice overview of the motivation, but I think it misses one
    of the main reasons we clean up patches in git.git: code review.

Well, I said "change review" instead of "code review".  I added the
word "code" specifically, but I'll stick some wording on why it is
important to code review.  I already touched on people who wanted to
bisect.

    By cleaning up patches into single, logical changes that build on one
    another, and which don't individually regress (i.e., they are always
    moving towards some desirable common endpoint), the author is writing a
    chronological story not of what happened, but what _should_ happen, with
    the intent that the audience (i.e., reviewers) are convinced that the
    change is the right thing to do.

I'll add this paragraph as well.

    > [Do periodic maintenance]
    >
    > Compact your repo (git gc --aggressive)
    >
    > This will removed outdated dangling objects (after the two+ week grace
    > period). It will also compress any loose objects git has added since
    > your last gc. git will run gc automatically after certain commands, but
    > doing a manual --aggressive will save space and speed git operations.

    Most people shouldn't be using "--aggressive".

I'll add `git gc` as an intermediate stage and take wording from the
manual to run `git gc --aggressive` every few hundred changesets.

I suppose it all depends on your definition of the period in periodic
maintenance.

    > [section Miscellaneous "don't"s]
    >
    > create very large repositories (when possible)
    >
    > Git can be slow in the face of large repositories. There are
    > git-config options that can help. pack.threads=1 pack.deltaCacheSize=1
    > pack.windowMemory=512m core.packedGitWindowSize=16m
    > core.packedGitLimit=128m. Other likely ones exist.

    It might help to qualify "big" here. ... I think big here is
    probably getting into 100K-200K files (where the time to stat()

    files becomes noticeable, commits are probably not relevant
    (because git is usually good at only looking at recent bits of
    history for most operations), and packfiles above 1G or so start
    to get cumbersome (mostly because of the I/O on a full repack; but
    then you should consider marking a pack as .keep).

    But those numbers are just pulled out of a hat based on the last few
    years. Your OS, your hardware, and your expectations make a huge
    difference in what seems reasonable.

That was why I didn't mention any specific limits.  However, since you
were kind enough to do provide some, I will include them.  I will also
add that my suggested configuration values are only needed if you are
experiencing memory pressure on packing.

    Your config recommendations seem mostly related to relieving memory
    pressure for packing (at the expense of making the pack a lot slower).

Very true, that was the problem I was running into.  I will
specifically make that comment.  I'll make a wild recommendation
about sizing these variables, which I'd certainly accept corrections
to or advice on.  Specifically the next sentence:

----------------------------------------------------------------------
My gut tells me that sizing ("deltaCacheSize" + "windowMemory" +
min("core.bigFileThreshold[512m]", TheSizeOfTheLargestObject)) *
"threads" to be around *half* the amount of RAM you can dedicate to
running `git gc` will optimize your packing experience, but I will be
the first to admit that made up that formula based on a very few
samples and it could be drastically wrong.
------------------------------------------------------------------

    I don't think you should need to adjust core.packedGitWindowSize or
    core.packedGitLimit at all.

Well, certainly git takes up a ton (specifically double or just over
1GB additional) more RAM during gc with them unset, and caused some
limited swapping of other processes (but no thrashing).  However, the
real question is, did it take more time?  It did, but the amount of
added time was about 3% and thus probably well under my test accuracy.

					-Seth Robertson
