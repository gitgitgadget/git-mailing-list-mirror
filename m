Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D98A01FC43
	for <e@80x24.org>; Mon, 13 Mar 2017 17:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753485AbdCMRUO (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 13:20:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57528 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752004AbdCMRUM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 13:20:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C2540800B1;
        Mon, 13 Mar 2017 13:20:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wjIwOhKl26iq2aGOFnvZdv2uvxA=; b=NHZN26
        gx2pHgjoJxCXVXoTRFYfjZjlbvtw7VvCyYwCCf777XzHku3muYg+ef7XQdDwRLfs
        fQb6D5+jFwQUkSsz9vpr+NYEGw5a7IU1Ag+p7YOQHiHrTXgmTL4HcOnAUfusvt9U
        e861L7Fgn86PfspX91nh0mWi3U513CluLPgyY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Rp4GxS5XQCNKuUDFVAxr01Levl19780b
        Mk2JggqEysNG2QsuI0z0pA8c6rcOLIzHnWdxJkFhnTtnL6/qlZs2AnbyTB6RW648
        XZiNzwBy296j8Pld79O19r3DmLYry6ii+ueHmIR9hqyjSp25lKYaPbvvO4bz58o2
        fdVajx1bcQs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BB16B800B0;
        Mon, 13 Mar 2017 13:20:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EEDC1800AD;
        Mon, 13 Mar 2017 13:20:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] http-walker: fix buffer underflow processing remote alternates
References: <20170312123853.55ehe2jurozb6zad@sigill.intra.peff.net>
        <xmqqfuihu382.fsf@gitster.mtv.corp.google.com>
        <20170313135053.3pi56dfdlcva66ml@sigill.intra.peff.net>
        <20170313140445.bjdxnjylirn3e5z3@sigill.intra.peff.net>
Date:   Mon, 13 Mar 2017 10:20:08 -0700
In-Reply-To: <20170313140445.bjdxnjylirn3e5z3@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 13 Mar 2017 10:04:45 -0400")
Message-ID: <xmqq7f3tt7p3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F889432-0811-11E7-8CC3-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> but we do not add back in the "/" when making requests. So technically:
>
>   ../some-path/my-objects
>
> works now, and would not if we were more picky. I doubt anybody cares,
> but I went for the minimal behavior change here. If anybody wants to get
> more fancy, the correct path is to leave the path intact here and teach
> the appending side to stop re-adding "objects".

Yeah.  I admit that I didn't spend too much time last night auditing
the code but I didn't find anything that adds things like "info/refs"
that results in a URL outside the original "/objects", so I agree
that "don't strip and don't re-add 'objects'" would be the right way
to go if anybody cares deeply enough.  Let's leave that for others
and take this one.

Thanks.

> -- >8 --
> Subject: http-walker: fix buffer underflow processing remote alternates
>
> If we parse a remote alternates (or http-alternates), we
> expect relative lines like:
>
>   ../../foo.git/objects
>
> which we convert into "$URL/../foo.git/" (and then use that
> as a base for fetching more objects).
>
> But if the remote feeds us nonsense like just:
>
>   ../
>
> we will try to blindly strip the last 7 characters, assuming
> they contain the string "objects". Since we don't _have_ 7
> characters at all, this results in feeding a small negative
> value to strbuf_add(), which converts it to a size_t,
> resulting in a big positive value. This should consistently
> fail (since we can't generall allocate the max size_t minus
> 7 bytes), so there shouldn't be any security implications.
>
> Let's fix this by using strbuf_strip_suffix() to drop the
> characters we want. If they're not present, we'll ignore the
> alternate (in theory we could use it as-is, but the rest of
> the http-walker code unconditionally tacks "objects/" back
> on, so it is it not prepared to handle such a case).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  http-walker.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/http-walker.c b/http-walker.c
> index b34b6ace7..507c200f0 100644
> --- a/http-walker.c
> +++ b/http-walker.c
> @@ -296,13 +296,16 @@ static void process_alternates_response(void *callback_data)
>  					okay = 1;
>  				}
>  			}
> -			/* skip "objects\n" at end */
>  			if (okay) {
>  				struct strbuf target = STRBUF_INIT;
>  				strbuf_add(&target, base, serverlen);
> -				strbuf_add(&target, data + i, posn - i - 7);
> -
> -				if (is_alternate_allowed(target.buf)) {
> +				strbuf_add(&target, data + i, posn - i);
> +				if (!strbuf_strip_suffix(&target, "objects")) {
> +					warning("ignoring alternate that does"
> +						" not end in 'objects': %s",
> +						target.buf);
> +					strbuf_release(&target);
> +				} else if (is_alternate_allowed(target.buf)) {
>  					warning("adding alternate object store: %s",
>  						target.buf);
>  					newalt = xmalloc(sizeof(*newalt));
