Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369FFC433E0
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 22:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7CF164FD3
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 22:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbhCJWQh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 17:16:37 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58392 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhCJWQX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 17:16:23 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7F518123D18;
        Wed, 10 Mar 2021 17:16:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=p+5kX8J/kr2Jk8P7b3BkXjnLHe4=; b=cL1q7H
        xJLZwQjX/nt6gIeiuc0HdiOkQRyEDWJEztHAGk+LrJjgowJ0oE04qvSIpAPTTKMq
        xIxY2gbrG9efVvWsprknJ1M0auGrcT2UX+W9NkZYsY+DouK+kJl/PnC6T0eEbCdu
        p+ajOdEJYx7qNFN3JW+gzY54Wk1MWsF/jropI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wrNjf0nmRozwMSGJ8SX8NmNj8yiCtX/q
        DCODg43Thwxtm91J1OihowmSJuNQfNmQIvXMM0cLav7+tFlKinaw3mpM5yMgzPEY
        JGxS8ypVurvutzXSq+7CpPSNrTU1PXqDNhdXlOUq6oSpAXm6HuwIgjCKr8FuO3hD
        VWxQYqitly8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 76A8B123D17;
        Wed, 10 Mar 2021 17:16:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4AD69123D16;
        Wed, 10 Mar 2021 17:16:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/3] filter-branch: drop multiple-ancestor warning
References: <YEj8meoPn/g6tCe3@coredump.intra.peff.net>
        <YEj8zy5JX+KvlfGJ@coredump.intra.peff.net>
Date:   Wed, 10 Mar 2021 14:16:16 -0800
In-Reply-To: <YEj8zy5JX+KvlfGJ@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 10 Mar 2021 12:07:27 -0500")
Message-ID: <xmqqtupiirin.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3D28D17A-81EE-11EB-94D0-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> When a ref maps to a commit that is neither rewritten nor kept by
> filter-branch (e.g., because it was eliminated by rev-list's pathspec
> selection), we rewrite it to its nearest ancestor.
>
> Since the initial commit in 6f6826c52b (Add git-filter-branch,
> 2007-06-03), we have warned when there are multiple such ancestors in
> the map file. However, the warning code is impossible to trigger these
> days. Since a0e46390d3 (filter-branch: fix ref rewriting with
> --subdirectory-filter, 2008-08-12), we find the ancestor using "rev-list
> -1", so it can only ever have a single value.

;-)

