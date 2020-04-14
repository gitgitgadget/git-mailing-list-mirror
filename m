Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B00C2BA19
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 18:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACAE420575
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 18:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QezIKgTH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729664AbgDNSZq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 14:25:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56193 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbgDNSZp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Apr 2020 14:25:45 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EA20E5A3ED;
        Tue, 14 Apr 2020 14:25:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=PVMvZr6y/rfALxXmvufcg90EKdA=; b=QezIKg
        THIkDeyrq8nBsKsoFELiUWNe6A0aMKJxJLt4iYFJ2xhnpC62oDBPiwIPhEgXyv6v
        HQG2rBi8jQkMY68tHeaw8aEdt3BvTInLvu8EaWaGg/5q11R2FzoWG5vts2VPsMxE
        o1eMRLl/KdREdiaEtlYnQgia+bgC2w2mQOEco=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bPPzbXLzQYOYDdiPmn49DGlgsD8DXm5X
        04C60FfxG9B3iIRCcLK0acMQuhOWEE8Jqh440whyVkOidp2FQf2YEeaIGBQK24qw
        CG20fopM27QnGufnGCI7ERrmL7GaOTAbdEK5lVOEz5R1HCy3SJnJeMVfFf086xDM
        epR8cjNuQF0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E14815A3EC;
        Tue, 14 Apr 2020 14:25:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 639355A3EB;
        Tue, 14 Apr 2020 14:25:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, jnareb@gmail.com,
        garimasigit@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/3] revision: complicated pathspecs disable filters
In-Reply-To: <44ce43e2-6cf0-0e48-18eb-f02543d81bf4@gmail.com> (Derrick
        Stolee's message of "Mon, 13 Apr 2020 07:49:12 -0400")
References: <pull.609.git.1586566981.gitgitgadget@gmail.com>
        <9cc31c289aa785f026eec84452ed68e80505d95e.1586566981.git.gitgitgadget@gmail.com>
        <xmqqeesthfbf.fsf@gitster.c.googlers.com>
        <44ce43e2-6cf0-0e48-18eb-f02543d81bf4@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date:   Tue, 14 Apr 2020 11:25:40 -0700
Message-ID: <xmqqmu7d9b6j.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 58D03802-7E7D-11EA-B8D5-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> But if users may use icase pathspec very often, it may be worth
>> considering to build the bloom filter after downcasing the paths,
>> perhaps?  Given that many projects extract their source code to a
>> case insensitive filesystem, I would imagine that downcasing paths
>> would map two originally different paths into the same thing only
>> rarely, if ever, so there may not be much downside to do so.
>
> This behavior could be extended later, and carefully. My initial
> thought was that the case check would happen on every commit. If
> the :(icase) check only happens at the walk tip(s), then we could
> compute a single Bloom key at the start.

Sorry, I am not sure what you mean.

Do you mean that we notice that the user wants to match 'foo' case
insensitively, and tell the logic that uses changed-path records in
the graph file that commits that cannot possibly have touched any or
the paths 'foo', 'foO', 'fOo', ... (all 8 case permutations) are not
interesting?

I guess that would work, but I was wondering if it is simpler
without much downside if the changed-path records in the graph file
are prepared on paths after they are normalized to a single case.
That would lose information (e.g. you no longer can say "commits
that touch the path 'foo' is interesting, but those that touch the
path 'Foo' are not"), but makes the side that queries much simpler
(i.e. you do not have to prepare all 8 case permutations---you only
ask about 'foo').

And because the Bloom filter is used only for performance to cull
commits that can never possibly match, allowing a false positive
that would be discarded by actually running tree-diff anyway, the
only potential downside happens when the project has too many paths
that are different only in cases by increased collisions and by
reducing our chances to skip running tree-diff (and never affects
correctness).  

But this is not the "could be extended later" kind of behaviour, I
am afraid.  It is baked in the data stored in the graph file.

It all depends on how often people want :(icase) pathspec matches in
the history, I suspect.  My point was that we need to declare that
:(icase) won't matter in real life (hence we won't optimize our data
to support that use case), before the way in which the data stored
in the graph file is computed is cast in stone.

Thanks.
