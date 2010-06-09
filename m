From: Johan Herland <johan@herland.net>
Subject: Re: RFC: Making submodules "track" branches
Date: Wed, 09 Jun 2010 10:22:18 +0200
Message-ID: <201006091022.18896.johan@herland.net>
References: <AANLkTilBQPHgkCLJ7ppNo5TwC9Bdmqo-OMRpaDFwbQPd@mail.gmail.com>
 <201006082352.38136.johan@herland.net> <4C0F4185.2000207@web.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 09 10:26:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMGcH-0004z0-MK
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 10:26:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756714Ab0FII0Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jun 2010 04:26:24 -0400
Received: from smtp.getmail.no ([84.208.15.66]:48032 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755576Ab0FII0W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jun 2010 04:26:22 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L3Q001M1N9FM160@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Wed, 09 Jun 2010 10:22:27 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 5DBA51EA54BE_C0F4F41B	for <git@vger.kernel.org>; Wed,
 09 Jun 2010 08:22:25 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 52D641EA3342_C0F4F3BF	for <git@vger.kernel.org>; Wed,
 09 Jun 2010 08:22:19 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L3Q001NFN97BA30@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 09 Jun 2010 10:22:19 +0200 (MEST)
User-Agent: KMail/1.13.3 (Linux/2.6.33-ARCH; KDE/4.4.4; x86_64; ; )
In-reply-to: <4C0F4185.2000207@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148753>

On Wednesday 09 June 2010, Jens Lehmann wrote:
> Am 08.06.2010 23:52, schrieb Johan Herland:
> > The good thing with =C3=86var's approach is that this is all config=
urable
> > per branch (indeed, per commit[1]) by editing your .gitmodules file=
=2E
>=20
> Yep, I think this is the sane way to do that.
>=20
> > Interesting. Will the object parsing machinery handle that without
> > hiccups? What if an older Git version tries to checkout/update a
> > submodule with a 0- hash?
>=20
> Maybe =C3=86var's idea of dropping such a submodule from the tree is =
better.

Agreed. That will of course cause older Git versions to skip the submod=
ule=20
altogether, which is probably the safest failure mode.

> > Me too, but I suspect that if you draw the "one big repo" approach =
to
> > its logical conclusion, there will be some demand for recursive
> > commits.
>=20
> You may be right here. But as submodules often have a detached HEAD, =
this
> might get interesting ;-)

Yes, trying to recursively commit across a submodule with detached HEAD=
=20
should obviously fail (at least by default). But as long as a local bra=
nch=20
is checked out in the submodule (which is not necessarily the same as h=
aving=20
the submodule _track_ that branch), a recursive commit should be relati=
vely=20
straightforward.

> > [1]: Say your submodule usually tracks a branch, but you're creatin=
g
> > some tag in the super-repo, and you want that tag to uniquely ident=
ify
> > the submodule. You achieve this by making sure the tagged commit
> > removes the relevant "branch =3D whatever" line from .gitmodules, a=
nd
> > records the appropriate submodule version in the super-repo tree.
> > Then, you can revert the .gitmodules change on the next commit to
> > resume tracking the submodule branch.
> >=20
> > Now, whenever you checkout the tag, you will always get the exact s=
ame
> > version of the submodule, although the submodule otherwise tracks s=
ome
> > branch.
>=20
> Won't work anymore when we would use 0{40} or drop it from the tree.
> AFAICS always-tip and referencing a certain commit don't mix well.

AFAICS, it would still work as long as it exists in the tree for that=20
specific commit (but is missing/0{40} in other commits).

We're not mixing "always-tip" and "exact-commit" in the same commit. We=
 use=20
"always-tip" in regular commits, and then temporarily switch to "exact-
commit" in the commits where a certain submodule version is required.


=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
