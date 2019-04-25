Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 096041F453
	for <e@80x24.org>; Thu, 25 Apr 2019 10:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbfDYKE1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 06:04:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55329 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbfDYKE1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 06:04:27 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0A54B14FC07;
        Thu, 25 Apr 2019 06:04:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6Xdzoxig2zmR
        BKBd1d8By+sXvIU=; b=U7tKX394UaeQWXYhL3VhmA0/Qyi2jSA5fSH2XUBQCXyd
        yMZXNuEnPOZcCPwEG6TWa386NZEwD0QGgII0J04nKIOmLYwn35WGtESqYVhlG2lK
        1uyqj/ru5EqT3cTAJPkmhn4YkVxwgEGZ9x4vwhLS5ofMQz94HRA7o2hb+RrgsKM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=KfrcJI
        pqTdX+mrb+X2acviJdX5wdvtNPGnu+ksvXIfBmgZ9o0SO1imi3V8dbDPSj6ArVZT
        kJwmRxzEqvC52y42EujOS/RhKbZbjSyj70o+gdTpaw+mxFfybySLL8NCUkRk5TND
        ZgjY59U4X7NWuOvf3dos68EKk2UuapoBVhWSA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 01F2914FC06;
        Thu, 25 Apr 2019 06:04:25 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6570F14FC05;
        Thu, 25 Apr 2019 06:04:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/5] run-command: add preliminary support for multiple hooks
References: <20190424004948.728326-1-sandals@crustytoothpaste.net>
        <20190424004948.728326-2-sandals@crustytoothpaste.net>
        <xmqqo94w2l3k.fsf@gitster-ct.c.googlers.com>
        <8f79d251-58d9-f63b-7171-7f1fbd11c6f9@kdbg.org>
        <xmqqo94uzyxa.fsf@gitster-ct.c.googlers.com>
        <87lfzys9t1.fsf@evledraar.gmail.com>
Date:   Thu, 25 Apr 2019 19:04:23 +0900
In-Reply-To: <87lfzys9t1.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 25 Apr 2019 11:39:38 +0200")
Message-ID: <xmqqwojiwgd4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 80E1A410-6741-11E9-AE46-1646B3964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> To me this is another point in favor of bypassing this problem entirely
> and adopting the semantics GitLab (and it seems others) use. I.e. in
> order execute:
>
>     .git/hooks/pre-receive .git/hooks/pre-receive.d/*

But isn't that exactly what Brian wanted to avoid?  Consider those
who run the current version of Git (which considers pre-receive.d/
is just a floating cruft Git does not care), with their own
implementation of pre-receive hook that goes over the contents of
pre-receive.d/ directory and executes each in order.  If a new
version of Git you release runs pre-receive followed by each of the
files in pre-receive.d/ directory, especially because you designed
to use *.d convention to match existing practice, doesn't your new
version of Git end up running the scripts in *.d directory twice?
