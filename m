From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH 0/3] Be more careful when prunning
Date: Thu, 06 Oct 2011 22:58:24 +0200
Message-ID: <1317934704.4619.1.camel@centaur.lab.cmartin.tk>
References: <1317932385-28604-1-git-send-email-cmn@elego.de>
	 <20111006205103.GA1271@erythro.kitwarein.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-xaRtZF1ei8iOdB4YZ0jd"
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: mathstuf@gmail.com
X-From: git-owner@vger.kernel.org Thu Oct 06 22:58:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBv1b-0001JW-8y
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 22:58:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759287Ab1JFU6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 16:58:31 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:50602 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759129Ab1JFU6a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 16:58:30 -0400
Received: from [192.168.1.17] (brln-4db9e4ec.pool.mediaWays.net [77.185.228.236])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 9A09A46100;
	Thu,  6 Oct 2011 22:58:04 +0200 (CEST)
In-Reply-To: <20111006205103.GA1271@erythro.kitwarein.com>
X-Mailer: Evolution 3.0.3-2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183033>


--=-xaRtZF1ei8iOdB4YZ0jd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2011-10-06 at 16:51 -0400, Ben Boeckel wrote:
> On Thu, Oct 06, 2011 at 22:19:42 +0200, Carlos Mart=C3=ADn Nieto wrote:
> > The first patch is not that big a deal, but it's better if we're
> > freeing the refspecs, we might as well free all of them.
> >=20
> > The second patch teaches get_stale_heads to use the user-provided
> > refspecs instead of the ones in the config. For example, running
> >=20
> >     git fetch --prune origin refs/heads/master:refs/heads/master
> >=20
> > doesn't remove the other branches anymore. For a more interesting (and
> > believable) example, let's take
> >=20
> >     git fetch --prune origin refs/heads/b/*:refs/heads/b/*
> >=20
> > because you want to prune the refs inside the b/ namespace
> > only. Currently git will delete all the refs that aren't under that
> > namespace. With the second patch applied, git won't remove any refs
> > outside the b/ namespace.
> >=20
> > What is probably the most usual case is covered by the third patch,
> > which pretends that a "refs/tags/*:refs/tags/*" refspec was given on
> > the command-line.
>=20
> I applied the patches to current master (7f41b6b) and got a segfault
> with:
>=20
>     git fetch -p -t origin master
>=20
> It does not happen with master.

I thought I'd got rid of those problems. Thanks for noticing. I'll
investigate.

>=20
> Backtrace:
>=20
> (gdb) bt
> #0  0x00007ffff7395d18 in __strchr_sse42 () from /lib64/libc.so.6
> #1  0x00000000004b2d39 in find_in_refs (query=3D0x7fffffffdb90, ref_count=
=3D2, refs=3D<optimized out>) at remote.c:1709
> #2  get_stale_heads_cb (refname=3D0x7a8f31 "refs/heads/a/branch/name", sh=
a1=3D0x7a8f09 "\367\343\375C=D9=A9\223u\305OG\233)z\347X\370\333\325", <inc=
omplete sequence \335>, flags=3D0, cb_data=3D0x7fffffffdc50) at remote.c:17=
40
> #3  0x00000000004adf19 in do_for_each_ref (submodule=3D<optimized out>, b=
ase=3D0x4ea1c2 "", fn=3D0x4b2ca0 <get_stale_heads_cb>, trim=3D0, flags=3D0,=
 cb_data=3D0x7fffffffdc50) at refs.c:684
> #4  0x00000000004b4249 in get_stale_heads (remote=3D<optimized out>, fetc=
h_map=3D<optimized out>, refs=3D<optimized out>, ref_count=3D<optimized out=
>) at remote.c:1777
> #5  0x0000000000426cfb in prune_refs (ref_map=3D<optimized out>, n=3D<opt=
imized out>, refs=3D<optimized out>, transport=3D0x78e040) at builtin/fetch=
.c:511
> #6  do_fetch (ref_count=3D<optimized out>, refs=3D<optimized out>, transp=
ort=3D0x78e040) at builtin/fetch.c:711
> #7  fetch_one (remote=3D<optimized out>, argc=3D<optimized out>, argv=3D<=
optimized out>) at builtin/fetch.c:894
> #8  0x0000000000427550 in cmd_fetch (argc=3D2, argv=3D0x7fffffffe070, pre=
fix=3D0x0) at builtin/fetch.c:955
> #9  0x0000000000405084 in run_builtin (argv=3D0x7fffffffe070, argc=3D5, p=
=3D0x731b08) at git.c:308
> #10 handle_internal_command (argc=3D5, argv=3D0x7fffffffe070) at git.c:46=
6
> #11 0x000000000040448b in run_argv (argv=3D0x7fffffffdf10, argcp=3D0x7fff=
ffffdf1c) at git.c:512
> #12 main (argc=3D5, argv=3D0x7fffffffe070) at git.c:585
>=20
> --Ben
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20



--=-xaRtZF1ei8iOdB4YZ0jd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJOjhZwAAoJEHKRP1jG7ZzTjxAH/iB1h1MDtZBGG3ssDSKTeDMM
ciy/sN28+ahdmiaIdXeGn0L/6heb/ErMFQiXaNhV2FioaKKVMa5orZv+ocI9jQ3y
mW2zge9ALls4Fb+8Q10Vs0ZqH2YyuLyDHebvv4QvsrN4xBjg2JuFC6azaKfQZwCn
/IIX6T4dWX4YL0aZ55Z4YEJ3uSpKzMta1Mqc3izL0YhF9T+FvkEwDI2dlCiUlomW
cq+HihLFfHyy9PPjXWiloTjsZgOK6sbhCIHEHtD9HbYk+PVGcA7vihrhiyQyn6FQ
Loh1z0sWQKMGPGzHkwfANgG2pM+2eNXfo6V3tm1fi2VkReBfAJVPB4zZxYRuRFc=
=Sroh
-----END PGP SIGNATURE-----

--=-xaRtZF1ei8iOdB4YZ0jd--
