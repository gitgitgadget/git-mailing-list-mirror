Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5F0C433EF
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 17:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73B5660EE3
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 17:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhICRTj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 13:19:39 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51551 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhICRTj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 13:19:39 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D108914168E;
        Fri,  3 Sep 2021 13:18:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0iW6/dGxDtVLO5xk0fXSBZ9AJQBzyJSyV7suWS
        VYaSc=; b=FWLHHXz1sW7/5yVDo3A0o485fMZPWgyQhE1O2PbpExE4GLvq53vwEJ
        4nJ4hXsFtYBtnn4EdmlyTXPQzMeTWJ1SAeFODkS8F+1s6SwyldP8uQUufdZ2Bmmh
        th1Zuop8yvEsbjJBUEyM4M5h7KjVFL5uiQi9QvGeJHORWp7teVmWM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C97D714168B;
        Fri,  3 Sep 2021 13:18:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EE45614168A;
        Fri,  3 Sep 2021 13:18:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 08/15] scalar: implement the `clone` subcommand
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
        <2cbf0b611133df5fa7eed1bf38460f9d119d2a6e.1630359290.git.gitgitgadget@gmail.com>
        <xmqqsfyoqm6e.fsf@gitster.g>
        <a7c9870a-9af3-bac8-1964-358ecdebe344@gmail.com>
Date:   Fri, 03 Sep 2021 10:18:34 -0700
In-Reply-To: <a7c9870a-9af3-bac8-1964-358ecdebe344@gmail.com> (Derrick
        Stolee's message of "Fri, 3 Sep 2021 08:30:49 -0400")
Message-ID: <xmqq35qlh91x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F8E6BF86-0CDA-11EC-845A-FA11AF6C5138-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> Ahh, you do not do "git clone"; you do "git init", set things up,
>> and then "git fetch" and checkout, all manually.
>> 
>> Which is kind of shame.
>> 
>> I wonder if it is a cleaner implementation to give a new option to
>> "git clone" that gives a command sequence (not necessarily have to
>> be implemented as a shell script) that specifies necessary
>> pre-configuration steps to be done before the command starts the
>> transfer step.
>
> I agree that 'git clone' plus maybe some more improvements like
> '--sparse=cone' to set up cone-mode sparse-checkout would be good.
> And also the implementation being contributed here is cleaner if
> we can use 'git clone'.
>
> We are trying to balance a clean upstream implementation with some
> custom things that we still need in our microsoft/git fork to
> handle the integration with the GVFS Protocol (i.e. partial clone
> on Azure Repos). That customization is cleaner to keep here in the
> scalar code instead of adding an option to 'git clone'.

Oh, there is no disagreement on that point, at least in the short
term.  I was wondering why "clone" subcommand needs a duplicated
logic that should be unnecessary, before realizing that this was
not implemented as a wrapper to (possibly updated) "clone", and
I agree that starting with a looser coupling like this step does
is easier to everybody.

"Kind of shame" is just that I wished we had already prepared "git
clone" side to accept customization more easily before its various
distinct phases (new repository creation, where a custom logic may
want to affect the name and location of it and how "git init" is
driven, initial "fetch", where a custom logic may want to affect the
fetch refspec and its parameters like depths and cones, and initial
"checkout") do their things.  If we allowed such plug-in of logic to
affect how "git clone" worked already, it would have been possible
to do "scalar clone" with much less code.  It also would allow us to
reorganize the "clone --local" hack in a way that is easier to
reason about (I think even in today's code, the way I hooked it up
can be seen which is quite messy).  It may even help folks who want
to extend "git clone" to clone a repository recursively its
submodules with project-specific customizations (like which ones to
clone by default, etc.).

I suspect that learning from the way "scalar clone" is done on top
of "init" + "fetch" + "checkout" in this initial series may help us
extend "git clone" later to fill such needs.

> If your opinion to switch to 'git clone' is a strong one, then I
> could see us doing that change. I just want you to be aware of the
> hidden reasons for choices like these.

Not at all at this moment.

It is mostly that the way "init" + "fetch" + "checkout" was done in
this step reminded me of a much longer-term wish I have had for a
while.
