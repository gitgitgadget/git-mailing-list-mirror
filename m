Return-Path: <SRS0=tECa=DD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD9EC2D0A8
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 08:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AB4721D94
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 08:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="GXJ0UfFT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbgIZIhw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Sep 2020 04:37:52 -0400
Received: from mout.web.de ([212.227.17.11]:34181 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbgIZIhw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Sep 2020 04:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1601109467;
        bh=vPB1y8sQaUostgUP88aZe0xmLM58Sv2GW5MGZcNYM7M=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=GXJ0UfFTrm2QLGKvmH7VNjfXdczHkr5hjLXsT3uEFoD43qAr4flHC6EyAABWVvk6S
         tLSx9TWuezJD/awm0ybq4x+ltNBA459QiPdhK8nDHIcDHBniee2sTlvbymqLyVyoD5
         OdIGDkuW9sdMnbwhPb+dP5Y4bzgth83s6+g60txY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.149.245]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MFc9x-1kGoG61XBF-00EfUt; Sat, 26
 Sep 2020 10:37:47 +0200
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Aaron Lipman <alipman88@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] ref-filter: plug memory leak in reach_filter()
Message-ID: <d9922bbe-4e34-45fe-66a5-d7b5bf42117a@web.de>
Date:   Sat, 26 Sep 2020 10:37:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Tw+KvaCL4H6UPnl+dBdGLiJQsWwSSsnt9nT0mVyaQL/7xlPNxAs
 UNskkxv/oo9W1l6ThT5MYayxc8gBinhUwuWB5ec7Qyx8kOJewiIhpOAESlf2ogdr+l9ew86
 wMkwWWjRrUceIGNyfriL+6N5JrdBlR1W66tIst3ALZckm0Ps6yKW3UmxZqCHYXMWDTuHAML
 /jtyqTUPAfYAmP19IGt8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mGYujx7hMvU=:37RHn8IwlsEt4I7S4NHSSQ
 zvsJGPPuybnaxuntSRVPiDnQ9YYg5HrOjbRSDylS+yV4v/lr93UPzM64uSDZsAWNbmrs+wyAf
 zfIZ7nh82bBJy0jMxU1yLhkDJK9xnHMadsm0FaGcW1YMkv2BEolIYRLfu50PvMloz+chV6a8X
 gc1SisogJlJBSaqck2CbW4XwV+RNRoyPTCzKwomieczyq3KB755OZHB4WSH5qKFmuF5DOHWU+
 l1CjVrS2kXei35sg2rp5noO4kyLeuvLif1tJJX1CNj43t8G7q3uwXoVXNNUCX+qvcp8QF7dDg
 aPXVEUGX324zRNg9H2+6PG2JnEfxtB4nRklAo9/O0OSyTbkyfZYKWJjk5VMQnYmAXQ4EAjfbw
 P5Pqg+BH3BE6C/mF19dorgxtZluTZy8/DBc95ni5uV/z6I+peyu7tInVoT6nwIEFarCphlnsZ
 mRwsCrgkXS3LzIsCBmC2QZG8f6hjNuvnexagkCXYQSWLko6JGubxjtsbbyoTvMXLg5xOOQbjn
 zclpUGzKNn+mqqY37XUhTzORYPVCfyl9CFgeOgUXaUrPsrZPjHiXhx/nE0SxYmswwu8HBaJ4z
 s0EuBfErS4q5+xupFHmhOyY4GjQxVS66+Qrf/4UbPefecYhAQm1RAuz8UhJ6kdGT75jrk5G0u
 sF01+x2vqyeQzufSMr4Y6muX3TZRfPwnwsKcQKuUXR1X5BkSizzHaCHlRk8NYFPQVdQyeYjan
 EaWAMSX2NHbbo859gI1fkcsstl98AYatVNHjONBwfUhiehZ9wLYa9QbyOBdYP8BuE8Vja3dSu
 UEbDucpuvw9/+THwq3fzqyGH1GnVtbB42I583z/LQZjVreNs2WyPHLzYdDvaDVqD/5E2+SY4l
 xvpJka1PKnTn0hNgMQR1VYGE3NeXCellkv785CXoJnEegRzC1m095ejaXhjfWeES6ctloTpJV
 jYREJVh9O1zkunQkzqg0d9LbNhKvHWCJmuiiGGD5K7b1i2XN/zGlJViQak4kY6kkB3GagoatU
 dGGomPCXUz7/rzOrBEbYwE8SREemRyQxT+/wb6JMQqoHaoqB0MOCT14VVikvBFSG6qd+kOLFT
 BES5JYl5vPxlZ1y77Lxkgo/A0iT789XKUs1PPg5rPK8m1yi/Wfsu11ZmE5VjmtKto8T01b2fV
 6gd6FWK0BvoaRgaDrQw7ZzuOkp5+vOTx381NN/sA2gSFnYPYDJcVx+gdkY0Ay5qnMNrmwg6j9
 aiclFMBp7+3fojxr/
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

21bf933928 (ref-filter: allow merged and no-merged filters, 2020-09-15)
added an early return to reach_filter().  Avoid leaking the memory of a
then unused array by postponing its allocation until we know we need it.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 ref-filter.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index 5550a0d34c..e0b8cd3ed8 100644
=2D-- a/ref-filter.c
+++ b/ref-filter.c
@@ -2239,12 +2239,14 @@ static void reach_filter(struct ref_array *array,
 {
 	struct rev_info revs;
 	int i, old_nr;
-	struct commit **to_clear =3D xcalloc(sizeof(struct commit *), array->nr)=
;
+	struct commit **to_clear;
 	struct commit_list *cr;

 	if (!check_reachable)
 		return;

+	to_clear =3D xcalloc(sizeof(struct commit *), array->nr);
+
 	repo_init_revisions(the_repository, &revs, NULL);

 	for (i =3D 0; i < array->nr; i++) {
=2D-
2.28.0
