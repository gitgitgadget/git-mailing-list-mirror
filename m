From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 05 Sep 2007 11:14:00 +0200
Message-ID: <20070905091400.GE31750@artemis.corp>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org> <20070905074206.GA31750@artemis.corp> <46DE6DBC.30704@midwinter.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="ryJZkp9/svQ58syV";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 11:14:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISqxf-00033W-0l
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 11:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755478AbXIEJOG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 05:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754909AbXIEJOE
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 05:14:04 -0400
Received: from pan.madism.org ([88.191.52.104]:37626 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754796AbXIEJOC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 05:14:02 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id C02FD1DAF1;
	Wed,  5 Sep 2007 11:14:00 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 6C1559F54; Wed,  5 Sep 2007 11:14:00 +0200 (CEST)
Mail-Followup-To: Steven Grimm <koreth@midwinter.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <46DE6DBC.30704@midwinter.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57699>


--ryJZkp9/svQ58syV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 05, 2007 at 08:50:04AM +0000, Steven Grimm wrote:
> Pierre Habouzit wrote:
> >  Well independently from the fact that one could suppose that users
> >should use gc on their own, the big nasty problem with repacking is that
> >it's really slow. And I just can't imagine git that I use to commit
> >blazingly fast, will then be unavailable for a very long time (repacks
> >on my projects -- that are not as big as the kernel but still -- usually
> >take more than 10 to 20 seconds each).
> > =20
>=20
> What about kicking off a repack in the background at the ends of certain=
=20
> commands? With an option to disable, of course. It could run at a low=20
> priority and could even sleep a lot to avoid saturating the system's=20
> disks -- since it'd be running asynchronously there should be no problem=
=20
> if it takes longer to run.

  there is an issue with that: repack is memory and CPU intensive. Of
course renicing the process deals with the CPU issue, but not with the
memory one. I've often seen repacks eat more than 300 to 400Mo of memory
on not so big repositories: it seems (and experience tells me that, not
looking at the code) that if you have some big binary blobs (we have
=2Eswf's and .fla's in our repository) it can consume quite a lot of RAM
to (presumably) compute efficient deltas.

  Sadly there is no way to "renice" the ram usage of a process. Once a
repack is launched, it will make your system swap, and put the whole
computer on its knees.

> IMO expecting end users to regularly perform what are essentially=20
> database administration tasks (running git-gc is akin to rebuilding=20
> indexes or packing tables on a DBMS) is naive. Heck, even database=20
> administrators don't like to run database administration commands;=20

  Well that's what crons are for. When you install a SGBD in a
reasonable enough distro, it comes with the optimizing scripts in crons,
launched at a reasonable period of the day (localtime). So the
comparison doesn't hold. And that's exactly the problem: it's quite hard
to ship git with an optimizing cron task, because we can't know where
the user will keep his repositories, and when he works, so you have
somehow to do it yourself.

  Or you can deal with that with a "rule". At work, we have our devel
trees under $HOME/dev/, so the cron we use is just a (roughly):

    find $HOME/dev/ -name .git -type d -maxdepth 4 | while read repo
    do
        GIT_DIR=3D"$repo" git gc
    done

  As we work on NFS, with a new developper, we can just setup the cron
for him at a date where he's not supposed to be at work, and that's it.
I'm not sure there is a good solution at all.

  Or we could also provide a: git-coffee-break command that would tell
git: do whatever you want with this computer in the next 10 minutes,
there won't be anyone watching, but I assume tea-lovers will feel
excluded.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--ryJZkp9/svQ58syV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG3nNYvGr7W6HudhwRAtHJAKCOtTuQj8/eO+1kzWkv54LwXW9EgACfZq0D
XZXET3YSP3S9vS0hLz60XOI=
=QYgn
-----END PGP SIGNATURE-----

--ryJZkp9/svQ58syV--
