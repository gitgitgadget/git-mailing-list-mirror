Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E52FC00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 21:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239009AbiG2VMQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 17:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiG2VMO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 17:12:14 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018F932DA0
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 14:12:12 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 620591A4051;
        Fri, 29 Jul 2022 17:12:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qzxAkx8WR6vUR/+sTdcCbFMeRs7dyi19/8F4fl
        /AUZw=; b=ANptxPGLJM4kg5t9r1rZQppufQ0xridzhiFPzJyU9aGbQyxHz5i4Iq
        wHSZKGKQpc9ik2DQi7fYbCy4CuhmydE9KU63kntUXVcWYa69gvuHd6bA5mT2j7kt
        mqmjNtvB0DVfKqw73cXKv4JcOclLU6ezmo/ikTY4b6jcozhbdPQT4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5B4371A4050;
        Fri, 29 Jul 2022 17:12:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 074291A404F;
        Fri, 29 Jul 2022 17:12:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Sergey Grunenko <grunenko.serg@gmail.com>, git@vger.kernel.org
Subject: Re: [BUG] "git log" command wraps lines not correctly while
 terminal width changed
References: <CAFRNrRYs5tkTq_Dz3qX+jZ_PJLdUwT4NgabavYeHsGOEtMTq5w@mail.gmail.com>
        <YuRF7rSskqT2YkMs@coredump.intra.peff.net>
Date:   Fri, 29 Jul 2022 14:12:07 -0700
In-Reply-To: <YuRF7rSskqT2YkMs@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 29 Jul 2022 16:41:18 -0400")
Message-ID: <xmqq4jyz62u0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1B3D0210-0F83-11ED-BCC5-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Jul 29, 2022 at 06:35:20PM +0400, Sergey Grunenko wrote:
>
>> Hi, developers. I met some small bug in console report of "git log" command
>
> I don't think this is a bug in git, because git isn't actually doing any
> wrapping.

We do measure the terminal width when we start and adjust the length
of --stat and other things, but it does not affect the overall
correctness of what you said.  We just draw once, and never go back
to redraw with updated width in response to SIGWINCH.  After we emit
our output, it is up to the pager and the terminal.

> OK, so it sounds like you're probably seeing "less" get told by the
> terminal that the window size has changed, and it adapts.
> ...
> The mouse scroll wheel is presumably telling the terminal to move
> through its back-scroll. How it handles re-rendering of content that's
> only in the back-scroll is up to it, and totally outside the control of
> either git or the pager. It behaves as your 8a for me, using urxvt on
> Linux. You probably need to file a report with the provider of your
> terminal emulator.

