From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: hosting git on a nfs
Date: Thu, 13 Nov 2008 21:01:20 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811132044460.3468@nehalem.linux-foundation.org>
References: <200811121029.34841.thomas@koch.ro>  <20081112173651.GA9127@linode.davidb.org>  <alpine.LFD.2.00.0811120959050.3468@nehalem.linux-foundation.org>  <loom.20081113T174625-994@post.gmane.org>  <alpine.LFD.2.00.0811131214020.3468@nehalem.linux-foundation.org>
  <alpine.LFD.2.00.0811131252040.3468@nehalem.linux-foundation.org>  <alpine.LFD.2.00.0811131518070.3468@nehalem.linux-foundation.org>  <371xaQfxsMMQ-9LK24q-nhcS4loEggn8Cj3J1IzfMbzzYDGE6HKbQQ@cipher.nrlssc.navy.mil>  <alpine.LFD.2.00.0811131630470.3468@nehalem.linux-foundation.org>
  <alpine.LFD.2.00.0811131707090.3468@nehalem.linux-foundation.org> <885649360811131933webae91w134dce4c5c0ccf89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Bruce Fields <bfields@fieldses.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: James Pickens <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 06:03:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0qq8-0002sf-TP
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 06:03:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbYKNFCL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 00:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbYKNFCK
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 00:02:10 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37475 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750717AbYKNFCJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Nov 2008 00:02:09 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mAE51MtT006577
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 13 Nov 2008 21:01:23 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mAE51Kr8026691;
	Thu, 13 Nov 2008 21:01:21 -0800
In-Reply-To: <885649360811131933webae91w134dce4c5c0ccf89@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.432 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100950>



On Thu, 13 Nov 2008, James Pickens wrote:
> 
> I wonder if there are other completely different parts of git that could
> benefit from multi threading when the work tree is on nfs?

I'm sure there are. That said, threading things is usually really quite 
painful. The only reason this preloading was easy to do was that we really 
had all the data structures laid out beautifully for this, and I had spent 
a lot of effort earlier on a whole series of "avoid duplicate lstat()" 
changes, which gave us that whole ce_uptodate() thing, and all normal 
cases already taking advantage of it, and the "uptodate" bit being 
percolated along all the paths.

If it hadn't been for that, it would have been much nastier to do.

As it was, there was literally just a simple little extra phase to fill in 
all teh data structures that we already had set up in parallel.

> I'm thinking specifically of 'git checkout', since while testing this 
> patch I happened to do a 'git pull' that resulted in several thousand 
> new files being created, and the "Checking out files" part took 
> *forever* to run.

Now, the good news is that the actual work-tree part of checking things 
out is probably pretty amenable to the same kind of parallelization, for 
largely the same reasons: the whole checking out thing is already done in 
multiple phases with all error handling done before-hand. So we will have 
built up all our data structures earlier, and set the CE_UPDATE bit, and 
then there's just a final "push it all out" phase.

So CE_UPTODATE and CE_UPDATE are really very similar in that sense - 
except at opposite ends of the pipeline. The CE_UPTODATE bit marks a name 
entry as matching the filesystem data (and allows all later phases to 
avoid doing the expensive lstat()s), while the CE_UPDATE (and CE_REMOVE) 
bits allow us to do all our complex work in-memory without committing it 
to disk, and then we push it out in one go.

So if you want to multi-thread checkout, you literally need to just thread 
the last for-loop in unpack-trees.c:check_updates() (the CE_UPDATE loop 
that does "checkout_entry()" over the whole index). 

> And FWIW, I timed 50 iterations of 'git diff', and the average runtime
> dropped from 11.7s to 2.8s after this patch.  A nice improvement.

Very impressive. That said, I suspect you get a "superlinear" improvement 
because once it gets faster, the kernel cache also works better, since you 
can do more loops without having the NFS attributes time out.

Whether that kind of effect happens much in actual practice is debatable, 
although it's quite possible that it will work the same way in some 
scripting schenarios.

			Linus
