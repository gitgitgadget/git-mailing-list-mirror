From: Eric Blake <eblake@redhat.com>
Subject: temporarily unsetting sendemail.smtpuser
Date: Wed, 19 May 2010 16:54:02 -0600
Organization: Red Hat
Message-ID: <4BF46C0A.9070000@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enig8B108844B2942D0ACD1757FC"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 20 00:54:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEs9n-0007G1-GH
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 00:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961Ab0ESWy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 May 2010 18:54:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15506 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750943Ab0ESWyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 May 2010 18:54:25 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o4JMsPgs017762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Wed, 19 May 2010 18:54:25 -0400
Received: from [10.11.8.79] (vpn-8-79.rdu.redhat.com [10.11.8.79])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o4JMsMOO032716
	for <git@vger.kernel.org>; Wed, 19 May 2010 18:54:23 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-3.fc13 Lightning/1.0b1 Mnenhy/0.8.2 Thunderbird/3.0.4
X-Enigmail-Version: 1.0.1
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147351>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8B108844B2942D0ACD1757FC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I have a setup where I normally send patches through my ISP, which
requires authentication, so I have sendemail.smtpuser=3Dme and
sendemail.smtpserverport=3D587 set in my ~/.gitconfig (among others).  Bu=
t
for one project I work on, I am required to send patches through an
alternate SMTP server that does not require authentication.

At first, I thought it would be a simple matter to use git config to
create an alias, where the explicit command line requests would override
the global ~/.gitconfig settings:

[alias]
	submit =3D send-email --smtp-user=3D --smtp-server=3Dalternate \
		--smtp-server-port=3D25

But that fails with:

$ git submit -1
fatal: unrecognized argument: --smtp-user=3D
format-patch -o /tmp/JgTFO8Rq3v -1 --smtp-user=3D: command returned error=
: 128

In other words, git-send-email didn't recognize the empty --smtp-user=3D
command as an override request, and instead passed it on to
git-format-patch which croaks.

So I ended up creating this hairy alias instead:

[alias]
	submit =3D "!sh -c 'git config --global --unset sendemail.smtpuser; git
send-email --smtp-server=3Dalternate --smtp-server-port=3D25 \"$@\"; st=3D=
$?;
git config --global sendemail.smtpuser me; (exit $st)' sh"

I suppose I could have used a shell function for fewer forks:

[alias]
	submit =3D "!doit() { git config --global --unset sendemail.smtpuser; gi=
t
send-email --smtp-server=3Dalternate --smtp-server-port=3D25 \"$@\"; st=3D=
$?;
git config --global sendemail.smtpuser me; return $st; }; doit"

But both of those are rather unappealing.  Is there a better approach to
accomplishing what I wanted?

--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org


--------------enig8B108844B2942D0ACD1757FC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJL9GwLAAoJEKeha0olJ0Nqxi8H/2h0C3YVw5mwOC5fUsWNxSqN
5hLEN5G3P2dvOyE4N2GJz1HP3YjE90T5LmJZ9mC9kY8Dp6dXKJxqNplf9yxqtBiH
vvSYXBqAkCsXddLAebHXumAHDtOFI06vZSjz02raSGFPIB9+xoeLWIuPKcqEdGNw
tXZG8D0j+5VgYrfahJeLM1v81vea+8pHKUOF6mDuBeOF5AAtoVXiKeZ04bIIEN7H
ZwowhN6mirLTsmA1qFzvCaOJ3ppm/a1uLQMLKiVQI9xGY3/u25SjEJ7j3+PVI6wj
H3R4DXVz4ztQQQKgyD57C/7+v2J1UbRpZ4HyOuyyT7/LcndKwxaFd/Natl1tKnw=
=0GQh
-----END PGP SIGNATURE-----

--------------enig8B108844B2942D0ACD1757FC--
