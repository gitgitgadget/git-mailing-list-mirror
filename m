Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3184AC6FA8F
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 17:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237999AbjH2RfU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 13:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237998AbjH2Rey (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 13:34:54 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE098C9
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 10:34:49 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 737D535FDA;
        Tue, 29 Aug 2023 13:34:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nGRkRjzfcCCBU0y4ggcVcRHS00psTTExN3uYky
        wg6bA=; b=Ww9RB4LPlcll15e9kpihmvawZfkTTXqCRxP8ywcpkyjpSnC/Az+kc3
        ZjTcqoz6nw+2NxTXr/X4cA8yb/ilZ0jLlXCr3n5i2tBWADY/ZtaTgAdW/pL61PyE
        dIKxtcC3RO8tWAsZl9pSt6XZ+6ZLh2mm/xOzdF+uVDqmZz6zLZBdY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6AE6F35FD9;
        Tue, 29 Aug 2023 13:34:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D135735FD8;
        Tue, 29 Aug 2023 13:34:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] builtin/pack-objects.c: remove unnecessary
 strbuf_reset()
References: <cover.1693262936.git.me@ttaylorr.com>
        <921a79c8bd6ab688fb9f403a59eeaed3176b630e.1693262936.git.me@ttaylorr.com>
Date:   Tue, 29 Aug 2023 10:34:43 -0700
In-Reply-To: <921a79c8bd6ab688fb9f403a59eeaed3176b630e.1693262936.git.me@ttaylorr.com>
        (Taylor Blau's message of "Mon, 28 Aug 2023 18:49:04 -0400")
Message-ID: <xmqq4jkheor0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 57E31FD2-4692-11EE-9184-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> When reading input with the `--cruft` option, `git pack-objects` reads
> each line into a strbuf, and then moves it to either the list of
> discarded or fresh packs, depending on whether or not the input line
> starts with a '-' character.
>
> At the beginning of each loop iteration, the next line of input is read
> with `strbuf_getline()`, which calls `strbuf_reset()` (as a part of
> `strbuf_getwholeline()`) before reading the next line of input.

Yup, the reset() at the end of each iteration is not needed to
prepare for the next interation (which getline() is perfectly
capable of doing it itself) but helps to release the resource
that is no longer used after the loop finishes iterating.  If I were
cleaning up this code, I would probably move the _reset() after the
loop instead *and* keep the _release() at the end, so that future
changes can add new (re)uses of buf in between.

But it is probalby not worth worrying about keeping a single line
from the cruft object list a little longer than absolutely needed.

Will queue.  Thanks.

>
> Thus, the call to `strbuf_reset()` (added back in b757353676
> (builtin/pack-objects.c: --cruft without expiration, 2022-05-20)) at the
> end of the loop is unnecessary, so let's remove it accordingly.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  builtin/pack-objects.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index d2a162d528..868efe7e0f 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -3603,7 +3603,6 @@ static void read_cruft_objects(void)
>  			string_list_append(&discard_packs, buf.buf + 1);
>  		else
>  			string_list_append(&fresh_packs, buf.buf);
> -		strbuf_reset(&buf);
>  	}
>  
>  	string_list_sort(&discard_packs);
