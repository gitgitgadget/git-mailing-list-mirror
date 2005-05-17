From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/4] Pulling refs files
Date: Tue, 17 May 2005 18:20:40 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505171802570.30848-100000@iabervon.org>
References: <20050517214533.GP7136@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed May 18 00:29:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYAX2-0001ch-6s
	for gcvg-git@gmane.org; Wed, 18 May 2005 00:27:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbVEQW0s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 May 2005 18:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262039AbVEQWXH
	(ORCPT <rfc822;git-outgoing>); Tue, 17 May 2005 18:23:07 -0400
Received: from iabervon.org ([66.92.72.58]:49158 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262038AbVEQWVQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2005 18:21:16 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DYAQa-0002Ft-00; Tue, 17 May 2005 18:20:40 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050517214533.GP7136@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 17 May 2005, Petr Baudis wrote:

> Dear diary, on Tue, May 17, 2005 at 11:20:54PM CEST, I got a letter
> where Daniel Barkalow <barkalow@iabervon.org> told me that...
> > Hmm... maybe the right thing is to make the implementation-provided
> > transfer code handle arbitrary things in GIT_DIR, but have code for
> > updating reference files atomically and using a reference file to start
> > from use "refs/"? Certainly, there's nothing special about reference files
> > in transit.
> > 
> > Certainly the things in the info/ directory shouldn't be treated a head
> > that you're going to pull, so that has to be different above the protocol
> > level anyway.
> 
> *confused* :) I'm sorry, I have trouble understanding this. Could you
> rephrase, please?

If you want to get info/ignore, you want to get it and save it, not
download a set of objects it refers to. So it's different from specifying
that you want to use refs/heads/master as the starting point for a pull.

There would be a separation between transfering whatever file you specify
and treating the specified (remote) file from refs/ as the starting point
for pulling objects.

Also, you don't need to do the same kind of careful update, since the
desired value of info/ignore isn't going to depend on the previous
value.

> > So the remote receiver should get an instruction: change X from OLD to NEW
> > and pull NEW. It should:
> > 
> >  - lock the file against further updates
> >  - check that the current value is the provided OLD
> >  - pull the necessary objects
> >  - write NEW to the file
> - unlock the file ;-))

The way I'm actually doing things is to write NEW into the lock file at
some arbitrary point, and "writing to the file" is actually renaming the
lock file to the normal filename. So writing unlocks the file
automatically.

> >  - report success
> > 
> > On failure of any step, it should unlock the file without changing it.
> 
> Sounds right.

I think I'll get to implementing it Wednesday night. I might be able to
get the first step done tonight (my previous patch, except with the
transfer applying to arbitrary files).

	-Daniel
*This .sig left intentionally blank*

