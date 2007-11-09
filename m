From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Inconsistencies with git log
Date: Fri, 9 Nov 2007 10:36:28 -0800 (PST)
Message-ID: <alpine.LFD.0.999.0711091029160.15101@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0711072255420.4362@racer.site>
 <9e4733910711071503va92a653s25fd978989d5917d@mail.gmail.com>
 <Pine.LNX.4.64.0711072309380.4362@racer.site>
 <9e4733910711071529m604f3b12v29b3a040074ea4e@mail.gmail.com>
 <Pine.LNX.4.64.0711080003080.4362@racer.site>
 <9e4733910711071609t3e5412f1mf02e501b2d820bb3@mail.gmail.com>
 <alpine.LFD.0.999.0711090747210.15101@woody.linux-foundation.org>
 <9e4733910711090920m6b0b7704x7c5a3849215f385c@mail.gmail.com>
 <alpine.LFD.0.999.0711090929130.15101@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711090943120.15101@woody.linux-foundation.org>
 <20071109182248.GD28800@xp.machine.xx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 09 19:37:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqYjP-0001dK-Q5
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 19:37:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752045AbXKIShL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 13:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751990AbXKIShL
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 13:37:11 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:52710 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751233AbXKIShI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Nov 2007 13:37:08 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA9IaSZS017223
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 9 Nov 2007 10:36:29 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA9IaSIa026598;
	Fri, 9 Nov 2007 10:36:28 -0800
In-Reply-To: <20071109182248.GD28800@xp.machine.xx>
X-Spam-Status: No, hits=-2.739 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64244>



On Fri, 9 Nov 2007, Peter Baumann wrote:
> 
> Hm. I tried to run your 'git log' and 'git log .' example and a diff
> revealed that the output of those two isn't the same, contrary to what I
> thought.

Btw, you can *make* them the same by using

	git log --full-history --sparse .

which basically tells git that you do not want any of the history 
simplification that git log does by default.

There's two different kinds of simplifications (which is why there are two 
kinds of switches above):

 - the "simplify merges to just the parent that is identical"

   This basically means that if a merge result comes 100% from one of the 
   parents, by default we will only look at that parent. Using 
   --full-history avoids this.

 - the "dense" history, which removes simple commits that don't make any 
   changes

   This is the "--sparse" thing: it says that we're interested even in 
   regular commits that simply don't make any changes.

> In the 'git-log .' case, there should be done a history simplification,
> but then only commits which don't change anything are pruned and AFAIR
> 'git commit' doesn't allow this.

Actually, git itself creates these commits under several circumstances:

 - you can *force* it. No, "git commit" on its own doesn't allow it, but 
   you can do it quite easily with "git commit-tree" and setting things 
   up by hand.

 - you can import history from other SCM's. I think all importers will 
   honor other SCM's, and if they allow empty commits then the end result 
   will have empty commits in it too!

 - merges. This is the common case. You have a "git merge --ours" or 
   similar, which basically merges just one side (or, even without 
   "--ours", this is really common for the non-"." case: a merge just 
   doesn't touch some files at all). Then, the merge simplifier will first 
   turn it into a "single parent", and then densification will remove that 
   (now uninteresting) empty merge.

> Using core git, one could create commits with the same tree as their 
> parent, but I don't think that all the commits which get removed in the 
> '.' case where produced that way. There has to be another case I can't 
> figure out.

See above. Three cases, in fact.

		Linus
