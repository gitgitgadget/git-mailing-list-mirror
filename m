Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7336C433DB
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 04:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3AD123AAC
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 04:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbhAWE7F (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 23:59:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:36264 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbhAWE7E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 23:59:04 -0500
Received: (qmail 18068 invoked by uid 109); 23 Jan 2021 04:58:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 23 Jan 2021 04:58:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23104 invoked by uid 111); 23 Jan 2021 04:58:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 22 Jan 2021 23:58:21 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 22 Jan 2021 23:58:19 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org
Subject: Re: git archive setting user and group
Message-ID: <YAus63jWBP1fIAhf@coredump.intra.peff.net>
References: <043f01d6f0fe$d6ad7660$84086320$@pdinc.us>
 <cef51cd3-c6b5-ed24-f695-83be3a6743b4@web.de>
 <20210122213954.7dlnnpngjoay3oia@chatter.i7.local>
 <YAt2PPM4HRcKva9a@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YAt2PPM4HRcKva9a@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 23, 2021 at 01:05:00AM +0000, brian m. carlson wrote:

> > Right now, "git archive" operations are bit-for-bit identical across all
> > versions going back at least 8+ years. In fact, we've been relying on this to
> > support bundling tarball signatures with git tags themselves (via git notes).
> > E.g. you can see this in action here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tag/?h=v5.10.9
> > 
> > If you click on "(sig)", you will download a signature that can be used to
> > verify the tarball generated using "git archive".
> 
> Please do not rely on this behavior.  I want to state in the strongest
> possible terms that this is not guaranteed behavior and it may change at
> any time.  We have explicitly said so on the list multiple times.  If
> you need reproducible archives, you need to add a tool to canonicalize
> them in a suitable format and not rely on Git to never change things.

I strongly second this. :)

It's also not quite true that things have remained bit-for-bit identical
for all that time. We have fixed bugs in that time, although they do not
always cause a change in every output tarball (they often depend on
corner cases like having long pathnames). Two off the top of my head
(that have indeed caused people to complain about changing checksums):

  - 22f0dcd963 (archive-tar: split long paths more carefully,
    2013-01-05)

  - 82a46af13e (archive-tar: fix pax extended header length calculation,
    2019-08-17)

We also rely on system gzip. That's pretty stable, but I have heard tell
that even `gzip -n` may differ on platforms.

Another fun one I saw recently: using export-subst with $Format:%h$ will
produce different results depending on how many objects are present in
the repository running git-archive.

-Peff
