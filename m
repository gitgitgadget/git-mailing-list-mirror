From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Kernel headers git tree
Date: Thu, 13 Jul 2006 22:16:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607132157370.5623@g5.osdl.org>
References: <1152835150.31372.23.camel@shinybook.infradead.org> 
 <7v4pxlt3xg.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.64.0607131800520.5623@g5.osdl.org>
 <1152840456.31372.75.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 14 07:17:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1G3B-00046M-Q5
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 07:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbWGNFRF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Jul 2006 01:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964794AbWGNFRE
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 01:17:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52943 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964790AbWGNFRD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Jul 2006 01:17:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6E5GsnW023978
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 13 Jul 2006 22:16:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6E5GrRr030087;
	Thu, 13 Jul 2006 22:16:53 -0700
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1152840456.31372.75.camel@shinybook.infradead.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.85__
X-MIMEDefang-Filter: osdl$Revision: 1.140 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23872>



On Fri, 14 Jul 2006, David Woodhouse wrote:
> > 
> > The default ordering from git-rev-list (and all other revision listing 
> > things, ie "git log" etc) _does_ guarantee that we never show a child 
> > before _one_ of its parents has been shown (although "parent" in this case 
> > may be the command line).
> 
> Does it? I thought at one point it sorted on some random criterion like
> alphabetically by author, or some other cosmetic information which isn't
> really part of the git structure -- like the timestamp or something?
> We still don't enforce monotonicity, do we? The timestamps are still
> just fluff?

The timestamps are, and always have been, just a heuristic.

The output order of git-rev-list is actually entirely well-defined, but 
it's the _cheap_ ordering, not the strict and full topological one.

The cheap ordering means that we don't ever look at the whole history, but 
it's still a real "DAG reachability ordering" in the sense that when we 
output a commit, we have _always_ output _one_ full path of commits to 
reach that commit from one of the starting point.

But since you can traverse the DAG in any number of ways, the heuristic is 
that when there are multiple choices, we pick the one with the most recent 
commit date.

So to give an example, let's say we have

	HEAD  ->     A
		    / \
		   B   C
		  / \   \
		 D   E   F
		  \ /   / \
		   G   H  I
		  .......

the difference between --topo-order and the default ordering for

	git rev-list HEAD

is most visible for commit 'G'.

For --topo-order, we guarantee that before we show 'G', we _will_ have 
shown both 'D' and 'E'. In other words, --topo-ordering guarantees that it 
shows _all_ children before it shows the parent.

That's a _very_ very expensive thing to guarantee, because you can't 
actually tell that you've seen all children on 'G' before you've basically 
traversed most of the tree. In the above example, you CANNOT tell whether 
'F' is a child of 'G', for exmaple. Think about it. You don't know - maybe 
the missing piece is 'I' -> 'Z' -> 'G', but without having parsed all the 
commits, you'll never know.

[ Actually, strictly speaking, you can guarantee it earlier than before 
  you parsed them _all_: you can guarantee it once _every_single_commit_ 
  whose parents you haven't followed yet is a direct ancestor of 'G' - at 
  that point, and not before, do you know that 'G' can have no more 
  children. That's actually very expensive to compute, so we don't do it - 
  we will walk the whole history, and only _then_ do we use one of the 
  algorithms to generate a topological sort from the full DAG.

  If somebody knows of an _incremental_ algorithm that doesn't need the 
  full DAG and can do a topo-ordering, that would be wonderful. But it's 
  basically very very very expensive. ]

So by default, we don't do that at all. By default, we will print out 'G' 
whenever we have printed out _any_ path leading to 'G', and 'G' is the 
commit with the most recent commit date.

So we might print things out as A, B, D, G, E ... - notice how we printed 
out 'E' _after_ we did 'G', but we did have the A->B->D->G path, so G was 
reachable from the top along the path we printed.

> In this case, I really do have commits in the intermediate tree which
> don't actually change anything, and I want to filter them out -- I
> couldn't see a simple way to do it all in one pass.

Ok, in that case, the "." is correct, but the --topo-order should be 
unnecessary because you only care about the first entry.

			Linus
