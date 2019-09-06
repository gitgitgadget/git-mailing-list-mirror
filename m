Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24F421F461
	for <e@80x24.org>; Fri,  6 Sep 2019 17:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395142AbfIFRLR (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Sep 2019 13:11:17 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57782 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387856AbfIFRLR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Sep 2019 13:11:17 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 18D878DB7F;
        Fri,  6 Sep 2019 13:11:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KDSqK83M5fnyvGgxCODJfvOUKwU=; b=tilYQw
        f97DDYJepiyPyn+tjSuJBzYYYbI1yjnVJixafmh8fVhZS4OwSs2JYPEixrvcgL4Z
        yaxqoUvUIImTWTasfnYil/drxCjrcjH+CCfxU6hh+XN8MuBSGMaRVvfths70T/2P
        OP1G/WIjit6EyCgLzJuE1YFscMI88JvfjNwnM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OiOArJK6PhtEBkCczHBTKcrx6oMSj3gw
        6NlAaZ6gCxVk8YNlkZ6a8DvFiNmR/x+tytcsDpBwh6vijTtT56A8l3jikn9xML3m
        77UYqXA7ePVVB/YQIeq7U1wPxjstHdyIwpnok7+nEefiYpNJqXfTo4ot2oG4o/nx
        T9OaAIJbUOc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 112678DB7E;
        Fri,  6 Sep 2019 13:11:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 366578DB7B;
        Fri,  6 Sep 2019 13:11:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        stolee@gmail.com
Subject: Re: [PATCH 3/3] commit-graph.c: handle corrupt/missing trees
References: <cover.1567720960.git.me@ttaylorr.com>
        <9fbd965e3892307bb5bb78952f017624fcc0b73a.1567720960.git.me@ttaylorr.com>
        <20190906061919.GA5122@sigill.intra.peff.net>
        <xmqqo8zxnz0m.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 06 Sep 2019 10:11:09 -0700
In-Reply-To: <xmqqo8zxnz0m.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 06 Sep 2019 09:57:29 -0700")
Message-ID: <xmqq5zm5nydu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 53AD57E0-D0C9-11E9-9486-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> ...
> Is there even a single caller that is prepared to react to NULL?
>
>     Answer. There is a single hit inside fsck.c that wants to report
>     an error without killing ourselves in fsck_commit_buffer().  I
>     however doubt its use of get_commit_tree() is correct in the
>     first place.  The function is about validating the commit object
>     payload manually, without trusting the result of parse_commit(),
>     and it does read the object name of the tree object; the call to
>     get_commit_tree() used for reporting the error there should
>     probably become has_object() on the tree_oid.

At least we need to ensure, not just has_object(), but the object
indeed claims to be a tree object.  It is OK if it is a corrupt
tree object---we'll catch its brokenness separately anyway.

    Hmm, the should we also tolerate the pointed object to be broken
    in a way that it is not even able to claim to be a tree object?
    That would mean that has_object() is sufficient to check here.

OK, so... 

> So, after fixing the above, we may safely be able to die inside
> get_commit_tree() instead of returning NULL.
>
> By the way, I think get_commit_tree() and parse_commit() in fsck
> should always use the value obtained from the underlying object and
> bypass any caches like commit graph---if they pay attention to the
> caches, they should be fixed.  Secondary caches like commit graph
> should of course be validated against what are recorded in the
> underlying object, but that should be done separately.
