Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E40ACA0FF3
	for <git@archiver.kernel.org>; Fri,  1 Sep 2023 20:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350715AbjIAUVW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Sep 2023 16:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350713AbjIAUVV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2023 16:21:21 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B6210CF
        for <git@vger.kernel.org>; Fri,  1 Sep 2023 13:21:15 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 053052666C;
        Fri,  1 Sep 2023 16:21:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=HeyKG1YsrH5d0B6MXp50RvnGWH/InoxVnVm8q7
        Vyx7w=; b=WkPx1eEEGNOl/czEtW+RWVU4pc7JuHEaBI8bHYa4qr8GcOTeJ2HcuI
        l+PydNG0yT+mMGhH7hs4XsZdrOAAPXoEfTFzidokUTpIyqnqUFROp6Rn3WJ3MWg3
        LS7/vf9KB+RI6ESDGr044ZrOlc2L2u2TqrCawN6XDIMLCd6fX6M+Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F12742666B;
        Fri,  1 Sep 2023 16:21:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 99C3C2666A;
        Fri,  1 Sep 2023 16:21:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Kousik Sanagavarapu <five231003@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] ref-filter: sort numerically when ":size" is used
In-Reply-To: <20230901191639.GA1955435@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 1 Sep 2023 15:16:39 -0400")
References: <20230901142624.12063-1-five231003@gmail.com>
        <xmqqa5u5rgis.fsf@gitster.g>
        <20230901174540.GB1947546@coredump.intra.peff.net>
        <xmqqr0nhpyf3.fsf@gitster.g>
        <20230901183206.GA1952051@coredump.intra.peff.net>
        <ZPI0e1XzZrDV2fJk@five231003>
        <20230901191639.GA1955435@coredump.intra.peff.net>
Date:   Fri, 01 Sep 2023 13:21:10 -0700
Message-ID: <xmqq7cp9prux.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 17B4E31C-4905-11EE-B005-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> But I think that is the wrong way to optimize it. We shouldn't be
> storing any strings per-atom, but rather walking the parse tree to
> produce a single output buffer. And the values should be cheap to fill
> in, because we should parse the object as necessary up front. This is
> more or less the way the pretty.c parser does it.

I thought "as necessary" may be a bit tricky as populate_value()
were taught to omit doing the whole get_object() thing when the
values for used_atom[] are all computable without parsing the object
at all, but it seems that over time the populate_value() callchain
has degraded sufficiently to unconditionally call get_object() these
days, so I agree that the arrangement does not have much optimization
value, at least in the current code.

