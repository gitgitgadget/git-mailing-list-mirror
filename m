From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Order of push/pull file transfers
Date: Fri, 24 Jun 2005 12:38:43 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506241219140.30848-100000@iabervon.org>
References: <20050623111255.A1162@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 24 18:36:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlrA9-0001DA-G4
	for gcvg-git@gmane.org; Fri, 24 Jun 2005 18:36:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263149AbVFXQmE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Jun 2005 12:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263146AbVFXQmD
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jun 2005 12:42:03 -0400
Received: from iabervon.org ([66.92.72.58]:38150 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S263135AbVFXQkW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jun 2005 12:40:22 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DlrCV-0003sj-00; Fri, 24 Jun 2005 12:38:43 -0400
To: Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20050623111255.A1162@flint.arm.linux.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 23 Jun 2005, Russell King wrote:

> Last night, I pulled Linus' kernel tree from k.o, but Linus was in the
> middle of pushing an update to it.  The way cogito works, it grabs the
> HEAD first, and then rsyncs the objects.

It needs to do this, in case HEAD changes after or during the rsync (to
include objects written after the rsync looked for them).

> However, this retrieved the updated HEAD, and only some of the objects.
> cogito happily tried to merge the result, and failed.  A later pull
> and git-fsck-cache confirmed everything was fine _in this instance_.

It should be fine in all instances; it makes no assuptions about the
presence or absence of objects in the local database before the pull, so
doing a pull after the previous one didn't work right should be just as
likely to result in a functional state as any other pull.

> Therefore, may I suggest the following two changes in the way git
> works:
> 
> 1. a push updates HEAD only after the rsync/upload of all objects is
>    complete.  This means that any pull will not try to update to the
>    new head with a partial object tree.

git-ssh-push only updates the HEAD (or, rather, the thing the HEAD is a
symlink to) afterwards. I'm not sure how Linus was getting things
there. It's also possible that the mirroring process is failing to
maintain this constraint.

> 2. a pull only tries to fetch objects if HEAD has been updated since
>    the last pull.

That's no good; if the only recent change is a new tag, you want to get 
the tag object. Also, having it not do this is what let it recover in your
case on the second try. The only risk is that you'll pick up some objects
that you don't need yet (but would need if you pulled again when the push
completes).

	-Daniel
*This .sig left intentionally blank*

