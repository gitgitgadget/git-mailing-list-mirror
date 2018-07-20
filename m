Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEF8B1F597
	for <e@80x24.org>; Fri, 20 Jul 2018 13:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731203AbeGTOLK (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 10:11:10 -0400
Received: from imap.thunk.org ([74.207.234.97]:38224 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731103AbeGTOLK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 10:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=y1VhvTexUw8dg+ohjquf0+lSrywWDy1HG/qfN+K8cFo=; b=lvkfC2f/Xrj2SUsOGIIvT+69Mb
        k+AkKM3uMcCtByHIl08xOlgYOapqohAMmiJDTJu6D1rUq0J707DlCyElLJiW2VY7FfdP91Yhp3YGu
        WKD3Ah4jSCb5ItgZ/aYCmyGB0Tdc0WSIOuq+72i3mwMOE4Toby181CA46fejsi2pPZzY=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fgVMw-0003ha-LI; Fri, 20 Jul 2018 13:22:50 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 2174B7A644D; Fri, 20 Jul 2018 09:22:41 -0400 (EDT)
Date:   Fri, 20 Jul 2018 09:22:41 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/2] introduce "banned function" list
Message-ID: <20180720132241.GN30706@thunk.org>
References: <20180719203259.GA7869@sigill.intra.peff.net>
 <20180719203901.GA8079@sigill.intra.peff.net>
 <xmqqmuumdetr.fsf@gitster-ct.c.googlers.com>
 <20180720010808.GC2179@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720010808.GC2179@sigill.intra.peff.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 09:08:08PM -0400, Jeff King wrote:
> Ditto for sprintf, where you should _always_ be using at least xsnprintf
> (or some better tool, depending on the situation).  And for strncpy,
> strlcpy (or again, some better tool) is strictly an improvement.

Nitpick: this may be true for git, but it's not strictly true in all
cases.  I actually have a (non-git) case where strncpy *is* the right
tool.  And this is one where I'm copying a NUL-terminated string into
a fixed-length charater array (in the ext4 superblock) which is *not*
NUL-terminated.  In that case, strncpy works(); but strlcpy() does not
do what I want.

So I used strncpy() advisedly, and I ignore people running Coccinelle
scripts and blindly sending patches to "fix" ext4.

But perhaps that's also a solution for git?  You don't have to
necessarily put them on a banned list; you could instead have some
handy, pre-set scripts that scan the entire code base looking for
"bad" functions with cleanups automatically suggested.  This could be
run at patch review time, and/or periodically (especially before a
release).

						- Ted
