Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BFCC43334
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 19:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354094AbiFUTqy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 15:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353438AbiFUTqw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 15:46:52 -0400
X-Greylist: delayed 1225 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Jun 2022 12:46:46 PDT
Received: from gateway10.unifiedlayer.com (gateway10.unifiedlayer.com [74.220.194.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11407275F6
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 12:46:45 -0700 (PDT)
Received: from cm6.websitewelcome.com (unknown [108.167.139.19])
        by gateway10.unifiedlayer.com (Postfix) with ESMTP id D59D920070F5A
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 14:26:19 -0500 (CDT)
Received: from uscentral455.accountservergroup.com ([174.136.13.174])
        by cmsmtp with ESMTP
        id 3jVzoaPIK8f6z3jVzoM7x6; Tue, 21 Jun 2022 14:26:19 -0500
X-Authority-Reason: nr=8
Received: from 76-222-220-222.lightspeed.rcsntx.sbcglobal.net ([76.222.220.222]:59808 helo=bigbox.attlocal.net)
        by uscentral455.accountservergroup.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <git@tim.thechases.com>)
        id 1o3jVz-001vmi-J9
        for git@vger.kernel.org; Tue, 21 Jun 2022 14:26:19 -0500
Date:   Tue, 21 Jun 2022 14:26:18 -0500
From:   Tim Chase <git@tim.thechases.com>
To:     git@vger.kernel.org
Subject: stashing only unstaged changes?
Message-ID: <20220621142618.239b02cd@bigbox.attlocal.net>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; amd64-portbld-freebsd13.0)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - uscentral455.accountservergroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tim.thechases.com
X-BWhitelist: no
X-Source-IP: 76.222.220.222
X-Source-L: No
X-Exim-ID: 1o3jVz-001vmi-J9
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 76-222-220-222.lightspeed.rcsntx.sbcglobal.net (bigbox.attlocal.net) [76.222.220.222]:59808
X-Source-Auth: tim@thechases.com
X-Email-Count: 1
X-Source-Cap: dGhlY2hhc2U7dGhlY2hhc2U7dXNjZW50cmFsNDU1LmFjY291bnRzZXJ2ZXJncm91cC5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I recently had composed a commit with some `git add -p` leaving some
portions unstaged. I wanted to stash the unstaged changes to make
sure that the staged code ran as expected, so I did  a `git stash`
only to find that it unstaged my staged changes and stashed
*everything*.

Using `git stash --saved` does the opposite of what I want (stashing
the index, not the difference between the index and the working-copy)

So I carefully re-`git add -p`'ed everything and tried `git stash
--keep-index` which sounded promising (my index remained the same),
but popping my stash ended up causing conflicts because it had
stashed the diff of HEAD..working-copy, not INDEX..working-copy.  A
`git stash show -p` confirmed that the stash included things that I
had already staged.

So I carefully re-`git add -p`ed everything yet again, but then got
stuck trying to convince `stash` to save a snapshot of only the diff
in my working directory. To work around it, I did a `git diff >
temp.patch` to obtain the stuff I'd wanted to stash, a `git reset
--staged` to clear out those changes, ran my code to verify
(eventually committing it), and then applied the `temp.patch` back on
top of my changes.  It worked, but felt convoluted.

I did see the `git stash -p` option, to manually choose the inverse
bits, but for what I was doing, it was more sensible to `git add -p`
and try to stash the rest.

So is there some option I've missed to tell `git stash` to stash only
the delta between the uncommitted-index and the working-copy?

Thanks,

-Tim


(I'd posted this on /r/git

https://www.reddit.com/r/git/comments/vchu83/stashing_only_unstaged_changes/

but figured I'd try my hand here in the hope of more answers)
