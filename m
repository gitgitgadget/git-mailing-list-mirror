Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1244C4332F
	for <git@archiver.kernel.org>; Wed, 19 Oct 2022 12:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiJSMqo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Oct 2022 08:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiJSMqY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2022 08:46:24 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D050912D81F
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 05:29:01 -0700 (PDT)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1ol5AW-0004I4-E4;
        Wed, 19 Oct 2022 10:15:21 +0100
Message-ID: <1d6d6047-6993-d4fd-c506-6c9be9a789dd@iee.email>
Date:   Wed, 19 Oct 2022 10:15:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH 1/2] notes: support fetching notes from an external
 repo
Content-Language: en-GB
To:     Vegard Nossum <vegard.nossum@oracle.com>, git@vger.kernel.org
Cc:     Johan Herland <johan@herland.net>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Christian Hesse <mail@eworm.de>
References: <20220802075401.2393-1-vegard.nossum@oracle.com>
 <96b04fc0-eadc-af01-502a-e5236a393ac4@iee.email>
 <66d96a5c-ce6f-9241-a766-f396674798c9@oracle.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <66d96a5c-ce6f-9241-a766-f396674798c9@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Vegard,

On 17/10/2022 14:14, Vegard Nossum wrote:
>
> On 8/30/22 16:17, Philip Oakley wrote:
>> Sorry for late comment.
>
> And sorry for late response! I didn't receive your email for some
> reason, but I noticed it in the list archives.
>
>> On 02/08/2022 08:54, Vegard Nossum wrote:
>>> Notes are currently always fetched from the current repo. However, in
>>> certain situations you may want to keep notes in a separate repository
>>> altogether.
>>>
>>> In my specific case, I am using cgit to display notes for repositories
>>> that are owned by others but hosted on a shared machine, so I cannot
>>> really add the notes directly to their repositories.
>>>
>>> This patch makes it so that you can do:
>>>
>>>      const char *notes_repo_path = "path/to/notes.git";
>>>      const char *notes_ref = "refs/notes/commits";
>>>
>>>      struct repository notes_repo;
>>>      struct display_notes_opt notes_opt;
>>>
>>>      repo_init(&notes_repo, notes_repo_path, NULL);
>>>      add_to_alternates_memory(notes_repo.objects->odb->path);
>>>
>>>      init_display_notes(&notes_opt);
>>>      notes_opt.repo = &notes_repo;
>>>      notes_opt.use_default_notes = 0;
>>>
>>>      string_list_append(&notes_opt.extra_notes_refs, notes_ref);
>>>      load_display_notes(&notes_opt);
>>>
>>> ...and then notes will be taken from the given ref in the external
>>> repository.
>>>
>>> Given that the functionality is not exposed through the command line,
>>> there is currently no way to add regression tests for this.
>>>
>>> Cc: Johan Herland <johan@herland.net>
>>> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
>>> Cc: Christian Hesse <mail@eworm.de>
>>> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
>>> ---
>>>   common-main.c |  2 ++
>>>   notes.c       | 15 ++++++++++++---
>>>   notes.h       |  3 +++
>>>   refs.c        | 12 +++++++++---
>>>   refs.h        |  2 ++
>>>   5 files changed, 28 insertions(+), 6 deletions(-)
>>
>> Where's the documentation? Without a clarity of purpose and usage then,
>> for me, it doesn't fly.
>>
>> I feel that underlying this there may something that's interesting, but
>> without the 'SPIN' narrative (situation, problem, implication, and
>> need-payoff) I'm not sure what it's trying to do from a broad user
>> perspective. (Spin is just one approach to 'selling' the patches;-)
>>
>> I'd agree that Notes are 'odd' in that they are out of sequence relative
>> to commits, and may not be common between users viewing the same repo.
>> I'd like to understand the issues in a wider context.
>> -- 
>> Philip
>
> Perhaps the best way to showcase this is with a screenshot of what we're
> trying to upstream:
>
> https://vegard.github.io/cgit/6399f1fae4ec.png
>
> Since git commits cannot be changed without rewriting history, git notes
> is the mechanism by which we can attach new information to existing
> commits. We're internally using these notes for cross-referencing
> information like references to subsequent fixes, backports in other
> trees, mailing list discussions, etc.
>
> There is also a bit more information in my cgit patch submission from
> today: https://lists.zx2c4.com/pipermail/cgit/2022-October/004764.html
>
> My "problem" is that there are many moving parts to this, and the two
> git.git patches sit at the top of the dependency chain:
>
> 1. these git patches
> 2. the cgit patches
> 3. the Linux kernel-specific notes generation scripts/logic
> 4. the Linux kernel notes themselves
> 5. displaying notes on kernel.org
>
> Almost all of these steps involve different people with different
> standards, different motivations, different priorities.
>
> As I wrote earlier, I am trying to be a good citizen and upstream as
> much of this as I can. But it's hard to justify what Junio asked for:
> scrapping my current patches (which we are currently using...) in favour
> of a complete rewrite with more functionality that does not buy us
> anything from my point of view.
>
> Does this clarify things?

Yes, and No;
Even without Junio's desire for a broader functionality of the
`alternate object database` (is it that, or an ext repo?), I still felt
that given the new and improved functionality, it would need some extra
text to go into the documentation and man pages, along with a short
abstract to go into the release notes. Somehow the prospective users
(e.g. me) would need to be told - I.e. be able to read from the man
pages what to expect.

The commit messages also didn't really bring out where the benefit would
be seen i.e. the cgit display (as per your screen shot). Also some
annotation of the screen shot with an arrow pointing to what was 'new'
could help.

Also you didn't really explain the point you make above about the
"shared machine", which cuts across the normal "personal machine" view
of the 'distributed' in DVCS.

>
> I think my patches are a good cleanup regardless of motivation and
> everything was fairly well documented in the changelogs, so I'm
> surprised to see skepticism in the git community.

In a sense, I hear your frustration. It does feel common that that every
knife has to be converted to scissors (two knives working together) or a
multi-tool Swiss Army knife, and in some cases loosing the original
'obviousness' of a simple thing done well.

A first step may be to write out "what would the man pages say" that
explains how the the `alternate object database` is used and set up, and
then maybe look at whether Junio's example, to see if you have explained
this new capability well enough.

I hope that helps clarify my original comments.

Philip
