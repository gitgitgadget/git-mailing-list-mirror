Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8052C433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 22:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA8B961A7B
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 22:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355738AbhJAWEZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 18:04:25 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52384 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhJAWEY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 18:04:24 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0AAC7153C94;
        Fri,  1 Oct 2021 18:02:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9izoujnULLgCkWsmFoHnGRb7UbjuVE2wjf0k5L
        HRYZU=; b=JjnLUBFDDQSzRRdF+7RJK2LtJf06uaGPf2qwvXz/mlvmg+glFhlpjc
        eocFWoZknyPJn6gceMwQk/VeyyxAJUugguApM6e//R7n1Q22wRkGrqWVrQT9Tcdf
        gOmp8LUWvQVHRxqv9FtUZxakH5FNFqSLZEpmDZhg4sem1/SV1Vybw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 02D08153C93;
        Fri,  1 Oct 2021 18:02:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8E916153C92;
        Fri,  1 Oct 2021 18:02:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jeff King <peff@peff.net>, Neeraj Singh <nksingh85@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2021, #08; Mon, 27)
References: <xmqq8rzhmsi7.fsf@gitster.g>
        <CABPp-BGuzd_TH57-1RvwJQD5r3S3ZkJcuiPnU8aWee8pgzUBEw@mail.gmail.com>
        <YVOn3hDsb5pnxR53@coredump.intra.peff.net>
        <20210929184339.GA19712@neerajsi-x1.localdomain>
        <YVVyUkwYNfkEqNfU@coredump.intra.peff.net>
        <CABPp-BH6ZzC9p94xda3SqfL0JjxoVAb3oV57a9cpg2ZDc=5NNA@mail.gmail.com>
        <xmqq7dew8yq6.fsf@gitster.g>
        <CABPp-BEhLQ3b8OCn3EbTa=g7uh_YXmkQuuGazn=OsT=bG3ot1w@mail.gmail.com>
Date:   Fri, 01 Oct 2021 15:02:36 -0700
In-Reply-To: <CABPp-BEhLQ3b8OCn3EbTa=g7uh_YXmkQuuGazn=OsT=bG3ot1w@mail.gmail.com>
        (Elijah Newren's message of "Fri, 1 Oct 2021 11:12:22 -0700")
Message-ID: <xmqqr1d42ykj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A0E3DB0-2303-11EC-A0F7-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> So with that out of the way, let's return to discussing the textconv
> cache.  If the remerge-diff results aren't cached, isn't it unsafe to
> allow the textconv cache to persist anything while remerge-diff is
> running because it could create corruption?

I do not think anybody involved in this thread thinks it is
practical to annotate each write_object_file() with "this is
temporary" vs "this is to persist", so it is a given that it would
be all-or-none.  If we want write_object_file() called while we are
running remerge-diff to write to a temporary object store, we have
to accept any other write_object_file() called by somebody else,
like textconv cache, must become temporary.

It may be sufficient to plug ref updates (which would cover the
finialization of notes-cache used by the textconv cache) to avoid
corruption, but that might give us a pointless and unpleasant error
message, so it may be necessary to teach the notes-cache stuff to
allow getting existing cached data while disabling it to accept
cache updates.

Thanks.

