Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACDF920756
	for <e@80x24.org>; Tue, 17 Jan 2017 19:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751031AbdAQTuX (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 14:50:23 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61063 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750924AbdAQTuW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 14:50:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1CF616048A;
        Tue, 17 Jan 2017 14:50:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=efLYebtGrkvyqr+4KMVmInuObl0=; b=NRjKK4
        YaS2SOuaEv09DZ4Kvj1ZnT21urZ8CibfZy2M3/aIBX4niE8bt9D+lpnJ7ZGW7z5F
        +DNT3kyNysVO6NBopWMwuiKcpzLBJvhj88tXBCOVl31kwe5pTZFzwAkAKyvi/BgG
        YKOgI1vtKjgQ2MhBOeTlP8i7wodIDAaVUjOmw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Vsn6yy2DDvux7bNIIvFOviwnprFh0EPN
        qwxE/JOJt8JNOgTRZk0zKgXQTw/aLrOUcoqavPHhKj26Hz5HuJA8gsDZdJDZz8As
        AwhvYNbti4i3dbTOaJGPPC/9+b0DtucZxXk5+KnI2MQAjmczxuFPqyXUFvMqVg2v
        6YEr84g6FVY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1418360489;
        Tue, 17 Jan 2017 14:50:21 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5CA2D60488;
        Tue, 17 Jan 2017 14:50:20 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 00/38] Teach the sequencer to act as rebase -i's backend
References: <cover.1481642927.git.johannes.schindelin@gmx.de>
        <cover.1483370556.git.johannes.schindelin@gmx.de>
        <xmqqinpnuaxl.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1701141904390.3469@virtualbox>
        <xmqqinpgdass.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1701161129240.3469@virtualbox>
Date:   Tue, 17 Jan 2017 11:50:19 -0800
In-Reply-To: <alpine.DEB.2.20.1701161129240.3469@virtualbox> (Johannes
        Schindelin's message of "Mon, 16 Jan 2017 11:45:06 +0100 (CET)")
Message-ID: <xmqq7f5tfouc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D78632A-DCEE-11E6-A0B1-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > The original code is:
>> >
>> > 	. "$author_script"
>> 
>> [...]
>>
>> If the code in the sequencer.c reads things other than the three
>> variables we ourselves set, and make them into environment variables
>> and propagate to subprocesses (hooks and editors), it would be a
>> bug.  The original did not intend to do that (the dot-sourcing is
>> overly loose than reading three known variables and nothing else,
>> but is OK because we do not support the case where end users muck
>> with the file).  Also, writing FOO=BAR alone (not "export FOO=BAR"
>> or "FOO=BAR; export FOO") to the file wouldn't have exported FOO to
>> subprocesses anyway.
>
> That analysis cannot be completely correct, as the GIT_AUTHOR_* variables
> *are* used by the `git commit` subprocess.

In the scripted version, do_with_author shell function explicitly
exports GIT_AUTHOR_* variables because they are the only ones we
care about that are read from existing commit and carried forward
via the author-script mechanism.  We do not care about, and in fact
we do not intend to support, any other variables or shell commands
that appear in the author-script.
