X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 21 Nov 2006 22:40:56 -0500
Message-ID: <20061122034056.GB23856@spearce.org>
References: <20061120215116.GA20736@admingilde.org> <ejt9dh$kfm$1@sea.gmane.org> <7v7ixp20za.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611201501230.3338@woody.osdl.org> <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <Pine.LNX.4.64.0611211437430.3338@woody.osdl.org> <20061121235429.GH5443@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 22 Nov 2006 03:41:15 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061121235429.GH5443@nan92-1-81-57-214-146.fbx.proxad.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32064>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gmiz1-0003W3-3o for gcvg-git@gmane.org; Wed, 22 Nov
 2006 04:41:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967040AbWKVDlI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 22:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967051AbWKVDlI
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 22:41:08 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:43457 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S967040AbWKVDlE
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 22:41:04 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gmiyd-0007yh-1r; Tue, 21 Nov 2006 22:40:47 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 5145720FB09; Tue, 21 Nov 2006 22:40:57 -0500 (EST)
To: Yann Dirson <ydirson@altern.org>
Sender: git-owner@vger.kernel.org

Yann Dirson <ydirson@altern.org> wrote:
> Put it another way, I see the proposal of allowing tree entries to be
> commits in addition to trees and blobs, akin to recording the submodule
> _history_ inside the _tree_, which I feel precisely violates the
> distinction you want to keep between those 2 concepts.

No.  Linus is right.  Submodule commits belong in the tree.

We want to record a specific subtree within a larger tree.  There are
three ways we can refer to a tree: by its tree SHA1, by a commit
which points at the tree SHA1, or by a tag which points at a
commit which points at the tree SHA1, or by a tag which points
at a tag which points at a commit which points at a tree SHA1.
Which is basically a tree-ish.

The advantage of linking to the commit-ish (commit or tag) and
not the tree-ish for a submodule is that it also provides you quick
access to answer the "how did this tree arive at this state" question
as the answer cannot come solely from the top level commit chain.
The reason... keep reading...
 
> What about the case of a subproject that would evolve fast, and for
> which we may not want intermediate versions to be part of the
> supermodule ?  (just exploring an idea without real connection to the
> one discussed above)

Right.  The submodule is free to be committed to an infinite number
of times for any given commit in the supermodule.

It is expected that users will commit to a submodule say hundreds of
times for every commit they make to the supermodule.  Or thousands.
This is especially true if the submodule is some very large project,
e.g. the Linux kernel, and the supermodule "upgrades" the kernel it
is using after 3 months of staying on the same version.  Suddenly the
supermodule has only 1 commit which covers maybe 10,000 commits in
the submodule.

Yet we still want to be able to efficiently perform operations like
"git bisect" within the scope of that submodule, to help narrow down
a particular bug that is within that submodule.  To do that we need
the commit chain (all 10,000 of those commits) in the submodule.
To get those we really need a commit-ish and not a tree-ish, as
going from a tree-ish to a commit-ish is not only not unique but
is also pretty infeasible to do (you need to scan *every* commit).

-- 
