Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CBBC433EF
	for <git@archiver.kernel.org>; Sat,  2 Apr 2022 14:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356134AbiDBOSj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Apr 2022 10:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245536AbiDBOSj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Apr 2022 10:18:39 -0400
Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7ED118F4D
        for <git@vger.kernel.org>; Sat,  2 Apr 2022 07:16:46 -0700 (PDT)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4KVzcV2cJ6z5tl9;
        Sat,  2 Apr 2022 16:16:42 +0200 (CEST)
Message-ID: <cc9aaba3-6904-4f96-db50-a368b9d9f0f2@kdbg.org>
Date:   Sat, 2 Apr 2022 16:16:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 7/7] git-sh-setup: don't mark trees not used in-tree
 for i18n
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>
References: <cover-v2-0.5-00000000000-20211119T202455Z-avarab@gmail.com>
 <cover-v3-0.7-00000000000-20220326T171200Z-avarab@gmail.com>
 <patch-v3-7.7-7a82b1fd005-20220326T171200Z-avarab@gmail.com>
 <2e2d20d6-a33d-b223-d364-ab43d92dd220@kdbg.org>
 <220327.8635j3fx3t.gmgdl@evledraar.gmail.com>
 <63bf6e97-1dca-c2b1-5673-301039e73acf@kdbg.org>
 <220328.86lewudzw3.gmgdl@evledraar.gmail.com>
 <45c963da-19a5-de51-34d4-5b29f461c9ec@gmail.com>
 <220331.86a6d6qqfe.gmgdl@evledraar.gmail.com>
 <12c7c651-49d2-d38b-122a-3fb5c29e94df@kdbg.org>
 <220402.86r16fn2bx.gmgdl@evledraar.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <220402.86r16fn2bx.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.04.22 um 12:44 schrieb Ævar Arnfjörð Bjarmason:
> 
> On Thu, Mar 31 2022, Johannes Sixt wrote:
> 
>> Am 31.03.22 um 13:15 schrieb Ævar Arnfjörð Bjarmason:
>>> I do have some WIP changes to tear down most of the *.sh and *.perl i18n
>>> infrastructure (the parts still in use would still have translations),
>>> and IIRC it's at least a 2k line negative diffstat, and enables us to do
>>> more interesting things in i18n (e.g. getting rid of the libintl
>>> dependency).
>>
>> Why? Why? Why? Does the status quo have a problem somewhere? All this
>> sounds like a change for the sake of change.
> 
> So this is quite the digression, but, hey, you asked for it.

Oh, no, this is not a digression *at all*. What your write below is the
kind of text that is needed to judge the value of a change. Without it,
a change that does not have an otherwise obvious improvement[*] is just
for the change's sake.

[*] In my book, getting rid of a libintl dependency is not an obvious
improvement. I may be biased in this case, because that dependency was
never a problem for me. Might be because my personal builds all have
NO_GETTEXT set.

