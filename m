From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Re: git-http-pull broken in latest git
Date: Fri, 12 Aug 2005 11:37:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508121111070.12816@iabervon.org>
References: <42F8D472.3080404@de.bosch.com> <20050811223349.GI25280@pasky.ji.cz>
 <7v4q9wf4ad.fsf@assigned-by-dhcp.cox.net> <20050812024552.GO25280@pasky.ji.cz>
 <Pine.LNX.4.63.0508112256430.12816@iabervon.org> <7vll37afz4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 17:35:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3bYA-0007NC-9b
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 17:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbVHLPeY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 11:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbVHLPeY
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 11:34:24 -0400
Received: from iabervon.org ([66.92.72.58]:60429 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751099AbVHLPeX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Aug 2005 11:34:23 -0400
Received: (qmail 19409 invoked by uid 1000); 12 Aug 2005 11:37:37 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Aug 2005 11:37:37 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vll37afz4.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 11 Aug 2005, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > Petr Baudis <pasky@suse.cz> writes:
> >> Yes, but cg-clone doesn't - it naively depended on the core git tools
> >> actually, er.. working. ;-)
> 
> Sorry about that.  I used to have a wrapper to deal with packs
> around http-pull before Daniel's pack enhancement, and yanking
> it before really checking that enhanced http-pull actually
> worked was my fault as well.

It was actually the patches after the http-pull fixes (the ones for 
parallelizing pull.c) that broke things; one advantage to fixing 
local-pull would be that you can set up tests for it reasonably 
effectively, which would have caught the regression.

> > At some point, I have to revisit getting git-ssh-* to generate exactly the 
> > required pack and transfer that, but that's an efficiency issue, not a 
> > correctness one, and shouldn't be relevant to the problem you're having.
> 
> Wouldn't enhancing ssh-push to generate packs on the fly involve
> reinventing send-pack and/or upload-pack?

The idea is that you wouldn't have to identify what situation applied 
yourself; you could just invoke git-ssh-pull/git-ssh-push, and it would 
happen faster due to the compression benefits. The point is that scripts 
can just pick which git-*-pull to use based on the format of the remote 
branch address, without variation in behavior.

> The same thing can be said about local-pull to a lesser degree.
> Lesser because people, including Pasky who said so on the list
> recently, would like its hard-linking behaviour, and its not
> exploding the existing packs, which send-pack and upload-pack
> would not give.  So I would rate local-pull higher than
> ssh-push/pull on the priority scale if I were doing them.

This is a higher priority, but writing more than bugfixes is unpleasent at 
the moment due to my home workstation's monitor dying, so it'll probably 
be next week that I'll get to it. The git-ssh-* stuff is longer-term, 
since it works now, and isn't even all that slow with the overlapping 
requests.

You could, actually, probably do the local-pull fix if you wanted. I seem 
to recall that being your code originally; you just need to have fetch() 
identify that an object is in a pack, copy/link/symlink the index and 
pack instead of the object file, and add the pack to the list of 
registered packs. I've mostly been failing to deal with reading an index 
file that is in some directory that hasn't been registered as somewhere to 
read from (i.e. the source repository).

	-Daniel
*This .sig left intentionally blank*
