Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90E6C00A89
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 22:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EA32206C1
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 22:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tF5CjKf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbgJ3WCK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 18:02:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55148 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgJ3WCJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 18:02:09 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BD06B8A160;
        Fri, 30 Oct 2020 18:02:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uDCSSXK5QP05qEeY4f88nGTLqoY=; b=tF5CjK
        f135vuXRFxlCxLVGWKCdsXRHSmVvfDqsTfpnb5GsuBGcphxU51oYNiQ09d1mYHpA
        XRqLs7iRClMMYONO/snE422aRai4ikwICC4xj1VXnMIt166OGZ1bABpN410b5Jq5
        D6Arzr6Pk9t13dLLnnhdXjo/JDJ+s3tHL8hdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=L/tqN0HXfG0RI1iHWQktFv38ow5UNxCd
        nXbUt2zmuU3YffrTxd8zSk3ZZfmRE6PL/ToylY2eEWYAh3QqWUEFpDs5WziboN1l
        rjZpQnMUJS9nuDoMA0jUA5DGkjbkv4X00qXQ01kkwAmey5SiZyYhmcKUi6ihGdjO
        SFGPqRcnpIc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AC7018A15F;
        Fri, 30 Oct 2020 18:02:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BB5658A15D;
        Fri, 30 Oct 2020 18:02:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, git@jeffhostetler.com,
        chriscool@tuxfamily.org, peff@peff.net, newren@gmail.com,
        jrnieder@gmail.com, martin.agren@gmail.com
Subject: Re: [PATCH v3 09/19] entry: add checkout_entry_ca() which takes
 preloaded conv_attrs
References: <cover.1603937110.git.matheus.bernardino@usp.br>
        <e1b886f82320db6fd1b389eb4d63ac45bd5af7b1.1603937110.git.matheus.bernardino@usp.br>
Date:   Fri, 30 Oct 2020 15:02:04 -0700
In-Reply-To: <e1b886f82320db6fd1b389eb4d63ac45bd5af7b1.1603937110.git.matheus.bernardino@usp.br>
        (Matheus Tavares's message of "Wed, 28 Oct 2020 23:14:46 -0300")
Message-ID: <xmqqblgj5q5f.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8CE812B6-1AFB-11EB-9C89-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> The parallel checkout machinery will call checkout_entry() for entries
> that could not be written in parallel due to path collisions. At this
> point, we will already be holding the conversion attributes for each
> entry, and it would be wasteful to let checkout_entry() load these
> again. Instead, let's add the checkout_entry_ca() variant, which
> optionally takes a preloaded conv_attrs struct.
>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---

I think my review comment to 08/19 is partly taken care of with this
step.  Perhaps the progression will become simpler to understand if
we add this new helper first?  I dunno.  In either case, the end
result of applying both 08 and 09 looks quite nicer than the state
after up to 07 are applied.

