From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 3/4] Documentation: move some AsciiDoc parameters into
 variables
Date: Thu, 16 Oct 2014 01:52:53 +0000
Message-ID: <20141016015253.GC146788@vauxhall.crustytoothpaste.net>
References: <1413070656-241955-1-git-send-email-sandals@crustytoothpaste.net>
 <1413070656-241955-4-git-send-email-sandals@crustytoothpaste.net>
 <xmqq61flvzay.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="R+My9LyyhiUvIEro"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 16 03:53:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeaFS-0003QT-LA
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 03:53:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbaJPBw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 21:52:58 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49307 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750820AbaJPBw6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Oct 2014 21:52:58 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 16C402808F;
	Thu, 16 Oct 2014 01:52:57 +0000 (UTC)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <xmqq61flvzay.fsf@gitster.dls.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.17-rc5-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2014 at 01:43:49PM -0700, Junio C Hamano wrote:
> I think it makes sense to make these customizable, but I wonder if
> it makes the result easier to maintain if we make units of logical
> definitions larger, e.g.
>=20
> 	ASCIIDOC =3D asciidoc
>         TXT_TO_MANHTML =3D $(ASCIIDOC) -b xhtml11 -d manpage $(ASCIIDOC_C=
ONF)
>         TXT_TO_ARTICLE =3D $(ASCIIDOC) -b docbook -d article

Looking at the code, it seems the most reusable unit is something like
the following:

  TXT_TO_HTML =3D $(ASCIIDOC) -b xhtml11 $(ASCIIDOC_CONF)
  TXT_TO_XML =3D $(ASCIIDOC) -b docbook $(ASCIIDOC_CONF)

that is, omitting the -d argument from the variable.  Using -d would
mean we'd have to have a variable for each of the seven locations we
call $(ASCIIDOC).

> Then the above would become something like:
>=20
> 	ASCIIDOC =3D asciidoc
> 	ASCIIDOC_COMMON =3D $(ASCIIDOC) \
>         	$(ASCIIDOC_EXTRA) $(ASCIIDOC_CONF) -agit_version=3D$(GIT_VERSION)
>         TXT_TO_MANHTML =3D $(ASCIIDOC_COMMON) -b xhtml11 -d manpage
>         ...
>=20
> and would further simplify this part
>=20
> >  $(MAN_HTML): %.html : %.txt asciidoc.conf
> >  	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
> > -	$(ASCIIDOC) -b xhtml11 -d manpage -f asciidoc.conf \
> > +	$(ASCIIDOC) -b $(ASCIIDOC_HTML) -d manpage $(ASCIIDOC_CONF) \
> >  		$(ASCIIDOC_EXTRA) -agit_version=3D$(GIT_VERSION) -o $@+ $< && \
>=20
> into just
>=20
> 	$(TXT_TO_MANHTML) -o $@+ $<
>=20
> After all, our output formats are fairly limited, I would think.
> Are there too many different variants and exceptions to make such an
> approach infeasible?

I'm on board with the $(ASCIIDOC_COMMON) idea, but to minimize the
number of variables, I think we should leave the -d out of the macro
itself.  I'll re-roll over the next couple of days.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--R+My9LyyhiUvIEro
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUPyT1AAoJEL9TXYEfUvaLSLgQALCzShzC/zm6Ljb+UKiKxK1+
n63q2uPmmCyh0YTPJ+6Oazzmiq1a482VSau/dlk9rTspCoMYCIGwMCnG6xhUkqHc
0jmOAUaqbkyHe+cjj0/gFFOlchbAFSgGka34kThOVG+YOupt2s+BQGywx+nPkvfu
Cq+MTVBMh8Xt+NtV178K5CrXNFPoSSIne342tBjU8Z/OKfpxxJoazE1Gnv/6eZSl
FTSjys9ACQVW0Ta+e5o4Yo887E77vTS6IWmss3a39TYj0xMUjBR8NYsafn4u6QDG
HeKJ4I1I2VWa/3WgYygJ2dDSA+iV8NFEaSQQsPJYX6n6kZucVRJB7zGNVeeK65Gg
UuGclWG+vCt614Id8ceeYE896dBL1owyiAi8J25+1x6ZKatgfG/xohtmBtA27w5N
63i2ex1ezLOkIrAnKK7wje4HDOaSxInFVQaL5piTve8lok94TausLS8rBjPDlr3V
3PjOxVwnY/NaY5N3yFiCqJI/9rAG9C8Cex0tpeEDusiySCOtddilqBrghXUH9p94
/QmgAal99p4hqyG2yw3nPe0KTu82cyUZvCOFEQughfdQT5lqkd+wy4va4PmAbCqN
c1WozYo5djlF+jX7mlLk5lRv7b8sI1V1xiKOwf68MkvGh2K8S3CJ+Geks/3bnGra
Z7XNBHcpIdjhiaZECD26
=uFfo
-----END PGP SIGNATURE-----

--R+My9LyyhiUvIEro--
