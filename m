Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F928C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 16:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAE4D610A3
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 16:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245139AbhIGQet (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 12:34:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:40686 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231378AbhIGQes (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 12:34:48 -0400
Received: (qmail 19524 invoked by uid 109); 7 Sep 2021 16:33:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Sep 2021 16:33:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15057 invoked by uid 111); 7 Sep 2021 16:33:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Sep 2021 12:33:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 7 Sep 2021 12:33:40 -0400
From:   Jeff King <peff@peff.net>
To:     Calum McConnell <calumlikesapplepie@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] Add support for new %w wildcard in checkout filter
Message-ID: <YTeUZEQayE9D08Es@coredump.intra.peff.net>
References: <20210906181002.625647-1-calumlikesapplepie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210906181002.625647-1-calumlikesapplepie@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 06, 2021 at 02:10:00PM -0400, Calum McConnell wrote:

> When building content filters with gitattributes, for instance to ensure
> git stores the plain-text rather than the binary form of data for certain
> formats, it is often advantageous to separate the filters into separate,
> potentially complex scripts.  However, as the $PWD where content filters
> are executed is unspecified the path to scripts needs to be specified as
> an absolute path.  That means that the guide for setting up a repository
> which uses scripts to filter content cannot simply consist of "include
> the following lines in your .git/config file", and it means that the
> otherwise safe operation of moving a git repository from one folder to
> another is decidedly unsafe.
> 
> This %w (short for 'work tree') will allow such scripts to exist and
> be executed on each checkout, without needing to be added to the PATH
> or be dependent upon the $PWD of the checkout call.

I sympathize with your goal here, but I have two high-level thoughts.

One is regarding security.

I was worried a bit that this might provide an opportunity for untrusted
repositories to trigger scripts from within their working trees without
the user having a chance to OK them. But the "%w" here would be used in
the config that the user must manually specify. So that gives them an
opportunity to investigate it as much as they want.

But it does mean we're pointing to code in the working tree that could
change after a git-pull, etc. You _can_ be careful about that (e.g., by
fetching and looking at the results, and then merging only if OK), but
the "use from working tree by default" model makes it easy to screw up
(especially if you put it into your ~/.gitconfig, and then it's used
with every repository, trusted or not).

When discussing similar features (like, say, taking project-level config
after making sure it's OK), our general thinking has been that we should
make sure Git can access some non-worktree location, and make it easy for
users to copy the data to it.

So in its most awkward state, that's asking people to copy the script
somewhere in their PATH (and then update it as needed, after verifying
it each time). That's not _too_ bad as instructions go, but gets hard if
your audience doesn't have a consistent PATH set up.

I wonder if we could do better with one or both of:

  - some way of specifying the repository directory in a config option.
    I think you can do something like that now with:

      mkdir -p .git/scripts
      cp myfilter .git/scripts/foo-filter
      git config filter.foo.clean '$(git rev-parse --git-dir)/scripts/foo-filter'

    which is admittedly a bit awkward. Some kind of syntactic candy
    could help there (having Git recognize "$GIT_SCRIPTS/foo-filter" or
    something).

  - some way of specifying an in-repo blob via config. I think right now
    you could do something like:

      git config filter.foo.clean '
        tmp=$(mktemp -t foo-filter) &&
	trap "rm -f \"$tmp\"" 0 &&
	git cat-file 1234abcd >"$tmp" &&
	"$tmp"
      '

    That's obviously even more horrible, but if we had some kind of
    syntactic sugar, you could set the config to "$oid:1234abcd" or
    something.

    That saves you from the awkward "mkdir/cp" in the first example, but
    gets around the security implications because of the immutability of
    Git objects.

My second thought was that this is a more general problem. It's one for
config itself, and for other script programs you might point to via
config. So it seems like we should be able to come up with a solution
that is more general than just clean/smudge filters.

-Peff
