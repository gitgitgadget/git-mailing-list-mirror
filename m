From: Jan Hudec <bulb@ucw.cz>
Subject: Re: .gitignore, .gitattributes, .gitmodules,
	.gitprecious?,.gitacls? etc.
Date: Wed, 5 Sep 2007 20:38:31 +0200
Message-ID: <20070905183831.GA29370@efreet.light.src>
References: <7vhcmmpxed.fsf@gitster.siamese.dyndns.org> <B4A2AE9980774365B5D14B442A7A22F6@ntdev.corp.microsoft.com> <20070826100647.GH1219@pasky.or.cz> <4C603F7C51884DF8AFAEC3F6E263798D@ntdev.corp.microsoft.com> <a1bbc6950708271327x4dd948d4m8e9e35f757a7d92e@mail.gmail.com> <Pine.LNX.4.64.0708280945350.28586@racer.site> <20070904202326.GC3786@efreet.light.src> <a1bbc6950709050106j137215obd7272b2a77c3b13@mail.gmail.com> <7vk5r5jzpn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Cc: Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 20:38:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISzm1-0000nW-F3
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 20:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753693AbXIESil (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 14:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753903AbXIESil
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 14:38:41 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:56790 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753693AbXIESik (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 14:38:40 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id CF9A4576F6;
	Wed,  5 Sep 2007 20:38:38 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id AaQcOX0Xs2Ri; Wed,  5 Sep 2007 20:38:35 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 86142576BE;
	Wed,  5 Sep 2007 20:38:34 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1ISzln-0007fg-FH; Wed, 05 Sep 2007 20:38:31 +0200
Content-Disposition: inline
In-Reply-To: <7vk5r5jzpn.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57736>


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 05, 2007 at 01:14:44 -0700, Junio C Hamano wrote:
> "Dmitry Kakurin" <dmitry.kakurin@gmail.com> writes:
>=20
> > I assert that since index does not have .gitattributes the one from
> > local directory should not be used.
> >
> > Think about dedicated build machine scenario: I have a machine that
> > always does sync + build. After every sync the local directory should
> > always be identical to what-was-committed.
>=20
> Thinking about the reason _why_ .gitattributes may be updated,
> one would notice that it is because somebody did this command
> sequence:
>=20
> 	git checkout		;# now work tree is clean
> 	edit .gitattributes	;# modify the attributes of a file
> 	edit file		;# edit the file attributes talks about
> 	git add file		;# this can be affected by .gitattributes
> 	git add .gitattributes	;# this is changed in the same commit
> 	git commit
>=20
> Now, should we always take .gitattributes from the index?

Yes, they should:

$ git checkout
$ edit .gitattributes
$ edit file
$ git add file
$ git commit ;# this does NOT have the changes to .gitattributes

the above case is a user error that can (at some cost) be detected:

$ git checkout
$ edit .gitattributes
$ edit file
$ git add file
$ git add .gitattributes
Warning! Changes to gitattributes affects handling of files scheduled for
commit. Please add following files again before commit:
  file
$

It would be possible to special-case .gitattributes in add to:
 - do diff between the old and new value of .gitattributes in index,
 - list files changed in index compared to HEAD,
 - match each of them to all patterns in the diff,
 - if any matches, print the warning and list of matches.
It might be even possible to actually inspect the changes and apply those
that can be automatically (and not ask user to re-add), but some filters
loose information, so user interaction is needed to add good version.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG3venRel1vVwhjGURArVbAKDmluauHY6dAqMD5QIFsGWaKzTRXACfZO1X
91F71Rn0yEJspedfzjCSNjM=
=heD5
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
