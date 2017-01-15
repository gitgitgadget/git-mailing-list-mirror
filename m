Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2214520756
	for <e@80x24.org>; Sun, 15 Jan 2017 07:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750792AbdAOHrg (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jan 2017 02:47:36 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58019 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750757AbdAOHrf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2017 02:47:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 13AA756C14;
        Sun, 15 Jan 2017 02:47:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kj1qEkmxR0/bPeZYvjBOQFrfA3E=; b=D3Di/N
        G8GyP3eoP1z1OPGXb/TFOJf9mXubVFq/jvrgBTa5z8VV6uhwdt9H8r1RacU2sFx6
        YbC9E7IjmXv5lmsRKvJWrL2roNtEGVvz9Rwot5qiLoeD7/KLgSlhhjXucHt9kc5m
        oVGtuaLRctsAQulPNi3DG8/83oJc97BDmO+3M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=v4F1U+0ajAytC0HUxXWhxzCq1SfJKB0B
        mALwKzvunKnsWZtHzjvDz3qZ6Ue78AKQDQYBTlZqWbQtJnHfI/EF1FkAhB4AhaTh
        rAteoeHNZ+P3SwfAjyBRgpo+sZeBNqWa04qVDMr3hxP2jI6glBictCDTov432MrZ
        9TGG8asZr+4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DB1E856C13;
        Sun, 15 Jan 2017 02:47:33 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D4C9056C12;
        Sun, 15 Jan 2017 02:47:32 -0500 (EST)
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
Date:   Sat, 14 Jan 2017 23:47:31 -0800
In-Reply-To: <alpine.DEB.2.20.1701141904390.3469@virtualbox> (Johannes
        Schindelin's message of "Sat, 14 Jan 2017 19:08:41 +0100 (CET)")
Message-ID: <xmqqinpgdass.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DF92DD5A-DAF6-11E6-A8CA-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> You stated elsewhere that converting a script into a builtin should focus
> on a faithful conversion.
>
> The original code is:
>
> 	. "$author_script"
>
> Granted, this *cannot* be converted faithfully without reimplementing a
> shell interpreter. So I did the next best thing: I converted it into code
> that reads a block of environment variable settings.

It is unfortunate that you took "faithful" too literally.  While I
do appreciate it if your conversion aims to faithfully replicate the
original, even to be bug-to-bug compatible, but obviously we cannot
replicate everything the above original _could_ do.  

By "a faithful conversion", I meant that the behaviour of the
reimplementation should be as faithful to the original's intent as
possible.  Nothing more.

The intent of the above original is to read back what we wrote to
preserve the author identity we learned earlier when we wrote the
file.  We read the "author" line from the commit object header, and
write assignments to GIT_AUTHOR_{NAME,EMAIL,DATE} variables.  Nothing
more is intended.

The end-users COULD abuse the original code to cause it to do a lot
more than that, e.g. by adding "export FOO=BAR" at the end and have
the value of the new environment variable propagate throughout the
code and even down to subprocesses.  They can even assign to some
variables we use internally for bookkeeping and break "rebase -i"
machinery.  But that is outside the intent of the original code--we
do not need to or want to replicate that faithfully.

I also need to react to the "environment variable settings" at the
end of the quoted paragraph.

If the code in the sequencer.c reads things other than the three
variables we ourselves set, and make them into environment variables
and propagate to subprocesses (hooks and editors), it would be a
bug.  The original did not intend to do that (the dot-sourcing is
overly loose than reading three known variables and nothing else,
but is OK because we do not support the case where end users muck
with the file).  Also, writing FOO=BAR alone (not "export FOO=BAR"
or "FOO=BAR; export FOO") to the file wouldn't have exported FOO to
subprocesses anyway.
