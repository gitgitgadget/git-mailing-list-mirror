Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67935C55189
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 08:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44AA1206E9
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 08:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgDVIJy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 04:09:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:35566 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726539AbgDVIJv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 04:09:51 -0400
Received: (qmail 4391 invoked by uid 109); 22 Apr 2020 08:09:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 Apr 2020 08:09:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27356 invoked by uid 111); 22 Apr 2020 08:20:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Apr 2020 04:20:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 22 Apr 2020 04:09:50 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Dennis Clarke <dclarke@blastwave.org>, git@vger.kernel.org
Subject: Re: minor patch required to compile git 2.26.1 on Oracle Solaris 10
 with Oracle Studio
Message-ID: <20200422080950.GA464427@coredump.intra.peff.net>
References: <6bf94982-71c4-78e9-0f4d-7fa4e485c417@blastwave.org>
 <xmqqzhb8rqa6.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzhb8rqa6.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 18, 2020 at 10:35:45PM -0700, Junio C Hamano wrote:

> Dennis Clarke <dclarke@blastwave.org> writes:
> 
> > Very minor patch required :
> 
> But both size_t and unsigned int are wrong types, no?  Shouldn't we
> be using socklen_t (and we seem to have autoconf support to figure
> out an appropriate socklen_t fallback typedef)?

That is generally the right type according to POSIX, but I think there's
something even more subtle going on. If we're defining our own
inet_ntop(), then the type shouldn't really matter, should it?

Dennis didn't show us the compiler errors, but my suspicion is that it
is complaining because it is seeing the definition of inet_ntop()
already from a system header, and ours does not match.

Which implies that NO_INET_NTOP should not be set in the first place.
I think this is the same issue discussed in:

  https://lore.kernel.org/git/CAH8yC8m3JFvEcfFF3z1rrRnEPK-adHGObmkOhNZiph7QJKUWqA@mail.gmail.com/

with a patch (which needs at least a signoff added) in:

  https://lore.kernel.org/git/CAH8yC8kaWXbN+RYMJnM9em7KKW54+N07JtyS1MZk0qppD=m2BA@mail.gmail.com/

Dennis, does building with:

  make NO_INET_NTOP= NO_INET_PTON=

help?

-Peff
