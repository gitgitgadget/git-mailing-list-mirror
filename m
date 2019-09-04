Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D63FF1F461
	for <e@80x24.org>; Wed,  4 Sep 2019 23:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbfIDXgA (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 19:36:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59084 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfIDXgA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 19:36:00 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9EE3522B11;
        Wed,  4 Sep 2019 19:35:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3UabsyRJz+EpIu5ik89e4vnBP14=; b=jJYiP5
        /1NuhdtF+QkbFm/eqwptvBXt3uJlzgdh2qAOiD4qxrF/3jdCTzxeVsJe8WXDssII
        WgyOW2kALLhMAX99IrF8wks9tvhQFnxtMcpqDzkp5O2L7Zr9cEAWWES4bUr7pXhA
        4YZd+KT4C9c2m3z7Ho0TGgpxESQ+nVkukzZP8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BVBa/xrPuPkeF0V6BQQRDS+bSfARBZrY
        nY7J+SshljxzOSr13wMGvK1sB5kFxKvC++TCA6bt9bTiFzXO3xQfFwmRo0dr+371
        ThBDu75SUXcbq4BNzqWGiCGilDhH181EkYQj54Piyz2Qgf7R9vtP8z3LwT4UkH5m
        OGJ9mHyVXak=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 96D9122B10;
        Wed,  4 Sep 2019 19:35:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D6A1D22B0F;
        Wed,  4 Sep 2019 19:35:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>,
        David Turner <dturner@twosigma.com>
Cc:     stolee@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH] cache-tree: do not lazy-fetch merge tree
References: <69f2b069-3e11-4a2e-9b81-bde18c463d8c@gmail.com>
        <20190904223529.135623-1-jonathantanmy@google.com>
Date:   Wed, 04 Sep 2019 16:35:55 -0700
In-Reply-To: <20190904223529.135623-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Wed, 4 Sep 2019 15:35:29 -0700")
Message-ID: <xmqq7e6nskh0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BE60C148-CF6C-11E9-AD25-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> When cherry-picking (for example), new trees may be constructed. During
> this process, Git constructs the new tree in a struct strbuf, computes
> the OID of the new tree, and checks if the new OID already exists on
> disk. However, in a partial clone, the disk check causes a lazy fetch to
> occur, which is both unnecessary (because we have the tree in the struct
> strbuf) and likely to fail (because the remote probably doesn't have
> this tree).

FWIW, this logic dates back to aecf567c ("cache-tree: create/update
cache-tree on checkout", 2014-07-05), when "checkout" learned to
perform opportunistic revalidation of cache-tree data structure,
without writing into the object store.  If we were lazily checked
out, and created a blob locally that happens to match the original
we did not fetch in a directory this piece of code is hashing, the
resulting hash _may_ name a tree that the other side has that we did
not fetch, so taking the "to_invalidate = 1" side would make the
resulting cache-tree less optimal, but because the design choice
being made here is to take that hit in order to avoid network cost,
as long as that is documented properly (iow, "probably doesn't have"
is not an issue; even if they have it, you do not want to fetch and
make the cache-tree entry valid), it is OK.


