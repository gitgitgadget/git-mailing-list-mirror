Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD02FC433F5
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 00:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbiBBAvX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 19:51:23 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56159 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbiBBAvW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 19:51:22 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 58B0C106B35;
        Tue,  1 Feb 2022 19:51:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MR9/atEyWzo7aJND15NFoLurURbPwcPq+U4b9c
        XhATE=; b=MRl9z1ZZIlWy1PwQ2FSZEefvaeDG8pfPk5u6UPQsOU5K6NZ45r6/2r
        eahEN8wLbMQbe1y+ewnZxAJHt2Y/urguYldDk2SG5hgn9tpbzUwCYHw7h16nXiR/
        4it505EzeKCRIwufL4g60V6VtnzpMVT6Zk4jxaQUzemlmTUs74zsI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4B278106B34;
        Tue,  1 Feb 2022 19:51:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A7A21106B32;
        Tue,  1 Feb 2022 19:51:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, rsbecker@nexbridge.com, bagasdotme@gmail.com,
        newren@gmail.com, avarab@gmail.com, nksingh85@gmail.com, ps@pks.im,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v4 2/4] core.fsync: introduce granular fsync control
References: <pull.1093.v3.git.1639011433.gitgitgadget@gmail.com>
        <pull.1093.v4.git.1643686424.gitgitgadget@gmail.com>
        <7a164ba95710b4231d07982fd27ec51022929b81.1643686425.git.gitgitgadget@gmail.com>
Date:   Tue, 01 Feb 2022 16:51:19 -0800
In-Reply-To: <7a164ba95710b4231d07982fd27ec51022929b81.1643686425.git.gitgitgadget@gmail.com>
        (Neeraj Singh via GitGitGadget's message of "Tue, 01 Feb 2022 03:33:42
        +0000")
Message-ID: <xmqqr18m8514.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3CB61730-83C2-11EC-820C-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +core.fsync::
> +	A comma-separated list of parts of the repository which should be
> +	hardened via the core.fsyncMethod when created or modified. You can
> +	disable hardening of any component by prefixing it with a '-'. Later
> +	items take precedence over earlier ones in the list. For example,
> +	`core.fsync=all,-pack-metadata` means "harden everything except pack
> +	metadata." Items that are not hardened may be lost in the event of an
> +	unclean system shutdown.
> ++
> +* `none` disables fsync completely. This must be specified alone.
> +* `loose-object` hardens objects added to the repo in loose-object form.
> +* `pack` hardens objects added to the repo in packfile form.
> +* `pack-metadata` hardens packfile bitmaps and indexes.
> +* `commit-graph` hardens the commit graph file.
> +* `objects` is an aggregate option that includes `loose-objects`, `pack`,
> +  `pack-metadata`, and `commit-graph`.
> +* `default` is an aggregate option that is equivalent to `objects,-loose-object`
> +* `all` is an aggregate option that syncs all individual components above.

I am not quite sure if this is way too complex (e.g. what does it
mean that we do not care much about loose-object safety while we do
care about commit-graph files?) and at the same time it is too
limited (e.g. if it makes sense to say a class of items deserve more
protection than another class of items, don't we want to be able to
say "class X is ultra-precious so use method A on them, while class
Y is mildly precious and use method B on them, everything else are
not that important and doing the default thing is just fine").

If we wanted to allow the "matrix" kind of flexibility, I think the
way to do so would be

	fsync.<class>.method = <value>

e.g.

	[fsync "default"] method = none
	[fsync "loose-object"] method = fsync
	[fsync "pack-metadata"] method = writeout-only

Where do we expect users to take the core.fsync settings from?  Per
repository?  If it is from per user (i.e. $HOME/.gitconfig), do
people tend to share it across systems (not necessarily over NFS)
with the same contents?  If so, I am not sure if fsync.method that
is way too close to the actual "implementation" is a good idea to
begin with.  From end-user's point of view, it may be easier to
express "class X is ultra-precious, and class Y and Z are mildly
so", with something like fsync.<class>.level = <how-precious> and
let the Git implementation on each platform choose the appropriate
fsync method to protect the stuff at that precious-ness.

Thanks.




	
