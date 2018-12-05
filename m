Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A312D211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 21:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbeLEVBH (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 16:01:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:60168 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728269AbeLEVBG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 16:01:06 -0500
Received: (qmail 9055 invoked by uid 109); 5 Dec 2018 21:01:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Dec 2018 21:01:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2754 invoked by uid 111); 5 Dec 2018 21:00:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 05 Dec 2018 16:00:35 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Dec 2018 16:01:05 -0500
Date:   Wed, 5 Dec 2018 16:01:05 -0500
From:   Jeff King <peff@peff.net>
To:     "Coiner, John" <John.Coiner@amd.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git, monorepos, and access control
Message-ID: <20181205210104.GC19936@sigill.intra.peff.net>
References: <939efd87-b2af-29d7-efdd-9cf8f6de9d10@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <939efd87-b2af-29d7-efdd-9cf8f6de9d10@amd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 05, 2018 at 08:13:16PM +0000, Coiner, John wrote:

> One obstacle to moving AMD to git/VFSForGit is the lack of access 
> control support in git. AMD has a lot of data whose distribution must be 
> limited. Sometimes it's a legal requirement, eg. CPU core designs are 
> covered by US export control laws and not all employees may see them. 
> Sometimes it's a contractual obligation, as when a third party shares 
> data with us and we agree only to share this data with certain 
> employees. Any hypothetical AMD monorepo should be able to securely deny 
> read access in certain subtrees to users without required permissions.
> 
> Has anyone looked at adding access control to git, at a per-directory 
> granularity? Is this a feature that the git community would possibly 
> welcome?

In my opinion this feature is so contrary to Git's general assumptions
that it's likely to create a ton of information leaks of the supposedly
protected data.

For instance, Git is very eager to try to find delta-compression
opportunities between objects, even if they don't have any relationship
within the tree structure. So imagine I want to know the contents of
tree X. I push up a tree Y similar to X, then fetch it back, falsely
claiming to have X but not Y. If the server generates a delta, that may
reveal information about X (which you can then iterate to send Y', and
so on, treating the server as an oracle until you've guessed the content
of X).

You could work around that by teaching the server to refuse to use "X"
in any way when the client does not have the right permissions. But:

  - that's just one example; there are probably a number of such leaks

  - you're fighting an uphill battle against the way Git is implemented;
    there's no single point to enforce this kind of segmentation

The model that fits more naturally with how Git is implemented would be
to use submodules. There you leak the hash of the commit from the
private submodule, but that's probably obscure enough (and if you're
really worried, you can add a random nonce to the commit messages in the
submodule to make their hashes unguessable).

> I would welcome your feedback on whether this idea makes technical 
> sense, and whether the feature could ever be a fit for git.

Sorry I don't have a more positive response. What you want to do is
perfectly reasonable, but I just think it's a mismatch with how Git
works (and because of the security impact, one missed corner case
renders the whole thing useless).

-Peff
