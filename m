Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8C3C433EF
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 18:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbiGYS4P (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 14:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbiGYS4O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 14:56:14 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B76D10F
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 11:56:14 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 914801B1519;
        Mon, 25 Jul 2022 14:56:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4E+jea43XqKhVHMixUyZqPJYzf74ARW7kDFUif
        ucywE=; b=eLqVHoNBc6j4ycdg7d2j23zUzcnJ7Djsi8t/JzsXCWt/djdIxuDjKN
        4CABGA9t474f0LnKMoc9U7yWl3lZ+YqTfg1GZ6Y0i7Qh64e3qU7I0eSGHwic4b/f
        0r/GxlENaVEQhDWLHiZA4FSChJKqxtHsVv8Eg5O6+c7VTA1vCHAXM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 89AD71B1518;
        Mon, 25 Jul 2022 14:56:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3BD6C1B1517;
        Mon, 25 Jul 2022 14:56:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com
Subject: Re: [PATCH v2] fetch-pack: write effective filter to trace2
References: <20220715172943.2681492-1-jonathantanmy@google.com>
        <20220718170027.3993042-1-jonathantanmy@google.com>
        <xmqqwncadwzh.fsf@gitster.g>
Date:   Mon, 25 Jul 2022 11:56:09 -0700
In-Reply-To: <xmqqwncadwzh.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        18 Jul 2022 12:47:14 -0700")
Message-ID: <xmqqtu753tti.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7291F81C-0C4B-11ED-BA3D-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Tan <jonathantanmy@google.com> writes:
>
>> +static void write_and_trace_filter(struct fetch_pack_args *args,
>> +				   struct strbuf *req_buf,
>> +				   int server_supports_filter)
>> +{
>> +...
>> +}
>
> The previous round already had the same issue, but this makes it
> even worse by introducing a function that makes it clear that it
> mixes quite unrelated two features (i.e. write the filter to the
> other end, which MUST be done for correct operation of the protocol,
> and write a log to trace2, which may not be even necessary when we
> are not logging at all).
> ...
> In a sense, we can say that the only purpose this helper function is
> to tell the server end what the filter we use is by renaming it; it
> is OK to have debugging statements and logging code as part of the
> implementation of such a function.
>
> I actually like that direction better.  A helper function may exist
> *ONLY* to trace, in which case, having "trace" in its name would
> make perfect sense.  A helper function may exist to perform the real
> work, but it may log what it did to perform the real work as well.
> I think the latter shouldn't have "trace" in its name at all, or our
> helpers will all be called do_FOO_and_trace(), do_BAR_and_debug(),
> etc., which is nonsense.  Just calling do_FOO() and do_BAR(), and
> then having them log or trace as needed, is fine.

After waiting for a week, I still haven't seen any correction to
this patch, but do you want to give the helper function a bit more
sensible name in an updated patch, perhaps say "send_filter()" or
something?

Otherwise the topic looked good.

Thanks.
