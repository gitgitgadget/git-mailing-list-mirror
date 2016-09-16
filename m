Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AF0B207DF
	for <e@80x24.org>; Fri, 16 Sep 2016 23:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757772AbcIPXEx (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 19:04:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50522 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753932AbcIPXEv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 19:04:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E9EF140309;
        Fri, 16 Sep 2016 19:04:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kFx88QXyb4o6ufKgGtwNcGkIvHY=; b=XA3PdZ
        hOJ1VfyklBE+ECp6+/n7WR7qA2Veobr9lbPJo/MAWCd8O1ho6k/8Snw0/PeMzjiH
        yWaizMHWkvcbeYqhtPB6Asba2SKpnkivJWW48ryVk37nbera80sgXFIC/SFwPtMn
        7fK6x3iZaungZ8R7citBGqJXai2t8ANlvgXFI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MeUfCgHQJFcZrRsbxmkyUik/v3DYYeIO
        VZCBUWCB/x+Twdh6YArCzP6qmcdSR+cuPope0/rBiv00syeHq2D7+pdisYl6bkiw
        psjd1EOfUd4+Qwn9nQMb1byN1zXdzWxfVZZ37M7g8FjrXRh0ggYDLgUho+hPg25e
        0tD1CAsOzOg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E191340308;
        Fri, 16 Sep 2016 19:04:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5C47840307;
        Fri, 16 Sep 2016 19:04:38 -0400 (EDT)
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
        <xmqqshszimrh.fsf@gitster.mtv.corp.google.com>
        <128036e3-47b4-b7ae-034f-8d227a62729f@google.com>
Date:   Fri, 16 Sep 2016 16:04:36 -0700
In-Reply-To: <128036e3-47b4-b7ae-034f-8d227a62729f@google.com> (Jonathan Tan's
        message of "Fri, 16 Sep 2016 15:36:05 -0700")
Message-ID: <xmqq7fabigzf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F154AD46-7C61-11E6-89B6-096F12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> On 09/16/2016 01:59 PM, Junio C Hamano wrote:
>>         if (mi->in_line_header->len) {
>>                 /* we have read the beginning of one in-line header */
>>                 if (line->len && isspace(*line->buf) &&
>>                     !(mi->use_scissors && is_scissors_line(line))) {
>
> Minor note: this means that the scissors check appears twice in the
> code, once here and once below (for the non-header case).

Yes.  I actually was wondering if it is even more sensible to always
have the scissors check at the very beginning.  Even if we saw a
half-written in-body header already in the message, when we see a
scissors line, we clear the slate and restart as if the line after
the scissors is the first line in the body of the message.

>>                         append to mi->in_line_header strbuf;
>>                         return 0;
>>                 }
>>                 /* otherwise we know mi->in_line_header is now complete */
>>                 check_header(mi, mi->in_line_header, ...);
>
> (Sorry - should have also noticed this in your original e-mail.)
>
> I'm concerned about what happens if check_header fails - we would then
> have some lines which need to be treated as log messages. (At least,
> they are currently treated that way.)

I actually think we should refactor check_header() further so that
in-body header processing does not even see things that shouldn't be
changed.  The current check_header() should be used only for real
mail headers, and then a reduced version of check_header() that is
called for in-body will _ONLY_ handle the header lines that are
handled by the first "search for the interesting parts" loop.

And of course we would update your "does it look like rfc2822?" to
match what are handled by the "interesting parts" loop.  That I
think would match the current behaviour much better, I would think.

The ">From " and "[PATCH]" cases in check_header() should not even
be there.  We should handle them inside handle_commit_msg(), as
these two cases should never appear in the real header part of a
message.

And if we clean it up like that, I do not think we would ever need
to worry about "ah, it looked like a header but it is not after
all".  And not having to worry about it is a good thing and should
be one of the primary goals in this conversion, I whould think.

Thanks.


