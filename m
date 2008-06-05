From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH 1/5] Allow stack.patchorder.all to return hidden patches
Date: Thu, 5 Jun 2008 08:41:52 +0200
Message-ID: <20080605064152.GA23209@diana.vm.bytemark.co.uk>
References: <20080604210655.32531.82580.stgit@localhost.localdomain> <20080604211316.32531.84226.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 08:42:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K49BV-0006jh-Tc
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 08:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752355AbYFEGmA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jun 2008 02:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752339AbYFEGmA
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 02:42:00 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2506 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830AbYFEGl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 02:41:59 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K49AW-00064N-00; Thu, 05 Jun 2008 07:41:52 +0100
Content-Disposition: inline
In-Reply-To: <20080604211316.32531.84226.stgit@localhost.localdomain>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83864>

On 2008-06-04 22:13:17 +0100, Catalin Marinas wrote:

> A new property, patchorder.all_visible, was added to return only the
> applied + unapplied patches. This is used in the "commit" command to
> avoid automatically committing the hidden patches.
>
> Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>

Acked-by: Karl Hasselstr=F6m <kha@treskal.com>

Provided you improve the error message (see below).

> diff --git a/stgit/commands/commit.py b/stgit/commands/commit.py
> index cc2f13a..1bdbeea 100644
> --- a/stgit/commands/commit.py
> +++ b/stgit/commands/commit.py
> @@ -45,11 +45,11 @@ options =3D [make_option('-n', '--number', type =3D=
 'int',
>  def func(parser, options, args):
>      """Commit a number of patches."""
>      stack =3D directory.repository.current_stack
> -    args =3D common.parse_patches(args, list(stack.patchorder.all))
> +    args =3D common.parse_patches(args, list(stack.patchorder.all_vi=
sible))
>      if len([x for x in [args, options.number !=3D None, options.all]=
 if x]) > 1:
>          parser.error('too many options')
>      if args:
> -        patches =3D [pn for pn in stack.patchorder.all if pn in args=
]
> +        patches =3D [pn for pn in stack.patchorder.all_visible if pn=
 in args]
>          bad =3D set(args) - set(patches)
>          if bad:
>              raise common.CmdException('Bad patch names: %s'

=46orbidding commit to operate on hidden patches? OK, why not? But
saying "Bad patch name" if the user gives a hidden patch is probably a
bit on the grumpy side ... :-)

> diff --git a/stgit/lib/stack.py b/stgit/lib/stack.py
> index f9e750e..bdd21b1 100644
> --- a/stgit/lib/stack.py
> +++ b/stgit/lib/stack.py
> @@ -102,8 +102,8 @@ class PatchOrder(object):
>                           lambda self, val: self.__set_list('unapplie=
d', val))
>      hidden =3D property(lambda self: self.__get_list('hidden'),
>                        lambda self, val: self.__set_list('hidden', va=
l))
> -    # don't return the hidden patches, these have to be returned exp=
licitly
> -    all =3D property(lambda self: self.applied + self.unapplied)
> +    all =3D property(lambda self: self.applied + self.unapplied + se=
lf.hidden)
> +    all_visible =3D property(lambda self: self.applied + self.unappl=
ied)
> =20
>  class Patches(object):
>      """Creates L{Patch} objects. Makes sure there is only one such o=
bject

Nice compromise to the debate on whether "all" should include hidden
patches.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
