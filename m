Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F145BC64E7B
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 18:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87ADC2151B
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 18:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fknsP+xz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbgLAS2I (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 13:28:08 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60402 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbgLAS2I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 13:28:08 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0BF76113DFF;
        Tue,  1 Dec 2020 13:27:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7t4UeT/Hfu/lRgmXmN5nwN/uudY=; b=fknsP+
        xzaCcQJtii2TXYIAql8NEBvenBGFqsv02ifPhAeRv7YnuP4rF4L4LOd7BPyFD3f7
        b3Itox+i96cqZRT66rfk2DP1oZn0/XKK8W5I3pbhVmYgYpneHayXcCZFVGARG2v1
        caZfBUKB1J+AwwaDF1JKl6DPC8xBs4AfFvczU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wL+kddp67fE+QfLIjd520e3dy/Gvb49E
        TJ9GgCxySW5NyOl2LjqeLhvDhzynuTLtOuhxxxTSnAgJ2kNUVhG7anqj6YEeqOuj
        BicYTJKTeAMO+f4YyshwOPQc1mZ4bfBzINuQ2bVvfvkVXVrC+iPGVnNyqaD2FXp9
        Lf7BL78L8iE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 048A6113DFE;
        Tue,  1 Dec 2020 13:27:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4C649113DF8;
        Tue,  1 Dec 2020 13:27:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        emilyshaffer@google.com
Subject: Re: [PATCH v2] builtin/bugreport.c: use thread-safe localtime_r()
References: <27fc158339c91f56210f00dae9015da1d6c781ec.1606777520.git.me@ttaylorr.com>
        <73eb4965807ea2fdf94f815a8f8a2b036296ecca.1606782566.git.me@ttaylorr.com>
        <X8WqFynk23yWT6E3@coredump.intra.peff.net>
Date:   Tue, 01 Dec 2020 10:27:20 -0800
In-Reply-To: <X8WqFynk23yWT6E3@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 30 Nov 2020 21:27:35 -0500")
Message-ID: <xmqqlfehqt4n.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DA60A92A-3402-11EB-ACAB-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> We might also want to do this on top:
>
> -- >8 --
> Subject: [PATCH] banned.h: mark non-reentrant gmtime, etc as banned

I see the patch does more than what subject describes.  

I am not opposed to banning ctime_r() and asctime_r(), but I do not
want to see our future readers wonder why they are banned by the
commit whose title clearly states that we refuse non-reentrant ones
in our codebase.

Thanks.

> The traditional gmtime(), localtime(), ctime(), and asctime() functions
> return pointers to shared storage. This means they're not thread-safe,
> and they also run the risk of somebody holding onto the result across
> multiple calls (where each call invalidates the previous result).
>
> All callers should be using gmtime_r() or localtime_r() instead.
>
> The ctime_r() and asctime_r() functions are OK in that respect, but have
> no check that the buffer we pass in is long enough (the manpage says it
> "should have room for at least 26 bytes"). Since this is such an
> easy-to-get-wrong interface, and since we have the much safer stftime()
> as well as its more conveinent strbuf_addftime() wrapper, let's likewise
> ban both of those.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> TBH, ctime() and its variants are so awful that I doubt anybody would
> try to use them, but it doesn't hurt to err on the side of caution.
>
>  banned.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/banned.h b/banned.h
> index 60a18d4403..7ab4f2e492 100644
> --- a/banned.h
> +++ b/banned.h
> @@ -29,4 +29,17 @@
>  #define vsprintf(buf,fmt,arg) BANNED(vsprintf)
>  #endif
>  
> +#undef gmtime
> +#define gmtime(t) BANNED(gmtime)
> +#undef localtime
> +#define localtime(t) BANNED(localtime)
> +#undef ctime
> +#define ctime(t) BANNED(ctime)
> +#undef ctime_r
> +#define ctime_r(t, buf) BANNED(ctime_r)
> +#undef asctime
> +#define asctime(t) BANNED(asctime)
> +#undef asctime_r
> +#define asctime_r(t, buf) BANNED(asctime_r)
> +
>  #endif /* BANNED_H */
