Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891D8C433DF
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 21:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E504207FC
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 21:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WAMT0JHE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404088AbgFXVdS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 17:33:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58133 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403906AbgFXVdS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 17:33:18 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C9B427AF52;
        Wed, 24 Jun 2020 17:33:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=V0EG4X2KSfPuQ1p27wCVtEKXajw=; b=WAMT0J
        HEYIEJrhrmsE/dOxSpX1diK/P5sUKU/h8ty18mc/10stQkw2XcOnkerx1n0LNdiO
        qv2PCErVJo3ZjVNjxhDQdEiDTlYzvr9UOjTlTHiFNhrB89A6tvXcGNN23t7QFf5s
        S29Bcl7fQdyySnwyrt5sQAtCEiBreSbL3FqTg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sYCwNOmWJIL0Nps2aweBtcr3Czgqqc43
        zgnBtUM0hoDcK4m1oVvXm2Xf8uNgJwWqBARzVX0WDL4YQgppMByjAzaNUa9YHmNA
        7eBn5aZnV35YRlcYsrDsR/uXSfPtAMvFjviLoxkOFuRyhqvAuCsCapC5qj2cZ46q
        uSkrXLf1zoU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C1D017AF51;
        Wed, 24 Jun 2020 17:33:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 48C247AF50;
        Wed, 24 Jun 2020 17:33:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] send-email: restore --in-reply-to superseding behavior
References: <20200624195520.2062298-1-aquini@redhat.com>
Date:   Wed, 24 Jun 2020 14:33:14 -0700
In-Reply-To: <20200624195520.2062298-1-aquini@redhat.com> (Rafael Aquini's
        message of "Wed, 24 Jun 2020 15:55:20 -0400")
Message-ID: <xmqqo8p85eud.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4FFAFE8E-B662-11EA-A0F8-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rafael Aquini <aquini@redhat.com> writes:

> git send-email --in-reply-to= fails to override the email headers,
> if they're present in the output of format-patch, which breakes the

Will do s/breakes/breaks/ while applying.

It makes me wonder, however, why it is a good idea to have the I-R-T
in the format patch output in the first place.

>  			elsif (/^In-Reply-To: (.*)/i) {
> -				$in_reply_to = $1;
> +				if (!$initial_in_reply_to) {
> +					$in_reply_to = $1;
> +				}

I can see how this would work the way it should for the first
message we send out, so it would work well for a single patch.

But what does this change do to the chaining (either making [PATCH
1/N] thru [PATCH N/N] as responses to the cover letter [PATCH 0/N],
or making [PATCH n+1/N] as response to [PATCH n/N] for 1 <= n < N)
of multiple messages?

When you prepare a series whose 1..N/N are all pointing at 0/N with
the already prepared In-Reply-To (so you have N+1 files to send
out), wouldn't you want to make 0/N a reply to a particular message
you specify on the command line, while keeping the relationship
among your messages intact?  Doesn't having $initial_in_reply_to
(i.e. command line override) help above code break the chaning?



>  			}
>  			elsif (/^References: (.*)/i) {
> -				$references = $1;
> +				if (!$initial_in_reply_to) {
> +					$references = $1;
> +				}
>  			}
>  			elsif (!/^Date:\s/i && /^[-A-Za-z]+:\s+\S/) {
>  				push @xh, $_;
