Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB86C433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 10:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D2E360FF2
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 10:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239038AbhIMKsc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 06:48:32 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:17741 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238610AbhIMKsb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 06:48:31 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mPjUX-000AIL-5K; Mon, 13 Sep 2021 11:47:14 +0100
Subject: Re: [PATCH v2 0/7] strvec: use size_t to store nr and alloc
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <5e5e7fd9-83d7-87f7-b1ef-1292912b6c00@iee.email>
 <cover-v2-0.7-00000000000-20210912T001420Z-avarab@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <cdf72de4-4879-c4b9-e882-2e134c6ba45f@iee.email>
Date:   Mon, 13 Sep 2021 11:47:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <cover-v2-0.7-00000000000-20210912T001420Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/09/2021 01:15, Ævar Arnfjörð Bjarmason wrote:
> This is a proposed v2 of Jeff King's one-patch change to change
> strvec's nr/alloc from "int" to "size_t". As noted below I think it's
> worthwhile to not only change that in the struct, but also in code
> that directly references the "nr" member.
>
> On Sat, Sep 11 2021, Philip Oakley wrote:
>
>> On 11/09/2021 17:13, Ævar Arnfjörð Bjarmason wrote:
>>> On Sat, Sep 11 2021, Jeff King wrote:
>>>
>>>> We converted argv_array (which later became strvec) to use size_t in
>>>> 819f0e76b1 (argv-array: use size_t for count and alloc, 2020-07-28) in
>>>> order to avoid the possibility of integer overflow. But later, commit
>>>> d70a9eb611 (strvec: rename struct fields, 2020-07-28) accidentally
>>>> converted these back to ints!
>>>>
>>>> Those two commits were part of the same patch series. I'm pretty sure
>>>> what happened is that they were originally written in the opposite order
>>>> and then cleaned up and re-ordered during an interactive rebase. And
>>>> when resolving the inevitable conflict, I mistakenly took the "rename"
>>>> patch completely, accidentally dropping the type change.
>>>>
>>>> We can correct it now; better late than never.
>>>>
>>>> Signed-off-by: Jeff King <peff@peff.net>
>>>> ---
>>>> This was posted previously in the midst of another thread, but I don't
>>>> think was picked up. There was some positive reaction, but one "do we
>>>> really need this?" to which I responded in detail:
>>>>
>>>>   https://lore.kernel.org/git/YTIBnT8Ue1HZXs82@coredump.intra.peff.net/
>>>>
>>>> I don't really think any of that needs to go into the commit message,
>>>> but if that's a hold-up, I can try to summarize it (though I think
>>>> referring to the commit which _already_ did this and was accidentally
>>>> reverted would be sufficient).
>>> Thanks, I have a WIP version of this outstanding starting with this
>>> patch that I was planning to submit sometime, but I'm happy to have you
>>> pursue it, especially with the ~100 outstanding patches I have in
>>> master..seen.
>>>
>>> It does feel somewhere between iffy and a landmine waiting to be stepped
>>> on to only convert the member itself, and not any of the corresponding
>>> "int" variables that track it to "size_t".
>>>
>>> If you do the change I suggested in
>>> https://lore.kernel.org/git/87v93i8svd.fsf@evledraar.gmail.com/ you'll
>>> find that there's at least one first-order reference to this that now
>>> uses "int" that if converted to "size_t" will result in a wrap-around
>>> error, we're lucky that one has a test failure.
>>>
>>> I can tell you what that bug is, but maybe it's better if you find it
>>> yourself :) I.e. I found *that* one, but I'm not sure I found them
>>> all. I just s/int nr/size_t *nr/ and eyeballed the wall off compiler
>>> errors & the code context (note: pointer, obviously broken, but makes
>>> the compiler yell).
>>>
>>> That particular bug will be caught by the compiler as it involves a >= 0
>>> comparison against unsigned, but we may not not have that everywhere...
>> I'm particularly interested in the int -> size_t change problem as part
>> of the wider 4GB limitations for the LLP64 systems [0] such as the
>> RaspPi, git-lfs (on windows [1]), and Git-for-Windows[2]. It is a big
>> problem.
> Okey, fine, no fun excercise for the reader then ;)

