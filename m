Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29845C433E1
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 16:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA4FB2076C
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 16:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="U5KgvaWr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgHLQxF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 12:53:05 -0400
Received: from mout.web.de ([212.227.17.11]:35145 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbgHLQw7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 12:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1597251174;
        bh=7AGDU2Ra13Y8UbJ+JpJg5ZGyN+o/W143Fn6pTG/F2co=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=U5KgvaWr02uYpauLtfpfrXdbp6Nxg4qFU6qw362YDb6hYwNgK/HjC16v3Ez7M9H8q
         RZHgAMQtda84kQpNAuCsJqIYoTIcjY/Js6th2tq/s/vMSyZ/a7tmiUKOLQ6YCiGhin
         QlnGCXb8JCZWX0Z1n4lc3lJsxnasB337zSfWwuK8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MXoYQ-1kBTTu1rNU-00Ybrs; Wed, 12
 Aug 2020 18:52:54 +0200
Subject: [PATCH v2] midx: use buffered I/O to talk to pack-objects
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Chris Torek <chris.torek@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Derrick Stolee <stolee@gmail.com>
References: <c5920e08-b7dd-e870-f99e-225d0aafc663@web.de>
Message-ID: <9162c1cb-36fd-3203-ec58-4bd1501938d0@web.de>
Date:   Wed, 12 Aug 2020 18:52:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <c5920e08-b7dd-e870-f99e-225d0aafc663@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mswOnZOe9Uf7XH60QIPrMdrGB7hfMvGOl3AghR71GX9vrSEgCf3
 VdAL089wa/mvsAFaHWlwL04sVzRitqVT91SUBe+QnnLzqXtVqktSPa0dGDZ1ZFe02xS6xdI
 WirzsTj5ngjm1y/7k8OqpiU3GW7RBKsClyU1oRfhPf/YaWnWgITU/QE3R0EhmQQJkrVk2Xs
 sQfEVfd/4F2G///hdoj5A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5VfynKHRV+o=:SM8NJVJAV24IOlGo55L5Xa
 AxJhmy+DFBt6pLCYr8guFaKFXvJjUjmd4QlwsBZfNMLF00cTIKFs29AdOPLAof55YRsV53Dqx
 lzvh/Xc5Q3a7utbFPtQDXMzN/oC3N7QBFZZvqyaUHoouXiTOJfWEj6yIRCAa8aD+et5cf7A5y
 Tj5RcUpreQV8o5LEsMIn6wLP5QKf5oedttquh5rUqZvxwotBTspXgJiuKSad62IldiiHUUNOV
 IHOBGuUtw9E6TWdr2dymqsfEYxTf7ZjWN3l+MMixuTCgsH5yQEvIsf7t8tKlgvleCw7JnQ940
 UdSMujFS5Lp63q0KStiEZP0AeDXx96WeOxftTbfdDithyVQtdOcktts8RN10E6c+iBCpYnzMo
 N4brJNgP1UwqYpYJKB5m5+OqMp5rVyGygqNj6S9WxWaiExi3C/C5KHVJRqUHqpoG4uQanKz+m
 MifFbQKR3tHdhPsaw1/RSdxrqA0iGqk7Ck1aLnp3QF6Wj6D5CfSj1WckKR0ogPZVTbXznYGoj
 XhizxWN8903oEKhXyT/YtJVBcWgWQyCYmiFru3qSh4GHH7m2axc7kqLJ16K7U3AFTxv3BekFc
 Y7/VmHYOpKhh7mDZlwz7UDKYDLKQZbS5bguAkCfKbIVgHaX1vNr9ELkUeEq8ipjVWIaDn8iQt
 PgJ421AZO6BWrnzbumyh6jhqTKoKPOd4OsLX3emtbrmLaxVRlcIZLVdqdR2xNmwctzbri+K66
 r8kqWsmXMeQfk5JHAO1gkSvCKPdRv8HGypZCRphLPS8NWL7AP6W+upfPoOZvZs7Q/p/7iyAM2
 +AN6KQq1AwD+z2MgmgePSgjLjjiV9uZFHpGXOWekbvCTL6IfATTDuwOaGa/Se9ES1huG0IxJ4
 6oFG8P99Bcl3ia8I7RuHiHFQ4CFbJYXl8ic7xekW1XJy4MDWrEDwCoJFgwCKy5U1k+T1E7gXy
 xBFZC8rVIfHSX/2Mthn5NaU79F5ygY+2UWDMiFY1ZR5p2UGMM2gJZc69ONMsOrF3gkVb1ZNrY
 /XqBqpziBE4+zIk3HLXEgLwBYdYe5I0ChS+l8fXpYeK48JKy5SwlZ2orz2xlimdXpHkK3kZvj
 IlrKfK0KFMjutTbF9vNYAdbc3h5fA14OHF1lkdDKvrZ79b5HM4LQnq5ij3sS1ej5wdt6GFW1N
 f8VZ6wIp7vlD2knBKIpbN1+yFZlMbXFuwmLQXxblogI5YY4Uz9TQUTI8JulRc+9zxu0t56vid
 c6Haatwu0F2TfktI5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Like f0bca72dc77 (send-pack: use buffered I/O to talk to pack-objects,
2016-06-08), significantly reduce the number of system calls and
simplify the code for sending object IDs to pack-objects by using
stdio's buffering.

Helped-by: Chris Torek <chris.torek@gmail.com>
Helped-by: Johannes Sixt <j6t@kdbg.org>
Encouraged-by: Derrick Stolee <stolee@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Change since v1:
- Removed error handling to match the original code.

 midx.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/midx.c b/midx.c
index a5fb797edee..0f95c3d8526 100644
=2D-- a/midx.c
+++ b/midx.c
@@ -1383,6 +1383,7 @@ int midx_repack(struct repository *r, const char *ob=
ject_dir, size_t batch_size,
 	uint32_t i;
 	unsigned char *include_pack;
 	struct child_process cmd =3D CHILD_PROCESS_INIT;
+	FILE *cmd_in;
 	struct strbuf base_name =3D STRBUF_INIT;
 	struct multi_pack_index *m =3D load_multi_pack_index(object_dir, 1);

@@ -1435,6 +1436,8 @@ int midx_repack(struct repository *r, const char *ob=
ject_dir, size_t batch_size,
 		goto cleanup;
 	}

+	cmd_in =3D xfdopen(cmd.in, "w");
+
 	for (i =3D 0; i < m->num_objects; i++) {
 		struct object_id oid;
 		uint32_t pack_int_id =3D nth_midxed_pack_int_id(m, i);
@@ -1443,10 +1446,9 @@ int midx_repack(struct repository *r, const char *o=
bject_dir, size_t batch_size,
 			continue;

 		nth_midxed_object_oid(&oid, m, i);
-		xwrite(cmd.in, oid_to_hex(&oid), the_hash_algo->hexsz);
-		xwrite(cmd.in, "\n", 1);
+		fprintf(cmd_in, "%s\n", oid_to_hex(&oid));
 	}
-	close(cmd.in);
+	fclose(cmd_in);

 	if (finish_command(&cmd)) {
 		error(_("could not finish pack-objects"));
=2D-
2.28.0
