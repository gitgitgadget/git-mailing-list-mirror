Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B927C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 19:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 061246103D
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 19:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240365AbhHaTLG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 15:11:06 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57219 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbhHaTLG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 15:11:06 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 75CD814065F;
        Tue, 31 Aug 2021 15:10:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uhzpZ3r7XmPUXV6SXrrt99e3I2nyblWTGSL1fA
        1xsxo=; b=rEXDG5MKDj49uTj53VB8s9CTg5gJCJRtaamguDjLX1UqJnmliWAQJg
        e7Q1xW40rxTCMpusmT28tsN/GdMUYW7AGxKZ0zQ9pE0rNUr4jXEsZ3q+b+SuuJzY
        rJUJaez9Mdg9iPgJQoVKRoJF1cNdquRM2K5T0Imce26Q5aqDpjCtE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6D60914065D;
        Tue, 31 Aug 2021 15:10:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D4B8A14065C;
        Tue, 31 Aug 2021 15:10:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Tal Kelrich via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tal Kelrich <hasturkun@gmail.com>
Subject: Re: [PATCH] fast-export: fix anonymized tag using original length
References: <pull.1030.git.1630425354496.gitgitgadget@gmail.com>
Date:   Tue, 31 Aug 2021 12:10:05 -0700
In-Reply-To: <pull.1030.git.1630425354496.gitgitgadget@gmail.com> (Tal Kelrich
        via GitGitGadget's message of "Tue, 31 Aug 2021 15:55:54 +0000")
Message-ID: <xmqqlf4htoqa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0DBF06E6-0A8F-11EC-BC35-FA11AF6C5138-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Tal Kelrich via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Tal Kelrich <hasturkun@gmail.com>
>
> Commit 7f4075949686 (fast-export: tighten anonymize_mem() interface to
> handle only strings, 2020-06-23) changed the interface used in anonymizing
> strings, but failed to update the size of annotated tag messages to match
> the new anonymized string.
>
> As a result, exporting tags having messages longer than 13 characters
> would create output that couldn't be parsed by fast-import,
> as the data length indicated was larger than the data output.
>
> Reset the message size when anonymizing, and add a tag with a "long"
> message to the test.
>
> Signed-off-by: Tal Kelrich <hasturkun@gmail.com>
> ---
>     fast-export: fix anonymized tag using original length
>     
>     Fixes an issue with fast-export anonymization, where any original
>     annotated tag message longer than 13 characters would make the output
>     unimportable by fast-import (as the data length indicated the original
>     length).
>     
>     This also resolves a more minor issue, where if the original message was
>     short, the anonymized tag message would be truncated.

Thanks.  I've looked at all places where anonymize_str() is used and
found that this is the only problematic caller.

Will queue.
