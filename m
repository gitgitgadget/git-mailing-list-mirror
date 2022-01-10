Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFB5C433F5
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 17:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237655AbiAJRDZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 12:03:25 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62034 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237327AbiAJRDZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 12:03:25 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A75E018520B;
        Mon, 10 Jan 2022 12:03:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tMwV1M5hiPSw+xd/P73MFJ7B32XkEa3aLAI6Ud
        USK+4=; b=HmAW8UC1WPJ+lgV26opiZ/rIBSMn5Lu6Zf+OtLlqpcpgmi4WjSaSDJ
        PI75wfpFyxg34uhGi3C2IrPT6+lEPPToLuI3/wn3JLy5Z25dIWIrPxzHqmh/rkw2
        iLHkSqeok3VirM5iOPdsKCOo9gE2DmmDzvPkhTPSqRJjDXVbTXU3s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8CC3918520A;
        Mon, 10 Jan 2022 12:03:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EA678185209;
        Mon, 10 Jan 2022 12:03:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Fabian Stelzer <fs@gigacodes.de>, git@vger.kernel.org,
        Pedro Martelletto <pedro@yubico.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3] gpg-interface: trim CR from ssh-keygen
References: <20220103095337.600536-1-fs@gigacodes.de>
        <20220107090735.580225-1-fs@gigacodes.de>
        <YdtVrT4gBvnXfNr6@flurp.local>
Date:   Mon, 10 Jan 2022 09:03:20 -0800
In-Reply-To: <YdtVrT4gBvnXfNr6@flurp.local> (Eric Sunshine's message of "Sun,
        9 Jan 2022 16:37:49 -0500")
Message-ID: <xmqq8rvn34mf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3764D826-7237-11EC-9E73-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> of the existing string-splitting functions. For instance, something
> like this:
>
>     struct strbuf **line, **to_free;
>     line = to_free = strbuf_split(&ssh_principals_out, '\n');
>     for (; *line; line++) {
>         strbuf_trim_trailing_newline(*line);
>         if (!(*line)->len)
>             continue;
>         principal = (*line)->buf;
>
> keeping in mind that strbuf_trim_trailing_newline() takes care of
> CR/LF, and with appropriate cleanup at the end of the loop:
>
>         strbuf_list_free(to_free);
>
> (and removal of `FREE_AND_NULL(principal)` which is no longer needed).
>
> Something similar can be done with string_list_split(), as well.

Unless you are writing an interactive text editor, an array of
lines, each of which can individually be manupulated cheaply when
inserting or deleting a span of chars, is a way too ugly and overly
expensive data structure to keep your data in the long haul.  In
short, strbuf_split() was a mistaken piece of API that does not
belong to this project ;-)

The cycles spent by crypto before getting to this point in the code
is expensive enough that the extra cycles to separately scan to
split them into lines and another scan from the end of the each line
to trim may not matter, so I'd stop at saying "I'd rather not to see
the above code" instead of my usual "Please don't", from performance
perspective in this case.

But from code cleanliness perspective, well, let me just say that
this is not Python or Java but a C project.


