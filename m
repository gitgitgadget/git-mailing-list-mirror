Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CCE61F463
	for <e@80x24.org>; Mon,  9 Sep 2019 21:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731688AbfIIVF7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 17:05:59 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63661 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfIIVF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 17:05:59 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A0C3D9400C;
        Mon,  9 Sep 2019 17:05:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BdvnrI+kUMJvjHX0en8gpRIKoEs=; b=ESo7et
        ue7s0ngX0VaHyh/Qt7a1RCZnyhLnEus+feftYw/dSq1lkF4ipUekEWDQEw1d3nRP
        NuS5OaNKpK0uH7BlX6g8TQEWbB5uheqt/uUtE85I0x96v36bzOE3kNwchQtdtjiD
        Ryzu25wPvbzAIR1dE7J9Mk7/L3nS6NeKm6o34=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EHLdCl63IqnpPiYCiI6M/PRJFHgu1sfD
        cpCSKG93B9Vq7jEaugh1d4YwNTjqqlad8xu2Jr9RvVsrNThckcJlQULvPbSlE5l3
        xjei9gpnXOYQngWKdH2GARKIfB6wv0N4Wn7S0KGS/oY4oTSFlDSspixRDzOt9Leu
        xLWCxSbBQm0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 990C79400B;
        Mon,  9 Sep 2019 17:05:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C123094008;
        Mon,  9 Sep 2019 17:05:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, stolee@gmail.com
Subject: Re: [PATCH v2] cache-tree: do not lazy-fetch merge tree
References: <20190903194247.217964-1-jonathantanmy@google.com>
        <20190909190130.146613-1-jonathantanmy@google.com>
        <xmqqsgp5i6s1.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 09 Sep 2019 14:05:53 -0700
In-Reply-To: <xmqqsgp5i6s1.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 09 Sep 2019 12:55:26 -0700")
Message-ID: <xmqqef0pi3im.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9D60A51C-D345-11E9-8650-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Isn't that what is going on?  I thought I dug up the original that
> introduced the has_object_file() call to this codepath to make sure
> we understand why we make the check (and I expected the person who
> is proposing this change to do the same and record the finding in
> the proposed log message).
>
> I am running out of time today, and will revisit later this week
> (I'll be down for at least two days starting tomorrow, by the way).

Here is what I came up with.

    The cache-tree datastructure is used to speed up the comparison
    between the HEAD and the index, and when the index is updated by
    a cherry-pick (for example), a tree object that would represent
    the paths in the index in a directory is constructed in-core, to
    see if such a tree object exists already in the object store.

    When the lazy-fetch mechanism was introduced, we converted this
    "does the tree exist?" check into an "if it does not, and if we
    lazily cloned, see if the remote has it" call by mistake.  Since
    the whole point of this check is to repair the cache-tree by
    recording an already existing tree object opportunistically, we
    shouldn't even try to fetch one from the remote.

    Pass the OBJECT_INFO_SKIP_FETCH_OBJECT flag to make sure we only
    check for existence in the local object store without triggering the
    lazy fetch mechanism.

