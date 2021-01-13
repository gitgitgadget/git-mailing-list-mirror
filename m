Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DFEC433E0
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 17:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E44FB23370
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 17:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbhAMRnC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 12:43:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21212 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727998AbhAMRnC (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 Jan 2021 12:43:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610559695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=IbypQFshSl+0930NSjfhBXAow8ynZXKqhe73tu0S9As=;
        b=X6ah6ICnfAnDgrn54owV92vM9ShjN2cg8+eqKfAIrwu/Q4wrPGbrUqfxHcQxmm+5EYqumO
        2u7RYhuK987hlqsu1FxILSjp/GJZMu6gUyfC7Gz+i+5ydhLL9TIEwR3DiOPVpNjTRpezxP
        Pd/IQR9zZGQ2xwbT6tnwvx4yYY8uYWo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-VeS36MJkNYyEJ7qK6jXwFQ-1; Wed, 13 Jan 2021 12:41:32 -0500
X-MC-Unique: VeS36MJkNYyEJ7qK6jXwFQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FA3119611A0
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 17:41:31 +0000 (UTC)
Received: from [10.36.114.92] (ovpn-114-92.ams2.redhat.com [10.36.114.92])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 98DEC60938
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 17:41:30 +0000 (UTC)
Message-ID: <e2dbe996f6a7285fe0487e34d65eccf712867547.camel@redhat.com>
Subject: [bug] git-ls-files sometimes does not list files with pathspec
 magic ":(exclude)"
From:   Thomas Haller <thaller@redhat.com>
To:     git@vger.kernel.org
Date:   Wed, 13 Jan 2021 18:41:28 +0100
Organization: Red Hat
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-bjpK6kouL2JWG9llgzhn"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--=-bjpK6kouL2JWG9llgzhn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,


It seems git-ls-files has an issue together with certain ":(exclude)"
tags.

For example, on NetworkManager's git tree (top-level directory) I run

  git ls-files -- src/platform/ ":(exclude)shared/n-acd"

which wrongly lists not files. It seems to be some
relation between the exclude and the search path because a different
path/exclude does not exhibit the problem.

I also tested current git-master (72c4083ddf91b489b7b7b812df67ee8842177d98)
which has the same issue.

Here is a reproducer (in a container run on Fedora 33/x86_64):

  podman run -ti alpine:latest \
    sh -c '
      apk add git &&
      git clone https://gitlab.freedesktop.org/NetworkManager/NetworkManage=
r.git &&
      cd NetworkManager &&
      git checkout -B tmp cd754680a6a0e35b286d4157269053ccc3996a32 &&
      echo ">>>>>>now BAD1..." &&
      git ls-files -- src/platform/ ":(exclude)shared/n-acd"
      echo ">>>>>>now GOOD1..." &&
      git ls-files -- src/platform/ ":(exclude)shared/c-list"
      echo ">>>>>>now GOOD2..." &&
      git ls-files -- src/platform ":(exclude)shared/n-acd"
      echo ">>>>>>now GOOD3..." &&
      git ls-files -- src/vpn/ ":(exclude)shared/n-acd"
   '

Note that only the first call in the reproducer has the unexpected
result.


best,
Thomas


--=-bjpK6kouL2JWG9llgzhn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEESep8Zw4IUOdBlRT2KcI2bk38VygFAl//MMgACgkQKcI2bk38
VyhpfxAAm0ewT/FMFHKSjMH6VmhU0lFhBtzi7y9tRt0+y+TT7lBEszoy82dwhqVe
IigBCIrGqFXIXrhq0BsKLbW3rRLx6l791alVd5FoontswyZ51LaLWyCKj2+Ys/zl
PVWKpfW6WeO37lKSF312lnRXHtgauLvvmJdCN22iXK8TPUFfwG94y4gpIeVC8roo
r7kInGQ5oOmG06tAc2jq4Ey1WexqIECUdp6Yi9AeDW1IKmNMFNbimvq+t0HMC7qi
U34MIu57pq7p1W5oHMz0RsaqITtUEns19iQDpTwa+BhxgM0psoNhK7PPFlYstdg0
P7r8cuc+DezlEADP2TvfXSX/0I/gQBARCqrpHcu1f7PRJYZUTCB/jsSGiZHqLRp1
ooOVy5EFG8EkhuZrhOlgRMC8KKyJor/bkMyJNBar3Xad4zUcfG2fwqi/fmYteFUw
7PAtyw4rAK0sQZmqaXrA2u9aMsvRTgL9ZH0AhaNEE5HPLUGERWNgUzjEWJDbSx3d
yXyu+Y5GC5jeBGj0gciiuG/r7COtm9EpCKGTieXBu5tkt4xWNo6A3Z2jbn47dYxU
mE1JUoW7cvjGBc0JyPrue6PYhwbT0gm4SjpKhovFyqEFnpfyVFTckdGvRoS+UcgI
qI5kNv38X4c2SOgfVB6BNPYHHyUAlU5kmu3mlyLweYBethewCeQ=
=aifL
-----END PGP SIGNATURE-----

--=-bjpK6kouL2JWG9llgzhn--

