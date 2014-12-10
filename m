From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Poor push performance with large number of refs
Date: Wed, 10 Dec 2014 23:34:43 +0000
Message-ID: <20141210233443.GA130424@vauxhall.crustytoothpaste.net>
References: <20141210003735.GA124293@vauxhall.crustytoothpaste.net>
 <CAJo=hJvKBvQvN=EV4y=ACz5pou9A0tD+txAn_8VR9L3KKtQSiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Cc: git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Dec 11 00:34:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyqmV-0000vr-5i
	for gcvg-git-2@plane.gmane.org; Thu, 11 Dec 2014 00:34:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758293AbaLJXev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 18:34:51 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:55233 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756847AbaLJXeu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Dec 2014 18:34:50 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 1F79A2808F;
	Wed, 10 Dec 2014 23:34:47 +0000 (UTC)
Mail-Followup-To: Shawn Pearce <spearce@spearce.org>,
	git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJo=hJvKBvQvN=EV4y=ACz5pou9A0tD+txAn_8VR9L3KKtQSiA@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.17.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261257>


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 09, 2014 at 09:41:28PM -0800, Shawn Pearce wrote:
> On Tue, Dec 9, 2014 at 4:37 PM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > Most of the time is spent between the "Pushing to remote machine" and
> > "Counting objects", running git pack-objects:
> >
> >   git pack-objects --all-progress-implied --revs --stdout --thin --delt=
a-base-offset --progress
> >
> > Unfortunately, -vvv doesn't provide any helpful output.  I have some
> > suspicions what's going on here, but no hard data.  Where should I
> > be looking to determine the bottleneck?
>=20
> My guess is the revision queue is struggling to insert 20,000 commits
> that the remote side "has", are uninteresting, and should not be
> transmitted. This queue insertion usually requires parsing the commit
> object out of the local object store to get the commit timestamp, then
> bubble sort inserting that commit into the queue.

I looked at this more in depth today and I found that the bottleneck is
--thin.  I tried git send-pack, which does not use --thin by default,
which led me to further testing.  A particular push went from 24 seconds
with --thin to 4 seconds without.

I agree that the large number of refs is at least part of the problem,
because reducing the number of refs has a slight but noticeable impact.
It's also the factor I can least control.

I have a patch which allows per-remote configuration of whether to use
thin packs (which I will send shortly), but I'm wondering if we can do
better, especially since --thin is the default.  It looks like --thin
forces pack-objects to do its own lookup (essentially a rev-list)
instead of using the values provided on stdin.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUiNiTAAoJEL9TXYEfUvaLHcwP/1pyFVIZazbnB9O9940jg1JT
80b8IQWH4LI3GeEN9hYrbrNjHc9L7wJdoZ5i4TJAe3TbubbqHVwdXWVqooNHik9B
BoeeMgx55urDe7HS3Mwx3Wd3qGBeU74m3Zuk5MI+vj62R8ChylYORsIiSMtfmTrc
nK0rsSRsGPK/Q6/S5B4w0wN/MLkV0kidqeDdhjczkEvD0ZkP1sQww3eslFdiWnLD
/5dgF3ffj+RhrqY6VLdeLjrYYdiM+i/ZkhfODuK/syx6bYg3licm0VfKNn/KA3Zo
y/yfCXSLwzceOnrNDm7YzgRxoHV3O5ZXrWnE1QZHaUb42+nPnglhS00J35p89MUi
7bvRpF9utnO4vs1qRqYw58tBhqW1jz0/ErrdK0VTbp+2HeifagZmjp9eFk9cmS5M
DoT4w3YcDvpTAHega59l945/TGWLJdnDo1ElQGcAbFTnzWjP+B8P5m167vyzCKym
beweYVDZ3Fz4kGuMFIato7bBwtoOlti56gaNsdFl5kmsxQlK8789z0mgp69bFrG0
2Oc6TQOeexZKFA3RL5G6Z2t70xdLo198p/KY2POCPphNPM93Cb37Q49mSoH6gG3C
9y+oQZTFh/VDT7OwtTwaIHJhAugQ+zRtkUC0qYmlgWT0cKeHyNod2ObrGv4AfIdh
LMpENEJNe9VxMqjwCy52
=s4ry
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
