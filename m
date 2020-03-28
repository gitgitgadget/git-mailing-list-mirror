Return-Path: <SRS0=KP1k=5N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394BFC43331
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 15:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D3B8206F6
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 15:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgC1P43 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Mar 2020 11:56:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:54540 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726518AbgC1P43 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Mar 2020 11:56:29 -0400
Received: (qmail 24521 invoked by uid 109); 28 Mar 2020 15:56:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 28 Mar 2020 15:56:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2666 invoked by uid 111); 28 Mar 2020 16:06:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 28 Mar 2020 12:06:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 28 Mar 2020 11:56:27 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Norbert Kiesel <nkiesel@gmail.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] pull: avoid running both merge and rebase
Message-ID: <20200328155627.GB1215566@coredump.intra.peff.net>
References: <pull.739.git.git.1585345900763.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.739.git.git.1585345900763.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 27, 2020 at 09:51:40PM +0000, Elijah Newren via GitGitGadget wrote:

> When opt_rebase is true, we still first check if we can fast-forward.
> If the branch is fast-forwardable, then we can avoid the rebase and just
> use merge to do the fast-forward logic.  However, when commit a6d7eb2c7a
> ("pull: optionally rebase submodules (remote submodule changes only)",
> 2017-06-23) added the ability to rebase submodules it accidentally
> caused us to run BOTH a merge and a rebase.  Add a flag to avoid doing
> both.
> 
> This was found when a user had both pull.rebase and rebase.autosquash
> set to true.  In such a case, the running of both merge and rebase would
> cause ORIG_HEAD to be updated twice (and match HEAD at the end instead
> of the commit before the rebase started), against expectation.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>     pull: avoid running both merge and rebase
>     
>     Cc: Norbert Kiesel nkiesel@gmail.com [nkiesel@gmail.com], Jeff King 
>     peff@peff.net [peff@peff.net]

I'm not sure how cc is supposed to work with GGG, but it clearly didn't
here. :)

Anyway, the patch looks good. Thanks for following through on this.

> @@ -992,10 +993,12 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>  			if (is_descendant_of(merge_head, list)) {
>  				/* we can fast-forward this without invoking rebase */
>  				opt_ff = "--ff-only";
> +				ran_ff = 1;
>  				ret = run_merge();
>  			}
>  		}
> -		ret = run_rebase(&curr_head, merge_heads.oid, &rebase_fork_point);
> +		if (!ran_ff)
> +			ret = run_rebase(&curr_head, merge_heads.oid, &rebase_fork_point);

It feels like there should be some arrangement of the conditionals that
doesn't require setting an extra flag, but I actually don't think there
is. And anyway, doing the most obvious and minimal fix here is the right
place to start. We don't need more regressions. ;)

-Peff
