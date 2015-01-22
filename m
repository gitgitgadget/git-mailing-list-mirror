From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 1/3] connect.c: Improve parsing of literal IPV6 addresses
Date: Thu, 22 Jan 2015 20:07:03 +0000
Message-ID: <20150122200702.GA96498@vauxhall.crustytoothpaste.net>
References: <54BD3D14.90309@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Cc: git@vger.kernel.org, lists@hcf.yourweb.de
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Jan 22 21:07:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEO27-0006Qw-35
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 21:07:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752922AbbAVUHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 15:07:11 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:43391 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752479AbbAVUHJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jan 2015 15:07:09 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:c8c4:ec20:e47c:f338])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 1C2F42808F;
	Thu, 22 Jan 2015 20:07:08 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, lists@hcf.yourweb.de
Content-Disposition: inline
In-Reply-To: <54BD3D14.90309@web.de>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.16.0-4-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262863>


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2015 at 06:21:24PM +0100, Torsten B=C3=B6gershausen wrote:
>When parsing an URL, older Git versions did handle
>URLs like ssh://2001:db8::1/repo.git the same way as
>ssh://[2001:db8::1]/repo.git
>
>Commit 83b058 broke the parsing of IPV6 adresses without "[]":
>It was written in mind that the fist ':' in a URL was the beginning of a
>port number, while the old code was more clever:
>Literal IPV6 addresses have always at least two ':'.
>When the "hostandport" had a ':' and the rest of the hostandport string
>could be parsed into an integer between 0 and 65536, then it was used
>as a port number, like "host:22".
>Otherwise the first ':' was assumed to be part of a literal IPV6 address,
>like "ssh://[2001:db8::1]/repo.git" or "ssh://[::1]/repo.git".
>
>Re-introduce the old parsing in get_host_and_port().
>
>Improve the parsing to handle URLs which have a user name and a literal
>IPV6 like "ssh://user@[2001:db8::1]/repo.git".
>(Thanks to Christian Taube <lists@hcf.yourweb.de> for reporting this long
>standing issue)
>
>Another regression was introduced in 83b058:
>A non-RFC conform URL like "[localhost:222]" could be used in older versio=
ns
>of Git to connect to run "ssh -p 222 localhost".
>The new stricter parsing did not allow this any more.
>See even 8d3d28f5dba why "[localhost:222]" should be declared a feature.

I'm not sure this is a very good idea.  While this may have worked in=20
the past, it's also completely inconsistent with the way all non-SSH=20
URLs work in Git:

  vauxhall ok % git push https://bmc@2001:470:1f05:79::1/git/bmc/homedir.gi=
t master
  fatal: unable to access 'https://bmc@2001:470:1f05:79::1/git/bmc/homedir.=
git/': IPv6 numerical address used in URL without brackets

  vauxhall no % git push https://bmc@[castro.crustytoothpaste.net]/git/bmc/=
homedir.git master
  fatal: unable to access 'https://bmc@[castro.crustytoothpaste.net]/git/bm=
c/homedir.git/': Could not resolve host: [castro.crustytoothpaste.net]

  vauxhall no % git push https://bmc@[castro.crustytoothpaste.net:443]/git/=
bmc/homedir.git master
  fatal: unable to access 'https://bmc@[castro.crustytoothpaste.net:443]/gi=
t/bmc/homedir.git/': Could not resolve host: [castro.crustytoothpaste.net

I would argue that people using IPv6 literals in URLs should already=20
know how to do it correctly, and the consistency between SSH and HTTPS=20
URLs is a feature, not a bug.  In the non-URL SSH form, you still have=20
to use the bracketed form to deal with the case in which somebody=20
creates a directory called "1" in their home directory and writes:

  git push 2001:470:1f05:79::1:1 master=20

when they mean

  git push [2001:470:1f05:79::1]:1 master
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUwVhmAAoJEL9TXYEfUvaLEQ0P/3Sfzp0EGXtfsvRW2sG3VOt0
fnBa1RSKPl9s+BxebIGn3HMHcH2u0wOfb71hbKwcQWaMVgzoH7wsd9ma3spwSWvA
qbA6WOy+WTT9fJAmF6+9X/RsC7EfIBsKeLfuW7K/MydDo+/xuEFS/7L8DYNRNBlR
UrhKop3v+UlMRng6wOCcaZdV9jQcDb6MAHLfzkkdszrW8HPA8MyQpIBSvmrl1rRn
sT4DmT7Dt15MjWIAEVyieihyaZ8PW29HypsNs1q66vCrvC9VE4oNwZVfZ5ewH1+q
7d+lJwrtcUvUsBCKaQRipavo5Mq2NLiZ9kwjb4Xk6KBXl8IX+j6jDfF5Yi1Mq0py
ZNA+ENI5OB/A1zs8CmxvenuHz0J8NgmIL3dMRvNCI+QukPhoA0CreaCazhE51vM/
KfjCpctv/63XNMCS81+/HRRE4dE02ahdiB3h1Kuvgc2fb8CEZbVh9Hz+elBNO2ei
vreVGDc/z/TG12cjp9w21T0w6qexLqEtasWG9nPYZPZIqg6I+IMFNEtLNFlclW4f
+HSHlNDfnWqvhH4v5tZ6f4mlLQSOkEd+HSDPTbgvCWx4oGSPrpzhFE8MrxIrWKoc
b+vrLvQ7sTI629J5kIzOHqNsyNEzFUduWGFEfzu44k1398ztpx1vQsojCi0XQSfz
dkbCBckv58AuCuDN9Cz9
=q+TY
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
