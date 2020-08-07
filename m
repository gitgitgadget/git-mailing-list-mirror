Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D93C433E0
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 19:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09ABC2074D
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 19:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="n2FpLBVw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgHGT0U (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 15:26:20 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55272 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGT0U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 15:26:20 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 44432EFEA8;
        Fri,  7 Aug 2020 15:26:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XUBq6vnmMvDdsXop73voHa+LeS4=; b=n2FpLB
        VwbKGBVS7VGwepHytJbvMdJ9vjFP8WBs+5PEiCHg0VCNknD+fOIHwpk/M84DiU9H
        431lMi4vvfVDD3vBThVeXkDD50/JQ+0cWupTqYI4o5ZiWC+bkMvsNLxmba5LXt8Z
        nl4WrMcQryywj81zMaGFkZ/wFJTwmGOXgta4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wT53PAW1perrenOUYg8ltHnU5iSfqZEh
        IirWDHarHoVJOyeIzYi0YkVS4JXuV2pdiEc6Cgk/FK4Zlw5euMnBnBBI/mc0/mqr
        PdvXpseB5i9gMT5Kq6ZCPyvStkBP5OlMe5cYzedgVE5q3S7uYCVbWw1pfBWFpISI
        I175c85nBMo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3DADFEFEA7;
        Fri,  7 Aug 2020 15:26:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 87185EFEA6;
        Fri,  7 Aug 2020 15:26:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH] refs: fix interleaving hook calls with reference-transaction hook
References: <63fb363375b515b903ed1269d10124b727c1d1cc.1596783732.git.ps@pks.im>
        <20200807075837.GA32344@coredump.intra.peff.net>
        <20200807090412.GA1407904@tanuki.pks.im>
        <20200807093239.GA1228157@coredump.intra.peff.net>
        <20200807094946.GA1758126@tanuki.pks.im>
        <20200807182141.GA1307024@coredump.intra.peff.net>
Date:   Fri, 07 Aug 2020 12:26:13 -0700
In-Reply-To: <20200807182141.GA1307024@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 7 Aug 2020 14:21:41 -0400")
Message-ID: <xmqqd042gsve.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DC6F79FA-D8E3-11EA-9F72-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Aug 07, 2020 at 11:49:46AM +0200, Patrick Steinhardt wrote:
>
>> Yeah, it's also been my take that OS-level overhead is probably going to
>> matter more than those access calls, and I argued such back when I
>> proposed the hook. So I'm perfectly happy to see this caching mechanism
>> go.
>> 
>> Should I re-post a v2 with your patch and my test?
>
> Sure, that would be fine (to be clear, I'd also be OK with your original
> patch, too; it was mostly just a curiosity to me).

Let's queue the correctness fix patch as-is. 

We can and should make the simplification as a separate step,
justified with the performance numbers.

Thanks.
