Return-Path: <SRS0=XjWc=BM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFECC433DF
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 14:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ABBC20738
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 14:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="sEfDzvsE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgHBOik (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Aug 2020 10:38:40 -0400
Received: from mout.web.de ([212.227.15.3]:55415 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbgHBOik (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Aug 2020 10:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1596379115;
        bh=lq7Z4jwUeQzkoG7f7pFwuP71q1bgsiTnuyZqRm/AME0=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=sEfDzvsEP3rT5sxTVps2SU/z0XB4mtit755z6wTUb7GZpXCsg5lhEUb/iPGQq4lbw
         HqiPu8wJHEjgeIseaAvmTF84ohNhHnhH7HNVQt+COo4RtSB7zZvKKJort80PIJB5/O
         Ull4YPOggEfn3IkBeKzIoZvSBTqgdBPDyB6b6nI8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LotIZ-1khdIG1Tbv-00gmLq; Sun, 02
 Aug 2020 16:38:35 +0200
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] connected: use buffered I/O to talk to rev-list
Message-ID: <2e2907ac-3be9-c0ed-830a-f8aa28b471aa@web.de>
Date:   Sun, 2 Aug 2020 16:38:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HP71SYYm8o5rNPOCMI6ajVTvNAWRujEIyFrsTWoZBm85YswsIFs
 a8L+z0wXtuTILkiLSM0zloiiFN1XnuwLtpWESJ6pZhP2vYb2tjWD8Z/nFq5IE8lFuPv8obZ
 XwGpCQ6sh9HEjOXNR3q08CsDC+JiAKvDwJupM9engi1uc01d4mvPab/SCSQz5iDaxV9aGgi
 b/Y+rMhZpcKWbgHqbWcIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y89jtUOT54A=:KAAcyKAsitfEmdj99cBKT0
 rtwJ6YIp1pEufyl/3Bb6u1I29E818Rpo1jaNTE8l2DqkfqHx8bDHhPwDsHGWG/tRpAs97SNJu
 zpZDua6ff76eAauVYwLRUBkjmhURhuXQ4IBL5LqWJtQv/L03z+QYLuuEAbh92sgRlOzOmD8Uk
 CrfKIYc7gxt4ErAKk5RpHgxjnAL1IYtDwCeOaQX1tRFVNaHMCTnNnRRMXSkyBqq0x3+ITSEip
 ujxTsSoViY7ziFCpjk+VJC1+LZ3bP9bcTVheeWMvTdiyvnbafaLnMZv0GsqTbdGh/eGqdP4pq
 HZeqjnK+7op3mBrPNqS0YuN6HjqLU3X453J2MnOKLCIxXM9blE3vQmssGhEOSo0oh7aYGQWZI
 TveALzXg6EaEAtMayv2XAOvtrojfD87R0V9LRZHNrAw8EsrAnyr1L04wD42G6//uFS6usi1DI
 dCGOLTAOn8/crUf9CO6bXl1ZyBWvuDOB5xbmzTV8C5/IXCsVkvtPb5UgU17gM+oicJO/30FWe
 +14bIjSo+JeKH1OaEDICVUhLlkKOsad1mK6uQrDrYDfeYFmDFMdHi1e1Aeq5aJnpuFmQCHp9j
 DI+IDf9pEtqcfrp3wTr6IEF5nNoI2u9eaRF/tOuR4ryhuIm3nyzjtC1YkxZdvZ9M4oFnvW0uw
 TVabQTZhLyURR8xsN0d3PzzCAK4sVNhQrBjzaLqyUZVOSlGBkuYHOHNWGB4qZpfs79yzjA7aX
 cb8lybhZutHiT14YzsqkKtpehGoA5ZLu1uLzmMMTvqwzQdmMktjei3atqDqHrID7Mh7shGJMK
 LqCkhyd+QjVW2j+/l9XjqNumz0VJTSNO5w0TT2qd04VpQxkVOC2aNcvwTnjBf5kh9gCbZSHRf
 cVS7r/naDUbSMQZd5PK800nUSn4p0359H4lD8ejZZi4xt6RDDi5gpcnkZTkC1dUm9qDAxyXNf
 DTBft10jo6FDi0+2ojV+V+U/u72Yl3N6wuA9bKD4yZoWerKIULKX6zFKTiEry90AgC4hslBiL
 FueqPwecQV61lkCJoAT90r9Z+rlICTXarKcnjhj8YRRWU7eZzoOouLj9FQsh3t0Tw0YVUhuig
 VCBuD801R2yhLUbqdDPbOi+pUaEbBydR7yvcR7lpHX8kONPREivIpPukswxCKZvp9fPmzKCfd
 hH0ites3u0HRXDHtVntzp8P+wK2WUch95UaKIJF2bZTe9NVsr6NDN5ACUe2Rhfxb7oJOFnGDC
 a3iTGVw+tF6YsPKt4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Like f0bca72dc77 (send-pack: use buffered I/O to talk to pack-objects,
2016-06-08), significantly reduce the number of system calls and
simplify the code for sending object IDs to rev-list by using stdio's
buffering and handling errors after the loop.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 connected.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/connected.c b/connected.c
index 937b4bae387..05c2916f38d 100644
=2D-- a/connected.c
+++ b/connected.c
@@ -22,14 +22,13 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 		    struct check_connected_options *opt)
 {
 	struct child_process rev_list =3D CHILD_PROCESS_INIT;
+	FILE *rev_list_in;
 	struct check_connected_options defaults =3D CHECK_CONNECTED_INIT;
-	char commit[GIT_MAX_HEXSZ + 1];
 	struct object_id oid;
 	int err =3D 0;
 	struct packed_git *new_pack =3D NULL;
 	struct transport *transport;
 	size_t base_len;
-	const unsigned hexsz =3D the_hash_algo->hexsz;

 	if (!opt)
 		opt =3D &defaults;
@@ -122,7 +121,8 @@ int check_connected(oid_iterate_fn fn, void *cb_data,

 	sigchain_push(SIGPIPE, SIG_IGN);

-	commit[hexsz] =3D '\n';
+	rev_list_in =3D xfdopen(rev_list.in, "w");
+
 	do {
 		/*
 		 * If index-pack already checked that:
@@ -135,16 +135,10 @@ int check_connected(oid_iterate_fn fn, void *cb_data=
,
 		if (new_pack && find_pack_entry_one(oid.hash, new_pack))
 			continue;

-		memcpy(commit, oid_to_hex(&oid), hexsz);
-		if (write_in_full(rev_list.in, commit, hexsz + 1) < 0) {
-			if (errno !=3D EPIPE && errno !=3D EINVAL)
-				error_errno(_("failed write to rev-list"));
-			err =3D -1;
-			break;
-		}
+		fprintf(rev_list_in, "%s\n", oid_to_hex(&oid));
 	} while (!fn(cb_data, &oid));

-	if (close(rev_list.in))
+	if (fclose(rev_list_in))
 		err =3D error_errno(_("failed to close rev-list's stdin"));

 	sigchain_pop(SIGPIPE);
=2D-
2.28.0
