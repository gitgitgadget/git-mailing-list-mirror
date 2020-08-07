Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6F4C433E0
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 17:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C001B20866
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 17:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Hlidh+B5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgHGRcb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 13:32:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60544 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgHGRca (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 13:32:30 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F1B5B6A638;
        Fri,  7 Aug 2020 13:32:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hFODhB71tSM01JAlgRe3vrs7YtM=; b=Hlidh+
        B5XRurhokCtlGl+8gJYHv+eD7r++JXObNlhoJUKLQPdlk+Xb8PlmXObm9Ba44gqr
        NXGmWl1GrqzibAYm8qWt4SFMYt2Q5LQbqOdyrcSWr2Y+myW7qvGjsci5QJacu6wh
        vFvkb62D9pixgWT0S1d/BwZ25w1WZgJ+g6n8o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DRymPa8sv7qMNVsoT3D+sT+5JTB6PaNu
        DUtTcBWhO8yXmR4/Tea0x+BpjgrRVBIAWXzD8EBjGIW2RHD4ldSMUl8zrPyphJBG
        ZX54YRiLu9sCudhISwcLRHxWKTsdLzM+Sb+7aKRzyDhhVKWnrulX2VfF3jsLxMlT
        06GnM6KL9iA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E98FA6A636;
        Fri,  7 Aug 2020 13:32:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6C1086A635;
        Fri,  7 Aug 2020 13:32:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] refs: fix interleaving hook calls with reference-transaction hook
References: <63fb363375b515b903ed1269d10124b727c1d1cc.1596783732.git.ps@pks.im>
        <20200807075837.GA32344@coredump.intra.peff.net>
        <20200807090412.GA1407904@tanuki.pks.im>
        <20200807093239.GA1228157@coredump.intra.peff.net>
        <20200807094946.GA1758126@tanuki.pks.im>
Date:   Fri, 07 Aug 2020 10:32:26 -0700
In-Reply-To: <20200807094946.GA1758126@tanuki.pks.im> (Patrick Steinhardt's
        message of "Fri, 7 Aug 2020 11:49:46 +0200")
Message-ID: <xmqqpn82gy51.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F6905BD4-D8D3-11EA-BB73-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Aug 07, 2020 at 05:32:39AM -0400, Jeff King wrote:
>
>> That implies you're just seeing noise. And indeed, with the patch below
>> I get:
>> 
>> Test                         HEAD^             HEAD
>> --------------------------------------------------------------------
>> 1400.2: update-ref           1.93(1.57+0.42)   1.91(1.55+0.42) -1.0%
>> 1400.3: update-ref --stdin   0.07(0.02+0.05)   0.07(0.02+0.05) +0.0%
>> 
>> Running it a second time gets me +0.5%. :)
>
> Yeah, it's also been my take that OS-level overhead is probably going to
> matter more than those access calls, and I argued such back when I
> proposed the hook. So I'm perfectly happy to see this caching mechanism
> go.

Is the above about negative cache?  IOW, does the above demonstrate
that one extra access() to make sure there is no hook does not hurt
us anything?  

If so, yes, I am 100% for removing the cache mechanism.

Thanks for driving design decision with numbers.  That's always
pleasant to see.


