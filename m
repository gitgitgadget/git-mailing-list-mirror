From: Junio C Hamano <junkio@cox.net>
Subject: Re: My Itchlist
Date: Sat, 06 Aug 2005 12:04:33 -0700
Message-ID: <7voe8a6g5a.fsf@assigned-by-dhcp.cox.net>
References: <7v8xzfde7t.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508051924390.3258@g5.osdl.org>
	<Pine.LNX.4.63.0508060846050.12882@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 21:05:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1TyN-0006PR-Vb
	for gcvg-git@gmane.org; Sat, 06 Aug 2005 21:04:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263412AbVHFTEk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Aug 2005 15:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263420AbVHFTEj
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Aug 2005 15:04:39 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:42196 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S263412AbVHFTEg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2005 15:04:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050806190436.SHBW1860.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 6 Aug 2005 15:04:36 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0508060846050.12882@wgmdd8.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 6 Aug 2005 08:50:11 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I think that we need a method to do a push in reverse: If a central 
> repository has several branches, I might want to pull just those branches 
> where the local head is a strict parent of the remote side, and get 
> complains for the others. And maybe reference naming comes as a freebie 
> with that.

I can first run "git ls-remote" to discover what are available
heads and tags, and choose to "git fetch" without actually
merging nor touching my references if I did not want to.  I
could then attempt to "git resolve" offline, and if it results
in a real merge, not fast forward, and if I am in a hurry and do
not want to risk merging without thinking, I can just keep my
head and defer the merging part.  I think that is what you are
getting at by "pull only when local is a strict parent of the
remote".

It is really the matter of where the ancestry computation
happens.  You seem to think you would want to do it on the
central server side, but I tend to think that should be done on
the puller's side, like I outlined above.  There are two
reasons:

 (1) as you mentioned in a separate topic, the current
     upload-pack/fetch-pack protocol pair seems to put a
     nontrivial burden on the server side.  I'd prefer to have
     the client side do more work.

 (2) You are interested in that remote branch, so while you may
     not want to merge the upstream changes into the branch you
     have your local modifications right away, it is likely you
     eventually will.  Fetching the objects would not be a
     wasted traffic.

What Linus said makes a lot of sense to me.  While the current
"git fetch" user interface captures a commonly used pattern of
fetching a single remote reference and optionally storing that
remote reference as a local reference under refs/heads, it is
cumbersome to use when you want to slurp objects needed for
multiple remote references and not store the references
themselves anywhere.
