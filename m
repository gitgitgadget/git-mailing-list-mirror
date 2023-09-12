Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07937CA0EF7
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 17:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236944AbjILRHc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 13:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236940AbjILRHb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 13:07:31 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA7C10D9
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 10:07:28 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B1E51B3E2F;
        Tue, 12 Sep 2023 13:07:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=TAFZNFcizD84MArRe4dZ+/D2WUUKELmch9VjDg
        Tgi+8=; b=ea1d+dD49IuRgkIX/BINTgAV754JO2zrvyio8aL2VtxuQlbJWXD8fX
        pcQ8Gjyw/3p34EIPeuDUBNB2HFqJE3vXlwG9ivrkglcxBjJ5R2ZX3mb2sDSW0CNK
        BoSxpbf+1YTlvg53Nwq5G4oWYC0lB1nLDvqOuUcp8ITYobLTTLmms=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 62BBA1B3E2E;
        Tue, 12 Sep 2023 13:07:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C1FBB1B3E2D;
        Tue, 12 Sep 2023 13:07:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josip Sokcevic <sokcevic@google.com>
Cc:     jonathantanmy@google.com, git@vger.kernel.org,
        git@jeffhostetler.com
Subject: Re: [PATCH v3] diff-lib: Fix check_removed when fsmonitor is on
In-Reply-To: <CAJiyOijMvqK184wFgoXFyX5kmURkX3k2OmuiBpArikj26iHpMA@mail.gmail.com>
        (Josip Sokcevic's message of "Mon, 11 Sep 2023 20:03:47 -0700")
References: <20230906060241.944886-2-sokcevic@google.com>
        <20230911170901.49050-2-sokcevic@google.com>
        <xmqqsf7ks4nn.fsf@gitster.g>
        <CAJiyOijMvqK184wFgoXFyX5kmURkX3k2OmuiBpArikj26iHpMA@mail.gmail.com>
Date:   Tue, 12 Sep 2023 10:07:25 -0700
Message-ID: <xmqqfs3jpbg2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D94F11FA-518E-11EE-B2B7-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josip Sokcevic <sokcevic@google.com> writes:

> Yes, I agree we should optimize this in a follow up. One thing I'm not
> sure about is if we should try to construct `struct stat` using
> `cache_index`, or we should check for `CE_FSMONITOR_VALID` in a way
> that `stat` would no longer be needed for those code paths.

Good point.  

It seems to be entirely doable, even though the stench from the
abstraction layer violation may be horrible.

ie_match_stat(), which is called by match_stat_with_submodule(),
does pay attention to CE_FSMONITOR_VALID bit, so none of the members
of struct stat matters when the bit is set.  But the bit is not set,
all members that fill_stat_data() and ce_match_stat_basic() care
about do matter.  Other code that follows callers of check_removed()
do care about at least .st_mode member, and I suspect that in the
current code .st_mode is the only member that gets looked at.

So after all, I think your original "fix" was correct, but it took
us some time to figure out why it was, which means we would want to
explain it in the log message for developers who would want to touch
the same area in the future.

Thanks.
