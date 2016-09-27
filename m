Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F33AE20986
	for <e@80x24.org>; Tue, 27 Sep 2016 15:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755231AbcI0Pd1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 11:33:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50875 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754640AbcI0Pd0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 11:33:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BF3AA3B9C7;
        Tue, 27 Sep 2016 11:33:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Hy1EtzO5V8NOi67J87rsk0c+oCY=; b=oVp7BD
        ODpVX4u9GToQ5lGL1DA2qPrI23Pc11wEbLq1rr0X8PE/7sBQGepXFu7icPRIF/jL
        9rTCXvHyFqIDmmGeUqMl8GF/Wa80FcWQ3fUWLLWeiQKMYD7MT8Spo4HPXugDX5o2
        xW4ZoXbQmcR55886ch3th7A75Jfzk6aa1eRXs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RVzbHfZ2bQwII/OLeuoca32MhfdRQ8Gh
        4aUZLw6oIxsQ9Lxzs/q8Ze9SbGr6OS2kZlEf9gp6R7d/k998ot1kecTDowonAnbe
        ioanVPtLMH7mZcpFA+KubjUlIscSt+L6K/19ckYAQEuMh1jVJC98nRqeVxFRyY4l
        g8Bqhh/ZYqM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B652C3B9C6;
        Tue, 27 Sep 2016 11:33:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 360D93B9C5;
        Tue, 27 Sep 2016 11:33:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] utf8: refactor code to decide fallback encoding
References: <20160927012211.9378-1-gitster@pobox.com>
        <20160927012211.9378-2-gitster@pobox.com>
        <20160927055202.4ucddki3xkns45om@sigill.intra.peff.net>
Date:   Tue, 27 Sep 2016 08:33:22 -0700
In-Reply-To: <20160927055202.4ucddki3xkns45om@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 27 Sep 2016 01:52:02 -0400")
Message-ID: <xmqqvaxhqrwd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BA6B8156-84C7-11E6-913A-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> But once we introduce other fallbacks, then "utf8 -> latin1" may become
> "UTF-8 -> iso8859-1". A system that knows only "utf8" and "iso8859-1"
> _could_ work if we turned the knobs individually, but won't if we turn
> them both at once. Worse, a system that knows only "UTF-8" and "latin1"
> works now, but would break with your patches.
>
> I'm not convinced it's worth worrying about, though. The existence of
> such a system is theoretical at this point. I'm not even sure how common
> the "know about utf8 but not UTF-8" thing is, or if we were merely being
> overly cautious.

Yeah, I did consider having to try the permutations until it works,
but suspecting that somebody takes "utf8" without taking "UTF-8" is
to pretty much invalidate the basic premise of the existing code,
i.e. spelling it as "UTF-8" is the most likely to work anywhere as
long as UTF-8 is supported, so I stopped worrying about it at that
point.

I'd actually welcome a more generic suggestions we can put in our
documentation so that we can _lose_ the fallback entirely (e.g. "if
your contributor spelled 'utf8' and your system, which does take
'UTF-8', does not like it, then here is what you can do to your
/etc/locale.alias").

