Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAB6C433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 18:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DBC960ED4
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 18:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbhJLSas (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 14:30:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50673 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbhJLSar (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 14:30:47 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E5F38E6550;
        Tue, 12 Oct 2021 14:28:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1VQzl6BN3DaMh1k7xGjdyYdZlkdG6DsybM2KZC
        1ZuY4=; b=lXpIyTqLHqHxzvp2pLd1XJ2CvmpUIyEHgp63VXAud9BoEgv+LIgvH7
        ZVSsoEchoQsOF79tZ9VgYIT5G99osWy/BpCvyMLV0GATMwKRiSzbjGgIEUVRN//q
        G7qGTgCydhwwTqfJCZ052BpNF/ZRHwQ295N8KvD32giOo+czvbniA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DD160E654D;
        Tue, 12 Oct 2021 14:28:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5817AE654C;
        Tue, 12 Oct 2021 14:28:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Alex Waite" <alex@waite.eu>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] credential wildcard does not match hostnames containing
 an underscore
References: <28ff3572-1819-4e27-a46d-358eddd46e45@www.fastmail.com>
        <xmqqk0ii3zl6.fsf@gitster.g>
        <2883c3a9-a44f-4b24-acac-5ed573319d27@www.fastmail.com>
Date:   Tue, 12 Oct 2021 11:28:43 -0700
In-Reply-To: <2883c3a9-a44f-4b24-acac-5ed573319d27@www.fastmail.com> (Alex
        Waite's message of "Tue, 12 Oct 2021 20:00:55 +0200")
Message-ID: <xmqqfst63xno.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3B67762A-2B8A-11EC-B5A3-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Alex Waite" <alex@waite.eu> writes:

> Thanks for the response. :-)
>
>> Hmph, given that hostnames cannot have '_' (cf. RFC1123 2.1 "Host
>> Names and Numbers", for example), the third URL seems invalid.  Is
>> this even a bug?
>
> That is a fair question, and I do acknowledge that later on in my bug report (where I provide some additional information).
>
> The core issue, IMO, is that git is not consistent with itself. I
> can write a static rule that will match
> ("https://test_c.example.com") but cannot write a pattern that
> will do so.

I do not know if that is avoidable.

To be able to match a concrete URL that came from the running
session with a pattern taken from the configuration, we'd need to do
some parsing to figure out which part of the URL matches the
wildcard, and to be able to tell which substrings are "parts", there
needs some syntactic rule that says what constitutes a valid word.

I guess that we could make them consistent by treating a literal as
a pattern that does not happen to have any wildcard and reject the
"test_c" hostname the same way in both cases.  I do not offhand know
how desirable such a change would be.


