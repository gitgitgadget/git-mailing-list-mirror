Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBDAC433DB
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 15:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5209E221E5
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 15:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbhASPIY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 10:08:24 -0500
Received: from mail.aerusso.net ([104.225.219.13]:58032 "EHLO mail.aerusso.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389660AbhASOxx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 09:53:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aerusso.net; s=default;
        t=1611067988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k7Vm7waBrV8cxFpIvdOd1xP2OZJfF0R3c1i7BFUoMRE=;
        b=FisDtJ2rNnVg3pQBMoatuQNs36JliSvo6QQuDuSo9D2PZ7/rE1pDZpf83XkRqMVtbmr3E0
        QWWCpn1PPRU91XEPtNBt4Fx8/Y8i+jgjVfQmdPkZfGjY4a1KIimzi/jQMQEiug5PpgwThg
        R/MELJv7W1WvEzSF0B63KQub2zToJsi5oXNSYdRFbvpfzJh79N2OPBVv5xtsFRROxRfnfC
        j/j5b6VlhgWpeVPE4z9v31E+dNhD/WX+hNjOGiq3awf0xOsGQwzuwxVdLqS8JfBclToG1B
        zCY0kZUx1EUlbzR7B19k03X4cXXWzwHuaTATpeGgJT5JMo1bLMCFvbO6eymiUQ==
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Aiyee Bee <shane.880088.supw@gmail.com>, git@vger.kernel.org
References: <C8MJ83LNOZ1Q.OCQKHOTGHKWF@localhost>
 <38ed4389-ba9f-743a-3fa3-5ffab12ef0a9@gmail.com>
 <992cd021-d6f6-dfe4-1918-45643aa85a61@aerusso.net>
 <xmqq7do9iuqj.fsf@gitster.c.googlers.com>
From:   Antonio Russo <aerusso@aerusso.net>
Subject: Re: DEVEL: Help with feature implementation
Message-ID: <9fc9d752-06f4-e75d-1549-f257fd34e0c3@aerusso.net>
Date:   Tue, 19 Jan 2021 07:52:37 -0700
MIME-Version: 1.0
In-Reply-To: <xmqq7do9iuqj.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/18/21 6:24 PM, Junio C Hamano wrote:
> Antonio Russo <aerusso@aerusso.net> writes:
> 
>> As a side note, would this list be willing to look at patches that remove
>> the need to use revs->limited?  Adding new features would be much easier if
>> we could restrict git to use streaming algorithms for these simplifications.
> 
> Do you mean you will write new implementations of operations like
> "--simplify-merges", "--ancestory-path" and all its friends without
> the need for the "limited" bit?

Yes.

> Willing to look at?  I do not know about others, but sure, it would
> make be extremely excited.
> 
> You may be able to rewrite some other operations that implicitly
> require the limited bit into an incremental implementation, but I am
> skeptical that you can do "simplify-merges" in a streaming fashion
> in such a way that we'd dig a bit but not all the way down before
> making decisions on which commits should be included in the output
> and how their parenthood relationship should appear etc.  I and
> Linus tried independently and we did not get that far in our
> attempts (note: there wasn't commit-graph back then).

Yeah, it's a big task (but, it'd be useful work, rather than doing
another rewrite of my feature to make it work when revs->limited).
Each of the flags (simplify-merges, ancestry-path, etc.) is its own
little sub-project.

I haven't thought about any one flag specifically, but the fact that
two complete code paths exist right now just seem like a nightmare.
I'm not necessarily interested in making the implementations faster,
but rather getting rid of the duplicated code path.

It's also a long-term goal, but it's nice to hear that people would
be interested in it.

> If you are talking about precomputed stuff like commit-graph, that
> may change the equation, but we'd prefer to have the system work
> without requiring these auxiliary data (in other words, it would be
> fine to use them as optimization).

No, I understand that generation numbers can only be used as an
optimization (i.e., they might all be GENERATION_NUMBER_INFINITY).
