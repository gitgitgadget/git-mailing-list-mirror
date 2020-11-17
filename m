Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA89C388F9
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 00:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB08A223C7
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 00:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="l7j4cHGn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731588AbgKQAqL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 19:46:11 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57753 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731546AbgKQAqL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 19:46:11 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 023D58A5CD;
        Mon, 16 Nov 2020 19:46:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yixIU0yQWXHGvwHfSSoyntgJYBQ=; b=l7j4cH
        GnsFD4Y0qVw1OfooLKp7f973tryYetD++zCa89tCbijldXVuasPXc2IxhVicnzr9
        BK5NCRMd4EZ/y/EZRzUE2aK901LgTqoXyBjXCjTCtBZ4RL6ThURRgm0tFncfTern
        Ut+QK4/a+m647NNCtvAJU4WzWhidqSkM6saOc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YvU0IQBqAJc8g+nwJn+fG+39wImlCVf/
        AOjAl53rrVgJVicl4zCb1JZttkrB7o3gGfYlqyWCXe3BPHsZ1U6shEalL79/5sXa
        wawRJ3B6zF3sC2DiUYlMnNY/pSW89l8w9DaflRG6fUr8LU3Qjd8jNKRnw3dQeZgz
        CXovWkSRzmg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BA01D8A5CC;
        Mon, 16 Nov 2020 19:46:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 99D948A5CA;
        Mon, 16 Nov 2020 19:46:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 3/3] builtin/repack.c: don't move existing packs out of
 the way
References: <cover.1605552016.git.me@ttaylorr.com>
        <d4e73aad14189a00621da9e000d2c6a5fe776d84.1605552016.git.me@ttaylorr.com>
        <xmqqpn4c7uf2.fsf@gitster.c.googlers.com>
        <X7MYifflg7SaTRXm@nand.local>
Date:   Mon, 16 Nov 2020 16:46:06 -0800
In-Reply-To: <X7MYifflg7SaTRXm@nand.local> (Taylor Blau's message of "Mon, 16
        Nov 2020 19:25:45 -0500")
Message-ID: <xmqqd00c7qup.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 478CD2E4-286E-11EB-B25E-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> In any case, much of what I speculated while reading the proposed
>> log message turned out to be false, which may be a sign that the log
>> message did not explain the approach clearly enough.  I thought that
>> a newly created file that happened to be identical to existing ones
>> would be discarded without getting renamed to their final location,
>> but the code does not do such special casing.  I thought the
>> 'metadata' it talks about were to compensate for side effects of
>> reusing the old files, but that was not what the 'metadata' was even
>> about.
>
> It's more about: ...

You do not have to explain that to me here.  Instead explain that to
future readers of our history in the commit log message.

Thanks.
