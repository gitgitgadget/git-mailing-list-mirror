From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Performance issue: initial git clone causes massive repack
Date: Sat, 4 Apr 2009 15:07:43 -0700
Message-ID: <20090404220743.GA869@curie-int>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jousvV0MzM2p6OtC"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 05 00:09:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqE3G-0001eJ-Q3
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 00:09:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbZDDWHv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 18:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751947AbZDDWHu
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 18:07:50 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:47036 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750877AbZDDWHu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 18:07:50 -0400
Received: (qmail 17592 invoked from network); 4 Apr 2009 22:07:46 -0000
Received: from tsi-static.orbis-terrarum.net (HELO curie.orbis-terrarum.net) (76.10.188.108)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Sat, 04 Apr 2009 22:07:46 +0000
Received: (qmail 16664 invoked by uid 10000); 4 Apr 2009 15:07:43 -0700
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115600>


--jousvV0MzM2p6OtC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

This is a first in my series of mails over the next few days, on issues
that we've run into planning a potential migration for Gentoo's
repository into Git.

Our full repository conversion is large, even after tuning the
repacking, the packed repository is between 1.4 and 1.6GiB. As of Feburary
4th, 2009, it contained 4886949 objects. It is not suitable for
splitting into submodules either unfortunately - we have a lot of
directory moves that would cause submodule bloat.

During an initial clone, I see that git-upload-pack invokes
pack-objects, despite the ENTIRE repository already being packed - no
loose objects whatsoever. git-upload-pack then seems to buffer in
memory.

In a small repository, this wouldn't be a problem, as the entire
repository can fit in memory very easily. However, with our large
repository, git-upload-pack and git-pack-objects grows in memory to well
more than the size of the packed repository, and are usually killed by
the OOM.

During 'remote: Counting objects: 4886949, done.', git-upload-pack peaks at
2474216KB VSZ and 1143048KB RSS.=20
Shortly thereafter, we get 'remote: Compressing objects:   0%
(1328/1994284)', git-pack-objects with ~2.8GB VSZ and ~1.8GB RSS. Here,
the CPU burn also starts. On our test server machine (w/ git 1.6.0.6),
it takes about 200 minutes walltime to finish the pack, IFF the OOM
doesn't kick in.

Given that the repo is entirely packed already, I see no point in doing
this.

For the initial clone, can the git-upload-pack algorithm please send
existing packs, and only generate a pack containing the non-packed
items?

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--jousvV0MzM2p6OtC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.10 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAknX2i8ACgkQPpIsIjIzwizVDACfZMUSxD0wyHdl75NREqFavCHL
ZcQAnRB8XFuywB7FlFFY64pxyV1t0HTo
=wux1
-----END PGP SIGNATURE-----

--jousvV0MzM2p6OtC--
