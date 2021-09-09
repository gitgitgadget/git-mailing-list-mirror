Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE30C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 19:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A737F6105A
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 19:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244705AbhIIT1v (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 15:27:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:43246 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237494AbhIIT1u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 15:27:50 -0400
Received: (qmail 621 invoked by uid 109); 9 Sep 2021 19:26:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Sep 2021 19:26:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15531 invoked by uid 111); 9 Sep 2021 19:26:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Sep 2021 15:26:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Sep 2021 15:26:39 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH 4/5] http: centralize the accounting of libcurl
 dependencies
Message-ID: <YTpf7yC+32LYRC4Z@coredump.intra.peff.net>
References: <cover-v4-0.5-00000000000-20210730T175650Z-avarab@gmail.com>
 <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
 <patch-4.5-47b513a261b-20210908T152807Z-avarab@gmail.com>
 <YTkPfyAYTU4ZgRgb@coredump.intra.peff.net>
 <xmqq5yv91wbn.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq5yv91wbn.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 09, 2021 at 10:40:44AM -0700, Junio C Hamano wrote:

> > Part of me is a little sad at the duplication this creates. We could
> > just be checking
> >
> >   #ifdef CURLOPT_TCP_KEEPALIVE
> >
> > in the second hunk, without the first one at all.
> 
> I recall having exactly the same reaction when the above pattern
> first was floated.  
> 
> I still do not see how the GITCURL_* duplication is worth it.  What
> do we want to gain from having a "central registry"?
> 
> If it is to see which ones we care about, would it be sufficient to
> use the hits from "git grep -e CURL" with postprocessing?

Just brain-storming:

  - It's probably a little easier to read, with the comments all
    together with the definitions (keeping in mind that some of these
    flags may need to be checked in several spots).

  - Likewise a few of the checks are non-trivial, with multiple ANDs, so
    it may be nicer to have a single registry (though the resulting
    "GIT_CURL_HAVE_X_and_Y_and_Z" are pretty ugly to me).

  - _Possibly_ it provides a knob for the user to say
    "-DGIT_CURL_HAVE_FOO=1" by overriding our auto-detection. But since
    most of these are "do we have FOO defined? Because are about to
    reference it in the code", I don't see what that override would buy
    you.

I dunno. I admit that I do not overly care that much. Handling curl
version dependencies was neglected for many years. If Ævar wants to take
a more active role in handling these and this is convenient for him, I'm
happy enough however it works.

-Peff
