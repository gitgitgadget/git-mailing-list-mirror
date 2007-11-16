From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit RFC] A more structured way of calling git
Date: Fri, 16 Nov 2007 08:42:55 +0100
Message-ID: <20071116074255.GA16975@diana.vm.bytemark.co.uk>
References: <20071026192418.GA19774@diana.vm.bytemark.co.uk> <b0943d9e0711151028y22b37e04y87a6bc74dc4c5031@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	Git Mailing List <git@vger.kernel.org>,
	Yann Dirson <ydirson@altern.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 08:43:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsvrY-00063i-5i
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 08:43:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027AbXKPHnY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Nov 2007 02:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752021AbXKPHnY
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 02:43:24 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1753 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002AbXKPHnX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 02:43:23 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Isvqp-0004WH-00; Fri, 16 Nov 2007 07:42:55 +0000
Content-Disposition: inline
In-Reply-To: <b0943d9e0711151028y22b37e04y87a6bc74dc4c5031@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65200>

On 2007-11-15 18:28:16 +0000, Catalin Marinas wrote:

> I eventually managed to have a (not so in-depth) look at this

Thanks!

> and I am OK with it (but merging after 0.14).

Yes, that seems like a good idea.

> As you said the current structure and the new one will work in
> parallel for some time.

Yes. This is a very nice property that makes the whole enterprise
feasible.

> It would even be possible to implement unit testing.

Yes. Unit testing would be easier with the new code, since it's more
modular.

> Commitdata maybe should be written as CommitData (as in the e-mail
> text).

Probably. I've alredy made that spelling error myself at least once
when writing code.

> The Repository.head property is not cached and it is probably OK to
> avoid some problems I had. We could run profiling afterwards to see
> how often it is called.

Yes. This applies to a few other things as well -- I try to be careful
to write things so that they could be cached transparently if it turns
out we need it. But I also try to not optimize prematurely.

In some cases the caching is more than just a speed optimization.
Commits and trees can be compared with regular Python object identity,
for example, because I never create duplicates.

> > I started to implement a few StGit commands on top of gitlib.py
> > and stacklib.py, and then realized something very appealing:
> >
> >   Just about every StGit command can be accomplished by first
> >   creating a bunch of new commit objects with gitlib.py, then
> >   trying to check out the new HEAD, and then rewriting refs with
> >   stacklib.py. Only the first and second steps can possibly fail,
> >   and if they do, they do so without leaving any user-visible junk
> >   behind. This can be used to make all commands either succeed
> >   completely, or do nothing at all.
>
> As you said, that's a bit difficult for 'push' as it is made of a
> series of separate individual patch pushes. Can we not use a
> temporary index by setting GIT_INDEX_FILE during the whole
> transaction and freely update the working copy. Only if the
> transaction fails, we clean the working copy and check out the
> default index? This might slow down some operations though.

The sample code I posted does exactly this index trick. So yes, I
think it's a splendid idea. :-)

Basically, what it does (or eventually should do) is repeatedly use
the temp index to create the new commits without ever touching the
default index or the worktree. Only if a merge conflicts would we
check out one of the parents and spill the conflicts to the worktree.
(And once we're finished pushing we'd want to check out the new stack
top, obviously.)

The only problem is that while git-read-tree can do a three-way merge
in a temp index without touching the worktree, git-merge-recursive
assumes that the worktree reflects one of the trees to be merged and
can be written to. Which is _totally OK_ if there really is going to
be a conflict. But merge-recursive does fancier conflict resolution
than read-tree (I think -- I still have to look up exactly what, but I
don't think read-tree does rename detection for example), so it might
succeed even if read-tree failed.

> In the future, it would be nice to record the stack state before
> transactions in a git object (via pickle) together with HEAD id and
> provide unlimited undo.

Yes, this was exactly what I was refering to when I talked about
transaction logging. The only difference is that I'd prefer a simple
text format instead of a pickle, but we can have a fight about that
detail later. :-)

The complete state that would have to be saved would be

  * (patchname, commit sha1) pairs for all patches

  * (branchname, branch head sha1) pair

  * the ordered lists of applied, unapplied, and eventually also
    hidden patches

This is somewhat redundant (applied/unapplied could be inferred from
the commit DAG, etc.) but it would allow us to represent relevant
illegal states as well, which is needed in order to be able to undo
repairs of inconsistent stacks.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
