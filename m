Return-Path: <SRS0=rdad=ID=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517FEC433DB
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 23:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11489650A1
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 23:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbhCEXVZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 18:21:25 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51492 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhCEXVC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 18:21:02 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 22C0AA290F;
        Fri,  5 Mar 2021 18:21:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KwM/5D94YKUMBWJYkAA9h39wHwg=; b=myUQwu
        dl8ZPvp+lLQOj1dsxOpFTx3nFQaGFhJmcszuKE8VijOu+c1VswZd5TOgbb1B4P7z
        theLousYWZ3lUs2ErSyrGHBHr9hpDi1ACB/EX5IzxhgJAPQtt1JtsfKB2tvbzHWq
        Xaw7sOfn80DRGR1zorr+3y/Bhq014az8t2D54=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=X6jW3tq94dyUA2vlVvv0ZgO+1oSzsUHy
        tL9drKzQrw7aHkOhpjnBaym0aZ19iYSWxzLdK/YGHnUFSlb/QMpOyC1H7WB5YeL6
        7Qo6ptsk3n9tCdLYEBg8qKvg33bZDDHPVGbnG6V/4ZwdxF8xJSY7sCH8YaIej41p
        DyXXWwcZFpc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1B4AAA290E;
        Fri,  5 Mar 2021 18:21:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9D88CA290C;
        Fri,  5 Mar 2021 18:21:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, nmulcahey@google.com
Subject: Re: [PATCH] fetch-pack: do not mix --pack_header and packfile uri
References: <YEF5BfE6eXmhhiAf@google.com>
        <20210305011621.599649-1-jonathantanmy@google.com>
        <xmqqzgzha0z5.fsf@gitster.c.googlers.com>
        <xmqqmtvh9ye8.fsf@gitster.c.googlers.com>
Date:   Fri, 05 Mar 2021 15:20:59 -0800
In-Reply-To: <xmqqmtvh9ye8.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 05 Mar 2021 11:46:39 -0800")
Message-ID: <xmqqr1kt89wk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 732691D8-7E09-11EB-8C4A-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> THis makes it sound like the entire idea of this offending commit
>> was wrong, and before it, the codepath that processed the packfile
>> fetched from the packfile URI were using the index-pack correctly
>> by using index-pack arguments that are independent from the one that
>> is used to process the packfile given in-stream.  Why isn't the fix
>> just a straight revert of the commit???
>
> By the way, the band-aid in this patch may be OK for the upcoming
> release (purely because it is easy to see that is sufficient for
> today's codebase), but I said the above because I worry about the
> health of the codebase in the longer term.  The "pass_header" may
> not stay to be the only difference between the URI packfile and
> in-stream packfile in the way they make index-pack invocations.

For example, the URI one presumably is a CDN hosted long term one,
which may be a good candidate to --keep, and in-stream one,
especially when packfile URI feature is used, can be expected to be
recent small leftover bits that it is likely that we do not want to
keep (in fact, if they are small enough, we'd prefer to keep them
loose).
