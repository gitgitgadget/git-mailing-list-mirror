From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2 - RFH/WIP] xdiff-merge: optionally show conflicts in
 "diff3 -m" style
Date: Sun, 31 Aug 2008 10:38:18 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808311021120.12958@nehalem.linux-foundation.org>
References: <7vzlmwbs1u.fsf@gitster.siamese.dyndns.org> <7vsksobrn9.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0808281727490.3300@nehalem.linux-foundation.org> <7vmyiwbpe2.fsf@gitster.siamese.dyndns.org> <7v1w05d5hm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 31 19:39:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZqtu-0008S6-28
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 19:39:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754692AbYHaRil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 13:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754559AbYHaRik
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 13:38:40 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60549 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754501AbYHaRik (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Aug 2008 13:38:40 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7VHcJvo022550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 31 Aug 2008 10:38:20 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7VHcIR9031692;
	Sun, 31 Aug 2008 10:38:18 -0700
In-Reply-To: <7v1w05d5hm.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.932 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94497>



On Sun, 31 Aug 2008, Junio C Hamano wrote:
> 
> On average, I am finding that "diff3 -m" format more irritating than
> useful.  However, on occasions like this, I am finding it quite useful.

I have to say that the best feature of the standard merge is the zealous 
version, which apparently doesn't work well with the "diff3 -m" format.

I do agree that what is often really nasty with the normal merge conflict 
info is when you actually need the original thing to understand why some 
hunk was left, and yes, a common case of that is that one side simply 
removed a function, and the other side had modified it. At that point the 
resulting conflict is often hard to understand without seeing the 
original, exactly because you don't see any actual "conflict", you only 
see one side (the other side being empty).

But what really saves that situation is the combination of

 - 'gitk --merge <file>'
 - 'git diff' showing the multi-way merge

and I find myself really _hating_ doing rebases because the merge helpers 
are so totally useless (ie "gitk --merge" at least didn't use to work 
across a rebase conflict because MERGE_HEAD isn't set)

But the biggest problem, and the reason I _really_ detest the diff3 
format, is that small merges are fairly often pretty easy to see anyway. 
If the conflict markers all fit in one screenful, it's generally fairly 
easy to see why something conflicted, because you can visually compare 
things.

But the complicated cases are when there are bigger changes, and the 
conflict is over many many lines of code, and it's really hard to visually 
see what changed. And the diff3 format makes this worse - it not only 
makes the conflict 50% bigger to begin with, it moves the two conflicting 
versions away from each other, making that visual comparison much harder.

Now, there are tools to help with that. I think various of the graphical 
merge tools understand the diff3 format, and then ti can really help. But 
I think it hurts for a lot of the _common_ cases.

> My observation so far suggests that it would be best for me to leave the
> configuration "merge.conflictstyle" to the default "merge", and instead
> give an option to allow me to tell "git checkout -m -- $path" (which is
> also a new feature; it overwrites the $path by the result of a fresh merge
> to reproduce the conflicted state in the working tree, using the three
> stages recorded in the index) to use "diff3 -m" style, when I want to.

Now *this* I think is a great idea! 

The reason I think it's a great idea is that it solves so many _different_ 
issues (which is the mark of a really good solution):

 - it fixes my problem with diff3 output: the fact that it's more annoying 
   by _default_ than it is occasionally useful.

   If the default isn't to do it - since by default it often hurts - but 
   you have the option to do it when there is something confusing going on 
   (like the "one side disappeared, why did it conflict?" case), then you 
   have the best of both worlds - a good default with a way to dig deeper 
   when you need to.

 - it fixes another totally unrelated problem: incorrect merge 
   resolutions.

   Again, I find this to be fairly rare, but what git is good at is to 
   make incremental resolutions for merge problems - you can resolve the 
   merge in the work tree, then compile and test the result before 
   actually committing it, and "git diff" always gives relevant and 
   interesting output for the merge.

   And _occasionally_ the resolve looks obvious, but then when you compile 
   things you notice that it doesn't work because (for example) you 
   resolved it by removing one side (exactly because the other side was a 
   removal), and it turned out that the conflict was adding a function 
   that you hadn't realized was new, and was needed.

   And while "git diff" is fine, and you can cut-and-paste things and try 
   to re-resolve it that way, I have occasionally decided to just do a 
   "git reset" and re-do the whole merge.

   But your idea allows us to just re-do the merge for a single file.

So I think we do quite well already, but your solution really does sound 
like a good and useful addition to the toolbox.

		Linus
