From: Petr Baudis <pasky@suse.cz>
Subject: Re: git-bisect problem
Date: Tue, 14 Feb 2006 02:27:55 +0100
Message-ID: <20060214012755.GC31278@pasky.or.cz>
References: <20060213002502.5c23122c.akpm@osdl.org> <7virrj1v44.fsf@assigned-by-dhcp.cox.net> <20060213013205.4ba47836.akpm@osdl.org> <7vbqxb1sho.fsf@assigned-by-dhcp.cox.net> <20060213021917.742b2b10.akpm@osdl.org> <7v8xsezsni.fsf@assigned-by-dhcp.cox.net> <20060213165620.11ec6051.akpm@osdl.org> <20060214011512.GB31278@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 02:27:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8oyN-0002hX-33
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 02:27:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbWBNB1N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 20:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbWBNB1N
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 20:27:13 -0500
Received: from w241.dkm.cz ([62.24.88.241]:64716 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750868AbWBNB1M (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2006 20:27:12 -0500
Received: (qmail 28984 invoked by uid 2001); 14 Feb 2006 02:27:55 +0100
To: Andrew Morton <akpm@osdl.org>
Content-Disposition: inline
In-Reply-To: <20060214011512.GB31278@pasky.or.cz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16097>

Dear diary, on Tue, Feb 14, 2006 at 02:15:12AM CET, I got a letter
where Petr Baudis <pasky@suse.cz> said that...
> Dear diary, on Tue, Feb 14, 2006 at 01:56:20AM CET, I got a letter
> where Andrew Morton <akpm@osdl.org> said that...
> > Junio C Hamano <junkio@cox.net> wrote:
> > >
> > > Sorry, this question is what I do not quite understand.
> > > 
> > >  Here is my understanding of the situation.
> > > 
> > >   - Betweeen 2.6.16-rc1 and 2.6.16-rc2 a bug you are chasing was
> > >     introduced.  You know rc1 works fine but rc2 is bad.
> > > 
> > >   - You suspect that changes introduced by merging Jeff's tree
> > >     at some point between -rc1 and -rc2 may be causing this.
> > > 
> > >  Am I totally misunderstanding the situation?
> > 
> > yup ;)
> > 
> > The bug is in Jeff's tree only
> > (git+ssh://master.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git#ALL)
> > so I wanted to perform the bisection on the git-netdev-all branch.
> > 
> > So I did a `git log git-netdev-all' and looked at where the ipw2200 changes
> > were and then decided that the 2.6.16-rc1 and 2.6.16-rc2 commits straddled
> > those changes nicely, so I chose those as the bisection starting points.
> 
> But aren't those commits on the Linus' "branch", not containing any
> commits specific to git-netdev-all?
> 
> I imagine the situation is like:
> 
> * -- 2.6.16-rc1  -- * -- * -- 2.6.16-rc2  -- * - -  (linus)
>   \                        \              \
> * -- * -- * -- * -- * -- * -- * -- * -- * -- M - -  (git-netdev-all)
> 
> Then, if you bisect between -rc2 and -rc1, you will never actually get
> to the git-netdev-all branch, since there are no such commits inbetween
> -rc2 and -rc1. Even if you consider this:
> 
> * -- 2.6.16-rc1  -- * -- * -- 2.6.16-rc2  -- * - -  (linus)
>   \              /         \              \
> * -- X -- Y -- Z -- A -- * -- * -- * -- * -- M - -  (git-netdev-all)
> 
> git-bisect will consider the X, Y, Z commits (since they are part of the
> ancestry between -rc and -rc2), but not commits from A on - it can't
> reach them topologically if it considers only commits between -rc1 and
> -rc2:
> 
> * -- 2.6.16-rc1  -- * -- * -- 2.6.16-rc2
>   \              /
>    - X -- Y -- Z

I got this one (and consequently, the following one) wrong - obviously,
it should read as

       2.6.16-rc1  -- * -- * -- 2.6.16-rc2
                   /
       X -- Y -- Z

since the "asterisk" commit is already behind -rc1.


Pedagogical excursion:

All those commit intervals are really set differences - if you have
commit A and commit B,

	[A,B] = B \cup (ancestry(B) \ ancestry(A))

or if you don't like math, color B and all its ancestors blue in
your head, and then color all the A ancestors black. The commits
that stay blue are in the [A,B] interval.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
