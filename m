Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A63C43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 17:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8CC20737
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 17:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HTqhbmyj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404284AbgDCReC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 13:34:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56994 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403998AbgDCReB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 13:34:01 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7354D5A01B;
        Fri,  3 Apr 2020 13:33:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7zV+tHOdiQ7/xwDdiQA26NkVuTc=; b=HTqhbm
        yjk/t8IZnky3mAgcdfJVnGib2Djb//ZRrHdMhV+1udskEeCocMag9MfyCLBECH5s
        EL79S8eV2xo8VXE8ADirFxzqSzl0C0S8IzK4xAcQTH33iBTJSI9TxMZGhIbqtymX
        YWmnDA0AA7e2axrnk0Fk+KYxgb2oB48Qqg9FQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ld0gudo7Cxr4tT13lc7HXwIGQy3kL0jK
        pN3BHRfo0jPuLr/XDtrOd9NCmDu4Jael84qG+1rPhKVP9L6cS3XQpt6eJ8gE9tHo
        dmXm+QwH5XhqUs4L1rwCeHxiiVPANSvXL19+p/T+8Jskf4Nimg2CajQR0oiQHNJG
        iAzbPRv+xLc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 69C185A01A;
        Fri,  3 Apr 2020 13:33:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EADF95A019;
        Fri,  3 Apr 2020 13:33:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 9/9] update-ref: implement interactive transaction handling
References: <cover.1585129842.git.ps@pks.im> <cover.1585811013.git.ps@pks.im>
        <5670bea2b15bafbd93d7d507b35e54980ad06fb9.1585811014.git.ps@pks.im>
        <fd4b874a-478f-2139-e910-c000b8a1f396@gmail.com>
Date:   Fri, 03 Apr 2020 10:33:58 -0700
In-Reply-To: <fd4b874a-478f-2139-e910-c000b8a1f396@gmail.com> (Phillip Wood's
        message of "Fri, 3 Apr 2020 14:40:26 +0100")
Message-ID: <xmqqa73s1njt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D113890-75D1-11EA-8EC8-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> I found the talk of "non-transactional" sessions a bit confusing
> because the normal --stdin does update all the refs it is given as a
> single transaction, so that if it cannot update one ref none of them
> are updated. If I've understood correctly these changes are about
> coordinating transactions across several repositories. I'm not sure
> how best to convey that in the man page - perhaps we could call them
> single repository transactions and multi repository transaction or
> something.

FWIW, I described the topic in my "What's cooking" report as adding
an ingredient to implement two-phase commit-style atomic updates
across multiple repositories.  These "prepare to commit, now if you
say 'yes I am ready', there is no taking it back", "now do the
commit as you promised", and "Earlier I made you promise that you'd
commit all when I tell you, but you no longer should commit" are
good enough ingredients, but I am not so sure about the actual
implementation in this topic (or it is really possible to make the
promise "ok, now I can commit everything without lock conflicts if
you tell me" with our ref API, which does not have "now freeze all
refs in the repository---from now on until I say otherwise, no refs
can be manipulated", in the first place).

