Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ACAB2018A
	for <e@80x24.org>; Tue, 28 Jun 2016 15:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999AbcF1PNL (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 11:13:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58122 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751158AbcF1PNL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 11:13:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 776182368B;
	Tue, 28 Jun 2016 11:13:09 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kW3R520Z9CRs64S7r7HrxFQI+sI=; b=bL0J4q
	8e8yjsIP/9eC4c13Hw5Qx8YaT4FCOt0aJqfe4u2+OPcBlCX0VpQswv0ASGka5Jmg
	/ELwS8N6EYZSYp5yn3DtUpQZdqfkVQaTnLjXzxcHQxaswhJK62aCdHR8ZrH1L2HT
	QK+ZrjvPOlkFR6BzTdNSi9RuxtLpAo2nikNnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lDmPUQLs0HOvtEsEf/csHDVVybU7E/ql
	nNs3esMWivqHEoJ7XmFoKaBJhw1btkFjvVESvyoqZ7y0xoJymC4d7EyInWKQYprq
	mMcgDeM6nHG8iDt4mRfX29W3GVZfAZY6+59ZhcVGp9NpXs1lE5JRPk1jd44mfnHq
	cUKkPSlOVpM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6F4DC2368A;
	Tue, 28 Jun 2016 11:13:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E72ED23689;
	Tue, 28 Jun 2016 11:13:08 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Jeff King <peff@peff.net>, Lukas Fleischer <lfleischer@lfos.de>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@fluxnic.net>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] Refactor recv_sideband()
References: <20160613195224.13398-1-lfleischer@lfos.de>
	<20160614210038.31465-1-lfleischer@lfos.de>
	<20160624153121.GA2494@sigill.intra.peff.net>
	<alpine.DEB.2.20.1606241942220.12947@virtualbox>
	<20160624181414.GA25768@sigill.intra.peff.net>
	<CAPc5daWxWpMe4ob4zu0tMK4uWpLPDxC7GS8KTb4+3g5=ztv71A@mail.gmail.com>
	<146702508453.24123.590646528169139972@s-8d3a37fa.on.site.uni-stuttgart.de>
	<xmqqr3bibpap.fsf@gitster.mtv.corp.google.com>
	<20160627161616.GA4430@sigill.intra.peff.net>
	<alpine.DEB.2.20.1606281203000.12947@virtualbox>
	<alpine.DEB.2.20.1606281204330.12947@virtualbox>
Date:	Tue, 28 Jun 2016 08:13:06 -0700
In-Reply-To: <alpine.DEB.2.20.1606281204330.12947@virtualbox> (Johannes
	Schindelin's message of "Tue, 28 Jun 2016 12:05:36 +0200 (CEST)")
Message-ID: <xmqqr3bh9wjh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D27826CC-3D42-11E6-9335-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Erm, sorry...
>
> On Tue, 28 Jun 2016, Johannes Schindelin wrote:
>
>> [...] we actually do not override fprintf() at all anymore [*1*] [...]
>
> ... forgot the
>
> Footnote *1*: In Git for Windows, we actually *do* override fprintf(),
> thanks to using gettext, but it is *gettext* that is doing the overriding
> now, not Git.

That's nice to know but is not particularly actionable.  

Do you mean

 - We do color correctly without having to override fprintf() these
   days, so feel free and safe to use either fwrite() or write()

 - Because we do not override fprintf(), we no longer do colors

 - Or something in between, e.g. "we don't override fprintf()
   ourselves but gettext does X for us (for unknown value of X), so
   you will get color as long as you do Y (for unknown value of Y)"?

In other words, based on this piece of knowledge you shared with us,
what is your recommendation for Lukas's patch to do?

Thanks.

