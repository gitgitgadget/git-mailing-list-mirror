Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01446C4332F
	for <git@archiver.kernel.org>; Fri,  9 Dec 2022 00:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiLIAtY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 19:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiLIAtW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 19:49:22 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87C8A4333
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 16:49:21 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 62C0E33825;
        Fri,  9 Dec 2022 00:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1670546960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lDwbF0oU1l0Oy8BFtGK3bxxtkiAkTF3h56L0UgeAatI=;
        b=VVxttuBQfZ5gVN7f1w6WGxrq5B/kCPUrkh1Y1rgqjVJ5cWMtB4hPLOSJT9TxRSKUy4Vob+
        RZq+o6Wzy++9dVDjFls7PoWhCu9W2O2ab1EBNiGm/uhaNZG+fg7/9Px+LQdv5i0FBXRuDB
        iAbsRqUMGOnseFN4ZhffewTgJIqf3ho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1670546960;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lDwbF0oU1l0Oy8BFtGK3bxxtkiAkTF3h56L0UgeAatI=;
        b=Qa/k2Dg40sG0OuUkvxSL+wUt5fw0xNEJNJGCFMzssdgsAiIpZe8FJ5BeQoxi1dpXglm3Hb
        rpaS2+8UhWu2AoCw==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0B5B32C141;
        Fri,  9 Dec 2022 00:49:19 +0000 (UTC)
Date:   Fri, 9 Dec 2022 01:49:18 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Jeff King <peff@peff.net>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        johncai86@gmail.com, Taylor Blau <me@ttaylorr.com>
Subject: Re: Question: How to execute git-gc correctly on the git server
Message-ID: <20221209004918.GI28810@kitsune.suse.cz>
References: <CAOLTT8Tt3jW2yvm6BRU3yG+EvW1WG9wWFq6PuOcaHNNLQAaGjg@mail.gmail.com>
 <221208.86a63y9309.gmgdl@evledraar.gmail.com>
 <20221208011631.GH28810@kitsune.suse.cz>
 <Y5GLsZgmrxbBtLqo@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y5GLsZgmrxbBtLqo@coredump.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 08, 2022 at 02:01:05AM -0500, Jeff King wrote:
> On Thu, Dec 08, 2022 at 02:16:31AM +0100, Michal Suchánek wrote:
> 
> > > A "git gc" on a "live" repo is always racy in theory, but the odds that
> > > you'll run into data corrupting trouble tends to approach zero as you
> > > increase the gc.pruneExpire setting, with the default 2 weeks being more
> > > than enough for even the most paranoid user.
> > 
> > And that two weeks expiration applies to what, exactly?
> > 
> > For commits there is author date and commit date but many other objecs
> > won't have these I suppose. And the date when the object is pushed into
> > the repository is unrelated to these two, anyway.
> 
> In this case it's the mtime on the object file (or the pack containing
> it). But yes, it is far from a complete race-free solution.

So if you are pushing a branch that happens to reuse commits or other
objects from an earlier branh that might have been collected ín the
meantime you are basically doomed.

How likely that is depends a lot on your workflow.

People deleting a branch and then pushing another variant in which many
objects are the same is a risk.

People exporting files from somewhere and adding them to the repo which
are bit-identical when independently exported by multiple people and
sometimes deleting branches is a risk.

...

Thanks

Michal
