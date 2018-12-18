Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 121FE211B3
	for <e@80x24.org>; Tue, 18 Dec 2018 12:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbeLRMl3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Dec 2018 07:41:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:44736 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726403AbeLRMl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Dec 2018 07:41:29 -0500
Received: (qmail 15430 invoked by uid 109); 18 Dec 2018 12:41:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 18 Dec 2018 12:41:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12702 invoked by uid 111); 18 Dec 2018 12:41:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 18 Dec 2018 07:41:01 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Dec 2018 07:41:27 -0500
Date:   Tue, 18 Dec 2018 07:41:27 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 8/8] tests: mark tests broken under
 GIT_TEST_PROTOCOL_VERSION=2
Message-ID: <20181218124127.GB30471@sigill.intra.peff.net>
References: <xmqqimzygmz6.fsf@gitster-ct.c.googlers.com>
 <20181213155817.27666-9-avarab@gmail.com>
 <87pnu51kac.fsf@evledraar.gmail.com>
 <20181214101232.GC13465@sigill.intra.peff.net>
 <87o99o1iot.fsf@evledraar.gmail.com>
 <20181217195713.GA10673@sigill.intra.peff.net>
 <20181217231452.GA13835@google.com>
 <874lbb209x.fsf@evledraar.gmail.com>
 <20181218000227.GB13835@google.com>
 <8736qv18w4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8736qv18w4.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 18, 2018 at 10:28:27AM +0100, Ævar Arnfjörð Bjarmason wrote:

> I.e. have a repo with "master" and a "root-password" branch, where the
> "root-password" branch has content that's irresistible to "git repack"
> for delta purposes, do we end up sending the "root-password" content
> over on a fetch even when that branch isn't advertised & forbidden?
> 
> Or, if that fails are there ways to make it work? E.g. using hidden/* in
> combination with delta islands?

Delta islands wouldn't generally help here. They only tell us not to
store on-disk deltas that fetching clients aren't likely to be able to
reuse (i.e, they want X but will generally not have Y, so don't make a
delta there).

In the attacks I mentioned in my previous email, the deltas would
usually be computed on the fly for each fetch. So the lack of on-disk
deltas across "security boundaries" wouldn't help.

You could disable on-the-fly delta compression, but the resulting packs
are much larger (and you'd think it would save some server CPU, but
experiments I've done show that it helps a lot less than you'd think,
since we often end up zlib-deflating more bytes).

-Peff
