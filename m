Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F40C433DB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 02:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 941CF64DFA
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 02:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhA2Cd5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 21:33:57 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56827 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhA2Cd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 21:33:56 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BA35DFCA28;
        Thu, 28 Jan 2021 21:33:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=ALGHJHoNwDy+CA/6xtWoazHP6k0=; b=DSg8cTAVPPByrKnWul87
        jg/f/abdQTKHrZcn9AYmKIvfiHGHbkbLOoezUJcJkE1O+20oRxM/kktkR2VJKji5
        QTONbOdV9lctkWPXLjA1oNJkIO6HgIn3BEPoP78fngx0wlBwTCUY+lrVy6O8Qs6r
        a09772eQQ9/8RD1TsxezI4k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=M8iwWyiCIv0GhTSV475qA3FlaJraWIRXhZTLp3cfrHcEQ4
        kMAJtttOMc0MGZQHguGKcg26UHlfHt+hqerVoHDH9v5+mWikxaVpyxD0utehuXra
        I7DMx63dUKS9k6hvjhlcrUCjkz58zfSr+4BXtWr7a8wDLStRHJ3rMHzUSJEOs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A5012FCA27;
        Thu, 28 Jan 2021 21:33:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DE722FCA26;
        Thu, 28 Jan 2021 21:33:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com
Subject: Re: [PATCH 01/10] packfile: introduce 'find_kept_pack_entry()'
References: <cover.1611098616.git.me@ttaylorr.com>
        <dc7fa4c7a61f657e779e10385d3e8076d6dac36c.1611098616.git.me@ttaylorr.com>
Date:   Thu, 28 Jan 2021 18:33:10 -0800
Message-ID: <xmqqwnvwtqu1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 54D9D8F2-61DA-11EB-B782-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Future callers will want a function to fill a 'struct pack_entry' for a
> given object id but _only_ from its position in any kept pack(s). They
> could accomplish this by calling 'find_pack_entry()' and checking
> whether the found pack is kept or not, but this is insufficient, since
> there may be duplicate objects (and the mru cache makes it unpredictable
> which variant we'll get).

I wonder if we eventually need a callback interface to walk _all_
pack entries for a given object, so that "I am only interested in
instances in kept packs" will be under total control of the callers.
As it stands, it is "just grab any one that is in a kept pack, any
one of them is fine", which is almost just of as narrow utility as
the original's "just grab the first one---any one of them is fine",
the latter of which is "insufficient" as the log message says.

But this (in the context of the remainder of the series) might be
sufficient, at least for now.

> Teach this new function to treat the two different kinds of kept packs
> (on disk ones with .keep files, as well as in-core ones which are set by
> manually poking the 'pack_keep_in_core' bit) separately. This will
> become important for callers that only want to respect a certain kind of
> kept pack.

Or maybe not ;-)

If there are notable relationship between on-disk and in-core kept
packs (e.g. "the set of on-disk kept packs is a subset of in-core
kept packs", "usually on-disk kept packs get in-core kept bit upon
their packed_git instances are populated, but we can drop the bit at
runtime, so on-disk and in-core are pretty much independent and
there is no notable relationship"), it must be explained upfront to
help the reader form a sensible world view.

> Introduce 'find_kept_pack_entry()' which behaves like
> 'find_pack_entry()', except that it skips over packs which are not
> marked kept. Callers will be added in subsequent patches.
>
> Co-authored-by: Jeff King <peff@peff.net>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>

Fun.

Thanks.
