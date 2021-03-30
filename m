Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74B9C433DB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 05:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADDA161585
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 05:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhC3Fu5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 01:50:57 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64369 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhC3FuY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 01:50:24 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ABE6612881C;
        Tue, 30 Mar 2021 01:50:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=sewPToxKYEeW
        FszcqxHPcXeNURQ=; b=LF1TYW6QpeLhW6PSucGfVOMaShkrTRONHNqvm6jp6t2B
        d81es+gLvE7sMVqmxQKWGsYhv7qFeZ8MM1j/6AE94MmnvQWoj2cUoF+C8wsor7mI
        rmWxZ4ojrEqd2QaMnYNuNwgLJZoi2/lUzvrnq3G4CVyp1JOVd+5E9aYYUWsimz8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=kixI3Q
        HP29JxVEccOgLOc42u4j7Mrko2pyyH/LK7bt0Wppk4JTPAS+R/5r/vbne9PCmUqL
        5pGB7xZ+J2KUp5uzAtomXNvkiHemZqe36Ybx5CjsGh82CCcq9GY0pSsRn4bxQxce
        h0I7dYLNvwjBAWGt0Skb4t2Nr8tXq0qrb3clY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9898312881B;
        Tue, 30 Mar 2021 01:50:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AC99712881A;
        Tue, 30 Mar 2021 01:50:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 10/10] tag: don't misreport type of tagged objects in
 errors
References: <20210308200426.21824-1-avarab@gmail.com>
        <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
        <patch-10.11-a84f670ac24-20210328T021238Z-avarab@gmail.com>
Date:   Mon, 29 Mar 2021 22:50:18 -0700
In-Reply-To: <patch-10.11-a84f670ac24-20210328T021238Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 28 Mar
 2021 04:13:40
        +0200")
Message-ID: <xmqq35wdfaw5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D02621B2-911B-11EB-A2C8-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Fix a regression in 89e4202f982 ([PATCH] Parse tags for absent
> objects, 2005-06-21) (yes, that ancient!) and correctly report an
> error on a tag like:
>
>     object <a tree hash>
>     type commit
>
> As:
>
>     error: object <a tree hash> is tree, not a commit
>
> Instead of our long-standing misbehavior of inverting the two, and
> reporting:
>
>     error: object <a tree hash> is commit, not a tree
>
> Which, as can be trivially seen with 'git cat-file -t <a tree hash>'
> is incorrect.

Hmph, I've always thought it is just "supposed to be a" missing in
the sentence ;-)

> Hence the non-intuitive solution of adding a
> lookup_{blob,commit,tag,tree}_type() function. It's to distinguish
> calls from parse_object_buffer() where we actually know the type, from
> a parse_tag_buffer() where we're just guessing about the type.

I think it makes sense to allow the caller to express distinction
between "I know that this object is a blob, because I just read its
object header" and "Another object tells me that this object must be
a blob, because it is in a tree entry whose mode bits are 100644".

I wish we found a set of names better than lookup_<type>_type() for
that, though.  It's just between

      lookup_tag_type(r, oid, OBJ_NONE);
      lookup_tag_type(r, oid, OBJ_TAG);

I cannot quite tell which one is which.  I also wonder if the last
arg should just be a boolean ("I know it is a tag" vs "I heard it
must be a tag").
