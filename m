X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: bash completion in backticks partially broken
Date: Sun, 5 Nov 2006 05:26:35 -0500
Message-ID: <20061105102635.GB4843@spearce.org>
References: <20061105090540.GA4843@spearce.org> <7vpsc2teb0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 5 Nov 2006 10:26:50 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vpsc2teb0.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30964>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgfDA-0004aq-2i for gcvg-git@gmane.org; Sun, 05 Nov
 2006 11:26:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932631AbWKEK0k (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 5 Nov 2006
 05:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932633AbWKEK0k
 (ORCPT <rfc822;git-outgoing>); Sun, 5 Nov 2006 05:26:40 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:3304 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S932631AbWKEK0j
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2006 05:26:39 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GgfD0-000514-8h; Sun, 05 Nov 2006 05:26:34 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 8F89520E491; Sun,  5 Nov 2006 05:26:35 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > This is really annoying when it comes to less contrived examples.
> > I find myself forming odd pipelines with commit-tree, update-ref,
> > mktree, lstree, sed, rev-list, etc. and always keep bumping up on
> > the limitations of git-completion.bash.
> >
> > Any suggestions?
> 
> I am more interested in why you would even need to use
> combinations of such low-level commands in day-to-day workflow.
> 
> If they are often-needed patterns, you would have scripted them
> already, so completion would not be an issue for you.  So I am
> assuming these are ad-hoc one-shot needs.

Yes, that's correct.
 
> While it is satisfying to know that things you would want to do
> can be scripted even for one-shot use (which is how git is
> designed to, and it shows that the design goal has been
> achieved), maybe it's a sign that we are giving you too much
> flexibility?  Under less capable/flexible system that puts you
> in a straightjacket, you would not even be tempted to do oddball
> things to begin with...

A few recent examples come to mind:

  *) We're mostly on Windows (*sigh*) which as you know is a case
     insensitive file system.  Someone managed to delete a file
	 called 'Myfoo' and recreate it as 'MyFoo' on two different
	 branches.

	 We have a specialized merge driver which we are running on
	 certain merges.  This merge driver made the bad assumption
	 that both 'Myfoo' and 'MyFoo' should stick around after
	 merging those two branches together.  No, merge-recursive
	 doesn't implement the type of bastard merge we need,
	 so don't ask.	This merge strategy is also probably not
	 useful to anyone else, which is why I haven't posted a
	 patch to include it.

	 A quick hack with mktree/commit-tree/update-ref removed
	 the wrong 'Myfoo' leaving 'MyFoo' in place.  And before
	 you ask, yes I did check that was sane, 'Myfoo' and 'MyFoo'
	 had the exact same SHA1.  ;-)

  *) A new user branched off a highly experimental branch then
     proceeded to merge that straight into the mainline.  We found
	 his mistake 100 commits later on the mainline and couldn't
	 rewind it.

	 Because of the way that mainline is flushed into the
	 testing environment, and because it had a lot of history on
	 it that we wanted to keep valid in git-blame, I reverted
	 ~36 commits in one large squash commit onto the mainline,
	 flushed that into testing, then squash cherry-picked all
	 ~36 commits back ontop of that, then merged that into the
	 prior experimental branch.  Yuck.

	 The upside is that both git-blame and git-pickaxe report
	 back to the original commits.	:)

	 I'm sure I abused git-write-tree and git-commit-tree during
	 that as both are faster than waiting for git-commit.  Yes,
	 it takes me less time to type out and execute commit-tree
	 pipeline than to wait for git-commit on my system.  :-(

	 I also know I spent a lot of time with gitk and
	 git-merge-base trying to find the correct set of 36 commits
	 which had to be worked on.  It wasn't a trivial rev-list/log
	 type operation due to the sheer number of commits and merges
	 involved.  Our commit graph is much uglier than git.git.

  *) Being the moron that I am I pulled another (but slightly
     less) experimental branch into the highly experimental branch
     mentioned above.  3 weeks later we concluded that was a bad idea
	 as not all of the stuff in the slightly less experimental
	 branch was good.  But I had also done a number of bug fixes
	 onto that highly experimental branch and those needed to
	 get saved.

	 This turned out to be mostly a format-patch | am pipeline,
	 so it wasn't really that awkward.

  *) At least twice I've had an aweful merge of over 1000 files
     conflicting heavily between two branches.	Yet in both cases
	 I *know without a doubt* that one of those two branches is
	 completely correct for 15 of say 20 top level directories,
	 such that those 15 directories cover about 995 files.

	 To resolve these I've often just reverted those directories
	 en-mass to the version in the merge-base of the two branches
	 by way of ls-tree/vi/mktree, then let merge-recursive do
	 its thing.  As the correct side differs but the wrong side
	 was reverted, the correct side pops out of the merge. :-)

	 Its somewhat lying in the history because Git now thinks
	 that one branch modified 995 files, then suddenly threw them
	 all back to the version at the merge-base.  But honestly
	 reverting them back to the merge-base and then immediately
	 doing a merge which replaces them with the correct versions
	 is about the same as resolving the 995 conflicts during
	 the merge with the ones from the other branch.

	 Its also *much* faster on Cygwin.  That 1000 file merge
	 would probably have taken my system 15 minutes just to
	 invoke 'merge' on each file and still leave me with a mess
	 to cleanup.  Yet the bastard approach above with mktree
	 took me like 5 minutes (total).

Now on UNIX systems I never do stupid things like the above; nor
do I work with such new users...  Hmm...  I wonder what that says...

-- 
