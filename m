From: Carl Baldwin <cnb@fc.hp.com>
Subject: Re: How is working on arbitrary remote heads supposed to work in Cogito (+ PATCH)?
Date: Mon, 15 Aug 2005 10:23:24 -0600
Organization: Hewlett Packard
Message-ID: <20050815162324.GA9857@hpsvcnb.fc.hp.com>
References: <20050729081051.GH24895@pasky.ji.cz> <20050813041114.GA29412@hpsvcnb.fc.hp.com> <7vacjmqnu7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Baldwin <cnb@fc.hp.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 15 18:24:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4hkL-0006PY-St
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 18:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbVHOQXb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 12:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964818AbVHOQXb
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 12:23:31 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:24971 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S964817AbVHOQXa (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Aug 2005 12:23:30 -0400
Received: from smtp2.fc.hp.com (smtp.fc.hp.com [15.15.136.253])
	by atlrel7.hp.com (Postfix) with ESMTP id E4B9BDE8;
	Mon, 15 Aug 2005 12:23:29 -0400 (EDT)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp2.fc.hp.com (Postfix) with ESMTP
	id AAD6D41F5C8; Mon, 15 Aug 2005 16:23:29 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id 899EB2AF18; Mon, 15 Aug 2005 10:23:24 -0600 (MDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vacjmqnu7.fsf@assigned-by-dhcp.cox.net>
X-Origin: hpescnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Over the week-end, I was thinking about the thread "Re: How is working
on arbitrary remote heads supposed to work in Cogito".  I wanted to
weigh in an opinion that I've developed on it but thought it deserved a
new thread.

Somewhere in the thread something was mentioned about maintaining
<local branch>:<remote branch> pairs in the git repository when pushes
and pulls are performed.  I think the argument was actually against
keeping this information and ultimately against allowing pushes to a
branch of a different name.

I wanted to weigh in with why it would be a good idea to make note of
this information.  The only thing that would be required of the plumbing
is to specify how this information is kept and if a push or pull is
performed directly with git then make note of the push/pull
relationship.  Everything else would be up to the porcelains.

So, I envision a simple directed graph where nodes represent the
branches (wether local or remote) and the edges represent push or pull
relationships between branches.

Git already stores the nodes.

The edges, in theory, would spring into existence when a push or pull is
performed between two branches for the first time.

This graph will be extremely useful for manageing flow in a project.  It
could enable something as simple as a script that would walk the edges
and tell which ones have fallen behind.  It would also be possible to
easily pull up a visual representation of the graph (with graphviz,
maybe).  This sort of thing might prove to be a valuable orientation
tool for the developer or project manager.

It could also enable some very powerful project flow management --- in a
porcelain of course --- that would manage flow from an engineer's own
sand-box through software engineering 'gates' such as integration,
quality assurance, product maintenance and the documentation and
sign-offs required to pass through each of these gates.

It could also be used to aid in documenting and managing the, already
existent, linux tree development flow in whatever way suits.

This is a big return on investment.  Little would be required of the
plumbing to maintain these 'edges', just add to them when it performs a
push/pull on an edge that hasn't already been recorded.  Any changes or
deletions could be handled by the user or by some porcelain.

I think it is important, though, to specify how this information should
be stored to maintain compatibility between porcelains while (hopefully)
allowing for some degree of flexibility.  I don't yet know where this
line should be drawn.

Carl

On Sat, Aug 13, 2005 at 12:48:32AM -0700, Junio C Hamano wrote:
> Carl Baldwin <cnb@fc.hp.com> writes:
> 
> > On Fri, Jul 29, 2005 at 08:10:51AM +0000, Petr Baudis wrote:
> >> Exactly. I want much more freedom in pushing, the only requirement being
> >> that "the to-be-replaced remote head is ancestor of the to-be-pushed
> >> local head". I think (am I wrong?) git-send-pack localhead:remotehead
> >> would work just fine for me, the only thing I need is the support for
> >> different local and remote head names.
> >
> > Sorry to join the game so late.  I've only read this thread now.
> 
> Just in case you have not noticed, the push in 0.99.4 and
> onwards does exactly that.  Please see git-push-script.txt in
> the Documentation/ directory --- oops, there is no such thing.
> 
> Please see git-send-pack.txt instead, and if you feel like it, I
> would appreciate a patch to add the missing documentation for
> git-push-script ;-).
> 
> What's not supported well yet is the opposite --- downloading
> multiple refs and dealing with them.
> 
> Johannes Schindelin calls this "reverse push", and I think that
> is really a good name to describe what it does.  It takes a
> remote repository and possibly multiple refs, downloads the
> objects to complete the named remote references, and updates the
> local refs only if the remote refs are fast forward children of
> the local refs being replaced, just like "push" fast forwards
> the remote refs using the local refs.  In other words, given
> <src> and <dst> repository, the following should do the same
> thing:
> 
>     On <src> repository machine, with GIT_DIR being the <src> repository:
>     $ git push <dst> <ref-local-name>:<ref-remote-name>...
> 
>     On <dst> repository machine, with GIT_DIR being the <dst> repository:
>     $ git pull <src> <ref-remote-name>:<ref-local-name>...
> 
> Johannes posted a script on the list a couple of days ago, which
> should work well, except that it was written before the
> git-fetch-pack command was updated to natively download from
> multiple refs, so it does not know how to fetch multiple refs at
> a one go.
> 
> -jc
> 

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        Systems VLSI Laboratory
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
