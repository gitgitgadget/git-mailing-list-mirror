Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C64E72018E
	for <e@80x24.org>; Mon,  8 Aug 2016 16:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312AbcHHQL5 (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 12:11:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50773 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751479AbcHHQL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 12:11:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B4FCE31571;
	Mon,  8 Aug 2016 12:11:55 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3bctbmk9z2pE6iDWdIh/JVdpa9o=; b=D+UdJf
	ejCDp7wtm7DUzYMuheNMKgcWw0GDiO15UIX/6Fy14v94r5RUF8nWFIvCnXOyImZu
	e1ffN9hh6sz48H37DHaoE/4Gm3s0WkWZAa+SwnpMZwuXVaad+yh8d4FvPrVwrgiG
	1WHKrv92mqj3psqWd7A60TubIxCMyUfJzP87U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j1VCvlDVxHLPFQiozgZiSvEcVA7UCS0W
	K0A3lkqNuwcqFr8D+kvk+s4/EKKGgWFfQ81ZWzw6PVLSMPS1vXlONDDj6Xtb1DL+
	7bGNQAoUxcvbxRLm8+81LSWKl/YtFN4wssF8+o74pwVfabjMNYXoI2NN0fQDWpfI
	YwpMJcUtxZQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AC7EE3156C;
	Mon,  8 Aug 2016 12:11:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2DF2431565;
	Mon,  8 Aug 2016 12:11:55 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Kirill Smelkov <kirr@nexedi.com>
Cc:	Jeff King <peff@peff.net>, Vicent Marti <tanoku@gmail.com>,
	=?utf-8?Q?J=C3=A9rome?= Perrin <jerome@nexedi.com>,
	Isabelle Vallet <isabelle.vallet@nexedi.com>,
	Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
	Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] pack-objects: Teach --use-bitmap-index codepath to respect --local, --honor-pack-keep and --incremental
References: <20160729074051.GA5987@teco.navytux.spb.ru>
	<20160729074656.23813-1-kirr@nexedi.com>
	<xmqqy44gjqv9.fsf@gitster.mtv.corp.google.com>
	<20160808123734.GA3995@teco.navytux.spb.ru>
Date:	Mon, 08 Aug 2016 09:11:53 -0700
In-Reply-To: <20160808123734.GA3995@teco.navytux.spb.ru> (Kirill Smelkov's
	message of "Mon, 8 Aug 2016 15:37:35 +0300")
Message-ID: <xmqqfuqfgrzq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D33F2A14-5D82-11E6-A570-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Kirill Smelkov <kirr@nexedi.com> writes:

>> > ...
>> > Suggested-by: Junio C Hamano <gitster@pobox.com>
>> > Discussed-with: Jeff King <peff@peff.net>
>> > ---
>> 
>> I do not think I suggested much of this to deserve credit like this,
>> though, as I certainly haven't thought about the pros-and-cons
>> between adding the same "some object in pack may not want to be in
>> the output" logic to the bitmap side, or punting the bitmap codepath
>> when local/keep are involved.
>
> I understand. Still for me it was you who convinced me to add proper
> support for e.g. --local vs bitmap instead of special-casing it.

OK, in such a case, it probably is more sensible to do it like:

    ...
    with all differences strangely showing we are a bit faster now, but
    probably all being within noise.

    Credit for inspiring this solution and discussing the design of
    the change goes to Junio and Jeff King.

    Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
    ---
     builtin/pack-objects.c  |  36 ++++++++++++-----
     t/t5310-pack-bitmaps.sh | 103 ++++++++++++++++++++++++++++++++++++++++++++++++
     2 files changed, 130 insertions(+), 9 deletions(-)

Don't forget your own sign-off ;-)
