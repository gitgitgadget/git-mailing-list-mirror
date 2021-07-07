Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A4EC07E95
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 22:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED8A761CBE
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 22:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbhGGWgW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 18:36:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62468 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhGGWgV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 18:36:21 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 616EEDF435;
        Wed,  7 Jul 2021 18:33:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Obu4xcGTkLcG
        D0HmaRYIVEQ0ASP6s00irc4j6/RVUWM=; b=Ns/NtASsWwcm9xUBc6ESwnnqhSzo
        B4bLfAV8KjWQGap8JqQ78qpT+AwnREZlCLH24dgguw/eED6DgsB4ba2wBFmawJuL
        GyVtzL/wuD0k5ZzPjIBxTSPC5zjb3tJhnSTLB4NAcZV0l7McXVT5YAOgARF35cfp
        6Trj5oR6BLbyUx4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5A456DF434;
        Wed,  7 Jul 2021 18:33:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D6CBCDF433;
        Wed,  7 Jul 2021 18:33:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] strbuf.[ch]: add STRBUF_HINT_SIZE macro = 8192
References: <cover-0.3-00000000000-20210707T103712Z-avarab@gmail.com>
        <patch-1.3-f5a6c4a2720-20210707T103712Z-avarab@gmail.com>
Date:   Wed, 07 Jul 2021 15:33:39 -0700
In-Reply-To: <patch-1.3-f5a6c4a2720-20210707T103712Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 7 Jul
 2021 12:38:40 +0200")
Message-ID: <xmqqsg0pda9o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 608BDEEA-DF73-11EB-82ED-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> In b449f4cfc97 (Rework strbuf API and semantics., 2007-09-06) the
> first hardcoding of 8192 appeared in strbuf.[ch], then in
> f1696ee398e (Strbuf API extensions and fixes., 2007-09-10) another one
> was added, and in b4e04fb66e8 (strbuf: add strbuf_read_once to read
> without blocking, 2015-12-15) a third.
>
> Let's factor that out into a STRBUF_HINT_SIZE macro, and add a
> strbuf_hint() helper macro for "hint ? hint : STRBUF_HINT_SIZE".

I guess hiding 8k that appears twice in strbuf.c behind a macro or
symbolic constant might makes sense, but=20

 - STRBUF_HINT_SIZE is a misnomer.  It is the default when the
   caller didn't give you a useful hint.  It is STRBUF_NO_HINT_SIZE,
   because it is the size that is used when there is no hint, or
   better yet, call it STRBUF_DEFAULT_READ_SIZE, perhaps?

 - strbuf_hint() is a misnomer for the same reason.
   strbuf_read_size(hint) perhaps, but for two or three callers,
   spelling out (hint ? hint : STRBUF_DEFAULT_READ_SIZE) is easier
   to understand.

 - Both STRBUF_HINT_SIZE and strbuf_hint() have no reason to be
   visible outside the implementation of strbuf.c; the whole reason
   why such a "the caller does not care, so let's use this logic to
   come up with the default value" exists is so that caller does not
   have to know and instead pass "0", which has nothing to do with
   the actual value used.

 - Also, there is no reason why strbuf_read() and strbuf_read_once()
   must share the same default when the caller did not give any
   hint; replacing these occurrences of 8k with a single constant
   may give a false impression that they must match.  This is merely
   an observation and not an objection, because the caller by
   passing 0 is saying they do not care at all, so while we can use
   arbitrary and different random values in these two functions, we
   can use the same arbitrary value as well.

