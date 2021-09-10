Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7BAC433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 18:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16F3860F6D
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 18:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhIJSNR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 14:13:17 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59379 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbhIJSNB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 14:13:01 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7425E148B9F;
        Fri, 10 Sep 2021 14:11:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=NVNpE3dd8xGJ
        FkEhpT22VEYlBqjthL9TZPBvUPSeSCk=; b=EvsSGF3rRlu4AZi6DHTeSRp2WEO9
        HEfr16pBHwwwjIQ+17wMJsLnKBTgua7Tq5WqTTxSS5kf5vjI4ii8Uu0eUhCqCVSp
        nY0a8dIN6FLetmR3CKbcprtLzVPYf1ciOWAsAGfqD8oJ7BkCNCoBCWupXdOBoZU7
        IhJvdeQRvhvyasQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 69F4A148B9E;
        Fri, 10 Sep 2021 14:11:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B92C7148B9C;
        Fri, 10 Sep 2021 14:11:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Oddidies in the .mailmap parser & future syntax extensions
References: <20210910130236.40101-1-me@fangyi.io>
        <YTt4RymWg+TOEmUf@tilde.club> <877dfocps2.fsf@evledraar.gmail.com>
Date:   Fri, 10 Sep 2021 11:11:45 -0700
In-Reply-To: <877dfocps2.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 10 Sep 2021 18:48:26 +0200")
Message-ID: <xmqq1r5wti5a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8FA5A34C-1262-11EC-BFCA-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> [Changed subject]

[jc: culled CC addresses]

> I'd expect:
>
>     Foo <foo@example.com> Bar
>
> To be an alias/shorthand for:
>
>     Foo <foo@example.com> Bar <foo@example.com>

OK.

> More annoying is that this:
>
>     New <foo@example.com> <bar@example.com>
>     <foo@example.com> <zar@example.com>
>
> Doesn't mean the same as:
> ...
> I.e. I'd expect the name to map to the empty string, *unless* we saw an
> earlier address, i.e. just as we do for the first bar -> foo line (we
> map it to a name of "New", we don't map it to an empty name).

You expect the first one to map (anyname, <bar@example.com>) to
("New", <foo@example.com>) and you describe the second one does not
map the human-readable part to "New", but it is unclear what the
code does, or why you expect it to map to "" (or what your
expectation is, for that matter, exactly---do you want an empty
string, or do you want "New", or something else???).

FWIW, if we were designing it from scratch, I'd expect the second
one to map (anyname, <zar@example.com>) to ($1, <foo@example.com>),
keeping the human-readable part as-is and only map the e-mail part.

Or do you expect that when these two entries appear together, the
first entry with "New" is carried over to the second entry?

> Doing that would be strictly backwards compatible, i.e. now we'll
> entirely ignore the 3rd E-Mail address. It does mean we also
> accidentally support things like:
>
>     New <foo@example.com> <bar@example.com> # A comment, because we ign=
ore everything after the 2nd address
>
> But don't tell anyone I told you that :) But that is something that
> might technically have inadvertently closed the door to future syntax
> extensions, but we could probably do them anyway, or at worst have some
> heuristic.

I vaguely recall that it was not an accident but a deliberate
feature to allow comments, but don't tell anyone I told you that.

