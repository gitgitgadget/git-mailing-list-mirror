Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF20C3404B
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 23:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 203CD24656
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 23:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lUI4NQJO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgBRXF2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 18:05:28 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60522 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgBRXFY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 18:05:24 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EE36440BE8;
        Tue, 18 Feb 2020 18:05:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=g6ES9VTLg+DRln0KQRsijCia7+M=; b=lUI4NQ
        JOxrDypW0L9XinMrF4MzLpLee7PYSTbKgkBxeCYF+eEnxiPzzHuAS5xXjuTUT47M
        7Ym8x/RLMhjWrZ+6eV4beV3bEuMsceofZ5Gdo8eAcrKXRghIF8eB39FsrTykla9T
        nSPC088GgsiVENHMaaXXyXtZB+YswP/u6M1Cc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eIk+QehAqRyRQrdY5j52x1c5dy6g2BSl
        JnCCQDwhTglAnUbyDNg11VZ9mSTu4ntIXRVZlqXhWORQH+0q6s5RNDRkatQ/u+/c
        F+dHQZAsHdEBs/uQXDpaUufnC/24+H+rP7oyDKNHKlQcT8AkTxk0k8d1h5HsQgqh
        0n4SFmJFpzQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E5FD640BE5;
        Tue, 18 Feb 2020 18:05:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 582CD40BE3;
        Tue, 18 Feb 2020 18:05:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org,
        rhi@pengutronix.de
Subject: Re: [PATCH] describe: output tag's ref instead of embedded name
References: <xmqqd0ahp0na.fsf@gitster-ct.c.googlers.com>
        <fcf19a46b80322c5579142efe4ec681a4dcbdd28.1581802264.git.matheus.bernardino@usp.br>
        <20200216065101.GA2937208@coredump.intra.peff.net>
        <xmqqd0abk7zc.fsf@gitster-ct.c.googlers.com>
        <20200218195402.GA21586@coredump.intra.peff.net>
Date:   Tue, 18 Feb 2020 15:05:21 -0800
In-Reply-To: <20200218195402.GA21586@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 18 Feb 2020 14:54:02 -0500")
Message-ID: <xmqq4kvnijim.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 23E82DEE-52A3-11EA-8E89-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Coming back to the original topic, ...

> If a tag describes a commit, we currently output not the tag's ref but
> its embedded name. This means that when the tag is locally stored under
> a different name, the output given cannot be used to access the tag in
> any way. A warning is also emitted in this case, but the message is not
> very enlightening:

None of the above is wrong per-se, but the reason why we chose to
use the real name of the tag in the tag object, while issuing a
warning, was so that people can correct the mistake of storing an
annotated tag A to a wrong refname Q.  If "describe" gave a name
based on refname Q, there is no incentive to correct the situation
to use the right refname.  The name that describes the commits
relative to the real name of the A is *not* usable by design, until
the refname is corrected (i.e. the tag is stored in the right
place).

So I am not 100% confident that the original patch is a good idea.
