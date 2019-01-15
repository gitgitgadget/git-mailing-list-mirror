Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C135D1F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 19:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389304AbfAOTbP (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 14:31:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:37310 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731685AbfAOTbP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 14:31:15 -0500
Received: (qmail 25282 invoked by uid 109); 15 Jan 2019 19:31:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 15 Jan 2019 19:31:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12749 invoked by uid 111); 15 Jan 2019 19:31:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 15 Jan 2019 14:31:16 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Jan 2019 14:31:13 -0500
Date:   Tue, 15 Jan 2019 14:31:13 -0500
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 2/3] setup: do not use invalid `repository_format`
Message-ID: <20190115193112.GE4886@sigill.intra.peff.net>
References: <20181218072528.3870492-1-martin.agren@gmail.com>
 <cover.1547488709.git.martin.agren@gmail.com>
 <a7e58385290e6789105d2d5b794f4bf8607285dd.1547488709.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7e58385290e6789105d2d5b794f4bf8607285dd.1547488709.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 14, 2019 at 07:34:56PM +0100, Martin Ågren wrote:

> If `read_repository_format()` encounters an error, `format->version`
> will be -1 and all other fields of `format` will be undefined. However,
> in `setup_git_directory_gently()`, we use `repo_fmt.hash_algo`
> regardless of the value of `repo_fmt.version`.
> 
> This can be observed by adding this to the end of
> `read_repository_format()`:
> 
> 	if (format->version == -1)
> 		format->hash_algo = 0; /* no-one should peek at this! */
> 
> This causes, e.g., "git branch -m q q2 without config should succeed" in
> t3200 to fail with "fatal: Failed to resolve HEAD as a valid ref."
> because it has moved .git/config out of the way and is now trying to use
> a bad hash algorithm.
> 
> Check that `version` is non-negative before using `hash_algo`.
> 
> This patch adds no tests, but do note that if we skip this patch, the
> next patch would cause existing tests to fail as outlined above.

I'm still somewhat confused about how this breaks. If we move
".git/config" out of the way, then we have no version indicator and
presumably we should guess GIT_HASH_SHA1. Which is what's happening if
we fail to call repo_set_hash_algo(), no?  In other words, wouldn't
repo_set_hash_algo() always be a noop in that case?

I get why adding the code snippet above would cause that assumption to
break, but I am just not sure why we would add that code snippet. ;)

I also get why read_repository_format() doing this in patch 3 would be a
problem:

  +       if (format->version == -1) {
  +               clear_repository_format(format);
  +               format->version = -1;
  +       }

but doesn't that point out that clear_repository_format() should be
setting hash_algo to GIT_HASH_SHA1 as the default (and likewise "bare =
-1", etc, that is done in that function)?

-Peff
