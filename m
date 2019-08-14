Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 355581F45A
	for <e@80x24.org>; Wed, 14 Aug 2019 11:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfHNLst (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Aug 2019 07:48:49 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:35231 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfHNLst (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Aug 2019 07:48:49 -0400
Received: from localhost (unknown [157.45.27.62])
        (Authenticated sender: me@yadavpratyush.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id BE4BF100007;
        Wed, 14 Aug 2019 11:48:46 +0000 (UTC)
Date:   Wed, 14 Aug 2019 17:18:44 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: How to reset selected lines?
Message-ID: <20190814114844.gvb5znje7cpzehkd@localhost.localdomain>
References: <20190813141816.yoer6pfjdnlgtj76@localhost.localdomain>
 <20190813154239.GA22514@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813154239.GA22514@sigill.intra.peff.net>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/08/19 11:42AM, Jeff King wrote:
> On Tue, Aug 13, 2019 at 07:48:16PM +0530, Pratyush Yadav wrote:
> 
> > To put things into context of why I am asking this, git-gui has a 
> > feature where you can select parts of a displayed diff, and can 
> > stage/unstage those parts. That feature is implemented in git-gui by 
> > just generating a diff from the selected lines, and then applying it. 
> > Check git-gui/lib/diff.tcl:643 for the implementation.
> > 
> > Now, I want to add a similar feature, but one that discards/resets the 
> > selected lines. And I'd like to avoid the hack that git-gui's 
> > apply_range_or_line is. So, is there a cleaner way to do this that does 
> > not involve generating a diff and then applying it?
> 
> To answer your second question first:
> 
> Git's index and trees only understand whole files, so at some point you
> must generate the final file content. A diff is an easy way to represent
> the changes, apply them to the existing state, and then get that final
> content. But it doesn't _have_ to be. You could make some modifications
> to what is in the working tree and then say "OK, now stage this.".
> 
> BUT. That is probably not what the user wants, if the content in the
> index actually has some modifications that are not in the working tree
> (i.e., you wouldn't want to overwrite them). Hence we tend to work with
> diffs, saying "make these changes to what is already in the index, and
> if they conflict, then bail".
> 
> So "git add -p", for example, also works by creating diffs, modifying
> them, and feeding the result to "apply". You can see the implementation
> in git-add--interactive.perl, where it literally calls diff and apply
> commands.
> 
> And that leads us to the answer to the first question. That script
> implements "add -p", but also "checkout -p" (which is what you want),
> "reset -p", "stash -p", etc. They differ only in what we diff and how we
> apply the result; the main engine of slicing and dicing the diff through
> user interaction is the same. See the %patch_modes hash for the list.

Ah, so that means I do have to dive into generating diffs. Too bad, I 
was hoping for a cleaner (read: easier) way.

On that note, I don't suppose there is a way to use 
git-add--interactive's diff engine from a script, is there?  That'd 
allow me to not write potentially buggy code and solve problems someone 
already solved.

Thanks for your detailed answer.

-- 
Regards,
Pratyush Yadav
