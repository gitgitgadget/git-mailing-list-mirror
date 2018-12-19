Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 585C81F405
	for <e@80x24.org>; Wed, 19 Dec 2018 15:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbeLSPin (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 10:38:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:45796 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727542AbeLSPin (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 10:38:43 -0500
Received: (qmail 23500 invoked by uid 109); 19 Dec 2018 15:38:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 19 Dec 2018 15:38:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22122 invoked by uid 111); 19 Dec 2018 15:38:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 19 Dec 2018 10:38:15 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Dec 2018 10:38:41 -0500
Date:   Wed, 19 Dec 2018 10:38:41 -0500
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/3] setup: do not use invalid `repository_format`
Message-ID: <20181219153841.GB14802@sigill.intra.peff.net>
References: <20181218072528.3870492-1-martin.agren@gmail.com>
 <20181218072528.3870492-3-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181218072528.3870492-3-martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 18, 2018 at 08:25:27AM +0100, Martin Ågren wrote:

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
> 
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>

Hmm. It looks like we never set repo_fmt.hash_algo to anything besides
GIT_HASH_SHA1 anyway. I guess the existing field is really just there in
preparation for us eventually respecting extensions.hashAlgorithm (or
whatever it's called).

Given what I said in my previous email about repos with a missing
"version" field, I wondered if this patch would be breaking config like:

  [core]
  # no repositoryformatversion!
  [extensions]
  hashAlgorithm = sha256

But I'd argue that:

  1. That's pretty dumb config that we shouldn't need to support. Even
     if we care about handling the missing version for historical repos,
     they wouldn't be talking sha256.

  2. Arguably we should not even look at extensions.* unless we see a
     version >= 1. But we do process them as we parse the config file.
     This is mostly an oversight, I think. We have to handle them as we
     see them, because they may come out of order with respect to the
     repositoryformatversion field. But we could put them into a
     string_list, and then only process them after we've decided which
     version we have.

So I think your patch is doing the right thing, and won't hurt any real
cases. But (of course) there are more opportunities to clean things up.

-Peff
