From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/4] Pulling refs files
Date: Tue, 17 May 2005 17:20:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505171645130.30848-100000@iabervon.org>
References: <20050517201436.GC7136@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue May 17 23:23:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DY9V9-00013y-AH
	for gcvg-git@gmane.org; Tue, 17 May 2005 23:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbVEQVVo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 May 2005 17:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbVEQVVo
	(ORCPT <rfc822;git-outgoing>); Tue, 17 May 2005 17:21:44 -0400
Received: from iabervon.org ([66.92.72.58]:53509 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261937AbVEQVV0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2005 17:21:26 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DY9Uk-0008P5-00; Tue, 17 May 2005 17:20:54 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050517201436.GC7136@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 17 May 2005, Petr Baudis wrote:

> Dear diary, on Sun, May 15, 2005 at 05:23:18AM CEST, I got a letter
> where Daniel Barkalow <barkalow@iabervon.org> told me that...
> > On Sat, 14 May 2005, Petr Baudis wrote:
> > 
> > > So what about just something like
> > > 
> > > 	git-wormhole-pull remote:refs/head/master wormhole://localhost/
> > > 
> > > That is, you could just specify remote:path_relative_to_url instead of
> > > SHA1 id as the commit.
> > 
> > Do you have any sensible alternatives to "remote:refs/<something>" in
> > mind? I suppose that "remote:HEAD" would also work. How are you thinking
> > of having the value get written locally?
> 
> Anything that gets eventually wound up in the info/ directory. (The name
> of the ignore file saved in info/ignore is the current hit.)

Hmm... maybe the right thing is to make the implementation-provided
transfer code handle arbitrary things in GIT_DIR, but have code for
updating reference files atomically and using a reference file to start
from use "refs/"? Certainly, there's nothing special about reference files
in transit.

Certainly the things in the info/ directory shouldn't be treated a head
that you're going to pull, so that has to be different above the protocol
level anyway.

> Well, it'd be again nice to have some generic mechanism for this so that
> the user could theoretically push over rsync too or something (although
> that'll be even more racy, it is fine for single-user repository).

Hmm; I'm not sure what would be good for interfacing with rsync.

> I think the remote file to write the value inside should be porcelain
> business.

Certainly it's porcelain business what remote file to write; but I think
it has to be core business doing the lock, test, and update. I think it
would be inconvenient to go back to the porcelain layer in the middle of
the operation, particularly since it would have to go back to the core,
which is what has the connection to the remote host.

> What you should always check though is that before the pull
> (and after the locking) the value in that file is the same as the "push
> base". This way you make sure that you are still following a single
> branch and in case of multiuser repositories that you were fully merged
> before pushing.

So the remote receiver should get an instruction: change X from OLD to NEW
and pull NEW. It should:

 - lock the file against further updates
 - check that the current value is the provided OLD
 - pull the necessary objects
 - write NEW to the file
 - report success

On failure of any step, it should unlock the file without changing it.

	-Daniel
*This .sig left intentionally blank*

