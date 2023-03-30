Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CD1C761AF
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 13:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjC3NCA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 09:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjC3NB7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 09:01:59 -0400
Received: from mailscanner.iro.umontreal.ca (mailscanner.iro.umontreal.ca [132.204.25.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423D49020
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 06:01:52 -0700 (PDT)
Received: from pmg2.iro.umontreal.ca (localhost.localdomain [127.0.0.1])
        by pmg2.iro.umontreal.ca (Proxmox) with ESMTP id 2C65680800;
        Thu, 30 Mar 2023 09:01:50 -0400 (EDT)
Received: from mail01.iro.umontreal.ca (unknown [172.31.2.1])
        by pmg2.iro.umontreal.ca (Proxmox) with ESMTP id 7F57C80223;
        Thu, 30 Mar 2023 09:01:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iro.umontreal.ca;
        s=mail; t=1680181306;
        bh=vwjQaTCIF6p/HTPCFZ938CzUrGf6Z2obFpEy8P0UWiw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Assnul/2yvQ0pewZ9KmQTylOC3J3/4hdSwjXcW1E3MiPPDbaaqurX+cEZ6DrmZCQS
         qT5Z06vpEsiMwy8Rq+Z6cZ2Ig9IIWwiusw/okUB/V2G/zy8VBnAMcFK/ozdDZyz1ce
         c0o0xW8c9pykbMV9ehTq6AkgpC8rpUsfFkBBcCxixPQTzMRRjSSiz/4cSNx9qVoTm/
         zJIM7dPSAfCRDlYWIlFUzg3xbCTT2uAahQbgFg4uPx7SER4rCfXSwefxXsFda8bqYJ
         iQPIP1Eqxcr/+cwlLZMlIwpVspCMGrjcAvHchoyQoEB6Awxo+EHdsbW4QcUE6FNKMz
         VsjM8+l254WVg==
Received: from pastel (69-196-169-39.dsl.teksavvy.com [69.196.169.39])
        by mail01.iro.umontreal.ca (Postfix) with ESMTPSA id 585B6123358;
        Thu, 30 Mar 2023 09:01:46 -0400 (EDT)
From:   Stefan Monnier <monnier@iro.umontreal.ca>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: `git gc` says "unable to read" but `git fsck` happy
In-Reply-To: <20230329233735.GD2314218@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 29 Mar 2023 19:37:35 -0400")
Message-ID: <jwvfs9mz9n7.fsf-monnier+Inbox@gnu.org>
References: <jwvfs9nusjm.fsf-monnier+Inbox@gnu.org>
        <20230329233735.GD2314218@coredump.intra.peff.net>
Date:   Thu, 30 Mar 2023 09:01:39 -0400
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> How come it can't read `f5e44b38fc8f7e15e5e6718090d05b09912254fa` during
>> "repack" while `git fsck` says everything is fine?
>
> Do you use separate worktrees?

Very much so, indeed!

> It sounds like it might be similar to this case:
>
>   https://lore.kernel.org/git/c6246ed5-bffc-7af9-1540-4e2071eff5dc@kdbg.org/

That's sounds exactly right.  I was actually preparing to file
a separate bug report because of a similar problem I had identified
where a worktree's `index` caused a similar problem (`git fsck` happy
but `git gc` fails) except it was found much earlier in `git gc`,
causing a "bad object" error almost right away.

> If so, there are patches in the current "master" (but not in a released
> version yet) that fix fsck to detect this.

Good, thanks.

>> More importantly: how do I diagnose this further and fix it?
>
> If it is the same problem (which would be a blob or maybe cached tree
> missing in one of the worktree's index files), then probably you'd
> either:
>
>   1. Accept the loss and blow away that worktree's index file (or
>      perhaps even the whole worktree, and just recreate it).

Hmm... the problem is "that": I have about a hundred worktrees for
this repository.
But yes, I can just throw away all those `index` files, I guess.

>      (assuming that the file itself is still hanging around).
> The original corruption bug itself (gc not taking into account worktree
> index files) has been fixed for a while, so the theory is that this can
> be lingering corruption from a repack by an older version of Git. But if
> you have evidence to the contrary, we'd like to hear that, too. ;)

My suspicion is that the origin of the broken state is elsewhere (maybe
a power failure?) because the problem appeared "simultaneously" (a few
days apart, really) for two different repositories.

> I don't think --aggressive would help at all. In theory --prune=now
> might, but I think even that won't help if the problem is that the
> object is referenced in an index file.

Indeed, I had also tried `--prune=now` and it did not help.
Thanks,


        Stefan

