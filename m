Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208E1C433E0
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 01:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC9E922C9E
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 01:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbhATBFB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 20:05:01 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50960 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbhATBE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 20:04:59 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DB1F411C23F;
        Tue, 19 Jan 2021 20:04:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=kQFG4gwM7ZhQu/DE4k+x9T/gNFo=; b=qojTHu
        MbQilM9VJjuASEngvdFuDGkQMrRrh1i3jZ86AzCkngDJelh21+Ho9t2xkvbCrKDm
        j1aZ2DgijOoj1I7p+Zu0ePok3zNUPhUcTAgXtiClGAfebIp1lPK4QwZ3T0PHLNob
        NbApZbJOhUbtx3EAghWuCEo4rQjTH4W0w3qzI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vXRVR/lyb0gN0jszAPEYtZvWfhqluHb3
        fN7NqSvwkhqudGXhEqdbeUs+NlmOtN4VrzSqdWTPgvZGKk80PwUqqzsMrLHfBh4d
        GR9/PgeqsEwGaK1LsuMH6ymU6zFRVUorMvbH5X6LxJfIop4H89/7tTeD+6YXAh4P
        z7+BLvEaTIc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D4C1F11C23E;
        Tue, 19 Jan 2021 20:04:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.99.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 24BAA11C23C;
        Tue, 19 Jan 2021 20:04:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     stolee@gmail.com, me@ttaylorr.com, git@vger.kernel.org,
        peff@peff.net
Subject: Re: RFC on packfile URIs and .gitmodules check
In-Reply-To: <20210119191306.1500480-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Tue, 19 Jan 2021 11:13:06 -0800")
References: <d2ca2fec-a353-787a-15a7-3831a665523e@gmail.com>
        <20210119191306.1500480-1-jonathantanmy@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
Date:   Tue, 19 Jan 2021 17:04:11 -0800
Message-ID: <xmqqsg6wh110.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 68FC324C-5ABB-11EB-94D4-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> It might be nice to teach 'index-pack' a mode that says certain
>> errors should be reported as warnings by writing the problematic
>> OIDs to stdout/stderr. Then, the second check after all packs are
>> present can focus on those problematic objects instead of
>> re-scanning everything.
>
> My initial reaction was that stdout is already used to report the hash
> part of the generated name and that stderr is already used for whatever
> warnings there are, but looking at the documentation, index-pack
> --fsck-objects is "[for] internal use only", so it might be fine to
> extend the output format in this case and report the problematic OIDs
> after the hash. I'll take a look.

If I am not mistaken, Taylor also mentioned the possibility to give
"these objects need reinspecting" to a later process, and it is an
excellent suggestion.  And I think it is perfectly fine to adjust
the internal format used purely for internal use.

Thanks.
