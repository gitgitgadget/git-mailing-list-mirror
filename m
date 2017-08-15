Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D58D0208B8
	for <e@80x24.org>; Tue, 15 Aug 2017 18:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751565AbdHOSn6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 14:43:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55728 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751095AbdHOSn6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 14:43:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 47E2DA5690;
        Tue, 15 Aug 2017 14:43:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=QVy9OCh2cDl4
        VoX3oZ4CC1vmy1w=; b=egMyedpi0N/5SqvdT2kw020otxBdQXGn0PXEC/DlwZQh
        dDRtwYwrA+i1i1ZMdB1vuoVQHWvO1G2eVri4BAJJQiIvT0GWN3lIXQhTBsIgtw5I
        DjZy4AGsf9E+lwGCc45qY1Xp/UmCcwi9LpQONnT/MMsh3fOtrgfaXfvpEokquoI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=QCJeft
        el2dkTx5dxcYoJkyAZsMaY1WIPErPHGsINZxNNS6HvUMZSJab7lLS3AkmgrJqi5i
        zPnX3LmTfCcmYItdy+wxmbfHUPoWjevT87Dlpr9SlzOjyLS9gj8VVlbWVZykkrXD
        w8WYiOOHL6s50WUgkv0z6gG7jGjQZGaaE1r2c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 36BF8A568F;
        Tue, 15 Aug 2017 14:43:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 99FBEA568D;
        Tue, 15 Aug 2017 14:43:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/5] strbuf_reset: don't write to slopbuf with ThreadSanitizer
References: <cover.1502780343.git.martin.agren@gmail.com>
        <931ffb00319f40e3c9e099f17eeae6a0c1de41ea.1502780344.git.martin.agren@gmail.com>
Date:   Tue, 15 Aug 2017 11:43:48 -0700
In-Reply-To: <931ffb00319f40e3c9e099f17eeae6a0c1de41ea.1502780344.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Tue, 15 Aug 2017 14:53:04
 +0200")
Message-ID: <xmqqk224r7rv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AD82899C-81E9-11E7-8C58-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> If two threads have one freshly initialized string buffer each and call
> strbuf_reset on them at roughly the same time, both threads will be
> writing a '\0' to strbuf_slopbuf. That is not a problem in practice
> since it doesn't matter in which order the writes happen. But
> ThreadSanitizer will consider this a race.
>
> When compiling with GIT_THREAD_SANITIZER, avoid writing to
> strbuf_slopbuf. Let's instead assert on the first byte of strbuf_slopbu=
f
> being '\0', since it ensures the promised invariant of "buf[len] =3D=3D
> '\0'". (Writing to strbuf_slopbuf is normally bad, but could become eve=
n
> more bad if we stop covering it up in strbuf_reset.)
>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
>  strbuf.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/strbuf.h b/strbuf.h
> index e705b94db..295654d39 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -153,7 +153,19 @@ static inline void strbuf_setlen(struct strbuf *sb=
, size_t len)
>  /**
>   * Empty the buffer by setting the size of it to zero.
>   */
> +#ifdef GIT_THREAD_SANITIZER
> +#define strbuf_reset(sb)						\
> +	do {								\
> +		struct strbuf *_sb =3D sb; 				\
> +		_sb->len =3D 0;						\
> +		if (_sb->buf =3D=3D strbuf_slopbuf)				\
> +			assert(!strbuf_slopbuf[0]);			\
> +		else							\
> +			_sb->buf[0] =3D '\0';				\
> +	} while (0)
> +#else
>  #define strbuf_reset(sb)  strbuf_setlen(sb, 0)
> +#endif
> =20
> =20
>  /**

The strbuf_slopbuf[] is a shared resource that is expected by
everybody to stay a holder of a NUL.  Even though it is defined as
"char [1]", it in spirit ought to be considered const.  And from
that point of view, your new definition that is conditionally used
only when sanitizer is in use _is_ the more correct one than the
current "we do not care if it is slopbuf, we are writing \0 so it
will be no-op anyway" code.

I wonder if we excessively call strbuf_reset() in the real code to
make your version unacceptably expensive?  If not, I somehow feel
that using this version unconditionally may be a better approach.

What happens when a caller calls "strbuf_setlen(&sb, 0)" on a strbuf
that happens to have nothing and whose buffer still points at the
slopbuf (instead of calling _reset())?  Shouldn't your patch fix
that function instead, i.e. something like the following without the
above?  Is that make things noticeably and measurably too expensive?

Thanks.

 strbuf.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/strbuf.h b/strbuf.h
index 2075384e0b..1a77fe146a 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -147,7 +147,10 @@ static inline void strbuf_setlen(struct strbuf *sb, =
size_t len)
 	if (len > (sb->alloc ? sb->alloc - 1 : 0))
 		die("BUG: strbuf_setlen() beyond buffer");
 	sb->len =3D len;
-	sb->buf[len] =3D '\0';
+	if (sb->buf !=3D strbuf_slopbuf)
+		sb->buf[len] =3D '\0';
+	else
+		assert(!strbuf_slopbuf[0]);
 }
=20
 /**
