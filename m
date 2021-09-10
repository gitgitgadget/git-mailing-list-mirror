Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04008C433FE
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 14:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEEFF61026
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 14:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbhIJOUS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 10:20:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:43894 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233973AbhIJOUR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 10:20:17 -0400
Received: (qmail 5835 invoked by uid 109); 10 Sep 2021 14:19:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Sep 2021 14:19:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25470 invoked by uid 111); 10 Sep 2021 14:19:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Sep 2021 10:19:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Sep 2021 10:19:04 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH 2/5] http: correct curl version check for
 CURLOPT_PINNEDPUBLICKEY
Message-ID: <YTtpWADzTJEAIvk+@coredump.intra.peff.net>
References: <cover-v4-0.5-00000000000-20210730T175650Z-avarab@gmail.com>
 <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
 <patch-2.5-511534ce17a-20210908T152807Z-avarab@gmail.com>
 <YTkNdGk28UJnSDVt@coredump.intra.peff.net>
 <xmqqv939wdgl.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv939wdgl.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 09, 2021 at 04:12:26PM -0700, Junio C Hamano wrote:

> > But in terms of compiling, all we care about is that the constant is
> > there. So I think the cutoff point you found is what we want. Presumably
> > when the file format isn't supported we'd get some error, though it's
> > not clear if that would come during the actual curl_*_perform(), or if
> > we should be checking the curl_easy_setopt() result.
> 
> If we were evaluating a patch to add support for pinnedpublickey
> afresh back in, say, 2017, perhaps we cared enough about the
> distinction between 7.39 and 7.44 (Nov 2014 and Aug 2015,
> respectively), but I'd say cut-off at 7.44 for this, once it is
> written and committed in our codebase, is good enough for us.
> 
> If the code originally had cut-off at 7.39 and we were raising the
> floor to 7.44 with "sha256 weren't usable before that version" as
> the justification, it would be a totally different situation and it
> may be worth the code change, but I am not sure if going backwards
> is worth it.
> 
> So, I dunno.

I don't have a sense of whether the functionality difference between
7.39 and 7.44 actually matters.

I just saw it as: if you have 7.39 then before it would not work because
we didn't bother to compile it, and after it _might_ work depending on
how you use it. So it's a strict increase in functionality. Likewise, if
you compile Git against 7.39 and then later upgrade the shared library,
you'd get the increased functionality.

But I admit I don't really care that much, either. This is an
obscure-ish feature in a 7 year old version of libcurl we are talking
about.

But there is one thing that does get weird if we don't do this patch. If
we later take the approach of checking:

  #ifdef CURLOPT_PINNEDPUBLICKEY

then that will subtly shift the cutoff point from 7.44 to 7.39 anyway.
_If_ we are going to do that conversion in a later patch (as this series
does), I think it makes sense to shift the version number explicitly in
a commit with an explanation, as this commit does.

-Peff
