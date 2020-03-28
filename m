Return-Path: <SRS0=KP1k=5N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A237C43331
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 16:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6279206F6
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 16:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgC1Qah (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:30:37 -0400
Received: from mx.sdf.org ([205.166.94.20]:52107 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbgC1Qah (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Mar 2020 12:30:37 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02SGUOWR023036
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sat, 28 Mar 2020 16:30:24 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02SGUOBa001954;
        Sat, 28 Mar 2020 16:30:24 GMT
Date:   Sat, 28 Mar 2020 16:30:24 +0000
From:   George Spelvin <lkml@SDF.ORG>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        lkml@sdf.org
Subject: Re: Feature request: rebase -i inside of rebase -i
Message-ID: <20200328163024.GA26885@SDF.ORG>
References: <20200320223015.GA19579@SDF.ORG>
 <xmqq36a2bpxz.fsf@gitster.c.googlers.com>
 <20200320233528.GB19579@SDF.ORG>
 <nycvar.QRO.7.76.6.2003211135380.46@tvgsbejvaqbjf.bet>
 <20200321175612.GC19579@SDF.ORG>
 <nycvar.QRO.7.76.6.2003252008490.46@tvgsbejvaqbjf.bet>
 <20200326001821.GB8865@SDF.ORG>
 <nycvar.QRO.7.76.6.2003281510260.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2003281510260.46@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 28, 2020 at 03:25:06PM +0100, Johannes Schindelin wrote:
> There are _many_ ways to mess up a nested rebase, including (but not
> limited to) `--onto`, forgetting `-r`, editing the todo list too much in
> an editor without undo.
> 
> If you are suggesting that a nested `git rebase -i` would not need a way
> to abort _just_ the nested rebase, then I fear we must stop the
> conversation right here. That's not going to fly.

Yes, I'm seriously suggesting that.  My arguments are:

* The benefit is limited, because you can do pretty much all the
  same things with just plain --edit-todo, and I don't see the
  point of handing the user a loaded gun and ensuring they can't
  shoot themselves in their *left* foot.

* The cost in implementation complexity is considerable.  Even the
  *semantics* are awkward.  In particular, if you reorder patches
  between the outer and inner rebases, how do you define the end of
  the inner rebase?

Now, I *did* agree that being able to abort just the nested rebase
*from the initial todo edit* is useful and achievable.  That can
be handled as a special case.  It's allowing "git rebase --abort"
from halfway throuigh the nested rebasethat introduces all kinds
of hair.

>> The main problem with a full nested rebase is that you need to define when
>> the inner rebase completes and the outer rebase resumes.  I very much
>> want the ability to move commits around between the outer rebase and the
>> inner one, which makes that distinction ill-defined.
> 
> That probably means that we have not thought through the problem, at least
> not enough. If we have nested levels, then we might need to record those
> nested levels, including the equivalent of `ORIG_HEAD`, `onto` and the
> todo list. And of course make them accessible to the user.

I worry that's too much conceptual complexity being foisted on the user.

> Mind you: I do not necessarily request a perfect design. I just don't want
> to slam the door shut when it comes to more sophisticated use cases. I
> _really_ would like to have a way to "just redo the latest 5 commands",
> for example, but I have no illusion about getting that any time soon.

The big use cases I see are:
- Wanting to back up in the current rebase, "quilt pop" style.
  Many times I've found a hunk in patch #4 that should have been
  part of patch #2.
- Wanting to move the base back a bit further than originally
  planned.  (This is often an alternate form of the preceeding;
  I find a hunk that should have been in patch #-2.)
- Wanting to rearrange commits across the current commit.  I've
  gone and edited patch #4 and introduced a dependency on patch #7.
  I want to move patch #7 back so that my revised #4 can be tested.

I think of the feature as an "edit-todo" that includes some already-
applied patches.

>> The thing is, it's already quite possible to make a mess of a rebase
>> halfway through and need to abort after you've put a lot of work in.
> 
> Tell me about it!

Thus, my comment above about protecting the user's left foot.  If
they still need to be careful to not shoot off their right foot,
are we saving them any mental effort?

My goal for the nested-rebase feature is that it can be useful for
*recovering* from such messes.  Back up a few steps to before the
trouble started, but *not* a full abort.

>> I think a more general-purpose recovery mechanism might be more
>> useful.
>>
>> For example, if the --edit-todo included a (commented-out) list of what
>> had already been done, then after realizing that you screwed up
>> conflict resolve b' and have now committed bad resolutions c' and d'
>> on top of it, you could easily rebase --nested and replace b', c' and d'
>> with the original b, c and d.
>>
>> Without aborting and throwing away a' as well, which was perhaps a lot of
>> work.
> 
> We do have the `done` file, but that does not discern between commands
> in the todo list that have been there in the first place and commands that
> have been added by the user _during_ the rebase. And of course it does not
> reflect any commands that have been removed/changed by the user during the
> rebase.
> 
> So yeah, something like a journal, maybe.

I was thinking of the "done" file.  At a low level, we already have
the reflog, and giving the user yet another transaction log to remember
is undesirable.

If we just added the original commit ID to the automatically
generated reflog entry, si it also records the higher-level intention,
that might do it.  I.e. change

bc56134cfe278 HEAD@{3}: rebase (pick): wilc1000: Use crc7 in lib/ rather than a private copy
	to
bc56134cfe278 HEAD@{3}: rebase (pick 01cb7b5b7851): wilc1000: Use crc7 in lib/ rather than a private copy

Oh!  What if we recorded, for the duration of the rebase, the todo
list state corresponding to reflog entries?  (Or, equivalently,
the reflog state at each step through the todo list.)  Then we
could back up the rebase with just a reflog entry pointer.

I like this precisely because it doesn't give the user a new entity
to keep track of; it just makes an existing entity more useful.

> Thank you for thinking about this feature, and for discussing it with me.
> I think it will be a really nice feature to have, and I want to avoid
> problems with a design that simply won't allow for certain use cases
> (remember how `git rebase --preserve-merges` does not allow for reordering
> commits, and how the design of that feature simply made this bug
> unfixable? I _dearly_ regret not thinking that through).

Definitely, let's think it through.  But remember that "perfection
is achieved, not when there is nothing more to add, but when there
is nothing left to take away."  KISS is a design *goal*, not just
a necessary compromise.
