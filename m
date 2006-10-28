X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: fetching packs and storing them as packs
Date: Sat, 28 Oct 2006 03:21:46 -0400
Message-ID: <20061028072146.GB14607@spearce.org>
References: <Pine.LNX.4.64.0610252333540.12418@xanadu.home> <4540CA0C.6030300@tromer.org> <Pine.LNX.4.64.0610271310450.3849@g5.osdl.org> <7v3b99e87c.fsf@assigned-by-dhcp.cox.net> <20061028034206.GA14044@spearce.org> <Pine.LNX.4.64.0610272109500.3849@g5.osdl.org> <7vwt6l9etn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 28 Oct 2006 07:22:08 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vwt6l9etn.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30369>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdiVy-0004v9-Pg for gcvg-git@gmane.org; Sat, 28 Oct
 2006 09:21:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751889AbWJ1HVy (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006
 03:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751890AbWJ1HVy
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 03:21:54 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:19856 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1751889AbWJ1HVx
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006 03:21:53 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GdiVn-0003UU-DP; Sat, 28 Oct 2006 03:21:47 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 E2C6420E45B; Sat, 28 Oct 2006 03:21:46 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> > I would MUCH rather we just rename the index/pack file to something that 
> > git can _use_, but that "git repack -a -d" won't remove....
> 
> Two points.
> 
> The "locking" I mentioned was between receive-pack and repack -a
> -d; upload-pack (what millions people are using to read from the
> repository you are pushing into) is not affected.  So in that
> sense, we can afford to use lock without much contention.

And giving how difficult locking is to get on most filesystems I'd
just rather avoid any sort of locking whenever possible.  That's one
reason why reflog is 1 file per ref and not 1 file per repository...
 
> I just thought of a cute hack that does not involve renaming
> packs at all (so no need to match new-pack-X.pack with
> pack-X.idx), and Shawn's sequence actually would work, which is:

I take this above statement to mean that you answered your own
question about how my sequence is able to resolve the race condition?
 
> The receive-pack side:
> 
>   a. Create temporary pack file in $GIT_DIR/objects/pack_XXXXX.
>   b. Create temporary index file in $GIT_DIR/objects/index_XXXXX.
>   c. Write pack and index, in "inactive" state.
>   d. Move pack to $GIT_DIR/objects/pack/...
>   e. Move idx to $GIT_DIR/objects/pack...
>   f. Update refs.
>   g. Mark new pack and idx as "active".
> 
> The "repack -a -d" side:
> 
>   1. List all active packs and store in memory.
>   2. Repack only loose objects and objects contained in active packs.
>   3. Move new pack and idx into $GIT_DIR/objects/pack/...
>   4. Mark new pack and idx as "active".
>   5. Delete active packs found by step #1.
> 
> Pack-idx pair is marked "active" by "chmod u+s" the .pack file.
> During the normal operation, all .pack/.idx pair in objects/pack/
> directories are usable regardless of the setuid bit; we would
> never make .pack files executable so u+s would not otherwise
> hurt us either.  "active" probably is better read as "eligible
> for repacking".

As cool as that trick is I'm against using the file mode as a
way to indicate the status of a pack file.  For one thing not
every filesystem that Git is used on handles file modes properly.
We already have core.filemode thanks to some of those and I use
Git on at least one of those "not so friendly" filesystems...

Why not just use create a new flag file?

Lets say that a pack X is NOT eligible to be repacked if
"$GIT_DIR/objects/pack/pack-X.keep" exists.

Thus we want to have the new ".keep" file for historical packs and
incoming receive-pack between steps c and g.  In the former case
the historical pack is already "very large" and thus one additional
empty file to indicate we want to retain that pack as-is is trivial
overhead (relatively speaking); in the latter case the lifespan of
the file is relatively short and thus any overhead associated with it
on the local filesystem is free (it may never even hit the platter).

In the sequence above we create pack-X.keep between steps b and c
during receive-pack ensuring that even before the pack is usable by
a Git reader process that it can't be swept up by a `repack -a -d`
and we delete the pack-X.keep file in step g to mark it active.

Further only repack and the receive-pack side code changes: all
existing packs are automatically taken to be active while only
packs coming in from receive-pack or those marked by a human as
"historical" will be kept.

Two birds, one stone.  Thoughts?

-- 
