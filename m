Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C34AC433F5
	for <git@archiver.kernel.org>; Fri, 24 Dec 2021 18:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353437AbhLXSby (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Dec 2021 13:31:54 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:50298 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230508AbhLXSbx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Dec 2021 13:31:53 -0500
Received: from host-92-7-140-211.as13285.net ([92.7.140.211] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1n0pM6-0007QX-Bh; Fri, 24 Dec 2021 18:31:51 +0000
Message-ID: <54e16578-93f3-33e7-bd31-8909992e3407@iee.email>
Date:   Fri, 24 Dec 2021 18:31:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [RFC PATCH 00/10] range-diff: fix segfault due to integer
 overflow
Content-Language: en-GB
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
References: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com>
 <nycvar.QRO.7.76.6.2112101528200.90@tvgsbejvaqbjf.bet>
 <59ec39af-fdb1-a86a-d2be-37e5954e245f@iee.email>
 <211222.86r1a5plsm.gmgdl@evledraar.gmail.com>
 <c2bf8e3b-d758-6c60-506b-293d5be49eb6@iee.email>
 <211224.86zgoqgd7q.gmgdl@evledraar.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <211224.86zgoqgd7q.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/12/2021 16:46, Ævar Arnfjörð Bjarmason wrote:
> On Fri, Dec 24 2021, Philip Oakley wrote:
>
>> On 21/12/2021 23:36, Ævar Arnfjörð Bjarmason wrote:
>>> On Tue, Dec 21 2021, Philip Oakley wrote:
>>>
>>>> Sorry for the late comment..
>>>>
>>>> On 10/12/2021 14:31, Johannes Schindelin wrote:
>>>>> Hi Ævar,
>>>>>
>>>>> On Thu, 9 Dec 2021, Ævar Arnfjörð Bjarmason wrote:
>>>>>
>>>>>> The difference between "master" and "git-for-windows/main" is large
>>>>>> enough that comparing the two will segfault on my system. This is
>>>>>> because the range-diff code does some expensive calculations and will
>>>>>> overflow the "int" type.
>>>>> You are holding this thing wrong.
>>>>>
>>>>> The `main` branch of Git for Windows uses merging rebases, therefore you
>>>>> need to use a commit range like
>>>>> `git-for-windows/main^{/^Start.the.merging}..git-for-windows/main` and
>>>>> compare it to `git-for-windows/main..master`.
>>>> I'm not sure that a Git repo has an established way of indicating to how
>>>> it's branching/merging/releasing workflow is set up, especially for
>>>> projects with non-normative use cases, such as Git for Windows. We don't
>>>> have a git document for covering  the different workflows in common use
>>>> for easy reference and consistent terminology.
>>>>
>>>> The merging rebase flow, with 'fake' merge does solve a problem that
>>>> git.git doesn't have but could easily be a common process for 'friendly
>>>> forks' that follow an upstream with local patches. The choice of
>>>> '{/^Start.the.merging}' is currently specific to the Git-for-Windows
>>>> case making it harder to discover this useful maintainer method.
>>> Yes, but let's not get lost in the weeds here. As I noted I just picked
>>> GFW as a handy example of a large history & that command as a handy
>>> example of something that segfaults on "master".
>> Had you already experienced the segfault locally, without using the GFW
>> example? How many commits were present in that case?
> Yes, I ran into it "orginally" just range-diffing as part of a local
> build process.
>
> I could dig up what revision range it was exactly, but does it matter?
No the particular range-diff doesn't matter, I was checking that this
wasn't a confusion about the Git for Windows workflow.

>
>> The GFW example seems like it's taken the discussion in the wrong direction.
>>
>> For me:
>> $ git log git/master..origin/main --pretty=oneline | wc -l
>> 62105
>>
>> That's a lot of commits to have in a range diff. It's almost as big as
>> the whole of git/master
>>
>> $ git log git/master --pretty=oneline | wc -l
>> 65400
>>
>> Personally I'd like a way of trimming 'deadheads' that's a bit easier
>> that needing to remember Dscho's magic string [1], but time will tell.
> There are some repos that move forward by 500-1k commits/day, and people
> do cherry-pick patches etc. So wanting to range-diff after a couple of
> months is something you might do...

It feels to me that in such cases that maybe the algorithm may need
tweaking for the needle in a haystack case ;-)
>
>>> So the point really isn't to say that we should fix range-diff becase
>>> it'll allow us to run this practically useful command on a git.git fork.
>>>
>>>> I fully agree that the range-diff should probably have a patch limit at
>>>> some sensible value.
>>> Why would it? If I'm willing to spend the CPU to produce a range-diff of
>>> an absurdly large range and I've got the memory why shouldn't we support
>>> it?
>> There will always be a limit somewhere, and if it's not commit count or
>> other easily explained & checked limit it will be hard to rationalise
>> about why Git suddenly fails with an error (or segfault) in those
>> humungous case.
> I think it's fairly easy to explain the "your system wouldn't let us
> malloc more, we're dying" that we get from xmalloc(), st_*() and the
> like.
That's better than a segfault, but does it give actionable information
to the user as to what (& how much) they should do? Hence the comment
about a commit count measure.

>>> We don't in cases like xdiff where it's not trivial to just raise the
>>> limits, but here it seems relatively easy.
>>>
>>> I think limits to save users from spending CPU time they didn't expect
>>> are reasonable, but then we can handle them like the diff/merge rename
>>> detection limits, i.e. print a warning/advice, and allow the user to
>>> opt-out.
>>>
>>> That also doesn't really apply here since "diff/merge" will/might still
>>> do something useful in those scenarios, whereas range-diff would just
>>> have truncated output.
>>>
>>>> The 'confusion' between the types size_t, long and int, does ripple
>>>> through a lot of portable code, as shown in the series. Not an easy problem.
>>> Yes, although here we're not just casting and overflowing types, but
>>> overflowing on multiplication and addition, whereas usually we'd just
>>> overflow on "nr" being too big for "int" or similar.
>> I've been very slowly looking at the `long` limits on GFW which have
>> very similar arithmetic issues for pointers, often with no clear answers.
> Right, that's to do with the whole "long" or whatever use in the
> object.c and related code, but I don't think that's applicable here, is
> it?

That question was more about the policy aspects of ensuring that any
proposals aren't 'head against a brick wall' when it comes to the
potential intrusiveness.

Thanks for the clarifications.

Philip

