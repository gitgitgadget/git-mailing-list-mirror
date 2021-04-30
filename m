Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167BEC433B4
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 05:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6DEE613E1
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 05:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhD3FnZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 01:43:25 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65232 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhD3FnY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 01:43:24 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 57AF7136453;
        Fri, 30 Apr 2021 01:42:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OuLJZdB1KYSwXNRwKZ5xOPzuM5duqvEK4pVt3q
        wOMXY=; b=uCUFjpI3xn1NUUWE1WNfZ4CvvSWO/9YEoA2Y9vBSOSCPW9QU0nVJbu
        iqHlTdkLiwh5am5FngkQYhvXj6oZWBl++bP7NsFzLVrObTILq6fvZpGwSbQyLqOH
        /5QG1FRLlCeWo/tYmfrZDAcXpo1S7II/w+ERWjp4HDND/18L0cPOQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5160A136452;
        Fri, 30 Apr 2021 01:42:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8DB5C13644B;
        Fri, 30 Apr 2021 01:42:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 0/6] Push negotiation
References: <cover.1617929278.git.jonathantanmy@google.com>
Date:   Fri, 30 Apr 2021 14:42:32 +0900
In-Reply-To: <cover.1617929278.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Thu, 8 Apr 2021 18:09:57 -0700")
Message-ID: <xmqqtunocoqf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DD1EF92A-A976-11EB-BEAC-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Here are patches for push negotiation. The basic idea is that we can
> reuse part of the fetch protocol (and code) to find out what is in
> common between the client and server, and then use that information to
> further narrow the objects sent in the packfile during a push.
>
> Patch 1 is a bug fix that probably should be merged even if the rest
> aren't. Patches 2-4 are refactorings in preparation for the future
> patches. Patches 5-6 contain the actual logic and documentation.
>
> I have written more about it in my prior work [1], although the commit
> messages and documentation in patches 5-6 should be enough to explain
> what's going on. (If they're not, feel free to make review comments.)
>
> The main change from [1] is that the client-side code that used to be in
> builtin/fetch-pack.c is now in builtin/fetch.c, because I realized that
> builtin/fetch-pack.c does not support HTTP. Other than that, all the
> "what hasn't been done yet" items have been done except for statistics
> in the commit message.
>
> [1] https://lore.kernel.org/git/20210218012100.928957-1-jonathantanmy@google.com/

So... anybody else wants to review this and give it a-OK?

> Jonathan Tan (6):
>   fetch-pack: buffer object-format with other args
>   fetch-pack: refactor process_acks()
>   fetch-pack: refactor add_haves()
>   fetch-pack: refactor command and capability write
>   fetch: teach independent negotiation (no packfile)
>   send-pack: support push negotiation
>
>  Documentation/config/push.txt           |   7 +
>  Documentation/technical/protocol-v2.txt |   8 +
>  builtin/fetch.c                         |  27 ++-
>  fetch-pack.c                            | 224 +++++++++++++++---------
>  fetch-pack.h                            |  11 ++
>  object.h                                |   2 +-
>  send-pack.c                             |  61 ++++++-
>  t/t5516-fetch-push.sh                   |  35 ++++
>  t/t5701-git-serve.sh                    |   2 +-
>  t/t5702-protocol-v2.sh                  |  89 ++++++++++
>  transport-helper.c                      |  10 ++
>  transport.c                             |  30 +++-
>  transport.h                             |   6 +
>  upload-pack.c                           |  18 +-
>  14 files changed, 430 insertions(+), 100 deletions(-)
