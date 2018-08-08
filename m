Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 891E1208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 17:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbeHHUQt (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 16:16:49 -0400
Received: from gproxy5-pub.mail.unifiedlayer.com ([67.222.38.55]:35628 "EHLO
        gproxy5-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727062AbeHHUQt (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 8 Aug 2018 16:16:49 -0400
X-Greylist: delayed 1232 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Aug 2018 16:16:48 EDT
Received: from cmgw12.unifiedlayer.com (unknown [10.9.0.12])
        by gproxy5.mail.unifiedlayer.com (Postfix) with ESMTP id 71E6F1408B5
        for <git@vger.kernel.org>; Wed,  8 Aug 2018 11:35:33 -0600 (MDT)
Received: from box5008.bluehost.com ([50.116.64.19])
        by cmsmtp with ESMTP
        id nSMvfv7oiak7tnSMvflxfY; Wed, 08 Aug 2018 11:35:33 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.us; s=default; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:Reply-To:From:Subject:
        Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=F+7i9npFLtxxVRbfD7FlkWD82wm3B7OZU44Rh9tPMPg=; b=Qgck05qADVu56ACKpOUPTncpue
        JBBdiAqmLo4HTaZe+dhzmTxfIx4P0V9MYg+efQ8oZ2VjXCLXgjfpBQeKctLg2Ve9Bu8fGtlU5SUSf
        //Qed7Z81rbb6oKYoLZ7UOUcO;
Received: from [50.226.24.42] (port=53870 helo=pdsdesk)
        by box5008.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <paul@mad-scientist.net>)
        id 1fnSMu-0010Lc-OM; Wed, 08 Aug 2018 11:35:32 -0600
Message-ID: <b247434b62ccd30f32adbebb83fa6ea12b51b6ff.camel@mad-scientist.net>
Subject: Re: Help with "fatal: unable to read ...." error during GC?
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Date:   Wed, 08 Aug 2018 13:35:30 -0400
In-Reply-To: <20180808160612.GC1607@sigill.intra.peff.net>
References: <1b2f649f0ece2ff46801c7bbd971c736e257af83.camel@mad-scientist.net>
         <20180808160612.GC1607@sigill.intra.peff.net>
Organization: I may be mad, but I'm a professional!
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5008.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 50.226.24.42
X-Source-L: No
X-Exim-ID: 1fnSMu-0010Lc-OM
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (pdsdesk) [50.226.24.42]:53870
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTAwOC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2018-08-08 at 12:06 -0400, Jeff King wrote:
> I'd have expected fsck to find it, too. However, looking at the code,
> I'm not convinced that fsck is actually considering detached worktree
> heads properly, either. Try:
> 
>   git rev-list --all --reflog --objects >/dev/null
> 
> which I know checks worktrees correctly. I'd expect that to fail.
> 
> If it does, then we need to narrow down which worktree is corrupt.
> Perhaps something like:
> 
>   git worktree list |
>   while read worktree head junk; do
>         git rev-list --objects $head >/dev/null ||
>         echo "$worktree seems corrupt"
>   done

Thanks for the note!  Unhappily for me none of these operations seem to
find any actionable problems...

$ git rev-list --all --reflog --objects >/dev/null
warning: reflog of 'HEAD' references pruned commits
warning: reflog of 'HEAD' references pruned commits
warning: reflog of 'HEAD' references pruned commits
warning: reflog of 'HEAD' references pruned commits
warning: reflog of 'HEAD' references pruned commits
warning: reflog of 'HEAD' references pruned commits
warning: reflog of 'HEAD' references pruned commits
warning: reflog of 'HEAD' references pruned commits
warning: reflog of 'HEAD' references pruned commits
warning: reflog of 'HEAD' references pruned commits
$ echo $?
0

$ git worktree list | while read wt head junk; do \
  git rev-list --objects $head >/dev/null || echo "$wt seems corrupt"; \
  done
$

Just to be sure I updated the loop above to echo $wt and $head and they
were correct.  I also re-ran git gc after the above and still got the
original error output so it didn't magically fix itself :).
