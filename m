From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Deleting remote branch pointed by remote HEAD
Date: Wed, 21 Jan 2009 13:30:10 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0901211237530.19665@iabervon.org>
References: <e29894ca0901210502n1ed1187bm46669a402ab4fe48@mail.gmail.com> <49773240.7090605@drmicha.warpmail.net> <e29894ca0901210638t636de791sf27d28893a7a0b65@mail.gmail.com> <49773E48.90302@drmicha.warpmail.net>
 <20090121161940.GA20702@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	=?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 21 19:31:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPhrW-0005S9-7L
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 19:31:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753944AbZAUSaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 13:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753929AbZAUSaO
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 13:30:14 -0500
Received: from iabervon.org ([66.92.72.58]:54628 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753602AbZAUSaN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 13:30:13 -0500
Received: (qmail 21445 invoked by uid 1000); 21 Jan 2009 18:30:10 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Jan 2009 18:30:10 -0000
In-Reply-To: <20090121161940.GA20702@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106636>

On Wed, 21 Jan 2009, Jeff King wrote:

> On Wed, Jan 21, 2009 at 04:24:56PM +0100, Michael J Gruber wrote:
> 
> > So, you get these errors on the local repo when dealing with the remote
> > repo, right? I guess this means two things:
> > 
> > 1) You are deleting a remote branch
> 
> Actually, he doesn't have to delete the remote branch; somebody else
> can. The problem is that the HEAD pointer for his remote tracking
> branches points to a branch that doesn't exist. This can happen because
> we sometimes update the tracking branches (including deletion) without
> impacting the HEAD pointer.
> 
> There are two ways that I can think of (and there may be more) to
> provoke this:
> 
>   1. delete a remote branch via push. The local side will helpfully
>      delete your local tracking branch to match what happened on the
>      remote. If it was the remote's HEAD, then you get a broken state
>      (and while we discourage pushing to the remote HEAD on a non-bare
>      repo, it is perfectly OK for a bare one).
> 
>   2. somebody else deletes the remote branch that is the HEAD, and you
>      update your tracking branches via "git remote prune", which deletes
>      your tracking branches corresponding to any deleted remote branches.
> 
> And actually there is a slight variant on both of the above. The deleted
> branch does not actually have to be the current HEAD on the remote. It
> just has to match your _idea_ of the current HEAD on the remote, which
> may be out of date.
> 
> Situation (1) happens entirely locally. So it can be fixed fairly easily
> by checking whether the remote tracking HEAD points to a branch we are
> deleting, and deleting the HEAD in that case (the code should be in
> builtin-send-pack.c:update_tracking_ref). Of course you have probably
> also created a broken situation on the remote, so perhaps receive-pack
> should handle that.
> 
> Situation (2) could do something similar: when we see that we are about
> to delete the ref pointed to by the remote tracking HEAD, we could
> delete the HEAD.
> 
> But both situations are a little hack-ish to me. You are deleting the
> HEAD because you don't know what the right value is from the remote end.
> A better fix would be to actually pull the HEAD information down during
> fetch. And I seem to recall a patch about that at some point (it
> required a new protocol extension), but I don't know what become of it.

The information is available already; the only thing is that we don't have 
a way to know that the user wants to get the remote's suggested HEAD; as 
Junio pointed out at the time, a user might decide that "next" is the most 
interesting branch, and set refs/remotes/origin/HEAD to that branch, and 
therefore doesn't want it reset to the remote server's value.

That is, refs/remotes/origin/HEAD is only there to let the user abbreviate 
the most useful branch of the remote; there's no reason it should reflect 
the remote's HEAD, except that the remote's HEAD is a good guess if the 
user hasn't said anything.

I think it might be more appropriate to just care less about a broken 
symref, explain what's wrong if the user actually tries to use it, and 
otherwise mostly ignore it.

	-Daniel
*This .sig left intentionally blank*
