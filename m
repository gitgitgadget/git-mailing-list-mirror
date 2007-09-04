From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Wed, 05 Sep 2007 01:01:17 +0200
Message-ID: <20070904230117.GA12448@olympe.madism.org>
References: <46DDC500.5000606@etek.chalmers.se> <20070904213857.GA21351@steel.home>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="FCuugMFkClbJLl1L";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Lukas =?utf-8?Q?Sandstr=C3=B6m?= <lukass@etek.chalmers.se>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 01:03:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IShQc-0001RG-9S
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 01:03:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753570AbXIDXDV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 19:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752403AbXIDXDV
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 19:03:21 -0400
Received: from postfix2-g20.free.fr ([212.27.60.43]:38713 "EHLO
	postfix2-g20.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753172AbXIDXDU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 19:03:20 -0400
Received: from smtp7-g19.free.fr (smtp7-g19.free.fr [212.27.42.64])
	by postfix2-g20.free.fr (Postfix) with ESMTP id D649619F7440
	for <git@vger.kernel.org>; Wed,  5 Sep 2007 00:04:14 +0200 (CEST)
Received: from smtp7-g19.free.fr (localhost [127.0.0.1])
	by smtp7-g19.free.fr (Postfix) with ESMTP id E7DA31A371;
	Wed,  5 Sep 2007 01:01:17 +0200 (CEST)
Received: from olympe.madism.org (olympe.madism.org [82.243.245.108])
	by smtp7-g19.free.fr (Postfix) with ESMTP id A65711A360;
	Wed,  5 Sep 2007 01:01:17 +0200 (CEST)
Received: by olympe.madism.org (Postfix, from userid 1001)
	id 720215E565; Wed,  5 Sep 2007 01:01:17 +0200 (CEST)
Mail-Followup-To: Alex Riesen <raa.lkml@gmail.com>,
	Lukas =?utf-8?Q?Sandstr=C3=B6m?= <lukass@etek.chalmers.se>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20070904213857.GA21351@steel.home>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57654>


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On mar, sep 04, 2007 at 09:38:57 +0000, Alex Riesen wrote:
> Lukas Sandstr=C3=B6m, Tue, Sep 04, 2007 22:50:08 +0200:
> > Hi.
> >=20
> > This is an attempt to use "The Better String Library"[1] in builtin-mai=
linfo.c
> >=20
> > The patch doesn't pass all the tests in the testsuit yet, but I thought=
 I'd
> > send it out so people can decide if they like how the code looks.
>=20
> It looks uglier, but what are measurable merits? Object code size,
> perfomance hit/improvement, valgrind logs?

  Well I honestly believe that putting strbufs/bstrings in mailinfo.c
adds no value. I was going to give it a try to see how strbufs
performed, but it's just useless.

  The main problem mailinfo has, it's according to Junio that it may
sometimes truncate some things in buffers at 1000 octets, without dying
loudly. That is bad.

  _but_ there is no point in using arbitrary long string buffers to
parse a mail. Remember, a mail goes through SMTP, and SMTP is supposed
to limit its lines at 512 characters (without use of extensions at
least). Not to mention that an email address cannot be more than 64+256
chars long (or sth around that). So using variable lengths buffers is
just a waste.

  string buffers are not really (IMHO) supposed to help in parsing
tasks, and when you need to do some serious parsing, either do it by
hand or use lex, but nothing in between makes sense to me.

  OTOH, string buffers can be used in many places where git has (at
least 4 different to my current count, growing) many implementations of
always slightly different kind of buffers. I've some more patches
pending here than the one I already sent, and well, here is the
diffstat:

$ git diff --stat origin/master.. ^strbuf*
 archive-tar.c         |   67 ++++++++++++---------------------------------=
---
 builtin-apply.c       |   29 ++++++---------------
 builtin-blame.c       |   34 ++++++++-----------------
 builtin-commit-tree.c |   59 +++++++++---------------------------------
 builtin-rerere.c      |   53 +++++++++++---------------------------
 cache-tree.c          |   57 ++++++++++++++---------------------------
 diff.c                |   25 ++++++------------
 fast-import.c         |   38 +++++++++++----------------
 mktree.c              |   26 ++++++-------------
 9 files changed, 116 insertions(+), 272 deletions(-)

  I mean, there is not even a need to show the diff to understand what
the gain is. And that was possible, because strbufs are straightforward,
and gives you the kind of controls git needs (tweaking how memory will
be allocated to avoid reallocs is part of the answer).


  A French author once said: =E2=80=9CIl semble que la perfection soit atte=
inte
non quand il n'y a plus rien =C3=A0 ajouter, mais quand il n'y a plus rien =
=C3=A0
retrancher.=E2=80=9D -- Antoine de St =C3=89xup=C3=A9ry[0]. IMHO git will n=
ever need any
of the bstring splits, streaming functions, tokenization or whatever,
and supporting those has necessarily led the bstring library to make
some choices that may not fit git needs. I don't really like reinventing
the wheel, but OTOH buffers and strings are often of the critical path,
and having a nice fitting buffer API is priceless.


  [0] Perfection is achieved, not when there is nothing more to add, but
      when there is nothing left to take away.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG3eO9vGr7W6HudhwRAqnsAJ9UHd1iStelrqBl+R/QMAtRr2kdSgCfYn7V
dJCqYKMvF76KY19rzRxk+i4=
=WMWl
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
