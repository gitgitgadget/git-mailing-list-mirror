Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA65C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 19:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50D1B60FE6
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 19:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239115AbhHaTrI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 15:47:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58563 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbhHaTrI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 15:47:08 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DAA5ADD2AF;
        Tue, 31 Aug 2021 15:46:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/RjvLOnuovxg
        PLDIQotP5I2nUjZ1oaDtRUsnf1vmlE8=; b=L0o5JquS3QS56zGeAVVlQuevyO6A
        wVWt5VxSVbky6LbCYfEcznPuXGnd5zx4/9ReMuBeN+xEBaIXrkrmWBJdbud3OzQR
        g/frmRal7314y6/z/2UQ+0UHMuOhBCSXcRiNurccrXQRzh+QttylmmcVRxwvtCOw
        KPfng5snDo8cw1Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C76DCDD2AC;
        Tue, 31 Aug 2021 15:46:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2E8F0DD2AA;
        Tue, 31 Aug 2021 15:46:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Marius Storm-Olsen <marius@storm-olsen.com>
Subject: Re: [PATCH] mailmap.c: fix a memory leak in free_mailap_{info,entry}()
References: <patch-4.4-ad8680f529-20210714T172251Z-avarab@gmail.com>
        <patch-1.1-f11eb44e4c5-20210831T134023Z-avarab@gmail.com>
        <YS6FKEApva30sKgl@coredump.intra.peff.net>
Date:   Tue, 31 Aug 2021 12:46:10 -0700
In-Reply-To: <YS6FKEApva30sKgl@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 31 Aug 2021 15:38:16 -0400")
Message-ID: <xmqq8s0htn25.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 17C84A08-0A94-11EC-857E-D601C7D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Aug 31, 2021 at 03:42:52PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>
>> In the free_mailmap_entry() code added in 0925ce4d49 (Add map_user()
>> and clear_mailmap() to mailmap, 2009-02-08) the intent was clearly to
>> clear the "me" structure, but while we freed parts of the
>> mailmap_entry structure, we didn't free the structure itself. The same
>> goes for the "mailmap_info" structure.
>>=20
>> This brings us from 50 failures when running t4203-mailmap.sh to
>> 49. Not really progress as far as the number of failures is concerned,
>> but as far as I can tell this fixes all leaks in mailmap.c
>> itself. There's still users of it such as builtin/log.c that call
>> read_mailmap() without a clear_mailmap(), but that's on them.
>>=20
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.co=
m>
>> ---
>
> Thanks, the patch looks good to me. I agree with Eric that mentioning
> "leak failures" in the second paragraph would make it less confusing. :=
)

Here is what I queued.

Thanks, all.

From ccdd5d1eb14a6735c34428e856c0de33f1055520 Mon Sep 17 00:00:00 2001
From: =3D?UTF-8?q?=3DC3=3D86var=3D20Arnfj=3DC3=3DB6r=3DC3=3DB0=3D20Bjarma=
son?=3D
 <avarab@gmail.com>
Date: Tue, 31 Aug 2021 15:42:52 +0200
Subject: [PATCH] mailmap.c: fix a memory leak in free_mailap_{info,entry}=
()
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

In the free_mailmap_entry() code added in 0925ce4d49 (Add map_user()
and clear_mailmap() to mailmap, 2009-02-08) the intent was clearly to
clear the "me" structure, but while we freed parts of the
mailmap_entry structure, we didn't free the structure itself. The same
goes for the "mailmap_info" structure.

This brings the number of SANITIZE=3Dleak failures in t4203-mailmap.sh
down from 50 to 49. Not really progress as far as the number of
failures is concerned, but as far as I can tell this fixes all leaks
in mailmap.c itself. There's still users of it such as builtin/log.c
that call read_mailmap() without a clear_mailmap(), but that's on
them.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 mailmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mailmap.c b/mailmap.c
index d1f7c0d272..e1c8736093 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -36,6 +36,7 @@ static void free_mailmap_info(void *p, const char *s)
 		 s, debug_str(mi->name), debug_str(mi->email));
 	free(mi->name);
 	free(mi->email);
+	free(mi);
 }
=20
 static void free_mailmap_entry(void *p, const char *s)
@@ -51,6 +52,7 @@ static void free_mailmap_entry(void *p, const char *s)
=20
 	me->namemap.strdup_strings =3D 1;
 	string_list_clear_func(&me->namemap, free_mailmap_info);
+	free(me);
 }
=20
 /*
--=20
2.33.0-323-g897a01baa9

