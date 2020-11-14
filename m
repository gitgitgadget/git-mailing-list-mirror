Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB20C5519F
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 18:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73D7D2225E
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 18:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Zu5aGVAy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgKNShJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Nov 2020 13:37:09 -0500
Received: from mout.web.de ([212.227.15.4]:58867 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbgKNShI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Nov 2020 13:37:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1605379023;
        bh=XlpB1iGKC8r+OGd0uncF32ni5f1S5BO6dZck9erq7Qw=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=Zu5aGVAy1s5Ayq6nAsGUAZ4PvNXK3N4jYkdTvGNvO1tIeVpIeYSQdJkTSLRYlpiFY
         7+u7/DTBHtODh5AP9rprBuJ57B/+2TUbtoqVJ9OfnPx/pR1WIo8oVZXO/ITYTRxms6
         pRxFTeJ4Nz0bVbR7Ie0RfINaXnITzNVfg0YbuGAA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.17.45]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MBjMO-1kYU793Kf6-00CCYR; Sat, 14
 Nov 2020 19:37:03 +0100
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] diff-lib: plug minor memory leaks in do_diff_cache()
Message-ID: <80fb4a2a-992f-7d3b-9413-5059da3a8f01@web.de>
Date:   Sat, 14 Nov 2020 19:37:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zGJTlUfHLV53Ek5I4gpUIk+yPUQce30NybZP0cYyRiXW6IHXD6M
 pLtdcIXNh7S7q76oFLRR28IYEEYfsnX/o4AfVBWjWyRqV16enZh/XKKmrUaQVVA7WTXGZVO
 VBkT4kij/DFP9j5GNC5QBXDH1Z5x23e5/valatfZQ1zaU0IB9wh2EoJCRPUfu1DbBJ235og
 9b5tShVPmORMpYZz2ph9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gccV0u+l2AU=:1r/CD8+brTcPLiHiP+mMpM
 Ltve4tvgV+YbYOSSivjFwXSWmlB4ccoih4A1XZa/ABRsqQMbn89rnwYpzaHJoRLaKJnQ2bmlr
 dDqwl4LDEZ1ZoLePHqhRJ6AzZ1U+pTBZ96NFvbI6sCupbJxUSjp4NwXjvk96rh6HlfCerjA7W
 E/GHPtpoTOtb1d811vQ75QCOigqJZCPO+FBnJ2JQ8mZY7Y67UhiVA88Thsfk8tUw2IhZQyknF
 qRcbfrACB3DtpHN68yFdYSnLhHRBfhU2LNioKLNGtAkIL5wi3HT6FE8RKJZPK+1qswpwJ/3vc
 /dAz8j+2KCLXLRx3mMKZIFZUh1DZyqCZrBfd0MCbJbPPGAas5pBSnxcdnWEHNpfgCjIjOqxhM
 zjxJ4sua3OUwuEHIWPEuJF2tdSVVO9X030ue7liRyaVWj6vTYNoWKIE9yM4oVftduj6YXU9Wm
 tWaqtAZ1AIquyMRjqZ9VWkuAqnFjUl0AA5s5ezyMmiow1aVLTp1w3JNaFN1506vKwBtTtdkCW
 zmU2cx0Pc9YDAbIyxemtJSwZZryramxqjwl90uF15YPDCDgzLdYGJsW+199fnJEZP9KIB5cE2
 NsV8SEodiDrmsqV0wviBVZP7d+Cfwp8NWg0ul7Ml+T9Ba/c08MVUyrz9ID66jxpuP6PIDUJPI
 Jrf9eegIWxjE37RmF/vG7au4/zkBTgy4ZPMMeJKLVRROPfshZMI3Y9nm1c3NUkIYxLUAlmc1+
 RYfWg5sveCH+OnDoG/NihfESgywDzWJN9asqGHxc3FqL3SZa+Sb+pk2KoAihR1bb/1i3IYFPN
 2+fz8hjeSzV79rcAz3Pz4pnnmQdnegk0MT4igWLdvTgv7cp931c1lPwSPTDcTAypR/KwUwyS4
 nQPEWLBPSaomFONU33eQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

do_diff_cache() builds a struct rev_info to hand to diff_cache() from
scratch by initializing it using repo_init_revisions() and then
replacing its diffopt and prune_data members.

The diffopt member is initialized to a heap-allocated list of options,
though.  Release it using diff_setup_done() before overwriting it.

The initial value of the prune_data member doesn't need to be released,
but the copy created using copy_pathspec() does.  Clear it after use.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 diff-lib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/diff-lib.c b/diff-lib.c
index 082e249fc3..b73cc1859a 100644
=2D-- a/diff-lib.c
+++ b/diff-lib.c
@@ -606,10 +606,12 @@ int do_diff_cache(const struct object_id *tree_oid, =
struct diff_options *opt)

 	repo_init_revisions(opt->repo, &revs, NULL);
 	copy_pathspec(&revs.prune_data, &opt->pathspec);
+	diff_setup_done(&revs.diffopt);
 	revs.diffopt =3D *opt;

 	if (diff_cache(&revs, tree_oid, NULL, 1))
 		exit(128);
+	clear_pathspec(&revs.prune_data);
 	return 0;
 }

=2D-
2.29.2
