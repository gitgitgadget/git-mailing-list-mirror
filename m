From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Question about git-merge-stupid
Date: Thu, 3 Jul 2008 10:08:54 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807030947360.18105@woody.linux-foundation.org>
References: <20080703123314.GS4729@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Jul 03 19:11:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KESLH-0001LN-4c
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 19:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755330AbYGCRK3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 13:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755098AbYGCRK2
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 13:10:28 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52190 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755139AbYGCRK1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jul 2008 13:10:27 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m63H8tbd024145
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 3 Jul 2008 10:08:56 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m63H8sMJ017652;
	Thu, 3 Jul 2008 10:08:54 -0700
In-Reply-To: <20080703123314.GS4729@genesis.frugalware.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.366 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87297>



On Thu, 3 Jul 2008, Miklos Vajna wrote:
> 
> I'm trying to understand what is the difference between different merge
> strategies. git-merge-stupid is something I failed to understand from
> the git history/code/documentation, so I'm asking here.
> 
> 1) From git history:
> 
> It seems git-merge-stupid was created by 2276aa6 when Junio renamed
> -resolve to -stupid and let -resolve use read-tree. Actually
> 
>         git show 2276aa6:git-merge-stupid.sh
> 
> says -stupid uses read-tree as well.

I think -stupid should probably be removed.

The history of -stupid is from doing the simple single-tree resolve that 
git-read-tree can do, but then doing the obvious hack of just trying to 
pick the base that gives the least number of conflicts.

HOWEVER. 

 - in practice, there's seldom any actual point to it. In 99% of all 
   cases, you only have a single merge base anyway.

 - if you have a workflow that encourages criss-cross merges (which makes 
   the above "in practice" not be true), the common case will be that the 
   merge base doesn't much matter.

 - Counting conflicts by looking at the numbe of files that conflict is a 
   pretty stupid metric anyway. Yes, it's obvious, and yes, I bet there 
   are cases where it does the right thing, but I also bet there are cases 
   where it does the _wrong_ thing - it might pick a merge base with fewer 
   files conflicting, but with harder conflicts.

 - the "recursive" merge strategy simply handles things better. There's 
   not really any reason to use a "pick random merge base that happens to 
   give least conflicts", when the recursive strategy does something much 
   more natural.

So you shouldn't really compare -stupid to -resolve. You should compare 
-stupid to -recursive, and the latter is simply much better.

> 2) From code:
> 
> It seems -stupid is better than -resolve when there are multiple bases.

Maybe. And maybe not.

> $ git merge -s resolve c
> Trying simple merge.
> Merge made by resolve.
> 
> So it seems resolve does not completely fail if there are multiple
> bases, either.

I think -resolve can handle up to 6 bases, or something like that. After 
that it should fail with a "I cannot read more than 8 trees" or something 
(eight being the two trees to be merged, plus the six bases).

And with multiple bases, it will already pick the best one on a per-file 
basis (I think - I should know the threeway merge, but it is pretty 
confusing code) rather than trying to pick one globally. Not pretty, but 
it's yet another reason why -stupid is actually stupid, and not worth it.

So -stupid in _theory_ can handle cases that -resolve cannot (more than 
six bases), but (a) that doesn't happen and (b) you'd be better off with 
-recursive anyway.

> 3) From documentation:
> 
> Actually -stupid is missing from Documentation/merge-strategies.txt. I
> plan to send a patch to add it, once I understnad what it does. :-)

Well, see above. I think there's a reason why -stupid isn't even worth 
documenting. It might be better off just removed.

		Linus
