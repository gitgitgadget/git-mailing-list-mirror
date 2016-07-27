Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0985B203EA
	for <e@80x24.org>; Wed, 27 Jul 2016 00:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757684AbcG0AUJ (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 20:20:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53073 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756964AbcG0AUI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 20:20:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4DA3D2FBF6;
	Tue, 26 Jul 2016 20:20:07 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ytRONPZ2tjeibw2qimMVSrG4McI=; b=ciRwhY
	3lDcmKttmRUNt87wWTW04cLMunRAS9ifFsTpu2IIUkc0C+0VTSVgUVli5lq8I05/
	+sThjUMygiC/DH9JjZjpStquukOB5Nkqt7aaBv3537m3kSU9jtTVj232DDB0JALG
	YxP4Gr/BNhnwKMlSIm3Bx94q8T2YApcmzM85Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D5rJmWf6DLGj+RVsWzlI8j9Du8nDCXYn
	AWKyA0N13P0bLZABgaLa/HKtnFERDjVN0aLwwVDEwIVBZViRmiFdRbQjLoKPju92
	Z6ebO4az8X90eOnEfHyNjc+Kok3NXH15CDFSlj+xAQpE1mzbdHI8DH4zVzIYiMzV
	37M+6u0p3+E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 452BB2FBF5;
	Tue, 26 Jul 2016 20:20:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E26A32FBF4;
	Tue, 26 Jul 2016 20:20:05 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	larsxschneider@gmail.com
Cc:	git@vger.kernel.org, jnareb@gmail.com, tboegi@web.de,
	mlbright@gmail.com, remi.galan-alfonso@ensimag.grenoble-inp.fr,
	pclouds@gmail.com, e@80x24.org, ramsay@ramsayjones.plus.com,
	peff@peff.net
Subject: Re: [PATCH v2 3/5] pkt-line: extract and use `set_packet_header` function
References: <20160722154900.19477-1-larsxschneider@gmail.com>
	<20160727000605.49982-1-larsxschneider@gmail.com>
	<20160727000605.49982-4-larsxschneider@gmail.com>
Date:	Tue, 26 Jul 2016 17:20:03 -0700
In-Reply-To: <20160727000605.49982-4-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Wed, 27 Jul 2016 02:06:03
	+0200")
Message-ID: <xmqqinvsx77w.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DE84AE28-538F-11E6-B74B-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> `set_packet_header` converts an integer to a 4 byte hex string. Make
> this function publicly available so that other parts of Git can easily
> generate a pkt-line.

I think that having to do this is a strong sign that the design of
this series is going in a wrong direction.

If you need a helper function that writes a pkt-line format that
behaves differently from what is already available (for example,
packet_write()), it would be much better to design that new function
so that it would be generally useful and add that to pkt-line.[ch],
instead of creating random helper functions that use write(2)
directly, bypassing pkt-line API, to write stuff.

In other words, do not _mimick_ pkt-line; enhance pkt-line as
necessary and use it.

