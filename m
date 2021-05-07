Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6DAC433B4
	for <git@archiver.kernel.org>; Fri,  7 May 2021 03:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21A776101D
	for <git@archiver.kernel.org>; Fri,  7 May 2021 03:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhEGD0y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 23:26:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:47058 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230366AbhEGD0y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 23:26:54 -0400
Received: (qmail 31940 invoked by uid 109); 7 May 2021 03:25:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 07 May 2021 03:25:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29207 invoked by uid 111); 7 May 2021 03:25:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 06 May 2021 23:25:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 6 May 2021 23:25:54 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jason Gore <Jason.Gore@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git clean enumerates ignored directories (since 2.27)
Message-ID: <YJSzQm2p5bCAd8Fv@coredump.intra.peff.net>
References: <DM6PR00MB06829EC5B85E0C5AC595004E894E9@DM6PR00MB0682.namprd00.prod.outlook.com>
 <YHdzDlAfsuZ21HR7@camp.crustytoothpaste.net>
 <YHf+m7vOQumdJXwX@coredump.intra.peff.net>
 <CABPp-BH3tbTyA9gj=2vb878d1MQVCTqT7=kS5U+sB6CoDX0Jww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BH3tbTyA9gj=2vb878d1MQVCTqT7=kS5U+sB6CoDX0Jww@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 06, 2021 at 07:31:40PM -0700, Elijah Newren wrote:

> On alpine linux-musl, I get an "error: Tests passed but test cleanup
> failed; aborting", which makes it report as a failed build.  I'm not
> sure how to fix it and am asking for ideas.
> 
> Apparently the deeply nested directory hierarchy cannot be removed on
> that platform with a simple "rm -rf $dirname".  It throws a "rm: can't
> stat '/__w/git/git/t/trash
> directory.t7300-clean/avoid-traversing-deep-hierarchy/directory400/directory399/directory398/.....(you
> get the idea)....': Filename too long" error message.[1]
> 
> Adding a "test_when_finished find directory400 -delete" also gives a
> "Filename too long" message followed by a lot of "Directory not empty"
> messages.[2]
> 
> Anyone have any bright ideas about how to tweak this test?  See [3]
> for the current incarnation of the code, which was basically taken
> from Brian's sample testcase.

My guess is that that version of "rm" is trying to feed the entire
pathname directly to unlink() and rmdir(), and it exceeds PATH_MAX.

Even with GNU tools, for instance, I get:

  $ rmdir $(find avoid-traversing-deep-hierarchy -type d | tail -1)
  rmdir: failed to remove 'avoid-traversing-deep-hierarchy/directory400/
    [...and so on...]/directory1': File name too long

because it feeds the whole to a single rmdir() call. Whereas stracing
GNU "rm -rf", it uses unlinkat() and openat() to delete each level
individually (probably to avoid this exact problem).

Is the actual path length important, or just the depth? If the latter,
then calling it "d400/d399/.../d2/d1" would likely help, as that's less
than 2000 bytes.

-Peff
