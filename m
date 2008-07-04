From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Cherry picking instead of merges.
Date: Thu, 3 Jul 2008 22:30:32 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807032221190.2815@woody.linux-foundation.org>
References: <20080703182650.GA11166@old.davidb.org> <alpine.LFD.1.10.0807031403380.2815@woody.linux-foundation.org> <20080703223949.GA23092@old.davidb.org> <20080704001003.GA19053@atjola.homenet> <20080704044032.GA4445@old.davidb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	git@vger.kernel.org
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Fri Jul 04 07:32:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEdu1-0001YE-SB
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 07:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbYGDFbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 01:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbYGDFbR
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 01:31:17 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55058 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751415AbYGDFbQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Jul 2008 01:31:16 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m645UXEL006744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 3 Jul 2008 22:30:34 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m645UXQK014563;
	Thu, 3 Jul 2008 22:30:33 -0700
In-Reply-To: <20080704044032.GA4445@old.davidb.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.365 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87361>



On Thu, 3 Jul 2008, David Brown wrote:
> 
> A cherry-picked tree would allow for an easy bisect, since all of the
> intermediary versions would work.  If I somehow knew magical points within
> the other tree I could do some number of merges and the bisect would still
> work.  I suppose I could do the merges one at a time, but it would make the
> history rather verbose.

Why do you want to worry so much about bisecting the merge?

You should basically expect that normally, a merge doesn't cause new bugs 
in itself. And if it does, the most common case is a fairly obvious 
mismerge (we've had a number of those in the kernel, but they weren't all 
that mysterious). So _planning_ for a subtle bisection failure sounds a 
bit strange and counter-productive.

So don't plan for it, and don't make it a primary issue for your workflow. 

Then, *after* you have a merge, and the unlucky thing happens where the 
merge is actually the thing that introduces the bug, and it's not obvious 
what the exact interaction is, and bisection didn't help you pinpoint it 
(because it really was the merge), *that* is when you might then choose to 
re-do the rebase in a temporary branch, and then bisect that re-linearized 
history. 

So basically:

 - keep the history clean and obvious

 - make it fairly straightforward and don't worry about the unlikely case.

 - don't do something painful just because bad things _can_ happen (they 
   can happen regardless of what you do)

 - because in the unlikely situation that bad things happen, you can 
   always then go back and do things the other way around and pinpoint 
   where the fault is that way.

IOW, let's say that you really do bisect things down to a merge and cannot 
see what the fault in that merge is, you can literally do

	# create a test-branch with the 'remote' side of the merge
	git checkout -b test-branch merge^2

	# rebase that remote side on top of the local side
	git rebase merge^

and now you've linearized the merge temporarily just to be able to bisect 
in that temporary branch what the bad interaction is. But once you've 
bisected it, the temporary branch is again just junk - there's no real 
value in saving it, because once you know _why_ the bug happened, you're 
just better off going back to the original history and just fixing it (and 
documenting the bug through the fix, rather than by addign extra-ugly 
history).

		Linus
