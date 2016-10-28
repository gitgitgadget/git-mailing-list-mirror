Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFF092035F
	for <e@80x24.org>; Fri, 28 Oct 2016 21:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761424AbcJ1Vfx (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 17:35:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61576 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754384AbcJ1Vfw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 17:35:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A276C4A71A;
        Fri, 28 Oct 2016 17:35:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nMl5xzV54bdNPtFmHEaxHK6UlIo=; b=p7Q7Pk
        JhJ30A0sX4NU5w32emTma4A/zzLStvS8rXrvUVMmk04lercz/7troUnzn97J7btG
        N/YW8ORHcyDgqoUp1HqgkIQG9F3S2G0OsbT/+n4EqEkqeD4ZS0ZFvFe0PQFGxSK3
        lmhieMEPe4uJD94PNDIUjKiohUHyagiq2wBBA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GYVLiGossKcVNF3ihJJjqZo81eTDJ11g
        ihDmzuvN73os+/vuJfapgaCMsojnLxw1jWgD/iAJizya6tBznmaTQOK1NjI7ltML
        zvtNvneWjIRT0Yx01OIEOiaxZ3JmkhHUOCPAFwbe6q3+CMlzWY2ZYs6Cy1P7am84
        6lMG0sRMfQU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9AC594A719;
        Fri, 28 Oct 2016 17:35:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1A6E34A717;
        Fri, 28 Oct 2016 17:35:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, pclouds@gmail.com, git@vger.kernel.org
Subject: Re: [PATCHv2 28/36] attr: keep attr stack for each check
References: <20161028185502.8789-1-sbeller@google.com>
        <20161028185502.8789-29-sbeller@google.com>
Date:   Fri, 28 Oct 2016 14:35:49 -0700
In-Reply-To: <20161028185502.8789-29-sbeller@google.com> (Stefan Beller's
        message of "Fri, 28 Oct 2016 11:54:54 -0700")
Message-ID: <xmqqvawcxikq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F62365C-9D56-11E6-A88E-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Instead of having a global attr stack, attach the stack to each check.
> This allows to use the attr in a multithreaded way.
>
>
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

>  attr.c    | 101 +++++++++++++++++++++++++++++++++++++++-----------------------
>  attr.h    |   4 ++-
>  hashmap.h |   2 ++
>  3 files changed, 69 insertions(+), 38 deletions(-)

This looks surprisingly simple ;-)  I like it.

I briefly wondered if the addition of lock/unlock surrounding
git_check_attrs() function belongs to [27/36], but that step is not
about making things thread-safe and is primarily to prepare existing
users to use an updated API that can be made thread-safe in later
steps.  This [28/36] is the step to have these---so the addition is
not out-of-space at all.  

Nicely done.

As this starts to pass a fully populated check object down to the
callchain that begins at bootstrap_attr_stack(), it makes it easier
to add the per-check optimization to read and keep only the relevant
entries from the attribute files later, by passing check also to the
read_attr_from_file() function.

The "set-direction" thing is not yet thread-safe, but I am not sure
what the best way to go there offhand.  It somehow feels unnecessary
to allow some thread to be going in the GIT_ATTR_CHECKIN direction
while others to be going in the GIT_ATTR_CHECKOUT direction, so we
probably can leave it at a lower priority for now.
