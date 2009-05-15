From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Funny error with git gc...
Date: Fri, 15 May 2009 11:46:32 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905151128230.3343@localhost.localdomain>
References: <alpine.DEB.1.00.0905152000520.4449@intel-tinevez-2-302> <7vmy9etey8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 15 20:46:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M52Qp-0003mZ-3T
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 20:46:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753332AbZEOSqp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 14:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753234AbZEOSqo
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 14:46:44 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57694 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752746AbZEOSqo (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 May 2009 14:46:44 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4FIkXTp000543
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 15 May 2009 11:46:34 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4FIkWHi028793;
	Fri, 15 May 2009 11:46:32 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7vmy9etey8.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.464 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119276>



On Fri, 15 May 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > if you need a chuckle, like me, you might appreciate this story: in one of 
> > my repositories, "git gc" dies with
> >
> > 	unable to open object pack directory: ...: Too many open files
> >
> > turns out that there are a whopping 1088 packs in that repository...
> 
> Isn't it a more serious problem than a mere chuckle?  How would one
> recover from such a situation (other than "mv .git/objects/pack-*;
> for p in pack-*.pack; do git unpack-objects <$p; done")?

Well, you can probably just increase the file limits and try again. 
Depending on setup, you may need root to do so, though.

I also think you _should_ be able to avoid this by just limiting the pack 
size usage. IOW, with some packed_git_limit, something like

	[core]
		packedGitWindowSize = 16k
		packedGitLimit = 1M

you should hopefully be able to repack (slowly) even with a low file 
descriptor limit, because of the total limit on the size.

That said, I do agree that ulimit doesn't always work on all systems 
(whether due to hard system limits or due to not having permission to 
raise the limits), and playing games with pack limits is non-obvious. We 
should really try to avoid getting into such a situation. But I think git 
by default avoids it by the auto-gc, no? So you have to disable that 
explicitly to get into this bad situation.

One solution - which I think may be the right one regardless - is to not 
use "mmap()" for small packs or small SHA1 files.

mmap is great for random-access multi-use scenarios (and to avoid some 
memory pressure by allowing sharing of pages), but for anything that is 
just a couple of pages in size, mmap() just adds big overhead with little 
upside. 

So if we use malloc+read for small things, we'd probably avoid this. Now, 
if you have a few thousand _large_ packs, you'd still be screwed, but the 
most likely reason for having a thousand packfiles is that you did daily 
"git pull"s, and have lots and lots of packs that are pretty small.

Dscho? What are your pack-file statistics in this case?

		Linus
