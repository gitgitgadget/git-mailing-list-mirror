Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F293C433B4
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 18:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F19760249
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 18:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbhDOSHQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 14:07:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63520 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbhDOSHP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 14:07:15 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B6435C68B9;
        Thu, 15 Apr 2021 14:06:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mhvQulO3usk47DHPIkp4k5SIAa8=; b=dZ6DIv
        /XZ8LnDxYmxTggVTo3HV91fgsAVAAIdntfaqFgbDdD3t9u3z9qRr3/plyKgpSPRO
        HKsa0l3hvG1HVxGXEulxzluVoFp7FR7s/hMO8tMU20yyQZF5be2dZGQKcILsPVO2
        +eg+rQU3eu0utCBExF9W+TlhzAPi1YTyPmDo8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eq0tLpMvPxNYlGmLqt2HMvfY9pqOk5vK
        tl5SUNJTbBeKbqcNCvgkTK9GnMCyZIqj0nYSKOSWra9PX4UvNBjPMrAIMbfEJ01P
        BqIFfhBJ3ArE9OHH4zaIJWmGY7UAY5HieIPXCJ0VEs+oEKLnDWh/l3m04trNmpDa
        sGqlOns8lmc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AD776C68B8;
        Thu, 15 Apr 2021 14:06:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3534AC68B6;
        Thu, 15 Apr 2021 14:06:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 2/2] repack: avoid loosening promisor pack objects in
 partial clones
References: <20210403090412.GH2271@szeder.dev>
        <20210414191403.4387-1-rafaeloliveira.cs@gmail.com>
        <20210414191403.4387-3-rafaeloliveira.cs@gmail.com>
Date:   Thu, 15 Apr 2021 11:06:50 -0700
In-Reply-To: <20210414191403.4387-3-rafaeloliveira.cs@gmail.com> (Rafael
        Silva's message of "Wed, 14 Apr 2021 21:14:03 +0200")
Message-ID: <xmqqzgxzqv5x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5A5BBA44-9E15-11EB-99E3-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rafael Silva <rafaeloliveira.cs@gmail.com> writes:

> For instance, a partially cloned repository that filters all the blob
> objects (e.g. "--filter=blob:none"), `repack` ends up unpacking all
> blobs into the filesystem that, depending on the repo size, makes
> nearly impossible to repack the operation before running out of disk.

Could you clarify this paragraph a bit more?  It is unclear why the
repository has "all the blob objects" that it can loosen with repack
in the first place, if it was cloned without any blob.  Do you mean
that repack does not stop at the promisor pack boundary and instead
lazily download blobs "on-demand", which ends up as loose objects?

Thanks.
