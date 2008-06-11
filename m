From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: stg pull/rebase
Date: Wed, 11 Jun 2008 08:11:10 +0200
Message-ID: <20080611061110.GA15034@diana.vm.bytemark.co.uk>
References: <20080607172202.GA5179@diana.vm.bytemark.co.uk> <b0943d9e0806100302j159f5b7fq6d970316b902b39b@mail.gmail.com> <20080610104244.GC30119@diana.vm.bytemark.co.uk> <b0943d9e0806100843j28bb3353y5889a50712377959@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 08:12:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6JZC-0006GH-K7
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 08:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245AbYFKGLZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jun 2008 02:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752070AbYFKGLZ
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 02:11:25 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1101 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752245AbYFKGLY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 02:11:24 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K6JY6-000444-00; Wed, 11 Jun 2008 07:11:10 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0806100843j28bb3353y5889a50712377959@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84592>

On 2008-06-10 16:43:27 +0100, Catalin Marinas wrote:

> 2008/6/10 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > On 2008-06-10 11:02:18 +0100, Catalin Marinas wrote:
> >
> > > However, I found some these policies useful. For example, I just
> > > do a "stg pull" from a Subversion repository with the config
> > > below:
> > >
> > > [stgit]
> > >         pull-policy =3D fetch-rebase
> > >         fetchcmd =3D git svn fetch
> > >         rebasecmd =3D git svn rebase
> >
> > Looks useful.
> >
> > But what exactly is "rebasecmd" useful for, when you already have
> > "fetchcmd" and a built-in rebase?
>
> In case the built-in rebase is not enough. Can you use "git svn
> fetch" followed by plain "git rebase"? There are some comments in
> git-svn.txt that recommend to use "git svn rebase" to preserve
> linear history.

You most definitely can. I've been doing so daily for more than a
year:

  $ git svn fetch -q
  $ stg rebase -m svn/branch

I _think_ what git svn rebase does is look at the git-svn commit
metadata to determine how many commits to rebase. But stg already has
this information, so we don't need it. (I haven't actually looked into
exactly what git svn rebase does, so it might turn out it's doing
something else too, but I can't think of anything that would be
necessary. As I said, I've been using this workflow for a long time,
and it works.)

The _advantage_ of having fetch be the only external command (besides
reducing complexity) is that we can make it all one single StGit
transaction (since the fetch runs to completion before the transaction
starts). This means that we don't have to touch files unnecessarily,
which means less recompilation.

> > > But "pull" always suggests fetching something. Adding "--rebase"
> > > would mean that it doesn't fetch. Shouldn't we leave this
> > > functionality to "rebase" only?
> >
> > These two things are orthogonal:
> >
> >  1. Whether and how to update the branch we're pulling from
> >     (fetching).
> >
> >  2. How to do the actual pulling (rebase, fast-forward, or merge).
>
> I think it's more of an language interpretation issue (I'm not a
> native English speaker). I see the "pull" action as pulling (can't
> find meaningful synonyms) remote changes into the current branch
> (i.e. fetch + merge). I think you see it as pulling the current
> stack onto a new base (i.e. rebase).

Well, the reason I proposed to keep "stg pull" rather than "stg
rebase" is that I agree with you that "pull" means "fetch _and_
integrate". (Let's try a new term; "integrate" means either "merge",
"fast-forward", or "rebase" (none of which implies any fetching, of
course).) This is how I imagine it working:

  stg pull

    Do a default fetch (that is, fetch according to the branch
    config), followed by a default integrate.

  stg pull --no-fetch

    Just a default integrate, no fetch.

  stg pull --fetch-only

    Just a default fetch, no integrate.

  stg pull --fast-forward

    Default fetch, followed by a "fast-forward" integrate.

  stg pull --rebase

    Default fetch, followed by a "rebase" integrate.

  stg pull --merge

    Default fetch, followed by a "merge" integrate.

Any of --no-fetch/--fetch-only can be combined with any of
--fast-forward/--rebase/--merge.

If stg pull is given a committish argument, this automatically means
--no-fetch, and causes it to integrate with that committish rather
than the branch specified in the config. We might want to allow other
kinds of arguments as well, I don't know.

And of course,

  stg rebase [committish]

    The same as "stg pull --no-fetch --rebase [committish]"; that is,
    no fetch, just rebase.

> > > These are OK, with the comment on have rebase functionality in
> > > "rebase" only.
> >
> > Why? I don't see the difference between rebase and the other two
> > that would motivate such a separation.
>
> See my interpretation of the word "pull". I can change my mind, no
> problem, but it would be interesting to see what a native English
> speaker says (though you are probably closer to English than me
> :-)).

Mph, I don't know about me being "closer". I thought you were the one
living in the UK? ;-)

Regardless, I don't think we're actually in disagreement -- as I
understand it, we both think that pull =3D fetch + integrate. And
"rebase" is one possible value of "integrate". (Holler if you disagree
with either of the views I've attributed to you.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
