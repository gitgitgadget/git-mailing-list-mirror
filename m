X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Thoughts about memory requirements in traversals [Was: Re: [RFC] Submodules in GIT]
Date: Sat, 2 Dec 2006 21:46:55 -0500
Message-ID: <20061203024655.GD26668@spearce.org>
References: <20061130170625.GH18810@admingilde.org> <Pine.LNX.4.64.0612021242080.3476@woody.osdl.org> <Pine.LNX.4.64.0612021252380.3476@woody.osdl.org> <200612030307.26429.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 3 Dec 2006 02:47:19 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Martin Waitz <tali@admingilde.org>,
	sf <sf-gmane@stephan-feder.de>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200612030307.26429.Josef.Weidendorfer@gmx.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33088>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqhNp-0003wO-KB for gcvg-git@gmane.org; Sun, 03 Dec
 2006 03:47:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424734AbWLCCrK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 21:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424787AbWLCCrK
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 21:47:10 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:19355 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1424734AbWLCCrJ
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 21:47:09 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GqhNR-0001Z8-78; Sat, 02 Dec 2006 21:46:49 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 C0BC920FB7F; Sat,  2 Dec 2006 21:46:55 -0500 (EST)
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
> Thinking even one step further:
> Would it make sense to define an encoding format for the content of
> commit and tree objects inside of packs, where the SHA1 is replaced by the
> offset of the object in this pack?
> As exactly the SHA1 is the least compressable thing, this could promise
> quite a benefit.

I actually had the same idea the other day.  I discarded it after
thinking about it for a minute.  Here's the problem:

Lets say we do this for the tree and parent IDs in a commit, because
these are the most commonly needed part of a commit during revision
traversal.  So we want to put the offset to the tree and the offset
to each parent at the front of the commit somehow to make them very
cheap to access.

This means that when we start to write out a commit we need to know
the offset to the tree that commit references.  But git-pack-objects
sorts object by type: commit, tree, blob (I forget where tags go,
but they aren't important in this context).  So generally *all*
commits appear before the first tree.  So when we write out the first
commit we need to know exactly how many bytes every commit will need
(compressed mind you) in this pack so we can determine the position
of the first tree.  Now do this for every commit and every tree
that those commits use...  yes, its a lot of work to precompute
and store all offsets before you even write out the first byte.

Its even worse with parent commits because ancestors tend to appear
behind the commit (newest->oldest) so that "git log" can benefit
from OS read-ahead.  So you also have to keep track of your parent
commmit offsets.  Not pretty.

Extending that idea to tree objects (store the offset of the entry)
makes the issue even uglier.

Oh, and packs aren't entirely self-contained.  A pack is only self
contained in the sense that no object in the pack deltafies against
an object outside of the pack[1].  However by design an object
(e.g. a commit or a tree) can reference an object which is either
loose or which is in another pack.  This is especially important
for every large projects where not every commit/tree/tag/blob will
fit into one 4 giB file.

**1** Except in the case of thin packs, which are used only on the
network and only to save bandwidth.

> AFAIK, we currently only use these offsets for referencing objects in
> delta chains.

Yes, that's a recent feature to reference a delta base.

-- 
