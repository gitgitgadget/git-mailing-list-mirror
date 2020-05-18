Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0BCC433DF
	for <git@archiver.kernel.org>; Mon, 18 May 2020 19:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2546E2081A
	for <git@archiver.kernel.org>; Mon, 18 May 2020 19:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YTryk7eB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgERTg0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 15:36:26 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55309 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbgERTgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 15:36:25 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B1513BFF2D;
        Mon, 18 May 2020 15:36:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=M1dVq1gv6i9FA7eCMv+SYGnT+hk=; b=YTryk7
        eBAQL2ix+E9U4nKHy3T/wlh83ynHBUHxh5NqrW0G4pbc0+ZT5d0ELhmH3TkU3j7/
        wKXSmJcG4pna8sm+F+fjyDkVtg4IR+7C5n9lP7Hvg5j9z/H8nSq45JHWADL6t7g4
        3lS17rPVk2NKzOANtHnV8B7L46BafeJ2fJfQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=a3KB+94V7BQOmZuAQjChCYexAGpyR7aG
        wvWa5LcuzFcN+HXApHCh4S6q5la19sBloHr8RHqedWHBswp/ceyZ1j2/AyBhMz+p
        6cviiCZnhPYPzxFeTCGFwVKH7SPz+jkUttwnVrDKuQVxUE0bVEmwM0vOBUBIoeMW
        uON+LvoQZ0g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A93E9BFF2C;
        Mon, 18 May 2020 15:36:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EBD45BFF28;
        Mon, 18 May 2020 15:36:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/7] remote-curl: fix deadlocks when remote server disconnects
References: <cover.1589393036.git.liu.denton@gmail.com>
        <cover.1589816718.git.liu.denton@gmail.com>
        <20200518165056.GD42240@coredump.intra.peff.net>
Date:   Mon, 18 May 2020 12:36:19 -0700
In-Reply-To: <20200518165056.GD42240@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 18 May 2020 12:50:56 -0400")
Message-ID: <xmqqh7wd2fyk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D9D47784-993E-11EA-8EF1-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Overall this looks pretty cleanly done. I left a few minor comments
> throughout, but the real question is whether we prefer the "0002" packet
> in the last one, or if we instead insist that the response end in a
> flush.

Thanks for a review.  I was reading the series through and I found
it a reasonably pleasant read.

> So I think either of your solutions (enforcing a final flush, or the
> 0002 packet) is preferable. I'm on the fence between them.

I am undecided, too X-<.
