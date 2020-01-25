Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664E0C2D0CE
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 00:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6B4205F4
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 00:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387469AbgAYAFn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 19:05:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:44234 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2387405AbgAYAFn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 19:05:43 -0500
Received: (qmail 9154 invoked by uid 109); 25 Jan 2020 00:05:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 25 Jan 2020 00:05:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12284 invoked by uid 111); 25 Jan 2020 00:12:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Jan 2020 19:12:54 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Jan 2020 19:05:42 -0500
From:   Jeff King <peff@peff.net>
To:     David =?utf-8?B?QnVyc3Ryw7Zt?= <davidburstrom@spotify.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Bug or unexpected behaviour in git show <rev>:a\b
Message-ID: <20200125000542.GA566779@coredump.intra.peff.net>
References: <CAA-mk2_jB2X1J-NCXQ92spa-fmEct9G9f1iQo7t8=rvD5coFDA@mail.gmail.com>
 <20200124190119.GB1672342@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200124190119.GB1672342@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 24, 2020 at 02:01:19PM -0500, Jeff King wrote:

> Also, unrelated to your problem, but I find it interesting in the output
> above that "git show HEAD:foo --" produces a less useful error message
> than "git show HEAD:foo" without the separator, even though the user has
> given us even more information about their intent. I think the DWIM
> verify_filename() has grown a lot more diagnosis code over the years
> that could also be used in the other code path.

I took a look at this, but it gets ugly pretty quickly, so I gave up.
The problem is that all of the good errors are produced by get_oid()
with GET_OID_ONLY_TO_DIE, but the moment where we decide to produce the
bad error is sometimes removed from the get_oid() call. E.g., in
something like "a..b", we'd want to report on whichever of "a" or "b"
caused a problem, but at the point of reporting the error, we only have
the unparsed "a..b".

Certainly this can be overcome, but it seemed like a rabbit-hole that I
didn't feel like going down today. Anybody is welcome to give it a shot.
I suspect the whole thing would be simpler if get_oid() could optionally
return an error string to the caller, instead of forcing us to call it a
second time with the "only to die" flag.

Speaking of which, I did go part-way down a different rabbit-hole in
preparation, and ended up with these patches. So it seemed worth posting
them.

  [1/3]: t1400: avoid "test" string comparisons
  [2/3]: t1506: drop space after redirection operator
  [3/3]: sha1-name: mark get_oid() error messages for translation

 sha1-name.c                    | 30 +++++++++++------------
 t/t1400-update-ref.sh          | 36 ++++++++++++++++++----------
 t/t1506-rev-parse-diagnosis.sh | 44 +++++++++++++++++-----------------
 3 files changed, 61 insertions(+), 49 deletions(-)

-Peff
