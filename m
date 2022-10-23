Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE7CC3A59D
	for <git@archiver.kernel.org>; Sun, 23 Oct 2022 18:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbiJWSIg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Oct 2022 14:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiJWSId (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2022 14:08:33 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA395D125
        for <git@vger.kernel.org>; Sun, 23 Oct 2022 11:08:32 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5B0271CD597;
        Sun, 23 Oct 2022 14:08:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6+rdmfyibHPJrJf79UDvgqt/dIX4Xoz20chn38
        q56HM=; b=ehzQqvzYKb1RkW1IoxgAYjJnJLx3h1VnV+k2+9Ej4CYMWu0h4PLVM/
        F5vV8BJJ8uC2IVGUPbdqzFt+VJWgLq9U6PyzMsj4lBJXeMg5kgyeultj3otJvRdz
        3za13ICDQHCoDzsn9j+7yRzPxs9AuFKOIjVWJ4reSJxwQAHiHy+pc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 443FE1CD596;
        Sun, 23 Oct 2022 14:08:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 689381CD595;
        Sun, 23 Oct 2022 14:08:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jan =?utf-8?Q?Pokorn=C3=BD?= <poki@fnusa.cz>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 4/5] repack: use tempfiles for signal cleanup
References: <Y1M3fVnixJHvKiSg@coredump.intra.peff.net>
        <Y1M3oie5dPrRaOni@coredump.intra.peff.net>
        <Y1RUI8ny2mexxwKm@coredump.intra.peff.net>
        <xmqqtu3vflau.fsf@gitster.g>
        <Y1VzPY4zQyZbVAsm@coredump.intra.peff.net>
Date:   Sun, 23 Oct 2022 11:08:26 -0700
In-Reply-To: <Y1VzPY4zQyZbVAsm@coredump.intra.peff.net> (Jeff King's message
        of "Sun, 23 Oct 2022 13:00:45 -0400")
Message-ID: <xmqqlep6fm5h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B160441A-52FD-11ED-8028-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Here's a patch on top of of jk/repack-tempfile-cleanup that adjusts the
> test (and should make the immediate racy CI pain go away). It gives some
> explanation why the third option isn't as interesting as you'd think. If
> somebody later wants to add such a "pack-objects died" error, we can
> adjust sigpipe handling there.

An extremely simplified alternative would be just to say !  instead
of test_must_fail, which essentially is ok=anycrash ;-)

I did try the same exact patch before going to bed last night but
t7700 somehow failed some other steps in my local tests and I gave
up digging further X-<.  One step at a time...

Will queue.  Thanks.

> -- >8 --
> Subject: [PATCH] t7700: annotate cruft-pack failure with ok=sigpipe
>
> One of our tests intentionally causes the cruft-pack generation phase of
> repack to fail, in order to stimulate an exit from repack at the desired
> moment. It does so by feeding a bogus option argument to pack-objects.
> This is a simple and reliable way to get pack-objects to fail, but it
> has one downside: pack-objects will die before reading its stdin, which
> means the caller repack may racily get SIGPIPE writing to it.
>
> For the purposes of this test, that's OK. We are checking whether repack
> cleans up already-created .tmp files, and it will do so whether it exits
> or dies by signal (because the tempfile API hooks both).
>
> But we have to tell test_must_fail that either outcome is OK, or it
> complains about the signal. Arguably this is a workaround (compared to
> fixing repack), as repack dying to SIGPIPE means that it loses the
> opportunity to give a more detailed message. But we don't actually write
> such a message anyway; we rely on pack-objects to have written something
> useful to stderr, and it does. In either case (signal or exit), that is
> the main thing the user will see.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t7700-repack.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
> index edcda849b9..9164acbe02 100755
> --- a/t/t7700-repack.sh
> +++ b/t/t7700-repack.sh
> @@ -433,7 +433,7 @@ test_expect_success TTY '--quiet disables progress' '
>  '
>  
>  test_expect_success 'clean up .tmp-* packs on error' '
> -	test_must_fail git \
> +	test_must_fail ok=sigpipe git \
>  		-c repack.cruftwindow=bogus \
>  		repack -ad --cruft &&
>  	find $objdir/pack -name '.tmp-*' >tmpfiles &&
