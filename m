From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: warning: no common commits - slow pull
Date: Sat, 16 Feb 2008 22:52:07 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802162239090.5496@iabervon.org>
References: <200802102007.38838.lenb@kernel.org> <7vd4r4clnb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Len Brown <lenb@kernel.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 17 04:52:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQaa5-0005d8-FK
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 04:52:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752183AbYBQDwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 22:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752382AbYBQDwK
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 22:52:10 -0500
Received: from iabervon.org ([66.92.72.58]:50948 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752247AbYBQDwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 22:52:09 -0500
Received: (qmail 9912 invoked by uid 1000); 17 Feb 2008 03:52:07 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Feb 2008 03:52:07 -0000
In-Reply-To: <7vd4r4clnb.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74091>

On Sun, 10 Feb 2008, Junio C Hamano wrote:

> Len Brown <lenb@kernel.org> writes:
> 
> > A couple of hours ago I pulled my reference copy of Linux tree,
> > which brought the tip here:
> >
> > commit 7cf712db6087342e5e7e259d3883a7b5ac3212d1
> > Merge: 58a14ee... 30ddb15...
> > Author: Linus Torvalds <torvalds@woody.linux-foundation.org>
> > Date:   Sun Feb 10 12:03:57 2008 -0800
> >
> >     Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-2.6
> >
> > Then, 10 minutes ago I did a pull to bring the head here:
> >
> > commit 19af35546de68c872dcb687613e0902a602cb20e
> > Author: Linus Torvalds <torvalds@woody.linux-foundation.org>
> > Date:   Sun Feb 10 14:18:14 2008 -0800
> >
> >     Linux 2.6.25-rc1
> >
> > But this second pull seems to have re-downloaded 172MB,
> > when it should have only needed the last few commits.
> >
> > thanks,
> 
> Thanks.  This is very puzzling.
> 
> > [lenb@d975xbx2 linus (master)]$ git pull
> > remote: Counting objects: 447, done.
> > remote: Compressing objects: 100% (39/39), done.
> > remote: Total 328 (delta 291), reused 325 (delta 289)
> 
> This part looks quite sane.
> 
> 	$ git rev-list --objects ^7cf712d v2.6.25-rc1^0 | wc -l
> 	328
> 
> > Receiving objects: 100% (328/328), 60.81 KiB, done.
> > Resolving deltas: 100% (291/291), completed with 97 local objects.
> 
> and the number of received objects exactly match.
> 
> > warning: no common commits
> 
> This is however very unexpected.  The sequence internally should
> be doing the equivalent of:
> 
>   - fetch the objects to complete the branches we track
>     (i.e. what the above "rev-list" that fetches to complete the
>     commit pointed by the v2.6.25-rc1 tag based on your earlier
>     tip 7cf712d);
> 
>   - store the tip (19af355 = v2.6.25-rc1^0) to the tracking
>     branch;
> 
>   - run another "git fetch" to retrieve objects to complete the
>     v2.6.25-rc1 tag itself, based on our available refs (which
>     includes the commit 19af355).

I wonder if the problem is that something isn't getting reinitialized for 
the second connection. It's not a separate invocation of fetch-pack, and I 
can't say for sure that it's sending the right info to the server when the 
statics in builtin-fetch-pack.c are left over from the earlier call. This 
would particularly explain the information that hitting ctrl-c and trying 
again fixes it.

I don't really know the builtin-fetch-pack code all that well, but I'll 
see if I can reproduce the problem and if I can figure out anything 
obviously wrong.

	-Daniel
*This .sig left intentionally blank*
