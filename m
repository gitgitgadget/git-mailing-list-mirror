From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH 4/5] Add stack creation and initialisation support to lib.Stack
Date: Sat, 7 Jun 2008 10:59:49 +0200
Message-ID: <20080607085949.GA32647@diana.vm.bytemark.co.uk>
References: <20080604210655.32531.82580.stgit@localhost.localdomain> <20080604211343.32531.41429.stgit@localhost.localdomain> <20080605072822.GD23209@diana.vm.bytemark.co.uk> <b0943d9e0806050542w663c64a8o93f81503eb811cf9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 11:02:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4uIs-00007M-7Z
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 11:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753999AbYFGJAL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Jun 2008 05:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753187AbYFGJAK
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 05:00:10 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1601 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520AbYFGJAI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 05:00:08 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K4uH7-0000FJ-00; Sat, 07 Jun 2008 09:59:49 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0806050542w663c64a8o93f81503eb811cf9@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84186>

On 2008-06-05 13:42:03 +0100, Catalin Marinas wrote:

> 2008/6/5 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > On 2008-06-04 22:13:43 +0100, Catalin Marinas wrote:
> >
> > > +from stgit.config import config
> > > +
> > > +class StackException(exception.StgException):
> > > +    """Exception raised by stack objects."""
> >
> > s/stack/L{Stack}/, perhaps?
>
> I was more referring to objects in the lib.stack module, not only
> the Stack class. Can this be expressed in any way with the epydoc
> format?

I think L{lib.stack} would work.

See http://epydoc.sourceforge.net/manual-epytext.html.

> > Wouldn't it be more consistent if the create function actually
> > returned a PatchOrder object, like other creation functions?
>
> It is a bit more complicated. PatchOrder requires a Stack object in
> __init__ but the stack is not fully set up at this point.

I see. How about calling the method "create_files" or something, then,
to avoid breaking with the newly established convention of having the
create() function create new underlying data and returning a Python
object that represents it?

> > (You might even consider having these files auto-created whenever
> > you instantiate a PatchOrder object and they don't yet exist.)
>
> This is definitely a solution but at the moment we have to support
> the old infrastructure which fails if the files aren't present. Once
> we don't have any reference to the stgit.stack module, we can do
> this more dynamically.

Right.

> > Also, the creation function might instead live in the Stack class,
> > since it owns the patch order.
>
> See my reply to a previous patch with my view on ownership and
> separation of functionality.

Yes, I agree with you now.

> > > +    def set_parents(self, remote, localbranch):
> > > +        if not localbranch:
> > > +            return
> > > +        if remote:
> > > +            self.set_parent_remote(remote)
> > > +        self.set_parent_branch(localbranch)
> > > +        config.set('branch.%s.stgit.parentbranch' % self._name, =
localbranch)
> >
> > Hmm, I don't quite follow. Why is this a no-op if you give a false
> > localbranch? And why is branch.<branchname>.stgit.parentbranch
> > needed, when it's always the same as branch.<branchname>.merge?
> > (Backwards compatibility? Would you mind making a comment about
> > that, in that case?)
>
> I don't fully follow it either :-).

Hmmm. :-)

> I just copied the code from stgit.stack.Series but I don't make any
> use of it yet. I think it was initially written by Yann Dirson for
> the "branch" command which I haven't translated yet. I think
> branch.<branchname>.stgit.parentbranch might be used by the current
> "pull" or "rebase" implementations. I'll comment it out (but still
> keep it for now) and put a FIXME so that I remember when converting
> the "branch" and "pull" commands.

In cases like this, when one wants to keep existing behavior unchanged
but doesn't quite understand the original reasons behind it, I like to
simply insert a big comment saying that this piece of code does this
strange thing for reasons unknown to me, but I kept them that way
because I didn't want to change the behavior at the moment.

( As an aside, I've also been thinking about pull/rebase. Let's have a
  discussion about that -- in another thread. )

> > What I'd really like to see here, I think, is something like this:
> >
> >  1. You get a Stack object from some stack.Repository method.
> >
> >  2. The Stack object works without having to be initialized, but
> >     the operations that need initialization throw an exception.
> >
> >  3. The Stack object has an initialize() method -- just a normal
> >     method, not a class method.
>
> That was the original behaviour in stgit.stack.Series but if you
> happen to try to access a patch or patchorder, you get some
> exception on missing file form those objects rather than "stack not
> initialised" from Stack.

This wouldn't be a problem if all methods that needed initialization
begain with a self.make_sure_were_initialized() call, which could
throw a suitable exception. (Though I see how this could get a touch
unwieldy -- it's probably not something you'd want to do unless you
_are_ shooting for auto-initialization.)

> I'm not fully convinced with automatic initialisation. I have some
> branches where I don't use StGIT but I might type a "stg series" by
> mistake. The branch will be promoted to a stack but later Git
> doesn't know about extra files in .git/patches and they aren't
> handled (removed, renamed etc.). I'm more in favour of the explicit
> initialisation.

Automatic initialization should work such that "initialize" is a
no-op. For example, the "applied" and "unapplied" files shouldn't even
exist if there are no patch names in them. That way, StGit metadata
files (and refs) are only created when there's an actual need for them
-- meaning that read-only StGit commands would never create any such
files.

Related to this: Have you looked in any detail at the "undo" stuff in
my experimental branch? The patch stack log that makes undo possible
contains all the metadata that StGit needs, accessible from a single
ref. I currently keep writing all the old metadata files as well, but
my long-term evil plan is to have only the stack log and nothing else.
If not earlier, I'd like to propose a move to auto-init at the same
time.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
