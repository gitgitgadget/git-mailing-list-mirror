From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [ANNOUNCE] Cogito-0.12
Date: Fri, 8 Jul 2005 11:56:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0507081139490.30848-100000@iabervon.org>
References: <20050708081458.GA17022@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>,
	Tony Luck <tony.luck@gmail.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 08 17:59:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqvFq-0004b6-HO
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 17:59:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262693AbVGHP67 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jul 2005 11:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262696AbVGHP67
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jul 2005 11:58:59 -0400
Received: from iabervon.org ([66.92.72.58]:52484 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262693AbVGHP66 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jul 2005 11:58:58 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DqvDX-0005fH-00; Fri, 8 Jul 2005 11:56:43 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050708081458.GA17022@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 8 Jul 2005, Petr Baudis wrote:

> It seems like the whole pull family is totally borked now, and I'm
> getting desperate. Looks like this evening will be *pull.c fixing for
> me.
> 
> Jul 04 Daniel Barkalow  [PATCH 0/2] Support for transferring pack files in git-ssh-*
> 
> is what brings some hope to my life, though. Daniel? Any chance we could
> get the similar fixes for local-pull? (I didn't actually look at the
> patch but briefly.)

This patch is not actually for transferring objects which are in pack
files in the source, but for transferring a group of objects as a pack
file. It does, however, read the source side with git-pack-objects to
generate the content to send, so it would, I guess, fix the problem for
the case where it decides to use a pack to transfer.

The real fix is to go through the pull methods (local-pull and
ssh-pull; http-pull presumably won't be encountering pack files yet) and
make them do appropriate things with pack files.

One thing that is in the patch is a change to the comment, specifying
that fetch() could also get other objects in addition to the one
specified, if there's some reason to think this is a good idea; the fix
for local-pull is probably to link/symlink/copy the pack file if the
object is in one.

For ssh-pull, serve_object in ssh-push needs to be taught how to extract
an object from a pack file and send it.

However, there's a bug in pull.c, covering up a terrible performance
issue: it doesn't actually make sure you have all the parent of a commit
that you had when it checked (due to not having a way of caching the
result of checking this, which would require you to put the entire
repository through cache each time you pull). This would mean that, if you
have a pack that references something outside of it, you won't get
everything with my proposal above.

I should be able to spend some time on these issues over the weekend.

	-Daniel
*This .sig left intentionally blank*
