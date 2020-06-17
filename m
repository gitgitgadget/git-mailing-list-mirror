Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30599C433E1
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 20:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0C67212CC
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 20:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uF/ks+nY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgFQUrA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 16:47:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53427 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgFQUq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 16:46:59 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BDD267D0F9;
        Wed, 17 Jun 2020 16:46:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HG/kyU/0bpnCab8ykSlMuZzPC6w=; b=uF/ks+
        nYxLmlNRW6pI1LZ/v+Kpd8RKdwPqirXEpq3j/9jpQb6YgcObDOTPR2yae+SQzJvI
        R6Ns1R5MR1uGeau424WX3p1YrIsP4fbe5EdKCxR8KcCdffmNNA/IXYJWZ1ILOJYr
        n7WoPLOUn1Po4HmMvSYxUBZKlKZ7nYTg5Lo7o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DGdc125A8Wdmmhk4nK0nhkns/3MbIBpJ
        8CaJ26FbujuW6HhI0FJjUemMw4kCgNNDqP0zIcShOPZtGT1+yqUHaugjYizbQZZ8
        NkeQhU9vxnUELA+3gHOuM05bAWIuTX8PFyy2W+z0sjhtcIjmaIAgENizQz1baZlO
        ZywVjBFFygc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B41597D0F8;
        Wed, 17 Jun 2020 16:46:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 392427D0F7;
        Wed, 17 Jun 2020 16:46:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com, avarab@gmail.com,
        abhishekkumar8222@gmail.com, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 0/2] Accelerate "git merge-base --is-ancestor"
References: <pull.664.git.1592414670.gitgitgadget@gmail.com>
Date:   Wed, 17 Jun 2020 13:46:56 -0700
In-Reply-To: <pull.664.git.1592414670.gitgitgadget@gmail.com> (Derrick Stolee
        via GitGitGadget's message of "Wed, 17 Jun 2020 17:24:27 +0000")
Message-ID: <xmqqzh91s9mn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AF3C3052-B0DB-11EA-8D73-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> It was recently [1] reported (and not-so-recently [2] reported) that "git
> merge-base --is-ancestor" can be pretty slow. In fact, it is regularly
> slower than "git branch --contains" or "git tag --contains", which are
> answering a "harder" query.
>
> [1] https://lore.kernel.org/git/20200607195347.GA8232@szeder.dev/
>
> [2] https://lore.kernel.org/git/87608bawoa.fsf@evledraar.gmail.com/
>
> The root cause is that the in_merge_base() implementation is skipping the
> fast can_all_from_reach() implementation and using paint_down_to_common()
> instead. Note that these are equivalent: a commit A is in the set of
> merge-bases between A and B if and only if B can reach A.

OK, so in short, this codepath was not taking advantage of the
generation numbers and that was the difference?

