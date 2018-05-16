Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C24A01F406
	for <e@80x24.org>; Wed, 16 May 2018 20:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751474AbeEPUn1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 16:43:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39418 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbeEPUn0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 16:43:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 603DB609D1; Wed, 16 May 2018 20:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1526503406;
        bh=GycvxIeCDNwRVZdy21rZmSQ78OWj388Vtp98QD2Gmj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YWlR4PpaeHFJL39+EH9B3IDa0VGUGEUDB35LMy4w0UfuTMsIazjzevL17DXsIWjrc
         RX6Drqu1oRPNn3REHK9my6RMHZiUZAxmZrJQGgXgdP6dsTFWAu0vlNkUFmfLjpzlQo
         CVpXT1T7B/BPNKpNcPlFBtX0Faab+J/T1pyV2Ovk=
Received: from mfick-lnx.localnet (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mfick@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 798F160541;
        Wed, 16 May 2018 20:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1526503405;
        bh=GycvxIeCDNwRVZdy21rZmSQ78OWj388Vtp98QD2Gmj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cq3J6qCS8IvyVA3lC4jmMf8YWuBgulWKTCtkQwJfAx17Yb7t8gy1xquZ90DPNEjcr
         ZJzkrtivaHM+yAQ4Q/46a/WLiaa4JXfDpBipliXlhfEWtt83vk4Q+4zr66bkgZterf
         ItakUG352f34QSIsJYKUh48dctDplJkJtzrS7lrw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 798F160541
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mfick@codeaurora.org
From:   Martin Fick <mfick@codeaurora.org>
To:     Jeff King <peff@peff.net>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
Subject: Re: worktrees vs. alternates
Date:   Wed, 16 May 2018 14:43:24 -0600
Message-ID: <2848918.IL6YjaUS5T@mfick-lnx>
User-Agent: KMail/4.13.3 (Linux/3.13.0-144-generic; KDE/4.13.3; x86_64; ; )
In-Reply-To: <20180516200658.GC4036@sigill.intra.peff.net>
References: <A33442B1-B37D-42E1-9C58-8AB583A43BC9@gmail.com> <42435260.5sd4EuToWN@mfick-lnx> <20180516200658.GC4036@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday, May 16, 2018 01:06:59 PM Jeff King wrote:
> On Wed, May 16, 2018 at 01:40:56PM -0600, Martin Fick 
wrote:
> > > In theory the fetch means that it's safe to actually
> > > prune in the mother repo, but in practice there are
> > > still races. They don't come up often, but if you
> > > have enough repositories, they do eventually. :)
> > 
> > Peff,
> > 
> > I would be very curious to hear what you think of this
> > approach to mitigating the effect of those races?
> > 
> > https://git.eclipse.org/r/c/122288/2
> 
> The crux of the problem is that we have no way to
> atomically mark an object as "I am using this -- do not
> delete" with respect to the actual deletion.
> 
> So if I'm reading your approach correctly, you put objects
> into a purgatory rather than delete them, and let some
> operations rescue them from purgatory if we had a race. 

Yes.  This has the cost of extra disk space for a while, but 
once I realized that we are incurring that cost already 
because for our repos, we already put things into purgatory 
to avoid getting stale NFS File handle errors during 
unrecoverable paths (while streaming an object).  So 
effectively this has no extra space cost then what is needed 
to run safely on NFS.

>   1. When do you rescue from purgatory? Any time the
> object is referenced? Do you then pull in all of its
> reachable objects too?

For my approach, I decided a) Yes b) No

Because:

a) Rescue on reference is cheap and allows any other policy 
to be built upon it, just ensure that policy references it 
at some point before it is prune from the purgatory.

b)  The other referenced objects will likely get pulled in 
on reference anyway or by virtue of being in the same pack.

>   2. How do you decide when to drop an object from
> purgatory? And specifically, how do you avoid racing with
> somebody using the object as you're pruning purgatory?

If you clean the purgatory during repacking after creating 
all the new packs and before deleting the old ones, you will 
have a significant grace window to handle most longer running 
operations.  In this way, repacking will have re-referenced 
any missing objects from the purgatory before it gets pruned 
causing them to be recovered if necessary.  Those missing 
objects, believed to be in the exact packs in the purgatory 
at that time, should only ever have been referenced by write 
operations that started before those packs were moved to the 
purgatory, which was before the previous repacking round 
ended.  This leaves write operations a full repacking cycle 
to complete in to avoid loosing objects.

>   3. How do you know that an operation has been run that
> will actually rescue the object, as opposed to silently
> having a corrupted state on disk?
> 
>      E.g., imagine this sequence:
> 
>        a. git-prune computes reachability and finds that
> commit X is ready to be pruned
> 
>        b. another process sees that commit X exists and
> builds a commit that references it as a parent
> 
>        c. git-prune drops the object into purgatory
> 
>      Now we have a corrupt state created by the process in
> (b), since we have a reachable object in purgatory. But
> what if nobody goes back and tries to read those commits
> in the meantime?

See answer to #2, repacking itself should rescue any objects 
that need to be rescued before pruning the purgatory.

> I think this might be solvable by using the purgatory as a
> kind of "lock", where prune does something like:
> 
>   1. compute reachability
> 
>   2. move candidate objects into purgatory; nobody can
> look into purgatory except us

I don't think this is needed.

It should be OK to let others see the objects in the 
purgatory after 1 and before 3 as long as "seeing" them, 
causes them to be recovered!

>   3. compute reachability _again_, making sure that no
> purgatory objects are used (if so, rollback the deletion
> and try again)

Yes, you laid out the formula, but nothing says this 
recompute can't wait until the next repack (again see my 
answer to #2)!  i.e. there is no rush to cause a recovery as 
long as it gets recovered before it gets pruned from the 
purgatory.


> But even that's not quite there, because you need to have
> some consistent atomic view of what's "used". Just
> checking refs isn't enough, because some other process
> may be planning to reference a purgatory object but not
> yet have updated the ref. So you need some atomic way of
> saying "I am interested in using this object".

As long as all write paths also read the object first (I 
assume they do, or we would be in big trouble already), then 
this should not be an issue.  The idea is to force all reads 
(and thus all writes also) to recover the object,

-Martin

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation

