Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E303E207DF
	for <e@80x24.org>; Fri, 16 Sep 2016 21:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965167AbcIPU7y (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 16:59:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64186 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S936132AbcIPU7v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 16:59:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D88253F0DC;
        Fri, 16 Sep 2016 16:59:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J278KXlvNve0umiIJpJsmLgyPHA=; b=SgShgK
        n+DqAdfvQG0BKayhxm7wQn6PEBu22tdAprldCbrAyQmKf5RB/3A6BOO832qvXcwc
        Bc5Ycz2oCgyaiZuZoxRzsAnSWF+BJU4EY93e1dOtFGTaOMaTrOOTF3DoSefUA2lR
        DoWKZJFP2gQOKW1uXK90c3/fie4DC0XI6bmTo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fgUcQmrT6OAyJyxGwzdRrE2THZmRDrgu
        tA1J5vjMECswbG3Qx0qP0ZDs6R4C14I+8V2NoD3UHpK2EbBrASaGig+BAzo0zDMt
        JdZYqSXcSvtytTaWgT2eOdh9LW1aICtn9uoExJTs41JxieYHt1snEG7ytENCoxb9
        J0BIRlwCQgI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D110E3F0DB;
        Fri, 16 Sep 2016 16:59:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5984D3F0D9;
        Fri, 16 Sep 2016 16:59:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [RFC/PATCH 3/3] mailinfo: handle in-body header continuations
References: <cover.1474047135.git.jonathantanmy@google.com>
        <20160907063819.dd7aulnlsytcuyqj@sigill.intra.peff.net>
        <cover.1474047135.git.jonathantanmy@google.com>
        <0152df30db0972d61ff45b2b099ad1242aacd431.1474047135.git.jonathantanmy@google.com>
        <xmqq8turk3aw.fsf@gitster.mtv.corp.google.com>
        <1b392241-461e-3b87-400d-70d66903e3d7@google.com>
Date:   Fri, 16 Sep 2016 13:59:46 -0700
In-Reply-To: <1b392241-461e-3b87-400d-70d66903e3d7@google.com> (Jonathan Tan's
        message of "Fri, 16 Sep 2016 13:49:18 -0700")
Message-ID: <xmqqshszimrh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 80EFFBE8-7C50-11E6-9C35-096F12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> handle_commit_msg(...)
>> {
>> 	if (mi->in_line_header->len) {
>> 		/* we have read the beginning of one in-line header */
>> 		if (line->len && isspace(*line->buf))
>
> This would mean that a message like the following:
>
>   From: Me <me@example.com>
>     -- 8< -- this scissors line will be treated as part of "From"
>
> would have its scissors line treated as a header.
>
> The main reason why I reordered the checks (in RFC/PATCH 1/3) is to
> avoid this (treating a scissors line with an initial space immediately
> following an in-body header as part of a header).
>
> (If this is not a concern then yes, I agree that the way you described
> is simpler and better.)

Ahh, OK.  I do not think anybody sane would do the "From:" thing,
but with the "does it look like 2822 header" check to decide if the
first header-looking line should be queued, another failure mode may
be:

	any-random-alpha-and-dash-string: 
         -- >8 -- cut here -- >8 --
        Subject: real subject

        The first line of the real message
        
I personally do not think it matters that much, but if we wanted to
protect us from it we could easily do

        if (mi->in_line_header->len) {
                /* we have read the beginning of one in-line header */
                if (line->len && isspace(*line->buf) &&
                    !(mi->use_scissors && is_scissors_line(line))) {
                        append to mi->in_line_header strbuf;
                        return 0;
                }
                /* otherwise we know mi->in_line_header is now complete */
                check_header(mi, mi->in_line_header, ...);
                strbuf_reset(&mi->in_line_header);
        }
	...

instead, I think.
