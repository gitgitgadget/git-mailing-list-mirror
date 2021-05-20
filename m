Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C989CC433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 23:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB9616101D
	for <git@archiver.kernel.org>; Thu, 20 May 2021 23:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbhETXzU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 19:55:20 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50620 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbhETXzU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 19:55:20 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B839B13B7A9;
        Thu, 20 May 2021 19:53:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=CpinT+GIzpc5
        3GDohXb3DolG7vwEYNLS1akhaCiua3M=; b=NOlFIO/Xp9qgIBtUSHz0OJL9+vYm
        FE7bWRh8xlJ3Dvxz70lZM+ps0ilTVy8NyMWidXdLQnDpYKmpPP9Huu4w0mNfuYPf
        7WaVx6I9si5fe4Os+nb2X3e7LQUQyA4Iab2Ibbg2zyoUKp6xoPpjU6bGDb1bKkpK
        17RN63fB9tpClYM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B122F13B7A8;
        Thu, 20 May 2021 19:53:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 09CC713B7A7;
        Thu, 20 May 2021 19:53:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Gregory Anders <greg@gpanders.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7Ru?= =?utf-8?B?Zw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH v2 00/10] send-email: various optimizations to speed up
 by >2x
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
        <cover-00.10-00000000000-20210520T081826Z-avarab@gmail.com>
        <YKYdeom6SgAHqojm@coredump.intra.peff.net>
Date:   Fri, 21 May 2021 08:53:53 +0900
In-Reply-To: <YKYdeom6SgAHqojm@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 20 May 2021 04:27:38 -0400")
Message-ID: <xmqqv97drmge.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A2C75E88-B9C6-11EB-B9E0-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I like all of this, except for the change in the interface of
> Git::config_regexp(). You mention that it's new-ish, and probably not i=
n
> wide use. And I agree that's probably true. But it feels like violating
> a principle of not breaking APIs, and we should stick to that principle
> and not bend it for "well, it's not that old an API".
>
> I'd find it more compelling if it the existing interface was broken or
> hard to avoid changing. But couldn't we just add a new function with th=
e
> extra info (config_regexp_with_values() or something)?

We seem to use it in-tree only once, but we have no control over
what out-of-tree users have been doing.

I do like your proposed name for the fact that it has _with_values
in it; the original gave us only a list of configuration variable
names, and now we are getting name-value tuples.

BUT

I am not sure if I like the new interface, and I do not know if the
the name "config_with_values" is a good match for what it does.

Namely, when a function is described as:

    =3Ditem config_regexp ( RE )

    Retrieve the list of configuration key names matching the regular
    expression C<RE>. The return value is an ARRAY of key-value pairs.

I would expect it to return ([key1, value1], [key2, value2], ...),
but the implementation returns (key1, value1, key2, value2, ...),
i.e. a flattened list, if I am not mistaken.

    my @cmd =3D ('config', '--null', '--get-regexp', $regex);
    unshift @cmd, $self if $self;
    my $data =3D command(@cmd);
    my (@kv) =3D map { split /\n/, $_, 2 } split /\0/, $data;
    return @kv;

We get NUL terminated records, so we first split the entire output
at NULs (to get a list of key-value records).  Each key-value record
has the key followed by LF followed by value, so we split it at the
first LF (i.e. a value with an embedded LF would behave correctly)
to extract key and value out of it.  But the resulting list is a
flat list with alternating key and value.

The side that works on the returned value of courese knows that it
is getting a flattened list and acts accordingly:

    my @kv =3D Git::config_regexp("^sende?mail[.]");
    while (my ($k, $v) =3D splice @kv, 0, 2) {
        push @{$known_config_keys{$k}} =3D> $v;
    }

Perhaps it may be more performant than a more obvious and
straight-forward "list of tuples", i.e.

    return map { [split /\n/, $_, 2] } split /\0/, $data;

    my @kv =3D Git::config_regexp("^sende?mail[.]");
    for my $tuple (@kv) {
        push @{$known_config_keys{$tuple->[0]}}, $tuple->[1];
    }

but somehow the flattened list felt unnatural at least to a na=C3=AFve
reader like me.
