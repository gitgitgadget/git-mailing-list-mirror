Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DFDC432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 21:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D15F060F58
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 21:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbhH0Vbr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 17:31:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:60958 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231696AbhH0Vbq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 17:31:46 -0400
Received: (qmail 10064 invoked by uid 109); 27 Aug 2021 21:30:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 27 Aug 2021 21:30:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16367 invoked by uid 111); 27 Aug 2021 21:30:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 27 Aug 2021 17:30:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 27 Aug 2021 17:30:56 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v4 00/25] multi-pack reachability bitmaps
Message-ID: <YSlZkMhD1vlc/48i@coredump.intra.peff.net>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1629821743.git.me@ttaylorr.com>
 <YSWOtNoxirDdmBXG@coredump.intra.peff.net>
 <YSWmhMID1hGs7Yp1@nand.local>
 <YSXy73lWKteiuY6s@coredump.intra.peff.net>
 <YSfiJmYMPPyEueUG@nand.local>
 <YSgGBxh24UAZR5X3@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YSgGBxh24UAZR5X3@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 26, 2021 at 05:22:15PM -0400, Taylor Blau wrote:

> > I did some research[1] on what parts of `--object-dir` have worked (and not
> > worked) in the past, and came to the conclusion that although this
> > behavior is surprising, we do bear the responsibility of continuing to
> > maintain it.
> 
> Hmm. Upon thinking on in more, here is some evidence to the contrary.
> The new test, specifically this snippet:
> 
>     git init repo &&
>     test_when_finished "rm -fr repo" &&
>     (
>       cd repo &&
>       test_commit base &&
>       git repack -d
>     ) &&
> 
>     nongit git multi-pack-index --object-dir=$(pwd)/repo/.git/objects write
> 
> will fail with GIT_TEST_DEFAULT_HASH=sha256, since the MIDX internals
> settle on the hash size via `the_hash_algo` which doesn't respect the
> hash algorithm used by the target repository.

Yeah, I think this is a good example of the class of things that might
fail: anything that requires the repo config to behave correctly.

I do think the hash format is somewhat unusual here. Most of the changes
to the on-disk files are reflected in the files themselves (e.g., pack
index v2 is chosen by config at _write_ time, but readers can interpret
the file stand-alone).

There may be other config that could influence the writing of the midx,
and we'd skip it in this kind of non-repo setup. An example here is
repack.usedeltabaseoffset, which midx_repack() tries to respect.
Ignoring that doesn't produce a nonsense result, but it doesn't follow
what would happen if run from inside the repo.

The other class of problems I'd expect is where part of the midx
operation needs to look at other parts of the repo. Bitmap generation is
an obvious one there, since we'd want to look at refs to find the
reachable tips. Now obviously that's a new feature we're trying to
introduce here, so it can't be an existing breakage. But it does make me
wonder what other problems might be lurking.

So I dunno. Even if it mostly works now, I'm not sure it's something
that I'm all that happy about supporting going forward. It seems like a
recipe for subtle bugs where the midx code calls into other library code
that assumes that it can look at the repository struct.

-Peff
