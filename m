Return-Path: <SRS0=ybwr=BB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FF9C433E0
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 21:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA02020825
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 21:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Kg1NcoWj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgGVVpu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 17:45:50 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60830 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbgGVVpu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jul 2020 17:45:50 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 92C00D40D0;
        Wed, 22 Jul 2020 17:45:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3IH28G/FE7QbirlE6djtTIR5XlI=; b=Kg1Nco
        WjvORPvvaWCggjkF2I2zpDta0ciwbd/36GHbOV6Hbf/fA8FiED4B4FUZdeULYZOf
        vES0/YrJgRyDa7Go5yDsB12Og1bzEJ2Kdb4FHBDXpMIxJRVFwz9Wtmg82jbTs0jU
        6M+gHZX09snms87OdR6/15RrassM7D44HO9lY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=r+srFKilemIhSYCDko2xnpg7jLhQ3fNN
        oOxiqlpNlJ54CeH+q90iKRB+OBM3sTwdIVQHJxY1u4HlV77wn+mKdxIeTmjoFL1J
        322xcEmGh+VYtmqQGPraRTwIlfk+2zADPbU0yzd8Gy7DpsxVlrNIi6HgxtI/VdZN
        E11ucyz9zUU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8A2B8D40CF;
        Wed, 22 Jul 2020 17:45:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D2499D40CE;
        Wed, 22 Jul 2020 17:45:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sluongng@gmail.com
Subject: Re: [PATCH 2/2] pack-objects: prefetch objects to be packed
References: <xmqqzh7s5sv4.fsf@gitster.c.googlers.com>
        <20200722213048.1581991-1-jonathantanmy@google.com>
Date:   Wed, 22 Jul 2020 14:45:44 -0700
In-Reply-To: <20200722213048.1581991-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Wed, 22 Jul 2020 14:30:48 -0700")
Message-ID: <xmqqo8o7441j.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B2EB1AAC-CC64-11EA-AA2F-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> OK - how about:
>
> [start]
> When an object to be packed is noticed to be missing, prefetch all
> to-be-packed objects in one batch.
>
> Most of the time (typically, when serving a fetch or when pushing),
> packs consist only of objects that the repo has. To maintain the
> performance in this case, the existing object type read is made to also
> serve as the object existence check: if the read fails, then we do the
> prefetch.
>
> An alternative design is to loop over all the entries in to_pack,
> checking the existence of each object, and prefetching if we notice any
> missing. This would result in clearer code, but would incur some
> performance degradation in the aforementioned most common case due to
> the additional object existence checks.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> [end]
>
> The first paragraph is already in the original, and the rest are
> additions.

Sure.  

The first two paragraphs would be sufficient, although the last
paragraph wouldn't hurt.

