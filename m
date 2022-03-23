Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2C5C433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 23:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345493AbiCWXb5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 19:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345476AbiCWXbz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 19:31:55 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02236A04F
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 16:30:25 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EBEC012B6F6;
        Wed, 23 Mar 2022 19:30:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=V1tM9UZR4/KZ3B1RZgB7Shx6eDaTjYUjrcdgrx
        vwi5Y=; b=B5pbt7MgYRZhNBcnhgQyCjGx1G2C9/4RMeow3nUEYrNGdoBoxgBOh+
        99Sn0Y6xYpCrphsw+H59N1sNnaZl+OcSoSjQuzzYI7VCou39PfWmKMEX/XTLRlfM
        qw2MGdybVNS0hcUOD8fhx+YjmrWW7GCYz4WnDnT/+f/PlryJTjhhg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E339A12B6F5;
        Wed, 23 Mar 2022 19:30:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 520F912B6F3;
        Wed, 23 Mar 2022 19:30:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, stolee@gmail.com
Subject: Re: [PATCH] commit-reach: do not parse and iterate minima
References: <20220323210803.1130790-1-jonathantanmy@google.com>
Date:   Wed, 23 Mar 2022 16:30:22 -0700
In-Reply-To: <20220323210803.1130790-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Wed, 23 Mar 2022 14:08:02 -0700")
Message-ID: <xmqqbkxwp7qp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 36C0247C-AB01-11EC-9516-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> When a commit is parsed, it pretends to have a different (possibly
> empty) list of parents if there is graft information for that commit.
> But there is a bug that could occur when a commit is parsed, the graft
> information is updated (for example, when a shallow file is rewritten),
> and the same commit is subsequently used: the parents of the commit do
> not conform to the updated graft information, but the information at the
> time of parsing.
>
> This is usually not an issue, as a commit is usually introduced into the
> repository at the same time as its graft information. That means that
> when we try to parse that commit, we already have its graft information.
>
> However, this is not the case when fetching with --update-shallow. In
> post_assign_shallow() in shallow.c, a revision walk is done that also
> parses commits at the shallow boundary before updating the shallow
> information (and hence, the graft information). (This revision walk
> needs to be done before the update because the nature of the update
> depends on the outcome of the revision walk.) If we were to
> revision-walk such a commit (at the shallow boundary), we would end up
> trying and failing to parse its parents because its list of parents is
> not empty (since it was parsed before there was any graft information
> telling us to conceal its parents). This revision walk will happen if
> the client has submodules, as it will revision-walk the fetched commits
> to check for new submodules, triggering this bug.
>
> This revision walk in post_assign_shallow() actually does not need to go
> beyond the shallow boundaries, so the solution is twofold: (1) do not
> iterate beyond such commits, and (2) in doing so, we no longer need to
> parse them, so do not parse them.

This sounds quite tricky.  In this case we may know which commit we
need to avoid (re)parsing to avoid the bug, but would it always be
the case?  It feels almost like we want to unparse the commit
objects when we clear the grafts information in the previous patch,
doesn't it?

