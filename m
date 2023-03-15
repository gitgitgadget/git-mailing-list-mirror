Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAE3C61DA4
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 17:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbjCORta (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 13:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjCORt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 13:49:28 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849EE7BA0D
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 10:49:06 -0700 (PDT)
Received: (qmail 18607 invoked by uid 109); 15 Mar 2023 17:49:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Mar 2023 17:49:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2623 invoked by uid 111); 15 Mar 2023 17:49:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Mar 2023 13:49:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Mar 2023 13:49:05 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        vdye@github.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 1/8] for-each-ref: add --stdin option
Message-ID: <ZBIFEXuE5Um9Z4zM@coredump.intra.peff.net>
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
 <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
 <a1d9e0f6ff6660c9264673be18bc24956f74eb9c.1678468864.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a1d9e0f6ff6660c9264673be18bc24956f74eb9c.1678468864.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 10, 2023 at 05:20:56PM +0000, Derrick Stolee via GitGitGadget wrote:

> When a user wishes to input a large list of patterns to 'git
> for-each-ref' (likely a long list of exact refs) there are frequently
> system limits on the number of command-line arguments.
> 
> Add a new --stdin option to instead read the patterns from standard
> input. Add tests that check that any unrecognized arguments are
> considered an error when --stdin is provided. Also, an empty pattern
> list is interpreted as the complete ref set.
> 
> When reading from stdin, we populate the filter.name_patterns array
> dynamically as opposed to pointing to the 'argv' array directly. This
> requires a careful cast while freeing the individual strings,
> conditioned on the --stdin option.

This is a nice feature to have, but I suspect like other pattern
features in Git (e.g., pathspecs), the matching is linear, and thus
pre-expanding the set of refs you're interested in becomes accidentally
quadratic.

And that seems to be the case here. If I have N refs and feed the whole
set as patterns via --stdin:

-- >8 --
for i in 4000 8000 16000 32000; do
  rm -rf repo
  git init -q repo
  (
    cd repo
    git commit --allow-empty -qm foo
    perl -e '
      my ($oid, $n) = @ARGV;
      print "create refs/heads/branch$_ $oid\n" for (1..$n);
    ' $(git rev-parse HEAD) $i |
    git update-ref --stdin
    git for-each-ref --format='%(refname)' >refs
    echo -n "$i: "
    command time -f %U \
      git.compile for-each-ref --stdin <refs 2>&1 >/dev/null
  )
done
-- 8< --

then the result quadruples for every doubling of the refs.

  4000: 0.32
  8000: 1.33
  16000: 5.10
  32000: 20.90

That may or may not be a show-stopper for your use case, and if not,
I don't think it's something we need to address immediately. But we may
want some kind of "literal" mode, that takes in a list of refs rather
than a list of patterns, and does a sorted-merge with the list of
available refs (or uses a hash table, I guess, but for-each-ref also
tries to avoid even being linear in the total number of refs, so you'd
still want to find the lowest/highest to bound the iteration).

-Peff
