Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C7861FCC7
	for <e@80x24.org>; Fri, 10 Feb 2017 04:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751225AbdBJEl4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 23:41:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:52754 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750989AbdBJEly (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 23:41:54 -0500
Received: (qmail 31192 invoked by uid 109); 10 Feb 2017 04:41:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Feb 2017 04:41:54 +0000
Received: (qmail 9582 invoked by uid 111); 10 Feb 2017 04:21:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Feb 2017 23:21:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Feb 2017 23:21:15 -0500
Date:   Thu, 9 Feb 2017 23:21:15 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] rev-parse --git-path: fix output when running in a
 subdirectory
Message-ID: <20170210042115.d4kmdf4obxqwobv4@sigill.intra.peff.net>
References: <50fe3ea3302c40f4c96eaa5a568837e3334f9dc4.1486555851.git.johannes.schindelin@gmx.de>
 <xmqqh944wmcs.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1702092201080.3496@virtualbox>
 <xmqqo9ybnie0.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo9ybnie0.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 09, 2017 at 01:50:31PM -0800, Junio C Hamano wrote:

> > There is just no way you can "fix" this otherwise. As an occasional shell
> > scripter, you may be tempted to use `$(git rev-parse --show-cdup)$(git
> > rev-parse --git-path filename)`, but of course that breaks in worktrees
> > and if you do not use worktrees you would not even know that your
> > workaround introduced another bug.
> 
> In case it is not clear, I understand all of the above.  
> 
> I was just worried about the people who do *NOT* use worktrees and
> did the obvious "concatenate --cdup with --git-path" and thought
> their script were working happily and well.  By prepending the path
> to the (real) location of the .git in the updated --git-path output
> ourselves, they will complain, our update broke their script.

That concatenating approach is broken in other ways, too. For example,
if you have $GIT_DIR set to an absolute path, then --git-path will use
that.  I don't think we have ever promised that the output of --git-path
(or --git-dir) would ever be absolute or relative (in fact, the
--git-dir documentation implies that you may get either).

So yes, there could be somebody who is doing this concatenation
workaround, but only ever calls their script in a certain way that never
triggers the absolute-path variant. They're happy now, and may not be
after Dscho's patch. But I really think they are relying on a bogus
assumption, and their scripts are already buggy.

-Peff
