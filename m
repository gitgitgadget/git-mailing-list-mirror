From: Pierre Habouzit <madcoder@debian.org>
Subject: git submodules
Date: Mon, 28 Jul 2008 18:20:03 +0200
Message-ID: <20080728162003.GA4584@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="pf9I7BMVVzbSWLtt";
	protocol="application/pgp-signature"; micalg=SHA1
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 28 18:21:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNVTE-0001gI-F2
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 18:21:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756093AbYG1QUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 12:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755980AbYG1QUL
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 12:20:11 -0400
Received: from pan.madism.org ([88.191.52.104]:46629 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755941AbYG1QUK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 12:20:10 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 9FFDA3BCC6
	for <git@vger.kernel.org>; Mon, 28 Jul 2008 18:20:06 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id A15B18DBF; Mon, 28 Jul 2008 18:20:03 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Git ML <git@vger.kernel.org>
Content-Disposition: inline
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90470>


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


While trying to sum up some things I'd like submodules to do, and things
like that, I came to ask myself why the heck we were doing things the
way we currently do wrt submodules.

This question is related to the `.git` directories of submodules. I
wonder why we didn't chose to use a new reference namespace
(refs/submodules/$path/$remote/$branch).

This would have the net benefit that most of the plumbing tasks would be
easier if they have to deal with submodules, because they aren't in this
uncomfortable situation where they have to recurse into another git
directory to know what to do.

It also has the absolutely nice property to share objects, so that
projects that replaced a subdirectory with a submodule don't see their
checkouts grow too large.

We probably still want submodules to act like plain independant git
repositories, but one can still *fake* that this way: submodules have
only a .git/config file (also probably an index and a couple of things
like that, but that's almost a different issue for what I'm considering
now) that has the setting:

    [core]
        submodule =3D true

This could make all the builtins look for the real $GIT_DIR up, which in
turn gives the submodule "name". Then, for this submodule, every
reference, remote name, ... would be virtualized using the
"remote/$submodule_name" prefix. IOW, in a submodule "some/sub/module"
the branch "origin/my/topic/branch" is under:
  refs/submodules/some/sub/module/origin/my/topic/branch
  <-- submod. --><-- submod.  --><-- --><--  branch  -->
     namespace 	     path/name   remote
Note that this doesn't mean that we must rip out .gitmodules, because
it's needed to help splitting the previous reference name properly, and
for bootstrapping purposes.


Having that, one can probably extend most of the porcelains in _very_
straightforward ways. For example, a local topic branch `topic` would be
the union of the supermodule `topic` branch, and all the
`refs/submodules/$names/topic` ones.

Most importantly, it would help implementing that tries to make your
submodules stay _on branch_. One irritating problem with submodules, is
that when someone else commited, and that you git submodule update,
you're on a detached head. Absolutely horrible. If you see your current
branch (assume it's master), then when you do that, you would update
your `refs/submodules/$name/master` references instead and keep the
submodule HEADs `on branch`. Of course we can _probably_ hack something
together along those lines with the current setup, but it would be _so_
much more convenient this way...

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiN8bMACgkQvGr7W6HudhyBewCcC+rR0uaSmEimcciFgy2fhTYR
4oIAn2aRhBCaM+6G72BX9CC5UKjRxr9L
=1uu/
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
