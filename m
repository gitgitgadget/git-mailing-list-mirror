Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67312C433ED
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 20:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 342BB61242
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 20:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348197AbhDMUW7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 16:22:59 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63706 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346491AbhDMUW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 16:22:58 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 12EB8137F42;
        Tue, 13 Apr 2021 16:22:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mti+IpDJMXTuOmBc3Jhif9K9YU4=; b=xOP7fa
        IkBsLfa5y9QfO2Bkui8LrJz47ffaaBycKA0YRnBhJD2LiOy8pilqwSMTdN700EY3
        VkopX3/aruMnLwNW/KP/UhpZy40duHTUqqugJwkUnCJL1TK6O9oX02fnHXBcKVjg
        BQUO6088+YPBc4MCGtFHoaFb9WzvAKbxAwGUI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sx+zyefBvJ3x/woSAMPWPL7ykjNL8ziu
        C7j/FeCZrikD9KTP6CLk/1EgCSD9I1CodoVBvv8hHDEqKooZe2S5qKYR++H2Q+ZI
        qGM+mXk7ZP4Bvkj070RO+t3fTsJ7fJuWMc1MwVOdKpxgto91OK0yvbD34Y3GZlLd
        rMrQ7apVJjU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0B813137F41;
        Tue, 13 Apr 2021 16:22:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4729B137F3E;
        Tue, 13 Apr 2021 16:22:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] revision: avoid parsing with
 --exclude-promisor-objects
References: <YHVECXHfZ1bidTJH@coredump.intra.peff.net>
        <YHVFnNvGim8Iduwq@coredump.intra.peff.net>
Date:   Tue, 13 Apr 2021 13:22:31 -0700
In-Reply-To: <YHVFnNvGim8Iduwq@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 13 Apr 2021 03:17:48 -0400")
Message-ID: <xmqqpmyykk8o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FA9553B6-9C95-11EB-94D9-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ... The only reason we call parse_object() is that
> we need a "struct object" on which to set the flags. There are two
> options here:
>
>   - we can look up just the object type via oid_object_info(), and then
>     call the appropriate lookup_foo() function
>
>   - we can call lookup_unknown_object(), which gives us an OBJ_NONE
>     struct (which will get auto-converted later by object_as_type() via
>     calls to lookup_commit(), etc).
>
> The first one is closer to the current code, but we do pay the price to
> look up the type for each object. The latter should be more efficient in
> CPU, though it wastes a little bit of memory (the "unknown" object

That's clever.  I like it.

>   5600.5: count commits                0.37(0.37+0.00)     0.38(0.38+0.00) +2.7%
>   5600.6: count non-promisor commits   11.74(11.37+0.37)   0.04(0.03+0.00) -99.7%
>
> The improvement is particularly big in this script because _every_
> object in the newly-cloned partial repo is a promisor object. So after
> marking them all, there's nothing left to traverse.

;-).
