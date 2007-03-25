From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Understanding version 4 packs
Date: Sun, 25 Mar 2007 05:40:34 -0400
Message-ID: <20070325094033.GJ25863@spearce.org>
References: <20070324202356.GA20734@bohr.gbar.dtu.dk> <20070325084641.GG25863@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Eriksen <s022018@student.dtu.dk>
X-From: git-owner@vger.kernel.org Sun Mar 25 11:40:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVPDT-00034m-SL
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 11:40:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbXCYJki (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 05:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbXCYJki
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 05:40:38 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44720 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbXCYJkh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 05:40:37 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HVPDF-0001pA-DV; Sun, 25 Mar 2007 05:40:33 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2403020FBAE; Sun, 25 Mar 2007 05:40:34 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070325084641.GG25863@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43050>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> So what you will find is that the EXTOBJ_FILENAME_TABLE is dumped
> out behind all of the commits, but before the first OBJ_DICT_TREE,
> and since all trees tend to get converted to an OBJ_DICT_TREE,
> the EXTOBJ_FILENAME_TABLE is sandwiched exactly between the commits
> and the trees.
...
> The reason we put the EXTOBJ_FILENAME_TABLE behind the commits is
> we often walk the commit chains (following parent pointers) without
> looking at the trees at all.  Consider `git log`, in the default
> settings we don't need the trees.  By keeping the filename table
> behind the commits the OS read-ahead buffering gets a better chance
> at loading all of the data we need, and none of the data we don't.
> 
> So that's why its where it is.

I just talked with Junio about this on #git.

My real reason for putting the EXTOBJ_FILENAME_TABLE here is
"lack of a better reason".  I just didn't write that above.  ;-)

We want it before the first OBJ_DICT_TREE to help the unpackers.

And just like we don't currently ever store the delta base for an
OBJ_TREE before the first commit (as commits always get packed first)
we also don't store the EXTOBJ_FILENAME_TREE before the first commit.

Junio raised the point that in large projects `git log -- asm/i386`
can be a very common/useful/necessary operation, and that in such
cases we need to evaluate trees as part of the log operation.
Any attempt to optimize for git-log without a path spec is wrong,
wrong, wrong.  I agree.

The part I quoted above was not trying to imply that Nico and I
are optimizing for using git-log without a path limiter.  It just
read that way to Junio, and may read that way for others too.
Hence this follow-up.

I'm open to suggestions about placement for EXTOBJ_FILENAME_TABLE,
but I think its current position between commits and trees is the
probably the best we can get.

-- 
Shawn.
