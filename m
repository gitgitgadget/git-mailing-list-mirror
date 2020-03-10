Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D20C10F27
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 18:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FEBE21D7E
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 18:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eXtYWKQF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgCJSTl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:19:41 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59974 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgCJSTl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 14:19:41 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 10532BC9F6;
        Tue, 10 Mar 2020 14:19:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+v+RsNB0Rg7i3ZG+fBvhsHgJzkA=; b=eXtYWK
        QFnQHNODtV55iLScGiUg7YE671u0PvG/pZ3IrmqIj/cTux3/0H/lZRmIVMCdV9jk
        rvfeZ97lLLzply9cOmvX/e+6ux6xlMq9Tx0DdOvGHUS7we0z20pRpExcp/4fqD71
        BDNp3xXN+oIdasCs1nmgbfPuJTJvl7olbWnEE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mdJrMbQAtD4uS/KWErtmYbjtkr6QDMk7
        wB0pBqaQCQAPwVmSgQM8lldqzGPgdqbcl8L3BSaX9oqtbRfdZNhOZN44RbMyh9G0
        b01lSCM/9xNhcYjgKu4VwKEkp8cTjd35ZJs8cJRlNTYFr8IxyngbiVZ56/K8veea
        JtA3q3K+UnY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0921ABC9F5;
        Tue, 10 Mar 2020 14:19:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4E0B8BC9F2;
        Tue, 10 Mar 2020 14:19:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] commit-slab: clarify slabname##_peek()'s return value
References: <20200310153049.3482-1-szeder.dev@gmail.com>
        <20200310175446.GB549010@coredump.intra.peff.net>
Date:   Tue, 10 Mar 2020 11:19:33 -0700
In-Reply-To: <20200310175446.GB549010@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 10 Mar 2020 13:54:46 -0400")
Message-ID: <xmqqftegjcne.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B2BDFEE6-62FB-11EA-8BAD-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> But that would get a bit awkward, because peek() returns a pointer, not
> a value (as it should, because the type we're storing may be a compound
> type, which we generally avoid passing or returning by value).  So we'd
> actually need to return a pointer to a zero-initialized dummy value. Not
> impossible, but getting a bit odd.

Do we have a guarantee that callers of the peek only look at, never
touch, the location?  As long as we make it return a "const *", it
might be OK, but a quick look at commit-slab.h tells me that we do
not say "const".
