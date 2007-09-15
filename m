From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Mailing patch series'
Date: Fri, 14 Sep 2007 22:35:18 -0400
Message-ID: <20070915023518.GX3099@spearce.org>
References: <46EB301B.8050602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Russ Brown <pickscrape@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 15 04:35:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWNVQ-0002Ge-SI
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 04:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759987AbXIOCfb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2007 22:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755405AbXIOCfa
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 22:35:30 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:57317 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755562AbXIOCfW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2007 22:35:22 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IWNVM-0006nw-Jd; Fri, 14 Sep 2007 22:35:32 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2A6EA20FBAE; Fri, 14 Sep 2007 22:35:19 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <46EB301B.8050602@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58216>

Russ Brown <pickscrape@gmail.com> wrote:
> I've noticed the method of mailing series' of patches on this mailing
> list, and I'd like to know a little more about how it's done, as I'm
> considering how well it might work for us as a workflow and review process.
> 
> Particularly, where does the series of patches come from?

Usually from Git itself, as in each Git commit is turned into its
own email message by `git format-patch` which can then be sent by
`git send-email` or your favorite mail client.

> Is this a
> usage scenario for stacked git (something else I don't fully understand
> the rationale behind as yet)?

Yes, its one of them.  When you are editing a series of patches that
you want someone to read as a linear "conversation" it can help to
use StGIT as you can reorder the commits (messages/patches) at will
and edit any of them at any time.  guilt is another excellent tool
that also can be used here.

I actually just use core Git itself with `git rebase -i` when I need
to perform ordering/editing before sending.  I like the interface it
offers, its fast enough for my needs, and well, I'm just so used to
the bare plumbing of Git that I think in terms of the DAG operators.
I've heard wonderful things about both StGIT and guilt, but they
aren't this particular developer's cup of tea.

> I'm imagining the developer has a local
> branch to which he commits his changes, and then rebases resulting in
> his branches being at the end of the local branch. How are they then
> extracted and mailed out?

git-format-patch takes one of two variations of arguments: either
a single commit or a range of commits.  The most common usage is
in the single commit case.

When given a single commit git-format-patch creates a message for
each commit on the current branch that is after the supplied commit.
The second case (range of commits) it creates a message for each
commit in that range.

So when I start developing a topic I branch off Junio's master,
which I happen to fetch into refs/remotes/jc/master (as I had
previously done `git remote add jc $url`):

	git checkout -b fetch-pack-fixes jc/master

           jc/master
           fetch-patch-fixes
          /
  -o-o-o-B

Then I do my development... and rebase against Junio before sending:

	git fetch jc

                          fetch-patch-fixes
                         /
  -o-o-o-B-m1-m2-m3-m4-m5     jc/master
         \                   /
          o-o-o-o-o-o-o-o-o-C

	git rebase jc/master

  -o-o-o-B                    jc/master          fetch-patch-fixes
         \                   /                  /
          o-o-o-o-o-o-o-o-o-C-m1'-m2'-m3'-m4'-m5'

Now I retest my series and send it to Junio:

	git format-patch --stdout jc/master >mbox
	mutt -f mbox

When mutt (my preferred mail client) starts it is loading a mailbox
with one email message per commit.  Only the commits on my current
branch (m1'-m5') that don't appear in jc/master (my tracking branch
of Junio's master) will be formatted into mbox.  That is only my
work that I haven't sent yet.

I (re)review each commit and then a macro sends the message on
its way.  To help me preaddress the emails I have the following
in .git/config:

	[format]
	  headers = "To: Junio C Hamano <gitster@pobox.com>\n"
	  headers = "Cc: git@vger.kernel.org\n"

That way the messages have proper To/Cc lines automatically entered
and the mutt macro is really just to trigger sending the message.

Finally I leave that branch alone.  If I want to make further changes
I actually fork off it and start a new branch:

	git checkout -b fetch-pack-fixes2 fetch-pack-fixes

As now when I send this new branch I can use:

	git format-patch --stdout fetch-pack-fixes >mbox
	mutt -f mbox

To send only the commits since the last series that I sent.  If my
work is worthy these commits will eventually come back during a
later fetch from Junio.  I look for my work using `git log` and
`git cherry` and delete the branches that Junio has fully merged in.

I don't actually quite use all of those commands by hand; I have a
proper wrapper script that I've put together to automate remembering
what I last sent, defaulting to "jc/master", and to run the pipeline
of format-patch and mutt.

> My next question, is supposing that the patches are reviewed and changes
> suggested. How does the developer then go about amending, say the second
> patch and getting the subsequent ones rebased off that? I'm assuming
> there's a nice clever way of doing it that doesn't involve manually
> messing with individual patch files etc.

Use StGIT, guilt, or `git rebase -i jc/master` to go back and edit
the necessary patches in the series, then resubmit the entire series.
Or just the changed ones and the later ones, depending on what got
merged upstream already.

If you edit something in a particular change you can cause
merge conflicts when the other commits are pushed on top/picked
(terminology depending on your tool of choice).  But you should
then get a merge conflict and be able to fix it up.

-- 
Shawn.
