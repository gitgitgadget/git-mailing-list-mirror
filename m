Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415BFC433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 21:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbiCIVdr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 16:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237633AbiCIVdp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 16:33:45 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720A11EACC
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 13:32:46 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 845E51784CE;
        Wed,  9 Mar 2022 16:32:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hKWuGNJWgboBOKKD5ZHThUM5OLD+RZx5R/K+/d
        aHOQs=; b=jiAoUdQni8k0Paon+3n+gQ8MyVBkRdELPU4LrDIlWfAWCJAPNVJ7TL
        /run6Zbh2KufKu2KqpZn+sR3WhahnpyawF3QDRWsvHK8DZBpHVmcXQwPhAy/SzMF
        O2WCNc5wBclgepLpmOGza7BGSse26dXlcqL1eixkNEn56aRtVHx6g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7D16F1784CD;
        Wed,  9 Mar 2022 16:32:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.14.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 06B191784CC;
        Wed,  9 Mar 2022 16:32:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robert Coup <robert@coup.net.nz>
Cc:     Calvin Wan <calvinwan@google.com>,
        Robert Coup via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 0/7] fetch: add repair: full refetch without negotiation
References: <pull.1138.v3.git.1646406274.gitgitgadget@gmail.com>
        <20220309002729.3581315-1-calvinwan@google.com>
        <CACf-nVeEBDQse0coA7QpQmQ92y9kDwXoTmayD8_NY2OHNZ5v+g@mail.gmail.com>
Date:   Wed, 09 Mar 2022 13:32:42 -0800
In-Reply-To: <CACf-nVeEBDQse0coA7QpQmQ92y9kDwXoTmayD8_NY2OHNZ5v+g@mail.gmail.com>
        (Robert Coup's message of "Wed, 9 Mar 2022 09:57:37 +0000")
Message-ID: <xmqqzglylslh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 74198A32-9FF0-11EC-BD17-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Coup <robert@coup.net.nz> writes:

> So, if you do a partial clone using `git clone --filter=...` then the
> filter is saved into the config at `remote.<name>.partialclonefilter`
> and is re-used by default for subsequent fetches from that remote. But
> there's nothing to stop `git fetch --filter=...` being run multiple
> times with different filters to carefully setup a repository for a
> particular use case, or any notion that there has to be "one" filter
> in place for a remote.

The way I read Calvin's suggestion was that you won't allow such a
random series of "git fetch"es without updating the "this is the
filter that is consistent with the contents of this repository"
record, which will lead to inconsistencies.  I.e.

 - we must maintain the "filter that is consistent with the contents
   of this repository", which this series does not do, but we should.

 - the "--refetch" is unnecessary and redundant, as long as such a
   record is maintained; when a filter settings changes, we should
   do the equivalent of "--refetch" automatically.

IOW, ...

> Running `git fetch --filter=...` doesn't update the remote's partial
> clone filter in the config, and IMO it shouldn't for the above reason.

... isn't "git fetch --fitler" that does not update the configured
filter (and does not do a refetch automatically) a bug that made the
"refetch" necessary in the first place?

Or perhaps I read Calvin incorrectly?
