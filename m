From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: q: faster way to integrate/merge lots of topic branches?
Date: Wed, 23 Jul 2008 10:59:01 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807231027030.4754@woody.linux-foundation.org>
References: <20080723130518.GA17462@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Wed Jul 23 20:00:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLidd-0000oE-9f
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 20:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753149AbYGWR7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 13:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753353AbYGWR7Y
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 13:59:24 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42760 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752648AbYGWR7X (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jul 2008 13:59:23 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6NHx2P5022492
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 23 Jul 2008 10:59:03 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6NHx1TS003663;
	Wed, 23 Jul 2008 10:59:02 -0700
In-Reply-To: <20080723130518.GA17462@elte.hu>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.4 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89725>



On Wed, 23 Jul 2008, Ingo Molnar wrote:
> 
> I've got the following, possibly stupid question: is there a way to 
> merge a healthy number of topic branches into the master branch in a 
> quicker way, when most of the branches are already merged up?
> 
> Right now i've got something like this scripted up:
> 
>   for B in $(git-branch | cut -c3- ); do git-merge $B; done 
> 
> It takes a lot of time to run on even a 3.45GHz box:
> 
>   real    0m53.228s
>   user    0m41.134s
>   sys     0m11.405s

This is almost certainly because a lot of your branches are a long way 
back in the history, and just parsing the commit history is old.

For example, doing a no-op merge of something old like v2.6.24 (which is 
obviously already merged) takes half a second for me:

	[torvalds@woody linux]$ time git merge v2.6.24
	Already up-to-date.

	real	0m0.546s
	user	0m0.488s
	sys	0m0.008s

and it gets worse the further back in history you go (going back to 2.6.14 
takes a second and a half - plus any IO needed, of course).

And just about _all_ of it is literally just unpacking the commits as you 
start going backwards from the current point, eg:

	[torvalds@woody linux]$ time ~/git/git merge v2.6.14
	Already up-to-date.
	real	0m1.540s

vs

	[torvalds@woody linux]$ time git rev-list ..v2.6.14
	real	0m1.407s

(The merge loop isn't quite as optimized as the regular revision 
traversal, so you see it being slower, but you can still see that it's 
roughly in the same class).

The merge gets a bit more expensive still if you have enabled merge 
summaries (because now it traverses the lists twice - once for merge 
bases, once for logs), but that's still a secondary effect (ie it adds 
another 10% or so to the cost, but the base cost is still very much about 
the parsing of the commits).

In fact, the two top entries in a profile look roughly like:

	102161   70.2727  libz.so.1.2.3            libz.so.1.2.3            (no symbols)
	7685      5.2862  git                      git                      find_pack_entry_one
	...

ie 70% of the time is just purely unpacking the data, and another 5% is 
just finding it. We could perhaps improve on it, but not a whole lot.

Now, quite frankly, I don't think that times on the order of one second 
are worth worrying about for _regular_ merges, and the whole (and only) 
reason you see this as a performance problem is that you're basically 
automating it over a ton of branches, with most of them being old and 
already merged.

But that also points to a solution: instead of trying to merge them one at 
a time, and doing the costly revision traversal over and over and over 
again, do the costly thing _once_, and then you can just filter out the 
branches that aren't interesting.

So instead of doing

	for B in $(git-branch | cut -c3- ); do git-merge $B; done

the obvious optimization is to add "--no-merged" to the "git branch" call. 
That itself is expensive (ie doing "git branch --no-merged" will have to 
traverse at least as far back as the oldest branch), so that phase will be 
AT LEAST as expensive as one of the merges (and probably quite a bit more: 
I suspect "--no-merged" isn't very heavily optimized), but if a lot of 
your branches are already fully merged, it will do all that work _once_, 
and then avoid it for the merges themselves.

So the _trivial_ solution is to just change it to

	for B in $(git branch --no-merged | cut -c3- ); do git-merge $B; done

and that may already fix it in practice for you, bringing the cost down by 
a factor of two or more, depending on the exact pattern (of course, it 
could also make the cost go _up_ - if it turns out that none of the 
branches are merged).

Other solutions exist, but they get much uglier. Octopus merges are more 
efficient, for example, for all the same reasons - it keeps the commit 
traversal in a single process, and thus avoids having to re-parse the 
whole history down to the common base. But they have other problems, of 
course.

			Linus
