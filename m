From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Joining cg-*-id
Date: Tue, 20 Sep 2005 07:53:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509200734440.2553@g5.osdl.org>
References: <1127166049.26772.26.camel@dv> <20050919215608.GA13845@pasky.or.cz>
 <Pine.LNX.4.58.0509191505470.2553@g5.osdl.org> <20050919225422.GG18320@pasky.or.cz>
 <Pine.LNX.4.58.0509191746130.2553@g5.osdl.org> <20050920135735.GC1884@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Pavel Roskin <proski@gnu.org>,
	fonseca@diku.dk, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 20 16:56:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHjUz-0008C7-Oc
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 16:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965022AbVITOxa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 10:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965023AbVITOxa
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 10:53:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22739 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965022AbVITOxa (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Sep 2005 10:53:30 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8KErGBo027119
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 20 Sep 2005 07:53:17 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8KErCBV020394;
	Tue, 20 Sep 2005 07:53:13 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050920135735.GC1884@pasky.or.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.117 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8997>



On Tue, 20 Sep 2005, Petr Baudis wrote:
> > 
> > So I'd love to have
> > 
> > 	git diff yesterday..
> > 
> > but the fact is, there's no sensible semantics for it. _which_ yesterday? 
> > There might be five different points that are "close to 24 hours ago", 
> > along five different paths backwards in the history.
> 
> A well-defined meaning for this from Cogito standpoint would be "the
> last commit on our HEAD before the date and all commits committed and
> merged to the HEAD". In Cogito, you don't merge two branches _together_,
> you merge one branch _into_ another (represented by the parents order),
> so this would be sensible.

No, it's _not_ sensible or well-defined.

The order of the parents does not matter. It fundamentally _cannot_ 
matter. I realize that both git and cogito put the "primary parent" first, 
but that doesn't help one iota - because git is distributed, if the other 
side merged and we just did a fast-forward, the "primary parent" will be 
the _other_ side.

In other words, anybody who thinks that the order of parents is meaningful 
is in for some nasty shocks. It really _fundamentally_ isn't true. I 
realize that's hard to accept, but it's a truism in a distributed system. 
You really cannot have parent ordering and distribution at the same time.

> But we would have to sort the log in merge order for this to be possible
> (and probably teach git-rev-list about it anyway).

It's not sensible regardless of how you order things. There _is_ no 
ordering. 

So if you give a date, and there is a merge after that date, you will
always have at least two ways to reach the next older commit (now, if
you're lucky, it will be a common one and unambiguous, but more commonly
you'll simply have _two_ commits that are "most recent commit older than
the date".

And if you select one of them at random (or by deciding which parent is 
the "primary" one), then 

	git diff yesterday..

will show not the changes since yesterday, but _all_ the changes that came 
in through the merge.

> By the way, did I understand it right that the only difference between
> the results of merge ordering and topo ordering is the order commits
> with regard to the order of parents?

The only guarantees topo-ordering gives is that a parent will be shown 
before its children. So it may still mix up commits that happened 
between two parallell workflows, unlike merge-order that will always show 
one parallell chain of development as a contiguous set of commits.

Only merge-order gives any meaning to the order of the parents, but as 
mentioned, that is irrelevant - a merge on the other side will "flip" the 
whole world-view.

And they happen.

		Linus
