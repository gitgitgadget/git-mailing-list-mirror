Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 343CC1F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 06:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbfKNGBg (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 01:01:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:47074 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725601AbfKNGBg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 01:01:36 -0500
Received: (qmail 22199 invoked by uid 109); 14 Nov 2019 06:01:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Nov 2019 06:01:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 977 invoked by uid 111); 14 Nov 2019 06:05:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 Nov 2019 01:05:09 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 14 Nov 2019 01:01:34 -0500
From:   Jeff King <peff@peff.net>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v2 05/11] object-store: allow threaded access to object
 reading
Message-ID: <20191114060134.GB10643@sigill.intra.peff.net>
References: <4c5652ab34f0989856aba919ca84b2b091dcad98.1569808052.git.matheus.bernardino@usp.br>
 <20191112025418.254880-1-jonathantanmy@google.com>
 <20191113052044.GB3547@sigill.intra.peff.net>
 <CAHd-oW4PtO2CKpd3HFgrJWmQf3MN+MHt5c7V6OGx33LgU-CrOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHd-oW4PtO2CKpd3HFgrJWmQf3MN+MHt5c7V6OGx33LgU-CrOQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 14, 2019 at 02:57:42AM -0300, Matheus Tavares Bernardino wrote:

> About the other parallel inflation calls on loose objects at
> unpack_loose_short_header(), unpack_loose_header_to_strbuf() and
> unpack_loose_rest(): could they suffer from a similar race problem?
> FWIU, the inflation input used in these cases comes from
> map_loose_object(), and it's not referenced outside this scope. So I
> think there's no risk of one thread munmapping the object file while
> other is inflating it. Is that right?

Right, I think loose objects would be fine, because the mmap'd content
is local to that stack variable.

> > A pthread_rwlock would work, but it would be the first use in Git. I
> > think we'd need to find an equivalent for compat/win32/pthread.h.
> 
> These[1][2] seems to be the equivalent options on Windows. I'll have
> to read these docs more carefully, but [2] seems to be more
> interesting in terms of speed. Also, the extra features of [1] are not
> really needed for our use case here.
> 
> [1]: https://docs.microsoft.com/en-us/windows-hardware/drivers/kernel/reader-writer-spin-locks
> [2]: https://docs.microsoft.com/en-us/windows/win32/sync/slim-reader-writer--srw--locks

Yeah, looks like it, but I don't have any expertise there (nor a Windows
system to test on).

-Peff
