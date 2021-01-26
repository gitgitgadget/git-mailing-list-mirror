Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C917C433DB
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 06:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 686272075A
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 06:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbhAZGZ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 01:25:57 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60238 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731596AbhAZGS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 01:18:29 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 694F510F441;
        Tue, 26 Jan 2021 01:17:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=OKw2q+EtUXwU
        YrFpWt5zkPQ5S4Q=; b=SnRlzpcV6KSbPyJDG2BPJOHgwx7HFfNBG2XLJC4keR85
        XYJBPNYWM5awRovXgDZr4yzZKDHRPwZKB3GCnqCg5BkNjYnM42TIl6AjRx/0Fxls
        nLNoDrBa1LhLwCEy7X9vZc5PsmEz6/LAZ1Yy2s2nJVolPqZlmw2WEYJvkzsaN1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Q8FnPW
        Mwg0CtYJbiKLLDTpEIBm0BLmGFPdX3UHx1bAM2upEmrTzGCdZCNIkfCnSQE4SsFZ
        e42zpNKVEOEsrRIAvtTNm0biMj0d41FpGIkwqVV0ObMF9dtYL34R5eK5uXVUDKbw
        z4KtVoqvsUTFLWNT24H8395dfTUlH8Z0W6EeY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5610310F440;
        Tue, 26 Jan 2021 01:17:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8DF6010F43F;
        Tue, 26 Jan 2021 01:17:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?=E9=98=BF=E5=BE=B7=E7=83=88_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?6Zi/5b63?= =?utf-8?B?54OI?= <adlternative@gmail.com>
Subject: Re: [PATCH] strbuf.c: optimize program logic
References: <pull.846.git.1611637582625.gitgitgadget@gmail.com>
Date:   Mon, 25 Jan 2021 22:17:41 -0800
In-Reply-To: <pull.846.git.1611637582625.gitgitgadget@gmail.com>
 (=?utf-8?B?IumYv+W+t+eDiA==?= via
        GitGitGadget"'s message of "Tue, 26 Jan 2021 05:06:22 +0000")
Message-ID: <xmqqy2gg2pdm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 335A8598-5F9E-11EB-8CB5-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"=E9=98=BF=E5=BE=B7=E7=83=88 via GitGitGadget" <gitgitgadget@gmail.com> w=
rites:

> From: ZheNing Hu <adlternative@gmail.com>
>
> the usage in strbuf.h tell us"Alloc is somehow a
> "private" member that should not be messed with.
> use `strbuf_avail()`instead."

When we use the word "private", it generally means it is private to
the implementation of the API.  IOW, it is usually fine for the
implementation of the API (i.e. for strbuf API, what you see in
strbuf.c) to use private members.

In any case, these changes are _not_ optimizations. =20

Replacing (alloc - len - 1) with strbuf_avail() is at best an
equivalent rewrite (which is a good thing from readability's point
of view, but not an optimization).  We know sb->alloc during the
loop is never 0, but the compiler may miss the fact, so the inlined
implementation of _avail, i.e.

	static inline size_t strbuf_avail(const struct strbuf *sb)
	{
	        return sb->alloc ? sb->alloc - sb->len - 1 : 0;
        }

may not incur call overhead, but may be pessimizing the executed
code.

If you compare the code in the loop in the second hunk below with
what _setlen() does, I think you'll see the overhead of _setlen()
relative to the original code is even higher, so it may also be
pessimizing, not optimizing.

So, overall, I am not all that enthused to see this patch.


One thing I noticed is that, whether open coded like sb->len +=3D got
or made into parameter to strbuf_setlen(sb, sb->len + got), we are
not careful about sb->len growing too large and overflowing with the
addition.  That may potentially be an interesting thing to look
into, but at the same time, unlike the usual "compute the number of
bytes we need to allocate and then call xmalloc()" pattern, where we
try to be careful in the "compute" step by using st_add() macros,
this code actually keep growing the buffer, so by the time the size_t
overflows and wraps around, we'd certainly have exhausted the memory
already, so it won't be an issue.

But we may want to audit existing code that is not careful when
preparing the second parameter to strbuf_setlen().  We just
analyzed, if we were to accept this patch, that "sb->len + got" that
appear as the second parameter to new call of strbuf_setlen() looks
bad but would not matter in practice, but we may not be so lucky in
other places.

Thanks for a food for thought.

> diff --git a/strbuf.c b/strbuf.c
> index e3397cc4c72..76f560a28d0 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -517,7 +517,7 @@ ssize_t strbuf_read(struct strbuf *sb, int fd, size=
_t hint)
> =20
>  	strbuf_grow(sb, hint ? hint : 8192);
>  	for (;;) {
> -		ssize_t want =3D sb->alloc - sb->len - 1;
> +		ssize_t want =3D strbuf_avail(sb);
>  		ssize_t got =3D read_in_full(fd, sb->buf + sb->len, want);
> =20
>  		if (got < 0) {
> @@ -527,7 +527,7 @@ ssize_t strbuf_read(struct strbuf *sb, int fd, size=
_t hint)
>  				strbuf_setlen(sb, oldlen);
>  			return -1;
>  		}
> -		sb->len +=3D got;
> +		strbuf_setlen(sb, sb->len + got);
>  		if (got < want)
>  			break;
>  		strbuf_grow(sb, 8192);
> @@ -543,7 +543,7 @@ ssize_t strbuf_read_once(struct strbuf *sb, int fd,=
 size_t hint)
>  	ssize_t cnt;
> =20
>  	strbuf_grow(sb, hint ? hint : 8192);
> -	cnt =3D xread(fd, sb->buf + sb->len, sb->alloc - sb->len - 1);
> +	cnt =3D xread(fd, sb->buf + sb->len, strbuf_avail(sb));
>  	if (cnt > 0)
>  		strbuf_setlen(sb, sb->len + cnt);
>  	else if (oldalloc =3D=3D 0)
>
> base-commit: 6d3ef5b467eccd2769f1aa1c555d317d3c8dc707
