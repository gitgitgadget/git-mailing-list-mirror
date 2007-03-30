From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: SEGV in git-merge recursive:
Date: Fri, 30 Mar 2007 23:00:43 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0703302239050.4045@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070329075010.GA3493@hermes> <81b0412b0703290429k63642a34u6bea1e08803ffba7@mail.gmail.com>
 <20070329125803.GA16739@hermes> <81b0412b0703290634j6e62ba89tce3c8c963be3fb92@mail.gmail.com>
 <20070329141230.GB16739@hermes> <81b0412b0703290744h34b6ef01s4e6f90b1d7ed231b@mail.gmail.com>
 <81b0412b0703290804n13af6f40we79f7251562c540@mail.gmail.com>
 <20070329183237.GB2809@steel.home> <Pine.LNX.4.64.0703291232190.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703291237240.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>,
	Tom Prince <tom.prince@ualberta.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 30 23:00:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXODI-00086K-M2
	for gcvg-git@gmane.org; Fri, 30 Mar 2007 23:00:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753642AbXC3VAq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Mar 2007 17:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753821AbXC3VAq
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Mar 2007 17:00:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:57315 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753642AbXC3VAp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2007 17:00:45 -0400
Received: (qmail invoked by alias); 30 Mar 2007 21:00:43 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp047) with SMTP; 30 Mar 2007 23:00:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+NngtT1hSNYpr1x7TdlPkPABgJ3zLs4wFhLWPHrI
	RVXq4v3ycE7H/q
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0703291237240.6730@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 29 Mar 2007, Linus Torvalds wrote:

> On Thu, 29 Mar 2007, Linus Torvalds wrote:
> 
> > It's not the initial commit. It's a criss-cross merge, and it's a 
> > virtual commit created by a previous level of merging.
> > 
> > Apply this patch to see it blow up much earlier, when that bogus 
> > commit with a NULL tree is created.
> > 
> > (I didn't debug *why* that happens, but maybe this gets somebody 
> > further)
> 
> Well, it happens because "git_write_tree()" returns NULL. Which in turn 
> is because "unmerged_index()" returns true.
> 
> merge_trees() tries to clean up the unmerged index, but apparently 
> doesn't do good enough of a job, so git_write_tree() is called with 
> entries still unmerged..

Actually, this is not the complete truth.

This particular case has a conflicting rename/rename in an _intermediate_ 
commit. This _cannot_ be resolved automatically, not even by putting 
conflict markers into the appropriate files (*1*).

IMHO, there is actually no way merge_trees() can fix the conflicts enough 
to write a tree.

So, the only way I see to avoid that SEGV is to something like this:

diff --git a/merge-recursive.c b/merge-recursive.c
index ece2238..cbc39e9 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1135,8 +1135,13 @@ static int merge_trees(struct tree *head,
 	else
 		clean = 1;
 
-	if (index_only)
+	if (index_only) {
 		*result = git_write_tree();
+		if (!*result) {
+			flush_output();
+			die ("cannot continue merging.");
+		}
+	}
 
 	return clean;
 }

NOTE: I will not make the error again _not_ to point out that this is 
_just_ a hint at what a proper patch would look like.

For example, a proper patch would include a test case, _and_ would print a 
proper hint about GIT_MERGE_VERBOSITY (otherwise, you will only get a 
fatal error "cannot continue merging", without any hint about what went 
wrong).

Ciao,
Dscho

*1* I played with the idea to do a threeway merge of the conflicting files 
(src->dst1,dst2, using src as common version), but I am not quite sure if 
it is worth the confusion it seeds.

Besides, there is another type of rename/rename conflict, which _cannot_ 
be solved in that manner: (src1,src2->dst). And for this case, we have to 
have a sane way out anyway.
