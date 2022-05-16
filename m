Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF55C433EF
	for <git@archiver.kernel.org>; Mon, 16 May 2022 19:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345350AbiEPTRR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 15:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345320AbiEPTRK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 15:17:10 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002C83D1C2
        for <git@vger.kernel.org>; Mon, 16 May 2022 12:17:05 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0698F190050;
        Mon, 16 May 2022 15:17:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KDFQOZ2Bx6ExADmniW5oz6/ZwFmL4Nu/+XbYA1
        PO2dM=; b=i/ZWR8a57fxJ0pXm8bkzeeFDl6ftJY/K9V74AjsZeLn51Q+Vz+VIeh
        HZqJhn6FpFOqF0+qrscsQ4BzJZ0upEbDyz8kHiRzIrS2RNflK8ggs4EzXmaw4lQx
        yppPWYvlqi0Fi6fzXBUPbLqWc1IoiGB9rEdW1MUtuaqrNnexUvyZ0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F1B5819004F;
        Mon, 16 May 2022 15:17:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8F1DF19004C;
        Mon, 16 May 2022 15:17:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        <rsbecker@nexbridge.com>
Subject: Re: [PATCH v2 0/2] setup.c: make bare repo discovery optional
References: <pull.1261.git.git.1651861810633.gitgitgadget@gmail.com>
        <pull.1261.v2.git.git.1652485058.gitgitgadget@gmail.com>
        <xmqqy1z12zxr.fsf@gitster.g>
        <kl6ly1z1iati.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Mon, 16 May 2022 12:16:59 -0700
In-Reply-To: <kl6ly1z1iati.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Mon, 16 May 2022 11:36:41 -0700")
Message-ID: <xmqqk0al1e50.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C3834824-D54C-11EC-B6DC-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>>  * die()-ing is necessary if we're trying to flip the default value of
>>>    discovery.bare. We'd expect many bare repo users to be broken, and it's
>>>    more helpful to fail loudly than to silently ignore the bare repo.
>>>
>>>    But in the long term, long after we've flipped the default and users know
>>>    that they need to opt into bare repo discovery, would it be a better UX
>>>    to just silently ignore the bare repo?
>>
>> Would a middle-ground of giving a warning() message help?  Can it be
>> loud and annoying enough to knudge the users to adjust without
>> breaking the functionality?
>
> Personally, when my tool changes its behavior, I would strongly prefer
> it to die than to "change behavior + warn". I'd feel more comfortable
> knowing that the tool did nothing as opposed to doing the wrong thing
> and only being informed after the fact. Also, I sometimes ignore
> warnings ;)

Heh, personally I would try very hard not to change the behaviour
without explicitly asked by the users with configuration or command
line option.  Flipping the default has traditionally been done in
two or three phases.

 (1) We start by giving a loud and annoying warning to those who
     haven't configured and tell them the default *will* change, how
     to keep the current behaviour forever, and how to live in the
     future by adopting the future default early.

 (2) After a while, we flip the default.  Those who haven't
     configured are given a notice that the default has changed, how
     to keep the old behaviour forever, and how to explicitly choose
     the same value as the default to squelch the notice.

 (3) After yet another while, we stop giving the notice.  If we
     omitted (2), here is where we flip the default.

Strictly speaking, we can have (1) in one release and then could
directly jump to (3), but some distros may skip the releases that
has (1), and (2) is an attempt to help users of such distros.

>> Hopefully "git fetch" over ssh:// and file:/// would run the other
>> side with GIT_DIR explicitly set?
>
> Ah, I'll check this and get back to you.
>
>>                                                        I do not yet
>> find these "problems, such as..." so convincing.
>
> What would be a convincing rationale to you? I'll capture that here.

That is a wrong question.  You are the one pushing for castrating
the bare repositories.

> I'm assuming that you already have such an rationale in mind when you
> say that the longer-term default is that "we respect bare repositories
> only if they are the cwd.". I'm also assuming that this rationale is
> something other than embedded bare repos, because "cwd-only" does not
> protect against that.

No, I do not have such a "different" rationale to justify the change
proposed in this patch.  I was saying that the claim "embedded bare
repos are risky", backed by your two examples, did not sound all
that serious a problem.  Presented with a more serious brekage
scenario, it may make the description more convincing.

Thanks.
