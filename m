From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [RFC] Improving compression in git network protocols
Date: Sat, 13 Aug 2005 20:22:42 +0400
Message-ID: <20050813162242.GA11609@procyon.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
X-From: git-owner@vger.kernel.org Sat Aug 13 18:24:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3yme-00008t-Jo
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 18:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbVHMQWy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 12:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbVHMQWy
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 12:22:54 -0400
Received: from mail.murom.net ([213.177.124.17]:51890 "EHLO ns1.murom.ru")
	by vger.kernel.org with ESMTP id S1751353AbVHMQWx (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2005 12:22:53 -0400
Received: from [172.17.7.8] (helo=procyon.home)
	by ns1.murom.ru with esmtp (Exim 4.42)
	id 1E3ymZ-0004x7-Sx; Sat, 13 Aug 2005 20:22:51 +0400
Received: by procyon.home (Postfix, from userid 500)
	id 8449BE3CF1C; Sat, 13 Aug 2005 20:22:42 +0400 (MSD)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

The git pack format has two uses:

1) A space-optimized format for local repository storage.

2) A compact format for transferring repository data over network.

However, these uses have some conflicting requirements, and currently
the pack format is not as optimal for the task of network transfer as
it could be.  In particular, because using pack files in a local
repository requires random access to the contained objects, all
objects in the pack are compressed separately, which negatively
impacts the compression rate.

I have made a patch which adds the "--compression-level=3DN" option to
git-pack-objects and tried to look what kind of improvement in the
compression rate we can get if we compress the whole pack file instead
of individual objects.  The patch is in a separate message, however,
I'm not sure if it should be applied immediately - currently there is
no infrastructure for using this option, and maybe we will choose to
implement the same idea in some different way.

Here are the results of my tests:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

1. Packing the whole linux-2.4 repository (13390 objects):

-rw-r--r--  1 vsu 159632105 Aug 13 17:12 pack-0-ef502d3d97088a8b1da4594fda4=
38c268dc5c692.pack
-rw-r--r--  1 vsu  30878501 Aug 13 17:16 pack-0-ef502d3d97088a8b1da4594fda4=
38c268dc5c692.pack.bz2
-rw-r--r--  1 vsu  38035157 Aug 13 17:14 pack-0-ef502d3d97088a8b1da4594fda4=
38c268dc5c692.pack.gz
-rw-r--r--  1 vsu  37739041 Aug 13 17:17 pack-0-ef502d3d97088a8b1da4594fda4=
38c268dc5c692.pack.gz-9
-rw-r--r--  1 vsu  43035924 Aug 13 17:12 pack-9-ef502d3d97088a8b1da4594fda4=
38c268dc5c692.pack
-rw-r--r--  1 vsu  43288931 Aug 13 17:11 pack-default-ef502d3d97088a8b1da45=
94fda438c268dc5c692.pack

The "pack-default-*" file is made without the --compression-level
option; the "pack-0-*" and "pack-9-*" files are made with level 0 (no
compression) and 9 (max compression) respectively.  From this we can
see:

- Using maximum compression for objects in the pack provides little
  benefit - about 0.6%.
 =20
- Creating a pack with uncompressed objects and compressing it with
  gzip gives a 12% improvement over the pack with compressed objects.
  Using "gzip -9" at this stage gives about 0.7% more compression.

- For an offline compression, bzip2 could be used instead of gzip -
  the pack compressed with bzip2 is 28% smaller than the pack with
  zlib-compressed objects.

2. Packing the whole linux-2.6 repository (67111 objects):

-rw-r--r--  1 vsu 232977930 Aug 13 17:47 pack-0-af8d554c2a184c1ebbaab13a8f8=
44329bcbfe763.pack
-rw-r--r--  1 vsu  49245784 Aug 13 17:52 pack-0-af8d554c2a184c1ebbaab13a8f8=
44329bcbfe763.pack.bz2
-rw-r--r--  1 vsu  59767656 Aug 13 17:49 pack-0-af8d554c2a184c1ebbaab13a8f8=
44329bcbfe763.pack.gz
-rw-r--r--  1 vsu  59323808 Aug 13 17:50 pack-0-af8d554c2a184c1ebbaab13a8f8=
44329bcbfe763.pack.gz-9
-rw-r--r--  1 vsu  70067732 Aug 13 17:45 pack-9-af8d554c2a184c1ebbaab13a8f8=
44329bcbfe763.pack
-rw-r--r--  1 vsu  70415173 Aug 13 17:43 pack-default-af8d554c2a184c1ebbaab=
13a8f844329bcbfe763.pack

- Again, --compression-level=3D9 does not help much - only 0.5%
  reduction.

- Using gzip on the pack with uncompressed objects gives 15%
  improvement over the pack with compressed objects; "gzip -9" does
  not help much.

- The pack with uncompressed objects compressed with bzip2 is 30%
  smaller than the pack with zlib-compressed objects.

3. Creating an incremental pack for the linux-2.6 repository (743
objects):

-rw-r--r--  1 vsu 4270645 Aug 13 17:54 pack-0-8d2c7fe3c00288d4a46fe25a61db3=
5ec965db8a1.pack
-rw-r--r--  1 vsu 1068277 Aug 13 17:56 pack-0-8d2c7fe3c00288d4a46fe25a61db3=
5ec965db8a1.pack.bz2
-rw-r--r--  1 vsu 1221308 Aug 13 17:56 pack-0-8d2c7fe3c00288d4a46fe25a61db3=
5ec965db8a1.pack.gz
-rw-r--r--  1 vsu 1214597 Aug 13 17:56 pack-0-8d2c7fe3c00288d4a46fe25a61db3=
5ec965db8a1.pack.gz-9
-rw-r--r--  1 vsu 1314817 Aug 13 17:55 pack-9-8d2c7fe3c00288d4a46fe25a61db3=
5ec965db8a1.pack
-rw-r--r--  1 vsu 1319322 Aug 13 17:54 pack-default-8d2c7fe3c00288d4a46fe25=
a61db35ec965db8a1.pack

- Once again, --compression-level=3D9 is next to useless - 0.3%
  improvement.

- The pack with uncompressed objects compressed with gzip is 7%
  smaller than the pack with zlib-compressed objects.

- The pack with uncompressed objects compressed with bzip2 is 19%
  smaller than the pack with zlib-compressed objects.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

As you see, compressing the pack as a whole can give noticeable
improvements (less on smaller files, more on bigger files).  Now we
need to find a way to use this:

- For methods which use git tools on both ends (git-clone-pack,
  git-ssh-pull, git-daemon) we could just create pipes to gzip/gunzip
  in the appropriate places.

- For non-git-aware methods (rsync, http) we still can use these
  improvements, but there are additional complications because of the
  pack index file.  We could have globally-compressed pack files in a
  separate directory together with their index files, and write an
  utility which will take a pack file with its index, recompress all
  objects and produce a pack file with compressed objects and new
  index.  In theory, we could reconstruct the index from just the pack
  file alone, but this procedure may be expensive (it will need to
  reconstruct all objects represented by deltas to find their hash
  values).

BTW, it could be possible to improve the global compression even more
by optimizing the order of objects in the pack file (currently trees
and blobs seems to be intermixed).  I did not try this yet, however.

--=20
Sergey Vlasov

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFC/h5SW82GfkQfsqIRAkxwAJ4rx8PGTuxu8YXcwzfCYZ6EA1DVQACeK29j
GOIKi3ahI89w0FaRIQIrjks=
=AOsi
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
