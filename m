From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] pull: gracefully recover from delta retrieval failure.
Date: Sun, 5 Jun 2005 13:24:05 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506051256450.30848-100000@iabervon.org>
References: <1117989532.10424.7.camel@port.evillabs.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 19:22:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Deyp8-0001m8-BC
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 19:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbVFERZW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 13:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbVFERZW
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 13:25:22 -0400
Received: from iabervon.org ([66.92.72.58]:11014 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261588AbVFERZN (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jun 2005 13:25:13 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1Deyqz-00079a-00; Sun, 5 Jun 2005 13:24:05 -0400
To: Jason McMullan <jason.mcmullan@timesys.com>
In-Reply-To: <1117989532.10424.7.camel@port.evillabs.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 5 Jun 2005, Jason McMullan wrote:

> (Or, if you'd like, I can rework pull.c to use the
>  verification-before-store technique I used in my git-daemon patch, so
>  all the *-pull mechanisms will be 'safe')

The reasons I don't really want a verification-before-store are:

 - I'd like things to be resumable on error; if you've already got a bunch
   of stuff and then the connection breaks, you should already have the
   things you got; so, at least, the temporary locations should be
   something predictable from the hash.

 - I'd like the user to be able to intentionally get partial repositories
   of various sorts, and still have consistant information. If I don't
   have anything written that's not in mainline, and I'm not going to be
   applying other people's patches, and I don't have an up-to-date
   repository, I'd like to be able to pull just mainline's head commit and
   tree, and work from there. I don't need the history unless I want to
   look up changes or want to merge something that's not derived entirely
   from the head I've got.

So what I'd really like is something where you store whatever objects you
have, and also have extra information about what objects you know about
but don't have and what objects you've gotten completely. Of course, this
needs to be kept manageable.

(Along the lines of the second one, there's a variety of partial
information which is sufficient for various purposes. If I trust that
Linus's latest tree is based on my most recent pull from him, I can
fast-forward with just the tree. I can also merge his tree into mine with
just the commits and his latest tree, since I must already have any common
ancestors. In all these cases, I may want to streamline my process by
doing "pull tree; pull all &; checkout" or 
"pull tree,commits; pull all &; merge", so that I can start on further
development while the rest of the information fills in.)

So I'd greatly prefer to keep the metadata of what objects we have
explicitly, rather than implicitly in the presence or absence of files in
the object directory. Also, for objects which we expect to be missing, it
would be good to keep info on where we expect to be able to get
them. Then, if I'm wrong about what I actually needed, it doesn't need me
to tell it again where to get things.

	-Daniel
*This .sig left intentionally blank*

