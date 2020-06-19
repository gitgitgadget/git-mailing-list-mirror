Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F85C433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 20:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B55E82100A
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 20:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nXQX4wXU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390247AbgFSUon (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 16:44:43 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58635 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389705AbgFSUon (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 16:44:43 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 88BC8CC05E;
        Fri, 19 Jun 2020 16:44:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pVBz/6eaT6yKz9JNVFwbtt2lDj8=; b=nXQX4w
        XUuYg4XOWlduNuWu+TwGSY7vcP5m5F6aPcNfJrfpxB6tAUvjJlvuDigLuu6/UtiQ
        scuIg7WT6LK7Kabs9CWY3RKSahiqdj0rQYrUGLLmpihTgE48vpJZrYimHbblsALW
        Zp9GLn5FyuVXgpOnFDu7k/0LhFO9H25BEM9Tw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NRDZCrhyCovuB9ySCVVz6WmamvFc5jSq
        CfQBR32t3j00p4+c9fYkCE9HdcEYJTxicG1EUgHO/n1Z9Fg71kSRrnT0RCy/q48k
        ElnO4oepKO8BD936Pn7PccQeeP4FE/ndqBu2b2zBhamP7QcTIsw2JnbO2sl1d+1o
        C6x5Qr614hM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 81DF6CC05C;
        Fri, 19 Jun 2020 16:44:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C4885CC05A;
        Fri, 19 Jun 2020 16:44:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Annoyance wrt ref@{1} and reflog expiry
References: <xmqqzh8zgcfp.fsf@gitster.c.googlers.com>
        <87o8pe3ou6.fsf@osv.gnss.ru> <xmqqwo42g5ld.fsf@gitster.c.googlers.com>
Date:   Fri, 19 Jun 2020 13:44:37 -0700
In-Reply-To: <xmqqwo42g5ld.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 19 Jun 2020 13:31:42 -0700")
Message-ID: <xmqqsgeqg4zu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B18CE552-B26D-11EA-BB10-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Or we could change the lookup side to use the value of the ref
> itself when asked for @{0}, and use the "old" side of the only entry
> when asked for @{1}.  That way, we do not need to play games with an
> artificial entry at all, which may be a better solution.

In other words, looking up @{0} will be the only special case.  A
natural consequence of the above way to look up @{1} is to look at
the old side of (N-1)th entry in the reflog for @{N}.

I am starting to like this idea, but I am not sure how tricky the
actual implementation would be.
