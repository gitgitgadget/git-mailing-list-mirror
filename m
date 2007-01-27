From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: More precise tag following
Date: Sat, 27 Jan 2007 17:46:14 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701271728020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org>
 <Pine.LNX.4.63.0701271352170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45BB5888.9020608@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Sat Jan 27 17:46:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAqh2-0001u8-43
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 17:46:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892AbXA0QqR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 11:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751908AbXA0QqR
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 11:46:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:36429 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751892AbXA0QqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 11:46:16 -0500
Received: (qmail invoked by alias); 27 Jan 2007 16:46:14 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp011) with SMTP; 27 Jan 2007 17:46:14 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45BB5888.9020608@fs.ei.tum.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37961>

Hi,

On Sat, 27 Jan 2007, Simon 'corecode' Schubert wrote:

> Johannes Schindelin wrote:
> > It is slower than Subversion's counterpart, just because SVN's blame sucks.
> > You cannot find out the _relevant_ information easily, i.e. once you merged
> > something, the _merge_ gets attributed for the change (at least the last
> > time I tried it).
> > 
> > So, don't blame blame for being useful in git.
> 
> Your reasoning is backwards.  Git's blame (or fwiw, rev-list path.name) 
> is not slower because it is doing a better job (I can't tell, I don't 
> use svn), but because it uses an algorithm which doesn't scale.  
> rev-list and blame are O(number of commits between HEAD and root) and 
> not O(number of commits affecting path).

Ah, I think you fall in the "files matter" trap.

My point is: for what git does it does not need information which might or 
might not be present, but it derives that information which was there from 
the beginning: the ancestry path.

Many people don't use or even need blame. And what you want to introduce 
would affect them, too.

That is why I proposed a cache (of precomputed data): you don't have to 
change _anything_ in the file format, but you can speed the processes up 
-- locally! -- if they matter to you.

Which means it works on old repositories, too.

> It might be sufficient for git.git, but certainly not for projects with 
> a long history.  we are talking KDE, FreeBSD, OOo, something like this.  
> They each got about 400k commits.  It takes literally *minutes* to get a 
> rev-list or a blame for a certain path.  The algorithm simply does not 
> scale.  And this has nothing to do with superior output, because hg does 
> it in O(num_of_file_revs), so it *can* be done.

But can hg do it that fast, if you track code _movement_ between files? I 
doubt so.

I don't know if git can, at the moment, but even if it cannot, in future 
versions this may well be possible, exactly because we do _not_ rely on 
metadata to be stored in the objects, which can be derived from the 
history as-is anyway.

> > Of course, you could introduce a cache, but then, I don't run blame 
> > _that_ often.
> 
> I don't think a cache is the right way.  I'd call the right idea 
> "auxillary information".

You can name it "Dirty Harry" if you want.

The important part is that you should not change the file format when you 
do not have to.

Rather, calculate the information you need from the existing data, and if 
you can reuse it, store it locally. _That_ is flexibility.

It also gives me a warm fuzzy feeling that no bogus "auxillary 
information" can be introduced by fetching from somewhere else. (It does 
not matter if intended or unintended.)

And if something is wrong with that "auxillary information", it can be 
regenerated correctly, without touching the real data -- the commit 
ancestry.

Just think of .git/info/refs: this data is derived from the repository, 
but because you need it so often (or it would be prohibitively expensive 
to do otherwise), it is derived only when needed, then stored, and 
retrieved quite often.

> > Besides, we already introduced an orthogonal historisation by reflogs, 
> > and your method would not cope gracefully with that, would it?
> 
> I don't see how reflogs can play into this.  After all we're talking 
> about the series of commits the blob experienced to get into its current 
> state, not the series of actions it took this repo to contain this blob.

My point was that you want to introduce a reverse mapping onto the history 
DAG. But this claims that there is only one history you can possibly look 
at. This assumption is wrong.

It can make a lot of sense to git-blame a change on a pull, maybe because 
you don't want to fix it yourself, but throw it all back to the lieutnant 
whom you pulled that part from.

You could find that pull (in theory; I don't think it works right now) 
with git-blame walking the _reflogs_ instead of the _commit history_.

In this case, your reverse mapping would be wrong.

See?

Ciao,
Dscho
