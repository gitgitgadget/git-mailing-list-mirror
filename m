From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] git-ssh-pull: commit-id consistency
Date: Sun, 26 Jun 2005 16:11:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506261550460.30848-100000@iabervon.org>
References: <20050626214547.A29432@tin.liacs.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 26 22:07:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DmdP8-0001dh-R6
	for gcvg-git@gmane.org; Sun, 26 Jun 2005 22:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbVFZUNi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Jun 2005 16:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbVFZUNi
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jun 2005 16:13:38 -0400
Received: from iabervon.org ([66.92.72.58]:23302 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261571AbVFZUNf (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jun 2005 16:13:35 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DmdTq-0006Bf-00; Sun, 26 Jun 2005 16:11:50 -0400
To: Sven Verdoolaege <skimo@liacs.nl>
In-Reply-To: <20050626214547.A29432@tin.liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 26 Jun 2005, Sven Verdoolaege wrote:

> I thought about keeping the check for a leading dot or slash,
> but then I figured that you'd get an error from the other
> side pretty quickly.
> 
> skimo
> --
> In contrast to other plumbing tools, git-ssh-pu{sh,ll} only
> allow a very restrictive form of commit-id filenames.
> This patch removes this restriction.

There are a few problems with this: not all pull methods can handle
vagueness; HTTP, for instance, needs to know exactly what URL to request,
and it can't deal with having the user request just anything. Also, it's
not particularly useful to support just anything as the hash to start
from, when you have to specify exactly the file to write the ref to (the
-w argument), which would be a lot more difficult and flaky, because we
can't just look for the only thing that works.

More generally, I think we should require explicit instructions, even when
we might be able to figure things out, when we're moving data between
repositories, similar to how we are strict about the data stored in
repositories (although, of course, we need to support a few more cases).

In addition, I think that stuff outside of objects/ and refs/ (and, when
we have something in it, info/) should be considered private, and not
transmitted from place to place.

One thing that might be a good idea, however, is to allow using symlinks
from .git/ to refs/<x>/<y> on the local side of git-ssh-push by converting
them to <x>/<y>. That way, when you push "HEAD", it will actually push
refs/heads/my-current-branch instead. Of course, the -w issue remains,
because you may have different names on the other side (i.e., on the local
side, it might be refs/heads/new-diff-algo, but the remote side might be
refs/heads/my-latest).

Really, the right solution is to keep this sort of info somewhere and have 
scripts do the right thing with exact specifications.

	-Daniel
*This .sig left intentionally blank*
