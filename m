Return-Path: <SRS0=3Zv9=35=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49E2C35250
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 15:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92CCC2080C
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 15:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="lIUbDYfN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgBIPz7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Feb 2020 10:55:59 -0500
Received: from mout.web.de ([212.227.15.3]:36003 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727316AbgBIPz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Feb 2020 10:55:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1581263754;
        bh=M31iPiEwJn/VCJ5wp1CI62KF4hO+OJk3wbKbUPpQyFU=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=lIUbDYfNzRJQfozQaIVaGeJyfRXJcTXL3ol69yOYFsNf3QZvtEx1t6QZRJekrFTvb
         /fxRe95g23Lu/vssP92PGZ6oUC9SHRiPhN0B/q2Zlco4amUUuxJe7qCeWMmyluqLhU
         luER9II0w78DxyRN9DAOmU3G4+wuebunMGOxNATQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.145.153]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lu57G-1jT2ho2eQA-011RjH; Sun, 09
 Feb 2020 16:55:54 +0100
Subject: [PATCH 1/4] parse-options: use COPY_ARRAY in parse_options_concat()
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1?= =?UTF-8?Q?y?= 
        <pclouds@gmail.com>
References: <11b82734-f61c-5e73-2d0c-22208c06d495@web.de>
Message-ID: <074eda38-9517-26b6-5608-55ec5f473d80@web.de>
Date:   Sun, 9 Feb 2020 16:55:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <11b82734-f61c-5e73-2d0c-22208c06d495@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xtWYpe+5oRZFsbUQ/NXvZtrJDa7TbddpHvdrV6qCnlEJfsfo4VJ
 NTgPg5KgG22gEEz/Rbn0B2bnN7w8Uux/DpdOXGQ1sTtHxwKukMKV72wDjV068L2yW49yNw8
 3U8O0vg1BSmXJvnpkoFesrPCvbze3PVJDto+C5aLh2syvV70wmg0aSSI3mU4D2565uR9FnN
 dbwq4qIv8wzspwCbB1e0A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yuN+E2VrnvM=:uAUVYYxGO7lF0i68Cunj9o
 xATU0wb68paKvEdSI7CI8gqIwD1tJqHZXI29qT/kc12jKbvtubm6Hpm0Xk/4ADMk3uLQWR0MJ
 m/22mvkJ/LPh+q5FUGSTRBMKCCy61OL+AO9EEsLeBbXbR3HVpv+1Ip7Du4IhKNJ2jz8eSlGvh
 ttQSrlNx0Z0wDqTzE1n/BKKeJjwqk0nYYKf+7AqKO/otn8ioG36FLOkfW5V0iiRYN+D0jgYVD
 gAEZPD9eQMOgcMJzze2RG8Bol3AvYxT56Rvier4dNB8RoQp89CO0dYVYd95SnDwN3RUqBZEfH
 nfa0Tz2mIQNodRlVyLuwJueZshej1QT9KGaHasYfDa7GeTlY98JB73Wjj/VteZ6eUTc+5H43J
 3zRnqjLmkBdzB6Bb/eLa6eUsCwqYO+NjtoJCIc/li3/rxxV95ffyfRQ7k64FXFldjAIoM2IPY
 FGr8o69ENvQzGHImhg2aD+Wy0cZrA1XXP83os6XhQrWwdHVUk0fiGNuAtAQ9ZG8NJsARQxJzV
 nbuV+agUi75a2BVYWkA/SAAigB3+63DZEbr287E/IJ34G3GlT75PQ5YMkV23yldqOJUYb+cJ+
 PKPgn6IXRGtUJqlkWawManxcAOizZeafEMaxWIxMnvphltxka9asju2NjMrYIw5jIsPlyhcqh
 KYyo8Km/wBQ+jAzs9jjHmUVGt7zrnmcqua4K62gIcIp7IuW5orE83vJx3IqeQKVqyqAAazBkK
 5Ua0FPC1SAvRO6ZLhy39D12FMql+wpKRG49Kvv1PSkzNK41ruJ9STYj5ytQCU1qk18l+nESFm
 AlDHJNt2RBl0sK0kwuoc3lBnvL2HVIQ0oGACdwI+WqaMcDeEDFNc3TT8ypv4VugA1uGg4PxS+
 Fl8ITnO03GtWYbU2oWHsQaB+g1Nk99TLZe0c5osGH8v6AHNFoNi0qloxwKq3q7RIXtHNtwAS8
 PKS0PzFOG5YEAJbl9qgKYXkfaUD8BW+XJBWKADqqM3x2peGoclB0dKOc+4Epw3GOgFEp6Pxdd
 VHRCPJ36zgcgGumH96SIHw5cYVeC19203UyMphtDLuFI60rhyDxCCB7+IygdjaCi4WsjyE4YW
 KluBSXYmCdUfSOdVydFdvH6LUjf1gFvIo7Q/5XOdxSCbUexAjbLJ600WYKpmIM7rOzIWidMDX
 ik5D5rw439IEJJ2ZDc4+/VPZCwIR14tdNQhlSlKPaoAdmj1m1fVL5u0ZEMhIx9JXt8EhM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use COPY_ARRAY to copy whole arrays instead of iterating through the
elements.  That's shorter, simpler and bit more efficient.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 parse-options-cb.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/parse-options-cb.c b/parse-options-cb.c
index c2062ae742..012e048856 100644
=2D-- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -188,11 +188,8 @@ struct option *parse_options_concat(struct option *a,=
 struct option *b)
 		b_len++;

 	ALLOC_ARRAY(ret, st_add3(a_len, b_len, 1));
-	for (i =3D 0; i < a_len; i++)
-		ret[i] =3D a[i];
-	for (i =3D 0; i < b_len; i++)
-		ret[a_len + i] =3D b[i];
-	ret[a_len + b_len] =3D b[b_len]; /* final OPTION_END */
+	COPY_ARRAY(ret, a, a_len);
+	COPY_ARRAY(ret + a_len, b, b_len + 1); /* + 1 for final OPTION_END */

 	return ret;
 }
=2D-
2.25.0
