Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A0751FEB3
	for <e@80x24.org>; Thu,  5 Jan 2017 11:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935933AbdAELTK (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jan 2017 06:19:10 -0500
Received: from userp1040.oracle.com ([156.151.31.81]:31220 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938492AbdAELTF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jan 2017 06:19:05 -0500
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v05BJ3n7025297
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
        for <git@vger.kernel.org>; Thu, 5 Jan 2017 11:19:04 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.13.8/8.14.4) with ESMTP id v05BJ3Ok021575
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
        for <git@vger.kernel.org>; Thu, 5 Jan 2017 11:19:03 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.13.8/8.13.8) with ESMTP id v05BJ1iv018995
        for <git@vger.kernel.org>; Thu, 5 Jan 2017 11:19:02 GMT
Received: from localhost (/10.175.213.190)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Jan 2017 03:19:00 -0800
Date:   Thu, 5 Jan 2017 12:23:59 +0100
From:   Quentin Casasnovas <quentin.casasnovas@oracle.com>
To:     git@vger.kernel.org
Subject: Refreshing index timestamps without reading content
Message-ID: <20170105112359.GN8116@chrystal.oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Jbyekxk18hnEXT0m"
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Source-IP: aserv0021.oracle.com [141.146.126.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Jbyekxk18hnEXT0m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi guys,

Apologies if this is documented somewhere, I have fairly bad search vudu
skills.

I'm looking for a way to cause a full refresh of the index without causing
any read of the files, basically telling git "trust me, all worktree files
are matching the index, but their stat information have changed".  I have
read about the update-index --assume-unchanged and --skip-worktree flags in
the documentation, but these do not cause any index refresh - rather, they
fake that the respective worktree files are matching the index until you
remove those assume-unchanged/skip-worktree bits.

This might sound like a really weird thing to do, but I do have a use case
for it - we have some build farm setup where the resulting objects of a
compilation are stored on a shared server.  The source files are not stored
on the shared server, but locally on each of the build server (as to
decrease network load and make good use of local storage as caches).

We then use an onion filesystem to mount the compiled objects on top of the
local sources - and change the modification time of the source to be older
than the object files, so that on subsequent builds, make does not rebuild
the whole world.

This works fine except for one thing, after changing the mtime of the
source files, the first subsequent git command needing to compare the tree
with the index will take a LONG time since it will read all of the object
content:

  cd linux-2.6

  # Less than a second  when the index is up to date
  time git status > /dev/null
  git status 0.06s user 0.09s system 172% cpu 0.087 total
                                              ~~~~~~~~~~~

  # Change the mtime..
  git ls-tree -r --name-only HEAD | xargs -n 1024 touch

  # Now 30s..
  time git status > /dev/null
  git status  2.73s user 1.79s system 13% cpu 32.453 total
                                              ~~~~~~~~~~~~

The timing information above was captured on my laptop SSD and the penalty
is obviously much higher on spinning disks - especially when this operation
is done on *hundreds* of different work tree in parallel, all hosted on the
same filesystem (it can take tens of minutes!).

Is there any way to tell git, after the git ls-tree command above, to
refresh its stat cache information and trust us that the file content has
not changed, as to avoid any useless file read (though it will obviously
will have to stat all of them, but that's not something we can really
avoid)

If not, I am willing to implement a --assume-content-unchanged to the git
update-index if you guys don't see something fundamentally wrong with this
approach.

Thanks for any hints you can give! :)

Q

--Jbyekxk18hnEXT0m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJYbizJAAoJEB5Tt01po9cNYnwP/i3MAVFAysbm43nLrflu9D7I
xbwU/8j9xnlYTcTr3mmGcFoJ+Vx7vH5M6NWI82o1XVnU/efpYxpKUA7iEMmvhwyq
QjYA75rjJsg+UrF/ebP5PmaA2v1nqkkBvPfXvS0xl9g3USaw6kkL5/IsmSK0Dzci
wDPb7QnpM5KW67JVOG8RvJVstd1ZokANnqlKE1qibFUyqJvzZsfPJRaoNoY9ILsA
P3hoVnIcVMcPBSrV3+k3fXBN8QhcUio73qz2nW7bdeEKpl5VtFrakBZLPDLg3aho
4Mq4v8osLHx2PVxJ4zdYe0QWFHJzoQUMKtlOEBhRIrEGXNpEwx5IzxBaaotfSNj3
v2YpB9DCGuBpuyPPFBFICxSrQnQIFVgLP+GNNE3a61pglgWIt0tWeAfeEfy9Pkdg
6ge994Mn0PJeEK2MGKIS/fzkz7Bzn9RdSjQozH4UFwHSmkJdg4Ym+pYIo+HlA3aL
w8ajoxKs959I9ibp1zdydKgD1s6HlHlJIVdZBGjQU5ZwLYQm54fK97Raz6xv0YNG
so14CLmdJ8z0pGidzLne2eH1kYIxeIk02ryCWFj70/S/045eZhIrBmXo6NNUcM9g
OTyYUO1B9etbhZc0E0SQqDdL6Cn0p+8akfnuTAYAhM+Z3p/6e7MYxC/xkcV80wRn
AZf89bK9cYwpgq0PBuwK
=gbku
-----END PGP SIGNATURE-----

--Jbyekxk18hnEXT0m--
