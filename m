Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1EDC43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 23:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1135E2073B
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 23:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JSuOkwwu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390285AbgDBXyv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 19:54:51 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57105 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390267AbgDBXyu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 19:54:50 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6774ECB6FB;
        Thu,  2 Apr 2020 19:54:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IwyRnaZpvxfJsodsYo8pJmmpUPs=; b=JSuOkw
        wuBCyVEI+RcdD/xjvF5xXLd7xBFrU1hWZC59V8Ej5InONJ3rQvvfDY/azoiOUH7e
        hYtXpabSpuiggaoOgwT2G94Ko49qZaTCW2LgrgdGEQPAIroAfpDcilGgBFz8Pfc9
        2T4T32RdW1uM37ltIYLAz+pIxNF7tCu1Yif6I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SRMpC/cIZVGDpqB/k3wptg4Bt99hUaFE
        o5lGcLIaoQVN26heRGUVjZFwxCpEn9gUYfTi+xsTgvSa9CsjDtPcnIu0lBB3oDqQ
        Q6Ef02UpFU2YG+crioUTYZYIVSZ9CFNk4zDscvAMKw2Ig7tnz5OQ7s0aSmitjfO1
        4DSU4yOBdZU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5F9C0CB6FA;
        Thu,  2 Apr 2020 19:54:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AC3FDCB6F9;
        Thu,  2 Apr 2020 19:54:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, peff@peff.net
Subject: Re: [PATCH v2 2/2] diff: restrict when prefetching occurs
References: <xmqq7dyx3b1o.fsf@gitster.c.googlers.com>
        <20200402230937.47323-1-jonathantanmy@google.com>
Date:   Thu, 02 Apr 2020 16:54:46 -0700
In-Reply-To: <20200402230937.47323-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Thu, 2 Apr 2020 16:09:37 -0700")
Message-ID: <xmqqsghl1m0p.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 55909180-753D-11EA-B2B0-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> My idea is that this prefetch is a superset of what diffcore_rebase()
> wants to prefetch, so if we have already done the necessary logic here
> (even if nothing gets prefetched - which might be the case if we have
> all objects), we do not need to do it in diffcore_rebase().

s/rebase/rename/ I presume, but the above reasoning, while it may
happen to hold true right now, feels brittle.  In other words

 - how do we know it would stay to be "a superset"?

 - would it change the picture if we later added a prefetch in
   diffcore_break(), just like you are doing so to diffcore_rename()
   in this patch?

So the revised version of my earlier "wondering" is if it would be
more future-proof (easier to teach different steps to prefetch for
their own needs, without having to make an assumption like "what
this step needs is sufficient for the other step") to arrange the
codepath from diffcore_std() to its helpers like so:

    - prepare an empty to_fetch OID array in the caller,

    - if the output format is one of the ones that wants prefetch,
      add object names to to_fetch in the caller, but not fetch as
      long as the caller does not yet need the contents of the
      blobs.

    - pass &to_fetch from diffcore_std() to the helper functions in
      the diffcore family like diffcore_{break,rename}() have them
      also batch what they (may) want to prefetch in there.  Delay
      fetching until they actually need to look at the blobs, and
      when they fetch, clear &to_fetch for the next helper.

    - diffcore_std() also would need to look at the blob eventually,
      perhaps after all the helpers it may call returns.  Do the
      final prefetch if to_fetch is still not empty before it has to
      look at the blobs.

Thanks.
