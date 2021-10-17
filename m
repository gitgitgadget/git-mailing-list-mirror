Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D85CC433EF
	for <git@archiver.kernel.org>; Sun, 17 Oct 2021 06:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FCD360FD9
	for <git@archiver.kernel.org>; Sun, 17 Oct 2021 06:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244982AbhJQGDN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Oct 2021 02:03:13 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55199 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244979AbhJQGDL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Oct 2021 02:03:11 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7A05516A2E5;
        Sun, 17 Oct 2021 02:01:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=SHe8SkTmjsOg
        UqV+83nONcZVUll84fhFq9itVsrmqB8=; b=WFYxoIIVdAGtwtLMZaB8u6XKxryP
        7YKUXFCT62/Ax3ZKmv7lnRjuJ1WzJ0zWa2NL4Gy9wPZ2zXje04A9RQj+iL9K1rKl
        4/1QcYD6lXWcucpATkyHPFSldh6D2cb17qSb1T8J/BTTVzWs7GremYWgieBjrzDU
        Ib3qjzT3KvAzq7o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7219D16A2E4;
        Sun, 17 Oct 2021 02:01:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AA9D016A2DD;
        Sun, 17 Oct 2021 02:00:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Hamza Mahfooz <someguy@effective-light.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v13 3/3] grep/pcre2: fix an edge case concerning ascii
 patterns and UTF-8 data
References: <20211015161356.3372-1-someguy@effective-light.com>
        <20211015161356.3372-3-someguy@effective-light.com>
        <xmqq4k9i5a4n.fsf@gitster.g>
        <eddcbe66-b172-90b7-309e-e9ce5b5b44a4@web.de>
        <87zgr8dg8j.fsf@evledraar.gmail.com>
        <fc7eb9fc-9521-5484-b05f-9c20086fd485@web.de>
Date:   Sat, 16 Oct 2021 23:00:58 -0700
In-Reply-To: <fc7eb9fc-9521-5484-b05f-9c20086fd485@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 16 Oct 2021 21:44:13 +0200")
Message-ID: <xmqq1r4k197p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9A0B7E82-2F0F-11EC-976F-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>>> Literal patterns are those that don't use any wildcards or case-foldi=
ng.
>>> If the text is encoded in UTF-8 then we enable PCRE2_UTF either if th=
e
>>> pattern only consists of ASCII characters, or if the pattern is encod=
ed
>>> in UTF-8 and is not just a literal pattern.
>>>
>>> Hmm.  Why enable PCRE2_UTF for literal patterns that consist of only
>>> ASCII chars?
>>> ...
>>     echo 'Ren=C3=A9 Scharfe' >f &&
>>     $ git -P grep --no-index -P '^(?:You are (?:wrong|correct), )?Ren.=
 S' f; echo $?
>>     1
>>     $ git -P grep --no-index -P '^(?:You are (?:wrong|correct), )?R[e=C3=
=A9]n. S' f; echo $?
>>     f:Ren=C3=A9 Scharfe
>>     0
>>
>> So it's a choose-your-own adventure where you can pick if you're
>> right. I.e. do you want the "." metacharacter to match your "=C3=A9" o=
r not?
>
> Yes, I do, and it's what Hamza's patch is fixing.

That may be correct but is this discussion still about "Why enable
... for literal patterns that consist of only ASCII"?  Calling "." a
"metacharacter" and wanting it to match anything other than a single
dot would mean the pattern we are discussing is no longer "literal",
isn't it?  I am puzzled.

>> These sorts of patterns demonstrate nicely that the relationship betwe=
en your
>> pattern being ASCII and wanting or not wanting UTF-8 matching semantic=
s
>> isn't what you might imagine it to be.
>
> Differences are:
>
> o: opt->ignore_locale
> h: has_non_ascii(p->pattern)
> i: is_utf8_locale()
> l: literal
>
> o h i l master hamza rene
> 0 0 0 0      0     1    0
> 0 0 0 1      0     1    0
> 0 0 1 0      0     1    1   <=3D=3D your first example
> 0 0 1 1      0     1    0
> 0 1 1 1      0     0    1
>
> Turning on PCRE2_UTF when is_utf8_locale() =3D=3D 0 seems wrong (first =
two
> lines).
>
> Turning on PCRE2_UTF for literal matching (fourth line) goes against
> 870eea8166 (grep: do not enter PCRE2_UTF mode on fixed matching,
> 2019-07-26).
>
> Turning on PCRE2_UTF for literal matching of non-ASCII characters (fift=
h
> line) also goes against that, so my intuition betrayed me.  When I
> adjust it, I get:
>
> 	if (!opt->ignore_locale && is_utf8_locale() && !literal)
> 		options |=3D (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
>
> That looks deceptively simple -- just drop has_non_ascii(p->pattern)
> from the original condition.
>
> Your second example is handle the same by all versions btw.:
>
> o h i l master hamza rene
> 0 1 1 0      1     1    1
>
> Ren=C3=A9
