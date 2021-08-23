Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7B0C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 17:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A93E61391
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 17:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhHWR65 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 13:58:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61162 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbhHWR64 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 13:58:56 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 08203EF198;
        Mon, 23 Aug 2021 13:58:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DugL37Gl3CbqNTWrmWdquxfteYaeLi1oMvJwwd
        tHom8=; b=W/hBtdBF9XzgOau4V4FKOzeUNJ0/GRPPYgKmYfGpfaqmyN97LflG+6
        qnXkkU/9B3U9/vjTlC7+RZjHevg/N8A6ylglq66eVDbKQbTDZj+NJfRsDStSPDYx
        uqRNaOqdZ9wl6TOWtRpKdUCw9PMSeETIl72eLMbfOsdrAIgJvW3Mo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0004EEF197;
        Mon, 23 Aug 2021 13:58:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6E0ABEF196;
        Mon, 23 Aug 2021 13:58:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v2] multi-pack-index: fix *.rev cleanups with --object-dir
References: <20210823094049.44136-1-johannes@sipsolutions.net>
        <YSPHdofrDOQk3xmy@coredump.intra.peff.net>
        <be882704d7cf2a96a78c5c745c0bca2c53150a28.camel@sipsolutions.net>
        <YSPWQtOjKVgIKqsd@nand.local>
Date:   Mon, 23 Aug 2021 10:58:09 -0700
In-Reply-To: <YSPWQtOjKVgIKqsd@nand.local> (Taylor Blau's message of "Mon, 23
        Aug 2021 13:09:22 -0400")
Message-ID: <xmqqk0kcqc0e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ADA936E0-043B-11EC-A623-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Mon, Aug 23, 2021 at 07:05:31PM +0200, Johannes Berg wrote:
>> On Mon, 2021-08-23 at 12:06 -0400, Jeff King wrote:
>> > I'm not entirely convinced that writing a midx when not "inside" a repo
>> > is something that we want to support. But if we do, then...
>>
>> Seemed like that was the point of --object-dir?
>
> Stolee (cc'd) would know more as the original author, but as I recall
> the point of `--object-dir` was to be able to write a midx in
> directories which were acting as Git repositories, but didn't contain a
> `.git` directory.
>
> It's kind of a strange use-case, but I recall that it was important at
> the time. Maybe he could shed more light on why. (Either way, we're
> stuck with it ;)).

It does sound strange.  "git -C $there multi-pack-index write"
would have felt more natural.
