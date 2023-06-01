Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA8FC7EE23
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 12:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbjFAMEy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 08:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbjFAMEt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 08:04:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4564FC
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 05:04:47 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 58D1521879;
        Thu,  1 Jun 2023 12:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1685621086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EGL29b0pTZqUSGEwQjcxA4z2z1FA0Uctl7I0ot9KIAA=;
        b=bL3o5qj26R85rf+TsUkquAa+EIXhUtS/EHNXsQg7NGovumtoIjEiuCKKnKs7RI1VyvJP5E
        FuFZnIZ9/7GAUe+2Cw5SuERIZeGhZ1iU9JW/gVuumfeW0mbCR9ZjXRDSnx49Sx4LouCKKr
        ceHSpB29PKw/IogceDqaOyHhurZ3SMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1685621086;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EGL29b0pTZqUSGEwQjcxA4z2z1FA0Uctl7I0ot9KIAA=;
        b=3AWqm7Q7y9Nq0+WMNuF/VtTAEqS4j9/LA3mlC4TLjwiwAwGWl/55QQMEi9xDoux6aK+nii
        1gnd5lEU79KUVxDQ==
Received: from hawking.suse.de (unknown [10.168.4.11])
        by relay2.suse.de (Postfix) with ESMTP id 4B3EC2C141;
        Thu,  1 Jun 2023 12:04:46 +0000 (UTC)
Received: by hawking.suse.de (Postfix, from userid 17005)
        id A7DDB4A0785; Thu,  1 Jun 2023 14:04:45 +0200 (CEST)
From:   Andreas Schwab <schwab@suse.de>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Monnier <monnier@iro.umontreal.ca>, git@vger.kernel.org
Subject: Re: `git gc` says "unable to read" but `git fsck` happy
In-Reply-To: <20230330181716.GA3286761@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 30 Mar 2023 14:17:16 -0400")
References: <jwvfs9nusjm.fsf-monnier+Inbox@gnu.org>
        <20230329233735.GD2314218@coredump.intra.peff.net>
        <jwvfs9mz9n7.fsf-monnier+Inbox@gnu.org>
        <20230330181716.GA3286761@coredump.intra.peff.net>
X-Yow:  YOW!  I can see 1987!!  PRESIDENT FORD is doing the REMAKE of "PAGAN
 LOVE SONG"...he's playing ESTHER WILLIAMS!!
Date:   Thu, 01 Jun 2023 14:04:45 +0200
Message-ID: <mvm4jnr9yn6.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mär 30 2023, Jeff King wrote:

> On Thu, Mar 30, 2023 at 09:01:39AM -0400, Stefan Monnier wrote:
>
>> > If it is the same problem (which would be a blob or maybe cached tree
>> > missing in one of the worktree's index files), then probably you'd
>> > either:
>> >
>> >   1. Accept the loss and blow away that worktree's index file (or
>> >      perhaps even the whole worktree, and just recreate it).
>> 
>> Hmm... the problem is "that": I have about a hundred worktrees for
>> this repository.
>> But yes, I can just throw away all those `index` files, I guess.
>
> If you try "git fsck" from the tip of master, it should identify the
> worktree index that is the source of the problem, I think. You might
> need to pass "--name-objects".

I had the same problem, and after Junio refreshed my memory by pointing
me to this thread, I updated to the brand new git 2.41 and re-ran git
fsck.  That duely identified problems in two of the worktree indexes
(invalid sha1 pointer in resolve-undo).  After recreating those indexes
there were no more complaints from git gc.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
