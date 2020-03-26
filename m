Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313A6C43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 00:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 112AB20719
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 00:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbgCZAS3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 20:18:29 -0400
Received: from mx.sdf.org ([205.166.94.20]:49855 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727498AbgCZAS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 20:18:28 -0400
Received: from sdf.org (IDENT:lkml@faeroes.freeshell.org [205.166.94.9])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02Q0IMt3012029
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Thu, 26 Mar 2020 00:18:22 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02Q0ILT5005394;
        Thu, 26 Mar 2020 00:18:21 GMT
Date:   Thu, 26 Mar 2020 00:18:21 +0000
From:   George Spelvin <lkml@SDF.ORG>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        lkml@sdf.org
Subject: Re: Feature request: rebase -i inside of rebase -i
Message-ID: <20200326001821.GB8865@SDF.ORG>
References: <20200320223015.GA19579@SDF.ORG>
 <xmqq36a2bpxz.fsf@gitster.c.googlers.com>
 <20200320233528.GB19579@SDF.ORG>
 <nycvar.QRO.7.76.6.2003211135380.46@tvgsbejvaqbjf.bet>
 <20200321175612.GC19579@SDF.ORG>
 <nycvar.QRO.7.76.6.2003252008490.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2003252008490.46@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 25, 2020 at 08:26:48PM +0100, Johannes Schindelin wrote:
> On Sat, 21 Mar 2020, George Spelvin wrote:
>> My assumption has been that, for simplicity, there would only be one
>> commit in progress, and aborting it aborts everything.
>
> But that does not necessarily make sense. Imagine that you rebase the
> latest three commits, interactively. Then a merge conflict in the third
> makes you realize that the first commit is no longer needed.
> 
> Enter the nested rebase. You manually re-schedule the failed `pick` via
> `git rebase --edit-todo` and then run the nested rebase: `git reset --hard
> && git rebase -i --nested HEAD~2`.
> 
> Except that you made a typo and said `HEAD~3` instead of `HEAD~2`. You
> delete the entire todo list to get a chance to restart the nested rebase.
> 
> But now the entire rebase gets aborted?

Um, this example is not persuasive.  If I just leave the excess commit at 
the front of the to-do list, then it will be recreated without change.

(Note that if I choose too *small* a nubmer by accident, I can insert a 
"break" at the front of the list and then rebase --nested starting from 
there.)

Okay, but what if I screw up worse and type HEAD^55 instead of HEAD^5?
nd that includes multiple merges and other messy stuff?

Well, perhaps a general-purpose optimization could be applied: for the 
first, mandatory, edit-todo, don't actually check out the tree until the 
edit is complete.  When it is, chop off any prefix of unaltered commits 
and start the rebase at the first change.

That would make inadvertently specifying a start point too far back
reasonably harmless.

It would also provide one level of nested abort in the case of a nested 
rebase.  Until you save the initial todo, the rebase doesn't do anything 
except some bookkeeping.  So you could have that be a special case, 
without providing a more general nested --abort.

The main problem with a full nested rebase is that you need to define when 
the inner rebase completes and the outer rebase resumes.  I very much 
want the ability to move commits around between the outer rebase and the 
inner one, which makes that distinction ill-defined.

> If that would happen to me, I would unleash a whole slew of rarely used
> words in the vague direction of whoever implemented the nested rebase
> feature...

The thing is, it's already quite possible to make a mess of a rebase
halfway through and need to abort after you've put a lot of work in.

I think a more general-purpose recovery mechanism might be more
useful.

For example, if the --edit-todo included a (commented-out) list of what 
had already been done, then after realizing that you screwed up
conflict resolve b' and have now committed bad resolutions c' and d'
on top of it, you could easily rebase --nested and replace b', c' and d'
with the original b, c and d.

Without aborting and throwing away a' as well, which was perhaps a lot of
work.

>> If I delete any of those five commits, then rebase.missingCommitsCheck
>> will trigger.  If I put y in the list, save it, then change my mind and
>> --edit-todo and delete y, it will also trigger.
> 
> As I said, I am not using that feature myself, so I do not even know what
> "trigger" means in this context. It might totally be okay to use the
> existing code as-is in the context of a nested rebase. That remains to be
> verified, though, I think.

What I mean by "trigger" is thatthe check would notice a missing commit
and produce a warning or error, as configured.
