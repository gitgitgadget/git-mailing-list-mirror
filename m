Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C2FC433DF
	for <git@archiver.kernel.org>; Wed, 13 May 2020 22:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9336520659
	for <git@archiver.kernel.org>; Wed, 13 May 2020 22:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pT0+Tpei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730884AbgEMWSL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 18:18:11 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55665 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730064AbgEMWSL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 18:18:11 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 49F97BDD36;
        Wed, 13 May 2020 18:18:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=a17cwpfbGWVRAvbzTTg3YCCbe9k=; b=pT0+Tp
        eixoKjqhVKSK2AKLX+rhIYXIMzmcTP0FOZ/MK13xHWh75FY4k/6CInRjrBoUbXNx
        OeJxU63d0VlxmuCMHFBOr9wmqO8+JOVqzS/VJPhCZkVvzcSmJWDM1qC/rnVQJ2jW
        gvokv8J/WnQchTjYIdLalh0m7HsemNa+rJ/Eg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uaKfdzvVJxgMtDc/ouclW8PHIoXmiQn+
        Lxkf0LDY8NuR0r8PHz8z0+tYgAvGZdkpsolssHRizUxLuy7XKw5X2fTJ2E5GZxQb
        tFTnj/y4vfJpI0n2iflBu77vJyo2IVDGUpmdS+oR8Y8vmpW7paQrstwzT7+jHF//
        VImTxjNtmoY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 35053BDD34;
        Wed, 13 May 2020 18:18:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6F627BDD33;
        Wed, 13 May 2020 18:18:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Xin Li <delphij@google.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrn@google.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] fetch: allow adding a filter after initial clone.
References: <20200513200040.68968-1-delphij@google.com>
        <xmqqo8qrsh0d.fsf@gitster.c.googlers.com>
        <CAOhzdui-4KeOit74fTy=3YxSncHGZzy+cE+6njyjHPyJ8xFpMA@mail.gmail.com>
Date:   Wed, 13 May 2020 15:18:04 -0700
In-Reply-To: <CAOhzdui-4KeOit74fTy=3YxSncHGZzy+cE+6njyjHPyJ8xFpMA@mail.gmail.com>
        (Xin Li's message of "Wed, 13 May 2020 14:41:00 -0700")
Message-ID: <xmqqsgg3qy1v.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9EAF6FE0-9567-11EA-A61D-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Xin Li <delphij@google.com> writes:

> The proposed change would allow converting an existing git clone to
> use partial clones.  For example:
>
> $ git clone --depth=1 https://android.googlesource.com/platform/bionic .
> $ git fetch --unshallow --filter=blob:none origin
>
> Previously, to allow this one would have to do the following manually
> first; the existing code would handle the rest gracefully:
>
> $ git config core.repositoryFormatVersion 1
> $ git config extensions.partialClone origin
>
> And the proposed change would have git do it for the user
> automatically, the existing workflow remains otherwise unchanged.

Actually, do we even know, when we "upgrade" the repository with the
patch, that the 'origin' supports the required protocol extensions
like on-demand fetching of objects?

At "git clone" time, "git clone --filter=..."  against a server that
is not prepared to serve as a lazy clone's backup remote would fail,
so we will never write extensions.partialClone=origin when origin
cannot serve as such. 

But writing these config you suggest to "do manually" is already not
a safe thing to do, without making sure it is supported, no?  It
does not sound like a good idea to do an unsafe thing for the user
automatically.

Added a few folks on Cc: list, who know and care more about partial
clones than I do for input.

Thanks.
