Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64B2C433E0
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 20:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70F2960234
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 20:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbhA2Ui4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 15:38:56 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54284 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbhA2Uiy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 15:38:54 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D1B67FF362;
        Fri, 29 Jan 2021 15:38:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CmMu7ZUummeAuD6t63/pTrK+lj4=; b=Vz2K91
        JHmhkz/egLSmluciHfMEjgBUpvQnDKHn0bgrFT3rUIlKYgLXHiaQB5mdVPnS+EBe
        O6onLbkvbwGdGxVMSUbrxMun1iqGMpmKsX0jU6noBkN4fWR1/AvqaKgZz7WIXtX/
        fgJrABoRCmkGXBOOYETj0YYRVs8URl+bqAgmw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fDqLNkkBknRhy77vn4PpUbz1kAh0szkg
        4OfRfamVQumpUzjSsuJ0sjC4EObdyKoKvdZ+Dl4bln4m523QAb7O4zLRmO3QFxYj
        OBZlwZcgXptf4fE6EqW0PecX+BjdwQyjtcUDqdZNn74/h52veyjUn9C0E0P6bBN1
        h1Ei0CzuCiU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C9EA4FF361;
        Fri, 29 Jan 2021 15:38:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 19C89FF35F;
        Fri, 29 Jan 2021 15:38:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH 05/10] p5303: measure time to repack with keep
References: <cover.1611098616.git.me@ttaylorr.com>
        <b3b2574d4d9d10f226b52d81fe0e6bf1f761504e.1611098616.git.me@ttaylorr.com>
        <xmqqft2ktnpj.fsf@gitster.c.googlers.com>
        <YBRi4v/AeDD/Zc9X@coredump.intra.peff.net>
Date:   Fri, 29 Jan 2021 12:38:08 -0800
In-Reply-To: <YBRi4v/AeDD/Zc9X@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 29 Jan 2021 14:32:50 -0500")
Message-ID: <xmqqy2gbsclr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E6662EF0-6271-11EB-A85B-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Jan 28, 2021 at 07:40:40PM -0800, Junio C Hamano wrote:
>
>> > diff --git a/t/perf/p5303-many-packs.sh b/t/perf/p5303-many-packs.sh
>> > index 277d22ec4b..85b077b72b 100755
>> > --- a/t/perf/p5303-many-packs.sh
>> > +++ b/t/perf/p5303-many-packs.sh
>> > @@ -27,8 +27,11 @@ repack_into_n () {
>> 
>> this construct:
>> 
>> 	... |
>> 	sed -n '1~5p' |
>> 	head -n "$1" |
>>         ...
>> 
>> which is a GNUism.  Peff often says that very small population
>> actually run our perf suite, and this seems to corroborate the
>> conjecture.
>
> Oops. Looks like I was the one who introduced that. Nobody seems to have
> complained, so I'm somewhat tempted to leave it. But it would not be too
> hard to replace with perl, I think.

Yeah, but would it be worth it?  I am actually OK to say that you
need GNU sed if you want to run perf.  We already rely on GNU time
to run perf tests, no?

