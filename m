Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE64C433E5
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 17:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42391207BB
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 17:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbgGWRrt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:47:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:36240 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbgGWRrt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 13:47:49 -0400
Received: (qmail 16033 invoked by uid 109); 23 Jul 2020 17:47:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Jul 2020 17:47:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13532 invoked by uid 111); 23 Jul 2020 17:47:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Jul 2020 13:47:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 23 Jul 2020 13:47:47 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] sha1-file: make pretend_object_file() not prefetch
Message-ID: <20200723174747.GA3975154@coredump.intra.peff.net>
References: <20200721225020.1352772-1-jonathantanmy@google.com>
 <xmqq4kq078ks.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4kq078ks.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 21, 2020 at 04:27:15PM -0700, Junio C Hamano wrote:

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > When pretend_object_file() is invoked with an object that does not exist
> > (as is the typical case), there is no need to fetch anything from the
> > promisor remote, because the caller already knows what the object is
> > supposed to contain. Therefore, suppress the fetch. (The
> > OBJECT_INFO_QUICK flag is added for the same reason.)
> 
> Yes, "pretend" is also a way to lie about the contents IIRC, so even
> if the object is available elsewhere, we should *not* fetch from the
> promisor.  Makes sense to me.

I agree this patch is fine, but I wonder if it could go even further. If
we are pretending some particular contents, shouldn't we override
anything that might be in the object database? I.e., could we eliminate
this has_object_file() entirely?

That should be OK for the same reason that it's OK to use QUICK.

There's only one caller of this function (git-blame), which I think
would be happy with such a change.

-Peff
