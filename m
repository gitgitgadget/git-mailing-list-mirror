Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C64C433FE
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 19:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236918AbiBWTb7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 14:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbiBWTb4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 14:31:56 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68624833C
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 11:31:27 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EBE7A177EA5;
        Wed, 23 Feb 2022 14:31:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TPA4vcK52Y6R0c0/iLu67fkIR/4FyzDjgdkd+a
        vj6AU=; b=YJZ8AdGW0iyIwLXbd/OxVZnQZMydkkZmOEo+ScxK74RpOJ0YAlB17C
        tYcHUdJsAA94m3YdGs27eWJqzMGxsMzZtS381Adpvi3nqjMJwdsRtLOrg0FPod9h
        SBtFWADE5PvoQrXIH9GqQBPfPFZI4amPubgZUtuWGQdXsT5VDigP8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E3193177EA4;
        Wed, 23 Feb 2022 14:31:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 560DC177E9F;
        Wed, 23 Feb 2022 14:31:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, John Cai <johncai86@gmail.com>,
        Robert Coup <robert.coup@koordinates.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 0/4] [RFC] repack: add --filter=
References: <pull.1206.git.git.1643248180.gitgitgadget@gmail.com>
        <pull.1206.v2.git.git.1644372606.gitgitgadget@gmail.com>
        <CAFLLRpJ1aDyLb4qAoQwYDyGdP1_PH8kzLAQCKJpQwiYiapZ5Aw@mail.gmail.com>
        <CB2ACEF7-76A9-4253-AD43-7BC842F9576D@gmail.com>
        <YhMC+3FdSEZz22qX@nand.local>
        <CAP8UFD2dpicW64eqBK47g43xDWA1qv2BMBEOSqj_My5PUs8TSg@mail.gmail.com>
        <YhQHYQ9b9bYYv10r@nand.local>
        <CAP8UFD3U4t-inWC5mZYhybWpjVwkqA7v4hYZ5voBOEJ=+_Y1kQ@mail.gmail.com>
Date:   Wed, 23 Feb 2022 11:31:23 -0800
In-Reply-To: <CAP8UFD3U4t-inWC5mZYhybWpjVwkqA7v4hYZ5voBOEJ=+_Y1kQ@mail.gmail.com>
        (Christian Couder's message of "Tue, 22 Feb 2022 18:11:11 +0100")
Message-ID: <xmqqv8x5v0qc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2FE345F4-94DF-11EC-8693-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

>> For what it's worth, I am fine having a mode of repack which allows us
>> to remove objects that we know are stored by a promisor remote. But this
>> series doesn't do that, so users could easily run `git repack -d
>> --filter=...` and find that they have irrecoverably corrupted their
>> repository.
>
> In some cases we just know the objects we are removing are stored by a
> promisor remote or are replicated on different physical machines or
> both, so you should be fine with this.

So, we need to decide if an object we have that is outside the
narrowed filter definition was (and still is, but let's keep the
assumption the whole lazy clone mechanism makes: promisor remotes
will never shed objects that they once served) available at the
promisor remote, but I suspect we have too little information to
reliably do so.  It is OK to assume that objects in existing packs
taken from the promisor remotes and everything reachable from them
(but missing from our object store) will be available to us from
there.  But if we see an object that is outside of _new_ filter spec
(e.g. you fetched with "max 100MB", now you are refiltering with
"max 50MB", narrowing the spec, and you need to decide for an object
that weigh 70MB), can we tell if that can be retrieved from the
promisor or is it unique to our repository until we push it out?  I
am not sure.  For that matter, do we even have a way to compare if
the new filter spec is a subset, a superset, or neither, of the
original filter spec?

> If you are not fine with this because sometimes a user might use it
> without knowing, then why are you ok with commands deleting refs not
> checking that there isn't a regular repack removing dangling objects?

Sorry, I do not follow this argument.  Your user may do "branch -D"
because the branch deleted is no longer needed, which may mean that
objects only reachable from the deleted branch are no longer needed.
I do not see what repack has anything to do with that.  As long as
the filter spec does not change (in other words, before this series
is applied), the repack that discards objects that are known to be
reachable from objects in packs retrieved from promisor remote, the
objects that are no longer reachable may be removed and that will
not lose objects that we do not know to be retrievable from there
(which is different from objects that we know are unretrievable).
But with filter spec changing after the fact, I am not sure if that
is safe.  IOW, "commands deleting refs" may have been OK without
this series, but this series may be what makes it not OK, no?

Puzzled.

