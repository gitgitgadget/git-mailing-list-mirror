Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA6CC43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 05:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F02B2072B
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 05:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbfLQF2N (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 00:28:13 -0500
Received: from cloud.peff.net ([104.130.231.41]:48302 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725796AbfLQF2N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 00:28:13 -0500
Received: (qmail 29757 invoked by uid 109); 17 Dec 2019 05:28:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 17 Dec 2019 05:28:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19698 invoked by uid 111); 17 Dec 2019 05:32:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 17 Dec 2019 00:32:49 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 17 Dec 2019 00:28:12 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Emily Shaffer <emilyshaffer@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] Makefile: drop GEN_HDRS
Message-ID: <20191217052812.GB2762303@coredump.intra.peff.net>
References: <xmqq1rt7hkp6.fsf@gitster-ct.c.googlers.com>
 <20191214003820.GA927924@coredump.intra.peff.net>
 <20191214010002.GA945704@coredump.intra.peff.net>
 <xmqqlfrcje1f.fsf@gitster-ct.c.googlers.com>
 <20191216192014.GA2678964@coredump.intra.peff.net>
 <20191217014321.GF10734@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191217014321.GF10734@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 16, 2019 at 05:43:21PM -0800, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > I actually wonder if the whole thing would be simpler if command-list.h
> > was a static tracked file with the declarations, and we generated
> > command-list.c with "extern const char *command_list[]", etc.
> 
> Right, or a "command-list.inc" file.
> 
> extern-ing it seems like the simplest way to go.

If only. I took a brief look at this. Besides the Makefile chaos (did
you know that the vcxproj rule manually builds and git-adds
command-list.h? No idea what is going on there), it looks like we
dynamically generate the category bitfield, which is then used directly
in help.c. We _could_ declare those bitfields as externs themselves, but
part of the point is that the full list of categories is generated
dynamically from command-list.txt.

So we'd either split the list into two (one list of categories special
enough to be manually declared, and the rest that get generated
automatically) or we'd end up just duplicating the whole list.

Certainly this could all be untangled, but given that the system is
working just fine as it is, it doesn't seem worth anybody's time (and
the risk of weird follow-on problems) to adjust it.

-Peff
