Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C85C433E4
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 13:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5620E208C7
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 13:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="AcSY2bDh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732501AbgFSNOJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 09:14:09 -0400
Received: from mout.web.de ([217.72.192.78]:39759 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730977AbgFSNOC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 09:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592572428;
        bh=Vy/xcX/JQ50b2cTl+AqrG7Y82XYaVKVN6suxAxUJojI=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=AcSY2bDhDGuec1hDnVviqRz3hFN5+HrtVBWIbnAhwGdRIRpU5OHLnKE7iykBTiQQJ
         KzykwOWnAP470SF+xZZBNI6b0Ha5omko/f2Pfo4XL4ujAxPAcLKJU9MAgyBqsNQy7/
         N7f4CvhPx0yAzhGSMlT8yAC0YqGkdt1BBIVkadFQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mkmvd-1j1ccm3bbz-00m85r; Fri, 19
 Jun 2020 15:13:47 +0200
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] commit-reach: plug minor memory leak after using
 is_descendant_of()
Message-ID: <ada13c16-d964-c6ee-80ac-626edbc5f52d@web.de>
Date:   Fri, 19 Jun 2020 15:13:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bMpjJDTLANoyzrk0f/OCQ5H1zp+oAQJiSQrZ3N1OpuKpELCrkEj
 m2OMiqzNmvS0dRdH3tRKWrBuM6c+N6xbOZFd9ySwhtb807Egi2ja/Ssbex6UFKm3NRy0jsJ
 WSKNd7IMkN3XAzKBt/bzX7JwDyhIP1By7ra+tmXDIS6iOTQRa6YGf3Ohu0BjNj72xKBZPMf
 I0/j0ioGEXs4Z1Iv1s1oA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RHd4UOUtANs=:FNL8Bg7S+n3ulU9swc7X+m
 T3nt6KUfJ+QmDuiNXBr/sYrVI+sy6YIc1xXLepUH9EJyrj0zWK+bbSnoT4vqf5BWbqGYrXnJX
 SSQL10Jrp7iRishdRm825QQyxR5K5+k8IV+5+o/obck9Iz9iiHO5IbZkmj1Vs1L/4c7HA+MhV
 3AbJOlfQuVxbGMqkXNNKJST0GIl2mj9oBPANtha5hYCjGnIMytcmnC5w99AZaCI4QK9Ua5Uom
 /qd1MC37b6NNiGugTu3N1WKiOqQWIDIDSUKS1Q7HFDRxi/WmbWfGXQhNXIekH0zMpoP9XryzF
 om+WIPsL+m2vlO2QncPBE1qWVm4nxoZ5aOaPgEPVTbvehzRbNaAStvJ1QzjhRZjwwMxcRj/Sj
 dUWbciFU9SCa0hs+LmhEF3CurwJFoYDHynO0Rb9l9jGryOT1axmTasUR1WKhcly71uQMD6rCv
 jIJ071bUPXeCeMBFPRdJGh2dPp+F12sVhTIhMaqa+Ma8bQKx0je4QpOIKxJM0/zwRuc7FI6iQ
 cpQd02PQVV0J5qv0UBIH9ztZoJ6SehARaHWfPS1Z32x5LJEW7ylCRhy993eNhXMi7N4YVG2ro
 f4qC35yz5MgI87TbMEv9FWcYWsxwgivkE7kqd9RBaZe8gYDxvZzSHat6eag8IMR9ryo14I2Cz
 b8u0Rw0/g/fWZr45qV1lvvYDs5uCzw3GzUTS1XR8AalwSoJtMsqyUcNSoXBKQlP4yHbuiGJNE
 7+6EMVca586GS+5GEushzMg4kTRbnYbqo9NOgMtr+C5iyiEU85a+Mnjt0G5NVdMCIYr0hxmLK
 L1Ln5aufyUGjUO/U3rvHu0DnYY4OWAp9O+DV+SIq/ACBSpKFDbc4y7MPze9LO7vgKlldfcUf/
 jfAXny+nIneYUcNxQl0i7FB7mVTcUzMqkcCO0mGK+OkZQR2pEUVufYcMQDYfBa8tp0u3TyeU1
 ugFcQUg1MF8KhZ3P6eJstA5yn9hETuPhp3J5Nzvf7LlDDG5lHh4kxFYMtrTP2XLG4P80G4VJ2
 YU7TasdnMYDiltDi5w4RX5uuz4i4egM5zwxPgL1IN4VFeeFdzwcIimFeSjoh5NitbjCC7diDI
 zhuvgE2rnly7BxJynCksIgYxlluJWbPYVL2IZNBFs0rdaWi++H/Z+zg/zzFlov16s8PJF+nSV
 RGMkA9/64VxHHpvIcOOU/G3SBCTp4gdZu/RsnJk84VRMN3Zk3OAEc3l0CCC+cE4ng6+1Q=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ref_newer() builds a commit_list to pass a single potential ancestor to
is_descendant_of().  The latter leaves the list intact.  Release the
allocated memory after the call.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
We could allocate the commit_list on the stack, which would simplify such
glue code quite a bit.  That would be dangerous in case is_descendant_of()
or some other function that is handed such a list tries to consume/free()
it.  How can we be tell a function is safe to be given a stack-allocated
list?  Perhaps by marking its argument as const.  Or by converting all
functions to arrays.

 commit-reach.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/commit-reach.c b/commit-reach.c
index 4ca7e706a1..6bba16e7b5 100644
=2D-- a/commit-reach.c
+++ b/commit-reach.c
@@ -396,6 +396,7 @@ int ref_newer(const struct object_id *new_oid, const s=
truct object_id *old_oid)
 	struct object *o;
 	struct commit *old_commit, *new_commit;
 	struct commit_list *old_commit_list =3D NULL;
+	int ret;

 	/*
 	 * Both new_commit and old_commit must be commit-ish and new_commit is d=
escendant of
@@ -417,7 +418,9 @@ int ref_newer(const struct object_id *new_oid, const s=
truct object_id *old_oid)
 		return 0;

 	commit_list_insert(old_commit, &old_commit_list);
-	return is_descendant_of(new_commit, old_commit_list);
+	ret =3D is_descendant_of(new_commit, old_commit_list);
+	free_commit_list(old_commit_list);
+	return ret;
 }

 /*
=2D-
2.27.0
