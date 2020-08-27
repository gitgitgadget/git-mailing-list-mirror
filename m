Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F016DC433DF
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 02:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 918742075B
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 02:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VKbFqdtL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgH0CKr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 22:10:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64913 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbgH0CKq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 22:10:46 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B70FB8168A;
        Wed, 26 Aug 2020 22:10:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+SkkGaWraD+850YDAsys823vKNM=; b=VKbFqd
        tLziPzHeM+445FNWn8uIAl6nIVt74qY/tPpUQoupt9jsymi4Sww2f+tvBqmmX8QV
        K2SQQ9M75mdbpEDy/4wYRvog6HobvOqIrfkPB7W8bJnXJmkm1etMZkg52+KvrjOZ
        /5rwJYn3+mCbu62bslUWB9fMC3U7uIhnEsil4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TEqPNDTE4lxtd2Or+0yaCiEnEyk0S8SW
        AyMpjQuBLk2UNtbIHzqzrwAvINEyAL1MqRxu4cKd2wW65iYxke4Qews62I3BSL8V
        3ejgZl8yNc42/EW5VRw26pBfzEJ+pUJupfVyuyKT+fjtmyUu3i4OAkSjEkKlJr/s
        oNK3td+19Xo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AEC3B81689;
        Wed, 26 Aug 2020 22:10:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3F7D181688;
        Wed, 26 Aug 2020 22:10:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH] wt-status: expand, not dwim, a "detached from" ref
References: <20200513004058.34456-1-jonathantanmy@google.com>
        <20200827014723.GA750502@google.com>
Date:   Wed, 26 Aug 2020 19:10:43 -0700
In-Reply-To: <20200827014723.GA750502@google.com> (Jonathan Nieder's message
        of "Wed, 26 Aug 2020 18:47:23 -0700")
Message-ID: <xmqqtuwosusc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 838FB3DC-E80A-11EA-BD63-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Given the context above, two possibilities seem appealing:
>
>  A. Like you're hinting, could dwim_ref get a variant that returns -1
>     instead of die()ing on failure?  That way, we could fulfill the
>     intent described in b397ea48:
>
> 	When it cannot figure out the original ref, it shows an abbreviated
> 	SHA-1.
>
>  B. Alternatively, in the @{u} case could we switch together the <old>
>     and <new> pieces of the context from the
>
> 	checkout: moving from master to @{upstream}
>
>     reflog line to make "master@{upstream}"?  It's still possible for
>     the upstream to have changed since then, but at least in the
>     common case this would match the lookup that happened at checkout
>     time.

Ah, blast from the past.  Thanks for resurrecting.

If we are allowed to change what goes to reflog, can we do even
better than recording master@{upstream} at the time "checkout"
records the HEAD movement?  "checkout: moving from next to master"
would be far better than "moving from next to next@{upstream}" or
"moving from next to @{upstream}".  

Can we even change the phrasing altogether, like "checkout: moving
from next to detached e9b77c..."?  That would produce even more
precise report.

