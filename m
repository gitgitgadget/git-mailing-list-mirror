From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: regression in  92392b4
Date: Wed, 23 Jul 2008 03:09:28 +0200
Message-ID: <20080723010928.GG11831@artemis.madism.org>
References: <20080722231745.GD11831@artemis.madism.org> <alpine.DEB.1.00.0807230033000.8986@racer> <20080723004108.GB14668@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="8bBEDOJVaa9YlTAt";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git ML <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jul 23 03:10:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLSsB-0002IS-Hs
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 03:10:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbYGWBJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 21:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbYGWBJc
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 21:09:32 -0400
Received: from pan.madism.org ([88.191.52.104]:50114 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751061AbYGWBJb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 21:09:31 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id A4104CE2;
	Wed, 23 Jul 2008 03:09:29 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id A1BCF142488; Wed, 23 Jul 2008 03:09:28 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git ML <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <20080723004108.GB14668@spearce.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89586>


--8bBEDOJVaa9YlTAt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2008 at 12:41:08AM +0000, Shawn O. Pearce wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Wed, 23 Jul 2008, Pierre Habouzit wrote:
> >=20
> > >   Hi, here is a manual painful down-secting (opposed to a bisect ;P) I
> > > did, since git in next cannot fetch on a regular basis for me. The
> > > culprit seems to be commit  92392b4:
> > >=20
> > >     =E2=94=8C=E2=94=80(1:11)=E2=94=80=E2=94=80<~/dev/scm/git 92392b4.=
=2E..>=E2=94=80=E2=94=80
> > >     =E2=94=94[artemis] git fetch
> > >     remote: Counting objects: 461, done.
> > >     remote: Compressing objects: 100% (141/141), done.
> > >     remote: Total 263 (delta 227), reused 155 (delta 121)
> > >     Receiving objects: 100% (263/263), 95.55 KiB, done.
> > >     fatal: Out of memory, malloc failed
> > >     fatal: index-pack failed
> > >     [2]    16674 abort (core dumped)  git fetch
> ....
> >=20
> > Just a guess:
> ....
> > diff --git a/index-pack.c b/index-pack.c
> > index ac20a46..19c39e5 100644
> > --- a/index-pack.c
> > +++ b/index-pack.c
> > @@ -257,6 +257,7 @@ static void unlink_base_data(struct base_data *c)
> >  		base_cache =3D NULL;
> >  	if (c->data) {
> >  		free(c->data);
> > +		c->data =3D NULL;
> >  		base_cache_used -=3D c->size;
> >  	}
> >  }
>=20
> Oh.  This is a pointless assignment.  If you look at any call sites
> for unlink_base_data() you will find that the struct passed in as
> "c" here is going out of scope after unlink_base_data() returns.  In
> no such case does the value of c->data get tested once this free is
> complete.
>=20
> We need the if (c->data) guard because we only want to decrement
> base_cache_used if the memory is still allocated.  It may have been
> released earlier, in which case base_cache_used has already been
> decreased and we don't want to double-decrement it.
>=20
> This patch makes the code more obvious, so Ack I guess, but it is
> not a solution to Pierre's woes.  Something else is wrong.
>=20
> Reading above shows we got a "fatal: Out of memory, malloc failed"
> right before the segfault.  What's odd is we segfaulted after we
> ran out of memory and should have die'd.
>=20
> There's at least two bugs in the above output:
>=20
> a) index-pack ran out of memory on a small pull (95 KiB).
> b) fetch segfaulted when index-pack failed.
>=20
> And this patch will unfortunately address neither of them.  :-|
>=20
> I've had a long past couple of days, and another one tomorrow.
> I'm not going to be able to debug this myself until perhaps Thursday
> or Friday.  Sorry.  If nobody beats me to it, I will put this on
> the top of the pile and try to fix it once I get back online at my
> new home.

  Like I said, I had a core that I stupidly lost, but I remember that
the broken malloc was:


    static void *get_data_from_pack(struct object_entry *obj)
    {
	    off_t from =3D obj[0].idx.offset + obj[0].hdr_size;
	    unsigned long len =3D obj[1].idx.offset - from;
	    unsigned long rdy =3D 0;
	    unsigned char *src, *data;
	    z_stream stream;
	    int st;

	    src =3D xmalloc(len);
            ^^^^^^^^^^^^^^^^^^

  len was horribly big, and outputing obj[1].idx showed that `sha1` had
text in it. I mean something like "could not\r\n     han" IIRC.

  I don't remember the rest of the backtrace, and have stupidly not kept
any ways of reproducing it.

--8bBEDOJVaa9YlTAt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiGhMgACgkQvGr7W6Hudhw6CgCfZiY/eBbr69rEUdQQeuNLxhYj
cdsAn103SGA3T4HE9VHEKSHlXshYc6xn
=CJSX
-----END PGP SIGNATURE-----

--8bBEDOJVaa9YlTAt--
