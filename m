Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 365762022D
	for <e@80x24.org>; Thu, 23 Feb 2017 19:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751213AbdBWTI6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 14:08:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:60946 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751099AbdBWTI5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 14:08:57 -0500
Received: (qmail 8019 invoked by uid 109); 23 Feb 2017 18:42:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 18:42:16 +0000
Received: (qmail 22519 invoked by uid 111); 23 Feb 2017 18:42:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 13:42:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Feb 2017 13:42:13 -0500
Date:   Thu, 23 Feb 2017 13:42:13 -0500
From:   Jeff King <peff@peff.net>
To:     Joey Hess <id@joeyh.name>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: SHA1 collisions found
Message-ID: <20170223184213.rml33rymw6x6pirc@sigill.intra.peff.net>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
 <CAPc5daVZ79WWKSw76kxHgDra9a7fSR1AibZa_pvK9aUuuVawLQ@mail.gmail.com>
 <20170223173547.qljypk7sdqi37oha@kitenet.net>
 <CA+55aFzFEpi1crykZ33r9f7BsvLt_kiB-CHXOkuCAX=fd4BU-w@mail.gmail.com>
 <20170223182147.hbsyxsmyijgkqu75@kitenet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170223182147.hbsyxsmyijgkqu75@kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2017 at 02:21:47PM -0400, Joey Hess wrote:

> Linus Torvalds wrote:
> > What you describe pretty much already requires a pre-image attack,
> > which the new attack is _not_.
> > 
> > It's not clear that the "good" object can be anything sane.
> 
> Generate a regular commit object; use the entire commit object + NUL as the
> chosen prefix, and use the identical-prefix collision attack to generate
> the colliding good/bad objects.

FWIW, git-fsck complains about those (and transfer.fsck rejects them):

  $ (git cat-file commit HEAD; printf '\0more stuff') |
    git hash-object -w --stdin -t commit
  ecb2e5165c184f9025cb4c49d8f75901f4830354

  $ git fsck
  warning in commit ecb2e5165c184f9025cb4c49d8f75901f4830354: nulInCommit: NUL byte in the commit object body

So as long as either your "good" or "evil" commit has binary junk in it,
you are likely to be noticed (not everybody turns on transfer.fsck, but
GitHub does).

-Peff
