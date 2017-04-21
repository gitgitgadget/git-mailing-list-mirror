Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93E70207BD
	for <e@80x24.org>; Fri, 21 Apr 2017 01:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S948409AbdDUBT7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 21:19:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64752 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S948396AbdDUBT5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 21:19:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 234F27B701;
        Thu, 20 Apr 2017 21:19:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bOZuvFxz1fNCRNwTD/dY382Rqa4=; b=Io8+WA
        qNUdgPgZCE/jF919Iy8ATqhIQ0Y5UA7a71sw5Dgi40s8LV2ebDGLT5vsi5V3hfNx
        bQjq8BZUKATcm/CAB8WdLZgQhHk62OWnfjhMxLMQDaU75NZwwjp7vAAIz5w56zzQ
        p6BjPpfwb9A08XUCaDoktv65TheTe3w5aLuwg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lc2RbIIpbbZDUC/6/6guxH4DWnERNxO8
        DDKJR2jLZgk0UnstIGxXLSJJSxT7yStSvlMu0/aKeW6BUD3TwyPtTT+vNr4L29EE
        taqt1xem8lU4LCPOX2kWsiI3c8IO+orn0bqW5ESfKJsb/0OTJqHsKtbaIbZ3hyuh
        yUYqzHygQYY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1933B7B700;
        Thu, 20 Apr 2017 21:19:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 688357B6FF;
        Thu, 20 Apr 2017 21:19:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v1] diffcore-rename: speed up register_rename_src
References: <20170418194421.22453-1-git@jeffhostetler.com>
        <20170418194421.22453-2-git@jeffhostetler.com>
        <20170419013214.q35jarvmk5jhqdyi@sigill.intra.peff.net>
        <xmqqd1c9cdzi.fsf@gitster.mtv.corp.google.com>
        <20170419025608.xy5nvso6k6lb5z7g@sigill.intra.peff.net>
        <20170419031839.m2zgwywa2soejiqk@sigill.intra.peff.net>
        <40228c69-7946-3ef1-35de-4cea9b0312e4@jeffhostetler.com>
        <20170420161359.haolllw4ac5jjqx4@sigill.intra.peff.net>
        <4d400fb6-201e-e1ba-cc3a-935951ab3e14@jeffhostetler.com>
        <20170420183455.y5oz3hspz3v2g6yr@sigill.intra.peff.net>
Date:   Thu, 20 Apr 2017 18:19:49 -0700
In-Reply-To: <20170420183455.y5oz3hspz3v2g6yr@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 20 Apr 2017 14:34:55 -0400")
Message-ID: <xmqqtw5i7e16.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9DB819EC-2630-11E7-8F00-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>   - this patch probably adds "unsorted tree" to the list of breakages
>     that would cause us to skip rename detection. I don't know if that's
>     actually possible in practice (i.e., do we end up sorting the
>     diffq elsewhere anyway?). I also wondered if it might run afoul of
>     diffcore_order(), but that is applied after rename detection, so
>     we're OK.

One of the frontends (I think it was diff-index) couldn't generate
sorted output (which is input to diffcore-* machinery) but I think
diffq is sorted before getting passed to the diffcore-* machinery in
that codepath, so we should be also OK on that front.
