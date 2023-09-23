Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63880CE7A88
	for <git@archiver.kernel.org>; Sat, 23 Sep 2023 06:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjIWG6V (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Sep 2023 02:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjIWG6V (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2023 02:58:21 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE18719B
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 23:58:14 -0700 (PDT)
Received: (qmail 9576 invoked by uid 109); 23 Sep 2023 06:58:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 23 Sep 2023 06:58:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24894 invoked by uid 111); 23 Sep 2023 06:58:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 23 Sep 2023 02:58:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 23 Sep 2023 02:58:13 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/6] coverity: cache the Coverity Build Tool
Message-ID: <20230923065813.GC1469941@coredump.intra.peff.net>
References: <pull.1588.git.1695379323.gitgitgadget@gmail.com>
 <8420a76eba3eba3afdc7747af6d609ad8dbd8cb6.1695379323.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8420a76eba3eba3afdc7747af6d609ad8dbd8cb6.1695379323.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 22, 2023 at 10:41:59AM +0000, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> It would add a 1GB+ download for every run, better cache it.
> 
> This is inspired by the GitHub Action `vapier/coverity-scan-action`,
> however, it uses the finer-grained `restore`/`save` method to be able to
> cache the Coverity Build Tool even if an unrelated step in the GitHub
> workflow fails later on.

Nice. This is the big thing that I think the vapier action was providing
us, and it does not look too bad. I have never used actions/cache
before, but it all looks plausibly correct to me (and I assume you did a
few test-runs to check it).

One note:

> +      # The Coverity site says the tool is usually updated twice yearly, so the
> +      # MD5 of download can be used to determine whether there's been an update.
> +      - name: get the Coverity Build Tool hash
> +        id: lookup
> +        run: |
> +          MD5=$(curl https://scan.coverity.com/download/$COVERITY_LANGUAGE/$COVERITY_PLATFORM \
> +                   --data "token=${{ secrets.COVERITY_SCAN_TOKEN }}&project=$COVERITY_PROJECT&md5=1")
> +          echo "hash=$MD5" >>$GITHUB_OUTPUT

We probably want --fail here, too (and presumably &&-chaining) so that
we don't accidentally write a bogus cache entry. Possibly even check
that $MD5 isn't blank if we want to be double-paranoid.

That made me wonder: if we do end up with a bogus cache entry, how does
one clear it? And it looks like it can be managed directly via
https://github.com/$user/$project/actions/caches. Nice.

-Peff
