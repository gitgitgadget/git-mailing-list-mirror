From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Convert "sink" to the new infrastructure
Date: Tue, 16 Sep 2008 21:36:47 +0200
Message-ID: <20080916193647.GA12513@diana.vm.bytemark.co.uk>
References: <20080912215613.10270.20599.stgit@localhost.localdomain> <20080914085118.GC30664@diana.vm.bytemark.co.uk> <b0943d9e0809141419q6facb21at627e658805f1d223@mail.gmail.com> <20080915075740.GB14452@diana.vm.bytemark.co.uk> <b0943d9e0809150944o71acafe7ndeda500b1fba97df@mail.gmail.com> <20080916074024.GA2454@diana.vm.bytemark.co.uk> <b0943d9e0809160759w5c9be510t3b33d5d983bff5a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 21:15:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfg1d-0006Mw-Km
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 21:15:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609AbYIPTOl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Sep 2008 15:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752317AbYIPTOl
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 15:14:41 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2903 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbYIPTOk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 15:14:40 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KfgLv-0003J1-00; Tue, 16 Sep 2008 20:36:47 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0809160759w5c9be510t3b33d5d983bff5a7@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96029>

On 2008-09-16 15:59:31 +0100, Catalin Marinas wrote:

> 2008/9/16 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > iw is the index+worktree object. The idea is that you provide one
> > if your branch is checked out, and not if not. Operations that
> > have no need of index+worktree, like pop, and push in case
> > automatic merging succeeds, will just work anyway, while
> > operations that need index+worktree, such as a conflicting push,
> > will cause the whole transaction to abort.
>
> Ah, that's the difference. I thought that even if iw isn't passed,
> it uses the default one.

It wouldn't be clean of it to do that -- it would be accessing
non-local state it had no business knowing about. I try hard to avoid
that kind of thing.

> > ( Oh, and note that what I just said talks about the "patch stack
> >   log", meaning that I'm talking about the code in
> >   kha/experimental. The code in kha/safe doesn't look quite the
> >   same -- in particular, there's no obvious place to place code
> >   that ignores the conflicting push. Unless you really don't want
> >   your sink changes to depend on the stack log stuff (e.g. because
> >   you doubt you'll be merging it anytime soon), I suggest we do
> >   this: I'll prepare, and ask you to pull, a "stacklog" branch,
> >   and once you've pulled it we won't rebase it anymore. You can
> >   merge it directly to your master or publish it as a separate
> >   development branch, whichever you feel is best. )
>
> I think we could merge your experimental branch into master. I gave
> it a try and seems OK. The only issue I had was that I had an older
> version of Git and it failed in really weird ways (stg pop still
> busy-looping after 4 minutes and in another case it failed with
> broken pipe). Once I pulled the latest Git, it was fine but we
> should try to be compatible at least with the Git version in the
> Debian testing distribution. It might be the patch at the top with
> diff-ing several trees at once but I haven't checked.

There are two patches that depend on new git versions. One needs git
1.5.6, which is in testing so I'll be pushing that to you; the other
needs Junio's master branch, and i won't even consider asking you to
take it until it's in a released git.

I hope to push it out to you tonight or tomorrow, but I have a small
pet patch I'd like to finish first, so I might be late.

> BTW, I ran some benchmarks on stable/master/kha-experimental
> branches with 300 patches from the 2.6.27-rc5-mm1 kernel. See
> attached for the results. Since performance was my worry with the
> stack log stuff, it turns out that there isn't a big difference with
> real patches. I think pushing can be made even faster by trying a
> git-apply first and taking the diff from the saved blobs in the log.

When benchmarking recent StGits, you'll want to try goto as well,
since push and pop are not yet new-infrastructure-ized (meaning
they're getting slowdowns from the stack log, but no speedups (if any)
from the new infrastructure).

> > On 2008-09-15 17:44:38 +0100, Catalin Marinas wrote:
> >
> > > +    if options.conflict:
> > > +        iw =3D stack.repository.default_iw
> > > +    else:
> > > +        iw =3D None
> >
> > As I said above, this doesn't (or at least isn't supposed to)
> > work.
>
> It should work since the trans.run() command without iw is
> equivalent to trans.run(iw=3DNone).

But passing iw =3D None means telling the transaction that you have no
index+worktree, so it won't touch them. You'll get no detection of
dirty tree, or checkout of result tree in the end. Which is not what
you indended, IIUC.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
