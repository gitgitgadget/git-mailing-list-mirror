Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B4491F454
	for <e@80x24.org>; Wed,  6 Nov 2019 01:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730553AbfKFBpM (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 20:45:12 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64269 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730125AbfKFBpM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 20:45:12 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 52A5E2AA5E;
        Tue,  5 Nov 2019 20:45:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6LghqbJCpymyPPdiS8YBljH5RrI=; b=IQ+YMd
        ooWTellBmCo4A8wExZ4ZpoQJqRgcQrOrzpjzxWJdqd9JP7zPzVGK4U89GRZV5oYk
        LMKzPS3eoL9DR3oQ/5uXJ+CeqLqKoQQVbH63tj6k7hMuKMsWhl1j6iS/XV1RDHOk
        qE6VlxucXoOw/Ikd8Xl2nWzv1P4TgvuoTBOs4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oPX3JZvX/GSxEa7ufyfKbVEPDyaEcopK
        GeOklDbV8Y1nZcAx2YGcykO4qYv47V35o1xM4RjkjspYgQJZE9HVt/BXZUIU0XUU
        XcsRxQTHQ9InJHV/c/lthcPe8fGWoLbveGQ1u6tM/ZDxvp9hp9j7jvNR/gIUl2BK
        XtA511C8I5w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 499342AA5D;
        Tue,  5 Nov 2019 20:45:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 86CFA2AA5C;
        Tue,  5 Nov 2019 20:45:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, sunshine@sunshineco.com
Subject: Re: [PATCH v2] fetch: remove fetch_if_missing=0
References: <20191101203830.231676-1-jonathantanmy@google.com>
        <20191105185619.207173-1-jonathantanmy@google.com>
Date:   Wed, 06 Nov 2019 10:45:08 +0900
In-Reply-To: <20191105185619.207173-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Tue, 5 Nov 2019 10:56:19 -0800")
Message-ID: <xmqq7e4dydzv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 10F2AF7A-0037-11EA-9A35-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> In fetch_pack() (and all functions it calls), pass
> OBJECT_INFO_SKIP_FETCH_OBJECT whenever we query an object that could be
> a tree or blob that we do not want to be lazy-fetched even if it is
> absent. Thus, the only lazy-fetches occurring for trees and blobs are
> when resolving deltas.
>
> Thus, we can remove fetch_if_missing=0 from builtin/fetch.c. Remove
> this, and also add a test ensuring that such objects are not
> lazy-fetched. (We might be able to remove fetch_if_missing=0 from other
> places too, but I have limited myself to builtin/fetch.c in this commit
> because I have not written tests for the other commands yet.)
>
> Note that commits and tags may still be lazy-fetched. I limited myself
> to objects that could be trees or blobs here because Git does not
> support creating such commit- and tag-excluding clones yet, and even if
> such a clone were manually created, Git does not have good support for
> fetching a single commit (when fetching a commit, it and all its
> ancestors would be sent).
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> Changes from v1:
> - Added NEEDSWORK in test, suggested by Jonathan Nieder
> - Used printf in test, suggested by Eric Sunshine

Nice.  The less we use big "plug the machinery to lazily fetch for
now" switch, the better, I think.

> +setup_triangle () {
> +	rm -rf big-blob.txt server client promisor-remote &&
> +
> +	printf "line %d\n" $(test_seq 1 100) >big-blob.txt

I'll tweak this line while queueing with a trailing " &&" (no need
to resend only for this).
