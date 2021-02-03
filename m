Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5491DC433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 02:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1581C64E36
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 02:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhBCCHj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 21:07:39 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53003 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbhBCCHi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 21:07:38 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 628D8104939;
        Tue,  2 Feb 2021 21:06:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=L7BktN82zNIs8kLm7o10BB35Dns=; b=QE4g7D
        QF8EHVxHo+FX+VoxaT8tVshKUCenhyI74X5W4/+z6Ix9VglUX+jof0VY6X5y/tVS
        YO343K44OcmUhDg3iIFW2X78pWqm1gGxP7tyZUANLTWpqoEegs0idN7OOWu1C5Ep
        vIOXPgdXqY+cWuRGKdlxKyWbYyNMFqTzR4Jpo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=e0NnClz/bh61ZGpWduyRREdnJ6ul92a1
        0+29t6O7uPXatcjAZwuqxP5u5Ze8prtc6nfFHtRzabqT3l9Bnwe+MZwbRoP1uPt9
        4t18upJkBsDRIumYxzXU5gGFyx3tj3MVRlt5QPRQ+NXoPxA+Lo4pV50pTEKqIBf5
        NYQrt63LQzY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5BBA3104938;
        Tue,  2 Feb 2021 21:06:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A144B104937;
        Tue,  2 Feb 2021 21:06:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, peff@peff.net,
        abhishekkumar8222@gmail.com, Taylor Blau <ttaylorr@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 2/6] commit-graph: always parse before
 commit_graph_data_at()
References: <pull.850.git.1612199707.gitgitgadget@gmail.com>
        <pull.850.v2.git.1612234883.gitgitgadget@gmail.com>
        <454b183b9ba502da7f40dc36aaa95cc3d12b5c2f.1612234883.git.gitgitgadget@gmail.com>
        <YBn3fxFe978Up5Ly@google.com>
        <1dab0bf0-9a7f-370a-c807-25d67ac7a0a0@gmail.com>
Date:   Tue, 02 Feb 2021 18:06:51 -0800
In-Reply-To: <1dab0bf0-9a7f-370a-c807-25d67ac7a0a0@gmail.com> (Derrick
        Stolee's message of "Tue, 2 Feb 2021 20:35:00 -0500")
Message-ID: <xmqq7dnpewg4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7C349FFC-65C4-11EB-B657-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> - what is the recommended way to recover from this state?  "git fsck"
>>   shows the repositories to have no problems.  "git help commit-graph"
>>   doesn't show a command for users to use; is
>>   `rm -fr .git/objects/info/commit-graphs/` the recommended recovery
>>   command?

"rm -f .git/objects/info/commit-graph" as well, no?

> That, followed by `git commit-graph write --reachable [--changed-paths]`
> depending on what they want.

Just out of curiosity, how important is "--reachable"?  It only
traverses from the tips of refs and unlike fsck and repack, not from
reflog entries (or the index for that matter, but that shouldn't
make much difference as there is no _commit_ in the index).

>> - is there configuration or a patch we can roll out to help affected
>>   users recover from this state?
>
> If you are willing, then take v2 of this series and follow through by
> clearing the commit-graph files of affected users. Note that you can
> be proactive using `git commit-graph verify` to see who needs rewrites.

FYI, today's 368b6599 (Merge branch 'ds/commit-graph-genno-fix' into
jch, 2021-02-01) has this stuff.
