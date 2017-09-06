Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 211FF208E3
	for <e@80x24.org>; Wed,  6 Sep 2017 03:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751698AbdIFD7u (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 23:59:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54407 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751420AbdIFD7s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 23:59:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2FD85B0EBF;
        Tue,  5 Sep 2017 23:59:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0h0rGoOWIFjBfQIydvKoWrPCT6E=; b=gkc49D
        PuAORq5saCU2riG7A0zzPIisRws3tzouTna3oDMT8DeAPpSJa0/4CxFP+wWHzkbZ
        HqaEKYplyzv7/DHusevgJS+28rONV4US3xDErnq2+uNbQdK9yfS+pQP3RdULr8j2
        gP1/J52evOO0BpaqzWqPbcngy3SvemcWvawIE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=duI0ue5MzYNjrd4ub7BU0TNkfxXmWSL5
        J9o5ZkqThzRfl/yK2ek1/+KBBff8kRXFss6YDClGJgo8ZOIwyY0yVhrs9w7FnSIb
        LVmTfeEc0ofrL6u0zUQPNMQ+wa4/rZt0FR804buRJtPQwAGTiAkwIzKoies4iklv
        7SDpzErsf3Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 287F8B0EBE;
        Tue,  5 Sep 2017 23:59:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 77E50B0EBD;
        Tue,  5 Sep 2017 23:59:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Martin =?utf-8?Q?=C3=85gre?= =?utf-8?Q?n?= 
        <martin.agren@gmail.com>, Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] config: use a static lock_file struct
References: <20170827073732.546-1-martin.agren@gmail.com>
        <9E4606AF-8814-42DE-8D3A-3A15C1B1723C@gmail.com>
        <CAN0heSraJFbbog7FKpAtmob9W6_5-AS1StZFVW6xUwMDWfMYgg@mail.gmail.com>
        <179AC8FB-5991-4200-9AAC-2F8D0914D5F9@gmail.com>
        <20170827232338.hm5t7t7c2xaa3zyl@sigill.intra.peff.net>
        <CAN0heSoUqcOqVspZkbPahWQdtVpSdtSZoCFWu0ZQJfN3F0mD2g@mail.gmail.com>
        <B1E291F2-86FF-4982-A092-92FAED65385C@gmail.com>
        <20170829185341.s3xlsx4uym7lcluc@sigill.intra.peff.net>
        <20170829185850.tfmjoa5u5sfuwpgi@sigill.intra.peff.net>
Date:   Wed, 06 Sep 2017 12:59:46 +0900
In-Reply-To: <20170829185850.tfmjoa5u5sfuwpgi@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 29 Aug 2017 14:58:50 -0400")
Message-ID: <xmqqmv6879zh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D304A64E-92B7-11E7-9D0F-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> In the long run we may want to drop the "tempfiles must remain forever"
> rule. This is certainly not the first time it has caused confusion or
> leaks. And I don't think it's a fundamental issue, just the way the code
> is written. But in the interim, this fix is probably worth doing.

I notice you also have a series to rework the "must remain forever"
on the list, but nevertheless let's take this one first.

Will queue.

Thanks.

