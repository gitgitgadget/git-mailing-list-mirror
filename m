Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FD5C433E2
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 15:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D484E206EB
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 15:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BNM4qjpr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732134AbgIAP4o (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:56:44 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51605 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731619AbgIAP4m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 11:56:42 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 30E1EF8418;
        Tue,  1 Sep 2020 11:56:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ridvdjQ82aqr/VU3oeYgKw9Uycc=; b=BNM4qj
        pr0sZTtnwGkmJBsUkmbveNlckRd+TCqt6BPDridYOXO5DJ7NOCV8DnGpv+uAfxXe
        2TlrEwRc7tJoptTVd3HgiF1xwsPbBYkuyt1tfnbeKIlgzHtAxsh9v1Obn6bBDG7Y
        JKjtSD+vGRmKCDH322CqGWQU6aPV7xI8MxTr4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tdqDtHMInyKYupA2VBMLw/n0HlkFZvh9
        nH0FitWt7r3h7sZHUioGy1zWR7ywYPgou+eVav1g8UE60jEHCqoK2e5UA1DHwlqT
        6O4aTGl+t1StTE1PEJGyWitZpCYGJB4bRxV+vttJiGWa+Dq+WbYxcTLK4IE6T5ne
        vSjd3p4YjeU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 28DF3F8417;
        Tue,  1 Sep 2020 11:56:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5A1BBF8415;
        Tue,  1 Sep 2020 11:56:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] xrealloc: do not reuse pointer freed by zero-length realloc()
References: <20200901111800.GA3115584@coredump.intra.peff.net>
Date:   Tue, 01 Sep 2020 08:56:35 -0700
In-Reply-To: <20200901111800.GA3115584@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 1 Sep 2020 07:18:00 -0400")
Message-ID: <xmqq7dtdebik.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B7946136-EC6B-11EA-B8E2-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The simplest fix here is to just pass "ret" (which we know to be NULL)
> to the follow-up realloc(). That does mean that a system which _doesn't_
> free the original pointer would leak it. But that interpretation of the
> standard seems unlikely (if a system didn't deallocate in this case, I'd
> expect it to simply return the original pointer). If it turns out to be
> an issue, we can handle the "!size" case up front instead, before we
> call realloc() at all.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  wrapper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/wrapper.c b/wrapper.c
> index 4ff4a9c3db..b0d375beee 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -120,7 +120,7 @@ void *xrealloc(void *ptr, size_t size)
>  	memory_limit_check(size, 0);
>  	ret = realloc(ptr, size);
>  	if (!ret && !size)
> -		ret = realloc(ptr, 1);
> +		ret = realloc(ret, 1);

The original does look bogus.

It however may be easier to reason about if we used malloc(1) in the
fallback path for "we got NULL after asking for 0-byte" instead.  I
would have a hard time guessing the reason why we are reallocating
NULL without going back to this commit, reading the log and seeing
the original to see that the reason why we didn't use malloc() but
realloc() is we aimed for a minimum change, if I encounter this code
after I forgot this discussion.

Thanks.
