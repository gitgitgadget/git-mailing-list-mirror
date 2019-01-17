Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28F771F453
	for <e@80x24.org>; Thu, 17 Jan 2019 17:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbfAQRcT (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 12:32:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:40002 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728218AbfAQRcT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 12:32:19 -0500
Received: (qmail 2226 invoked by uid 109); 17 Jan 2019 17:32:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 17 Jan 2019 17:32:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2423 invoked by uid 111); 17 Jan 2019 17:32:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 17 Jan 2019 12:32:20 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Jan 2019 12:32:17 -0500
Date:   Thu, 17 Jan 2019 12:32:17 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Brandon Williams <bwilliams.eng@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Aaron Schrab <aaron@schrab.com>
Subject: Re: [RFC] submodule: munge paths to submodule git directories
Message-ID: <20190117173216.GB27667@sigill.intra.peff.net>
References: <20180807230637.247200-1-bmwill@google.com>
 <20190115012507.GK162110@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190115012507.GK162110@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 14, 2019 at 05:25:07PM -0800, Jonathan Nieder wrote:

> I've put a summary in https://crbug.com/git/28 to make this easier to
> pick up where we left off.  Summary from there of the upstream review:
> 
> 1. Using urlencoding to escape the slashes is fine, but what if we
>    want to escape some other character (for example to handle
>    case-insensitive filesystems)?
> 
>    Proposal: Store the escaping mapping in config[1] so it can be
>    modified it in the future:
> 
> 	[submodule "plugin/hooks"]
> 		gitdirname = plugins%2fhooks

I think it might be worth dealing with case-sensitivity _now_, since we
know it's a problem. That doesn't make the problem of "what if we want
to change the mapping later" go away, but it does make it a lot less
likely to come up.

> 2. The urlencoded name could conflict with a submodule that has % in
>    its name in an existing clone created by an older version of Git.
> 
>    Proposal: Put submodules in a new .git/submodules/ directory
>    instead of .git/modules/.

This proposal is orthogonal to (1), right? I.e., if we store the mapping
then that is what tells us we're using the mapped name.

> 3. These gitdirname settings can clutter up .git/config.
> 
>    Proposal: For the "easy" cases (e.g. submodule name consisting of
>    [a-z]*), allow omitting the gitdirname setting.

Not having thought about it too hard, I suspect that may open back up
corner cases with respect to backwards compatibility and ambiguity.

Are you worried about human-readable clutter? I.e., that .git/config
becomes hard to read? If so, then:

  - I doubt this is any worse than the existing tracking-branch config.

  - it might be reasonable to store it in .git/submodule-config, and
    make sure that .git/config contains a single "[include]path =
    submodule-config" line. I've been tempted to do that for
    tracking-branch config.

Or are you worried about the cost of parsing those entries? Basically
every git command parses config linearly at least once; this normally
isn't noticeable, but at some size it becomes a problem. I have no idea
what that size is.

If so, then I think we'd want submodule config in its own file but
_without_ an include from the normal config file. That would break
compatibility with anything that tries to use "git config
submodule.foo.path", etc.

That's all just musing. I'm actually not really convinced it's a
problem.

> Is that a fair summary?  Are there concerns from the review that I
> forgot, or would a new version of the series that addresses those
> three problems put us in good shape?

I don't really have a strong opinion either way. I still think the
one-way transformation that the patch uses is less elegant than a real
encode/decode round-trip (i.e., what I discussed in [1]). But I admit to
not having thought through all of the details of the encode/decode
thing, and certainly have not written the code.

[1] http://public-inbox.org/git/20180809212602.GA11342@sigill.intra.peff.net/
