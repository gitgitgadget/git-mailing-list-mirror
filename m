Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04035C433E6
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 05:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A89E6238EE
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 05:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbhAUF7l (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 00:59:41 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56675 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387765AbhAUDG4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 22:06:56 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 623B7ACF80;
        Wed, 20 Jan 2021 22:06:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ZRYBGYnztDNl
        fASCUQyjwLrzJ2k=; b=V3Rw4ywHm7LJVvH0iGODhllt2rNmGsAPTWddjGXZUyx9
        UQGhX1Vo8M7b0E9+R7cUe0jkNAanELo0gmogU85PFDmir7T8OukF/KgaVvAvwyzo
        vFTgJZ6jtBcqMOo+dnOYsTEU0QGBFOwGHr/mXlP+DGaexpMAH3s2VARb33aau3c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=mLCRNS
        fhPzbzSdOirqDP0BqkVF5T5eBN/KIl3KSSIEqDpmz6pbb4WZuA+eInxlfW8vsuh0
        gQSXhFVxbx8jIqOCGPb0yffleuQszETSHxFb2LUR8DzLrZrkk8ofvGs4TOAafqRl
        44cx1daxJ/xsStgvadeg+syB7tviX4jLBk1Ro=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5980DACF7F;
        Wed, 20 Jan 2021 22:06:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DA77AACF7E;
        Wed, 20 Jan 2021 22:06:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, peff@peff.net,
        stolee@gmail.com, me@ttaylorr.com
Subject: Re: RFC on packfile URIs and .gitmodules check
References: <87o8hk820f.fsf@evledraar.gmail.com>
        <20210120193053.1804670-1-jonathantanmy@google.com>
Date:   Wed, 20 Jan 2021 19:06:11 -0800
In-Reply-To: <20210120193053.1804670-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Wed, 20 Jan 2021 11:30:53 -0800")
Message-ID: <xmqq1refdm58.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9DB5BF28-5B95-11EB-A835-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> We wouldn't be OK, actually. Suppose we have a separate packfile
> containing only the ".gitmodules" blob - when we call fsck_finish(), we
> would not have downloaded the other packfile yet. Git processes the
> entire fetch response by piping the inline packfile (after demux) into
> index-pack (which is the one that calls fsck_finish()) before it
> downloads any of the other packfile(s).

Is that order documented as a requirement for implementation?

Na=C3=AFvely, I would expect that a CDN offload would be to relieve
servers from the burden of having to repack ancient part of the
history all the time for any new "clone" clients and that is what
the "here is a URI, go fetch it because I won't give you objects
that already appear there" feature is about.  Because we expect that
the offloaded contents would not be up-to-date, the traditional
packfile transfer would then is used to complete the history with
objects necessary for the parts of the history newer than the
offloaded contents.

And from that viewpoint, it sounds totally backwards to start
processing the up-to-the-minute fresh packfile that came via the
traditional packfile transfer before the CDN offloaded contents are
fetched and stored safely in our repository.

We probably want to finish interaction with the live server as
quickly as possible---it would go counter to that wish if we force
the live part of the history hang in flight, unprocessed, while the
client downloads offloaded bulk from CDN and processes it, making
the server side stuck waiting for some write(2) to go through.

But I still wonder if it is an option to locally delay the
processing of the up-to-the-minute-fresh part.

Instead of feeding what comes from them directly to "index-pack
--fsck-objects", would it make sense to spool it to a temporary, so
that we can release the server early, but then make sure to fetch
and process packfile URI material before coming back to process the
spooled packdata.  That would allow the newer part of the history to
have newer trees that still reference the same old .gitmodules that
is found in the frozen packfile that comes from CDN, no?

Or can there be a situation where some objects in CDN pack are
referred to by objects in the up-to-the-minute-fresh pack (e.g. a
".gitmodules" blob in CDN pack is still unchanged and used in an
updated tree in the latest revision) and some other objects in CDN
pack refer to an object in the live part of the history?  If there
is such a cyclic dependency, "index-pack --fsck" one pack at a time
would not work, but I doubt such a cycle can arise.

Thanks.
