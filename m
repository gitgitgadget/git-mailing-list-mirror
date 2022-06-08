Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D84C43334
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 20:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbiFHUor (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 16:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiFHUoq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 16:44:46 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20999EAB8E
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 13:44:44 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 383F61924D6;
        Wed,  8 Jun 2022 16:44:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DQPuJ+L473gGn7+80qa2TZmLo+9BvrJH5EoeXm
        Qq/kU=; b=s9t7u7yRV+ZdomdqrrKfyfCstafxnAVejooiN46yBMS+59GqkfQe+l
        UnBst0UfaiGQX4OMWEMD3SLLTsnQP+WjODCAaBLDnFqqE0opZYodA/p2MmxMpXog
        RY/5bFEBYjP4jOtDV2sHgKDuVk0bMK2DVja34VVqDYjw27l1lisz8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 314621924D5;
        Wed,  8 Jun 2022 16:44:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B2F861924D3;
        Wed,  8 Jun 2022 16:44:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH 1/6] docs: document bundle URI standard
References: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
        <e771b2971d092af5ea8a47eb708d03e34b284a0f.1654545325.git.gitgitgadget@gmail.com>
        <xmqqsfoh4ery.fsf@gitster.g>
        <9244644f-2c80-f23d-f054-3f0c961696af@github.com>
        <xmqqo7z3q7lm.fsf@gitster.g>
Date:   Wed, 08 Jun 2022 13:44:39 -0700
In-Reply-To: <xmqqo7z3q7lm.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        08 Jun 2022 12:27:01 -0700")
Message-ID: <xmqqfskeriko.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D1B58FE8-E76B-11EC-81AC-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Derrick Stolee <derrickstolee@github.com> writes:
>
>>> How does a client tell which one it got?  Do we register mimetype
>>> with iana to use for these two types of files, and have the HTTP
>>> downloader to use the information?
>>
>> My implementation is much dumber than that: it first attempts to
>> parse the file as a bundle (looking for a bundle header) and then
>> attempts to parse it as a config file after that. If neither
>> succeed, then an error is thrown.
>
> I think that is probably the best implementation after all.
>
> We cannot trust what the other side tells us.  "They claimed that
> this is a bundle file and not a table-of-contents, and it does look
> like one, but it may be corrupt or even malicious file that may look
> like a bundle file on surface, so let's carefully examine it" ought
> to be the attitude the receiving side has towards the incoming data.

With the above, I do not mean that this new mechanism must be more
paranoia than we already are.  

    $ git fetch bootstrap.bndl refs/*:refs/bundle/bootstrap/*

should already have sensible error checking, and we should use the
available mechanism.  But there of course are places the new feature
should be careful in its new code, for example, we may want to
unbundle all these bundles in quarantined area until we resolve all
the prerequisite objects and then move them out of the quarantine,
for example, if the new feature rolls its own code to unbundle
instead of invoking "git fetch" on it.  Even if it spawns "git fetch"
on it, it may have to choose the parameters carefully (e.g. the refmap
would want to avoid clobbering our own ref namespace, which you plan
to do).


