From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 00/15] git-note: A mechanisim for providing free-form after-the-fact annotations on commits
Date: Mon, 28 May 2007 23:22:21 -0400
Message-ID: <20070529032221.GE7044@spearce.org>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org> <200705281840.50814.johan@herland.net> <alpine.LFD.0.98.0705280957070.26602@woody.linux-foundation.org> <200705281948.27329.johan@herland.net> <7vwsysbrtg.fsf@assigned-by-dhcp.cox.net> <20070528213511.GB7044@spearce.org> <alpine.LFD.0.98.0705282008400.26602@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue May 29 05:22:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HssI7-0005al-Ta
	for gcvg-git@gmane.org; Tue, 29 May 2007 05:22:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754155AbXE2DW3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 23:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754654AbXE2DW3
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 23:22:29 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36797 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754155AbXE2DW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2007 23:22:28 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HssHi-0008EZ-T5; Mon, 28 May 2007 23:22:11 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 97BD520FBAE; Mon, 28 May 2007 23:22:21 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0705282008400.26602@woody.linux-foundation.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48663>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> On Mon, 28 May 2007, Shawn O. Pearce wrote:
> > 
> > What if we use a "slow" storage by "refs/notes/$objname/$notename",
> 
> This _really_ won't scale. Even if the notes don't exist, just doing the 
> lookup (which will fail for most commits) will be horribly slow, and will 
> populate the dentry cache with negative entries.

Yes.

I think you missed what I was trying to say.  We *definately* do not
want to probe the OS and ask "do you have $objname1? $objname2?"
for exactly the reason you just stated.  (Though you being some
sort of kernel guru means you know a hellva lot more about that
dentry cache thing than I do!)

What I meant was something more like:

	DIR *d = opendir("refs/notes");
	if (d) {
		... notes can exist in both packfiles and "loose" ...
		only_packed_notes = 0;

		while (readdir(d)) {
			... the entry name here is the name of an object ...
			... stuff into a hash table, we can come back later ...
			... for the subdirectory contents if we need it ...
		}
		closedir(d);
		... also examine "packed-refs", in case any are there ...
	} else {
		only_packed_notes = 1;
		... we *only* have notes in packfiles, if we have any at all...
	}

Then looking up a note is just a probe into our in-memory hash
(if only_packed_notes is false) and a probe into the packfile(s) to
find the notes for the object.  Not very expensive if the packfiles
have the reverse obj->tag mappings indexed within them.
 
> To get good filesystem performance, you have to
>  - have reasonable hit-rates (and looking it up for each commit is _not_ 
>    going to do that)
>  - not have millions of objects.

Which is why we:

  a) allow these things to migrate into packed-refs, because
  getting into there is a hellva lot cheaper than getting into
  a packfile;

  b) move them into a packfile when we repack loose objects,
  because then we have really good access.

  c) take them out of packed-refs once they are into a packfile,
  and get them out of the loose refs/notes directory as early as
  possible.

-- 
Shawn.
