X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFD] making separate-remote layout easier to use
Date: Sat, 25 Nov 2006 22:34:33 -0500
Message-ID: <20061126033433.GD29394@spearce.org>
References: <7v1wnr19do.fsf@assigned-by-dhcp.cox.net> <ekafpm$fs7$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 26 Nov 2006 03:34:51 +0000 (UTC)
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <ekafpm$fs7$1@sea.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32319>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoAmx-0000Pf-Cg for gcvg-git@gmane.org; Sun, 26 Nov
 2006 04:34:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967247AbWKZDej (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 22:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967255AbWKZDej
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 22:34:39 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38631 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S967247AbWKZDei
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 22:34:38 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GoAme-0006Tr-KV; Sat, 25 Nov 2006 22:34:24 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 4CB9220FB09; Sat, 25 Nov 2006 22:34:34 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> wrote:
> Junio C Hamano wrote:
> >       Pull: +refs/heads/*:refs/remotes/<origin>/*
> 
> I hope that it also works with the remote.origin config file
> section instead of $GIT_DIR/remotes/origin

Yes, it does.  Fortunately Git is relatively consistent.  :-)
 
> > Forcing with '+' is debatable, but with separate-remote layout,
> > remotes/*/ hierarchy is to track what the remote has, and you
> > cannot do much else other than noticing and warning when the
> > remote end does funny things to its refs anyway, so I think
> > having '+' might be a better default.
> 
> Perhaps, perhaps not. It would be nice to have configuration option
> that would tell that history of given branch is being changed, and
> the ability to ask about it remotely, so git-clone would be able
> to add this + _when needed_ automatically.
> 
> But it's a fact that with separate remote the need to use fast-forward
> check is lessened, and it might be more important to not confuse first
> time user with having to modify $GIT_DIR/remotes/origin or remote.origin
> config section to fetch from the repository he/she cloned from.

Yes.  From an out-of-the-box-make-Git-appear-to-be-easier-to-use
point of view tossing + into the Pull:/remote.<name>.fetch setup
might seem like the right thing to do.  It lets the end-user blindly
follow the upstream repository they cloned from.  Almost.

The problem becomes when the user makes a topic branch off say
Junio's `pu` branch and later after doing a fetch and looking at
the log of `remotes/origin/pu` decide to pull the updated `pu`
into their topic branch, so they can continue testing.  But now
they are in merge hell as Junio has completely rebased `pu` and
what was there isn't, and what's there now ain't compatible...
and the new user curses at Git.

Needing to put + in front of a refspec (or needing to fetch it with
--force) is the user agreeing that something _evil_ is going on with
the upstream and that they acknowledge this may cause problems for
them locally.

I would prefer to see the upstream be able to publish a short
description of each branch, where the repository owner can describe
the policy of that branch, as well as have a machine readable
setting on each branch indicating if that branch will be rewound
from time to time, or never rewound.

git-clone should skip rewinding branches by default, unless the user
adds an option (e.g. --include-rewinding-branches).  This way new
users to git.git don't get the `pu` branch unless they really mean
to get it, at which point they have hopefully also read the upstream's
description of the `pu` branch and its rewinding policy, and can
at least start to grasp what is going to happen if they start to
work with the branch.
 
> > I am not sure if 'merge in corresponding branch' is the only
> > valid workflow, however. I am reluctant to make the system
> > automatically do so if the solution makes other workflows more
> > painful to follow.  Automatically merging remotes/origin/$foo
> > when on $foo branch is not good enough, in other words (also,
> > there may be a hierarchy under remotes/ other than origin).  It
> > might make sense to introduce "Merge: " in remotes/ file and if
> > they are present use "Pull: " only to decide what are fetched
> > and use "Merge: " to decide what is merged (if we were doing the
> > system from scratch, the former would have been named "Fetch: "
> > but it is too late now).
> 
> If you add "Merge: " in remotes/, then please add it also in
> remote section in config file. Config file has now 
> branch.<branchname>.merge (and it would be nice if clone would
> set ou this for local branches corresponding to remote branches),
> but it is not the same.

I'm against adding anything to the remotes/ file format.

We already have branch.<name>.merge to indicate what the default
source for a git-pull on the branch named <name> should be.
git-branch probably should fill that entry in when a branch is
created from a remotes ref.

-- 
