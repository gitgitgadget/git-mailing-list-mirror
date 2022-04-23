Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96B7C433EF
	for <git@archiver.kernel.org>; Sat, 23 Apr 2022 04:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbiDWErT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Apr 2022 00:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbiDWErR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Apr 2022 00:47:17 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321D7136970
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 21:44:20 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B5C931824D0;
        Sat, 23 Apr 2022 00:44:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=/1kIjPMyM938+zz1aRQv7rqBPXCNCE4WbP0Df20sPe0=; b=KoNu
        QAAjYAIl51XSxlPAY71xxD1k6uOKjJ1OU3DlOxjYVygpWaYT8K+hCllYOgLJikAY
        Y3rsNCz/SbnNcs/GGYOalfDFHpqsOz9xqqH9LNidvBmNVHQYJY//UCWiWFchtlo9
        GD/J1/WaxZo3F/Kao5GGOzVWCAaHJ0c0I3vm0yk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ADBCC1824CE;
        Sat, 23 Apr 2022 00:44:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B35F11824CD;
        Sat, 23 Apr 2022 00:44:15 -0400 (EDT)
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
        <xmqqzgkddf8m.fsf@gitster.g>
        <CAPMMpoj+g-XFKXoAXzW4d6WZRSBO_uE6MRsw2jWUPAjqWFQt2A@mail.gmail.com>
Date:   Fri, 22 Apr 2022 21:44:14 -0700
Message-ID: <xmqqv8v02yu9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0787EE20-C2C0-11EC-B1DA-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tao Klerks <tao@klerks.biz> writes:

>> "none", probably.  Much better than "current" that can create new
>> branches on the other side, which you would want to do with an
>> explicit end-user instruction (i.e. not with "git push", but with
>> "git push origin topic").

Sorry, "nothing" was what I meant.  Those non-simple branches are
left unconfigured with ASU=simple.  We both agree that the user does
not want to see the "with push.default=simple you have, you cannot
push from it" but the reason why they do not want to see can be
multiple.  You are assuming that they want to push to somewhere
else.  I am taking into account that they may not want to push them
at all, but only use locally.  If the intended workflow is

	git checkout -b main [origin/main] ;# assuming DWIM is on 
	git checkout -b topic origin/main
	... work work work ...
	git checkout main
	git merge topic
	... test test test ...
	... ahh, no it does not work, back to fix topic ...
	git reset --hard ORIG_HEAD
	git checkout topic
	... work work work ...
	git rebase -i ...
	git checkout main
	git merge topic
	... test test test ...
        ... yay, this time it is perfect and we can push it out ...
	git push

i.e. matching "simple" branches like main are used to locally bundle
what you locally worked on, and the result is pushed out to the
other side from there, while non-simple branches like topic are used
to locally work on your real changes, it is reasonable to expect
that the user wants "git push" to fail when the 'topic' branch is
checked out.

But unfortunately that does not work at the last step, as "nothing"
unfortunately affects the last step that tries to check out 'main',
too.  push.default='simple' would make it work.

> I would argue that git generally has a "problem", in that
> "branch.XXX.merge" entries have two classes of
> meanings/interpretation:
> * That is the "parent branch"
> ** The one I want changes from, when I say "update me with changes"
> ** The one I eventually want to get my changes to
> * That is the "remote instance/address" of *this* branch
> ** If I pull, it's to get changes to the same branch that others might have made
> ** When I push, it's to get this branch onto the server (not to get my
> changes into the "upstream")

Yes, that is very well known, and there arey mechanisms to support
some workflows that separates "where I get changes from" and "where
I publish my work" (look for "triangular workflows" in the list
archive).  

The thing is, "simple" is *NOT* meant for triangular workflow.  It
was to cater to novice users who are used to cvs/svn style
centralized "there is one place everybody pulls from and pushes to,
which is where they meet" model.
> Based on your feedback here, maybe "simple" is not the right name to
> associate with workflow, its assumptions and tradeoffs - I believe is
> accurately represents the intent and closely relates to the apparent
> design intent behind the push.default=simple option, but I'd love
> proposals as to how to name (and do) it better!
>
>> Currently, with both set to "simple", you do not even get .remote
>> and .merge for the "topic" branch, so your "git pull" simply does
>> not work.  And "git push" will also refuse to work.
>>
>
> That's right - because the assumption is that you've just created a
> new independent branch - independent by name, and therefore
> independent by default. You can of course add "--track" if you know
> what you're doing and know this is a local-only branch and you want it
> to track what you branched from and have "pull" bring in changes from
> there (without explicitly specifying so)!
>
>> But then why are you [*] forking from origin/main in the first
>> place?  What is the purpose you created 'topic' and what do you
>> plan to do with the result you develop on 'topic'?
>
> The assumption, in this workflow, is that you plan to work on that
> branch, potentially push to origin to back up or share your work, and
> will decide explicitly when to merge in changes from the origin you
> branched (forked) from, or merge changes up there.
>
>>
>>         Side note: "you" do not refer to"Tao, the advocate of the
>>         'simple' configuration", but figuratively the user who
>>         followed the "simple" route and created topic out of
>>         origin/main that is not connected to origin/main.
>>
>> Whatever you commit on topic eventually becomes part of what you'd
>> push to origin or elsewhere.  I'd assume it would be origin, because
>> as the user who choose 'simple', you have some branches that you
>> push back to the same name over there.  Presumably, those are the
>> primary integration branches the project has, like 'trunk', 'main',
>> 'master', etc.
>>
>> So perhaps the user would have been better off to fork off of the
>> LOCAL branch that would eventually be pushed back?  In other words,
>> the above user who created 'topic' would have done
>>
>>     $ git checkout -b main origin/main
>>
>
> (completely beside the point, but they would be more likely to have
> just done "git checkout main", for the same outcome)
>
>> to use as a local integration branch that collects the work you will
>> do locally that is targetted for their 'main' track, so to create a
>> topic that aims to be part of what is pushed back to their 'main'
>> track, you would want to do
>>
>>     $ git checkout -b topic main
>>
>> instead?  That way, "git push" would either not get .merge/.remote
>> (when branch.autosetupmerge is set to 'true') or point at your local
>> 'main' branch.
>
> I'm not sure I understand or agree with what you're saying here with
> "would [otherwise] point at your local 'main' branch". I have to
> assume you mean that would be the outcome with "always",

Yeah, I meant to add the matching (when ... is set to ...) after the
sentence and forgot.  You inferred what I meant to say correctly.

> In suggesting the user could/should have done that (in order to get a
> sane workflow, presumably), you are also suggesting that they should
> keep the state of that "local version of the upstream they eventually
> want to get their changes into" up-to-date: They should first check
> out master (for example), pull on master to get the state they expect,
> and *then* create their new differently-named local branch.

FWIW, I am not.

I do not think it is healthy nor necessary to make your local work
"catch up" too often with the outside world unnecessarily, be it
done with rebase or with merge.  They _can_ update 'master' when
outside world has something worth adding to your topic extra
dependency on and then update 'topic' to include what you took to
'master' from the outside.  Dissociating the 'topic' from outside
world is one way to encourage a better workflow.
