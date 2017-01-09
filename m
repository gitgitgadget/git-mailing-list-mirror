Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3AF71FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 16:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034911AbdAIQSF (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 11:18:05 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:37200 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030406AbdAIQR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 11:17:59 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7C801612F2; Mon,  9 Jan 2017 16:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1483978678;
        bh=pr9qPPODxiAuFYY9Kt7B0KkH4fff4XmKVq3O5ythDs0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UdX6sNkZqbzb/WvSyjjJ/9cDtMMbKNOb+irCKwpHMtu3pcAcLio7SI1aFeQ2gMwhi
         wm/a1E5zhRAMtDn99V2cghbxxZBcuKBlhGJCchhTKcb53gMQNKV4Aayma51wVVhpAg
         VPpURrNkekyDc6O32zV3jHvwUmzD9w7LHS+0Oweg=
Received: from mfick1-lnx.localnet (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mfick@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8F94D612F2;
        Mon,  9 Jan 2017 16:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1483978677;
        bh=pr9qPPODxiAuFYY9Kt7B0KkH4fff4XmKVq3O5ythDs0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jb481TNWQx2wTCFfFjP97Y9MHf//YcUju3u8R+QT3e4x0VzfyC+z2d4Q/v5DZTdmV
         YOMA9COG736ExczhPMbhuVaJaQZsEnmZ0XxsK784SQdUFzAETnn83rNToHD19wXDir
         Yn2Mg7vqZiF6p0Yv9TdlpIp9Y1q0zZyLYTgKGqOk=
DMARC-Filter: OpenDMARC Filter v1.3.1 smtp.codeaurora.org 8F94D612F2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=pass smtp.mailfrom=mfick@codeaurora.org
From:   Martin Fick <mfick@codeaurora.org>
To:     Jeff King <peff@peff.net>
Cc:     repo-discuss@googlegroups.com, jmelvin@codeaurora.org,
        jgit-dev@eclipse.org, git@vger.kernel.org
Subject: Re: Preserve/Prune Old Pack Files
Date:   Mon, 09 Jan 2017 09:17:56 -0700
Message-ID: <1802755.dVE0WDQbpH@mfick1-lnx>
User-Agent: KMail/4.8.5 (Linux/3.2.0-106-generic; KDE/4.8.5; x86_64; ; )
In-Reply-To: <20170109062137.zghmurndlbts5x44@sigill.intra.peff.net>
References: <24abd0ed58c25ce832014f9bd5bb2090@codeaurora.org> <5172470.bsscxDU4yv@mfick1-lnx> <20170109062137.zghmurndlbts5x44@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Monday, January 09, 2017 01:21:37 AM Jeff King wrote:
> On Wed, Jan 04, 2017 at 09:11:55AM -0700, Martin Fick 
wrote:
> > I am replying to this email across lists because I
> > wanted to highlight to the git community this jgit
> > change to repacking that we have up for review
> > 
> >  https://git.eclipse.org/r/#/c/87969/
> > 
> > This change introduces a new convention for how to
> > preserve old pack files in a staging area
> > (.git/objects/packs/preserved) before deleting them.  I
> > wanted to ensure that the new proposed convention would
> > be done in a way that would be satisfactory to the git
> > community as a whole so that it would be more easy to
> > provide the same behavior in git eventually.  The
> > preserved pack files (and accompanying index and bitmap
> > files), are not only moved, but they are also renamed
> > so that they no longer will match recursive finds
> > looking for pack files.
> It looks like objects/pack/pack-123.pack becomes
> objects/pack/preserved/pack-123.old-pack,

Yes, that's the idea.

> and so forth. Which seems reasonable, and I'm happy that:
> 
>   find objects/pack -name '*.pack'
> 
> would not find it. :)

Cool.

> I suspect the name-change will break a few tools that you
> might want to use to look at a preserved pack (like
> verify-pack).  I know that's not your primary use case,
> but it seems plausible that somebody may one day want to
> use a preserved pack to try to recover from corruption. I
> think "git index-pack --stdin
> <objects/packs/preserved/pack-123.old-pack" could always
> be a last-resort for re-admitting the objects to the
> repository.

or even a simple manual rename/move back to its orginal 
place?

> I notice this doesn't do anything for loose objects. I
> think they technically suffer the same issue, though the
> race window is much shorter (we mmap them and zlib
> inflate immediately, whereas packfiles may stay mapped
> across many object requests).

Hmm, yeah that's the next change, didn't you see it? :)  No, 
actually I forgot about those.  Our server tends to not have 
too many of those (loose objects), and I don't think we have 
seen any exceptions yet for them.  But, of course, you are 
right, they should get fixed too.  I will work on a followup 
change to do that.

Where would you suggest we store those?  Maybe under 
".git/objects/preserved/<xx>/<sha1>"?  Do they need to be 
renamed also somehow to avoid a find?

...
> I've wondered if we could make object pruning more atomic
> by speculatively moving items to be deleted into some
> kind of "outgoing" object area.
...
> I don't have a solution here.  I don't think we want to
> solve it by locking the repository for updates during a
> repack. I have a vague sense that a solution could be
> crafted around moving the old pack into a holding area
> instead of deleting (during which time nobody else would
> see the objects, and thus not reference them), while the
> repacking process checks to see if the actual deletion
> would break any references (and rolls back the deletion
> if it would).
> 
> That's _way_ more complicated than your problem, and as I
> said, I do not have a finished solution. But it seems
> like they touch on a similar concept (a post-delete
> holding area for objects). So I thought I'd mention it in
> case if spurs any brilliance.

I agree, this is a problem I have wanted to solve also.  I 
think having a "preserved" directory does open the door to 
such "recovery" solutions, although I think you would 
actually want to modify the many read code paths to fall 
back to looking at the preserved area and performing 
immediate "recovery" of the pack file if it ends up being 
needed.  That's a lot of work, but having the packs (and 
eventually the loose objects) preserved into a location 
where no new references will be built to depend on them is 
likely the first step.  Does the name "preserved" do well for 
that use case also, or would there be some better name, what 
would a transactional system call them?

Thanks for the review Peff!

-Martin


-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation

