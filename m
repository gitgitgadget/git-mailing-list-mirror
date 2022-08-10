Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A90FC00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 21:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbiHJVUc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 17:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiHJVUa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 17:20:30 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A74BB9
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 14:20:29 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A52C14CCC6;
        Wed, 10 Aug 2022 17:20:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JjUSC9FmAZQBNunr8xDJyECV7fy6bl9ij7Q6Ty
        nIRHY=; b=cixyzevpN1IB5K3EBkg+hmNR8dQPfOIqcMks/KzjQKjXEhxrxMX1fV
        oXspvdJ3ng9tispOhuXqXIbrM6As9/YiIt3CkmLua4tS6yfq1YGL76hu27UFApRD
        uocYBr/BEIbJw57o/2Gj569YIYgxEKCPRDSR2ClHzWC9BMTZnO4LE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2131C14CCC4;
        Wed, 10 Aug 2022 17:20:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8B52C14CCC3;
        Wed, 10 Aug 2022 17:20:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v8 08/14] merge-resolve: rewrite in C
References: <20210317204939.17890-1-alban.gruin@gmail.com>
        <20220809185429.20098-1-alban.gruin@gmail.com>
        <20220809185429.20098-9-alban.gruin@gmail.com>
        <08ea1eec-58fb-cbfa-d405-0d4159c99515@gmail.com>
Date:   Wed, 10 Aug 2022 14:20:26 -0700
In-Reply-To: <08ea1eec-58fb-cbfa-d405-0d4159c99515@gmail.com> (Phillip Wood's
        message of "Wed, 10 Aug 2022 16:03:47 +0100")
Message-ID: <xmqqilmzkd7p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 41594814-18F2-11ED-A897-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> git-merge-resolve will happily merge three trees, unfortunately using
> lists of commits will break that.

True.

While I agree that it would make sense to rewrite some strategies in
C, I do not quite see the point of redoing this particular one.  Its
simplicity is one of the only few remaining shining points in the
"resolve" strategy, and it can serve as an easy-to-understand
example to demonstrate what a merge-strategy implementation should
look like.  I however doubt with improvements to the "recursive" and
more recently the "ort" strategy, I do not know how much "real" use
there is to it.  I even suspect that the users do not mind if a
platform does not ship this strategy by default if it has so much
problem running a shell script.

By rewriting it to C, we would lose an easy-to-understand example
that the users can easily run to see how it works, but what we gain
in exchange is not clear, at least to me.
