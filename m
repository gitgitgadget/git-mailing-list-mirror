Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7158FC00144
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 23:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbiHAXSB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 19:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiHAXSA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 19:18:00 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4430D1571F
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 16:17:59 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6918813BA96;
        Mon,  1 Aug 2022 19:17:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=w8onCWJJD9TGMkrTNibz5vQlE1HdG0CKIPZ/zJ
        xvQQc=; b=MoGAmOgD1K7D5/CmLjCSs0VwjUYh+VDZccQfJGw7V4atcMcDSsgi6X
        TBvioX9MKQQdRxIwQQD2CKr4gUsDGCpva+nyX1HqyqTmGPH631l5tImqfmKcNpoT
        utz6Uz97v4kDDdJw/Ta2cb8ljFRYf2BOqNgmsBKWjc2eEG/wRb8To=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 60DF413BA93;
        Mon,  1 Aug 2022 19:17:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 96F6D13BA92;
        Mon,  1 Aug 2022 19:17:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Eugen Konkov <kes-kes@yandex.ru>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Re* --creation-factor=100 does not show code
References: <1196830250.20220726145447@yandex.ru>
        <7229p500-p2r4-on87-6802-8o90s36rr3s4@tzk.qr>
        <xmqqo7x9ch7n.fsf_-_@gitster.g>
        <85snn12q-po05-osqs-n1o0-n6040392q01q@tzk.qr>
        <xmqq5yjf4l60.fsf@gitster.g>
Date:   Mon, 01 Aug 2022 16:17:56 -0700
In-Reply-To: <xmqq5yjf4l60.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        29 Jul 2022 15:19:03 -0700")
Message-ID: <xmqqa68nlfiz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2DC93196-11F0-11ED-B1A3-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> When we say an option's value is expressed in <percent>, unless we
> are careful, people will assume that the valid value the option will
> take will lie between 0 and 100, and you cannot blame them.  IOW,
> while the word "percent" may be 100% correct in your mind, the way
> it is used to describe the feature in "git range-diff --help", it
> was not sufficient to help readers.

Stepping back a bit, I find that saying
"--creation-factor=<percent>" is like giving "--max-size=<bytes>".
They both make it clear that the readers express the number in what
scale, but fails to explain what the number means.  It is especially
hard for readers when the name of the option does not help explain
what the number is, e.g. "max size, size of what?" is a valid
question when dealing with "--max-size", and without the question
answered, the readers cannot decide what value they want to give to
achieve the effect they want.

the reader would want to know what it is (e.g. maximum memory that
is allowed to be allocated on heap) and how it is measured (i.e. in
bytes).  The former helps the readers guess what a reasonable value
they want to specify is (e.g. "I can afford to dedicate yMB"), and
the latter is essential for the readers to decide how exactly they
express what they chose (e.g. "I want to give yMB, but it is
measured in bytes, so I'll write y * 10^20 here").  We need both.

So _after_ they decide that 1.20 is the right number they want to
give to --creation-factor, the knowledge that the number is
expressed as percent does help them to write --creation-factor=120
correctly (not --creation-factor=1.20).

But for readers to come up with the number 1.20, there needs a
better explanation of what the number means in the first place.  "Go
read the algorithm section" is better than having nothing there, but
we should be able to do better by having a simple-to-understand
single paragraph description.

Thanks.
