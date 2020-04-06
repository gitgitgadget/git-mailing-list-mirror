Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD98C2BA17
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 15:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AAA721473
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 15:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbgDFPZF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 11:25:05 -0400
Received: from mx.sdf.org ([205.166.94.20]:58809 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728736AbgDFPZE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 11:25:04 -0400
Received: from sdf.org (IDENT:lkml@rie.sdf.org [205.166.94.4])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 036FOpkg017794
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Mon, 6 Apr 2020 15:24:51 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 036FOpVk014045;
        Mon, 6 Apr 2020 15:24:51 GMT
Date:   Mon, 6 Apr 2020 15:24:50 +0000
From:   George Spelvin <lkml@SDF.ORG>
To:     Sebastien Bruckert <sbruckert.dev@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        lkml@sdf.org
Subject: Re: Feature request: rebase -i inside of rebase -i
Message-ID: <20200406152450.GA9609@SDF.ORG>
References: <20200320233528.GB19579@SDF.ORG>
 <nycvar.QRO.7.76.6.2003211135380.46@tvgsbejvaqbjf.bet>
 <20200321175612.GC19579@SDF.ORG>
 <nycvar.QRO.7.76.6.2003252008490.46@tvgsbejvaqbjf.bet>
 <20200326001821.GB8865@SDF.ORG>
 <nycvar.QRO.7.76.6.2003281510260.46@tvgsbejvaqbjf.bet>
 <20200328163024.GA26885@SDF.ORG>
 <nycvar.QRO.7.76.6.2004041417420.46@tvgsbejvaqbjf.bet>
 <20200404174116.GB11944@SDF.ORG>
 <CA+KXf2C0XytyNEAAdTOZAzw5YTQuv3PSjJ7RgyWqTj9MPp6BDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+KXf2C0XytyNEAAdTOZAzw5YTQuv3PSjJ7RgyWqTj9MPp6BDQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 06, 2020 at 06:40:07AM -0400, Sebastien Bruckert wrote:
> What is your problem actually ? You want to edit a commit before where
> you are in a rebase ?
> 
> O --- A --- B --- C --- D
> * You are in a middle of a rebase at commit C.
> * You want to edit A without finishing all your actual rebase.
> 
> Is that right ?
> 
> Then, why making a whole new rebase for that operation ?

Actually, it's a *bit* more complicated.  I came across the need while 
preparing a large patch series for submission.  I was going through the 
series, making sure the patches were in a logical order and didn't contain 
junk like an edit that should have been a fixup to an ealier patch.

(Quite often, as I'm writing comments describing a new function,
I tweak the comments later.)

If I only want to fix up an old patch, I can make a fixup patch and merge 
it in in a later pass.  If I want to edit the commit message again, I 
can't make the change and have git remember it for me, but I can at least 
make a a (possibly empty) squash commit with a note about the change.

The hairy part comes when I'm doing a lot of reordering, and I realize 
that oh, damn it, commit C really should come before A in the patch 
series.  (Or maybe C should be split and *part* of it should
come before A.)

I don't want to abort the rebase and restart, because I've already put a 
lot of work into rebasing A and B.  (Which are each multiple patches, 
simplified to one for this explanation.)  I've rearranged patches, 
changed function names and prototypes, and resolved the 
resultant conflicts.

Just finishing up the rebase and restarting is a PITA, because I'll have 
more conflicts in D to resolve (again, D is not just a single commit), 
which will take some thinking, and by the time I"ve done all that I've 
forgotten what I was doing with C.

What I'd like to do is just back up a few steps in the current
rebase, put C there, and then resume rebasing D.

Instead, I end up writing myself a note and, at the conclusion of
the current rebase, starting a second one to apply the additional
changes.

> In this example, you are finally editing A with some sort of new
> nested operation. This operation should not do anything else than
> this. Like something atomical, you edit the commit / add a commit /
> remove one, and that's all. End of the story. Back to the original
> rebase, and back to commit C. If that "nested" operation  made
> conflict with B, we can move the actual rebase to B to clean the mess
> you made with the "nested" operation. But you are still in only one
> rebase. If you abort, everything gets cleaned up.
> 
> I don't know if any of this is pertinent / understandable, but I hope
> it gave a fresh view on that. You guys are maybe a bit too focused on
> what to do in case of an abort of a nested rebase. However, we don't
> actually know if a nested rebase is the best solution for this job.

This sounds a lot like my original (and still preferred) design: it's not 
really a nested transaction in the database sense (which can be aborted 
independent of the outer commit), it's just one rebase that I rewind.

I think a full nested transaction is too much conceptual complexity. And 
my primary use case is rearranging commits, so I want to move commits 
between the "outer" and "inner" rebase, which makes defining the boundary 
of the inner rebase problematic.

But Johannes Schindelin seems quite forcefully opposed to the lack of a 
nested abort, so we're hashing it out.

I'm very interested in your opinion, but please note that we already have 
fixup commits for amending single commits in place.

The problem that currently has no good solution arises when I realize 
halfway through a cleanup pass that things would be a lot simpler if I 
moved A to after C. "Hey, rather than adding A and then updating it to 
take C into account, how about I just do commit C first, and then add the 
final code of A in one step?"  That is, I want to change from O-A-B-C-D to 
O-B-C-A-D, but I didn't think of it until the rebase had reached O-A-B-C-.

I think of it as "quilt pop" operation, taking patches off the
applied list and putting them back on the todo.
