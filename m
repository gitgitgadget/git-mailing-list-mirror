Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92733C433E6
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 19:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 461D364F84
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 19:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhBCTVM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 14:21:12 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59566 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbhBCTVL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 14:21:11 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0634AAB5F2;
        Wed,  3 Feb 2021 14:20:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=N5/wjXXQinQiECy6xteUVA+QENM=; b=lslBPF
        u0aBDstK+Q614cuXOC/R/l38i5dTZMnBRIc6yeYU8UCYWqj8cKQ1rIXF4fuvKSd3
        uP9dhXal8o87rHpMlK3l9lP7WDoeKS0uBNS9480R1Ovn19hJNyU3S2gFDXkQVLz0
        79AIWoP54+PIHDD8dox/GSl77kClTw4J0WAj8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gB9ZQuxor42GyMPdQmrrPlA9qVZMW9sK
        mVi5b8lucDfx6ZUVe2C4mNahmpJQk/f4BDQ7rHZFd1V6UcBw9YJWJtPq9XtVv4Ik
        eT4GEV+0GZewsMLqI0yWw+ZYIdoWr23xC4jVflj6R4njgOBtkxPpFGLCNSAOQpKH
        8qkVP24n1SQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F038CAB5F1;
        Wed,  3 Feb 2021 14:20:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 70B6FAB5F0;
        Wed,  3 Feb 2021 14:20:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?us-ascii?Q?=3D=3Futf-8=3FB=3Fw4Z2YXIgQXJuZmrDtnLDsA=3D=3D=3F=3D?=
         Bjarmason <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: Re: Why does fast-import need to check the validity of idents? +
 Other ident adventures
References: <pull.795.v2.git.git.1590698437607.gitgitgadget@gmail.com>
        <pull.795.v3.git.git.1590870357549.gitgitgadget@gmail.com>
        <87bld8ov9q.fsf@evledraar.gmail.com>
Date:   Wed, 03 Feb 2021 11:20:27 -0800
In-Reply-To: <87bld8ov9q.fsf@evledraar.gmail.com> (utf's message of "Wed, 03
        Feb 2021 12:57:08 +0100")
Message-ID: <xmqq7dnpc610.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DFE897C0-6654-11EB-B629-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=" Bjarmason <avarab@gmail.com>
writes:

> But I was wondering about fast-import.c in particular. I think Elijah's
> patch here is obviously good an incremental improvement. But stepping
> back a bit: who cares about sort-of-fsck validation in fast-import.c
> anyway?

Those who want to notice and verify the procedure they used to
produce the import data from the original before it is too late?

I.e. data gets imported to Git, victory declared and then old SCM
turned gets off---and only then the resulting imported repository is
found not to pass fsck.

> Shouldn't it just pretty much be importing data as-is, and then we could
> document "if you don't trust it, run fsck afterwards"?

If it is a small import, the distinction does not matter, but for a
huge import, the procedure to produce the data is likely to be
mechanical, so even after processing just a very small portion of
early part of the datastream, systematic errors would be noticed
before fast-import wastes importing too much garbage that need to be
discarded after running such fsck.  So in that sense, I suspect that
there is value in the early validation.

> Or, if it's a use-case people actually care about, then I might see
> about unifying some of these parser functions as part of a series I'm
> preparing.

I think allowing people to loosen particular checks for fast-import
(or elsewhere for that matter) is a good idea, and you can do so
more easily once the existing checking is migrated to your new
scheme that shares code with the fsck machinery.
