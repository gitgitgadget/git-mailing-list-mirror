Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78DAF20A40
	for <e@80x24.org>; Wed, 29 Nov 2017 19:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751982AbdK2TLH (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 14:11:07 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:28615 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751443AbdK2TLF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 14:11:05 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3yn99g0qklz5tlK;
        Wed, 29 Nov 2017 20:11:03 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 9B197211E;
        Wed, 29 Nov 2017 20:11:02 +0100 (CET)
Subject: Re: [SCRIPT/RFC 0/3] git-commit --onto-parent (three-way merge, no
 working tree file changes)
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
Cc:     git@vger.kernel.org, Nikolay Shustov <nikolay.shustov@gmail.com>,
        Johannes Schneider <mailings@cedarsoft.com>,
        Patrik Gornicz <patrik-git@mail.pgornicz.com>,
        Martin Waitz <tali@admingilde.org>,
        Shawn Pearce <spearce@spearce.org>,
        Sam Vilain <sam@vilain.net>, Jakub Narebski <jnareb@gmail.com>
References: <8998e832-f49f-4de4-eb8d-a7934fba97b5@gmail.com>
 <d5f243a5-6e35-f3fc-4daf-6e1376bef897@kdbg.org>
 <203a75c8-0c58-253c-2c18-05450f7ae49b@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <ea156b8b-29d8-7501-b5a5-a29cfbd7d1d6@kdbg.org>
Date:   Wed, 29 Nov 2017 20:11:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <203a75c8-0c58-253c-2c18-05450f7ae49b@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.11.2017 um 02:15 schrieb Igor Djordjevic:
> On 27/11/2017 22:54, Johannes Sixt wrote:
>>
>> I my opinion, putting the focus on integration merge commits and the
>> desire to automate the re-merge step brings in a LOT of complexity in
>> the implementation for a very specific use-case that does not
>> necessarily help other cases.
> 
> It might seem more complex than it is, until you examine the guts to
> see how it really works :)
> 
> Basic concept is pretty simple, as I actually don`t automate
> anything, at least not in terms of what would manual user steps look
> like - for example, there`s no real re-merge step in terms of
> actually redoing the merge, I just reuse what was already there in a
> very clean way, I would think (supported by my current, humble
> knowledge, still).
> 
> The only merge that could possibly ever happen is upon committing
> desired subset of changes onto parent, and that shouldn`t be too
> complex by definition, otherwise that commit doesn`t really belong
> there in the first place, if it can`t be meaningfully applied where
> we want it (for now, at least).
> 
> That said, the whole operation of "posting on parent and re-merging
> everything", the way it looks like from the outside, could end just
> with a simple diff-apply-commit-commit internally, no merges at all.
> Only if simple `git apply` fails, we try some trivial merging - and
> all that inside separate (parent) index only, not touching original
> HEAD index nor working tree, staying pristine for the whole process,
> untouched.
> 
> Once done, you should be in the very same situation you started from,
> nothing changed, just having your history tweaked a bit to tell a
> different story on how you got there (now including a commit you
> posted on your HEAD`s parent).

Ok, then please explain, how this process should work in my workflow and 
with the `commit --onto-parent` feature that you have in mind. I have an 
integration branch (which is a throw-away type, so you can mangle it in 
any way you want); it is a series of merges:

  ...A    ...C          <- topics A, C
      \       \
    ---o---o---o---o    <- integration
          /       /
      ...B    ...D      <- topics B, D

Now I find a bug in topic B. Assume that the merges of C and D have 
textual conflicts with the integration branch (but not with B) and/or 
may be evil. What should I do?

With git-post, I make a fixup commit commit on the integration branch, 
then `git post B && git merge B`:

  ...A    ...C                  <- topics A, C
      \       \
    ---o---o---o---o---f---F    <- integration
          /       /       /
      ...B    ...D       /      <- topic D
          \             /
           f'----------'        <- topic B

The merge F does not introduce any changes on the integration branch, so 
I do not need it, but it helps keep topic B off radar when I ask `git 
branch --no-merged` later.

