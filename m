Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 039621F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 03:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbfJ2DSr (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 23:18:47 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63053 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfJ2DSq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 23:18:46 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D0F0C8D2BF;
        Mon, 28 Oct 2019 23:18:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9XptVzZT/w2BD23+ALv8udd1n24=; b=g/QeO6
        eEcQp3ylRL5zRE3+PYF5RtWwPfOUBwctftWNDnRVq5ETDP9x++cPICZ2qOHTsUuv
        /s1lScGmccukzoRKX4YN/m37ECew2EF8i+4VnGvYgEhhvPCWPNN4Pqz6QS+iEeWK
        Yxq7Ww6PrsE+MeLsmP+GaMGpcqOqVv4LUuKh4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YsuhL8EUanuX4znKxi6dgnkynCkK3THi
        e1UBDCWLHyobMiHZpAnLDKTxM3wNWEbKGNdvWEuV9aVVR4/f9iIRyquoq+bc7qWr
        w6go1j6iGnLn6tlOJ1CeLW9wbTLdPMGlkae+Q7LV7dZTbJsb4VPs5o72/6B5VHgr
        RCylyL1hT3E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C90338D2BE;
        Mon, 28 Oct 2019 23:18:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F22368D2BB;
        Mon, 28 Oct 2019 23:18:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] vreportf(): avoid buffered write in favor of unbuffered one
References: <pull.428.git.1572274859.gitgitgadget@gmail.com>
        <455026ce3ef2b2d7cfecfc4b4bf5b588eebddcfe.1572274859.git.gitgitgadget@gmail.com>
Date:   Tue, 29 Oct 2019 12:18:36 +0900
In-Reply-To: <455026ce3ef2b2d7cfecfc4b4bf5b588eebddcfe.1572274859.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 28 Oct 2019
        15:00:59 +0000")
Message-ID: <xmqqeeyw6xyr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CD2017B6-F9FA-11E9-8C7D-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Also please note that we `fflush(stderr)` here to help when running in a
> Git Bash on Windows: in this case, `stderr` is not actually truly
> unbuffered, and needs the extra help.

Yuck.  So on all systems, vreportf() now totally bypasses stdio?

Also, this is only to help output from us that goes via vreportf()
and other codepaths in us that use stdio to write to the standard
error stream can still get mixed on Windows (I think the answer is
yes, because we wouldn't need fflush() in this patch if we are
covering all writes to the standard error stream)?

By the way, I'd retitle the patch to highlight that we are still
doing buffered write, if I were doing this topic.  We are just
avoiding some implementations of stdio that do not give us buffering
and doing the buffering ourselves.

    Subject: vreportf(): don't rely on stdio buffering

or something like that.

> Co-authored-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  usage.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/usage.c b/usage.c
> index 2fdb20086b..4328894dce 100644
> --- a/usage.c
> +++ b/usage.c
> @@ -10,13 +10,19 @@ void vreportf(const char *prefix, const char *err, va_list params)
>  {
>  	char msg[4096];
>  	char *p;
> -
> -	vsnprintf(msg, sizeof(msg), err, params);
> +	size_t off = strlcpy(msg, prefix, sizeof(msg));

Like snprintf(3) the strlcpy() and strlcat() functions return the
total length of the string they tried to create.  For strlcpy() that
means the length of src.

So "off" would be strlen(prefix), which could be longer than
sizeof(msg)?  Then what happens to this vsnprintf() we see below?

> +	int ret = vsnprintf(msg + off, sizeof(msg) - off, err, params);
>  	for (p = msg; *p; p++) {
>  		if (iscntrl(*p) && *p != '\t' && *p != '\n')
>  			*p = '?';
>  	}
> -	fprintf(stderr, "%s%s\n", prefix, msg);

Strictly speaking this is a breaking change in that control
sequences in prefix are now clobbered.  Does any caller call this
function with prefix like "^M\033[K<some string>" to overwrite the
last output line with the new message?  If not, then probably we do
not have to worry about it (and reusing msg[] does feel attractive).

> +	if (ret > 0) {
> +		if (off + ret > sizeof(msg) - 1)
> +			ret = sizeof(msg) - 1 - off;
> +		msg[off + ret] = '\n'; /* we no longer need a NUL */
> +		fflush(stderr);
> +		xwrite(2, msg, off + ret + 1);
> +	}
>  }
>  
>  static NORETURN void usage_builtin(const char *err, va_list params)
