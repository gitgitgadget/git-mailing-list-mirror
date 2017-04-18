Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C35921FA26
	for <e@80x24.org>; Tue, 18 Apr 2017 04:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753451AbdDREfX (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 00:35:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61203 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751524AbdDREfU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 00:35:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E7FFE74E83;
        Tue, 18 Apr 2017 00:35:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lsSPqIZ9+LndtIkfubK1ovDqBP8=; b=sdsL57
        wFHfGJGqufwnmdc8dVUJoh8lQi1pdnSJK1bVpldiRJfsbx1EoOFkdqOWazig38BX
        r6Nne8Dx5EGKrJNzlbXEvntf4a93oQGEQGdKSh/uYy3lW3v1wUnVyDhMMNM8HD54
        yqcO2VwoJBam0qn9Vt7p6ZvLnVxqCGI3X3s30=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hX2BZXYkVOOSnXGaVScsvXEqJrYM75sE
        C53yxT5JsMPaESRw2oxWNfQkrS9Oyb4p6yd9bmLzB8qKXiKtIOElsStugVPeEZbp
        mvCI5lZgkc5ZDaREVptzvZs4EVhxUBjppWWRKbEBVCaBlrg1vJgSsuIjB9TbgwSq
        gYPg+MgprQo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DF81B74E82;
        Tue, 18 Apr 2017 00:35:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2A89274E81;
        Tue, 18 Apr 2017 00:35:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Ferreira <bnmvco@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu
Subject: Re: [PATCH v9 4/5] dir_iterator: refactor state machine model
References: <1492462296-4990-1-git-send-email-bnmvco@gmail.com>
        <1492462296-4990-5-git-send-email-bnmvco@gmail.com>
Date:   Mon, 17 Apr 2017 21:35:16 -0700
In-Reply-To: <1492462296-4990-5-git-send-email-bnmvco@gmail.com> (Daniel
        Ferreira's message of "Mon, 17 Apr 2017 17:51:35 -0300")
Message-ID: <xmqq4lxmfi4b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6CCCB41A-23F0-11E7-BA8E-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Ferreira <bnmvco@gmail.com> writes:

> Perform major refactor of dir_iterator_advance(). dir_iterator has
> ceased to rely on a convoluted state machine mechanism of two loops and
> two state variables (level.initialized and level.dir_state). This serves
> to ease comprehension of the iterator mechanism and ease addition of new
> features to the iterator.

I called 3/5 a "refactoring"; on the other hand, I wouldn't call
this refactoring--it is a major rewrite and/or enhancement.

Drop "convoluted...loops and variables"; instead spend the same
number of bits to explain how updated code is easier to follow.

> Add an option for the dir_iterator API to iterate over the root
> directory (the one it was initialized with) as well.

I had trouble understanding what you wanted to say with "iterate
over the root" because the phrase sounded, at least to me, to mean
"opendir the root directory and repeatedly issue readdir() calls,
returning each entry returned by them", and making that optional did
not make any sense to me.  I had to cheat by looking at the test
script to realize that you meant that the root directory that the
iterator is told to iterate over itself is also included in the
result, as opposed to the usual expectation that iterator would just
iterate over the contents of that directory recursively.  Perhaps

    Add an option for the API to also include the initial directory
    in the result.

or something like that?

By the way, some other topic already took t0065, so I moved your
t0065 over to t0066 while queuing.

> +/*
> + * This function uses a state machine with the following states:
> + * -> DIR_STATE_PUSHED: the directory has been pushed to the
> + * iterator traversal tree.
> + * -> DIR_STATE_PRE_ITERATION: the directory is *NOT* initialized. The
> + * dirpath has already been returned if pre-order traversal is set.
> + * -> DIR_STATE_ITERATING: the directory is initialized. We are traversing
> + * through it.
> + * -> DIR_STATE_POST_ITERATION: the directory has been iterated through.
> + * We are ready to close it.
> + * -> DIR_STATE_EXHAUSTED: the directory is closed and ready to be popped.
> + */

These "->" somehow makes it very hard to read; are these meant to be
bullets in a 5-item bulleted list, or do they mean more than that
(e.g. as an arrow, you are trying to say from state PUSHED there is
a transition to PRE_ITERATION, etc.)?

PRE_ITERATION says "*NOT* initialized"; has the directory been
already initialized in PUSHED state?  Instead of saying "*NOT*", it
may make it clearer if you say when it is initialized instead.
