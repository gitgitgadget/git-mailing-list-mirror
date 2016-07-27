Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4077A1F855
	for <e@80x24.org>; Wed, 27 Jul 2016 21:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbcG0Vhb (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 17:37:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62177 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757989AbcG0Vha (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 17:37:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2EBBB302C1;
	Wed, 27 Jul 2016 17:37:29 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uhHh4RIwsLCZRM5sb7HX+ToH84k=; b=bM81MK
	WLrnvOKk3MIZjAmWcW364dmjx/G4OL1R9pSfCWrbyd0uuPN7Tu4HX95yzhL/7jXx
	enUrnBSsmTes2gHr3cUoML5MUDDHHZQv6CHEfr2YJ6n3W+w3rjdGSXN7FApYs/fr
	CmYKPUOtnd1/y96B4yjlvRJ0veXuYEnOgXhu0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F4y8tznKmmrNwR8T37AYkoFFdMV293Y6
	18/uCW94FyYOA3XdFZgkQ1iC4nm9yPmUQNxAYcgwuHxP9HzVinBi1bjBZmE00qLK
	p9clwluA+w3QcAdkqqyk9O8pf7eu516I5vTelSFmFpnnPIszOXj/TkPZbDB/dwqi
	9y9eht45xGs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 23F70302BF;
	Wed, 27 Jul 2016 17:37:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 99A40302BE;
	Wed, 27 Jul 2016 17:37:28 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v5 12/16] merge-recursive: flush output buffer before printing error messages
References: <cover.1469187652.git.johannes.schindelin@gmx.de>
	<cover.1469547160.git.johannes.schindelin@gmx.de>
	<349bdfacfffa11d06241655c9e0b62506e58758b.1469547160.git.johannes.schindelin@gmx.de>
Date:	Wed, 27 Jul 2016 14:37:26 -0700
In-Reply-To: <349bdfacfffa11d06241655c9e0b62506e58758b.1469547160.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Tue, 26 Jul 2016 18:06:34 +0200
	(CEST)")
Message-ID: <xmqqh9bavk2x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 51209AD4-5442-11E6-99AF-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> The data structure passed to the recursive merge machinery has a feature
> where the caller can ask for the output to be buffered into a strbuf, by
> setting the field 'buffer_output'.
>
> Previously, we simply swallowed the buffered output when showing error
> messages. With this patch, we show the output first, and only then print
> the error message.

I didn't quite understand this paragraph until I realized that you
meant "when showing die message".  We died without flushing, losing
accumulated output.

> +static int err(struct merge_options *o, const char *err, ...)
> +{
> +	va_list params;
> +
> +	va_start(params, err);
> +	flush_output(o);

I would have written the above two swapped; va_start() logically
is about what happens in the next four lines.

> +	strbuf_vaddf(&o->obuf, err, params);
> +	error("%s", o->obuf.buf);
> +	strbuf_reset(&o->obuf);

Sneaky ;-)

The remainder replaces error(...) with err(o, ...) and updates the
callchain to pass the merge_options around, which looked good.

Thanks.
