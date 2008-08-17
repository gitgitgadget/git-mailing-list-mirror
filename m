From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git submodules
Date: Sun, 17 Aug 2008 22:13:36 +0200
Message-ID: <20080817201336.GA17148@artemis>
References: <20080728162003.GA4584@artemis.madism.org> <320075ff0807281323l51bb6478j30e3e4c490974a70@mail.gmail.com> <20080728205545.GB10409@artemis.madism.org> <20080728205923.GC10409@artemis.madism.org> <32541b130807281440v64f3cb9ci50cf6d16be4f2f82@mail.gmail.com> <20080728220308.GF10409@artemis.madism.org> <m3r69dtzm9.fsf@localhost.localdomain> <7vfxptpr76.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="C7zPtVaVf+AK4Oqc";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Jakub Narebski <jnareb@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Nigel Magnay <nigel.magnay@gmail.com>,
	Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 17 22:15:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUoer-0001yh-90
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 22:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbYHQUNk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 16:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbYHQUNk
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 16:13:40 -0400
Received: from pan.madism.org ([88.191.52.104]:34309 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750886AbYHQUNj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 16:13:39 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id C1C643F69F;
	Sun, 17 Aug 2008 22:13:37 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 7D8F67908; Sun, 17 Aug 2008 22:13:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vfxptpr76.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92625>


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2008 at 10:41:17PM +0000, Junio C Hamano wrote:
> I suspect the use of it may help the use case Pierre proposes, but its
> main attractiveness as I understood it back when we discussed the facility
> was that you could switch branches between 'maint' that did not have a
> submodule at "path" back then, and 'master' that does have one now,
> without losing the submodule repository.  When checking out 'master' (and
> that would probably mean you would update 'git-submodule init' and
> 'git-submodule update' implementation), you would instanciate subdirectory
> "path", create "path/.git" that is such a regular file that that points at
> somewhere inside the $GIT_DIR of superproject (say ".git/submodules/foo").
> By storing refs and object store are all safely away in the superproject
> $GIT_DIR, you can now safely switch back to 'maint', which would involve
> making sure there is no local change that will be lost and then removing
> the "path" and everything underneath it.

gitfiles looks nifty for sure, though I've thought about it a bit, and
I'm not sure if we don't want something a bit more powerful, though
still in the same vein.

If we look at submodules, I quite believe that we would benefit a lot
=66rom sharing the object directory accross the supermodule and all its
submodules, because of the following reasons:

  * It could make things like git-blame better: at work, it's common for
    us to move files across submodules: we have a stable library shared
    accross projects, and move there C modules that have staged for
    quite some time in the applications and are stable enough, and it's
    pity to loose history then, whereas git could really guess about the
    move if it sees through GITLINKS in the same object repository.
    GITLINKS are not very different from trees actually if you can look
    through them, it's just a matter of dereferencing twice instead of
    once.

  * For people that have made a subdirectory become a submodule (and
    it's also something that can happen) it's likely that lots of blobs
    are shared. It would end up taking less disk space.

  * It helps people fixing situations where they pushed a supermodule
    with a substate that never existed without seeing it. Since the
    object store is shared, this commit that actually never existed will
    never ever be pruned, and at _least_ one person on earth will never
    lose it. With detached heads everywhere it's very easy to not name a
    detached head, and have it pruned at some point.

  * I _believe_ (just a hunch) that it helps knowing if it's possible to
    perform a "recursive" (wrt submodules) checkout/reset/$whatever,
    without having to spawn subcommands and quite unpleasant similar
    stuff.


Though we would not like to have submodules suffer from reachability
issues after a prune in the supermodule. That means that all references
and reflogs of the submodules shall be accessible from the supermodule
so that everything that could mess with the object store by removing
objects cannot remove interesting objects (that should limit the code
paths to really seldom places actually).


So what I've thinked about was to extend gitfiles so that it can also
define where to find not only the git_dir but also the object store.
Moving the current "faked symlink" approach to a less terse file looking
like a standard git-config one. E.g.:

    [gitfile]
	git_dir =3D some/path/.git/submodules/foo/
        objects =3D some/path/.git/objects
        # why not other settings in the future ?

This part is quite easy and straightforward (and it can be done while
keeping backward compatibility with the current way gitfiles work).
What I can't decide is how we deal with the reflogs and references. I
see two choices. Assuming the submodules git_dir's are under the
supermodule $GIT_DIR/submodules/$name_of_the_super_module/:

  (1) we do nothing more.

  (2) we melt the submodules reflogs and references into the supermodule
      ones with appropriate namespacing. For example, for a submodule
      named "foo/bar" we would have its reflogs live in the supermodule
      .git/logs/submodules/foo/bar/logs/* and its references under
      .git/refs/submodules/foo/bar/refs/*. For that we add 'logs =3D' and
      'refs =3D' to the gitfile.

The first approach need us to be able to somehow recurse under
=2Egit/submodules to understand what inside that looks like a git_dir, and
teach reachability commands to look at the refs inside them. It can be
quite a lot of work, especially since we can have submodules inside
submodules at some point.

The second approach has the net benefit that no pruning command has to
be modified to work. Many commands that we want to act on the global
repository will just work. Though, we have to fix a couple of issues
too:
  (1) be able to have a references directory that is not .git/refs. I
      looked at the source, I believe only 3 or 4 places in the C code
      have to be fixed for that to work, maybe a bit more in the shell
      commands, but that should be fairly easy.

  (2) it will break reference packing, because the submodules won't see
      the supermodule packed-refs file, and we will probably have to
      draft a new packed-refs thingy because of this issue. A simple
      possibility I see is to move packed-refs as refs/.packed-refs (as
      a starting dot cannot be a reference name). Then teach
      git-pack-refs to generate a .packed-refs each time it crosses a
      'refs/' directory name, and finally learn how to load those (and
      no it won't require to recurse into the whole refs/, we can mark
      in the toplevel refs/.packed-refs that it has submodules and that
      there is a .packed-refs under
      refs/submodules/foo/bar/refs/.packed-refs and avoid the costly
      recursion).

  (3) we will have to teach for_each_ref to skip "/submodules",
      which is I believe fairly easy.


I personnaly like the second approach better because it will scale
better (I believe) when people will do submodules into submodules into
submodules. But I'm unsure if it's too disruptive or not.

So .. comments thoughts remarks are welcomed :)



Note: with enhanced gitfiles, and making workdirs use gitfiles, with any
      of those approaches, it's easy to make workdirs that won't have
      the "if we repack we may lose things referenced from other
      workdir's reflogs" problem anymore. Which is kind of a nifty side
      effect ;)
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiohm4ACgkQvGr7W6HudhzQxACglgkKK0t1vux+uMQ3848pa1Jc
wtgAn2FyKD8gImpEot4BUV/tNg+w0p+T
=NkHs
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
