Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE56C433F5
	for <git@archiver.kernel.org>; Wed,  4 May 2022 21:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235997AbiEDV2n (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 May 2022 17:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245360AbiEDV2m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 May 2022 17:28:42 -0400
X-Greylist: delayed 3511 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 May 2022 14:25:04 PDT
Received: from mail.esperi.org.uk (icebox.esperi.org.uk [81.187.191.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682954EF60
        for <git@vger.kernel.org>; Wed,  4 May 2022 14:25:03 -0700 (PDT)
Received: from loom (nix@sidle.srvr.nix [192.168.14.8])
        by mail.esperi.org.uk (8.16.1/8.16.1) with ESMTPS id 244KQOgJ029049
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Wed, 4 May 2022 21:26:24 +0100
From:   Nix <nix@esperi.org.uk>
To:     git@vger.kernel.org
Subject: 2.36.0: enormous numbers of loose objects after enabling partial
 clone filter: why? how to clean up?
Emacs:  more boundary conditions than the Middle East.
Date:   Wed, 04 May 2022 21:26:24 +0100
Message-ID: <877d71cadr.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-DCC-x.dcc-servers-Metrics: loom 104; Body=1 Fuz1=1 Fuz2=1
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So I turned on promisor remotes for my local Chromium tree last week:
the relevant remote now has partialclonefilter = blob:limit=10m. I
wanted to save a bit of space (well, OK, I was hoping for a lot).

This turned out to be... a bad idea. The first fetch after that exploded
some 45GiB of loose objects (nearly six million of them). I spotted an
ancient historical config option gc.pruneExpire=never and removed it:
that would explain the worst of the accumulation, if the files weren't
all dated at around the time of my first pull after turning on partial
clone.

A git repack -ad, git prune --expire=now, and similar expiry of all the
reflogs has got them down to a mere 112957 objects, 597304 kilobytes (!)
but I can't get the count lower than that, despite deleting every remote
(to get rid of the remote-tracking branches) and doing a full repack
(non-aggressive), prune, and a git prune-packed (which had no effect at
all). I've done not a great deal of work in this tree and no rebases:
there should be hardly any legitimate loose objects, I'd have thought.

Indeed, git fsck --verbose --name-objects shows that all these objects
are referenced, mostly in a few fairly recent branches. They also
clearly reside upstream, in the remote-tracking branches. So... why is
git repack refusing to pack them? Is there any way to find out? It's
fairly opaque in its decisions, which usually I don't worry about, but
this space bloat is kind of ridiculous.

(There are no alternates or anything like that pointing at this repo, so
it's not that.)

-- 
NULL && (void)
