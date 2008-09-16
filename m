From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Convert "sink" to the new infrastructure
Date: Tue, 16 Sep 2008 09:40:24 +0200
Message-ID: <20080916074024.GA2454@diana.vm.bytemark.co.uk>
References: <20080912215613.10270.20599.stgit@localhost.localdomain> <20080914085118.GC30664@diana.vm.bytemark.co.uk> <b0943d9e0809141419q6facb21at627e658805f1d223@mail.gmail.com> <20080915075740.GB14452@diana.vm.bytemark.co.uk> <b0943d9e0809150944o71acafe7ndeda500b1fba97df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 09:21:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfUqX-0007UY-Nk
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 09:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233AbYIPHS3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Sep 2008 03:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752190AbYIPHS3
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 03:18:29 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3445 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068AbYIPHS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 03:18:28 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KfVAe-0000oL-00; Tue, 16 Sep 2008 08:40:24 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0809150944o71acafe7ndeda500b1fba97df@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95983>

On 2008-09-15 17:44:38 +0100, Catalin Marinas wrote:

> Since we are talking about this, the transactions documentation
> doesn't explain when to use a iw and when to pass allow_conflicts. I
> kind of figured out but I'm not convinced. At a first look, passing
> allow_conflicts =3D True would seem that it may allow conflicts and n=
ot
> revert the changes, however, this only works if I pass an "iw". But
> passing it doesn't allow the default case where I want the changes
> reverted.

In my experimental branch, one of the patches adds the following piece
of documentation:

+        @param allow_conflicts: Whether to allow pre-existing conflict=
s
+        @type allow_conflicts: bool or function of L{StackTransaction}=
"""

That is, allow_conflicts decides whether to abort the transaction in
case there already were conflicts -- undo and friends need to allow
existing conflicts, but most other commands just want to abort in that
case.

This should of course have been a separate patch (in kha/safe), but it
seems I was lazy ...

iw is the index+worktree object. The idea is that you provide one if
your branch is checked out, and not if not. Operations that have no
need of index+worktree, like pop, and push in case automatic merging
succeeds, will just work anyway, while operations that need
index+worktree, such as a conflicting push, will cause the whole
transaction to abort.

> Please have a look at the attached patch which is my last version of
> the sink command rewriting. I'm not that happy (or maybe I don't
> understand the reasons) with setting iw =3D None if not
> options.conflict but that's the way I could get it to work.

That's not the right way to do it. iw =3D None will tell the transactio=
n
that you have no index+worktree, so the resulting tree will not be
checked out in the end. Since you don't change the set of applied
patches, and since all the automatic merges succeeded, you'll probably
get the exact same tree 99% of the time and not notice, but I wouldn't
recommend it.

The right way to do it, I guess, would be to add a
stop_before_conflicts flag to run(). As for implementing it, note how
the "if merge_conflict:" conditional in push_patch() delays the
recording of the final conflicting push so that the patch log can get
two entries for this transaction, one that undoes just the conflicting
push and one that undoes it all. It would probably not be hard to
teach that code to skip the conflicting push altogether.

( Oh, and note that what I just said talks about the "patch stack
  log", meaning that I'm talking about the code in kha/experimental.
  The code in kha/safe doesn't look quite the same -- in particular,
  there's no obvious place to place code that ignores the conflicting
  push. Unless you really don't want your sink changes to depend on
  the stack log stuff (e.g. because you doubt you'll be merging it
  anytime soon), I suggest we do this: I'll prepare, and ask you to
  pull, a "stacklog" branch, and once you've pulled it we won't rebase
  it anymore. You can merge it directly to your master or publish it
  as a separate development branch, whichever you feel is best. )

> 2008/9/15 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > What I've always wanted is "sink this patch as far as it will go
> > without conflicting". This comes awfully close.
>
> But this means that sink would try several consecutive sinks until
> it can't find one. Not that it is try to implement but I wouldn't
> complicate "sink" for this.

OK.

> I would rather add support for patch dependency tracking (which used
> to be on the long term wish list). It might be useful for other
> things as well like mailing a patch together with those on which it
> depends (like darcs).

Do you mean automatically detected dependencies, or dependencies that
the user has told us about?

> > BTW, this kind of flag might potentially be useful in many
> > commands (with default value on or off depending on the command).
> > Maybe
> >
> >  --conflicts=3Droll-back|stop-before|allow
>
> ATM, I only added a --conflict option which has the "allow" meaning.

OK.

> +    if options.conflict:
> +        iw =3D stack.repository.default_iw
> +    else:
> +        iw =3D None

As I said above, this doesn't (or at least isn't supposed to) work.

> +    # pop any patches to be sinked in case they are applied
> +    to_push =3D trans.pop_patches(lambda pn: pn in patches)

I see what made you want those utility functions ...

> +    if options.to:
> +        if options.to in to_push:
> +            # this is the case where sinking actually brings some
> +            # patches forward
> +            for p in to_push:
> +                if p =3D=3D options.to:
> +                    del to_push[:to_push.index(p)]
> +                    break
> +                trans.push_patch(p, iw)
> +        else:
> +            # target patch below patches to be sinked
> +            to_pop =3D trans.applied[trans.applied.index(options.to)=
:]
> +            to_push =3D to_pop + to_push
> +            trans.pop_patches(lambda pn: pn in to_pop)
> +    else:
> +        # pop all the remaining patches
> +        to_push =3D trans.applied + to_push
> +        trans.pop_patches(lambda pn: True)
> =20
> +    # push the sinked and other popped patches
>      if not options.nopush:
> -        newapplied =3D crt_series.get_applied()
> -        def not_reapplied_yet(p):
> -            return not p in newapplied
> -        push_patches(crt_series, filter(not_reapplied_yet, oldapplie=
d))
> +        patches.extend(to_push)
> +    try:
> +        for p in patches:
> +            trans.push_patch(p, iw)

Have you seen the reorder_patches() function last in transaction.py?
It seems you could save a lot of work here by using it.

> +    except transaction.TransactionHalted:
> +        if not options.conflict:
> +            raise

Not catching TransactionHalted will have the effect of rolling back
the whole transaction if it stops half-way through. But what you
really wanted was the new flag I described above, I think.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
