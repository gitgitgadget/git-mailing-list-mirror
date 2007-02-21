From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: removing content from git history
Date: Wed, 21 Feb 2007 16:21:30 -0500
Message-ID: <20070221212129.GD26525@spearce.org>
References: <20070221164527.GA8513@ginosko.local> <20070221165636.GH25559@spearce.org> <20070221171738.GA9112@fieldses.org> <Pine.LNX.4.64.0702210934470.4043@woody.linux-foundation.org> <20070221210045.GB26525@spearce.org> <Pine.LNX.4.64.0702211306520.4043@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Michael Hendricks <michael@ndrix.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 21 22:25:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJyy1-0006iv-Q5
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 22:25:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423163AbXBUVWx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 16:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423166AbXBUVWg
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 16:22:36 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:52983 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423163AbXBUVWR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 16:22:17 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HJytw-0000rP-3h; Wed, 21 Feb 2007 16:21:26 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 18EB220FBAE; Wed, 21 Feb 2007 16:21:30 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702211306520.4043@woody.linux-foundation.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40327>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> The probnlem there is that most conversion scripts that use 
> "write_sha1_file()" will want to *read* that file later. If 
> git-fast-import hasn't generated the pack yet (because it's still waiting 
> for more data), that will not work at all.

Yes, indeed...
 
> So then you basically force the conversion script to keep remembering all 
> the old object data (using something like pretend_sha1_file), or you limit 
> it to things that just always re-write the whole object and never need any 
> old object references that they might have written.
> 
> A lot of conversions tend to be incremental, ie they will depend on the 
> data they converted previously.

Which is why I was actually thinking of flipping this on its head.
Libify git-apply and embed that into fast-import, then one of the
native input formats might just be an mbox, or something close enough
that a simple C/perl/sed prefilter could make an mbox into the input.

fast-import can (and does if necessary) go back to access the
packfile it is writing.  It has the index data held in memory and
uses only OBJ_OFS_REF so that sha1_file.c can unpack deltas just
fine, even though we lack an index file and have not completely
checksummed the pack itself.

So although no other Git process can use the packfile, it is usuable
from within fast-import...

-- 
Shawn.
