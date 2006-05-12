From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-bisect failed me again
Date: Fri, 12 May 2006 09:11:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605120852590.3866@g5.osdl.org>
References: <20060512000249.71933599.akpm@osdl.org> <Pine.LNX.4.64.0605120738190.3866@g5.osdl.org>
 <20060512081207.6cd701f9.akpm@osdl.org> <Pine.LNX.4.64.0605120823170.3866@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 12 18:11:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FeaEu-0000Wq-Mz
	for gcvg-git@gmane.org; Fri, 12 May 2006 18:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWELQL1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 May 2006 12:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbWELQL1
	(ORCPT <rfc822;git-outgoing>); Fri, 12 May 2006 12:11:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63939 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751227AbWELQL0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 May 2006 12:11:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4CGBKtH015595
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 12 May 2006 09:11:22 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4CGBJdb018617;
	Fri, 12 May 2006 09:11:19 -0700
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605120823170.3866@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19918>



On Fri, 12 May 2006, Linus Torvalds wrote:
> 
> But git isn't linear. Never has been. The fact that commits get (roughtly) 
> sorted by date (modified by their ancestry relationships either subtly or 
> grossly depending on whether --topo-sort is off or on) does not make 
> anything linear.

Note that totally independently of sort order (whether "topo-order" or the 
normal cheaper "order by date, but at least one chain of parenthood always 
first"), you _will_ get the situation that a commit that was shown "last" 
in a linear list is actually merged long before.

The simplest case is this:

		merge
		 |  \
		 A   \
		 |    \
		 B     \
		 |      X
		 C      |
		 |	Y
		 D	|
		 |      Z
		..	..

where the "main branch" is the A-B-C-D.. line of history, and the merge 
brings in another "X-Y-Z" line of history.

Now, the A-B-C branch may have gotten a lot more recent love and 
attention, and when you linearize it, since the normal ordering tends to 
show it in a date-like order, you may get a list of commits like

		merge
		A
		B
		C
		D
		..
		X
		Y
		Z
		..


which makes you think that "A" is much more recent than "X". That may be 
actually be _true_, but:

 - 'X' actually _showed_up_ in the mainline much later than A. So, if you 
   track another persons tree like this, X as a commit may be 2 weeks old, 
   but it might not have been in the tree you tracked yesterday, because 
   it hadn't been _merged_ until today.

   So in a very real sense, from your standpoint, 'X' may be the 'recent' 
   one, because you hadn't seen it before, but you _had_ seen 'A' 
   yesterday.

 - Equally importantly, 'A' very much is _not_ a descendant of 'X' (ie, 
   'X' is _not_ reachable from 'A'). So even though 'A' is in a time-sense 
   much more recent than 'X', you can't say "it's the most recent commit, 
   so if there's a bug in any of the series, the bug must have been 
   visible at point 'A'".

This is why it's wrong to look at _any_ linearized list of commits and 
imply any ordering what-so-ever. There simply is no list ordering that 
guarantees anything at all, because even with "topo-sort", the only thing 
we guarantee is that commits that are directly related to each other will 
always sort the child before its parents. So even there, you can't 
actually say that one commit "dominates" another commit unless you end up 
looking at the parenthood chain (and merges are really important).

[ Strictly speaking, there is exactly _one_ thing you can say from just 
  seeing a list of commits: _if_ that list includes all types of commits 
  (ie notably merges and empty changes) _and_ if that list was generated 
  with just one "top" commit, then the first commit on the list will 
  dominate all other commits. But that's literally the only real ordering 
  you can ever know from just a list.

  So looking at the first commit in a list is actually valid, but only if 
  you included all the merges and only if the list was generated by a git 
  command, and not sorted by any other criteria ]

			Linus
