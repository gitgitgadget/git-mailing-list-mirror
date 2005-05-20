From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitk-1.0 released
Date: Fri, 20 May 2005 12:07:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505201150220.2206@ppc970.osdl.org>
References: <17036.36624.911071.810357@cargo.ozlabs.ibm.com>
 <20050519132411.GA29111@elte.hu> <17037.5109.556362.904185@cargo.ozlabs.ibm.com>
 <d6l9l1$ttd$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 21:06:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZCoT-0000E1-QR
	for gcvg-git@gmane.org; Fri, 20 May 2005 21:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbVETTGV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 15:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbVETTGV
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 15:06:21 -0400
Received: from fire.osdl.org ([65.172.181.4]:50827 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261438AbVETTFr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2005 15:05:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4KJ5gjA013799
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 20 May 2005 12:05:43 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4KJ5fG2027449;
	Fri, 20 May 2005 12:05:42 -0700
To: Kari Hameenaho <khaho@kolumbus.fi>
In-Reply-To: <d6l9l1$ttd$1@sea.gmane.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 20 May 2005, Kari Hameenaho wrote:
> Paul Mackerras wrote:
> > 
> > Yes, indeed.  I'll have to think about how to do it in a responsive
> > fashion, since getting the necessary information involves reading all
> > the commits and all the tree objects back to the beginning of time,
> > AFAICS.  
> 
> Maybe its not necessary to go back all the way. It is possible to look only
> commits between 2.6.12-rc4 and 2.6.12-rc3, like follows (needs just a few
> fixes to gitk):
> 
> gitk -d $(commit-id v2.6.12-rc4) ^$(parent-id $(commit-id v2.6.12-rc3))

But that _does_ actually go back all the way in time.

It does so inside of "git-rev-tree", and that's why git-rev-tree is slow.

What you can do, is to special-case certain things that git-rev-tree does, 
and try to do them more efficiently.

For example, git-rev-list is much nicer to use, exactly because it does
only one very particular special case of what git-rev-tree does, ie "list
all revisions". Because it's a special case, you can do it incrementally.

Similarly, you _can_ actually do "git-rev-tree HEAD ^OLD_HEAD" as a
special case too, and do it "as incrementally as possible". It's more
complicated than the (trivial) git-rev-list, so I've not actually done it,
but it's clearly important enough that I _should_ do it.

The way to do it "as incrementally as possible" is to start with the 
HEAD, and walk down and print out everything until you hit OLD_HEAD or a 
merge. Then:
 - If you hit OLD_HEAD, you're done.
 - If you hit a merge, you know the merge itself wasn't in OLD_HEAD, but 
   now one of the sides might contain OLD_HEAD which might have a merge
   pointing to the other side, so you don't know if you should show any of 
   the commits below it. What you do is:
    - walk down both paths in date order - like rev-list does - until you 
      _do_ hit OLD_HEAD. Here "date order" ends up being an approximation 
      for "how do I avoid going down a long chain that ends up already 
      being pointed to by OLD_HEAD"
    - mark everything reachable from OLD_HEAD as being uninteresting (aka 
      "seen"), and everything that reaches OLD_HEAD as being interesting
      and print it out.
    - as long as there are commits that aren't marked either uninteresting 
      _or_ interesting (they are unknown) continue to walk the commit 
      chain in date order, where the parent(s) of an uninteresting commit 
      is always uninteresting.
    - eventually, you'll have no unknowns left, and you can stop.

In the worst case, you'll end up walking back to the root (somebody did
development against the root, and then merged that development up after
OLD_HEAD), but that ends up being increasingly unlikely as the project
grows, so in practice this kind of algorithm will always end up doign work
that is comparable to the amount of development between OLD_HEAD and HEAD,
and independent of the total history size.

I might have missed some detail in the above, but it should be _fairly_
straightforward to start with rev-list.c and make it generate the lists of
"interesting", "uninteresting" and "unknown" commits and do the above.

Is anybody up for coding up this small exercise in graph traversal?

		Linus
