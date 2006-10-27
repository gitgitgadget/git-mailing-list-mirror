X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: fetching packs and storing them as packs
Date: Fri, 27 Oct 2006 00:42:34 -0400
Message-ID: <20061027044233.GA29057@spearce.org>
References: <Pine.LNX.4.64.0610252333540.12418@xanadu.home> <4540CA0C.6030300@tromer.org> <Pine.LNX.4.64.0610261105200.12418@xanadu.home> <45413209.2000905@tromer.org> <Pine.LNX.4.64.0610262038320.11384@xanadu.home> <20061027014229.GA28407@spearce.org> <45417205.6020805@tromer.org> <20061027030054.GB28407@spearce.org> <4541850B.8060608@tromer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 27 Oct 2006 04:42:51 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <4541850B.8060608@tromer.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30288>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdJYM-0005zm-AW for gcvg-git@gmane.org; Fri, 27 Oct
 2006 06:42:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423558AbWJ0Emn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 00:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423545AbWJ0Emn
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 00:42:43 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:59813 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1423542AbWJ0Emm
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 00:42:42 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GdJYS-0002oZ-PQ; Fri, 27 Oct 2006 00:42:52 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 83C3F20E45B; Fri, 27 Oct 2006 00:42:34 -0400 (EDT)
To: Eran Tromer <git2eran@tromer.org>
Sender: git-owner@vger.kernel.org

Eran Tromer <git2eran@tromer.org> wrote:
> On 2006-10-27 05:00, Shawn Pearce wrote:
> >> Change git-repack to follow references under $GIT_DIR/tmp/refs/ too.
> >> To receive or fetch a pack:
> >> 1. Add references to the new heads in
> >>    `mktemp $GIT_DIR/tmp/refs/XXXXXX`.
> >> 2. Put the new .pack under $GIT_DIR/objects/pack/.
> >> 3. Put the new .idx under $GIT_DIR/objects/pack/.
> >> 4. Update the relevant heads under $GIT_DIR/refs/.
> >> 5. Delete the references from step 1.
> 
> > That was actually my (and also Sean's) solution.  Except I would
> > put the temporary refs as "$GIT_DIR/refs/ref_XXXXXX" as this is
> > less code to change and its consistent with how temporary loose
> > objects are created.
> 
> If you do that, other programs (e.g., anyone who uses rev-list --all)
> may try to walk those heads or consider them available before the pack
> is really there. The point about $GIT_DIR/tmp/refs is that only programs
> meddling with physical packs (git-fetch, git-receive-pack, git-repack)
> will know about it.
 
Doh.  Yes, of course, that makes much sense.

Hmm... Looking at git-repack we have two things currently pending
to rework in there:

  - Historical vs. active packs.
  - Don't delete a possibly still incoming pack during -d.

These have a lot of the same implementation issues.  We need to
be able to identify a set of packs which should be allowed for
repack with -a, and allowed for removal with -d if -a was also used.
A newly uploaded pack cannot be in that list unless its contents are
referenced by one or more refs (which implies that the receive-pack
process has completed).

I'm thinking that the ref thing might be unnecessary.  We just
need to fix repack so it builds a list of "active packs" whose
objects should be copied into the new pack, and then only packs
loose objects and those objects contained by an active packs.

So the receive-pack process becomes:

  a. Create temporary pack file in $GIT_DIR/objects/pack_XXXXX.
  b. Create temporary index file in $GIT_DIR/objects/index_XXXXX.
  c. Write pack and index.
  d. Move pack to $GIT_DIR/objects/pack/...
  e. Move index to $GIT_DIR/objects/pack...
  f. Update refs.
  g. Arrange for new pack and index to be considered active.

And the repack -a -d process becomes:

  1. List all active packs and store in memory.
  2. Repack only loose objects and objects contained in active packs.
  3. Move new pack and idx into $GIT_DIR/objects/pack/...
  4. Arrange for new pack and idx to be considered active.
  5. Delete active packs found by step #1.

Junio was originally considering making historical packs
historical by placing their names into an information file (such as
`$GIT_DIR/objects/info/historical-packs`) and then consider all other
packs as active.  Thus step #1 is list all packs and removes those
whose names appear in historical-packs, while step #4 is unnecessary.

I was thinking about just changing the "pack-" prefix to "hist-" for
the historical packs and assuming all "pack-*.pack" to be active.
Thus step #1 is a simple glob on the pack directory and step #4
is unnecessary.

In the latter case its easy to mark an existing pack as historical
(just hardlink hist- names for pack, then idx, then unlink previous
names) and its also easy to mark new incoming packs as non active
by using a different prefix (e.g. "incm-") during step #d/#e and
then relinking them as "pack-" during step #g.  Its also very safe
on systems that support hardlinks.

We shouldn't ever need to worry about race conditions with repacking
historical packs.  For starters historical packs will tend to be
several years' worth of object accumulation and will be so large
that repacking them might take 45 minutes or more.  Thus they
probably will never get repacked.  An active pack will simply move
into historical status after it gets so large that its no longer
worthwhile to keep repacking it.  They also will tend to have objects
that are so old that at least one ref in the repository will point
at their entire DAG and thus everything would carry over on a repack.

So this would be cleaner then messing around with temporary refs and
gets us the historical pack feature we've been looking to implement.

-- 
