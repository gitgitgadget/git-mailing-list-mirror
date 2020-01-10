Return-Path: <SRS0=BdMw=27=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BA2C282DD
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 19:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B1820842
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 19:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iP7P+aG8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgAJTlM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jan 2020 14:41:12 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59671 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727812AbgAJTlM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jan 2020 14:41:12 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E72D21DF9F;
        Fri, 10 Jan 2020 14:41:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FCQKSpftzLDXKnXtPQjz1Mv9xu0=; b=iP7P+a
        G8508bKBm/MGF0xAHCH/qmBWo4lfzsIV39guk5ZqOIWsNrrToXZxmDNd/PcEK+k0
        q5WTa3W3kNQeX6ycreZPysN566oOO/2PYM+0G0nU/gHiQc+iA5qFvRroFojD1NrR
        aiNOnufQu//jDnJEjtwvPaR2MUsXNt9wLTHXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NBHQRE5f2O3j1iMVqdv3NjjBTLNMGyNF
        jcVFJdURCB9+gviaO55CFwg9wmhQVh//L80COaZ/JN/+Mqjq0ObIfb13yB1LljaA
        Ks90M2BfOufGyAPL+LwNA3jI7Q6wpNxGRGrm860r9Ijp4eYYZFextIRoGRQkMdgs
        +Lph1AuGnYc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DF4321DF9E;
        Fri, 10 Jan 2020 14:41:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 527A71DF9D;
        Fri, 10 Jan 2020 14:41:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Erik Fastermann <erik@fastermann.de>, git@vger.kernel.org
Subject: Re: Question about the pack OBJ_OFS_DELTA format
References: <1032627506.120165.1578644787174@email.ionos.de>
        <20200110095707.GA459765@coredump.intra.peff.net>
Date:   Fri, 10 Jan 2020 11:41:08 -0800
In-Reply-To: <20200110095707.GA459765@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 10 Jan 2020 04:57:07 -0500")
Message-ID: <xmqq1rs7m757.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 266CAC9C-33E1-11EA-A860-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The pack-format.txt file says:
>
>        offset encoding:
>             n bytes with MSB set in all but the last one.
>             The offset is then the number constructed by
>             concatenating the lower 7 bit of each byte, and
>             for n >= 2 adding 2^7 + 2^14 + ... + 2^(7*(n-1))
>             to the result.
>
> but I think is missing two bits of information:
>
>   - the bytes are in most-significant to least-significant order, which
>     IIRC is the opposite of the size varint
>
>   - each 7-bit byte sneaks in some extra data by implicitly adding "1"
>     to all but the last byte

Isn't the latter mentioned in the paragraph you quoted?
