Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E687120A40
	for <e@80x24.org>; Fri, 24 Nov 2017 05:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751524AbdKXFyx (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 00:54:53 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57696 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750853AbdKXFyx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 00:54:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A2752AC523;
        Fri, 24 Nov 2017 00:54:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=o8/TXY6h9uWyFd0LPmWd93qD6w8=; b=R1jPHb
        hkvVRbkMEomfWBPzoAr8GGw4jGQ3w3Nzf5ad1cHjHQlAwyXCgCqQ6TqUV5riKlWd
        62RH8M6Sg6clbABUjn85kgfeU82m21Zj7pGEdZyy72VjfkUs8mOawFUsB7AiVQOY
        7IBrDVSP2gkmra8jHHCvHUgJRZOFPf1yPjD+o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Pt8l516hzZZiuqJC7Nuv7JxkEOUCsvyK
        /qecj3Y5CvqHXl3cv5i8LwlZPmpn/lmG+nVqtoMUHNfaCQITN6uG4Ba2BmcLxJyD
        GF7SZBzgq6+5lIdeDUgchxLgfqDNsuPpdN6T+dMBEU9Q+lX0Xsl6OmGCD9YdspV5
        WrSaFj1z9BM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 99946AC522;
        Fri, 24 Nov 2017 00:54:52 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 016A0AC520;
        Fri, 24 Nov 2017 00:54:51 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Max Kirillov <max@max630.net>
Cc:     Jeff King <peff@peff.net>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] http-backend: respect CONTENT_LENGTH as specified by rfc3875
References: <20171123234511.574-1-max@max630.net>
Date:   Fri, 24 Nov 2017 14:54:50 +0900
In-Reply-To: <20171123234511.574-1-max@max630.net> (Max Kirillov's message of
        "Fri, 24 Nov 2017 01:45:11 +0200")
Message-ID: <xmqqvai0nrv9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FD10E8FA-D0DB-11E7-8AD6-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Max Kirillov <max@max630.net> writes:

> http-backend reads whole input until EOF. However, the RFC 3875 specifies
> that a script must read only as many bytes as specified by CONTENT_LENGTH
> environment variable. This causes hang under IIS/Windows, for example.
>
> Make http-backend read only CONTENT_LENGTH bytes, if it's defined, rather than
> the whole input until EOF. If the varibale is not defined, keep older behavior
> of reading until EOF because it is used to support chunked transfer-encoding.
>
> Signed-off-by: Florian Manschwetus <manschwetus@cs-software-gmbh.de>
> Authored-by: Florian Manschwetus <manschwetus@cs-software-gmbh.de>
> Fixed-by: Max Kirillov <max@max630.net>
> Signed-off-by: Max Kirillov <max@max630.net>
> ---
> ...
> I hope I marked it correctly in the trailers.

It is probably more conventional to do it like so:

    From: Florian Manschwetus <manschwetus@cs-software-gmbh.de>
    Date: <original date of Florian's patch series>

    http-backend reads whole input until EOF. However, the RFC 3875...
    ... chunked transfer-encoding.

    Signed-off-by: Florian Manschwetus <manschwetus@cs-software-gmbh.de>
    [mk: fixed trivial build failures and stuff]
    Signed-off-by: Max Kirillov <max@max630.net>
    ---

>  
> +/*
> + * replacement for original read_request, now renamed to read_request_eof,
> + * honoring given content_length (req_len),
> + * provided by new wrapper function read_request
> + */

I agree with Eric's suggestion.  In-code comment is read by those
who have the current code, without knowing/caring what it used to
be.  "It used to do this, but replace it with this new thing
because..." is a valuable thing to record in the log message, but
not here.
