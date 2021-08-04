Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D895C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 21:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B21C60F94
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 21:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbhHDVcj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 17:32:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56420 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbhHDVci (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 17:32:38 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BD514DFE48;
        Wed,  4 Aug 2021 17:32:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=98oCL9oURYo+ypckRBxF8H6/arifkQFHDSsLwm
        4pXMY=; b=YXvDqluvQ/W7dtNp81uc9JwRUDOAiMFqDTm6TGrPmlg8+ZJBT3wms/
        zRVpR0w6VvKuhuQSgp5ICeecLw8a8Nu3ZkOdh1i5nPnlXb2OHFI2lS/rW6RvfolD
        aL9M46H88UC9AkmBPfiHGRuZbE8ANLLG/nEaeCzCD4JbIe4KLhs9s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B5679DFE47;
        Wed,  4 Aug 2021 17:32:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 466EDDFE46;
        Wed,  4 Aug 2021 17:32:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: speed up loading of refs via commit graph
References: <08519b8ab6f395cffbcd5e530bfba6aaf64241a2.1628085347.git.ps@pks.im>
        <YQr/vLNjZomIe1ME@coredump.intra.peff.net>
Date:   Wed, 04 Aug 2021 14:32:22 -0700
In-Reply-To: <YQr/vLNjZomIe1ME@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 4 Aug 2021 16:59:40 -0400")
Message-ID: <xmqqo8acnbfd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 74B18150-F56B-11EB-BB0F-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Nice. I've sometimes wondered if parse_object() should be doing this
> optimization itself. Though we'd possibly still want callers (like this
> one) to give us more hints, since we already know the type is
> OBJ_COMMIT. Whereas parse_object() would have to discover that itself
> (though we already incur the extra type lookup there to handle blobs).

Ahh, you read one step further than I did ;-) Yes, if we are already
inspecting type there, doing this optimization inside parse_object()
becomes much easier to justify.
