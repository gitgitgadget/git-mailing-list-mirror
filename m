Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4B3C433F5
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 18:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235851AbiB1SzL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 13:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbiB1SzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 13:55:09 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091B34BFC4
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 10:54:28 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CBE83193694;
        Mon, 28 Feb 2022 13:54:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KwIgQ0A+nVqET/3gzj7cW0AlgFIQ0VZ8ahPdIK
        W0kRU=; b=a56okIEHrZyM/BE6ebr0LDDd4PRt5RvSCKrDBurCic8v5yjIyc5vBc
        2Va+j2l5urAV7t1AX+HOVprhyfizThG3MsFOGZuNF/8pvwxhRjk0+izFqy4lBIS5
        D3zWrnahJcoFjK2L74M/6KFhliZle5iCD5De0tzL0+FCN+Wo2hYuU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C359E193693;
        Mon, 28 Feb 2022 13:54:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 48656193690;
        Mon, 28 Feb 2022 13:54:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robert Coup <robert@coup.net.nz>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Robert Coup via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 0/8] fetch: add repair: full refetch without negotiation
References: <pull.1138.git.1643730593.gitgitgadget@gmail.com>
        <pull.1138.v2.git.1645719218.gitgitgadget@gmail.com>
        <220228.86r17n2aqd.gmgdl@evledraar.gmail.com>
        <CACf-nVcy8xsf+STJoE5vwcsUauHRcR5wmwmCfnUnSW=4jDcgYQ@mail.gmail.com>
Date:   Mon, 28 Feb 2022 10:54:24 -0800
In-Reply-To: <CACf-nVcy8xsf+STJoE5vwcsUauHRcR5wmwmCfnUnSW=4jDcgYQ@mail.gmail.com>
        (Robert Coup's message of "Mon, 28 Feb 2022 17:27:45 +0000")
Message-ID: <xmqqpmn6255r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D94ADD8C-98C7-11EC-BDA0-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Coup <robert@coup.net.nz> writes:

> fleshen-partial sounds like a horror movie scene to me.
>
> 1. `--refetch`

I do think, as part of a larger "repair" task, fetching objects
again from a known-good remote would be a sensible one step.  So
"re"fetch would be a good way to phrase it.

> 2. `--as-clone`

This I think is in the same vein.

> 3. `--expand-filter` (though TBC you don't necessarily need a filter)
> 4. `--refilter`

These focus on a wrong thing, I would think.  "I suspect my object
store may be missing some objects, and I want to repair it by
getting another copy from a known-good remote" would be the simplest
and easiest-to-explain form of the end-user requirement this feature
helps.  The end-user wish does not require "filter" at all.

But this reminds of me about a few caveats.

The patch does implement a good way to lie about what we have to the
other end, forcing them to send everything that is necessary to
create a new clone.

But that is only a half of what is required to "repair a possibly
broken object store by re-fetching".  It is sufficient for repairing
"missing objects", but not enough for repairing "broken/corrupt"
objects.  The object store has a mechanism to resist collision
attacks by ignoring objects coming over the network that do not
match what we locally already have.

I offhand do not think it is a practical problem that this new
mechanism is incapable of repair a repository with broken/corrupt
objects [*].  But tying the bland and broad word "repair" to the
feature that is meant to only deal with "missing" but not "curropt"
form of object store breakage may lead to confusion.

	Side note: others who spent more time on partial/lazy clone
	might realize that broken/corrupt objects are real problems
	they want to tackle, though.  I dunno, and that is why I am
	raising it as a potential issue.

Thanks.
