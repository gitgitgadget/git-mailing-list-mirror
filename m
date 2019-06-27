Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D2321F461
	for <e@80x24.org>; Thu, 27 Jun 2019 21:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfF0Vzv (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 17:55:51 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53955 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfF0Vzv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 17:55:51 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2ACF66B67C;
        Thu, 27 Jun 2019 17:55:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7Uldxm6VmeXpa3nAthlVaPfw2Ns=; b=QNbQVp
        M7QI0Xr1a+zsoEy3W16805EBIkEf4vplTNpMr7jQZwvkQYAwcfcMXWyEAdXdPjzX
        j5kHAAzcgG8s6EKpgMRmWcDvEDQhOIOrUf59mJoS2lMCSNoXOlo2brqleEnVTFxa
        5h55lZeUnq1RMLvXpCaIBoI2wNIoIJy3LNcYk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CeheaaB8IAgEmhj3qppPx1zLzr4PibgV
        GZd7SWX5OrO5N/SX/AYgvcX+p+ZSTSRLxOVcQootwzpbkQKk9Ekt2BkvodUbbDWG
        7Lc8s8OdTruhNBLahunODypeA8aLbEtz6Fnc3ky9DZ9D3SN3kqchL+qtbswuu+2f
        KHhAEBMOSlg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 21E796B67B;
        Thu, 27 Jun 2019 17:55:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4DB026B677;
        Thu, 27 Jun 2019 17:55:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: fprintf_ln() is slow
References: <20190627052515.GA21207@sigill.intra.peff.net>
        <20190627055739.GA9322@sigill.intra.peff.net>
        <CACsJy8Cjn2z7TrH9HLQ94Ph7qPZ0fC01J=Lq7GcrhvaCQZaSmg@mail.gmail.com>
        <20190627212154.GB20250@sigill.intra.peff.net>
Date:   Thu, 27 Jun 2019 14:55:44 -0700
In-Reply-To: <20190627212154.GB20250@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 27 Jun 2019 17:21:54 -0400")
Message-ID: <xmqqimsqae1r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 514D134E-9926-11E9-AAEA-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'm also not entirely convinced it's worth caring about this problem at
> all (whether the solution is buffering here, or just adding the "\n"
> back to the original strings). It's true that p1451 shows off a
> measurable improvement, but I think it's a silly, pathological case. I'd
> be surprised if anybody ever noticed the difference in the real world.

Yup, exactly my thought.

> The biggest benefit I see to dealing with it is not performance, but
> that it makes our messages more likely to appear atomically in the
> output (if multiple entities are writing to stderr).

I was primarily in favor of getting rid of *printf_ln() functions
(there are some 200+ callsites if I counted correctly) as I found it
a bit distracting.
