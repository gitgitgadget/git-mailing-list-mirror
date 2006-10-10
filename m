From: Shawn Pearce <spearce@spearce.org>
Subject: Re: is git-unpack-objects now redundant for 'git-push' and friends?
Date: Tue, 10 Oct 2006 12:14:05 -0400
Message-ID: <20061010161405.GB16412@spearce.org>
References: <452B9EE8.5020702@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 18:14:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXKFF-00016J-6O
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 18:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030178AbWJJQOL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 12:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030184AbWJJQOK
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 12:14:10 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:30172 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1030178AbWJJQOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 12:14:09 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GXKEy-0001CJ-Ds; Tue, 10 Oct 2006 12:14:00 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1AD6520FB00; Tue, 10 Oct 2006 12:14:05 -0400 (EDT)
To: Sam Vilain <sam@vilain.net>
Content-Disposition: inline
In-Reply-To: <452B9EE8.5020702@vilain.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28635>

Sam Vilain <sam@vilain.net> wrote:
> When pushing or pulling to/from a repository, why unpack the objects?
> Why not just fsck and then throw the pack into $GIT_DIR/objects/pack?
> 
> If you're pushing the entire repository, for instance, currently you
> might create 10,000's of files, which will just be thrown away later
> when you `git-repack -d'.
> 
> I suspect that this was never changed, because there never used to be
> more than one packfile allowed, correct?
> 
> If the server *does* send us duplicates of objects we already have for
> some reason, well that's what `git-repack -a -d' is for.
> 
> I'm just wondering if there are any good reasons to do this any more.

There's still a few good reasons to unpack things, even though I
hate sitting through 5000 objects unpacking on a Windows system,
or a very slow NFS system (one NFS based system I work with unpacks
small <1KiB objects at a rate of about 1 every 15 seconds).

 - We don't completely trust the remote peer.  If the remote sends
   us an object we already have we want to use the bytes we have
   and not the bytes they are sending.  That way even if the remote
   were able to generate a hash collision and produce a replacement
   byte sequence with the same hash, our known good byte sequence
   is not affected.

 - Packs sent over the network can be thin packs.  A think pack
   may not contain the object used as the delta base for a delta
   within that pack.  This is done to save network bandwidth when
   both sides already have the delta base for an object that is
   being transferred.

 - Local packs cannot access delta base objects not in the same
   pack.  This limitation simplifies the pack access code in a
   lot of the system.  It also means that you can in a worst case
   scenario obtain everything in that pack back when all you have
   is the pack file itself.

I'm sure there's more reasons than that, but those are the major
ones.

-- 
Shawn.
