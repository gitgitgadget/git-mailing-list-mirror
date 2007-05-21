From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 1/2] Update the bash prompt from 'applied' instead of the obsolete 'current'
Date: Mon, 21 May 2007 17:39:52 +0200
Message-ID: <20070521153952.GB6474@diana.vm.bytemark.co.uk>
References: <20070520204627.GR19253@nan92-1-81-57-214-146.fbx.proxad.net> <20070520211103.17468.21373.stgit@lathund.dewire.com> <20070521074838.GA32510@diana.vm.bytemark.co.uk> <b0943d9e0705210231j75ef2e57o922f7899f4b5814b@mail.gmail.com> <20070521101540.GB32510@diana.vm.bytemark.co.uk> <20070521113915.GA3090@diana.vm.bytemark.co.uk> <b0943d9e0705210817n35e50a6bgb519b693984b3a4b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, ydirson@altern.org,
	git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 21 17:43:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqA2V-0007wV-KT
	for gcvg-git@gmane.org; Mon, 21 May 2007 17:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755557AbXEUPnK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 21 May 2007 11:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755684AbXEUPnJ
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 11:43:09 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4285 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755673AbXEUPnI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 11:43:08 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Hq9zE-0001ti-00; Mon, 21 May 2007 16:39:52 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0705210817n35e50a6bgb519b693984b3a4b@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48024>

On 2007-05-21 16:17:22 +0100, Catalin Marinas wrote:

> On 21/05/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > On 2007-05-21 12:15:40 +0200, Karl Hasselstr=F6m wrote:
> >
> > > We might consider having plumbing written in C or something, and
> > > make sure that the plumbing can be called directly if there's
> > > need, but it's going to complicate things greatly compared to
> > > pure Python.
>
> Yes, it will complicate things. I think StGIT would have progressed a=
t
> a much slower pace if written in C :-).

I agree. C is not a good language to write a whole application in. But
for the hot spots, C is a reasonable choice.

> > What I'm (foggily) envisioning here is to rewrite parts of StGIT
> > (as little as possible) as a C library (libstgit.so?), and call
> > the library both from the Python code, and from a "plumbing" C
> > program (stgit-helper?). We should not try to make the library API
> > stable, just like the current git library.
>
> Apart from the start-up time, I don't see other major slowdowns
> caused by Python.

I haven't, either.

> It would be useful to use a git library directly without invoking
> external applications (I'm not sure what's the state of a "libgit.a"
> or what improvement we would get).

There is no usable git library yet. But once there is, I agree we
should use it.

> As for the start-up time, unless you write most of the commands in C,
> we would still have to load Python modules. If you run stg-prof
> instead of stg for a simple command like 'top', you can see that the
> main function takes about 60-70ms, the rest to 150ms reported by the
> external 'time' is Python start-up and module loading.

My suggestion was to have a small stand-alone C program that could do
some operations that need to be really fast, such as
top/applied/unapplied. It need not have a nice user interface since
it's only going to be called by scripts (bash-completion and the
like), and it should only handle those operations that _must- avoid
the Python startup penalty. And for sanity reasons, it should share
code with stgit.

> I had a quick try at using "freeze.py" to generate a binary (well,
> it includes python bytecodes but it might save time on module
> look-up) but it got confused by my optimisation to only load module
> commands based on the stg arguments. Maybe we should try this first.

I agree that we should try pure-Python optimizations first.

> > There are two kinds of things we'd want to have in the library:
> > (1) things that are too slow to do in Python, and (2) things that
> > need to be available from stgit-helper in order to avoid Python's
> > startup cost, such as top/applied/unapplied for the bash
> > completion and bash prompt.
>
> As you probably guessed, I'm not really in favour of re-writing
> parts of StGIT in C, at least not in the near future, though anyone
> can fork and re-implement it :-).

I wouldn't do it just for fun, either. But if it's a prerequisite to
get good enough performance for something we really want, and all else
has failed, I'd be willing to argue for the introduction of a C
library and helper application.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
