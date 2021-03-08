Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE543C433DB
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 19:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70C6D65296
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 19:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhCHTQf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 14:16:35 -0500
Received: from cloud.peff.net ([104.130.231.41]:55912 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231189AbhCHTQX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 14:16:23 -0500
Received: (qmail 26719 invoked by uid 109); 8 Mar 2021 19:16:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 Mar 2021 19:16:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20796 invoked by uid 111); 8 Mar 2021 19:16:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Mar 2021 14:16:23 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 8 Mar 2021 14:16:21 -0500
From:   Jeff King <peff@peff.net>
To:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Subject: Re: [PATCH 4/7] worktree: fix leak in dwim_branch()
Message-ID: <YEZ4BQTeT/vdX+tK@coredump.intra.peff.net>
References: <pull.899.git.1615228580.gitgitgadget@gmail.com>
 <d46a4e701620704ae3fd203c9d9dffb172cb3804.1615228580.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d46a4e701620704ae3fd203c9d9dffb172cb3804.1615228580.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 08, 2021 at 06:36:17PM +0000, Andrzej Hunt via GitGitGadget wrote:

> Make sure that we release the temporary strbuf during dwim_branch() for
> all codepaths (and not just for the early return).

Makes sense. Two style nits:

>  static const char *dwim_branch(const char *path, const char **new_branch)
>  {
> -	int n;
> +	int n, branch_exists;

If two variables aren't strictly related, but just happen to share the
same type, IMHO it's better to declare them separately. (There are
numerous spots in Git's code that don't follow this rule, but I think we
should be moving in that direction).

> -	if (!strbuf_check_branch_ref(&ref, branchname) &&
> -	    ref_exists(ref.buf)) {
> -		strbuf_release(&ref);
> +
> +	branch_exists = (!strbuf_check_branch_ref(&ref, branchname) &&
> +			 ref_exists(ref.buf));

We'd usually omit the extra parentheses here. I.e.,:

  branch_exists = !strbuf_check_branch_ref(&ref, branchname) &&
                  ref_exists(ref.buf);

-Peff
