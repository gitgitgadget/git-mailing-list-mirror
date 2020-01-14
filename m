Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E68C33C9E
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 21:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9076D24656
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 21:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgANVbL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 16:31:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:36602 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726491AbgANVbL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 16:31:11 -0500
Received: (qmail 10314 invoked by uid 109); 14 Jan 2020 21:31:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 Jan 2020 21:31:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25514 invoked by uid 111); 14 Jan 2020 21:37:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Jan 2020 16:37:26 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Jan 2020 16:31:10 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 0/8] Harden the sparse-checkout builtin
Message-ID: <20200114213110.GE3949560@coredump.intra.peff.net>
References: <pull.513.git.1579029962.gitgitgadget@gmail.com>
 <20200114193405.GA8674@syl.local>
 <c05c7dcb-43b4-dcf8-bc5d-e162f0b2d1a4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c05c7dcb-43b4-dcf8-bc5d-e162f0b2d1a4@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 14, 2020 at 02:44:50PM -0500, Derrick Stolee wrote:

> Since we've already worked out the workaround to be:
> 
> 	git clone --no-checkout <url> <dir>
> 	cd <dir>
> 	git sparse-checkout init --cone
> 
> there is no rush to fix this. Users _may_ discover the --sparse option
> from the clone docs and complain, but we can point them to the above
> directions for now.

Yes, but part of the beauty of the new system is just having to say
"--sparse" to make something useful happen. :)

> > Of course, if there's ever another need for v2.25.1, I don't think that
> > this would *hurt* to release then, which is to say that we definitely
> > should have these patches in a release, soon, but I don't think that
> > there's a terrible sense of urgency in the meantime.
> 
> I wouldn't complain to have patches 1-3 in an otherwise-warranted .1 release.

Agreed. 1-3 look obviously correct to me. The quoting bits I'm a little
more fuzzy on, just because I haven't really looked hard into cone mode.
Ditto for the "disable cone mode" checks.

My gut instinct is that you should be able to deduce whether the pattern
hashmap can be used purely from the patterns you see, and
core.sparseCheckoutCone would not be needed (and so if you violate the
rules by writing something manual, then it just gets slower; or maybe
we're even able to apply the literal cone-mode rules quickly and handle
the other separately). But it's much more likely I'm showing off my lack
of knowledge of the details of the problem space. You can feel free to
educate me, and/or roll your eyes and ignore me if this was already
discussed earlier.

By the way, I did notice this while poking about, which could go on top
(or hopefully be lumped in with the 1-3 as "obviously correct"):

-- >8 --

Subject: [PATCH] sparse-checkout: fix documentation typo for core.sparseCheckoutCone

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-sparse-checkout.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 974ade2238..285893b069 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -106,7 +106,7 @@ The full pattern set allows for arbitrary pattern matches and complicated
 inclusion/exclusion rules. These can result in O(N*M) pattern matches when
 updating the index, where N is the number of patterns and M is the number
 of paths in the index. To combat this performance issue, a more restricted
-pattern set is allowed when `core.spareCheckoutCone` is enabled.
+pattern set is allowed when `core.sparseCheckoutCone` is enabled.
 
 The accepted patterns in the cone pattern set are:
 
-- 
2.25.0.639.gb9b1511416

