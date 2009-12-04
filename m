From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Wrong damage counting in diffcore_count_changes?
Date: Fri, 4 Dec 2009 14:48:28 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912041419540.24579@localhost.localdomain>
References: <alpine.LFD.2.00.0912041200120.24579@localhost.localdomain> <7vljhio4a3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 04 23:49:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGgxp-0001cG-On
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 23:49:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757479AbZLDWtG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 17:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752923AbZLDWtF
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 17:49:05 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58481 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754517AbZLDWtD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Dec 2009 17:49:03 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id nB4MmT3p023729
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 4 Dec 2009 14:48:30 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id nB4MmSYX019255;
	Fri, 4 Dec 2009 14:48:28 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7vljhio4a3.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.458 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134582>



On Fri, 4 Dec 2009, Junio C Hamano wrote:
> 
> Well, the current loop structure largely comes from your eb4d0e3 (optimize
> diffcore-delta by sorting hash entries., 2007-10-02) so you would be the
> best judge of the change ;-), even though it seems that the current code
> inherited the "skipping of dst when src does not exist" bug from c06c796
> (diffcore-rename: somewhat optimized., 2006-03-12).

Yeah, I think the sorting thing tried to not change any logic, so the 
counting predates that whole thing.

> But my lunchbreak is over, and my evening is booked, so I unfortunately
> cannot spend more time thinking about any possible fallouts from this
> change until tomorrow.
> 
> Sorry, and thanks.

No problem. Just an example of the fallout here on the kernel:

 - totally made-up trivial differences in two different kernel 
   directories:

	[torvalds@nehalem linux]$ git diff -p --stat >
	 kernel/sched.c |    1 +
	 mm/memory.c    |    1 +
	 2 files changed, 2 insertions(+), 0 deletions(-)
	
	diff --git a/kernel/sched.c b/kernel/sched.c
	index 3c11ae0..7a86f4f 100644
	--- a/kernel/sched.c
	+++ b/kernel/sched.c
	@@ -1,3 +1,4 @@
	+123
	 /*
	  *  kernel/sched.c
	  *
	diff --git a/mm/memory.c b/mm/memory.c
	index 6ab19dd..0de58a6 100644
	--- a/mm/memory.c
	+++ b/mm/memory.c
	@@ -1,3 +1,4 @@
	+aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
	 /*
	  *  linux/mm/memory.c
	  *

 - Here's what current git reports (which is obviously garbage):

	[torvalds@nehalem linux]$ git diff --dirstat
	 100.0% kernel/

 - Here's what a fixed git with that patch reports:

	[torvalds@nehalem linux]$ ~/git/git diff --dirstat
	   8.6% kernel/
	  91.3% mm/

and notice how the fixed diff now sees the change to mm/memory.c as a real 
change (it used to dismiss it entirely because it was a new previously 
non-existent pattern, so the hash didn't exist in the source), and gives 
reasonable percentages as to how much damage has been done (ie the 
mm/memory.c changes were obviously bigger: 42 new characters vs 4 new 
characters).

So the patch definitely improves dirstat, although for a rather made-up 
example (I normally use it for much bigger diffs, where the impact of this 
bug is not nearly as noticeable).

But that patch also changes the end result (in major ways) for real 
examples too - probably exactly because it undercounted additions of new 
code. I can't prove that the new numbers are "better", but I think they 
are:

 - old and presumably broken:

	[torvalds@nehalem linux]$ git diff -M --dirstat --cumulative v2.6.32-rc8..v2.6.32
	   5.8% arch/
	   3.5% drivers/net/e1000e/
	   9.6% drivers/net/
	   3.9% drivers/staging/
	  34.8% drivers/
	   4.1% fs/cachefiles/
	  24.9% fs/fscache/
	  32.6% fs/
	  14.5% kernel/
	   3.7% net/

 - new and hopefully fixed:

	[torvalds@nehalem linux]$ ~/git/git diff -M --dirstat --cumulative v2.6.32-rc8..v2.6.32
	   3.3% Documentation/filesystems/caching/
	   3.5% Documentation/filesystems/
	   7.6% Documentation/
	   3.2% arch/arm/
	   4.2% arch/blackfin/
	  10.1% arch/
	   3.1% drivers/gpu/drm/
	   7.8% drivers/net/
	   3.1% drivers/staging/
	  30.0% drivers/
	   5.6% fs/cachefiles/
	  19.9% fs/fscache/
	  28.4% fs/
	   3.1% include/
	  12.9% kernel/

so it really does seem like the old code is crud. It just never really 
mattered, because from a "is this a copy" standpoint, we don't care all 
that much about the "added" content, we care mostly about the original 
size and how much of it still remains.

(Sanity check: the diffstat for that thing says:

 277 files changed, 4426 insertions(+), 1244 deletions(-)

and diffstat for just Documentation/ says

 5 files changed, 289 insertions(+), 14 deletions(-)

so you'd expect that the Documentation changes would be at _least_ 
(289+14)/(4426+1244), ie ~5%, and since text documentation lines tend to 
be more dense than actual code (with lines with just curly braces etc), I 
do think that 7.6% Documentation/ sounds much more likely than <3% 
(invisible).

I also did a "git log -M --summary" on the current kernel git tree, and it 
didn't actually change any of _that_. So it seems that rename detection 
still ends up spitting out the same numbers.

Which is actually not surprising, because rename detection doesn't even 
end up _using_ the "literal_added" part at all (it just does:

	score = (int)(src_copied * MAX_SCORE / max_size);

ie it bases it's score on the amount of copied data, scaling it by the 
bigger of the two src/dst sizes).

So just fixing the "literal added" count should not mess anything up, and 
seems to fix dirstat.

It also looks a bit like diffcore-break actually worked around this whole 
thing, and does

        /* sanity */
        if (src->size < src_copied)
                src_copied = src->size;
        if (dst->size < literal_added + src_copied) {
                if (src_copied < dst->size)
                        literal_added = dst->size - src_copied;   
                else
                        literal_added = 0;
        } 
        src_removed = src->size - src_copied;

so this _may_ change what -B does, but I get the feeling that it should 
improve that too. I'm running a before-and-after "git log -M -B --summary" 
on the kernel now, but it's a pretty expensive operation, so it hasn't 
finished yet.

			Linus
