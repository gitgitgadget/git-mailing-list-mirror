Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A678A201C8
	for <e@80x24.org>; Thu, 16 Nov 2017 03:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932182AbdKPDY3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 22:24:29 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54214 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753766AbdKPDY2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 22:24:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8D6FCB5F74;
        Wed, 15 Nov 2017 22:24:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=a3Hv+uPD/2zRYReiIUiZKw4yyOA=; b=ApSuk+
        HrzszEq7Y4WMKs4Q/5akyv9CkxO1PtZFRC6NQrZYQAbk8ajXb80G2vhX1iHGDZAw
        WOICRUqoCYpzCC5dpy2l8+LbAwuRO5iEBvk1XSPGh09Jnz/Aa3ATk5BsJaUFdfhr
        uGkitpLq6s++wwaXweKf/lUT8rLq4BJtNcVpA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yXS0yWxgIp24D7AEbO70MFXQ5YIiQmnU
        0ds9mTlm36LgEjB9fxebXzKd3yp20eiMnOyLh7L1dFEl1VYUAuVCPDG6tuCL/OxB
        4DPgwQylS9wlxkzV7Dgii7d7O/3841JNj5NpJHjzYSXTLy3GvrL0AGY0kcTrRqj/
        NW/mYwkaMgo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 86014B5F73;
        Wed, 15 Nov 2017 22:24:27 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 006DBB5F72;
        Wed, 15 Nov 2017 22:24:26 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Subject: Re: [PATCHv5 7/7] builtin/describe.c: describe a blob
References: <20171116020039.17810-1-sbeller@google.com>
        <20171116020039.17810-8-sbeller@google.com>
Date:   Thu, 16 Nov 2017 12:24:25 +0900
In-Reply-To: <20171116020039.17810-8-sbeller@google.com> (Stefan Beller's
        message of "Wed, 15 Nov 2017 18:00:39 -0800")
Message-ID: <xmqqwp2qx5w6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A66FFEFA-CA7D-11E7-8603-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> When describing commits, we try to anchor them to tags or refs, as these
> are conceptually on a higher level than the commit. And if there is no ref
> or tag that matches exactly, we're out of luck.  So we employ a heuristic
> to make up a name for the commit. These names are ambiguous, there might
> be different tags or refs to anchor to, and there might be different
> path in the DAG to travel to arrive at the commit precisely.

I am not sure if "And if there is ..." is adding much value here (I
do not think it is even technically correct for that matter).  If
there are more than one tag that point at the commit the user is
interested in, we use one of the tags, as tags conceptually sit at a
higher level.  And we use a heuristic to use one or the other tag to
make up a name for the commit, so the same commit can have two valid
names. ---So what?  Neither of these two valid names is "ambigous";
the commit object the user wanted to name _is_ correctly identified
(I would assume that we are not discussing a hash collision).

Lucikly, if we remove "And if...precisely", the logic still flows
nicely, if not more, to the next paragraph.

> When describing a blob, we want to describe the blob from a higher layer
> as well, which is a tuple of (commit, deep/path) as the tree objects
> involved are rather uninteresting.  The same blob can be referenced by
> multiple commits, so how we decide which commit to use?  This patch
> implements a rather naive approach on this: As there are no back pointers
> from blobs to commits in which the blob occurs, we'll start walking from
> any tips available, listing the blobs in-order of the commit and once we

Is "any tips" still the case?  I was wondering why you start your
traversal at HEAD and nothing else in this iteration.  There seems
to be no mention of this design decision in the documentation and no
justification in the log.

> found the blob, we'll take the first commit that listed the blob. For
> example
>
>   git describe --tags v0.99:Makefile
>   conversion-901-g7672db20c2:Makefile
>
> tells us the Makefile as it was in v0.99 was introduced in commit 7672db20.
>
> The walking is performed in reverse order to show the introduction of a
> blob rather than its last occurrence.

The reversing may improve the chance of an older commit to be chosen
rather than the newer one, but it does not even guarantee to show the
"introduction".

What this guarantees is that a long history will be traversed fully
before we start considering which commit has the blob of interest, I
am afraid.  Is this a sensible trade-off?

> +	argv_array_pushl(&args, "internal: The first arg is not parsed",
> +		"--objects", "--in-commit-order", "--reverse", "HEAD",
> +		NULL);

