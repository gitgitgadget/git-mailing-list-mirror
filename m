From: Johan Herland <johan@herland.net>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Mon, 14 Feb 2011 10:18:46 +0100
Message-ID: <201102141018.46527.johan@herland.net>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <201102140036.42197.johan@herland.net>
 <7vfwrrukzq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 14 10:18:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Poua7-0004ZW-Tu
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 10:18:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751953Ab1BNJSv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 04:18:51 -0500
Received: from smtp.getmail.no ([84.208.15.66]:44301 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751079Ab1BNJSu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 04:18:50 -0500
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LGL0076NOJBIJB0@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 14 Feb 2011 10:18:48 +0100 (MET)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id BC7AB1EA583D_D58F377B	for <git@vger.kernel.org>; Mon,
 14 Feb 2011 09:18:47 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 0AF891EA2BAD_D58F377F	for <git@vger.kernel.org>; Mon,
 14 Feb 2011 09:18:47 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LGL007W8OJAMY00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 14 Feb 2011 10:18:47 +0100 (MET)
User-Agent: KMail/1.13.6 (Linux/2.6.37-ARCH; KDE/4.6.0; x86_64; ; )
In-reply-to: <7vfwrrukzq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166699>

On Monday 14 February 2011, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > Yes, replicating existing behavior w/explicit refspecs would look like: 
> >   [remote "origin"]
> >   
> >         url = git://git.example.com/repo.git
> >         fetch = +HEAD:refs/remotes/origin/HEAD
> >         fetch = +refs/heads/*:refs/remotes/origin/*
> >         fetch = ~refs/tags/*:refs/tags/*
> 
> While this is fine, I am not sure about the "HEAD" part.  Most of the
> protocol do not convey which branch HEAD points at (instead "clone" has
> to guess), which eventually needs to be fixed.  Incremental updates via
> "fetch" does not touch "HEAD" at all by design; unlike the real branch
> heads "remotes/origin/$branch" that are used to keep copies of what are
> at the remote, "remotes/origin/HEAD" is meant to be used by the local
> repository to designate which of the remote branch is considered the
> primary branch from local repository owner's point of view, primarily so
> that you can say "origin" locally to mean "origin/next" by setting the
> symref origin/HEAD to point at it.  In that sense, the guess made by
> "clone" is only used to give an initial value.

Ah, ok. I've misunderstood the purpose of "remotes/origin/HEAD" then. Feel 
free to remove that refspec line from my proposal, and leave it as a 
special-purpose thing set up by clone (and maintained by the user 
thereafter).

Still (as I think was recently discussed in another thread), the existence 
of remotes/origin/HEAD _does_ cause problems if the origin remote also has a 
branch called "refs/heads/HEAD" (which would collide when fetched into the 
local repo).

> > FTR, my new/proposed refspecs would look like this:
> >   [remote "origin"]
> >   
> >         url = git://git.example.com/repo.git
> >         fetch = +HEAD:refs/remotes/origin/HEAD
> >         fetch = +refs/heads/*:refs/remotes/origin/heads*
> >         fetch = ~+refs/tags/*:refs/remotes/origin/tags/*
> >       
> >       ( fetch = +refs/notes/*:refs/remotes/origin/notes/* )
> >       ( fetch = +refs/replace/*:refs/remotes/origin/replace/* )
> 
> I think you meant "refs/remotes/origin/heads/*" (note the slash) on the
> RHS of the branch refspecs.

Indeed. Thanks for pointing out the typo.

> How's that different from refs/*:refs/remotes/origin/* by the way?

It's not, except that "refs/*:refs/remotes/origin/*" would fetch a too-large 
superset. E.g. it would fetch "refs/remotes/third-party/heads/foo" into 
"refs/remotes/origin/remotes/third-party/heads/foo", which we probably don't 
want.

> Also
> if you give tags a totally separate namespace, I don't see much reason to
> still give it the "auto-follow" semantics.  It is far simpler to explain
> if you just fetch all of them and be done with it, no?

Agreed. Also, to quote Peff in http://thread.gmane.org/gmane.comp.version-
control.git/160503/focus=160726 :

"Now you could argue that auto-follow is not worth the effort. It is
somewhat confusing, and I can't think of a time when it ever actually
reduced the set of objects I was fetching (as opposed to just fetching
all tags). But maybe others have use cases where it matters."

So if nobody disagree, I would have no problem with dropping the leading "~" 
from the refspec, thus disabling auto-following (tracking all tags 
explicitly instead).

> > Yes, to me it seems intuitive that when you specify <URL> (even if
> > <URL> corresponds to an existing remote) you do NOT update
> > remote-tracking refs, but if you use <remote>, you should ALWAYS
> > update remote-tracking refs. Others may disagree.
> 
> One argument for disagreement used to be that an explicit fetch of a
> single branch was a deliberate way to avoid updating the tracking branch
> before examining what has been changed (i.e. "git fetch origin master"
> followed by "git log origin/master..FETCH_HEAD" and hopefully followed by
> "git pull origin" or somesuch).  But that was before reflog was adopted
> as a reliable safety measure, and I don't think people should rely on
> that behaviour anymore.
> 
> I would actually make an even stronger point that people should not base
> their workflow on keeping remote tracking refs deliberately stale, which
> is exactly the "feature" was meant to be used for.  What has happened on
> the other end has already happened whether you like it or not, and there
> is no point in your locally pretending that it didn't happen.  If you
> don't like the latest update there, you go talk to the party that control
> the remote and rectify the situation with them.  It may involve pushing a
> reverting or correcting commit over there, or in the worst case you
> simply stop pulling from them, forking the project in effect at that
> point.

Agreed.

> > It may seem so, but in my experience it doesn't really work perfectly:
> > Even if I fully control the repo I push to, I still want precise
> > control over what I push there. Sometimes I may working on 'next' and
> > 'master' in parallel, and I might have finished and tested some
> > bugfixes on 'master', while I still have unfinished/untested stuff on
> > 'next'.
> 
> Yes, I do this all the time and I often say "git push ko maint master"
> (ko is my name for the k.org repo).  I however don't feel inconvenienced
> by it precisely because when I make such a push, I _know_ that I want to
> push only these two branches.  Saying "only these two branches"
> explicitly from the command line, and seeing only these two branches go
> out, are very assuring to me.  I usually try to be much more organized
> to make sure all four integration branches satisfy certain preconditions
> before pushing, and I say "git push ko" only after I make sure they do.
> 
> I consider it is a good UI design to force myself to type more when I am
> doing something un(der)disciplined and to let me type less when I am
> following a good project hygiene.

I don't doubt that the current behavior works well for you (otherwise I 
expect you would have changed it). However, what I've seen at $dayjob is 
that more inexperienced users will often push right after committing, and at 
that time they're still very much in the "working-on-one-branch" state of 
mind (as opposed to the "administering-multiple-branches" state of mind), so 
when they follow up a "git commit" with a "git push" they're surprised (or 
worse: oblivious) to the fact that "git push" can push multiple branches.

I guess it comes down to whether you fundamentally consider "git push" 
something that pushes multiple _branches_, or something that pushes multiple 
_commits_. And for the latter of those groups push.default == "matching" is 
inherently more "dangerous" than for the former. (Granted, me telling 
everyone to use push.default == "tracking" probably doesn't help them in 
discovering "git push"'s ability to update multiple branches.)


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
