Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E9EC2D0EC
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 21:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796FA207FF
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 21:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mb7hTI8S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgDJVvZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 17:51:25 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60047 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgDJVvZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 17:51:25 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 59D89C58BF;
        Fri, 10 Apr 2020 17:51:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Uvyp0tSQFjELGBI5dXA9KhvD6Rc=; b=mb7hTI
        8SZkvqfhDPlkRhLGmphwp6EqMVURT5nZhgMCqfyzznHJxjMZw689ezBuQVWyDOV3
        eDsMZ77Hfq8jik8YltLtLQfvB+lLLb/LJRrb2yHEk3Q/vFDhfph1zVENnDO68Zel
        5IIiPyTrd57OZYejFk8p33Kzi8Y6CkD4KbE14=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sOcVqBt+KxJa7EA+BaCWFhOL+C44v1B/
        REXwtJRTZ0gLBGhmD6v0w/Gr6KzE0FXJltNXrcTYe40/LaGBCvU+J0DnD4ld8TY1
        C1NRNAGHk+1atVAn4HHXk1/PZUcIeGBcl8ofjBIWFWKKaB89C8LeXhrcN+uvQvFk
        CByU2p3OjX8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 50844C58BE;
        Fri, 10 Apr 2020 17:51:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9D63AC58BD;
        Fri, 10 Apr 2020 17:51:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/6] config: drop useless length variable in write_pair()
References: <20200410194211.GA1363484@coredump.intra.peff.net>
        <20200410194445.GC1363756@coredump.intra.peff.net>
Date:   Fri, 10 Apr 2020 14:51:20 -0700
In-Reply-To: <20200410194445.GC1363756@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 10 Apr 2020 15:44:45 -0400")
Message-ID: <xmqq4ktrhuw7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6A82EFD2-7B75-11EA-8671-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> We compute the length of a subset of a string, but then use that length
> only to feed a "%.*s" printf placeholder for the same string. We can
> just use "%s" to achieve the same thing.

Heh, makes readers wonder why the original author wrote such a
convoluted code.

> The variable became useless in cb891a5989 (Use a strbuf for building up
> section header and key/value pair strings., 2007-12-14), which swapped
> out a write() which _did_ use the length for a strbuf_addf() call.

And that history, i.e. the %.*s formatter being a direct translation
from write(2), explains it.  

Thanks.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  config.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/config.c b/config.c
> index ff7998df46..7ea588a7e0 100644
> --- a/config.c
> +++ b/config.c
> @@ -2545,7 +2545,6 @@ static ssize_t write_pair(int fd, const char *key, const char *value,
>  {
>  	int i;
>  	ssize_t ret;
> -	int length = strlen(key + store->baselen + 1);
>  	const char *quote = "";
>  	struct strbuf sb = STRBUF_INIT;
>  
> @@ -2564,8 +2563,7 @@ static ssize_t write_pair(int fd, const char *key, const char *value,
>  	if (i && value[i - 1] == ' ')
>  		quote = "\"";
>  
> -	strbuf_addf(&sb, "\t%.*s = %s",
> -		    length, key + store->baselen + 1, quote);
> +	strbuf_addf(&sb, "\t%s = %s", key + store->baselen + 1, quote);
>  
>  	for (i = 0; value[i]; i++)
>  		switch (value[i]) {
