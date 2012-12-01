From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [RFC] remove/deprecate 'submodule init' and 'sync'
Date: Sat, 01 Dec 2012 11:30:04 -0500
Message-ID: <20121201163004.GB4823@odin.tremily.us>
References: <50BA257F.9070607@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Cc: Phil Hord <phil.hord@gmail.com>, Git <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Nahor <nahor.j+gmane@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Dec 01 17:30:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tepxg-0002ge-RS
	for gcvg-git-2@plane.gmane.org; Sat, 01 Dec 2012 17:30:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752543Ab2LAQaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2012 11:30:25 -0500
Received: from vms173009pub.verizon.net ([206.46.173.9]:61883 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752467Ab2LAQaZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2012 11:30:25 -0500
Received: from odin.tremily.us ([unknown] [72.68.99.23])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MED00DSE1U40J70@vms173009.mailsrvcs.net> for
 git@vger.kernel.org; Sat, 01 Dec 2012 10:30:06 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 781C46E3C48; Sat,
 01 Dec 2012 11:30:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1354379404; bh=Apqrl5v9BBJW4Fs2n//1Ca+wY8hFfwRmbHIv7j98/rc=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Jq32tzAF//hIZP8So35UAr4MKulwv67qRK/uq+uZYK7I23ns7lSyY8KD38EL6ITKL
 x3nIlPtSMzMgxF0DLq4OypFwTosro+1XtEDYOlT20QpOlFi+H5b6JmsY01CxQhW2ls
 jwCS1ms4mU3zaNW2fcjDyx78gkrnbV8yzEn6SLbk=
Content-disposition: inline
In-reply-to: <50BA257F.9070607@web.de> <50BA245A.5000702@web.de>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210977>


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 01, 2012 at 04:38:02PM +0100, Jens Lehmann wrote:
> Am 30.11.2012 18:53, schrieb W. Trevor King:
> > In my v5 patch, I check for submodule.<name>.remote first in the usual
> > `git config` files.  If I don't find what I'm looking for I fall back
> > on .gitmodules (basically Jens' suggestion).  However, my initial
> > copying-to-.git/config approach was mostly done to mimic existing
> > configuration handling in git-submodule.sh.  Since I agree with Jens
> > on configuration precendence, and I now had two options to read
> > (.branch and .remote), I thought I'd pull the logic out into its own
> > function (code included at the end).  While I was shifting the
> > existing submodule config handling over to my new function, I noticed
> > that with this logic, `submodule init` doesn't really do anything
> > important anymore.  Likewise for `submodule sync`, which seems to be
> > quite similar to `init`.
>=20
> You need to handle the 'url' setting differently. While I think the
> 'update' setting should not be copied into .git/config at all
> (because it makes it impossible for upstream to change that later
> without the user copying that himself as 'sync' doesn't do that) the
> 'url' setting in .git/config has two important implications:
>=20
> 1) It tells the submodule commands that the user wants to have that
>    submodule populated  (which is done in a subsequent "update" after
>    "init" copied the url there).

Good point, but this should depend on submodule.<name>.update; having
it as a side effect of a local submodule.<name>.url makes no sense.
Perhaps `submodule init` should be reduced to just wrap:

  $ git config submodule.<name>.update checkout

where the default update configuration would be 'none'.

> 2) It can be used to follow moving upstreams (think of checking out
>    an earlier commit before the upstream was moved, you won't be able
>    to clone it from there without having the new setting persist).
>    And which repository you follow is a matter of trust, so the extra
>    "git submodule sync" in that case is a good thing to have.
>=20
> So I believe 'url' is the only setting that should be copied into
> .git/config while all the others shouldn't.

If you want to override the old repository location for an old commit,
setting submodule.<name>.url makes sense.  My rewritten `sync` updates
the local submodule.<name>.url in the superproject if the
configuration option is already set [1].  Perhaps a `sync --local`
invocation should forcibly populate the local submodule.<name>.url to
make this workflow easier.  Bundling sugar for this special case
should not happen under an extra command called `init`.

> > [snip get_submodule_config()]
>
> Something like that makes sense. You can use it for the settings you add
> first and we can then reuse that for 'update' in a separate patch later.

I'm currently working out the details independently against v1.8.0.
This will be a fairly major shift, so I think it should stay
independent of `update --remote`.  The `update --remote` stuff should
be easy to adjust/rebase if the `init` removal/adjustment develops
into something acceptable.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQujCKAAoJEEUbTsx0l5OMjqQP/0rY9oI0z9w2kQQaag0beqHu
0zucwcRjrwrvtkknnB2L9XREKdnW/U4AKLb1YHLAHopW5FTrN94koUYggdkw66YM
MSpKGAAOOHqEaxMT0k/gI5rvWJ6p2hXHOkLv9RIvw4T72xY+XU+GtV+ZSwStarZR
3SqAI0svn4utMkBNyoRQFKLloZk7x9GJJCyv5xv75w4BCzhr52j2gXKFlfdxfpjA
pl9e2cNIXrWcf8OUmKm6wM/zNUc95UhGBUN5PH0J2FUyARbu3vDVDuZSNye15v47
0ZG21t5q1Hgy8a69TWnkSUS0rnix+3hiIlMJdfVNoZHHO8IOMsGbtDObEkhhxvf+
VZbZ/cc7cXKOVVcc5pchzalRjNBxx/sRhhmd2UCzeS57OV1zr/SDiYRzegAaQvnW
XQoLHuMFAg9pXKxXdCnyXa/CqvR/jOF/GLlS8kpQ+8aJOytvqnbfypCazKeqTQX+
TuqfloZzRIypKCv0FAWsoHP6zIlIFdE0H74DicYwfGuMzyfg5G0VVjN+iwQb2gGh
xWjVWpjU57UdpZzwd5gsEgWDRqFwAC/XOXUfg31cyVtL5the/FPbhEm94BWxHoQb
Xn7ygAB4ndCu7aw1mjAetSBijiZiLPFnLoeYWMvcFMHaFqPqNnELezcEgmIuGiuz
CuHRkm1anIIpzSSs4Agd
=SO3F
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--
