Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADC5C7618D
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 14:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239501AbjDFOu3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 10:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239654AbjDFOuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 10:50:09 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282F4B462
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 07:49:04 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 3416D2418A;
        Thu,  6 Apr 2023 10:49:02 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pkQv7-TQr-00; Thu, 06 Apr 2023 16:49:01 +0200
Date:   Thu, 6 Apr 2023 16:49:01 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH] rebase: implement --rewind
Message-ID: <ZC7b3QjRTQ2k7bhf@ugly>
Mail-Followup-To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
References: <20230323162235.995645-1-oswald.buddenhagen@gmx.de>
 <7bd63d7e-ad13-d5b8-54ea-ba5f81da0c17@gmx.de>
 <ZCMRpnS9gzN1Rlbh@ugly>
 <4fa6d2da-4885-09d9-dddb-6f19efda6398@gmx.de>
 <ZC2Qhi73YKSOJrM2@ugly>
 <230406.86zg7ls2jx.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <230406.86zg7ls2jx.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 06, 2023 at 12:45:02PM +0200, Ævar Arnfjörð Bjarmason wrote:
>My most common use-case for "nested" is certainly less complex that
>Johannes's, and is the following:
>
> * I've got e.g. a 10 patch series
>
> * I start rebasing that on "master", solve conflicts with "1..4", and
>   am now on a conflict on 5/10.
>
> * It now becomes obvious to me that the even larger conflict I'm about
>   to have on 6/10 would be better handled if I went back to 2/10 or
>   whatever, did a change I could do here in 5/10 differently, and then
>   proceeded.
>
>I.e. when I'm at 5/10 I'd conceptually like to do another "git rebase 
>-i
>HEAD~5" or whatever, use the *already rewritten* commits (otherwise I'd
>just abort and restast), re-arrange/rewrite them, and when I'm done
>return to 5/10.
>
yes, this patch addresses this use case - mostly.

i'm generally dealing with an even more benign case, because i'm 
"rebasing" with --keep-base most of the time (and i have the thing 
aliased to 'reshape' - maybe something for upstream?).

the case of rewinding from a conflicted state currently needs manual 
handling. i suppose i should detect the state, re-insert the pick, and 
reset hard out of it, as if --skip was used. the implicit 
destructiveness feels wrong, though. maybe require --force?

>But here's the important bit: Sometimes I'm just wrong about my re-edit
>to 2/10 being the right thing, and it would actually just make things
>worse, as I might discover in my "nested" rebase once I'm at 4/5 or
>whatever.
>
>So being able to do an "--abort" ot that point to go back to the
>"un-nested" 5/10 (*not* "original" 5/10) and proceed from there would be
>nice.
>
yeah, i'm experiencing that sometimes, but not often enough to bother 
automating it. manual recovery by hand-editing the todo after rewinding 
again did the trick so far.

>From a UX perspective I think just as our $PS1 integration can be made
>to show "5/10" it would be ideal if in this case we could show
>e.g. "5/10 -> 1/5" or whatever. I.e. I'm in a nested rebase of 1/5,
>which started from that 5/10".
>
hmm, i think you just pointed out johannes' hangup to me. ^^

you both are assuming a limited rewind, where you explicitly specify the 
affected range, and the todo list editor presents only that. you're 
deriving the term "nested" from the fact that it's an isolated subset of 
the rewritten commits.

however, i see these problems with that aproach:
- as mentioned in the OP, i might want to move hunks out of the nested 
   range. i could stash them, but then i'm dealing with two methods of 
   organizing the history, which gets really messy
- it gets even trickier if i want to move commits *into* the nested 
   range - i'd have to manually insert a pick, and then deal with the 
   possible conflict after unnesting
- who says that the nesting point should be the last chance to change my 
   mind? suppose i stop at 10, get the idea to re-edit 5, but after 
   reaching 15 i notice that re-editing 5 (and thus probably also 10)  
   was a terrible idea, so i want to go back to pre-nest 10

now suppose my approach, where the rebase is rewound right to `onto`, 
and the whole remaining todo is left in place. the nested base is 
implicitly determined by the first modified line of the rewound todo, so 
there is no harm in rewinding the whole rebase (*). and the rebase can 
just continue past the rewind point without anything special happening.  

if we want to be able to undo the rewind, we push HEAD and the todo list 
onto a stack. as phillip said, that's basically just a checkpoint, which 
happens to be automatically created when we are rewinding. that could be 
presented at the prompt as "REBASE 5/10 [1]" to signify the number of 
available checkpoints (and you'd access them with 'git rebase --restore 
[<id>]', quite similarly to stashes).

of course it gets really "interesting" when you want to go back to a 
checkpoint, but also want to salvage some of the rewritten commits. then 
you'll have to manually pick commits from the reflog, etc., but i don't 
see how one could possibly get around the complexity (we could present a 
combined todo file where alternative versions of commits are shown in 
comments, but that's quite some effort for only a slight improvement).

(*) actually, there is:
- firstly, having the entire todo in front of you can be rather annoying 
   when it's more than two dozen commits long and the part you want to 
   edit isn't near the beginning.
- secondly, skipping over merges doesn't appear to be a thing, so 
   johannes' use case would be *insanely* slow. but that's "only" an 
   implementation issue.

given these problems, i can see that it would make sense to accept an 
optional argument that limits the depth of the rewind (without impacting 
the overall approach).

thanks!
