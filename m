Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE1391F454
	for <e@80x24.org>; Sat,  2 Nov 2019 04:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbfKBEGA (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Nov 2019 00:06:00 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54031 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfKBEGA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Nov 2019 00:06:00 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 81B419B9E2;
        Sat,  2 Nov 2019 00:05:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dTDqUi+64xu0
        mtKGg+Gix+AFho0=; b=Fm0ju3wMgoCcTQgF/mMUdpUYnAGKu2crS1TXscTf+1bB
        vxPC4qNNANwrEXwMgMtygynp436fbwgK6RSUfWeMQ6IGg1yR6nOpVsW+jjEgOYrZ
        R9fTbr6kRDDdtHPEeRwb/6iK4wO3HZ99NVUW78wsqkQ3ADnwfbr9MufhcJHRZrU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=EeIoVI
        jBjBzjvhNHjEG/tI828BPEdpLC7gKbEPC/07NOBbmngXf+Sub1Z7GVCJixKbUeIX
        in+Hdzy8SbHC2iCTdpG0RrN4IXy3s9wWF/TEPV0Yfl/FhZbyGqz3S7d1KEZH1l/s
        OevHrm/CqfQiRWGjtf9TI2LA1Zmvg7jRMAzWc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7ACE59B9E1;
        Sat,  2 Nov 2019 00:05:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AB86C9B9E0;
        Sat,  2 Nov 2019 00:05:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 1/1] vreportf(): avoid relying on stdio buffering
References: <pull.428.v3.git.1572379280.gitgitgadget@gmail.com>
        <pull.428.v4.git.1572432276.gitgitgadget@gmail.com>
        <f6d6c8122abbd6339cf83309ac3761bbdac44023.1572432276.git.gitgitgadget@gmail.com>
Date:   Sat, 02 Nov 2019 13:05:51 +0900
In-Reply-To: <f6d6c8122abbd6339cf83309ac3761bbdac44023.1572432276.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 30 Oct 2019
        10:44:36 +0000")
Message-ID: <xmqqd0ea6hy8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 10FDAA60-FD26-11E9-9D9C-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The MSVC runtime behavior differs from glibc's with respect to
> `fprintf(stderr, ...)` in that the former writes out the message
> character by character.
> ...
> Let's avoid this predicament altogether by rendering the entire message=
,
> including the prefix and the trailing newline, into the buffer we
> already have (and which is still fixed size) and then write it out via
> `write_in_full()`.
> ...
> The process may have written to `stderr` and there may be something lef=
t
> in the buffer kept in the stdio layer. Call `fflush(stderr)` before
> writing the message we prepare in this function.

Thanks.

This is for future reference and not a comment for you alone, but we
probably do not want to single out glibc like this proposed log
message does in its first paragraph, as if in the author's mind, the
world has only two systems.  It invites questions like "what about
various BSD variants?  how does musl behave?" that may lead to a
suggestion to further update it to "differs from most everybody
else", or we may end up saying "MSVC, X and Y share this problem
unlike all others".  Either way, at that point, the original
singling out of glibc becomes meaningless.

"Platform X has this issue and here is a way to avoid that on
everybody" is a good description of the motivation, and the mention
of the behaviour of MSVC runtime is what we want to see there.

        The MSVC runtime writes out the message character by
        character given `fprintf(stderr, ...)`.

It is not necessary to add "There may be other platforms that share
the same issue, but MSVC alone is already important enough so we do
not list them here".  It is trivially true and obvious ;-)

As I said, the above is for future reference for everybody; it's
cutting close to the final, so let's queue this (and the other one)
as-is.

Thanks for working on this fix.

> Helped-by: Jeff King <peff@peff.net>
> Helped-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
> Helped-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  usage.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/usage.c b/usage.c
> index 2fdb20086b..58fb5fff5f 100644
> --- a/usage.c
> +++ b/usage.c
> @@ -9,14 +9,26 @@
>  void vreportf(const char *prefix, const char *err, va_list params)
>  {
>  	char msg[4096];
> -	char *p;
> +	char *p, *pend =3D msg + sizeof(msg);
> +	size_t prefix_len =3D strlen(prefix);
> =20
> -	vsnprintf(msg, sizeof(msg), err, params);
> -	for (p =3D msg; *p; p++) {
> +	if (sizeof(msg) <=3D prefix_len) {
> +		fprintf(stderr, "BUG!!! too long a prefix '%s'\n", prefix);
> +		abort();
> +	}
> +	memcpy(msg, prefix, prefix_len);
> +	p =3D msg + prefix_len;
> +	if (vsnprintf(p, pend - p, err, params) < 0)
> +		*p =3D '\0'; /* vsnprintf() failed, clip at prefix */
> +
> +	for (; p !=3D pend - 1 && *p; p++) {
>  		if (iscntrl(*p) && *p !=3D '\t' && *p !=3D '\n')
>  			*p =3D '?';
>  	}
> -	fprintf(stderr, "%s%s\n", prefix, msg);
> +
> +	*(p++) =3D '\n'; /* we no longer need a NUL */
> +	fflush(stderr);
> +	write_in_full(2, msg, p - msg);
>  }
> =20
>  static NORETURN void usage_builtin(const char *err, va_list params)
