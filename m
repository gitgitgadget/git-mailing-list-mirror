From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Packfile can't be mapped
Date: Mon, 28 Aug 2006 02:00:29 -0400
Message-ID: <20060828060029.GB25285@spearce.org>
References: <9e4733910608271804j762960a8ud83654c78ebe009a@mail.gmail.com> <20060828024720.GD24204@spearce.org> <Pine.LNX.4.64.0608280014190.3683@localhost.localdomain> <Pine.LNX.4.64.0608272133390.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 28 08:01:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHaBS-0000Ad-7J
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 08:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbWH1GAw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 02:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWH1GAw
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 02:00:52 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:1945 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751391AbWH1GAu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Aug 2006 02:00:50 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GHaAr-000789-Rm; Mon, 28 Aug 2006 02:00:43 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7B8AA20FB7F; Mon, 28 Aug 2006 02:00:29 -0400 (EDT)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0608272133390.27779@g5.osdl.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26144>

Linus Torvalds <torvalds@osdl.org> wrote:
> 
> On Mon, 28 Aug 2006, Nicolas Pitre wrote:
> > 
> > Good job indeed.  Oh and you probably should not bother trying to 
> > deltify commit objects at all since that would be a waste of time.
> 
> It might not necessarily always be a waste of time. Especially if you have 
> multiple branches tracking a "maintenance" branch, you often end up having 
> the same commit message repeated several times in "unrelated" commits 
> (they're really the same commit, applied to another branch).
> 
> Also, I could imagine that some automated system generates very verbose 
> (and possibly very regular) commit messages, so under certain 
> circumstances it may well make sense to see if the commits migth delta 
> against each other.
> 
> But I'll agree that in normal use it's not likely to be a huge saving, 
> though. It's probably not worth doing for the fast importer unless it just 
> happens to fall out of the code very easily.

Does git-pack-objects attempt to delta commits against each other?


I've been thinking about applying a pack-local but zlib-stream
global dictionary.  If we added three global dicationaries to the
front of the pack file, one for commits, one for trees and one
for blobs, and use those as the global dictionaries for the zlib
streams stored within that pack we could probably get a good space
savings for trees and commits.

I'd suspect that for many projects the commit global dictionary
would contain the common required strings such as:

  'tree ', 'parent ', 'committer ', 'author ', 'Signed-off-by: '

plus the top author/committer name/email combination strings.
For GIT I'd expect 'Junio C Hamano <junkio@cox.net>' to be way up
there in terms of frequency within commit objects.  Finding the most
common authors and committer strings would be trivial, as would
finding the most common 'footer' strings such as 'Signed-off-by: '
and 'Acked-by: '.

I think the same is true of trees, with '10644 ', '10755 ', '40000 '
being way up there, but also file names that commonly appear within
trees, e.g. "Makefile.in\0".

Blobs would be more difficult to generate a reasonable global
dictionary for.  But for some projects a crude estimated dictionary
can shave off at least 4% of pack size (true in both GIT and Mozilla
sources it seems).


Of course the major problem with pack-local, stream global
dictionaries is it voids the ability to reuse that zlib'd content
from that pack in another pack without wholesale copying the
dictionary as well.  This is an issue for servers which want to
copy out the pack entry without recompressing it but also want the
storage savings from the global dictionaries.

But then again, if we just delta against a commit which uses the
same author and committer, or against the same tree but different
version then there should be a lot of delta copying from the base...
which easily allows entry reuse and should provide similiar space
savings, providing the delta depth is deep enough (or the delta graph
is wide enough) to minimize the number of base objects containing
repeated occurrances of the common strings.

-- 
Shawn.
