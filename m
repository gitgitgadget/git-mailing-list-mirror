Return-Path: <SRS0=BZy3=CN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F91C52D6D
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 18:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8219225372
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 18:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="KnKqp4hM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgIDReE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Sep 2020 13:34:04 -0400
Received: from mout.web.de ([212.227.17.12]:34249 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgIDReD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Sep 2020 13:34:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1599240838;
        bh=th+ztNrkvD4FWRDp/HMYuSRXUbqfrC/v7PV/c8Nx24U=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=KnKqp4hMPNe/xveDUnXFw3EJ4AONay2emNR9HqVOUpcmTh4wmJmGZrv2f57+0QRa3
         2s/jzor3X8VHRkTu1mtktRjKLHOzvcPfXcoj/TMFd8h5rXrc0pCvRQqQnvBjsnBV3l
         ONB+8TaOz/euLMQuPzBhGXJeO6stfvvFr0242l0A=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.149.245]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MSJGB-1k7GPN3Dsx-00TRFK; Fri, 04
 Sep 2020 19:33:58 +0200
Subject: [PATCH] read-cache: fix mem-pool allocation for multi-threaded index
 loading
To:     Sandor Bodo-Merle <sbodomerle@gmail.com>, newren@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <CABLWAfQhWUSUS8p2XoGcNMUAp-vatD+-pDMngiJJW5qHG2CYCQ@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <dbccbf13-9ebb-2464-4325-cac4c7767f74@web.de>
Date:   Fri, 4 Sep 2020 19:33:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CABLWAfQhWUSUS8p2XoGcNMUAp-vatD+-pDMngiJJW5qHG2CYCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0eT7ykbDYjzFEXh726y/J438IwvwbvufF4nSig0TKN9NqYI+r4U
 mJ+6VeLYSLL2l7jYqNDH+WSXMML5vt50L1C5S0TifqT73daZm2PXrik8ylm3jr6CCXOa9Rv
 QvvpHoVJCgSChXXf4snlczcGJM71FHERmjtf0GNOy0dxvp9X/X3E1n7BrMAMfmbbTvv7Yyb
 ib1UqIQm94oasQIyW5W1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:j10N6kB5YwI=:NC42E+QCN78OR/hW8oSdZ/
 aMEKsk9clICr1FkeKpGHVwU+IeR+TQD0JgtTlwFZ1+gc+2BeWjJoATJExrmJrG6gdideE57lt
 HHPxRfE4IGgMH1OrQ6Wilw9tVaqQt2nnzhfe2RvHAY1/oS16pG1OAkXAagvM4vI3lillgr8SO
 YuCifCOCFsxAFlpn5iKP/pTHWdTDPrrVDv51MVqPUi9iR+HILhnw3s2qYd0wT/fvRjhhg6seX
 FfXM8YQdezH3y8hSIxH18yyt+cLCNflVtkG1JK90VBHgmOrtettmc7kKyFRW1zVR2P/jFK0/k
 EX9MkUMuQfXgQhM3AwbwUa0Mfj+M3I26QXgTNf6tglRdL0Nyzrw/xFlyDUIyKMGuv3AopnMYY
 RM5pM3hDtL6yegej5E8eeTmpkOVbDPuEY5LnRdFObPYvfolnhk3elvI4+1VkrmiUm5Yo/I5f6
 G+eHFLvZMru7ztxHXfNzGO59Ua9wn3WDAvYGYm/7ggfJt0rLHlGeJf7SpVUIo5kMebrkb0M1/
 cfSAa0YlU7geoeLqqePJYLo6mZRju9pvWn4cbR6qPqmMuLSLa4Hb/2VT0G6t5tx3M8HbJFgaK
 LoTJW/ZeRDfN2QMTX7bGDYoUtK4Dcb+TorTou9ocohF0WttTCJ8j1iwjyq+Y+j1herbfNgw6P
 p/q53eWDw92xueRVNKtmcL27qHqX4BHPcuOGCpvRo9pqXstUluMclmKyL1G2hhCfgRsAyxO4f
 1UzdXF9/l5USXOzI2khV0tXvtVWU18zCxJTPym85h4MXItbvulvGoXP6qWGJqGcoGMqw8eNB+
 z+HN4l7A9QjODGfyPu4eKPfmESLZVeckBbti2Ks49uwx0GLt/1CeC0DI56vIb42359jqfjCAL
 m4/UZewVlORy4r4sfwb8zo6xh4Glasse/37SgXYZF8xCINoUaeJ4MYEOHzB6xDQEN6bElGVNS
 VTIrqZUA2SEjncSDkwqDFPOZ6EwjrlQAWj+b91sisz0BzGF/wDyFnuYu2X9fUk7EY03kuYgly
 DwUrION3nQLz0FbjO9oAX0aSqRfK1ZVh64eQbaEaaGuxalQmA0d+XcxSVWeohs1PNQJy5v9iI
 8e8onpDM2EOskyJElG/CqcGy4i50/hv+sxgOhC5rPp/w0Jt+AfGk64fUTiaHiIpMdX2MZdXb7
 nQq/0bZxEMnpBKGd+G7njEbA313kj+d/ZlHHdI6njy7PiEnj2Kh9ZpnWpSj71ZAUWOlysfjmB
 LNWrdqwtePs3YV5a/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

44c7e1a7e0 (mem-pool: use more standard initialization and finalization,
2020-08-15) moved the allocation of the mem-pool structure to callers.
It also added an allocation to load_cache_entries_threaded(), but for an
unrelated mem-pool.  Fix that by allocating the correct one instead --
the one that is initialized two lines later.

Reported-by: Sandor Bodo-Merle <sbodomerle@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
"GIT_TEST_INDEX_THREADS=3D3 make test" passes with this patch, but fails a
lot without it.

 read-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index fa291cdbee..ecf6f68994 100644
=2D-- a/read-cache.c
+++ b/read-cache.c
@@ -2101,7 +2101,7 @@ static unsigned long load_cache_entries_threaded(str=
uct index_state *istate, con
 		nr =3D 0;
 		for (j =3D p->ieot_start; j < p->ieot_start + p->ieot_blocks; j++)
 			nr +=3D p->ieot->entries[j].nr;
-		istate->ce_mem_pool =3D xmalloc(sizeof(*istate->ce_mem_pool));
+		p->ce_mem_pool =3D xmalloc(sizeof(*istate->ce_mem_pool));
 		if (istate->version =3D=3D 4) {
 			mem_pool_init(p->ce_mem_pool,
 				estimate_cache_size_from_compressed(nr));
=2D-
2.28.0

