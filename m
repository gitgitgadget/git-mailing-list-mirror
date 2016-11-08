Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A7B22022A
	for <e@80x24.org>; Tue,  8 Nov 2016 20:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753870AbcKHUBO (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 15:01:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:40285 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752968AbcKHUBN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 15:01:13 -0500
Received: (qmail 24988 invoked by uid 109); 8 Nov 2016 20:01:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Nov 2016 20:01:12 +0000
Received: (qmail 23407 invoked by uid 111); 8 Nov 2016 20:01:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Nov 2016 15:01:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Nov 2016 15:01:10 -0500
Date:   Tue, 8 Nov 2016 15:01:10 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Word <argoday@argoday.com>
Cc:     Markus Hitter <mah@jump-ing.de>, git@vger.kernel.org,
        jword@bloomberg.net
Subject: Re: Bug: git config does not respect read-only .gitconfig file
Message-ID: <20161108200110.zvqdm2nlu5zxfyv5@sigill.intra.peff.net>
References: <CAD9aWChH14eviop=0_Ma_2Pa-2OyWJp9KjimH8dyqy-XDn9Rhw@mail.gmail.com>
 <40608c85-f870-87f7-daee-7fa98f5d19c1@jump-ing.de>
 <CAD9aWCgZkuaZNMDparVZE_WNFpOp7ud6iyCueGVbnU8s_EYtrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD9aWCgZkuaZNMDparVZE_WNFpOp7ud6iyCueGVbnU8s_EYtrQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 08, 2016 at 12:18:22PM -0500, Jonathan Word wrote:

> The point of confusion to users ( / my team) is that `git config`
> gives the appearance of editing / modifying the .gitconfig file
> in-place (where file permissions would be respected) however the
> actual implementation performs the equivalent of a rm+mv which only
> respects directory permissions.

The reason for the tmpfile/rename is that git-config actually takes a
dot-lock on the file while writing it. Simultaneous writers are blocked,
and simultaneous readers see an atomic view of the file (either the
state before or after the write, but never a half-written file).  Most
of git's file-writes are done this way.

> The `git config` command is only one of many that leverage that
> rename_tempfile function, if opting to respect file-level permissions
> across the board then the desired change is probably at that level
> rather than in config::git_config_set_multivar_in_file_gently which
> would only add respect for file-level permissions to the one command.

I am not convinced this is a code problem and not simply a documentation
issue, but if you wanted to add an option to try to respect file
permissions, then yes, I agree it should be done across the board.
Probably converting "rename(from, to)" to first check "access(to,
W_OK)". That's racy, but it's the best we could do.

-Peff
