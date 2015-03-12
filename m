From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 01/10] Define a structure for object IDs.
Date: Thu, 12 Mar 2015 10:46:52 +0000
Message-ID: <20150312104651.GF46326@vauxhall.crustytoothpaste.net>
References: <1425770645-628957-1-git-send-email-sandals@crustytoothpaste.net>
 <1425770645-628957-2-git-send-email-sandals@crustytoothpaste.net>
 <CEA07500-9F47-4B24-AD5D-1423A601A4DD@gmail.com>
 <20150311220825.GB46326@vauxhall.crustytoothpaste.net>
 <xmqqr3sv3vsf.fsf@gitster.dls.corp.google.com>
 <55016A3A.6010100@alum.mit.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AH+kv8CCoFf6qPuz"
Cc: Junio C Hamano <gitster@pobox.com>,
	"Kyle J. McKay" <mackyle@gmail.com>, git@vger.kernel.org,
	Andreas Schwab <schwab@linux-m68k.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Mar 12 11:47:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YW0dw-0007J5-Ei
	for gcvg-git-2@plane.gmane.org; Thu, 12 Mar 2015 11:47:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753556AbbCLKq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2015 06:46:57 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50046 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751121AbbCLKq4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2015 06:46:56 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:d0c6:418b:e1a:b913])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id AA1462808F;
	Thu, 12 Mar 2015 10:46:55 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	"Kyle J. McKay" <mackyle@gmail.com>, git@vger.kernel.org,
	Andreas Schwab <schwab@linux-m68k.org>
Content-Disposition: inline
In-Reply-To: <55016A3A.6010100@alum.mit.edu>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.19.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265359>


--AH+kv8CCoFf6qPuz
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2015 at 11:28:10AM +0100, Michael Haggerty wrote:
>On 03/12/2015 01:26 AM, Junio C Hamano wrote:
>> And that would break the abstraction effort if you start calling the
>> field with a name that is specific to the underlying hash function.
>> The caller has to change o->sha1 to o->sha256 instead of keeping
>> that as o->oid and letting the callee handle the implementation
>> details when calling
>>
>>         if (!hashcmp(o1->oid, o2->oid))
>>                 ; /* they are the same */
>>         else
>>                 ; /* they are different */
>> [...]
>
>Hmm, I guess you imagine that we might sometimes pack SHA-1s, sometimes
>SHA-256s (or whatever) in the "oid" field, which would be dimensioned
>large enough for either one (with, say, SHA-1s padded with zeros).
>
>I was imagining that this would evolve into a union (or maybe struct) of
>different hash types, like
>
>    struct object_id {
>        unsigned char hash_type;
>        union {
>            unsigned char sha1[GIT_SHA1_RAWSZ];
>            unsigned char sha256[GIT_SHA256_RAWSZ];
>        } hash;
>    };
>
>BTW in either case, any hopes of mapping object_id objects directly on
>top of buffer memory would disappear.

What I think might be more beneficial is to make the hash function
specific to a particular repository, and therefore you could maintain
something like this:

  struct object_id {
      unsigned char hash[GIT_MAX_RAWSZ];
  };

and make hash_type (or hash_length) a global[0].  I don't think it's
very worthwhile to try to mix two different hash functions in the same
repository, so we could still map directly onto buffer memory if we
decide that's portable enough.  I expect the cases where we need to do
that will be relatively limited.

Regardless, it seems that this solution has the most support (including
Junio's) and it's more self-documenting than my current set of patches,
so I'm going to go with it for now.  It should be easy to change if the
consensus goes back the other way.

[0] I personally think globals are a bit gross, but they don't seem to
have the problems that they would if git were a shared library.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--AH+kv8CCoFf6qPuz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVAW6bAAoJEL9TXYEfUvaLV1UP/24v37RIjrhvqO0A7dz41pLm
6xC7H8ZLBMj7lgDZU3JeHeD2DvEXjVQXqkR6wrQUDsJvLqGPI4mYROWGzbWmWwUA
YBm/icBMZCbinT5j+/13HEL/38OnRqNgKpKmQYigRvyOQOROpxaWqxIVZ9wepcLN
QFgyL+PaDMeUT7b1AF3WdORC1rGOTsqcpeUv4NNIUJ3gFZHFaFXIV3GnARSb5gYF
gpbDU6Cc4Y8AzTL+M5MNhZZP2lT2RwLlzx6Feg3s/eYqovLVQ3tEKPCI6mED+k/Y
TXpK4Ing2Iyy/ANbaIi2gobGv546hqaUNP2A6H4Usaq1QRejE1ie4KqQwkb8yg3D
ixO5Ev5VjsmIw1mvZmEZ8NXodHkdi1QJW7owdTkPjcAq53outEBGhfpGVmfnW3TG
jhbXW3oawZYG2f1pb8OS2FFz9C2nPP+2de5eO9/jUER4QUXj7t2JyuMru6bWhyTH
zYhachVTK2caZeM9n/oDqT8zXfgWXiwL6yLIBbsF+E+N9p2jChYxnt/7C0gRFysQ
QuBTNUD0GgN3ijTgyZurXqcxzV7pv6d/I/pomRNQVpQxHlL+jEmDtE1SAZ9jV1Da
Lwcl8T4RZiZeV9SE6REmvf0uS7DS6h0WqHrpLZhioUArevDMXyvOBPBSh+cwkzIg
8or5Xp28UNzPieZtsBbL
=5pSS
-----END PGP SIGNATURE-----

--AH+kv8CCoFf6qPuz--
