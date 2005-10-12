From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Add '--create-index' to git-unpack-objects
Date: Wed, 12 Oct 2005 08:20:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510120809190.14597@g5.osdl.org>
References: <Pine.LNX.4.63.0510121301340.30679@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051012173426.56fd5c1c.vsu@altlinux.ru>
 <Pine.LNX.4.63.0510121612340.6307@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051012145548.GA2539@master.mivlgu.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Oct 12 17:24:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPiPX-00079t-DG
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 17:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbVJLPU0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 11:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbVJLPU0
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 11:20:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43497 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964808AbVJLPU0 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Oct 2005 11:20:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9CFK64s011408
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 12 Oct 2005 08:20:06 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9CFK4YJ032489;
	Wed, 12 Oct 2005 08:20:05 -0700
To: Sergey Vlasov <vsu@altlinux.ru>
In-Reply-To: <20051012145548.GA2539@master.mivlgu.local>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.52__
X-MIMEDefang-Filter: osdl$Revision: 1.124 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10036>



On Wed, 12 Oct 2005, Sergey Vlasov wrote:
> 
> Hmm, pack-objects.c:write_one() does exactly the opposite - it writes
> the base object _after_ writing out the delta (but it does not ensure
> that ordering completely, so references to base objects can be
> pointing in both directions).  Why?

pack-objects.c is actually going to some trouble to make sure that the 
resulting pack is "optimal" in layout for the most recent case.

Not that I have actually verified optimality, but it was _meant_ to be 
that way. And my limited tests seemed to agree.

So it writes out all objects in "recency order", which is the order it 
gets them from git-rev-list: it's the same order as the objects are 
discovered when we traverse the history in time (except all commits come 
first, since most operations will traverse the commit history more than 
they will traverse the rest of the object links).

So the objects that are reachable in the most recent tree are all supposed 
to be at the beginning of the pack-file, just after the commits.

Now, think about what happens if such an object is a delta against 
something else...

In other words, if the most recent tree contains a delta against a much 
older object, we want not only the _delta_ to be early in the pack-file, 
we want the object that it is a delta _against_ to be there too (just 
_after_ the delta, to be exact: we obviously read the delta first, so it 
should come first in the pack).

The point being, that if you unpack the latest tree (ie "git checkout" or 
any of the normal "git diff" behaviour), the pack-file will basically be 
walked in a dense manner, and linearly starting roughly from the 
beginning. Which is the optimal IO pattern. Dense and ascending reads.

Now, if the object is reachable through some recent branch, but the delta 
is not, then that is not true. In that case, you want to write the recent 
base object early in the pack-file, but you do _not_ want to write the 
delta together with it, because that would be the wrong thing for the 
"recent head" case: it would add stuff to the beginning of the pack-file 
that isn't needed for recent objects.

So that's why it's an assymmetric thing. The preferred ordering of time 
breaks the symmetry.

			Linus
