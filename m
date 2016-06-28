Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEAD82018A
	for <e@80x24.org>; Tue, 28 Jun 2016 19:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752215AbcF1TvX (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 15:51:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55442 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751946AbcF1TvW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 15:51:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D874B242F1;
	Tue, 28 Jun 2016 15:51:20 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hKuHYoAutJ13I14+ROcPPpgovzI=; b=qg+TmY
	USLh+qFVOGNQTuA3SgeECcB9IlRqXh1W7kxr1Hkpny3lgy46OdnXiVk6QPJt3R1i
	OUp2b7rH/jLbCFqHdSJIvAmqFBsPt5wvJwWg4D6y/YHogFjvGAnK6rgfMmQ4JxAq
	hJutQsMsDieI8xs2Ly3EUm1zjnFIxLHBr+j6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KeO45nc93wDnXfeIwxYLqrpt4Z5ngA/q
	Gy3R1GF6hLMok6DzVIeiBnywZQ/Y0YJGbhHYeReyzNQQhNe6zD3/391bTcd3ip8C
	q2C5GCvMI9t263wrpSTooJXtHT7NVqHP9Fat5BKO1/aCgXP4FWOnN7gTFjUyeZfk
	OpyixMxnG8g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D1803242F0;
	Tue, 28 Jun 2016 15:51:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5FA2F242EF;
	Tue, 28 Jun 2016 15:51:20 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Nicolas Pitre <nico@fluxnic.net>
Cc:	Lukas Fleischer <lfleischer@lfos.de>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] Refactor recv_sideband()
References: <20160613195224.13398-1-lfleischer@lfos.de>
	<20160628043526.19403-1-lfleischer@lfos.de>
	<xmqqa8i59rph.fsf@gitster.mtv.corp.google.com>
	<xmqq60st9qg5.fsf@gitster.mtv.corp.google.com>
	<alpine.LFD.2.20.1606281334030.24439@knanqh.ubzr>
	<xmqqlh1p89mo.fsf@gitster.mtv.corp.google.com>
	<alpine.LFD.2.20.1606281422500.24439@knanqh.ubzr>
Date:	Tue, 28 Jun 2016 12:51:18 -0700
In-Reply-To: <alpine.LFD.2.20.1606281422500.24439@knanqh.ubzr> (Nicolas
	Pitre's message of "Tue, 28 Jun 2016 14:28:56 -0400 (EDT)")
Message-ID: <xmqq60st853d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AF5823B4-3D69-11E6-98BF-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Nicolas Pitre <nico@fluxnic.net> writes:

> Without this, the error and remaining buffer would be reversed as 
> mentioned previously.  With this, the order is restored, but a newline 
> is added to unterminated lines whereas the error was simply appended to 
> the output before Lukas' patch.
>
> In any case the new behavior is probably better and I'd simply adjust 
> the test expectations.

There is something else going on.  I cannot quite explain why I am
getting this failure from t5401-update-hooks.sh, for example:

    --- expect      2016-06-28 19:46:24.564937075 +0000
    +++ actual      2016-06-28 19:46:24.564937075 +0000
    @@ -9,3 +9,4 @@
     remote: STDERR post-receive
     remote: STDOUT post-update
     remote: STDERR post-update
    +remote: To ./victim.git
    not ok 12 - send-pack stderr contains hook messages

... goes and looks what v2.9.0 produces, which ends like this:

    ...
    remote: STDERR post-receive        
    remote: STDOUT post-update        
    remote: STDERR post-update        
    To ./victim.git
       e4822ab..2b65bd1  master -> master
     ! [remote rejected] tofail -> tofail (hook declined)

The test checks if lines prefixed with "remote: " match the expected
output, and the difference is an indication that the new code is
showing an extra incomplete-line "remote: " before other parts of
the code says "To ./victim.git" to report where the push is going.

It appeasrs that the "Refector"ed logic needs to be a bit more
careful when relaying an empty payload.
