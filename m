Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61801C56202
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 21:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01358206E0
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 21:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NjQ/OYoF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732250AbgKYVm2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 16:42:28 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50044 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728642AbgKYVm1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 16:42:27 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B87EF8DA63;
        Wed, 25 Nov 2020 16:42:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GcLcT9g/bCjZ
        mCKyd+kwtNdsYJM=; b=NjQ/OYoF6I8gU5I7I7XR70nL0UrSiYuepcxn79NgFXBK
        ARNVYJKu6CBRnu77Up6dLaTigS1yNA1VgD/sI906rKprJD1YtA09dqIYcbHVattB
        3oi6XdR2ATOJnwxU3prDvr/l0XcWsiGTbf50UVCIuSHz0XM0ggGVEe3uaaBckvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=mSePTK
        CxgLjmeQDMcB0G7MmqvB7Mk0PYamLjdY3FsCUFRSA+gHBSelMORxqJVF2K2m1dlK
        R5519k1IWUDCjsDvuWd1TJ4G24Dq5QvGFZJKKe7dr+7qjDoWLVcYgxEoN3/0GeQe
        jg4aXQN5OUcZyZtCEsHAQcxOisaq90J6oD0AQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AED748DA61;
        Wed, 25 Nov 2020 16:42:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 303438DA60;
        Wed, 25 Nov 2020 16:42:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Cc:     =?utf-8?B?5ZSQ5a6H5aWV?= <winglovet@gmail.com>, git@vger.kernel.org
Subject: Re: Bug report: orphaned pack-objects after killing upload-pack on [
References: <CAFWsj_UwkQX9y0xPQJE3xguo0z3TMkvKAwei5iryCWXvVP8CjA@mail.gmail.com>
        <badf3777-3970-b714-3ad9-67d2f77f94a5@web.de>
        <20201121002921.GC353076@coredump.intra.peff.net>
        <xmqqd006s7ee.fsf@gitster.c.googlers.com>
        <X7zOKbzR9gwJHMbJ@coredump.intra.peff.net>
Date:   Wed, 25 Nov 2020 13:42:24 -0800
In-Reply-To: <X7zOKbzR9gwJHMbJ@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 24 Nov 2020 04:11:05 -0500")
Message-ID: <xmqqy2ipcdvj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1B5CE858-2F67-11EB-BBFD-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So I think it is still a good idea to do, and what I wrote earlier is
> as good a we can do.
>
> Ren=C3=A9, do you want to wrap up your similar patch for the fetch side=
?

In the meantime, I may queue this on 'seen' but it cannot move
forward without a signoff.

Thanks.

--- >8 ------ >8 ------ >8 ------ >8 ------ >8 ---
From: Ren=C3=A9 Scharfe <l.s.r@web.de>
Date: Fri, 20 Nov 2020 19:52:45 +0100
Subject: [PATCH] upload-pack: kill pack-objects helper on signal or exit

We spawn an external pack-objects process to actually send objects
to the remote side. If we are killed by a signal during this
process, the pack-objects will hang around as a zombie.  We should
take it down when we go down.
---
 upload-pack.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/upload-pack.c b/upload-pack.c
index 3b858eb457..d4f7192d04 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -321,6 +321,7 @@ static void create_pack_file(struct upload_pack_data =
*pack_data,
 	pack_objects.in =3D -1;
 	pack_objects.out =3D -1;
 	pack_objects.err =3D -1;
+	pack_objects.clean_on_exit =3D 1;
=20
 	if (start_command(&pack_objects))
 		die("git upload-pack: unable to fork git-pack-objects");
--=20
2.29.2-538-g65d51b1459
