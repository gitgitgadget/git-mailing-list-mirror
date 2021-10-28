Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87540C433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 22:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BB3C610E5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 22:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbhJ1WtM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 18:49:12 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63338 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbhJ1WtK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 18:49:10 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D44A61561F0;
        Thu, 28 Oct 2021 18:46:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+P3WlFpfEPyokuqvGE8M9iCgcnS0dMzY+DfU2i
        7SLsI=; b=HeU+5MlTDsv6RdHtOHqNslUn1UJ6Jivg68BnQX17Tq1hqDicQzZhfz
        lg/rzHGO0q25yeN9tO2/LQAhIDHaow2TbFOIJQ6DTB6xTwKEncCv8b6En/EUqgdL
        dAErBBSEDKmdYqVdhpkxiIoFnDhACTQUiwuVJUQfesuceqTuPECAM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CD1241561EF;
        Thu, 28 Oct 2021 18:46:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 33D991561EE;
        Thu, 28 Oct 2021 18:46:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ivan Frade <ifrade@google.com>
Cc:     Ivan Frade via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v4 1/2] fetch-pack: redact packfile urls in traces
References: <pull.1052.v3.git.1634684260142.gitgitgadget@gmail.com>
        <pull.1052.v4.git.1635288599.gitgitgadget@gmail.com>
        <973a250752c39c3fe835d69f3fbe8f009fc4fa74.1635288599.git.gitgitgadget@gmail.com>
        <xmqq35omt11f.fsf@gitster.g>
        <CANQMx9WFKJAGF+7zti8+-b2je9sFuNxwOx-LCPtEoGCea54Mdw@mail.gmail.com>
Date:   Thu, 28 Oct 2021 15:46:39 -0700
In-Reply-To: <CANQMx9WFKJAGF+7zti8+-b2je9sFuNxwOx-LCPtEoGCea54Mdw@mail.gmail.com>
        (Ivan Frade's message of "Thu, 28 Oct 2021 15:15:05 -0700")
Message-ID: <xmqqa6ispy28.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EA575016-3840-11EC-B47A-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ivan Frade <ifrade@google.com> writes:

>> Hmph, the format we expect is "<hash> <uri>"; don't we need to
>> validate the leading <hash> followed by SP?
>
> I was trying to find a uri in a packet in general, not counting on the
> packfile-uri line format. That is probably an overgeneralization.

Ah, I see.  This is merely a tracing, so we might benefit from a
generalized version of redactor, and from that point of view, the
use of strstr and stopping at the whitespace do make sort-of sense
to me, but then we lack any attempt to redact more than one instance
of URL in a packet, so the generalization may have quite a limited
usefulness.

> Next patch version follows these suggestions to look for a packfile-uri line.

Yeah, I think that is a good way to go, at least for now.  When we
want a more general one, we can revisit it, but not now.

>> > -     packet_trace(buffer, len, 0);
>> > +     if (options & PACKET_READ_REDACT_URL_PATH &&
>> > +         (url_path_start = find_url_path(buffer, &url_path_len))) {
>> > +             const char *redacted = "<redacted>";
>> > +             struct strbuf tracebuf = STRBUF_INIT;
>> > +             strbuf_insert(&tracebuf, 0, buffer, len);
>> > +             strbuf_splice(&tracebuf, url_path_start - buffer,
>> > +                           url_path_len, redacted, strlen(redacted));
>> > +             packet_trace(tracebuf.buf, tracebuf.len, 0);
>> > +             strbuf_release(&tracebuf);
>>
>> I briefly wondered if the repeated allocation (and more
>> fundamentally, preparing the redacted copy of packet whether we are
>> actually tracing the packet in the first place) is blindly wasting
>> the resources too much, but this only happens in the protocol header
>> part, so it might be OK.
>
> We only allocate and redact if it looks like a packfile-uri line, so
> it shouldn't happen too frequently.

I was mostly wondering about the cost of determining "if it looks
like?".  But we do this only for the protocol header part, so we
won't have thousands of attempts to match, I guess.  Oh, or if we
also do this for the ref advertisement packets, then we might have
quite a many.  Hmph.

> I move the set/unset of the redacting flag to the FETCH_GET_PACK
> around the "packfile-uris" section.
> There is no need to check every incoming packet for a packfile-uri
> line, we know when they should come.

Yeah, that is quite a wise design decision, I would think.

Thanks.