There's a lot of weeds in there ;-)  In some ways it feels like the
SHA1->SHA256 transition, but without the consensus, as the 'shifting
foundations' problem only affect a subgroup of a subgroup (large Windows
files and repositories).
>
> This is what I'd been sitting on locally since that recent thread, I
> polished it up a bit since Jeff King posted his version.
>
> The potential overflow bug I mentioned is in rebase.c. See
> 5/7. "Potential" because it's not a bug now, but that code
> intentionally considers a strvec, and then iterates it from nr-1 to 0,
> and if it reaches 0 intentionally counts down one more to -1 to
> indicate that it's visited all elements.

It's these tidbits about how the problems surface, their detection and
resolution that are really useful. Along with general awareness raising.
At least here the issue is reasonably tightly focussed, and even then,
testing is hard.
>
> We then check that with i >= 0, except of course if it becomes
> unsigned that doesn't become -1, but rather it wraps around.
>
> The rest of this is all changes to have that s/int/size_t/ radiate
> outwards, i.e. when we assign that value to a variable somewhere its
> now a "size_t" instead of an "int" etc.

In the LLP64 case, I'm somewhat concerned about the possible pushback of
a wide spread s/int/size_t/ on the codebase's look & feel.
 (aside) I don't think there is even a `1S` to match the  the `1L` and
`1U` shorthands used in various places.

None of that is part of the series, but the patches are beneficial to
the codes portability.

>
>> [0]
>> http://nickdesaulniers.github.io/blog/2016/05/30/data-models-and-word-size/
>> [1] https://github.com/git-lfs/git-lfs/issues/2434  Git on Windows
>> client corrupts files > 4Gb
>> [2] https://github.com/git-for-windows/git/pull/2179  [DRAFT] for
>> testing : Fix 4Gb limit for large files on Git for Windows
> Jeff King (1):
>   strvec: use size_t to store nr and alloc
>
> Ævar Arnfjörð Bjarmason (6):
>   remote-curl: pass "struct strvec *" instead of int/char ** pair
>   pack-objects: pass "struct strvec *" instead of int/char ** pair
>   sequencer.[ch]: pass "struct strvec *" instead of int/char ** pair
>   upload-pack.c: pass "struct strvec *" instead of int/char ** pair
>   rebase: don't have loop over "struct strvec" depend on signed "nr"
>   strvec API users: change some "int" tracking "nr" to "size_t"
>
>  builtin/pack-objects.c |  6 +++---
>  builtin/rebase.c       | 26 ++++++++++++--------------
>  connect.c              |  8 ++++----
>  fetch-pack.c           |  4 ++--
>  ls-refs.c              |  2 +-
>  remote-curl.c          | 23 +++++++++++------------
>  sequencer.c            |  8 ++++----
>  sequencer.h            |  4 ++--
>  serve.c                |  2 +-
>  shallow.c              |  5 +++--
>  shallow.h              |  6 ++++--
>  strvec.h               |  4 ++--
>  submodule.c            |  2 +-
>  upload-pack.c          |  7 +++----
>  14 files changed, 53 insertions(+), 54 deletions(-)
>
> Range-diff against v1:
> -:  ----------- > 1:  2ef48d734e8 remote-curl: pass "struct strvec *" instead of int/char ** pair
> -:  ----------- > 2:  7f59a58ed97 pack-objects: pass "struct strvec *" instead of int/char ** pair
> -:  ----------- > 3:  c35cfb9c9c5 sequencer.[ch]: pass "struct strvec *" instead of int/char ** pair
> -:  ----------- > 4:  2e0b82d4316 upload-pack.c: pass "struct strvec *" instead of int/char ** pair
> -:  ----------- > 5:  be85a0565ef rebase: don't have loop over "struct strvec" depend on signed "nr"
> 1:  498f5ed80dc ! 6:  ba17290852c strvec: use size_t to store nr and alloc
>     @@ Commit message
>          We can correct it now; better late than never.
>      
>          Signed-off-by: Jeff King <peff@peff.net>
>     +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>      
>       ## strvec.h ##
>      @@ strvec.h: extern const char *empty_strvec[];
> -:  ----------- > 7:  2edd9708888 strvec API users: change some "int" tracking "nr" to "size_t"

