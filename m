Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9554EC43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 21:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 649432073C
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 21:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dVZ/4Mvw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbfLDVhr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 16:37:47 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51940 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbfLDVhr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 16:37:47 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AA5AF8FA67;
        Wed,  4 Dec 2019 16:37:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wViAIPxg/dj5+7wpo9TaA+jRKTE=; b=dVZ/4M
        vwwLgOumOQ57e3XzcHMmtJsyebo9J7LLrWNy1NO/tPESDIBroAfYxQ6fUaHpCPiL
        V2FAzfqdNXhtyvw5OLwT0EoKMu6Dii3dCO4UnS8KM+QgJpz5bSu+ktDDfe1BLhzr
        J8rYuFVL5v0cI8CmciW8XG4TF/vBCCziZhDCs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SIT+yRFIYGVnHmYZAKO1Y2rmmQtFUDFO
        1XbZJ0jxBkiy6Vd9GCfa2oghXrHmXckOCbAz+nBnG4mVjC5qv32ENkx1nm20exBo
        xGoU5zMKTbOo8NuWadJfOYhfw8IQmNCn95lgYMZJZN9488/1Lh/3YZ6WP5MbmOLg
        B4TaMfZMWNs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A26A08FA66;
        Wed,  4 Dec 2019 16:37:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C54DF8FA65;
        Wed,  4 Dec 2019 16:37:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     peff@peff.net, pamarlie@cisco.com, git@vger.kernel.org
Subject: Re: [PATCH] send-pack: use OBJECT_INFO_QUICK to check negative objects
References: <20191203232007.GA30535@sigill.intra.peff.net>
        <20191204205353.118168-1-jonathantanmy@google.com>
Date:   Wed, 04 Dec 2019 13:37:41 -0800
In-Reply-To: <20191204205353.118168-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Wed, 4 Dec 2019 12:53:53 -0800")
Message-ID: <xmqqr21j3h7e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4E2B66C6-16DE-11EA-8061-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> As for whether we should do it in the first place, I think that having 2
> orthogonal flags is clearer than having 1 that controls fetch
> (SKIP_FETCH) and 1 that does both (QUICK) without any that recheck
> packed, but I'm quite familiar with this part of the code, so perhaps
> I'm the wrong person to ask - we should optimize for the typical Git
> developer who just wants to access the object store. Judging from the
> frequency in which we encounter this issue (as Peff says), maybe we
> should go ahead and make QUICK imply SKIP_FETCH but not the other way
> around.

Thanks for thinking this through.  I am OK with that direction.

> (It is also possible just to make both imply the other and unify
> QUICK and SKIP_FETCH into one flag - I am not opposed to that -
> although read my email that Peff linked to see why bidirectional
> implication is correct in one sense but incorrect in another.)

Yup, also from the old message:

> Having said that, perhaps we should consider promisor-remote.c as
> low-level code and expect it to know that objects are fetched into a
> packfile (as opposed to loose objects), so it can safely use QUICK
> (which is documented as checking packed after packed and loose). If no
> one disagrees, I can make such a patch after jt/push-avoid-lazy-fetch is
> merged to master (as is the plan, according to What's Cooking [1]).

I agree that it makes sense to treat promisor-remote.c as the
low-level implementation detail that is allowed to be intimately
familiar with how its behaviour would interact with QUICK and
SKIP_FETCH options.

Thanks.
