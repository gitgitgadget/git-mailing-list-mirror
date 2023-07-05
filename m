Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCF0EB64DD
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 05:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjGEF4j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 01:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjGEF4i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 01:56:38 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D17210C3
        for <git@vger.kernel.org>; Tue,  4 Jul 2023 22:56:37 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DBEDE2DDB3;
        Wed,  5 Jul 2023 01:56:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=KGFrnUmQVmzU
        2R8Nswe4EPaBv3jTIkJvf2iv6SSyxzc=; b=i774SX5sre0NaI+SUTPZZZMqnDwX
        0NzCSGhId8ci+6/1ItdufHFpblnxfNuAUw+RzI8w+yJ4HfVbYGiHzGcLHiqhOLNZ
        BX/SDtJZPvAj7L7A3jaGbf5Fczy2Fl50kvZc6N4FbLjaL5IY6fxmZG3f843WvKOt
        3NFvU5Q5Va+uXe0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C84F02DDB2;
        Wed,  5 Jul 2023 01:56:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3DC2F2DDB1;
        Wed,  5 Jul 2023 01:56:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] pkt-line: don't check string length in packet_length()
References: <89d58db7-6a01-b3fa-54f0-19d5a3819eb3@web.de>
Date:   Tue, 04 Jul 2023 22:56:32 -0700
In-Reply-To: <89d58db7-6a01-b3fa-54f0-19d5a3819eb3@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 1 Jul 2023 09:05:15 +0200")
Message-ID: <xmqqttui3nqn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B1D32AF2-1AF8-11EE-8633-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> hex2chr() takes care not to run over the end of a short string.
> 101736a14c (pkt-line: extern packet_length(), 2020-05-19) turned the
> input parameter of packet_length() from a string pointer into an array
> of known length, making string length checks unnecessary.  Get rid of
> them by using hexval() directly.

I am puzzled about the part of the above description on "making
string length checks unnecessary".  The two callers we currently
have both do pass char[4], but the compiler would not stop us from
passing a pointer to a memory region of an unknown size; if we
butcher one of the current callers

diff --git c/pkt-line.c w/pkt-line.c
index 6e022029ca..e1c49baefd 100644
--- c/pkt-line.c
+++ w/pkt-line.c
@@ -421,7 +421,7 @@ enum packet_read_status packet_read_with_status(int f=
d, char **src_buffer,
 		return PACKET_READ_EOF;
 	}
=20
-	len =3D packet_length(linelen);
+	len =3D packet_length(buffer);
=20
 	if (len < 0) {
 		if (options & PACKET_READ_GENTLE_ON_READ_ERROR)

where "buffer" is just a random piece of memory passed to the caller
and there is no such guarantee like "it at least is 4 bytes long",
we would just slurp garbage and run past the end of the buffer.

> The resulting branchless code is simpler and it becomes easier to see
> that the function mirrors set_packet_header().

I do like the resulting code, but I feel a bit uneasy to sell this
change as "the code becomes more streamlined without losing safety".
It looks more like "this change is safe for our two callers; those
adding more callers in the future are better be very careful", no?
