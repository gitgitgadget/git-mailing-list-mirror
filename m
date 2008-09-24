From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Locking binary files
Date: Wed, 24 Sep 2008 00:15:39 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0809232330050.19665@iabervon.org>
References: <94c1db200809222339t7d65081eq7471fef86fb5ec73@mail.gmail.com> <48D8983C.7070506@op5.se> <94c1db200809230054t20e7e61dh5022966d4112eee6@mail.gmail.com> <48D8A97E.8070003@op5.se> <94c1db200809230656q4a9a765dw2354c0058b1d940c@mail.gmail.com>
 <alpine.LNX.1.00.0809231216350.19665@iabervon.org> <7v7i92tzgb.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0809231551320.19665@iabervon.org> <20080923215422.GV21650@dpotapov.dyndns.org> <alpine.LNX.1.00.0809231811560.19665@iabervon.org>
 <20080923232154.GW21650@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Mario Pareja <mpareja.dev@gmail.com>,
	Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 24 06:16:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiLo2-0004Ae-Ee
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 06:16:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbYIXEPl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 00:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbYIXEPl
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 00:15:41 -0400
Received: from iabervon.org ([66.92.72.58]:48213 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750991AbYIXEPk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 00:15:40 -0400
Received: (qmail 6980 invoked by uid 1000); 24 Sep 2008 04:15:39 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Sep 2008 04:15:39 -0000
In-Reply-To: <20080923232154.GW21650@dpotapov.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96616>

On Wed, 24 Sep 2008, Dmitry Potapov wrote:

> On Tue, Sep 23, 2008 at 06:29:53PM -0400, Daniel Barkalow wrote:
> > On Wed, 24 Sep 2008, Dmitry Potapov wrote:
> > 
> > > It still will happen if developers work on topic branches, and it is not
> > > a rate situation with Git. Thus locking some particular path is stupid.
> > > What you may want instead is too mark SHA-1 of this file as being edited
> > > and later maybe as being replaced with another one. In this case, anyone
> > > who has the access to the central information storage will get warning
> > > about attempt to edit a file that is edited or already replaced with a
> > > new version.
> > 
> > No, your goal is to avoid having to do a merge in order to do a particular 
> > push. That push is the push to the shared location. It doesn't matter if 
> > you use topic branches, because your eventual goal is still to push to the 
> > shared location (or, possibly, to have the project maintainer push to the 
> > shared location with some sort of interesting delegation), so you lock the 
> > shared location, not your topic branch.
> 
> What are you saying is that when I am locking some file on the current
> branch, Git (or whatever script that performs this locking) should figure
> out what is the original shared branch for it and lock the file there.

Or you should have to say. But "git lock <filename>" should probably 
put the lock on whatever branch "git push" would push to, and similarly 
for the other argument combinations that "git push" permits.

> When you have finished to edit and push changes then the lock should be
> removed if changes are pushed to this shared branch, otherwise it should
> be some token of delegation to the project maintainer who is going to
> push (or probably first merge, because other files may need that) to
> this branch.

Correct.

> Maybe, it can work, but it sounds too complex to me. I believe that my
> idea using SHA-1 is better. After all, what is file? It is its content.
> At least, in Git, we always identify files by their content.

Not at all; there are plenty of cases where what matters is the path, and 
some things are relevant by virtue of the form of the filename which names 
that content.

> Thus if you lock some file, you put a lock on certain SHA-1. Now, 
> regardless of branches and paths, this lock can work provided that you 
> have access to some shared location. Of course, this lock is purely 
> advisory, but it is good, because you may want to ignore it in some 
> case.

In my design, the lock (on the shared repository) is not advisory; if 
someone else has it, you can't push if the new commit doesn't match the 
old commit for that path. (Of course, the system might let you break the 
other person's lock.) I don't think locks are particularly useful if you 
don't get some particular guarantee out ofhaving them (in my case, that 
somebody else will have to do any merge for the file if one is needed).

> For instance, you want to created a new branch based on the 
> current shared location and have no plan to ever merge it back. In this 
> case, the lock on the shared branch should not matter to you. This is 
> true regardless how you implement locking, and in your scheme it will 
> another special case.

If you have no intention to merge a local branch back to the remote branch 
it is based on, then you won't have the remote configured for this. If the 
locking and lock-checking code uses the push configuration to determine 
what locks make sense, it'll automatically be unrelated.

	-Daniel
*This .sig left intentionally blank*
