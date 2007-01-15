From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-remote exclude
Date: Mon, 15 Jan 2007 13:56:07 -0800
Message-ID: <7vodp00xag.fsf@assigned-by-dhcp.cox.net>
References: <45AA44D6.6080605@gmail.com>
	<Pine.LNX.4.63.0701151118400.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<200701151155.26111.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 22:56:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6ZoX-0006Gy-K6
	for gcvg-git@gmane.org; Mon, 15 Jan 2007 22:56:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbXAOV4N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 16:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbXAOV4M
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 16:56:12 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:45577 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411AbXAOV4J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 16:56:09 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070115215608.WILZ15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Mon, 15 Jan 2007 16:56:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id BZvF1W00B1kojtg0000000; Mon, 15 Jan 2007 16:55:15 -0500
To: Andy Parkins <andyparkins@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36886>

Andy Parkins <andyparkins@gmail.com> writes:

> On Monday 2007 January 15 10:23, Johannes Schindelin wrote:
>
>> But then, I don't really see _why_ you would want such a solution. After
>> all, you are more likely to be interested in _specific_ branches, rather
>> than all branches _except_ a few.
>
> That's not true.  I have a patch (that doesn't work, so it's not submitted), 
> that would allow me to have:
>
> [remote "origin"]
>     url = git://git2.kernel.org/pub/scm/git/git.git
>     fetch = refs/heads/*:refs/remotes/up/*
>     fetch = !refs/heads/html
>     fetch = !refs/heads/todo
>
> i.e. I don't want those two branches, but I do want everything
> else.  I'd also like to be able to do "!/refs/heads/temp/*" so
> I could block a whole subdirectory of branches.

I do not think you are interested in "not these two but
everything else".  You are interested in maint, master, next, pu
and man.  You can get away by saying "not these two but
everything else" only because you are implicitly trusting me not
to publish insane number of random throw-away branches left and
right.

In an ideal world, I think you would want to be able to do
something like this:

 - Let's look at what they have right now.
 - I want, among the above, this, that and that.
 - I would never want any of the others I just checked.

 - If there are new ones found in the future, please let me know
   and I'll decide then.  or...
 - If there are new ones found in the future, I would not want to
   be bothered with them.  or...
 - If there are new ones found in the future, I want them too.

The choice between the last three will heavily depend on the
nature of the project and also your work habit to a certain
degree.

A remote could frequently throw in random small-topic branches
that are short lived, and are totally uninteresting for somebody
who wants to track the big picture branches.  You would say the
first if you primarily work in a particular area of the project,
because you will always be interested in the primary integration
and you may or may not be interested in a new topic.  You would
say the second if you are only interested in the big picture
branches after marking the primary integration branches as
interesting.  You would say the third only if you are a packrat,
or have unlimited brain bandwidth to keep track of what's
happening in every little corner of the project.

If a single repository has 1000 branches, that is a sign that
there is something wrong in the project's organization.  No
single person should need to look at 1000 branches -- that goes
directly against the distributed nature of git.  Humans do not
scale well.

Now, 'git-fetch' currently does not scale either, and I think it
is a problem, but I think that is fixable by redoing the part
below the while loop that calls append_fetch_head to make the
processing more efficient.

But you cannot optimize humans the same way.

The move to BK formalized a change to the development process of
the kernel project --- a central single integrator did not scale
well, and there was a need for a group of people around the
center to help the peer review and the integration process.  The
patch-flow in the development process places more integration
work and responsibility on the lieutenants, and the tool helps
people who are more central than the lieutenants trust, verify
and integrate their lieutenants' work.

Helping this kind of project organization is what git inherited
from BK as well.  The key to scaling is to limit the product of
the level of details times the size of the area one person needs
to look at.  A project may have 1000 simultaneous development
going at any one time, but a lieutenant should not need to look
at all 1000 branches but only a much smaller portion of them in
his own area of expertise.  A more central person should not
need to look at all 1000 branches either, but what he will look
at would be branches that the lieutenants would publish in their
repositories, as the result of integration of these 1000
branches at the lowest level.
