Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DD771FF6D
	for <e@80x24.org>; Mon, 19 Dec 2016 01:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752051AbcLSBMl (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Dec 2016 20:12:41 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50378 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752411AbcLSBMV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Dec 2016 20:12:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 172765852E;
        Sun, 18 Dec 2016 20:12:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=M8Ia/kx9FXI0psIVUAxAJ1BwgRk=; b=mIxAZr
        i/umj4KJVMLNpfFnkuzBcvRaeOCASGcKi9Pa1jbMuGfTOimgGsR/oUS0llqPXRF/
        GNj7fj3cBz4RZ5/Dbw6ZUckR0ECbYHqQhPpmSQt10gNfAhdCbNXfx3S8GJAWOYNR
        kVw8CL9rZokJKmo6TepcI1zKn/ldNUrWmRSQE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GYwi4s6geFj9lXY8I/kpsn/Z45PCPBCD
        +TvSUVsh3Zp53ztI5fhcq69VMutb7ClvKCw6tFC8rmfuFVif0rNNrM29cE4A0vPK
        7spITlKliqU1xxKzapBUI9g6KlNilpTNZiybNJjeTcXKbq0SPApOU9TZmGMAutmd
        hfzsKEO+Hi0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0DDD35852D;
        Sun, 18 Dec 2016 20:12:20 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 854155852C;
        Sun, 18 Dec 2016 20:12:19 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH] winansi_isatty(): fix when Git is used from CMD
References: <cover.1481454992.git.johannes.schindelin@gmx.de>
        <42ddc270ea04e01e899cc479063e5d602e4a4448.1481454992.git.johannes.schindelin@gmx.de>
        <129f000c-49c1-0e75-26b3-c96e9b442443@kdbg.org>
        <xmqqy3zfsq4q.fsf@gitster.mtv.corp.google.com>
        <5977e71d-da58-7cb0-bc69-343bb3a1341d@kdbg.org>
        <ffc6a7a0-4ae4-b755-0b09-5bcd7114a2e6@kdbg.org>
Date:   Sun, 18 Dec 2016 17:12:18 -0800
In-Reply-To: <ffc6a7a0-4ae4-b755-0b09-5bcd7114a2e6@kdbg.org> (Johannes Sixt's
        message of "Sun, 18 Dec 2016 16:26:02 +0100")
Message-ID: <xmqq37hkrabx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 30291D1C-C588-11E6-B0E6-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> ..
> The new isatty() override implemented by cbb3f3c9b197 (mingw: intercept
> isatty() to handle /dev/null as Git expects it, 2016-12-11) does not
> take into account that _get_osfhandle() returns the handle visible by
> the C code, which is the pipe. But it actually wants to investigate the
> properties of the handle that is actually connected to the outside
> world. Fortunately, there is already winansi_get_osfhandle(), which
> returns exactly this handle. Use it.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
> I was able to test the idea earlier than anticipated and it does work
> for me.

I'll queue this in 'pu' so that I won't forget, but this time I'll
make sure I won't act on it until I see you two agree on the right
way forward.

Thanks.  
