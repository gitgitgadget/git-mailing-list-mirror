Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD2DC4363A
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 22:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A13D320829
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 22:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1832195AbgJ0WFG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 18:05:06 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:40116 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1832196AbgJ0WFF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 18:05:05 -0400
X-Greylist: delayed 594 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Oct 2020 18:05:04 EDT
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id CC05233D3C7
        for <git@vger.kernel.org>; Tue, 27 Oct 2020 21:55:08 +0000 (UTC)
Received: (qmail 12893 invoked by uid 10000); 27 Oct 2020 21:55:08 -0000
Date:   Tue, 27 Oct 2020 21:55:08 +0000
From:   "Robin H. Johnson" <robbat2@gentoo.org>
To:     Git Mailing List <git@vger.kernel.org>
Subject: Bundles: Partial Clone & Shallow clone
Message-ID: <robbat2-20201027T175013-504497035Z@orbis-terrarum.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XT04jg8auJPqQyeH"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--XT04jg8auJPqQyeH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I was wondering if anybody has made a start towards easier ways to
create bundles of partial & shallow clones.

I'm looking at potential ways to improve the various snapshot &
incremental update mechanisms that we have available in Gentoo Linux's
tree distribution.

Right now, the various mechanisms available are:
- git tree WITHOUT generated metadata (git-daemon, smart-http)

Plus all of the following WITH generated metadata.
- git tree (git-daemon OR smart-http)
- daily full snapshots in several formats/layouts.
- deltas of full snapshots in some of the formats & layouts [1-day interval=
, no rollback]
- rsync:// tree [30-min intervals, no rollback]

Offline/Air-gapped use cases presently are expected to use the
snapshots+deltas, but the 1-day cadence is longer than desirable

Several of these formats cannot rollback unless they kept the old tree
or the snapshot it was generated from.

rsync:// performance is heavily impacted by network latency and large
number of small objects being transferred.

What I'd like to offer instead, is CDN-replicated bundles generated at
regular cadences, with the absolute minimal content; taken from the git
tree WITH generated metadata. The git tree would have tags for every
cadence point (ideally 30-minutes, with potential pruning of old tags).
The bundles would have GPG-signed checksums separately included, to
provide verification of the updates.

These come in two variants:
1. Daily full snapshots, equivalent to depth=3D1 clone.=20
2. 30-min & daily incremental bundles, using partial clone (needs to
   include the new blobs that would be present when up to date, and
   knowledge of which files can be deleted).

This should let users load some consistent set of daily or 30-min bundle
onto their gitdir, and hop between those tags [they would not have
gaps].

If they did have gaps due to a missing bundle or wanting to go within
the cadence points, and were online, they could use the partial
mechanisms to fill in their tree as needed.

Right now, I can naively generate the snapshots by explicitly making a
new detached shallow clone & then generating a bundle of that.=20

Incremental bundles are already possible, but presently include all
commits, trees & blobs between two points.

The bundles are already generally smaller than our prior snapshots and
deltas, but I'm looking to make the process easier and cover the
remaining gaps [if we have a high-change period, then the bundle winds
up bigger than other deltas, because of the intermediate blobs].

Ask 1. Ability to generate shallow bundle without the intermediate clone st=
ep.

Ask 2. For incremental bundles, ability to exclude blobs not needed by
       the latest commit (and it's tree).

Both of these I think would be possible by adding some variant on the
--filter mechanism to git-bundle.

--=20
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136

--XT04jg8auJPqQyeH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iQKTBAABCgB9FiEEveu2pS8Vb98xaNkRGTlfI8WIJsQFAl+YlzpfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJE
RUJCNkE1MkYxNTZGREYzMTY4RDkxMTE5Mzk1RjIzQzU4ODI2QzQACgkQGTlfI8WI
JsQqGhAAvBOqDxkR8f9DszqhYXeZEtb3sPZUumn0ZibOHkOOnKOWgr0wzv9dJuTU
EBKDQnWMb3eYaFKHU15ZK7ZITF0zPy8syaEXMbguz4ki4gRAfMwFQg71BVhRaMnU
Q4wDKaSJf0ikC03utdoFcVIc0tSJzKHSAMo7E0CpCcDcULxKmZceswkUe/y6qyMA
L+HIymbQ1uNs+/khqWNMBDMjLPgw1sx5x+1KpnFXeRFqinJzYTp5mqCGnJYbvjdo
ezGaifeu1db6Cy03CKVdzTk0lxW8sIkbCng0OU8DB5qsq/Qw6tA3YjEFt/u2jJHa
a5P0/BAYyUIu/U94bQ4cYt7uP8Uoi+vta05cHHFo3RV7DKjTb0PkwdZIwwRFAXR9
MZtFKL+TtPpTjwKvuxvVahpQRrV7Mkm8KOwnILp1SV5YKE23MudyOYSW9beDV8cn
sQb12zamB+WgjirfhkHZafXVmYA3J+yhaVilkLjOJeNHV0duZ1YDh8LeBSGIdfis
59Pu4Zxj2hvrLEKKgac5TK4ufF/KQ7mbMiIyIXyovkp5rW1iO0PiJSoSF6zKheJQ
fPAEFJ4JDit/+J6bvkCZSecoX82s0kOjcoR737vG98ePjcIy3ijjStG7h0ChRTzc
VGaBZR6hVbNtfU+JgvE/+QWyWVRPX02fHdoJ7DQ2MtXJzi3v/dk=
=MDBL
-----END PGP SIGNATURE-----

--XT04jg8auJPqQyeH--
