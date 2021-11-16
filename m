Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F394C433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 18:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C0B561BC1
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 18:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbhKPS5t (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 13:57:49 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63026 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhKPS5t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 13:57:49 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5ACCAEC741;
        Tue, 16 Nov 2021 13:54:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=85XeKQ1sQdxEzt2VEz5P2gzbrt9ukdixRUbgb3
        qmCfs=; b=QAlhD2qYQsZuPOYZQFvruUqPNf00RbOOvllVudrJ1tN39qj9hMlYcQ
        nNa35/zqEMzr+mjtyDWhDIMHG1Unb3zXD2pgBcX2VPbttlzcWgGIJSrLtGvQk1eb
        JOG66hjpsxDrbMHQx6YoQf9lz7eBVM2M6t660zBQ6OIY7oOPpZPPU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 515FFEC740;
        Tue, 16 Nov 2021 13:54:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A817AEC73F;
        Tue, 16 Nov 2021 13:54:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mugdha Pattnaik <mugdhapattnaik@gmail.com>
Cc:     Mugdha Pattnaik via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v6] submodule: absorb git dir instead of dying on deinit
References: <pull.1078.v5.git.git.1633521772731.gitgitgadget@gmail.com>
        <pull.1078.v6.git.git.1633523057369.gitgitgadget@gmail.com>
        <xmqqwnmopqqk.fsf@gitster.g>
        <CAA4dvxgNJ8eyuc5B6_GnSLHMWjdbJN5k_rTCLjWndEyjv_vOnw@mail.gmail.com>
Date:   Tue, 16 Nov 2021 10:54:49 -0800
In-Reply-To: <CAA4dvxgNJ8eyuc5B6_GnSLHMWjdbJN5k_rTCLjWndEyjv_vOnw@mail.gmail.com>
        (Mugdha Pattnaik's message of "Tue, 16 Nov 2021 23:50:45 +0530")
Message-ID: <xmqqy25o9bie.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AD78204E-470E-11EC-BF82-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mugdha Pattnaik <mugdhapattnaik@gmail.com> writes:

>> OK.  That sounds like an improvement, albeit possibly an overly
>> cautious one, as a casual "deinit" user will get an error as before
>> without "--force", which may or may not be a good thing.  Requiring
>> "--force" means it is safer by default by not changing the on-disk
>> data.  But requiring "--force" also means we end up training users
>> to say "--force" when it shouldn't have to be.
>> ...
>> Does "git submodule" currently reject a "deinit" request due to some
>> _other_ conditions or safety concerns and require the "--force"
>> option to continue?  Requiring the "--force" option to resolve ".git
>> is a directory, and the user wants to make it absorbed" means that
>> the user will be _forced_ to bypass these _other_ safety valves only
>> to save the submodule repository from destruction when running
>> "deinit", which may not be a good trade-off between the safety
>> requirements of these _other_ conditions, if exists, and the one we
>> are dealing with.
>
> This is definitely a situation we want to avoid. How about we try to run
> a check for uncommitted local modifications first?

I am not sure if I follow.  If we stop (ab)using "--force" for the
situation (i.e. where today's "deinit" would die because .git needs
to be absorbed first), then the user would not have to say "--force"
which may override other safety valve.  You'd check if .git needs to
be absorbed, make it absorbed as needed while reporting the fact
that you did so, and then let the existing "deinit" code to take
over.  If there are other safety checks that needs "--force" to be
overridden, that is handled (presumably) correctly by the existing
code, no?  So other than "do we need absorbing, and if so do it for
the user" check, I do not think you'd need to add any new "we try to
run a check for ..." at all.


