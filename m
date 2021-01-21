Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1673BC433DB
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 18:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEF0A23136
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 18:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbhAUSky (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 13:40:54 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54413 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbhAUSkg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 13:40:36 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 21418107A2C;
        Thu, 21 Jan 2021 13:39:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dDErkOetO+SR01x6B1jsX+s7XnE=; b=EGFzv8
        UaQ4xtxJWywCCd2uypHa7mPt9YmNcZ7FdxxsNKXtDk7h4DU8qig9mUJnMA5sCTx3
        PF07tG3YZusDDpTdziPzupHfzODFMZSeU4RQFDmEfOVf3GXmeSYlFrXhAHZw1jEt
        hzT8oZN9bEx9p7uaRnEFAlsEbGmxq5wHT7CFc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FirSjkKSWAGWjsfSDEyzoPdCVtVPMLVo
        HJ5d3ivvumkfhlJr/9hVNS+Y8txXPhUwlICiaPcxElJdz8Z67RndfoEskzagVfVU
        yjLaN1HOqPB48EiMqJgpdItwiNk58JD9wQoW9ReWhdr0DjsiO82/XVd6SUP9TPk3
        3Pc+k1+rHsY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 19685107A2B;
        Thu, 21 Jan 2021 13:39:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 13846107A13;
        Thu, 21 Jan 2021 13:39:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, peff@peff.net,
        stolee@gmail.com, me@ttaylorr.com
Subject: Re: RFC on packfile URIs and .gitmodules check
References: <xmqq1refdm58.fsf@gitster.c.googlers.com>
        <20210121183238.1780849-1-jonathantanmy@google.com>
Date:   Thu, 21 Jan 2021 10:39:42 -0800
In-Reply-To: <20210121183238.1780849-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Thu, 21 Jan 2021 10:32:38 -0800")
Message-ID: <xmqqbldicexd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 07929F7E-5C18-11EB-8796-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> Jonathan Tan <jonathantanmy@google.com> writes:
>> 
>> Or can there be a situation where some objects in CDN pack are
>> referred to by objects in the up-to-the-minute-fresh pack (e.g. a
>> ".gitmodules" blob in CDN pack is still unchanged and used in an
>> updated tree in the latest revision) and some other objects in CDN
>> pack refer to an object in the live part of the history?  If there
>> is such a cyclic dependency, "index-pack --fsck" one pack at a time
>> would not work, but I doubt such a cycle can arise.
>
> My intention is that the order of the packfiles (and cyclic
> dependencies) would not matter...
> I'm currently working on
> getting index-pack to output a list of the dangling .gitmodules files,
> so that fetch-pack (its consumer) can do one final fsck on those files.

In other words, it essentially becomes "we check everything we
obtained as a single unit across multiple packs, but for performance
we'll let index-pack work as much as possible on each individual
pack while it has necessary data in its core, and then we conclude
by checking the objects on the 'boundaries' that cannot be validated
using info that is only in one pack".

That does sound like the right approach.  THanks.
