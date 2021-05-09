Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3831FC433B4
	for <git@archiver.kernel.org>; Sun,  9 May 2021 08:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0547561055
	for <git@archiver.kernel.org>; Sun,  9 May 2021 08:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbhEII1j (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 May 2021 04:27:39 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53778 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhEII1h (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 May 2021 04:27:37 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CCCF5127BF0;
        Sun,  9 May 2021 04:26:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IcWoCDUh4fOttN3Mg1IP14buY4E1MsEwQDoc+J
        yqBjc=; b=i6KYVJL84LkpoP+CqSmoIMdNUx6A6WlPt+nfoHYv674Ju547+AhngJ
        TvBBmutgDsmqGiU8qlPbveSvVb/ZzzWSraGo7kfhL+stFSXhIh2KQXxmujOL8Ojp
        OanQKaXi8Rigl4eeUdItOm+v1jRfk7Y9a/70GzVMrRMR5R50YpSDU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B8E61127BEF;
        Sun,  9 May 2021 04:26:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DE9E7127BEE;
        Sun,  9 May 2021 04:26:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom Verma <hariom18599@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 2/2] [GSOC][RFC] ref-filter: introduce enum atom_type
References: <pull.951.git.1620487353.gitgitgadget@gmail.com>
        <3770df1829830229e768607b699730d2a7c21c5e.1620487353.git.gitgitgadget@gmail.com>
        <CAP8UFD0mOmqWUS49wywDVoWOyAkCRSUY5+i7Gqq-ZZSNCr-jvg@mail.gmail.com>
Date:   Sun, 09 May 2021 17:26:29 +0900
In-Reply-To: <CAP8UFD0mOmqWUS49wywDVoWOyAkCRSUY5+i7Gqq-ZZSNCr-jvg@mail.gmail.com>
        (Christian Couder's message of "Sun, 9 May 2021 08:21:41 +0200")
Message-ID: <xmqqh7jctiru.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 42588D76-B0A0-11EB-AE76-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> I am not sure it's worth having an atom_type field for each valid_atom
> element if the value of that field is already the index of the
> element, because then one would always be able to replace
> `valid_atom[i].atom_type` with just `i`. Or is it for some kind of
> type safety issue?

> I wonder if the enum should be instead defined like this:
>
> enum atom_type {
> ATOM_UNKNOWN = 0,
> ATOM_REFNAME,
> ...
> ATOM_ELSE,
> ATOM_INVALID, /* should be last */
> };
>
> As a struct containing an atom_type would typically be initialized
> with 0 after being allocated, `ATOM_UNKNOWN = 0` could ensure that we
> can easily distinguish such a struct where the atom_type is known from
> such a struct where it is unknown yet.
>
> Having ATOM_INVALID as always the last enum value (even if some new
> ones are added later) could help us iterate over the valid atoms using
> something like:
>
> for (i = ATOM_UNKNOWN + 1; i < ATOM_INVALID; i++)
>         /* do something with valid_atom[i] */;

OK.

As to "safety", I think it still makes sense to declare "enum", but
I agree that we do not necessarily have to have it in the valid_atom[]
struct.  We could do something like this instead:

    static struct {
            const char *name;
            info_source source;
            cmp_type cmp_type;
            int (*parser)(const struct ref_format *format, struct used_atom *atom,
                          const char *arg, struct strbuf *err);
    } valid_atom[] = {
           [ATOM_REFNAME] = { "refname", SOURCE_NONE, FIELD_STR, refname_atom_parser },
           [ATOM_OBJECTTYPE] = { "objecttype", SOURCE_OTHER, FIELD_STR, objecttype...
           [ATOM_OBJECTSIZE] = { "objectsize", SOURCE_OTHER, FIELD_ULONG, objectsi...
           ...
