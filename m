Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCAAC433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 02:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEDF3611BD
	for <git@archiver.kernel.org>; Thu, 20 May 2021 02:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhETC3f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 22:29:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58654 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhETC3f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 22:29:35 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2711AB9742;
        Wed, 19 May 2021 22:28:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=neFnSEhG2ptBP0AdzwCD1ZuMRk3QV/53uGiWmh
        W73Ms=; b=PFI6Cxr7St6M6bcvKvlEtzbVa/JPBgjJs5hta1TET2kAT/mAuDUPk+
        9aLB5D3yphjHjSCE/OXLQggBc0wQSYua5w7fsJgQWuS9UFzTcP04J3NWl4VCjZak
        CRd5Ia69bjTEFhyJXX7bY8X8PcRiLBCZca8uv/iyBigYoG5l6IyPA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 20365B9740;
        Wed, 19 May 2021 22:28:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A5350B973F;
        Wed, 19 May 2021 22:28:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Josh Steadmon <steadmon@google.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: RFC: error codes on exit
References: <YKWggLGDhTOY+lcy@google.com> <xmqqeee2w7ov.fsf@gitster.g>
        <YKXBhDbWMyB6A7z4@google.com>
Date:   Thu, 20 May 2021 11:28:13 +0900
In-Reply-To: <YKXBhDbWMyB6A7z4@google.com> (Jonathan Nieder's message of "Wed,
        19 May 2021 18:55:16 -0700")
Message-ID: <xmqqy2cauojm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 06F1326C-B913-11EB-9453-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>> I am sympathetic to the cause and I agree that introducing a
>> finer-grained classification might be a solution.  I however am not
>> sure how we can enforce developers to apply such a manually assigned
>> "error code" cosistently.
>
> I think two things you're hinting at are "what about maintainability?"
> and "what is the migration path?"

Not really.  There is not much to migrate from, and mislabeling by
developers, or more realistically disagreement between developers
what label is appropriate for which condition that leads to die(),
would be a usability problem and not maintainability that I would be
worried about.

> However, for analysis in aggregate (for example, to define an SLO[1])
> that would require us to maintain a database that maps
> <filename>:<lineno> to error code.  That database would be essentially
> the same as patches to record the error codes, so what it would really
> amount to is having these deployments using a permanent fork of Git.

Yes, the suggestion was to start from there to gain experience,
because ...

> If we expect the error codes to not be useful to anyone else, then
> that is the right choice to make (or rather, we'd have to use other
> heuristics, such as having the traces record a collection of offsets
> in the binary and a build-id so we can key off of stack trace
> signatures).  Part of the reason I started this thread is to get a
> sense of whether these can be useful to others.

... others will find it useful if the classification matches _their_
needs, but I suspect the "bin" a single die() location wants to be
classfied into would end up to be different depending on what the
log collecting entity is after.
