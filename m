Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D0AC04FDF
	for <git@archiver.kernel.org>; Wed, 16 Aug 2023 16:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344701AbjHPQ3T (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Aug 2023 12:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344702AbjHPQ3E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2023 12:29:04 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4004173F
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 09:29:03 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8C6032CBD8;
        Wed, 16 Aug 2023 12:29:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nac+fzWyqJLep9vqwT9j1pd/XE1ouryjlgUSyU
        vsJSI=; b=XeoVpFCBAwoFDC7tl+j4r89cRTfpNr9amtFvqar8yLxag6Gs+798Nv
        xTydCpBImvhWK9wGMxHoNNhjzMy/hUYaeDA2eQ1hfELNcNPvFFabKzdvXKUMQYhW
        AawVVthbURzFNfKfhmyxM3HcFModunjlPufdHJ4tV6YqK5bsWudZs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8592C2CBD7;
        Wed, 16 Aug 2023 12:29:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 26F212CBD4;
        Wed, 16 Aug 2023 12:29:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Mark Ruvald Pedersen via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Mark Ruvald Pedersen <mped@oticon.com>,
        Mark Ruvald Pedersen <mped@demant.com>
Subject: Re: [PATCH 1/2] sequencer: truncate labels to accommodate loose refs
References: <pull.1562.git.git.1691685300.gitgitgadget@gmail.com>
        <4971e3c52504bf965aa754c9a5d31abddbcc1466.1691685300.git.gitgitgadget@gmail.com>
        <xmqqr0oastxv.fsf@gitster.g>
        <42dd6b6f-4d33-724c-ab15-ba7bb5ead733@gmx.de>
Date:   Wed, 16 Aug 2023 09:28:57 -0700
In-Reply-To: <42dd6b6f-4d33-724c-ab15-ba7bb5ead733@gmx.de> (Johannes
        Schindelin's message of "Wed, 16 Aug 2023 10:36:33 +0200 (CEST)")
Message-ID: <xmqqcyzneyt2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 014B1688-3C52-11EE-8062-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> It is not a performance-critical code path, so I erred on the side of
> simplicity (although I have to admit that the post image of the diff is
> not exactly for the faint of heart).
>
> Could we maybe form the plan to keep in the back of our heads that we
> already have a UTF-8-truncating functionality in sequencer, and in case
> another user should turn up, implemnt that optimized function in
> `utf8.[ch]`?

Yup, that is a good idea.  Even though this one only cares about the
bytecount, we'd eventually benefit from two variants, truncate by
bytecount and truncate by display width.  Both variants should
return an error when given a bytestring that does not make a valid
UTF-8 sequence, and leave it to the caller to truncate at byte
boundary as a fallback, which is trivial (the alternative would be
to do the truncation by the callee, but then caller cannot tell if
the returned result is a fallback result that the end user may need
to be warned about or a known-valid UTF-8 substring if we go that
route, so it would be suboptimal).

Thanks.


