Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6303EC433E1
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 20:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 409012065F
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 20:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgGXUAn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 16:00:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:37528 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726503AbgGXUAn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 16:00:43 -0400
Received: (qmail 24867 invoked by uid 109); 24 Jul 2020 20:00:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Jul 2020 20:00:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26370 invoked by uid 111); 24 Jul 2020 20:00:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Jul 2020 16:00:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Jul 2020 16:00:42 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Tommaso Ercole <Tommaso.Ercole@qlik.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Creation of a branch named that has a directory prefix equal to
 the name of another branch fail.
Message-ID: <20200724200042.GC4013174@coredump.intra.peff.net>
References: <DM5PR1801MB2076F807C0B9F29A152DBEB7F0760@DM5PR1801MB2076.namprd18.prod.outlook.com>
 <DM5PR1801MB20762477763E6298C7FE6315F0770@DM5PR1801MB2076.namprd18.prod.outlook.com>
 <20200724160045.GA10590@syl.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200724160045.GA10590@syl.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 24, 2020 at 12:00:45PM -0400, Taylor Blau wrote:

> On Fri, Jul 24, 2020 at 10:26:14AM +0000, Tommaso Ercole wrote:
> > As per compiled bug report, creation of a branch that has a prefix that map to a folder, when that prefix is just an existing branch in the repo fails.
> >
> > I.E. 'a/b/c' when 'a/b' just exists.
> 
> This is a known limitation of loose references, since each reference is
> stored in a file in $GITDIR/refs.
> 
> Reftable support within Git will lift this limitation. In the meantime,
> if your references aren't updated you can store them as packed refs
> which don't have this limitation, but note that they will be expanded
> loose if you touch them again (i.e., this is a good solution for tags,
> but not development branches).

Note that even though packed-refs does not have this limitation, we
still enforce it in order to avoid headaches when moving between loose
and packed refs.

Likewise, we'll probably[1] continue to enforce it with reftables, at
least for a while, to make things less confusing when pushing and
pulling between repositories with different storage. If reftables become
the widespread default, then I imagine we'd consider loosening it then
(or alternatively, adding a config option for people who want the
flexibility and don't mind the interoperability cost).

-Peff

[1] I didn't actually check what the current reftable patches do, but
    that's my recollection from discussions long ago.
