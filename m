Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1F8C433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 15:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0A7B611C5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 15:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbhIJP3n (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 11:29:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:44044 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234130AbhIJP3m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 11:29:42 -0400
Received: (qmail 6116 invoked by uid 109); 10 Sep 2021 15:28:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Sep 2021 15:28:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26156 invoked by uid 111); 10 Sep 2021 15:28:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Sep 2021 11:28:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Sep 2021 11:28:30 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH 2/5] http: correct curl version check for
 CURLOPT_PINNEDPUBLICKEY
Message-ID: <YTt5nhXfZ8CRYayk@coredump.intra.peff.net>
References: <cover-v4-0.5-00000000000-20210730T175650Z-avarab@gmail.com>
 <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
 <patch-2.5-511534ce17a-20210908T152807Z-avarab@gmail.com>
 <YTkNdGk28UJnSDVt@coredump.intra.peff.net>
 <xmqqv939wdgl.fsf@gitster.g>
 <YTtpWADzTJEAIvk+@coredump.intra.peff.net>
 <87tuiscwso.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tuiscwso.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 10, 2021 at 04:37:48PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > I don't have a sense of whether the functionality difference between
> > 7.39 and 7.44 actually matters.
> 
> For what it's worth I tested this as part of re-rolling, i.e. I grabbed
> the tarball for 7.39[1].
> 
> By using the correct version number of 7.39 we'll support pinned public
> keys there, but if you supply e.g. the "sha256/[...]" format we'll
> instead of printing a warning about this version not supporting pinned
> keys, we'll die with an error from curl itself.

Thanks for testing that. That was really my one concern: that by not
issuing our own error for the semi-functional version, we might fail to
notice it entirely, putting people on that older version in a worse
spot. But it sounds like we (and curl) do the right thing.

> Aside from 7.39..7.44 though it does seem like a really bad thing to do
> to just warn that we don't support pinned public keys, but proceed with
> the request anyway (which could also be a push).
> 
> I don't think it's worth changing that s/warning/die/g now, since the
> target audience for a new git release with such an ancient curl version
> is probably zero, or near enough to be zero.

Yeah, agreed. When we introduce optional features we should try to make
sure that they fail in the safest direction (assuming the user has
explicitly asked to use them, as in this case). But given the age and
history here, I'm not sure it matters that much at this point. On the
other hand, if it really is s/warning/die/, that's easy enough to do. I
could go either way.

> I mean, we do have new git + old OS, but it tends to be *specific* old
> versions, namely for releases of this age the one released with RHEL. I
> think pretty nobody else does that (the rest are probably all
> RHEL-derived). Per 013c7e2b070 (http: drop support for curl < 7.16.0,
> 2021-07-30) none of the RHEL out there have a curl in the 7.39..7.44
> range.

I don't think the specific version range matters here. If I had curl
7.19.4 (for example) and tried to use the pinning feature I'd get a
warning but we'd continue without using the pinned key, which is
dangerous. That's true both before and after your patches.

> The commit doesn't note the RHEL 8 version (which b.t.w., is something I
> added to it, not you), but it seems to be 7.61.1[2]. So at least as far
> as RHEL goes we'll never be stuck in the 7.39..7.44 range..
> 
> 1. protip: curl.git git tags are rather useless, since (at least for old
>    versions) the embedded version number is bumped sometime *after* the
>    release).
> 
>    I also ran "diff -ru" on at least one old tag/tarball (I forget
>    which) and there were a lot of changes (and not just some "make dist"
>    stuff like autoconf files, version numbers or whatever).
> 
>    So in testing this I stopped using curl.git for anything but "git log
>    -G<str>" searching and the like, and just tested with archived
>    release tarballs.

Interesting to note. I'd always looked at curl.git in the past.

-Peff
