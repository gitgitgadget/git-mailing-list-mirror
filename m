From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Fri, 20 Oct 2006 13:57:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610201333240.3962@g5.osdl.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<200610201821.34712.jnareb@gmail.com>
	<20061020181210.GA29843@artax.karlin.mff.cuni.cz>
	<200610202047.11291.jnareb@gmail.com>
	<Pine.LNX.4.64.0610201151130.3962@g5.osdl.org>
	<45391F1C.80100@utoronto.ca>
	<Pine.LNX.4.64.0610201231570.3962@g5.osdl.org>
	<4539318D.9040004@utoronto.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: bazaar-ng@lists.canonical.com, Jan Hudec <bulb@ucw.cz>,
	Git Mailing List <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>
X-From: bazaar-ng-bounces@lists.canonical.com Fri Oct 20 22:57:40 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb1Qx-0005R6-Ra
	for gcvbg-bazaar-ng@m.gmane.org; Fri, 20 Oct 2006 22:57:40 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1Gb1Qu-0006Oo-MF; Fri, 20 Oct 2006 21:57:36 +0100
Received: from smtp.osdl.org ([65.172.181.4])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <torvalds@osdl.org>) id 1Gb1Qp-0006NN-WB
	for bazaar-ng@lists.canonical.com; Fri, 20 Oct 2006 21:57:32 +0100
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9KKvSaX006871
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 20 Oct 2006 13:57:28 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9KKvRin002139;
	Fri, 20 Oct 2006 13:57:27 -0700
To: Aaron Bentley <aaron.bentley@utoronto.ca>
In-Reply-To: <4539318D.9040004@utoronto.ca>
X-Spam-Status: No, hits=-0.977 required=5 tests=AWL,
	OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29540>



On Fri, 20 Oct 2006, Aaron Bentley wrote:
> 
> Agreed.  We start by comparing BASE and OTHER, so all those comparisons
> are in-memory operations that don't hit disk.  Only for files where BASE
> and OTHER differ do we even examine the THIS version.

Git just slurps in all three trees. I actually think that the current 
merge-recursive.c does it the stupid way (ie it expands all trees 
recursively, regardless of whether it's needed or not), but I should 
really check with Dscho, since I had nothing to do with that code.

I wrote a tree-level merger that avoided doing the recursive tree reading 
when the tree-SHA1's matched entirely, and re-doing the latest merge using 
that took all of 0.037s, because it didn't recursively expand any of the 
uninteresting trees.

But the default recursive merge was ported from the python script that 
did it a full tree at a time, so it's comparatively "slow". But it's fast 
enough (witness the under-1s time ;) that I think the motivation to be 
smarter about reading the trees was basically not just there, so my 
"git-merge-tree" thing is languishing as a proof-of-concept.

So right now, git merging itself doesn't even take advantage of the "you 
can compare two whole directories in one go". We do that all over the 
place in other situations, though (it's a big reason for why doing a 
"diff" between different revisions is so fast - you can cut the problem 
space up and ignore the known-identical parts much faster).

That tree-based data structure turned out to be wonderful. Originally (as 
in "first weeks of actual git work" in April 2005) git had a flat "file 
manifest" kind of thing, and that really sucked.  So the data structures 
are important, and I think we got those right fairly early on.

> We can do a do-nothing kernel merge in < 20 seconds, and that's
> comparing every single file in the tree.  In Python.  I was aiming for
> less than 10 seconds, but didn't quite hit it.

Well, so I know I can do that particular actual merge in 0.037 seconds 
(that's not counting the history traversal to actually find the common 
parent, which is another 0.01s or more ;), so we should be able to 
comfortably do the simple merges in less than a tenth of a second. But at 
some point, apparently nobody just cares.

Of course, this kind of thing depends a lot on developer behaviour. We had 
some performance bugs that we didn't notice simply because the kernel 
didn't show any of those patterns, but people using it for other things 
had slower merges. Sometimes you don't see the problem, just because you 
end up looking at the wrong pattern for performance.

> > So recursive basically generates the matrix of similarity for the 
> > new/deleted files, and tries to match them up, and there you have your 
> > renames - without ever looking at the history of how you ended up where 
> > you are.
> 
> So in the simple case, you compare unmatched THIS, OTHER and BASE files
> to find the renames?

Right. Some cases are easy: if one of the branches only added files (which 
is relatively common), that obviously cannot be a rename. So you don't 
even have to compare all possible combinarions - you know you don't have 
renames from one branch to the other ;)

But I'm not even the authorative person to explain all the details of the 
current recursive merge, and I might have missed something. Dscho? 
Fredrik? Anything you want to add?

			Linus
