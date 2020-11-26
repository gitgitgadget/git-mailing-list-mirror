Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BA3C56202
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 08:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3909720857
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 08:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388571AbgKZICT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Nov 2020 03:02:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:43504 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbgKZICS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Nov 2020 03:02:18 -0500
Received: (qmail 15242 invoked by uid 109); 26 Nov 2020 08:02:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 26 Nov 2020 08:02:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14561 invoked by uid 111); 26 Nov 2020 08:02:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Nov 2020 03:02:18 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Nov 2020 03:02:17 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH 07/12] fsck: add new "extra" checks for "mktag"
Message-ID: <X79hCWF8jDZBw/NG@coredump.intra.peff.net>
References: <X7wq3ba3QoxjyyrQ@coredump.intra.peff.net>
 <20201126012854.399-8-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201126012854.399-8-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 26, 2020 at 02:28:49AM +0100, Ævar Arnfjörð Bjarmason wrote:

> Add optional "extra" checks to fsck, these are needed to eventually
> replace the custom not-quite-fsck code in mktag.c.
> 
> The mktag checks differ from fsck_tag() in several ways, one of those
> is that fsck doesn't know how to refuse an object with custom headers,
> and isn't strict about header and body newline separation.
> 
> Teach it how to optionally report these. I thought the best way to do
> that given the current structure of the code was to add a new "extra"
> category in addition to error/warn/info.

Hmm, this new severity (and the extra options bit) feels a bit
backwards. We are already passing the information on what we find to the
report() callback. It seems like that is the place that should be
deciding what is important and what is not.

Unfortunately the defaults are somewhat backwards here. We'd have to
teach the fsck callbacks to ignore these harmless entries, rather than
teaching the mktag caller that they need to be respected.

So probably the extra bit in options to say "do these extra tag checks"
is the least-bad thing. But then why do we need to put them in their own
EXTRA section? The only caller that wants them would treat them as
errors.

I'm slightly on the fence on whether mktag really needs to enforce the
"unknown header" thing at all. Sure, we don't encourage them, but it's a
plumbing tool one could use to experiment with new headers. I guess the
downside is that a typo'd header would not be caught.

> Under --strict the "info"
> becomes a "warn" and "warn" becomes "error". Existing users of
> fsck's (and others, e.g. index-pack) --strict option rely on this.

Yeah, this is a weirdness I think we should eventually fix (along with
re-prioritizing some of the existing checks). I'm wary of doing anything
that further cements that somewhat broken world-view (keep in mind that
"index-pack --strict" is not "do fsck more strictly" but "do fsck at
all").

> I'm not changing fsck_commit() to validate commit objects like this
> either, we could do that, but unlike in the tag case that code
> wouldn't be used anywhere. If someone wants to write a "mkcommit" they
> which behaves like "mktag" they can borrow or refactor this logic for
> use in fsck_commit().

Seems reasonable.

-Peff
