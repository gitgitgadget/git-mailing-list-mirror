Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8D5C433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 04:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A41DA610F7
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 04:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbhIXEXj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 00:23:39 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56605 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbhIXEXh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 00:23:37 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 172D9162B57;
        Fri, 24 Sep 2021 00:22:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=mAXkGI3LkCu1gu9fwFDo9swJV
        /9Bw/j3TpSYjhu818Y=; b=wS7tboN0MY96nFxeWjTVue8t7Kdgh19Z4nnFQvH/L
        5pV7JbZmG2lFpW6ORzlDRqezw+IMeKU7+16dP5XqIKr5e9+56Y8C0+/2L5NOwnC7
        i8nhdWziaMe8vM2c984OHPPUMChPMUp1BHUsZGIB7arTOdP61CfDKD3ENo05kOq6
        Uc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0F49D162B56;
        Fri, 24 Sep 2021 00:22:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D7479162B54;
        Fri, 24 Sep 2021 00:22:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Hamza Mahfooz <someguy@effective-light.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 6/5] grep.c: mark eol/bol and derived as "const char *
 const"
References: <YUlVZk1xXulAqdef@coredump.intra.peff.net>
        <patch-1.1-c317e6e125e-20210921T124416Z-avarab@gmail.com>
        <YUnx7gt0KQNRlhuZ@coredump.intra.peff.net>
        <874kadapq1.fsf@evledraar.gmail.com>
        <YUowCkmWqKgIldNz@coredump.intra.peff.net>
        <874kab5r63.fsf@evledraar.gmail.com>
Date:   Thu, 23 Sep 2021 21:22:00 -0700
Message-ID: <xmqq4kaay55j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F754A01A-1CEE-11EC-A22F-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> That I just don't understand, i.e. how the variable is defined in this
> 6/5 pertains to how it gets used /inside/ the function in this case, th=
e
> caller code doesn't have to care, but perhaps I'm missing something...


-static struct grep_pat *create_grep_pat(const char *pat, size_t patlen,
+static struct grep_pat *create_grep_pat(const char *const pat, size_t pa=
tlen,
 					const char *origin, int no,
 					enum grep_pat_token t,
 					enum grep_header_field field)

Because the function signature is visible to the caller of this
function, it sees that the callee, as part of its implementation
detail, keeps "pat" pointer pointing at the same location.  That is
not something the caller needs to care, even though the caller may
deeply care that the memory locations "pat" points at will not be
changed via the pointer by calling this function.

On the other hand

@@ -1438,7 +1439,7 @@ static int look_ahead(struct grep_opt *opt,
 		      const char **bol_p)
 {
 	unsigned lno =3D *lno_p;
-	const char *bol =3D *bol_p;
+	const char * const bol =3D *bol_p;
 	struct grep_pat *p;
 	const char *sp, *last_bol;
 	regoff_t earliest =3D -1;

This one is totally invisible to the caller of the function, and is
a good documentation for those who read the implementation of it.

Thanks.
