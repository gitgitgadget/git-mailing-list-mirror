Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6154C48BDF
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 01:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C5C9611BE
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 01:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhFPBrO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 21:47:14 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54403 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbhFPBrN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 21:47:13 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A3B53143B52;
        Tue, 15 Jun 2021 21:45:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=du/sg8ihYBeg
        yxaJNBmfFGXl7BJemT78SETbflqUB+4=; b=Fzg8ZGtwoXkbE+BqrhYZC9BWMPFQ
        6WKYblufy0gwFyJCEB35jrNTlE1GVqVUSME+0wBXoB09MLrgZs2a+u14XqmxsUA+
        dMig15cedikOfmk3eweD/Y2/9LZcYgKlM2u+o/6WuMwLJwOd8apA06dYQhrdXMqF
        ny8m8AmROcRro/o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 84964143B51;
        Tue, 15 Jun 2021 21:45:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0753C143B50;
        Tue, 15 Jun 2021 21:45:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, dstolee@microsoft.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: Re: Making split commit graphs pick up new options (namely
 --changed-paths)
References: <871r9a2dol.fsf@evledraar.gmail.com> <YMJKcHpN/gL5U6KK@nand.local>
        <87mtrx1cdr.fsf@evledraar.gmail.com> <YMKzOgOU9lj9Nt0z@nand.local>
        <e85bb66a-d70d-1861-07ef-82a74bcce4d7@gmail.com>
        <YMOzDGOo/HbqzkPa@nand.local>
        <eb5e2df7-25d8-a878-78ba-cca771265978@gmail.com>
        <87fsxjyz01.fsf@evledraar.gmail.com>
Date:   Wed, 16 Jun 2021 10:45:03 +0900
In-Reply-To: <87fsxjyz01.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 15 Jun 2021 16:35:47 +0200")
Message-ID: <xmqqsg1itwf4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7924CF9C-CE44-11EB-908C-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> ... indeed unlinking a file you just created (but hold a FD
> to) is a common pattern for getting a temporary file that you don't nee=
d
> to unlink on atexit(). It's just not used in e.g. Git's codebase becaus=
e
> of portability concerns.

Do we open one r/w, write into it and later read back from it,
without wanting the file to persist after we exit?  That is more
suitable for say Editor's "swp" file but I do not think of an
instance of our use of temporary file that would benefit from that
pattern.  IOW, it's not used in our codebase because we have no need
for the pattern, not due to portability concerns.

But that distinction is not the primary point in this topic.

> So not a big deal at all, but I wonder if there should be a warning
> there on !Windows, if you can't unlink a file on a POSIX system that
> suggests e.g. a persistent permission problem that won't be going away
> if you ignore it.

I do think we should catch failure from unlink and probably should
error out, unless we anticipate that somebody else might be removing
the same file and we got ENOENT.
