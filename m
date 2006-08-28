From: Nicolas Pitre <nico@cam.org>
Subject: Re: Packfile can't be mapped
Date: Mon, 28 Aug 2006 10:40:49 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0608281026110.3683@localhost.localdomain>
References: <9e4733910608271804j762960a8ud83654c78ebe009a@mail.gmail.com>
 <20060828024720.GD24204@spearce.org>
 <Pine.LNX.4.64.0608280014190.3683@localhost.localdomain>
 <Pine.LNX.4.64.0608272133390.27779@g5.osdl.org>
 <20060828060029.GB25285@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 28 16:41:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHiId-0002cN-2t
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 16:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbWH1OlK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 10:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751011AbWH1OlK
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 10:41:10 -0400
Received: from relais.videotron.ca ([24.201.245.36]:40848 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750846AbWH1OlI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Aug 2006 10:41:08 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J4P002DTQ411DE0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 28 Aug 2006 10:40:49 -0400 (EDT)
In-reply-to: <20060828060029.GB25285@spearce.org>
X-X-Sender: nico@localhost.localdomain
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26159>

On Mon, 28 Aug 2006, Shawn Pearce wrote:

> Linus Torvalds <torvalds@osdl.org> wrote:
> > 
> > On Mon, 28 Aug 2006, Nicolas Pitre wrote:
> > > 
> > > Good job indeed.  Oh and you probably should not bother trying to 
> > > deltify commit objects at all since that would be a waste of time.
> > 
> > It might not necessarily always be a waste of time. Especially if you have 
> > multiple branches tracking a "maintenance" branch, you often end up having 
> > the same commit message repeated several times in "unrelated" commits 
> > (they're really the same commit, applied to another branch).
> > 
> > Also, I could imagine that some automated system generates very verbose 
> > (and possibly very regular) commit messages, so under certain 
> > circumstances it may well make sense to see if the commits migth delta 
> > against each other.
> > 
> > But I'll agree that in normal use it's not likely to be a huge saving, 
> > though. It's probably not worth doing for the fast importer unless it just 
> > happens to fall out of the code very easily.
> 
> Does git-pack-objects attempt to delta commits against each other?

Yes it does.  But simply because it requires no special case in the code 
for that and it can afford spending more time trying to tighten a pack 
given that it wastes a lot of cycles with delta windows already.  In the 
context of an intermediate pack from fast-import I doubt it is worth it 
since the extra time spent on that won't give you a significant size 
reduction.

> I've been thinking about applying a pack-local but zlib-stream
> global dictionary.  If we added three global dicationaries to the
> front of the pack file, one for commits, one for trees and one
> for blobs, and use those as the global dictionaries for the zlib
> streams stored within that pack we could probably get a good space
> savings for trees and commits.
> 
> I'd suspect that for many projects the commit global dictionary
> would contain the common required strings such as:
> 
>   'tree ', 'parent ', 'committer ', 'author ', 'Signed-off-by: '
> 
> plus the top author/committer name/email combination strings.
> For GIT I'd expect 'Junio C Hamano <junkio@cox.net>' to be way up
> there in terms of frequency within commit objects.  Finding the most
> common authors and committer strings would be trivial, as would
> finding the most common 'footer' strings such as 'Signed-off-by: '
> and 'Acked-by: '.
> 
> I think the same is true of trees, with '10644 ', '10755 ', '40000 '
> being way up there, but also file names that commonly appear within
> trees, e.g. "Makefile.in\0".

Indeed.

> Blobs would be more difficult to generate a reasonable global
> dictionary for.  But for some projects a crude estimated dictionary
> can shave off at least 4% of pack size (true in both GIT and Mozilla
> sources it seems).
> 
> 
> Of course the major problem with pack-local, stream global
> dictionaries is it voids the ability to reuse that zlib'd content
> from that pack in another pack without wholesale copying the
> dictionary as well.  This is an issue for servers which want to
> copy out the pack entry without recompressing it but also want the
> storage savings from the global dictionaries.

Why would copying the dictionary as well be a problem?  How large might 
it be?  Can it be stored deflated itself?

> But then again, if we just delta against a commit which uses the
> same author and committer, or against the same tree but different
> version then there should be a lot of delta copying from the base...
> which easily allows entry reuse and should provide similiar space
> savings, providing the delta depth is deep enough (or the delta graph
> is wide enough) to minimize the number of base objects containing
> repeated occurrances of the common strings.

This is already attempted by pack-objects and used when it provides a 
gain.  It is just much less likely to happen than with trees or blobs.


Nicolas
