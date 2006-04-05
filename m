From: Shawn Pearce <spearce@spearce.org>
Subject: Re: How should I handle binary file with GIT
Date: Wed, 5 Apr 2006 11:55:28 -0400
Message-ID: <20060405155528.GI14625@spearce.org>
References: <20060405073022.13054.qmail@web25806.mail.ukl.yahoo.com> <7v3bgs4exz.fsf@assigned-by-dhcp.cox.net> <e10mn9$cjs$1@sea.gmane.org> <Pine.LNX.4.64.0604051131010.2550@localhost.localdomain> <86wte4rq3d.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 05 17:55:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRAM9-0005ZW-JS
	for gcvg-git@gmane.org; Wed, 05 Apr 2006 17:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWDEPzi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 11:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWDEPzi
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 11:55:38 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:28612 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751124AbWDEPzh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Apr 2006 11:55:37 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FRALs-00053X-H9; Wed, 05 Apr 2006 11:55:24 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1622520E47A; Wed,  5 Apr 2006 11:55:28 -0400 (EDT)
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Content-Disposition: inline
In-Reply-To: <86wte4rq3d.fsf@blue.stonehenge.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18440>

"Randal L. Schwartz" <merlyn@stonehenge.com> wrote:
> >>>>> "Nicolas" == Nicolas Pitre <nico@cam.org> writes:
> 
> >> IIRC bsdiff is used by Firefox to distribute binary software updates.
> >> Xdelta is generic (not optimized for binaries like bsdiff and edelta), but
> >> supposedly offers worse compression (bigger diffs).
> 
> Nicolas> We already have our own delta code for pack storage.
> 
> I think the issue is related to being able to cherry-pick and merge
> when binaries are involved.  I've been worried about that myself.
> How well are binaries supported these days for all the operations
> we're taking for granted?  When is a "diff" expected to be a real
> "diff" and not just "binary files differ"?

The clearly safe approach is to include the full SHA1 ID of the
old object the patch was created from and use the xdelta in the
patch only as a means of transporting a compressed form of the new
version of the object.  If git-diff starts to export say a base 64
encoding of the xdelta then it should also include the full SHA1
ID for binary files, even if --full-index wasn't given.

git-apply should only apply an xdelta patch to the exact same
old object.  If the tree currently has a different object at that
path then reject the patch entirely.

If a path has a different object then the patch was based on then
we can do one of two things to be ``nice'' to the human:

  - If the old blob exists in the repository (it just isn't the
  current version at that path) then generate a temporary merge
  file holding the old blob with the delta applied.  The user can
  then finish the merge with whatever tool understands that binary
  file format, or do the merge by hand.

  - Supply a ``do it anyway'' flag to git-apply.  If this flag is
  given on the command line then the binary file is patched even
  though the object versions differ.  For some binary file formats
  this may actually be a valid thing to do.  But it probably isn't
  for a very large percentage of known file formats.

I could see some cases where it might be nice to be able to perform
specialized merge handling of binary files via hooks or filters.

For example *.tar.gz, *.zip, *.jar - these files are all just
compressed trees.  They should be somewhat mergeable with the same
semantics as other trees in GIT.  Of course one could just unpack
these into a directory and let GIT track the directory instead,
but this is rather inconvenient in a Java project.  :-)

If I recall correctly OpenOffice document files are XML compressed
into ZIP archives.  The XML *might* diff/patch cleanly as plain text.
The other resources in that archive are typically binary graphic
files and the like, which of course wouldn't diff/patch nicely.
But being able to diff/patch the main content might be semi-useful.

-- 
Shawn.
