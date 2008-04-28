From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: my git problem
Date: Mon, 28 Apr 2008 12:21:17 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0804281200130.3119@woody.linux-foundation.org>
References: <20080427112938.4dbe8e2a.akpm@linux-foundation.org> <alpine.LFD.1.10.0804271204510.3119@woody.linux-foundation.org> <20080427124454.6a606305.akpm@linux-foundation.org> <alpine.LFD.1.10.0804271315010.3119@woody.linux-foundation.org>
 <20080428114509.240ef4ae.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:22:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqYw5-00082W-4R
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 21:22:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934534AbYD1TVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 15:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934545AbYD1TVu
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 15:21:50 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43061 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932271AbYD1TVt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Apr 2008 15:21:49 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3SJLIYY023406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 28 Apr 2008 12:21:19 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3SJLHmo011105;
	Mon, 28 Apr 2008 12:21:18 -0700
In-Reply-To: <20080428114509.240ef4ae.akpm@linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.478 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80592>



On Mon, 28 Apr 2008, Andrew Morton wrote:
> 
> hm, weirdness.
> 
> y:/usr/src/git26> git-diff origin...git-ia64   
> y:/usr/src/git26> git-log origin...git-ia64 | wc -l
> 15574
> 
> I'd have expected git-log to operate on the same patches as git-diff.

No, not at all.

 - "git log" shows each commit in a range.

 - "git diff" shows just the difference between two states.

The two have nothing in common. One operates on lots of individual commits 
(git log) individually, while the other one fundamentally operates on just 
two end-points (git diff).

And "a..b" and "a...b" means two totally different things for the two 
totally different operations.

When doing "a..b" and looking at individual commits, it means "show all 
commits that are in b but *not* in a". And when doing "a..b" when asking 
for a "diff", it means "show the difference from 'a' to 'b'".

They are *very* different operations indeed. The log can be empty, even if 
the diff is not empty (example: b is _before_ a, so there is nothing in 
'b' that isn't in 'a', but that doesn't mean that 'b' is *equal* to 'a', 
so there is still a diff!). And the log can be non-empty, even if the diff 
is empty (example: 'b' and 'a' have the same actual tree, but two 
different ways of gettign there: the diff is empty, but the log of commits 
in between them is not).

So anybody who thinks that 'diff' and 'log' have *anything* to do with 
each other is fundamentally confused. Not just about git, btw. It's true 
in any model - it's fundamental.

As to 'a...b', it also means somethign different for diff (two endpoints!) 
and log (set of commits). For diff, it means "show the difference between 
the common commit and 'b'", while for log it means "show all commits that 
are in either 'a' or 'b' but *not* in both".

So you should do

	# generate the diff from the common point
	git diff -p --stat a...b

	# show the commits that are in b but not in a
	git log a..b

where the difference between two dots and three dots is important, and 
stems directly from the fact that 'diff' and 'log' are two totally 
different operations that cannot _possibly_ have semantics that mean the 
same thing - because a "set of commits" is fundamentally different from 
"difference betwen two endpoints".

So both "a..b" and "a...b" have meaning for both diff and log, but which 
you want to use depends on what you are looking for.

They do have some relationship, of course. If you want to have a simple 
way to know which is which, then

 - "a..b" is a plain difference. Think of it as a subtraction. For "diff", 
   it is simply the diff between a and b, and for log it is the "set 
   difference" (shown as either just "-" or as "\" in set theory math) 
   between the commits that are in b and not in a.

 - "a...b" is a more complex difference. For log, it's no longer the 
   regular set difference, but a "symmetric difference" (usually shown as 
   a greek capital "Delta" in set theory math). And for "diff", it's no 
   longer just the diff between two states, it's the diff from a third 
   state (the nearest common state) to the second state.

In short: It's easy to think that "log" and "diff" are related, but they 
really are very fundamnetally different. 

		Linus