> We don't have translations universally available because libintl is a
> rather heavy thing to ship.
> 
> I don't personally mind linking against it for my own builds, but grep
> for NO_GETTEXT in our tree & history for some of the workarounds.
> 
> We're also heading towards being able to build a stand-alone git binary
> for most things, which makes shipping in various setups much easier, but
> libintl is more of an "old-school" *nix library.
> 
> You need to ferry around auxilliary *.mo files, and for the *.sh and
> *.perl translations we need gettext.sh, /usr/bin/gettext and
> Locale::Messages (and everything that brings in).
> 
> I'd like translations for Git to Just Work, including if you're in some
> random docker image with someone's home-built git. Giving people fewer
> reasons to enable it improves accessibility. A lot of people who use git
> are not on their own personal laptop, but on some setup (corporate, CI
> etc.) that they don't fully control.
> 
> The gettext model & libintl is also just bad at various use-cases I
> think would make sense to support.
> 
> E.g. having a configurable option to emit output in two languages at the
> same time, either because you'd both like to understand the output &
> e.g. search errors online, or you'd understand more from a union of say
> German an English than from just one or the other.
> 
> For libintl you need'd to juggle setlocale() in the middle of your
> underlying sprintf implementation to do that, or pull other shenanigans
> of bypassing its API (e.g. directly reading the *.mo files), which
> pretty much amounts to the same thing.
> 
> So essentially I wanted to hack up something that would just
> post-process output like this:
> 
>     msgunfmt --strict -s -w 0 -i -E --color=always po/build/locale/de/LC_MESSAGES/git.mo
> 
> And turn it into a lang-de.c file, for which we'd make a lang-de.o that
> we'd link in. And then either binary search through it, or just generate
> code we'd compile (one really big switch/case statement).
> 
> Now, if you count the number of messages we translate in *.sh land on
> your digits you won't even need to use all of our toes, and for the
> *.perl it's similar, especially with add--interactive.perl going away
> any day now.
> 
> There isn't any fundamental obstacle to making such a thing portable to
> *.sh and *.perl, but having gotten that particular interop working once
> in the past needing to do that again would bring this (I think
> worthwhile) project from a "maybe someday" to "nah".

Just to make it clear: I am totally neutral on your goal. It's on others
to tell whether this is worth doing.

>>> But I also don't think that such a series is probably not possible in
>>> the near term if we're going to insist that all shellscript output must
>>> byte-for-byte be the same (for boring reasons I won't go into, but it's
>>> mainly to do with sh-i18n--envsubst.c).
>>
>> Such an insistence can easily be lifted if the change is justified
>> sufficiently. I haven't seen such a justification, yet.
> 
> Sure, but re the "chicken & egg" problem I might do all the work to do
> all that, and someone such as yourself might rightly point out that it
> would break someone's obscure use-case, scuttling the whole thing.
> 
> Which isn't an exaggeration b.t.w., if you e.g. look through our
> remaining gettext.sh usage you'll find that we carry the entirety of
> sh-i18n--ensubst.c and everything around it (at least ~1k lines) for
> emitting a single word in a single message in git-sh-setup.sh, that's
> it.

See, someone thought it was a good idea to have i18n in shell scripts
and others agreed that it was worth having ~1k lines of code to do that.
So the code went in. From then on, these ~1k lines are *not a problem*
in themselves. From then on, the decision of having ~1k lines or not
having them can only be based on what effect they have, but no longer on
"oh, wow, that's 1k lines to write a single word; do we really want that"?

> 
> Because the whole reason eval_gettext exists, and everything to support
> it, is to support the use-case of feeding *arbitrary input* into the
> translation engine, i.e. not the string you yourself have in your source
> code & trust (it avoids shell "eval").
> 
> But if you think that's of paramount importance (that word is "usage"
> b.t.w., and the equivalent in usage.c isn't even translated) there
> wouldn't be any way to make forward progress towards the next step of
> making the remaining shellscript translations call some "git sh--i18n"
> helper to get their output.
> 
> So, to the extent that I was going to pursue the above plan at all I
> wanted to do it in small steps, especially now as git-submodule.sh et al
> are going away.
> 
> So.
> 
> It would be nice to get some leeway in some areas, especially for
> something like this where I implemented this entire i18n system to begin
> with, so I'd think it would be clear that it's not some drive-by
> contribution. I clearly care about the end-goal, and have been sticking
> with this particular topic for more than a decade.
> 
> Not everything can always be a single atomically understood patch that
> carries all possible reasons to make the change with it, some things are
> more of a longer term incremental effort.
> 
> And since we all have limited time on this spinning ball of mud
> sometimes it can make sense to trickle in initial changes to see if some
> larger end-goal is even attainable, or will be blocked due to some
> unforeseen (or underestimated) reasons.

You can't have leeway for a change whose conclusion is "removes some
miniscule feature". But if you add "Here is the secret plan to Scrat's
golden nut; let's start with this change, even though it removes some
miniscule feature", things are vastly different.

-- Hannes
