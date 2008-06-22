From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH 3/4] Convert git_id() to the new id format
Date: Sun, 22 Jun 2008 17:48:54 +0200
Message-ID: <20080622154854.GC4468@diana.vm.bytemark.co.uk>
References: <20080619214023.27794.97039.stgit@localhost.localdomain> <20080619214222.27794.74083.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 22 17:50:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KARpN-00033d-2F
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 17:50:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710AbYFVPtE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Jun 2008 11:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752657AbYFVPtD
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 11:49:03 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2282 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752328AbYFVPtB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 11:49:01 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KARoE-0001KC-00; Sun, 22 Jun 2008 16:48:54 +0100
Content-Disposition: inline
In-Reply-To: <20080619214222.27794.74083.stgit@localhost.localdomain>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85785>

On 2008-06-19 22:42:22 +0100, Catalin Marinas wrote:

> The patch rewrites git_id() to use the new id format and coverts the
> commands using this function. The git_id() will be removed once all
> the commands are converted to the new infrastructure where
> git_commit() will be used instead.

Looks good. And the code volume reduction is significant.

>      if not rev:
> +        # backwards compatibility
>          return None

Could you expand this comment a bit? It's not enough of a clue for me.
:-/

> -def git_commit(name, repository, branch =3D None):
> +def git_commit(name, repository, branch_name =3D None):

Very nice parameter rename here, now that we have Branch objects (and
use a crappy language with no type system).

> -rev =3D '([patch][//[bottom | top]]) | <tree-ish> | base'
> -
> -If neither bottom nor top are given but a '//' is present, the comma=
nd
> -shows the specified patch (defaulting to the current one)."""
> +rev =3D '([branch:]patch) | <tree-ish> | base'

You can remove the parentheses now; they were only needed because they
used to enclose a complicated expression. Besides, shouldn't it be
[branch:]{base} instead of base? So something like

  rev =3D [<branch>:]<patch> | [<branch>:]{base} | <tree-ish>

>  help =3D 'show the files modified by a patch (or the current patch)'
> -usage =3D """%prog [options] [<patch>]
> +usage =3D """%prog [options] [[<branch>:]<patch>]

Unrelated to this patch: I realized last week that it's silly for stg
files to not accept a patch range.

>      if len(args) =3D=3D 0:
> -        patch =3D ''
> +        patch =3D 'HEAD'

Ah, so this is the backwards compatibility thing -- we used to pass
the empty string when we meant HEAD.

> -        (refpatchname, refbranchname, refpatchid) =3D parse_rev(patc=
hname)
> -        if refpatchname and not refpatchid and \
> -               (not refpatchid or refpatchid =3D=3D 'top'):
> -            # FIXME: should also support picking //top.old
> +        refbranchname, refpatchname =3D parse_rev(patchname)
> +        if refpatchname:

The corresponding TODO comment now would be that pick should be able
to pick patches from the past, from the stack log.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
