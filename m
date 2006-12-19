X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 2/2] git reflog expire
Date: Tue, 19 Dec 2006 05:40:32 -0500
Message-ID: <20061219104032.GB21324@spearce.org>
References: <7vodq3a136.fsf@assigned-by-dhcp.cox.net> <7vr6uxzgjb.fsf@assigned-by-dhcp.cox.net> <20061218140813.GA32446@spearce.org> <7vy7p4u1au.fsf@assigned-by-dhcp.cox.net> <7v64c8thr4.fsf@assigned-by-dhcp.cox.net> <20061219090851.GH2511@spearce.org> <7vhcvsry2c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 19 Dec 2006 10:41:07 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vhcvsry2c.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34818>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwcOm-0003WC-8h for gcvg-git@gmane.org; Tue, 19 Dec
 2006 11:40:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932771AbWLSKkh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 05:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932774AbWLSKkh
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 05:40:37 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:35693 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932771AbWLSKkg (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 05:40:36 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GwcOd-0008H4-MM; Tue, 19 Dec 2006 05:40:31 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 E0EEC20FB65; Tue, 19 Dec 2006 05:40:32 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > Of course that's not what the code does, because if either the
> > old or the new object is no longer in the ODB you are pruning away
> > the log entry.  I cannot however come up with a better name than
> > --expire-lost.  :-(
> 
> How about --expire-unreachable?

That actually does make more sense.  Those commits are what we would
traditionally have called unreachable commits, or dangling commits.
Hmm.  Flip a coin.  I'm probably as bad at UI as you are.  :-)
 
> To have 'expire' action as a subcommand to 'git-reflog' is from
> implementor's point of view, and is a horrible organization from
> the UI standpoint.  To the end users, it may be easier to have a
> single 'git-gc' command that runs these commands with reasonable
> set of defaults:
> 
>   - rerere gc
>   - reflog expire --all
>   - (possibly) repack -a -d
>   - prune
> 
> If we go that route, it probably is not even necessary to
> advertise that 'expire' is a subcommand of reflog.  The users
> would not run it from the command line; it is an implementation
> detail of 'git-gc' command.

Yes!  I agree with you completely here.  I'd also include 'pack-refs
--prune' to your list above, at least for refs/tags.  Those suckers
can eat up a lot of disk, slow down viualizers, and well, just
don't change.  Pack 'em!

> > Needing a subcommand like 'git reflog show HEAD' is just a lot
> > of typing[*1*].
> 
> I am very interested in seeing how 'git reflog show HEAD' would
> show the reflog entries.  I've tried showing it just like log
> family shows (it is reasonably easy; you build the list of revs
> out of reflog entries and feed them to 'git-show' machinery),
> and while it works, it is unusable for the purpose of seeing
> which ones are the lost ones (amended commits and rebased branch
> remnants).

At this point I'm going to wind up getting less than 4 hours of
sleep tonight (I'll be lucky if I get 3).  So I'm just going to skip
trying to draft out what I might want this to look like right now.
I'll try to sketch out a dump by hand from a couple of my own reflogs
and post 'em later tonight.  Ugh.  Tonight.  Its Tuesday already.
My body still thinks its Monday.

> The best I came up with is still my "show-branch --reflog" so
> far.  You really need to show not just the commit title but how
> they topologically relate to the commits on the surviving
> branch, and I think having something graphical or semi-graphical
> is a must.

Probably right.  But I can't make heads or tails out of that
output for just one topic branch whose reflog consists of only
the following:

  $ cut -f2 .git/logs/refs/heads/sp/mapwin 
  checkout: Created from origin^0
  am: Create read_or_die utility routine.
  reset --hard 106d710b
  am: Create read_or_die utility routine.
  reset --hard 
  rebase: Create read_or_die utility routine.

`show-branch --reflog --topics sp/mapwin` prints much shorter output
and almost says something useful, but not really.

-- 
