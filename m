From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 0/2] History replay support
Date: Fri, 2 Nov 2007 13:31:36 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0711021301200.3342@woody.linux-foundation.org>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com> 
 <alpine.LFD.0.999.0710272229430.30120@woody.linux-foundation.org> 
 <18212.13862.637991.30536@cargo.ozlabs.ibm.com> 
 <alpine.LFD.0.999.0710280943090.30120@woody.linux-foundation.org> 
 <18217.41899.54812.227152@cargo.ozlabs.ibm.com> 
 <alpine.LFD.0.999.0711010815320.3342@woody.linux-foundation.org> 
 <18218.63946.772767.179841@cargo.ozlabs.ibm.com>
 <e5bfff550711020544h1e9a648apfd268eb549645ccc@mail.gmail.com>
 <alpine.LFD.0.999.0711020828440.3342@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711021114390.3342@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 21:31:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io3BM-0001hI-2N
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 21:31:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758137AbXKBUbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 16:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758191AbXKBUbk
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 16:31:40 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:33841 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756148AbXKBUbj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Nov 2007 16:31:39 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA2KVaVE028682
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 2 Nov 2007 13:31:37 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA2KVava009644;
	Fri, 2 Nov 2007 13:31:36 -0700
In-Reply-To: <alpine.LFD.0.999.0711021114390.3342@woody.linux-foundation.org>
X-Spam-Status: No, hits=-3.23 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63171>


Ok, this is a rough first draft of avoiding the topological sort up-front, 
and instead incrementally sorting only when actually necessary.

The first patch is a pure cleanup. Quite frankly, I suspect the old 
topological sorting code would have worked perfectly fine as-is, but I 
couldn't really bear to watch it or think about debugging it the way it 
was before.

The indirection and other strangeness just blew my tiny little mind, and 
while I bet it had some historical reason, I ended up reworking that 
thing. I tried to keep it as similar as humanly possible to the old code 
(because it's easy to get wrong, and because I really didn't want to worry 
about the toposort itself), but the numbers speak for themselves:

	 4 files changed, 55 insertions(+), 126 deletions(-)

should tell you something. And it means that there are no subtle calling 
issues with preconditions for using the toposort etc - you can use it over 
and over again, and it should all be obvious. Knock wood.

The second diff is the one that actually adds the new feature, and it 
undoes most of the nice statistics of the first one:

	 5 files changed, 70 insertions(+), 12 deletions(-)

but we still end up with more deletions than insertions on the whole, 
*and* a new feature.

The new code is triggered by using the "--replay" flag, which will cause 
certain consistency checks to be done when a commit is shown by the log 
machinery. In particular:

 - if we print out a parent SHA1, and the parent has already been shown, 
   that's a topology violation, and causes a replay.
 - if we turn a commit unintersting, and the commit has already been 
   shown, that's a "uninteresting" violation, and causes a replay.

The second one I didn't test at all. It's probably hard to trigger, and 
I bet there are bugs there, but this is very much a WIP patch, with the 
hope that people other than me can work on it.

When a replay happens, the log code will print out

	Replay <sha1>

for each <sha1> commit that gets invalidated by the replay, and then start 
*that* part of history anew, with just the required part re-sorted.

Should it print just the number of commits? Perhaps. Play around with 
this.

Anyway, to give you some kind of idea of the effect of this, in the 
current git tree as it exists in my repo, I get 15 replay events, and if 
you compare the total log output, you see:

	[torvalds@woody git]$ wc -l t1 t2
	  170191 t1
	  178150 t2

where "t1" is without replays, and "t2" is with replays. The replays 
obviously do add lines (the replayed ones), but at least for git, it's on 
the order of 5% lines replayed.

The big difference is in the latency:

	time git log --parents --topo-order | head
	real    0m0.163s

vs

	time git log --parents --replay | head
	real    0m0.003s

ie you can see how the --replay thing starts outputtig commits 
immediately, because it knows it can just back up and fix any errors that 
happen.

That's the good news.

The bad news is that it doesn't work well in this simplistic form, because 
there is a O(n**2) behaviour when replays *do* happen, ie we end up having 
replays within replays, and rather than getting a 5% increase like for git 
itself, for the kernel archive this gets a roughly 50x increase for the 
replay. So the *latency* still improves dramatically (getting the first 
one hundred commits in 0.006 seconds vs 1.076s), but because of the bad 
behaviour wrt cascading replays, it's not really usable in this form (the 
full log goes from 8 seconds to 22s when writing to /dev/null - and is 
much worse if the receiver actually has to do something about it).

I think the right thing to do wrt this all would be to turn the replay 
logic into a latency-based one, where it would basically batch things up, 
but make sure to output something at least every half a second or so. But 
that's a pretty separate set of logic, so I thought I'd send this out 
as-is for comments..

			Linus
