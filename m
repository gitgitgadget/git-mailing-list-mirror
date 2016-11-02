Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C9C520193
	for <e@80x24.org>; Wed,  2 Nov 2016 22:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933041AbcKBWLR (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 18:11:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:37713 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932972AbcKBWLQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 18:11:16 -0400
Received: (qmail 22584 invoked by uid 109); 2 Nov 2016 22:11:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Nov 2016 22:11:16 +0000
Received: (qmail 7112 invoked by uid 111); 2 Nov 2016 22:11:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Nov 2016 18:11:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Nov 2016 18:11:14 -0400
Date:   Wed, 2 Nov 2016 18:11:14 -0400
From:   Jeff King <peff@peff.net>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     git@vger.kernel.org
Subject: Re: RFE: Discard hunks during `git add -p`
Message-ID: <20161102221113.peur2zyfs66bdchm@sigill.intra.peff.net>
References: <alpine.LSU.2.20.1611021435280.21207@nerf40.vanv.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.20.1611021435280.21207@nerf40.vanv.qr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 02, 2016 at 02:46:04PM +0100, Jan Engelhardt wrote:

> Current version: 2.10.2
> Example workflow:
> 
> * I would do a global substitution across a source tree, e.g. `perl -i 
>   -pe 's{OLD_FOO\(x\)}{NEW_BAR(x, 0)}' *.c`
> * Using `git add -p`, I would verify each of the substitutions that they 
>   make sense in their respective locations, and, based on that,
>   answer "y" or "n" to the interactive prompting to stage good hunks.
> * When done with add-p, I would commit the so-staged hunks,
>   and then use `git reset --hard` to discard all changes that were 
>   not acknowledged during add-p.
> 
> Being able to discard hunks (reset working copy to index contents) 
> during add-p would alleviate the (quite broad) hard reset.

As Konstantin pointed out, you can already discard interactively with
"git checkout -p". It might be nice to be able to do both in the same
run, and turn the "yes/no" decision into "yes/no/discard".

In theory it should be easy, as the same code drives the hunk selector
for both commands. It's just a matter of which command we feed the
selected hunks to. I don't know if there would be corner cases around
hunk-editing and splitting, though. The "add" phase should never touch
the working tree file itself, so any hunks present from the initial list
should still apply cleanly during the "discard" phase.

-Peff
