Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD99C433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 00:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiEXACf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 20:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbiEXAC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 20:02:29 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF076D396
        for <git@vger.kernel.org>; Mon, 23 May 2022 17:02:23 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 759F0178F77;
        Mon, 23 May 2022 20:02:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LGHGCBRW/d6tl50QZV5hqL+WDEAl1R0k2NsvmL
        8qBpY=; b=OX3reSBLy6mVyYwr0xsJdiOhR+6sgKIiOzdxWfrd5VJjzgRD8Fdv/6
        Uq3U0yWZ/+p61lASSD5r0s3+z4mbtKfKxk6UcNE1d1wnWGGzNmIr+e5rel26jZjD
        ztMA2KDfhIkHKrSn89pzOw/zeW8yp6+4HxLpBsdm1Q0Z7n0Yjq/qE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6D558178F76;
        Mon, 23 May 2022 20:02:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1AD81178F75;
        Mon, 23 May 2022 20:02:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH] http.c: clear the 'finished' member once we are done
 with it
References: <cover.1651859773.git.git@grubix.eu>
        <3f0e462e86625a3c253653e4a4eefabcd8590bf9.1651859773.git.git@grubix.eu>
        <xmqqtua2jtr0.fsf@gitster.g> <xmqqczgqjr8y.fsf_-_@gitster.g>
        <nycvar.QRO.7.76.6.2205232248360.352@tvgsbejvaqbjf.bet>
        <xmqqr14jluu4.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2205240124280.352@tvgsbejvaqbjf.bet>
Date:   Mon, 23 May 2022 17:02:17 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2205240124280.352@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 24 May 2022 01:41:02 +0200 (CEST)")
Message-ID: <xmqqa6b7lrw6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C73DCE64-DAF4-11EC-A574-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> It calls into cURL, which I suspect has a multi-threaded mode of
> operation,

https://curl.se/libcurl/c/threadsafe.html ;-)

My understanding is that what we have is pretty much select() driven
single-threaded multi-fd transfer.

> No, I suggested to replace the `finished` variable with an attribute (or
> "field" or "member variable") of the slot, and to respect it when looking
> for an unused slot, i.e. not only look for a slot whose `in_use` is 0 but
> also require `reserved_for_use` to be 0. In essence, the
> `run_active_slot()` function owns the slot, even if it is not marked as
> `in_use`. That should address the same concern as baa7b67d but without
> using a pointer to a local variable.

Not really.  An outer run_active_slot() and an inner
run_active_slot() have a pointer to the same slot object.

The inner one got hold of that object because the request the slot
used to represent for the outer run_active_slot() has finished, so
we would toggle either *(slot->finished) or the new slot->done in an
attempt to signal the completion to the outer run_active_slot() and
then make the slot not-in-use.  The slot becomes in-use again with a
different request and the inner run_active_slot() is run.  It first
says "this slot is not done yet---we are making a request using
it".  How would the inner one say that, exactly?

In baa7b67d's fix, it is done by setting slot->finished = &finished
to its own stackframe.  Because the outer run_active_slot() does not
look at slot->finished, but it looks at the finished on its
stackframe, what the inner run_active_slot() does here would not
break the outer one.

If we replace the mechanism with a separate member in the slot
structure, so that the outer run_active_slot() looks at slot->done
and the inner run_active_slot() also clears slot->done before
proceeding, then the inner one clobbers what the outer one will look
at when the recursive call that led to the inner one returns.
