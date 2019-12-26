Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC936C2D0C0
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 20:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A91DB20740
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 20:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="G8OfwRze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfLZUIN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 15:08:13 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55897 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfLZUIN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 15:08:13 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0E7F8A859C;
        Thu, 26 Dec 2019 15:08:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZbAdGTXoESrIUicZuL+E+hYeLg8=; b=G8OfwR
        zedms85sgrEJijyEBnW96c8J351bjS0x66yZDwnh1RaOHGm2YjVEd5tN3ckwf1qp
        shEQM4PTGVtlL9nivtKs8zgJxabPEDy3eySW+Yl2TFu+1lKmjlDx1TAVOrU16uUJ
        v+OyLNBbEOfN7lKXVQ2J4hnM0smcey/gB6oXY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SginRwRvQntJcnZ7O0t3iWRXsW1O4J23
        Y7E2DvCmAmz50FKNe0wv8TuAAuK9zWaxet0c5mCc2wnooHskfkBRyoXlcxwI56xh
        NFa8x7YR9qbuR2oj9byLov0XevK1LGiUU/w5jB+2q4PPsvx5BGgxN5ZZnk+Qb4GR
        JK+u476Oa/4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 06FF1A859B;
        Thu, 26 Dec 2019 15:08:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3CD0BA859A;
        Thu, 26 Dec 2019 15:08:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] t/check-non-portable-shell: detect "FOO= shell_func", too
References: <20191224005816.GC38316@google.com>
        <20191224010110.GF38316@google.com>
        <xmqqfth6lwgl.fsf@gitster-ct.c.googlers.com>
        <20191226195357.GA170890@google.com>
        <20191226195747.GC170890@google.com>
Date:   Thu, 26 Dec 2019 12:08:05 -0800
In-Reply-To: <20191226195747.GC170890@google.com> (Jonathan Nieder's message
        of "Thu, 26 Dec 2019 11:57:47 -0800")
Message-ID: <xmqqblruluje.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6F2C775E-281B-11EA-8D70-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Just like assigning a nonempty value, assigning an empty value to a
> shell variable when calling a function produces non-portable behavior:
> in some shells, the assignment lasts for the duration of the function
> invocation, and in others, it persists after the function returns.
> ...
> diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
> index 38bfeebd88..fd3303552b 100755
> --- a/t/check-non-portable-shell.pl
> +++ b/t/check-non-portable-shell.pl
> @@ -46,7 +46,7 @@ sub err {
>  	/(?:\$\(seq|^\s*seq\b)/ and err 'seq is not portable (use test_seq)';
>  	/\bgrep\b.*--file\b/ and err 'grep --file FILE is not portable (use grep -f FILE)';
>  	/\bexport\s+[A-Za-z0-9_]*=/ and err '"export FOO=bar" is not portable (use FOO=bar && export FOO)';
> -	/^\s*([A-Z0-9_]+=(\w+|(["']).*?\3)\s+)+(\w+)/ and exists($func{$4}) and
> +	/^\s*([A-Z0-9_]+=(\w*|(["']).*?\3)\s+)+(\w+)/ and exists($func{$4}) and

Thanks for a quick fix.

It is kind-of surprising that there was only one existing offender.
