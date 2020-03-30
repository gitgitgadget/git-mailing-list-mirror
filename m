Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A7BC2D0EB
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 18:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F1EE206F6
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 18:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgC3SSc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 14:18:32 -0400
Received: from mx.sdf.org ([205.166.94.20]:59710 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgC3SSb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 14:18:31 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02UIIC3R022799
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Mon, 30 Mar 2020 18:18:12 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02UIICGB001653;
        Mon, 30 Mar 2020 18:18:12 GMT
Date:   Mon, 30 Mar 2020 18:18:12 +0000
From:   George Spelvin <lkml@SDF.ORG>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        lkml@sdf.org
Subject: Re: Feature request: rebase -i inside of rebase -i
Message-ID: <20200330181812.GB9199@SDF.ORG>
References: <20200320223015.GA19579@SDF.ORG>
 <xmqq36a2bpxz.fsf@gitster.c.googlers.com>
 <20200320233528.GB19579@SDF.ORG>
 <nycvar.QRO.7.76.6.2003211135380.46@tvgsbejvaqbjf.bet>
 <20200321175612.GC19579@SDF.ORG>
 <nycvar.QRO.7.76.6.2003252008490.46@tvgsbejvaqbjf.bet>
 <20200326001821.GB8865@SDF.ORG>
 <nycvar.QRO.7.76.6.2003281510260.46@tvgsbejvaqbjf.bet>
 <0eef4721-1646-48f2-1102-71159d06b049@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0eef4721-1646-48f2-1102-71159d06b049@iee.email>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 30, 2020 at 03:01:28PM +0100, Philip Oakley wrote:
> Perhaps we can go the other way on this one.
> 
> I'd agree that attempting to nest (misunderstood mistaken) rebases is
> digging a too deep hole that we'd not get out of. However we do have
> other rebases available, specifically the "rebasing merges"
> https://git-scm.com/docs/git-rebase#_rebasing_merges.
> 
> I know rebasing merges is way down the man page, but it has all the
> power and flexibility needed _if_ we can step across from the mistaken
> rebase step (we are at the command prompt aren't we?) into the rebasing
> merge mode.
> 
> This will require a little bit of expansion of the insn (instruction)
> sheet so as to _include commented lines of the rebase steps completed_
> so far, along with the labels, resets, merges, etc, so that the user can
> _see_ where they they are within their failed progress (along with a
> title line telling them their initial command and that they are now on a
> rebasing merge insn;-).
> 
> From there they can update the insn to reset back to the correct point,
> redo the correct picks, and then get back to their remaining rebase steps.
> 
> It's a thought anyway.

I'm confused.  *How* does --rebase-merge mode help?  You're saying
"hey, if we use this, it solves the issue" but I don't see how to
pound this nail with that screwdriver.

I don't see how creating a branching history helps, and I don't see how to 
use the reset/label/merge commands to do anything but create a branching 
history.

I suppose it is possible to use the "reset" command in isolation
to describe the jump to a new base.  So you could have a history of:

# Command already executed:
# reset base
# pick A
# pick B
# pick C
# label rebase-1  User asked for a nested rebase
# reset A'

# Commands pending:
pick B'
pick C'
# rebase-2 complete, resume rebase-1
pick D
pick E

Is that what you were getting at?

I was thinking of it being implicit, but it might be nice for the initial
"reset" in each rebase to be explicit, *and not yet executed during
the initial todo edit*.

That makes it really clear that deleting the todo list entirely
results in no change to the tree.
