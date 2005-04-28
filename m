From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: kernel.org now has gitweb installed
Date: Thu, 28 Apr 2005 23:12:52 +0100
Message-ID: <1114726373.2734.47.camel@localhost.localdomain>
References: <42703E79.8050808@zytor.com>
	 <1114673723.12012.324.camel@baythorne.infradead.org>
	 <20050428081005.GG8612@pasky.ji.cz>
	 <1114676955.12012.346.camel@baythorne.infradead.org>
	 <1114680199.12012.363.camel@baythorne.infradead.org>
	 <Pine.LNX.4.58.0504281149330.18901@ppc970.osdl.org>
	 <1114723214.2734.9.camel@localhost.localdomain>
	 <42715B30.6010705@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 29 00:09:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRHBz-0000ag-1M
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 00:09:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262289AbVD1WOk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 18:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbVD1WOf
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 18:14:35 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:63370 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262281AbVD1WO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 18:14:26 -0400
Received: from baythorne.infradead.org ([81.187.226.107] helo=[192.168.129.125])
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DRHH1-0006h8-3p; Thu, 28 Apr 2005 23:14:20 +0100
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <42715B30.6010705@zytor.com>
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2005-04-28 at 14:52 -0700, H. Peter Anvin wrote:
> I thought about this for a few seconds (I really should do that more 
> often...) and realized what it is you want: you want a primary search 
> criterion which is "when did event X become visible to me", where "me" 
> in this case is the web tool.  That is not repository information, but 
> it is perfectly possible for the webtool to be aware of what it has 
> previously seen and when.
> 
> And yes, this ordering is clearly different for each observer.

The mailing list does it with tags -- it remembers the 'last seen
commit' and then effectively does 'rev-tree HEAD ^LASTSEEN', except that
I make a primitive attempt to get the ordering a little better than what
I get from rev-tree. But since the mailing list runs are hourly, I
really can get away with a _primitive_ attempt. That's why I hadn't
noticed the local/remote ordering problem that Linus pointed out.

It's not clear how you'd attempt to track local history for the general
case though -- the whole concept of a 'local' branch being special is
anathema to git. You'd have to hack it into some auxiliary storage, as I
do with tags -- but to get a fullly correct ordering it'd have to track
at least every locally-performed merge, and you really don't want to be
doing that kind of thing.

You might perhaps attempt to find a path through the graph which takes
in as many commits as possible where committer == `logname`@`hostname`
-- but as Linus and I already said, that's expensive.

I'm not entirely sure what the answer is; but it isn't parent ordering
and it isn't dates.

Using dates might be a nice quick approximation, but that really isn't
good enough. 

I wonder if we could try to enforce some meaning for dates though....
Currently, 'rev-tree AAAA ^BBBB' has to build the _entire_ tree for BBBB
back to the beginning, so it knows where to stop when following AAAA. 

However, if we _do_ take Junio's suggesting of enforcing monotonicity,
then we'll always know that the parents of a given commit will have a
timestamp which is older than its own timestamp. 

So given the task "list commits between 2.6.12-rc3 and 2.6.12-rc4' we
could look at the timestamp of rc3, and immediately follow the rc4
parents until we start seeing commits which are older than rc3. Then
each time we hit a commit in the parents of rc4 which is older than rc3
is, we continue doing a breadth-first search from rc3 until all the
parents we're looking at are older than the parent of rc4 which we're
currently considering. Etc. 

That means that the common case of "in A but not in B" can at least be
handled relatively efficiently without having to wait while it tracks
the history all the way back to the beginning. I still don't like it
much though...

-- 
dwmw2

