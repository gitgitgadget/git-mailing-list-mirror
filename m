Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC56C433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 06:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EB296192B
	for <git@archiver.kernel.org>; Wed, 12 May 2021 06:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhELGXh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 02:23:37 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61975 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhELGXg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 02:23:36 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BC4D013FCBF;
        Wed, 12 May 2021 02:22:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=A7r8d5jumPr4iLT8tRmCHxuukv6HeMjpjS7Vlz
        gUgZE=; b=d/Lb5VQd9FH428HBLkwfEe1aqC/qPWNty6O2CGyEybkyE+ECW2TG6p
        0o6SSJ7Bb4GWqzyfEI7VLGzVRFglntq8lHHNs7e+3nvBm6ofh1yUaLJmL5aYUQYz
        GKCG5+y8VL0/KRooaOpTlGiHvg3cUxef8PiqfyFlJHaLVPzK5mmJE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B57E413FCBE;
        Wed, 12 May 2021 02:22:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EDBE613FCBD;
        Wed, 12 May 2021 02:22:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Andrew Ottaviano <andrew_o1995@live.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Rebase Question
References: <MN2PR07MB59526F40B255183931649AD19C529@MN2PR07MB5952.namprd07.prod.outlook.com>
        <CAGyf7-GEA0mtxUxqEjYsfqM4Te-5JO5_nW0S6Vitdmywz1J7mg@mail.gmail.com>
        <YJsk49WBd27NrCAA@coredump.intra.peff.net>
Date:   Wed, 12 May 2021 15:22:24 +0900
In-Reply-To: <YJsk49WBd27NrCAA@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 11 May 2021 20:44:19 -0400")
Message-ID: <xmqqy2ckfp3z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6B756D68-B2EA-11EB-817D-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I don't think rerere helps here. In a rebase like this, the problem is
> that it _isn't_ the same conflict.
>
> Imagine a case like this:
> ...
> Applying the first commit gets this conflict (in diff3 form)
>
>   <<<<<<< ours
>   base
>   another
>   ||||||| base
>   base
>   =======
>   one
>   >>>>>>> theirs
>
> After we fix that up to "one\nanother", the second conflict is:
>
>   <<<<<<< ours
>   one
>   another
>   ||||||| base
>   one
>   =======
>   two
>   >>>>>>> theirs
>
> Likewise, even if you had done the original merge between branch tips,
> you'd have seen yet another conflict:
>
>   <<<<<<< ours
>   two
>   ||||||| base
>   base
>   =======
>   base
>   another
>   >>>>>>> theirs
>
> The actual lines changed are the same, but as the nearby context is
> continually shifting, we don't consider these to be the "same" conflict.

Correct.  The conflict you see at each step may be trivial to
resolve, but would not "replay" at all, exactly because they are not
the same conflicts.  Knowing that the user would resolve

    base --> base/another
        \                \
         ---> one--------- one/another

does not help us to decide that

    base --> two -----------
        \                   \
         ---> base/another---???

is resolved to two/another.

