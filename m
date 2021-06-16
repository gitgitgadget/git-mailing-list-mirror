Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A366C48BE8
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 10:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4BE161245
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 10:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbhFPKdc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 06:33:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:57366 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232307AbhFPKdb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 06:33:31 -0400
Received: (qmail 12452 invoked by uid 109); 16 Jun 2021 10:31:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 16 Jun 2021 10:31:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25289 invoked by uid 111); 16 Jun 2021 10:31:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 16 Jun 2021 06:31:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 16 Jun 2021 06:31:23 -0400
From:   Jeff King <peff@peff.net>
To:     phillip.wood@dunelm.org.uk
Cc:     Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/2] RFC: implement new zdiff3 conflict style
Message-ID: <YMnS+2DFYiswc75z@coredump.intra.peff.net>
References: <pull.1036.git.git.1623734171.gitgitgadget@gmail.com>
 <YMh2M8Ek/RUVjKkL@coredump.intra.peff.net>
 <CABPp-BE7-E03+x38EK-=AE5mwwdST+d50hiiud2eY2Nsf3rM5g@mail.gmail.com>
 <255df678-9a31-bba2-f023-c7d98e5ffc15@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <255df678-9a31-bba2-f023-c7d98e5ffc15@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 16, 2021 at 09:57:49AM +0100, Phillip Wood wrote:

> > > which seems worse. I haven't dug/thought carefully enough into your
> > > change yet to know if this is expected, or if there's a bug.
> 
> XDL_MERGE_ZEALOUS coalesces adjacent conflicts that are separated by fewer
> than four lines. Unfortunately the existing code in
> xdl_merge_two_conflicts() only coalesces 'ours' and 'theirs', not 'base'.
> Applying
> [...]
> gives
> 
> <<<<<<< HEAD
> 		if (starts_with(arg, "--informative-errors")) {
> 			informative_errors = 1;
> 			continue;
> 		}
> 		if (starts_with(arg, "--no-informative-errors")) {
> ||||||| 2f93541d88
> 		if (!prefixcmp(arg, "--informative-errors")) {
> 			informative_errors = 1;
> 			continue;
> 		}
> 		if (!prefixcmp(arg, "--no-informative-errors")) {
> =======
> 		if (!strcmp(arg, "--informative-errors")) {
> 			informative_errors = 1;
> 			continue;
> 		}
> 		if (!strcmp(arg, "--no-informative-errors")) {
> >>>>>>> 0c52457b7c^2
> 
> Which I think is correct. Whether combining single line conflicts in this
> way is useful is a different question (and is independent of your patch). I
> can see that with larger conflicts it is worth it but here we end up with
> conflicts where 60% of the lines are from the base version. One the other
> hand there are fewer conflicts to resolve - I'm not sure which I prefer.

Thanks for figuring that out. I agree that the output after the patch
you showed is correct, in the sense that the common lines show up in the
base now. It does feel like it's working against the point of zdiff3,
though, which is to reduce the number of common lines shown in the
"ours" and "theirs" hunks.

Likewise, I think this coalescing makes things worse even for "merge",
where you get:

  <<<<<<< ours
                  if (starts_with(arg, "--informative-errors")) {
                          informative_errors = 1;
                          continue;
                  }
                  if (starts_with(arg, "--no-informative-errors")) {
  =======
                  if (!strcmp(arg, "--informative-errors")) {
                          informative_errors = 1;
                          continue;
                  }
                  if (!strcmp(arg, "--no-informative-errors")) {
  >>>>>>> theirs

and have to figure out manually that those interior lines are common.
But I imagine there are cases where you have a large number of
uninteresting lines (blank lines, "}", etc) that create a lot of noise
in the output by breaking up the actual changed lines into tiny hunks
that are hard to digest on their own.

-Peff
