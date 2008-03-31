From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH/RFC] Allow "git remote --mirror" to mirror stashes
Date: Sun, 30 Mar 2008 23:03:21 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803302239220.19665@iabervon.org>
References: <1205499956.7589.4.camel@gentoo-jocke.transmode.se> <1205604534.7589.20.camel@gentoo-jocke.transmode.se> <7vbq4z4bl1.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0803281124240.19665@iabervon.org> <7vve33vj7a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, joakim.tjernlund@transmode.se
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 31 05:04:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgAJa-0002hb-Of
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 05:04:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752813AbYCaDDY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2008 23:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbYCaDDX
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 23:03:23 -0400
Received: from iabervon.org ([66.92.72.58]:60576 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751286AbYCaDDX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2008 23:03:23 -0400
Received: (qmail 25683 invoked by uid 1000); 31 Mar 2008 03:03:21 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 31 Mar 2008 03:03:21 -0000
In-Reply-To: <7vve33vj7a.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78546>

On Sun, 30 Mar 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > On Thu, 27 Mar 2008, Junio C Hamano wrote:
> >
> > Maybe it shouldn't do any filtering here, and instead do it in 
> > cmd_fetch_pack?
> 
> I dunno.  How would the code look like?

Actually, I don't see any reason to call check_ref_format. The point of 
filter_refs is to make sure that we don't fetch anything we didn't ask 
for. We shouldn't care at all about the name of the refs we're considering 
except whether there's in the list to fetch, and if the user requests the 
objects for a ref named 'refs/*^&+' and the server offers such a ref, 
there's no reason for us not to get the objects. (Sure, we shouldn't 
create the ref with that name, but this code path doesn't go on the create 
refs based on these names, except when it's already checking their format 
for that purpose anyway.)

So I'd say just drop the first "if" in that sequence entirely. The only 
thing that could be a problem we'd want to stop here is something that 
would break the packet protocol, and we've already gotten these values 
over the packet protocol anyway.

> > This is also true, although I'm not too sure that we won't want to do 
> > things like having "refs/default" in a public repository be the 
> > repository's suggestion for the default branch (to replace "HEAD", 
> > because, in a world where people use lots of branches, the "current 
> > branch" idea and the "default branch" idea aren't really the same idea, 
> 
> In a public repository with many branches to serve people with different
> interests, I do not think a single refs/default in addition to HEAD would
> help that much.  We would _not_ want to have more magic refs like HEAD.
> 
> Quite the opposite.  In such a repository, HEAD means even less, and
> instead of giving an extra layer of indirection, you tell people which
> branches are what in your repository.  "If you are interested in only the
> bugfixes without any new features since the last feature lease no matter
> how solid and tested they are, use 'maint' branch.  If you want solid and
> tested features, and do not mind new features, use 'master'.  Etc.".

It's not a particularly *useful* default, but "git-clone" presumably 
should initially check out *something* given a repository with multiple 
branches and no local user guidance. And, if this is the git.git 
repository, and you briefly check out each branch in turn to build it when 
you push new changes, then HEAD is usually master but briefly, rarely, and 
irrelevantly other things.

I'm not convinced that it's something worth actually implementing. But I 
think it's a plausible enough idea that we shouldn't exclude the 
possibility of one-level public refs. There are various usues people find 
for this sort of low-semantics pointer on FTP sites, so it could be useful 
in git as well.

	-Daniel
*This .sig left intentionally blank*
