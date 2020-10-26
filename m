Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9FAC4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 17:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7CC32070E
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 17:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WeSGMae/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1787401AbgJZRMv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 13:12:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58499 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1787390AbgJZRMs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 13:12:48 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EB1AD90298;
        Mon, 26 Oct 2020 13:12:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=09RB1cLrAnXDbWnBw9+ACsyU5oA=; b=WeSGMa
        e/a3aEtW1IfKBIpgPggxSWFP7+W0UTQxe6wMOg1VX/ME8LoGCQ/L4Uczdm8pCNGK
        gnF9HRIxe2tNK95R2uzheW/2G7Lc8gENFPsV8CndAvOnXREY5AGkmHFuRTlgy1N+
        bNnXy8vhncsA+owvBJH43rOm/1+Fl+V9gHP3c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=v0z/0q3VpB5gqhiHb8BCV0Q0fLy/YOHH
        SmkXn1fVM15hMmXP39TjwZWblmdSPAxW1+AI35QFJgrrcYLA1TU/DkUknfNa6cCq
        7oQrDWj26/QJHMo22ast2OtT0JRUO1HLjcoW/+CF5giL/Qf/uCoY+bDi9wUDHjsd
        CsOYxZ/5pVg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E26CE90297;
        Mon, 26 Oct 2020 13:12:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6DD8190296;
        Mon, 26 Oct 2020 13:12:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     VenomVendor <info@venomvendor.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Re: [PATCH 4/3] am, sequencer: stop parsing our own committer ident
References: <20201023070747.GA2198273@coredump.intra.peff.net>
        <20201023070939.GB2913115@coredump.intra.peff.net>
        <20201023072630.GA2918369@coredump.intra.peff.net>
Date:   Mon, 26 Oct 2020 10:12:45 -0700
In-Reply-To: <20201023072630.GA2918369@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 23 Oct 2020 03:26:30 -0400")
Message-ID: <xmqqft60gbci.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 77AF8014-17AE-11EB-BBEE-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> By the way, I wondered why we needed to do this parsing at all. The
> patch below does this in a much simpler way. It's a little bit ugly, I
> think, because we have to call getenv() ourselves. But that's the way
> fmt_ident() has always worked. We could probably improve that now that
> it takes a whose_ident flag (before that, it had no idea if we wanted
> author or committer ident).
>
> This is on top of the fixes (but we'd perhaps just want to do those on
> 'maint' as the minimal fix).

This could be the nicest step in the whole series, but let's leave
it out of the branch meant for 'maint'.

Thanks.
