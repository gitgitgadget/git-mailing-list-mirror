Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A32C43603
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 16:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 901C92173E
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 16:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="w88FyTP0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfLFQkS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 11:40:18 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61828 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfLFQkS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 11:40:18 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8023CAB9F3;
        Fri,  6 Dec 2019 11:40:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=j1cFNoYYjPI4SJ21zHkr2PNKWFA=; b=w88FyT
        P0lYs9HecpArKFvopLzX1NmjRX3ElVIpJ/bvjao5ZhASmC+5lo66XKu9YNfDD/V8
        dRhUV77Pn+PvJt6dHMtnAIFkOzFqjkb8nRs/Cbz0bGc7J9lUEaXT9+k3yJax96P8
        uu6TKdZsDAFBj0D4RLuaJoIW56MR698klouFc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YSe6fGSqbyzr5KNLtPoKDatEV8Q8qQ3y
        6ZoBHlV7/ZqAkyha5DmdX/qtaXXX09DfeKWR/iCZ0/j7s2/bL99xp9loCzlPI7Gv
        41BSuCjFOhGE4wzIJepQ4JY0lepUuyPbJ+TLZoAq/8LmMo3AK7QwPIoR7nf7KHlt
        3NgrYUq1TVo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 786A2AB9F2;
        Fri,  6 Dec 2019 11:40:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 94AB7AB9F1;
        Fri,  6 Dec 2019 11:40:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 7/7] apply --allow-overlap: fix a corner case
References: <pull.172.git.1575637705.gitgitgadget@gmail.com>
        <15c4cce5a027d56c7ddbe5523cf0f3beabd06ed7.1575637705.git.gitgitgadget@gmail.com>
        <xmqqr21hy3cf.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1912061502110.31080@tvgsbejvaqbjf.bet>
Date:   Fri, 06 Dec 2019 08:40:11 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1912061502110.31080@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Fri, 6 Dec 2019 15:11:41 +0100
        (CET)")
Message-ID: <xmqqa785xv9w.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1372AC82-1847-11EA-AF2A-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The beginning is more special than the end because it is associated with
> the line number 1. The end line number is flexible already.

Yeah, we do not insist "the lineno must be X" at the end like we do
at the beginning, but we still insist "there cannot be no post
context if we are adding at the end" just like there cannot be any
pre context for a patch that adds at the beginning, no?

> There is another difference: after splitting hunks, the first hunk is
> applied first, and may render the line numbers of succeeding hunks
> incorrect. The same is not true for the last hunk: it cannot render the
> preceding hunks' line numbers incorrect, as it has not been applied yet.

This truly may make quite a difference, especially because the hunks
are applied in order.

Thanks.
