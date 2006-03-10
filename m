From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-rev-list feature request
Date: Thu, 9 Mar 2006 21:14:49 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603092056300.18022@g5.osdl.org>
References: <17424.53563.622642.738307@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.64.0603091950360.18022@g5.osdl.org> <17425.1459.786864.172060@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 10 06:15:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHZxw-0006S1-6q
	for gcvg-git@gmane.org; Fri, 10 Mar 2006 06:15:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751858AbWCJFO4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Mar 2006 00:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbWCJFO4
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Mar 2006 00:14:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46735 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751858AbWCJFOz (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Mar 2006 00:14:55 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2A5EoDZ018080
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 9 Mar 2006 21:14:51 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2A5EnsF001281;
	Thu, 9 Mar 2006 21:14:50 -0800
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17425.1459.786864.172060@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17454>



On Fri, 10 Mar 2006, Paul Mackerras wrote:

> Linus Torvalds writes:
> 
> > Yeah. I _think_ what you want is
> > 
> >  - phase 1: generate the current graph that we already do for
> > 
> > 	git-rev-list --all ^cmit
> > 
> >  - phase 2: start at "cmit", and mark everything that refers to it as 
> >    "show me" (including "cmit" itself, which was originally marked 
> >    uninteresting)
> 
> I'm not sure if that's what I want.  Is that how "git-rev-list -- foo" 
> works?

Nope. "git-rev-list -- foo" will just start from the heads given, and walk 
down. 

> What I want is basically just what "git-rev-list -- foo" does, but
> with some extra flexibility in choosing what commits are interesting -
> that is, to be able to say that a commit is interesting if it affects
> some file, has a reference under .git/refs, or if it is one of a set
> of specified commits.

Ahh, ok, you actually wanted something simpler than I thought you might.

What you want is (in its most trivial form) really trivial: mark the 
special commits you want to save with TREECHANGE, so that they aren't 
pruned by the logic that prunes off the "this commit doesn't change the 
file, so ignore it" commits.

HOWEVER. That trivial thing has problems. What if the history got 
simplified at a merge because one side of the merge changed it, and the 
other one did not - in that case we'll follow the history down the leg 
that didn't change (since that's the history that ended up being the final 
one). Now, that means that we will totally prune out the other parent 
info, and the commits you want to remain simply won't be "connected" any 
more.

To explain that better, let's say that history looks like this:

	     a
	    / \
	   b   c
	   |   |
	   d   e
	    \ /
	     f

and you're following file "foo", which is the same in "a" and "c". The 
fact that they are the same there means that the name pruning will decide 
that the history that led to "a" through "b" wasn't interesting, so it 
will prune that out, and make the whole history be

	   a
	   |
	   c
	   |
	   e
	   |
	   f

and then after that, it will remove all commits that didn't actually 
change foo at all (we know "a" was such a commit since we already 
simplified the merge, but let's say that "e" was one too), so you get

	   c
	   |
	   f

as the final simplified history right now.

Now, the problem is that what should you do if you want to tag "d" and "e" 
as inherently interesting (perhaps because they are tagged releases)?

Now, the "e" case is the above trivial case: just mark any "inherently 
interesting" commit with the TREECHANGE flag, and the history won't be 
pruned away. So it now looks like

	   c
	   |
	   e    <- faked "interesting"
	   |
	   f

however, the fact that you did the same to "d" means that we will have 
that too on our list of "interesting" commits, even though we've pruned 
away all of the history leading _from_ it, so the trivial algorithm would 
actually result in

	     c
	     |
	 d   e
	  \ /
	   f

in that case. We'd see "d" because it's somehow intrisically interesting, 
but it ends up being shown as that "dead tip", because the merge that 
would reach it was simplified away.

Is that what you'd want?

If so, then the appended trivial path should effectively do what you ask 
for. It keeps all the revs you passed in as "interesting" whether they are 
or not, so now you can effectively just pass in all the refs you want, and 
it will never remove any of the positive refs you passed it.

If you want a commit that has a ref pointing to it be marked as 
interesting only if we see it while parsing the tree, then you need to do 
slightly more (in "rewrite_one()", you should look up whether that commit 
has a ref pointing to it).

		Linus

----
diff --git a/revision.c b/revision.c
index 713f27e..90d3764 100644
--- a/revision.c
+++ b/revision.c
@@ -149,7 +149,8 @@ static struct commit *get_commit_referen
 		if (flags & UNINTERESTING) {
 			mark_parents_uninteresting(commit);
 			revs->limited = 1;
-		}
+		} else
+			object->flags |= TREECHANGE;
 		return commit;
 	}
 
