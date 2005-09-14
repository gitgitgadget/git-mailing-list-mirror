From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: dumb transports not being welcomed..
Date: Tue, 13 Sep 2005 18:42:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509131819310.26803@g5.osdl.org>
References: <7vek7s1xsh.fsf@assigned-by-dhcp.cox.net> <20050913211444.GA27029@mars.ravnborg.org>
 <7vacig1wrb.fsf@assigned-by-dhcp.cox.net> <7vpsrcwrc1.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0509131525250.26803@g5.osdl.org>
 <Pine.LNX.4.63.0509140152160.24606@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0509131742240.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Sam Ravnborg <sam@ravnborg.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 03:42:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFMHz-0003HN-45
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 03:42:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563AbVINBmQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Sep 2005 21:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932564AbVINBmQ
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Sep 2005 21:42:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39390 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932563AbVINBmQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Sep 2005 21:42:16 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8E1g6Bo007271
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 13 Sep 2005 18:42:06 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8E1g5rF007472;
	Tue, 13 Sep 2005 18:42:05 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.58.0509131742240.26803@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8507>



On Tue, 13 Sep 2005, Linus Torvalds wrote:
> 
> That said, I do think that --objects handling is _very_ CPU-hungry. The 
> offender is this old commit of mine:

No, never mind. Even without that, we end up walking a _lot_ of really
uninterestng "internal" trees (ie trees where all parents were
uninteresting, and they were parsed just because we had to parse a lot of 
commits to determine what they reached). 

To explain it a bit better, let's see a common case:


HEAD:		a
	       / \
	      b   \
	     / \   \
	    c   d   \
	   /   / \   \
	  e   f   g   x
	   \ /   /   /
	    h   i   /
	     \ /   /
	      j   /
	       \ /
Old history:    k


Now, imagine that we do 

	git-rev-list b..a

which results in just two commits: 'x' and 'a' (everything else is
reachable from 'b'). This is actually not that uncommon. However, in order 
to realize that, we had to walk through _all_ of a..k and x before we saw 
that 'b'..'k' were all uninteresting, and there was nothing else reachable 
that migt be interesting.

Now, that's pretty cheap per se. git-rev-list is optimized for this case, 
and hey, it's usually just a few hundred objects. Not a big deal - 
generating the commit list takes a small fraction of a second.

However, now the true cost of "--objects" is clear: we will walk the two
"positive" trees ('a' and 'x') and look up all their objects (about 35,000
of them) interesting. So far so good. Just another fraction of a second. 

HOWEVER, then we walk _every_single_uninteresting_commit_ and walk _their_
objects to say "we've got this already". And the uninteresting commits are
often many more than the interesting ones - we might have had to go
several weeks back to list them all. The above example is not at all
extreme: we might have something like 20 interesting commits, and several
hundreds of the uninteresting ones.

Now, the way to optimize things is to realize that there are two "classes" 
of uninteresting commits. There are the uninteresting commits that are 
adjacent to an interesting one (in the above example, they are "b" and 
"k"), and there are the uninteresting commits that are only reachable from 
-other- uninteresting commits ('c'..'j'). Let's call the latter class 
"doubly uninteresting commits", and the former class "uninteresting edge 
commits".

And we really don't need to walk the "doubly uninteresting" trees. But we
do. Because we don't have another phase to discover the edge (we can't do
that during the initial discovery phase, because we don't know if a commit
is going to end up interesting in the end - we migth have another commit
that we haven't seen yet that might be the parent of a commit that _looks_
interesting right now, but ends up being uninteresting because that
eventually seen parent ended up being uninteresting).

In other words: I bet I could make "git-rev-list --objects" go from ten
seconds to a single second if I did that edge discovery for most small
incremental updates. Instead, I'm lazy, and I'm describing the problem on 
the list as an "educational experience", and am callously hoping that 
somebody will see it as an interesting challenge ;)

Btw, the above is definitely not made up. If I did my statistics right,
doing "git-rev-list v2.6.14-rc1.." with the current tree results in 178
"interesting" commits, and 6251 "uninteresting" ones. And I bet 99% of
those uninteresting ones are "doubly uninteresting" - and we're just
wasting CPU time looking at what objects are reachable from them..

		Linus
