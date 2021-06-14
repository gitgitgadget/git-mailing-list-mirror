Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9199C48BE8
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 03:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABEA061042
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 03:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbhFNDwU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 23:52:20 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53441 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbhFNDwT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 23:52:19 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C839C14CA32;
        Sun, 13 Jun 2021 23:50:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jO1RhlCh/MoZF6R6CDuRxLHydi3wsBi15jKVyq
        SomJ0=; b=BORpbFfhcvyvZWBYj4HcTL8hzuLlIEn01hCFr/90m5YXnXQesmi0Vj
        dusq1mYEFynEo1m8w9+qzNCIT5epvvg6KjO51UtBS40EuoFOZYjnmSzv8eW/7Dqj
        OMN6a6R25jtzeDVuFBI/dLIE0mcqwMJje7YN0I+8NoQFN6znwZRnE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C00C514CA31;
        Sun, 13 Jun 2021 23:50:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 19D3C14CA30;
        Sun, 13 Jun 2021 23:50:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/4] sideband: append suffix for message whose CR in
 next pktline
References: <87im2s5jjm.fsf@evledraar.gmail.com>
        <20210612050711.4057-4-worldhello.net@gmail.com>
Date:   Mon, 14 Jun 2021 12:50:10 +0900
In-Reply-To: <20210612050711.4057-4-worldhello.net@gmail.com> (Jiang Xin's
        message of "Sat, 12 Jun 2021 13:07:10 +0800")
Message-ID: <xmqqim2hyuj1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9EE18202-CCC3-11EB-80A8-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> When calling "demultiplex_sideband" on a sideband-2 message, will try to
> split the message by line breaks, and append a suffix to each nonempty
> line to clear the end of the screen line.

Subject of "will try" and "append" is missing.  Do you mean that
the helper function in question does these two things?  I.e.

	demultiplex_sideband() used on a sideband #2 will try
	to... and appends ...

> But in the following example,
> there will be no suffix (8 spaces) for "<message-3>":
>
>     PKT-LINE(\2 <message-1> CR <message-2> CR <message-3>)
>     PKT-LINE(\2 CR <message-4> CR <message-5> CR)

That description may mechanically correct, but

   after <message-3>, we fail to clear to the end of line

may make it easier to understand what the problem we are trying to
solve for those who do not remember what these suffix games are
about.

> This is because the line break of "<message-3>" is placed in the next
> pktline message.
>
> Without this fix, t5411 must remove trailing spaces of the actual output
> of "git-push" command before comparing.
>
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> ---
>  sideband.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/sideband.c b/sideband.c
> index 6f9e026732..abf2be98e1 100644
> --- a/sideband.c
> +++ b/sideband.c
> @@ -185,6 +185,10 @@ int demultiplex_sideband(const char *me, int status,
>  
>  			if (!scratch->len)
>  				strbuf_addstr(scratch, DISPLAY_PREFIX);
> +			else if (!linelen)
> +				/* buf has a leading CR which ends the remaining
> +				 * scratch of last round of "demultiplex_sideband" */
> +				strbuf_addstr(scratch, suffix);

The style of multi-line comment needs fixing, but the contents of
the comment is a bit hard to grok.

>  			if (linelen > 0) {
>  				maybe_colorize_sideband(scratch, b, linelen);
>  				strbuf_addstr(scratch, suffix);

I wonder if the following is simpler to read, though.

-- >8 --
Subject: [PATCH] sideband: don't lose clear-to-eol at packet boundary

When demultiplex_sideband() sees a CR or LF on the sideband #2, it
adds "suffix" string to clear to the end of the current line, which
helps when relaying a progress display whose records are terminated
with CRs.

The code however forgot that depending on the length of the payload
line, such a CR may fall exactly at the packet boundary and the
number of bytes before the CR from the beginning of the packet could
be zero.  In such a case, the message that was terminated by the CR
were leftover in the "scratch" buffer in the previous call to the
function and we still need to clear to the end of the current line.

Just remove the unnecessary check on linelen; maybe_colorize_sideband()
on 0-byte payload turns into a no-op, and we should be adding clear-to-eol
for each and every CR/LF anyway.

 sideband.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git c/sideband.c w/sideband.c
index 6f9e026732..1575bf16dd 100644
--- c/sideband.c
+++ w/sideband.c
@@ -185,10 +185,9 @@ int demultiplex_sideband(const char *me, int status,
 
 			if (!scratch->len)
 				strbuf_addstr(scratch, DISPLAY_PREFIX);
-			if (linelen > 0) {
-				maybe_colorize_sideband(scratch, b, linelen);
-				strbuf_addstr(scratch, suffix);
-			}
+
+			maybe_colorize_sideband(scratch, b, linelen);
+			strbuf_addstr(scratch, suffix);
 
 			strbuf_addch(scratch, *brk);
 			xwrite(2, scratch->buf, scratch->len);
