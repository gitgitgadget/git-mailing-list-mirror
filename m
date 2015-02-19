From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: odb_mkstemp's 0444 permission broke write/delete access on AFP
Date: Thu, 19 Feb 2015 20:08:33 +0000
Message-ID: <20150219200833.GB5021@vauxhall.crustytoothpaste.net>
References: <A403BFCC-D66F-49BD-B54C-BB86B467F1A1@gmail.com>
 <vpqtwyl90mx.fsf@anie.imag.fr>
 <340435D1-2FEB-4A4A-BBD2-E301096C72D8@gmail.com>
 <vpqiof14qu8.fsf@anie.imag.fr>
 <13683B35-70A8-4D9E-80E1-440E4E0DC7F0@gmail.com>
 <vpqr3tozzs5.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Cc: Fairuzan Roslan <fairuzan.roslan@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org, tboegi@web.de
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Feb 19 21:08:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOXOv-00087s-Lq
	for gcvg-git-2@plane.gmane.org; Thu, 19 Feb 2015 21:08:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784AbbBSUIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2015 15:08:40 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49008 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752398AbbBSUIk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Feb 2015 15:08:40 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:e5aa:2c88:b0cf:ba1e])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 4D13D2808F;
	Thu, 19 Feb 2015 20:08:37 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Fairuzan Roslan <fairuzan.roslan@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org, tboegi@web.de
Content-Disposition: inline
In-Reply-To: <vpqr3tozzs5.fsf@anie.imag.fr>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.19.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264112>


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2015 at 09:51:38AM +0100, Matthieu Moy wrote:
> This should be fixable from Git itself, by replacing the calls to
> "unlink" with something like
>=20
> int unlink_or_chmod(...) {
> 	if (unlink(...)) {
> 		chmod(...); // give user write permission
> 		return unlink(...);
> 	}
> }
>=20
> This does not add extra cost in the normal case, and would fix this
> particular issue for afp shares. So, I think that would fix the biggest
> problem for afp-share users without disturbing others. It seems
> reasonable to me to do that unconditionnally.

This can have security issues if you're trying to unlink a symlink, as=20
chmod will dereference the symlink but unlink will not.  Giving the file=20
owner write permission may not be sufficient, as the user may be a=20
member of a group with write access to the repo.  A malicious user who=20
also has access to the repo could force the current user to chmod an=20
arbitrary file such that it had looser permissions.

I've seen a case where Perl's ExtUtils::MakeMaker chmoded=20
/etc/mime.types 0666 as a result of this.

I don't think there's a secure way to implement this unless you're on an=20
OS with lchmod or fchmodat that supports AT_SYMLINK_NOFOLLOW.  Linux is=20
not one of those systems.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU5kLBAAoJEL9TXYEfUvaLTGAQAKFuPn88A9kzl9mWn5bzpuiP
10sGgvHdyHpL1isKkHB1peu4JTL0YF+FVdog3I5+hZ3DmbG87tEF3oc7YVFmHjZd
IjHDOZd6nOGKHcuU9wmXn2+LqhmEFn5qVKY39G4iokHmr0XPeulyyiuR6K5DUJR/
YeUFeo5uxMuUhYB7a1FgrlxKRwuSVFJM6HK4SgHK0Aw+GLJ7sy3oeNyeVp5wMxVO
s1gq7y4C3bRyqzYyrjBaEE/t8IbBJ3m9+09cJCfrFjcaDh8Ft/hauZNQ+ryf+QXE
kYqVyHPP6E/Ort2OFXJf8tvieqR7dvScbZx8/F2Lj5PmppVFwL1F3JRUeUDVMMRu
t9Sj/MP+JLC/gFZ4kI4B/MjckQ2xrPlXHU/9TeZkQOr+5l2ayLATmcJCpRI9zkv9
gLfR/8G2ZSspPN/VJpM5yh3muQW8iLI5c8tE4qeRAZvffBTFMSoZwHOEfzALT7X6
b42+AQ5PLSPiSs4RWQMS8uvms4h/VGTothxW7mH7lAHl7zjsKYiOeZuxtNrHrV9j
gP/gsl36u+nKy78iWg3bpU14Vbhg7gUTkPLTFUu6mkOeV4Ky1oH55UXSvykaIGL9
tjRqHJPmfe64WwaAF0uwudhpMszYjVQTsUy7TiN+E9rZ6gSzb0eDI0lGdurPhk4q
ooLAz+jdQc6JsB2zk30j
=Vtn+
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
