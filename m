Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6E6C07E95
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 22:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0F8A61CCA
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 22:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbhGGWkm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 18:40:42 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59885 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbhGGWkl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 18:40:41 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0350D1428EB;
        Wed,  7 Jul 2021 18:38:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=w5eJg5GQYdPK
        pMUK6gV/fH8MEWv2HdQW0lqB5dp3NRQ=; b=l9efpR6RdNTSA/ljGxlZ6s3/c+N8
        +z+R7n/VBQponS8u9Za11diJNUqOxMFzk+4FZahcwcMazpd/p8zgqD50XXwVjdyw
        EFlcNdtdNTxCs5M0C/HmdYvyDB+nDdUFba7DI5qz28F7vyrxvcqtn2cf8jjzDa3D
        ZO7d0xa4y+fYQPo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EF7391428EA;
        Wed,  7 Jul 2021 18:38:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 48F591428E6;
        Wed,  7 Jul 2021 18:37:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] strbuf.h API users: don't hardcode 8192, use
 STRBUF_HINT_SIZE
References: <cover-0.3-00000000000-20210707T103712Z-avarab@gmail.com>
        <patch-2.3-a920a9971e8-20210707T103712Z-avarab@gmail.com>
Date:   Wed, 07 Jul 2021 15:37:56 -0700
In-Reply-To: <patch-2.3-a920a9971e8-20210707T103712Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 7 Jul
 2021 12:38:41 +0200")
Message-ID: <xmqqo8bdda2j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FA9395E6-DF73-11EB-941A-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change a couple of users of strbuf_init() that pass a hint of 8192 to
> pass STRBUF_HINT_SIZE instead.
>
> Both of these hardcoded occurrences pre-date the use of the strbuf
> API. See 5242bcbb638 (Use strbuf API in cache-tree.c, 2007-09-06) and
> af6eb82262e (Use strbuf API in apply, blame, commit-tree and diff,
> 2007-09-06).
>
> In both cases the exact choice of 8192 is rather arbitrary, e.g. for
> commit buffers I think 1024 or 2048 would probably be a better
> default (this commit message is getting this commit close to the
> former, but I daresay it's already way above the average for git
> commits).

Yes, they are arbitrary within the context of these callers.

I do not think using STRBUF_HINT_SIZE macro in them is the right
thing to do at all, as there is no reason to think that the best
value for the write chunk sizes in these codepath has any linkage to
the best value for the read chunk sizes used by strbuf_read() at
all.  When benchmarking reveals that the best default size for
strbuf_read() is 16k, you'd update STRBUF_HINT_SIZE to 16k, but how
do you tell that it also happens to be the best write buffer size
for the cache-tree writeout codepath (answer: you don't)?