> Don`t let "usual/preferred/recommended" Git workflow distract you too
> much - one of the reasons I made this is because it also allows _kind
> of_ "vanilla Git" patch queue, where you can quickly work on top of
> the merge head, pushing commits onto parents below, being tips of
> your "queues", putting you up to speed without a need to ever switch
> a branch (hypothetically), until satisfied with what you have, where
> you can slow down and polish each branch separately, as usual.
> 
> Like working on multiple branches at the same time, in the manner
> similar to what `git add --patch` allows in regards to working on
> multiple commits at the same time. This just takes it on yet another
> level... hopefully :)

'kay, I'm not eagerly waiting for this particular next level (I prefer 
to keep things plain and simple), but I would never say this were a 
broken workflow. ;)

>> In your scenario above, it would certainly not be too bad if you
>> forgo the automatic merge and have the user issue a merge command
>> manually. The resulting history could look like this:
>>
>> (3)         o---o---A---X    (topicA)
>>             /         \   \
>>            /           M1--M2 (test, HEAD)
>>           /           /||
>>       ---o---o---M---' ||     (master)
>>           \   \       / |
>>            \   o-----B /      (topicB)
>>             \         /
>>              o---o---C        (topicC)
>>
>> I.e., commit --onto-parent A produced commit X, but M2 was then a
>> regular manual merge. (Of course, I am assuming that the merge
>> commits are dispensible, and only the resulting tree is of
>> interest.)
> 
> I see - and what you`re asking for is what I already envisioned and
> hoped to get some more feedback about, here`s excerpt from
> [SCRIPT/RFC 3/3] git-commit--onto-parent.sh[1] (I guess you didn`t
> have time to checked that one yet?):

I did have a brief look, but I stopped when I saw

	# Remove entry from HEAD reflog, not to pollute it with
	# uninteresting in-between steps we take, leaking implementation
	# details to end user.

It's a clear sign for me that's something wrong. It is not just reflogs 
that can become stale, but all operations that follow the `git commit` 
can fail. How do you clean up such a mess?

> 
>    For example, it might make sense to separate commit creation (on
>    current HEAD`s parent) and its actual re-merging into integration
>    test branch, where "--remerge" (or something) parameter would be used
>    on top of "--onto-parent" to trigger both, if/when desired.
>    
>    Another direction to think in might be introducing more general
>    "--onto" parameter, too (or instead), without "parent" restriction,
>    allowing to record a commit on top of any arbitrary commit (other
>    than HEAD). This could even be defaulted to "git commit <commit-ish>"
>    (no option needed), where current "git commit" behaviour would then
>    just be a special case of omitted <commit-ish> defaulting to HEAD,
>    aligning well with other Git commands sharing the same behaviour.
> 
> So I definitely look forward decoupling these two ((1) commit to
> parent and (2) remerge), with enough discussion flowing :)
> 
> Heck, even "to parent" is an artificial/imposed restriction now, in
> reality you could commit on top of any other commit you want (without
> switching branches)... but let`s take one step at a time.
> 
> Just note that omitting the remerge step is what actually makes the
> logic more complex, as we now need to change the original situation,
> too, both HEAD index and working tree, to remove changes which we
> committed elsewhere (without "merging" back in).

The "complex situation" I had in mind was not so much about the user's 
view, but how the implementation has to work when there are errors.

>>From what I understand, your `git-post` makes a commit where you are 
> _and copies_ it over to destination, so you end up with same changes
> in two places (two commits). More, you seem to keep working on top of
> your previous commit(s), which seems logical, later "posting" it
> where desired - so after the fact. It also means you do still have
> all your "fix" commits in HEAD while you work on them (and until you
> git-post and abandon them, discarding the integration branch).

Just to clarify: git-post only copies existing commits, but does not 
make the original itself.

> 
> But `git commit --onto-parent` proposed here does the commit on
> destination only, where later "remerge" is crucial part of still
> keeping that commit changes in the current HEAD working tree as well,
> so you can still keep working on top of them.
> 
> Could it be that you`re looking at `git commit --onto-parent` from an
> unexpected perspective (through your `git-post`, being conceptually
> different)...?

That may be the case. I'm very interested in your answer to my challenge 
above.

-- Hannes
