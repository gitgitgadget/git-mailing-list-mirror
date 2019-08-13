Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E991C1F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 15:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730104AbfHMPmk (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 11:42:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:41970 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727697AbfHMPmk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 11:42:40 -0400
Received: (qmail 4458 invoked by uid 109); 13 Aug 2019 15:42:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 13 Aug 2019 15:42:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1393 invoked by uid 111); 13 Aug 2019 15:45:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Aug 2019 11:45:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 13 Aug 2019 11:42:39 -0400
From:   Jeff King <peff@peff.net>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org
Subject: Re: How to reset selected lines?
Message-ID: <20190813154239.GA22514@sigill.intra.peff.net>
References: <20190813141816.yoer6pfjdnlgtj76@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190813141816.yoer6pfjdnlgtj76@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 13, 2019 at 07:48:16PM +0530, Pratyush Yadav wrote:

> To put things into context of why I am asking this, git-gui has a 
> feature where you can select parts of a displayed diff, and can 
> stage/unstage those parts. That feature is implemented in git-gui by 
> just generating a diff from the selected lines, and then applying it. 
> Check git-gui/lib/diff.tcl:643 for the implementation.
> 
> Now, I want to add a similar feature, but one that discards/resets the 
> selected lines. And I'd like to avoid the hack that git-gui's 
> apply_range_or_line is. So, is there a cleaner way to do this that does 
> not involve generating a diff and then applying it?

To answer your second question first:

Git's index and trees only understand whole files, so at some point you
must generate the final file content. A diff is an easy way to represent
the changes, apply them to the existing state, and then get that final
content. But it doesn't _have_ to be. You could make some modifications
to what is in the working tree and then say "OK, now stage this.".

BUT. That is probably not what the user wants, if the content in the
index actually has some modifications that are not in the working tree
(i.e., you wouldn't want to overwrite them). Hence we tend to work with
diffs, saying "make these changes to what is already in the index, and
if they conflict, then bail".

So "git add -p", for example, also works by creating diffs, modifying
them, and feeding the result to "apply". You can see the implementation
in git-add--interactive.perl, where it literally calls diff and apply
commands.

And that leads us to the answer to the first question. That script
implements "add -p", but also "checkout -p" (which is what you want),
"reset -p", "stash -p", etc. They differ only in what we diff and how we
apply the result; the main engine of slicing and dicing the diff through
user interaction is the same. See the %patch_modes hash for the list.

-Peff
