Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2875A20986
	for <e@80x24.org>; Tue,  4 Oct 2016 13:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752553AbcJDNx5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 09:53:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:52008 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751918AbcJDNx4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 09:53:56 -0400
Received: (qmail 22068 invoked by uid 109); 4 Oct 2016 13:53:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 13:53:55 +0000
Received: (qmail 5074 invoked by uid 111); 4 Oct 2016 13:54:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 09:54:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Oct 2016 09:53:53 -0400
Date:   Tue, 4 Oct 2016 09:53:53 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 08/18] link_alt_odb_entry: refactor string handling
Message-ID: <20161004135353.6ywgoxutjcbaali5@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
 <20161003203448.cdfbitl5jmhlpb5o@sigill.intra.peff.net>
 <CA+P7+xrUOnDebwZnfu-xv-GuTJka4-eNUAfBudQf5ZhnkczU6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xrUOnDebwZnfu-xv-GuTJka4-eNUAfBudQf5ZhnkczU6w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 03, 2016 at 11:05:42PM -0700, Jacob Keller wrote:

> This definitely makes reading the following function much easier,
> though the diff is a bit funky. I think the end result is much
> clearer.

Yeah, it's really hard to see that all of the "ent" setup is kept,
because it moves _and_ changes its content (from pfxlen to pathbuf.len).

I actually tried to split this into two patches to make the diff easier
to read, but there are two mutually dependent changes: moving to
pathbuf.len everywhere requires not-freeing pathbuf in the early code
path. But if you do that and don't move all of "is it usable" checks up,
then you have to add a bunch of new error-handling code that would just
get ripped out in the next patch.

There's definitely _some_ of that in this series already (e.g., the
counting logic in alt_sha1_path() added by patch 14 that just gets
ripped out in patch 15 when fill_sha1_path() learns to use a strbuf). I
tried to balance "show each individual obvious step" with "don't make
people review a bunch of scaffolding that's not going to be in the final
product".

-Peff
