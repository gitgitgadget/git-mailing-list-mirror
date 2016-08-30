Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 522851FD99
	for <e@80x24.org>; Tue, 30 Aug 2016 02:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756298AbcH3Cop (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 22:44:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58398 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756203AbcH3Cop (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 22:44:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B65833A552;
        Mon, 29 Aug 2016 22:44:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dZvviTi88tn+ZfZ/sXeBm/z0SE8=; b=kIGTgb
        gvSGcg4tAesYjhnWLr+BU0rnpS6+oi1gb5S67IEpekEraQpYgtuMjhE/r66szivE
        mvau3va7A9JmDKwlwB6wk38RkOzQFYUQ+bXraeJRzmp2SRMo/XiYUEySnqXvYlPp
        6RucuKdDUhWHzZNIl6zwL1D+j/FjlWj1ORGYo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oTACata50UwVEVh7V6SiZmlQzqLDhU6k
        /ArVRD6lLBJ7ijgAMJmeur53QmCLjJDjvWVGNhWGFl58MDfIZ3l+48+/O+u7oenR
        UCECmbAh2AVBqzvMMkbeCGb7nHWpsoqmb9UQcSq2hMZ/2xcdml+0o5iv15ZiIWQZ
        EIvPWR3uomU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AEB713A551;
        Mon, 29 Aug 2016 22:44:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3D7043A54F;
        Mon, 29 Aug 2016 22:44:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/6] require_clean_work_tree: ensure that the index was read
References: <cover.1472137582.git.johannes.schindelin@gmx.de>
        <4122fc996a0076c2426d5e1325f2ce2810ef4f9b.1472137582.git.johannes.schindelin@gmx.de>
        <xmqqmvjv6uxn.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 29 Aug 2016 19:44:40 -0700
In-Reply-To: <xmqqmvjv6uxn.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 29 Aug 2016 16:01:56 -0700")
Message-ID: <xmqq60qj6kmf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B40424E4-6E5B-11E6-B0C5-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I am not sure if it should be left as the responsibility of the
> caller (i.e. check the_index.initialized to bark at a caller that
> forgets to read from an index) ...

Scatch that.  That would not work in a freshly created repository
before doing any "git add".  An empty index is a normal state, so it
would not just be annoying to warn "You called me without reading
the index" but is simply wrong.

It was OK to have "we ensure that we've read into the_index from
some index file" as a fallback in a helper function designed to be
used in a "run once and exit" program, but I'd say as a part of
"libified" helper set, we should just make it a responsibility of
the caller to make sure whatever index entries the caller wants to
have in the_index to be used when calling this helper function.

During the course of developing whatever you are building that calls
this function, perhaps you were bitten by an unpolulated the_index,
_not_ because you genuinely could _not_ find the logical place that
is the best location to read the index file at in your code flow,
but simply because you forgot to read one and with that hindsight,
you _know_ what is the logical right place the index file should
have been read.  That is what I am guessing anyway.

And I further guess that this is a well-meaning attempt to _help_
others not having to worry about _when_ exactly the index file is
read.

But I do not think it is being helpful in the longer term.  When to
read the index file and when to discard the contents matters (and
for callers to which it does not matter, they can always read it at
the very beginning of the program, because by definition it does not
matter).  So let's not do this patch, unless there is some other
good reason to have it.


