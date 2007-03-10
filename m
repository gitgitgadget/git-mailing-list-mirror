From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Errors cloning large repo
Date: Fri, 9 Mar 2007 22:07:18 -0500
Message-ID: <20070310030718.GA2927@spearce.org>
References: <645002.46177.qm@web52608.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Anton Tropashko <atropashko@yahoo.com>
X-From: git-owner@vger.kernel.org Sat Mar 10 04:07:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPrvj-0002oH-TA
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 04:07:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793AbXCJDHZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 22:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752796AbXCJDHZ
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 22:07:25 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:53782 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752793AbXCJDHY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 22:07:24 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HPrvJ-000211-T6; Fri, 09 Mar 2007 22:07:10 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5F56A20FBAE; Fri,  9 Mar 2007 22:07:19 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <645002.46177.qm@web52608.mail.yahoo.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41843>

Anton Tropashko <atropashko@yahoo.com> wrote:
> again after git repack and don't see how to work around that aside from artifically
> splitting the tree at the top or resorting to a tarball on an ftp site.
> That 64 bit indexing code you previously mentioned would force me to upgrade git on both ends?
> Anywhere I can pull it out from?

I'm shocked you were able to repack an 8.5 GiB repository.
The default git-repack script that we ship assumes you want to
combine everything into one giant packfile; this is what is also
happening during git-clone.  Clearly your system is rejecting this
packfile; and even if the OS allowed us to make that file the
index offsets would all be wrong as they are only 32 bits wide.
The repository becomes corrupt when those overflow.


Troy Telford (with the help of Eric Biederman) recently posted a
patch that attempts to push the index to 64 bits:

  http://thread.gmane.org/gmane.comp.version-control.git/40680/focus=40999

You can try Troy's patch.  Nico and my's 64 bit index work is *not*
ready for anyone to use.  It doesn't exist as a compileable chunk
of code.  ;-)

Just to warn you, I have (re)done some of Troy's changes and Junio
has applied them to the current 'master' branch.  So Troy's patch
would need to be applied to something that is futher back, like
around 2007-02-28 (when Troy sent the patch).  But my changes alone
are not enough to get "64 bit packfiles" working.


As Linus said earlier in this thread; Nico and I are working on
pushing out the packfile limits, just not fast enough for some users
needs apparently (sorry about that!).  Troy's patch was rejected
mainly because it is a file format change that is not backwards
compatible (once you use the 64 bit index, anything accessing that
repository *must* also support that).

Nico and I are working on other file format changes that are
more extensive than just expanding the index out to 64 bits, and
likewise are also not backwards compatible.  To help users manage
the upgrades, we want to do a single file format change in 2007,
not two.  So we are trying to be very sure that what we give Junio
for final application really is the best we can do this year.

Otherwise we would have worked with Troy to help test his patch and
get that into shape for application to main the git.git repository.


One thing that you could do is segment the repository into multiple
packfiles yourself, and then clone using rsync or http, rather than
using the native Git protocol.

For segmenting the repository, you would do something like:

	git rev-list --objects HEAD >S
	# segment S up into several files, e.g. T1, T2, T3
	foreach s in T*
	do
		name=$(git pack-objects tmp <$s)
		touch .git/objects/pack/pack-$name.keep
		mv tmp-$name.pack .git/objects/pack/pack-$name.pack
		mv tmp-$name.idx .git/objects/pack/pack-$name.idx
	done
	git prune-packed

The trick here is to segment S up into enough T1, T2, ... files such
that when packed they each are less than 2 GiB.  You can then clone
this repository by copying the .git directory using more standard
filesystem tools, which is what a clone with rsync or http is
(more or less) doing.

Yes, the above process is horribly tedious and has a some trial
and error involved in terms of selecting the packfile segmenting.
We don't have anything that can automate this right now.

-- 
Shawn.
