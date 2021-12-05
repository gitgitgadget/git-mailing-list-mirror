Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046E0C433F5
	for <git@archiver.kernel.org>; Sun,  5 Dec 2021 01:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhLEBUi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Dec 2021 20:20:38 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58604 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbhLEBUi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Dec 2021 20:20:38 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 94D82F4D65;
        Sat,  4 Dec 2021 20:17:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JLL1Vru+pyEApFUjU5kY2j4zmNBqIH86BzrNJT
        ilAn8=; b=biw6bzJB66OuUjgHwxNxsCETDQoV4QuQAeMtGDBqxLw3hcaUjMqT/q
        IOxZK1Vk3aXn8C0Hc7+VpghJGjbdQ0SKPc66WHzpDuhdFKj6LXArFo/YhNPXpyzO
        +cFUbWr8fmKbojxBY01lQbyCpLk60nwmCM14vt8CfC2fUy3PgvSAA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D9F6F4D62;
        Sat,  4 Dec 2021 20:17:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CDB0CF4D61;
        Sat,  4 Dec 2021 20:17:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] http-backend: give a hint that web browser access is
 not supported
References: <xmqqee6vwj67.fsf@gitster.g>
        <20211202102855.23907-1-jengelh@inai.de> <xmqqee6spz9s.fsf@gitster.g>
        <7r23s082-o3q0-479o-srqn-r45q778s5nq7@vanv.qr>
Date:   Sat, 04 Dec 2021 17:17:08 -0800
In-Reply-To: <7r23s082-o3q0-479o-srqn-r45q778s5nq7@vanv.qr> (Jan Engelhardt's
        message of "Sat, 4 Dec 2021 12:09:52 +0100 (CET)")
Message-ID: <xmqqtufnonor.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 124CFE28-5569-11EC-A88F-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jan Engelhardt <jengelh@inai.de> writes:

> On Saturday 2021-12-04 09:09, Junio C Hamano wrote:
>
>>Jan Engelhardt <jengelh@inai.de> writes:
>>
>>> When using a browser to access a URI that is served by http-backend,
>>> nothing but a blank page is shown. This is not helpful.
>>>
>>> Emit the same "Request not handled" messages, but to the CGI stream
>>
>>Puzzled.  Same with what?
>
> "Request not handled" is already sent to stderr, which means it (only)
> shows up in the httpd error log.
>
> So now we send "Request not handled" also to stdout, which is what
> the browser will see.
>
>>What is in "pathinfo" parameter?
>
> It is getenv("PATH_INFO").

That part I know.  The question was what would a typical value of
that parameter look like in the context of somebody mistakenly
visiting Git smart HTTP endpoint via their browser.

I am basically wondering if it is helping the user enough, or if it
is sufficient to give just the "err" and "hint", and nothing else.

> Yes, that seems more like it. I was not aware of send_strbuf.

Heh, I wasn't either.  The review of this topic was the first time I
seriously read any part of that file, and I think I still only read
just about 20% of it ;-)

Also, will the real Git clients, which are the primary intended
audiences this program is trying to talk to, be OK if we suddenly
start giving a non-empty 404 page?

If any implementations of Git HTTP client this program is serving
(1) uses a 404 response as a cue to decide its next request
(e.g. there may be some "try this URL and if it fails, do another
one" fallback logic), and (2) depends on our 404 response to be
without any body, we'd be breaking the service for our primary
audience, only to mollify those who visit our HTTP endpoint that
they should not be visiting in the first place via the browser,
which would be worse than embarrassing.

Thanks.
