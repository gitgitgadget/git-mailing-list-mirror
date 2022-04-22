Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E7EC433EF
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 02:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbiDVCad (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 22:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbiDVCac (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 22:30:32 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8D81D0CC
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 19:27:40 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B60FD12CD27;
        Thu, 21 Apr 2022 22:27:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=FAK3Avk7jzQMfSxgx5Sp7aplE5hK4IQ43ZU6CNPS1D0=; b=cfDJ
        Lc6TRLm3gAMXu98wgvNEhQCQUj3JVLNhn6M86zbGj6Hcvbrmd/xBggIrMvC3DcyM
        xIA3YCX3osO2IRY72SKWOjAEYnmVUusbTW4T1Pz24hqymfu8skGGv+KSqXfy2k/v
        0cyve6FhZLE06Izuc0MKj64DyjYqt0JWwZgrsME=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AD9F312CD26;
        Thu, 21 Apr 2022 22:27:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DCDD812CD25;
        Thu, 21 Apr 2022 22:27:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tao Klerks <tao@klerks.biz>
Cc:     Josh Steadmon <steadmon@google.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4] merge: new autosetupmerge option 'simple' for
 matching branches
References: <pull.1161.v3.git.1646032466.gitgitgadget@gmail.com>
        <pull.1161.v4.git.1647843442911.gitgitgadget@gmail.com>
        <Yl2qwO0SMPOhb5h9@google.com>
        <CAPMMpogY5vZU8gyRSYh+BM4goPPtJw0cCiM-31sy-s_uGRv8uA@mail.gmail.com>
        <xmqqczhbr6pv.fsf@gitster.g>
        <CAPMMpohQei9vBBm=7hC=N5LPwzMCED=fZcXyePnrkLCHfCJTZw@mail.gmail.com>
        <xmqqlevzkxrf.fsf@gitster.g>
        <CAPMMpoiCD+fG=bs2j4Rin5Pvip9Mre9iqLcOb2LYnDQK9cuRxw@mail.gmail.com>
Date:   Thu, 21 Apr 2022 19:27:37 -0700
Message-ID: <xmqqzgkddf8m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C76D8E26-C1E3-11EC-B0EC-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tao Klerks <tao@klerks.biz> writes:

>> I am wondering if that is more irritating than it is
>> worth.  Instead, if you tell them to use branch.autosetupmerge=simple
>> and use push.default to something better than simple, wouldn't that
>> cover more cases and give fewer roadblocks to the end-user with
>> unnecessary errors?
>
> I think you're on to something I missed here.
>
> Unfortunately, I'm not sure what "something better than simple" for
> push.default actually is, in the current system.

"none", probably.  Much better than "current" that can create new
branches on the other side, which you would want to do with an
explicit end-user instruction (i.e. not with "git push", but with
"git push origin topic").

This depends on what you are really trying to achieve.  If we think
it through, perhaps it may turn out to be a combination of a bit
flawed workflow with a bit inadequate toolset.

With "simple" (both in branch.autosetupmerge and push.default), I
can see that if you create "main" from their "main" and "maint" from
their "maint", you want to see that

 (1) your "git pull" to integrate what happend on their "main" or
     "maint" respectively, and

 (2) your "git push" to push what you did on your "main" to their
     "main", and "maint" to "maint".

But it is totally unclear what you really want to do on "topic" you
created this way:

    $ git checkout -b topic origin/main

Currently, with both set to "simple", you do not even get .remote
and .merge for the "topic" branch, so your "git pull" simply does
not work.  And "git push" will also refuse to work.

But then why are you [*] forking from origin/main in the first
place?  What is the purpose you created 'topic' and what do you
plan to do with the result you develop on 'topic'?

	Side note: "you" do not refer to"Tao, the advocate of the
	'simple' configuration", but figuratively the user who
	followed the "simple" route and created topic out of
	origin/main that is not connected to origin/main.

Whatever you commit on topic eventually becomes part of what you'd
push to origin or elsewhere.  I'd assume it would be origin, because
as the user who choose 'simple', you have some branches that you
push back to the same name over there.  Presumably, those are the
primary integration branches the project has, like 'trunk', 'main',
'master', etc.

So perhaps the user would have been better off to fork off of the
LOCAL branch that would eventually be pushed back?  In other words,
the above user who created 'topic' would have done 

    $ git checkout -b main origin/main

to use as a local integration branch that collects the work you will
do locally that is targetted for their 'main' track, so to create a
topic that aims to be part of what is pushed back to their 'main'
track, you would want to do

    $ git checkout -b topic main

instead?  That way, "git push" would either not get .merge/.remote
(when branch.autosetupmerge is set to 'true') or point at your local
'main' branch.

 - The symptom you get from the former is no better than what you
   get from branch.autosetupmerge=simple but it is not worse.
   "push" and "pull" refuses to work and suggest you to do something
   additional.

 - The latter would make your "git push" and "git pull" on 'topic'
   to work with your local 'main', treating your 'main' in a way
   very similar to how you treat your remote 'main' when you are on
   your own 'main', which is quite reasonable if your change flow is
   designed to be "work on topic, when the changes on topic proves
   OK, send that to main, and when the changes on main proves OK,
   send that to their main".

I guess I am esseentially saying that the usefulness of "simple" for
branch.autosetupmerge is dubious.

> Do you agree that none of the push.default options available today are
> "right" for this flow? Do you have a preference or opinion as to
> whether:
> * push.default=current should be changed to set up tracking when absent, or
> * push.default=simple should be changed to "simply" push and set up
> tracking when there is no tracking, or
> * a new push.default option should be introduced for this behavior, or
> * some other configuration should be introduced to specify "and set up
> tracking on default push if missing" (and if so, under what
> circumstances should it kick in?)

None of the above, I guess.
