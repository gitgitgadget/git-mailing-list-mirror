From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH 4/5] Add stack creation and initialisation support to lib.Stack
Date: Thu, 5 Jun 2008 09:28:22 +0200
Message-ID: <20080605072822.GD23209@diana.vm.bytemark.co.uk>
References: <20080604210655.32531.82580.stgit@localhost.localdomain> <20080604211343.32531.41429.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 09:29:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K49uo-0003oD-JD
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 09:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752237AbYFEH2a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jun 2008 03:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752127AbYFEH23
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 03:28:29 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4436 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752060AbYFEH23 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 03:28:29 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K49tW-0006E5-00; Thu, 05 Jun 2008 08:28:22 +0100
Content-Disposition: inline
In-Reply-To: <20080604211343.32531.41429.stgit@localhost.localdomain>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83871>

On 2008-06-04 22:13:43 +0100, Catalin Marinas wrote:

> This patch adds the create and initialise Stack classmethods to
> handle the initialisation of StGIT patch series on a Git branch.

> diff --git a/stgit/lib/stack.py b/stgit/lib/stack.py
> index aca7a36..7375d41 100644
> --- a/stgit/lib/stack.py
> +++ b/stgit/lib/stack.py
> @@ -3,6 +3,10 @@
>  import os.path
>  from stgit import exception, utils
>  from stgit.lib import git, stackupgrade
> +from stgit.config import config
> +
> +class StackException(exception.StgException):
> +    """Exception raised by stack objects."""

s/stack/L{Stack}/, perhaps?

> @@ -105,6 +109,14 @@ class PatchOrder(object):
>      all =3D property(lambda self: self.applied + self.unapplied + se=
lf.hidden)
>      all_visible =3D property(lambda self: self.applied + self.unappl=
ied)
> =20
> +    @staticmethod
> +    def create(stackdir):
> +        """Create the PatchOrder specific files
> +        """
> +        utils.create_empty_file(os.path.join(stackdir, 'applied'))
> +        utils.create_empty_file(os.path.join(stackdir, 'unapplied'))
> +        utils.create_empty_file(os.path.join(stackdir, 'hidden'))
> +
>  class Patches(object):
>      """Creates L{Patch} objects. Makes sure there is only one such o=
bject
>      per patch."""

Wouldn't it be more consistent if the create function actually
returned a PatchOrder object, like other creation functions? (You
might even consider having these files auto-created whenever you
instantiate a PatchOrder object and they don't yet exist.)

Also, the creation function might instead live in the Stack class,
since it owns the patch order.

> @@ -133,12 +145,14 @@ class Patches(object):
>  class Stack(git.Branch):
>      """Represents an StGit stack (that is, a git branch with some ex=
tra
>      metadata)."""
> +    __repo_subdir =3D 'patches'
> +

This needs to be in the previous patch, I think, since you use it
there.

> +    def set_parents(self, remote, localbranch):
> +        if not localbranch:
> +            return
> +        if remote:
> +            self.set_parent_remote(remote)
> +        self.set_parent_branch(localbranch)
> +        config.set('branch.%s.stgit.parentbranch' % self._name, loca=
lbranch)

Hmm, I don't quite follow. Why is this a no-op if you give a false
localbranch? And why is branch.<branchname>.stgit.parentbranch needed,
when it's always the same as branch.<branchname>.merge? (Backwards
compatibility? Would you mind making a comment about that, in that
case?)

> +    @classmethod
> +    def initialise(cls, repository, name =3D None):
> +        """Initialise a Git branch to handle patch series."""
> +        if not name:
> +            name =3D repository.current_branch_name
> +        # make sure that the corresponding Git branch exists
> +        git.Branch(repository, name)
> +
> +        dir =3D os.path.join(repository.directory, cls.__repo_subdir=
, name)
> +        compat_dir =3D os.path.join(dir, 'patches')
> +        if os.path.exists(dir):
> +            raise StackException('%s: branch already initialized' % =
name)
> +
> +        # create the stack directory and files
> +        utils.create_dirs(dir)
> +        utils.create_dirs(compat_dir)
> +        PatchOrder.create(dir)
> +        config.set(stackupgrade.format_version_key(name),
> +                   str(stackupgrade.FORMAT_VERSION))
> +
> +        return repository.get_stack(name)

This is not quite like the other "create" functions, since it just
promotes a branch, without really creating it.

What I'd really like to see here, I think, is something like this:

  1. You get a Stack object from some stack.Repository method.

  2. The Stack object works without having to be initialized, but the
     operations that need initialization throw an exception.

  3. The Stack object has an initialize() method -- just a normal
     method, not a class method.

This will pave the way for automatic initialization -- just call
self.initialize() instead of throwing an exception in step (2).

What do you think?

> +
> +    @classmethod
> +    def create(cls, repository, name,
> +               create_at =3D None, parent_remote =3D None, parent_br=
anch =3D None):
> +        """Create and initialise a Git branch returning the L{Stack}=
 object."""
> +        git.Branch.create(repository, name, create_at =3D create_at)
> +        stack =3D cls.initialise(repository, name)
> +        stack.set_parents(parent_remote, parent_branch)
> +        return stack

Same point as with the other creation functions.

And I'd appreciate some documentation on what the parameters mean --
either here, or in the methods you call from here.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
