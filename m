Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA34F1FC46
	for <e@80x24.org>; Tue,  7 Feb 2017 19:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754544AbdBGTev (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 14:34:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:50680 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754583AbdBGTeo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 14:34:44 -0500
Received: (qmail 21869 invoked by uid 109); 7 Feb 2017 19:28:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Feb 2017 19:28:03 +0000
Received: (qmail 27490 invoked by uid 111); 7 Feb 2017 19:28:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Feb 2017 14:28:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Feb 2017 14:28:01 -0500
Date:   Tue, 7 Feb 2017 14:28:01 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Cornelius Weig <cornelius.weig@tngtech.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC] mailmap.blob overrides default .mailmap
Message-ID: <20170207192801.qoncjaqjpn3axpyn@sigill.intra.peff.net>
References: <77c0182b-8c4f-9727-f56f-d8e2bad8146d@tngtech.com>
 <CAGZ79kZ=ikbYpuK6E=ui1ju=bRavcVcxb3AA_dvb2Jp6cRNmJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZ=ikbYpuK6E=ui1ju=bRavcVcxb3AA_dvb2Jp6cRNmJQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 07, 2017 at 09:27:19AM -0800, Stefan Beller wrote:

> > The code shows why (mailmap.c):
> >         err |= read_mailmap_file(map, ".mailmap", repo_abbrev);
> >         if (startup_info->have_repository)
> >                 err |= read_mailmap_blob(map, git_mailmap_blob, repo_abbrev);
> >         err |= read_mailmap_file(map, git_mailmap_file, repo_abbrev);
> >
> >
> > Apparently this is not an oversight, because there is an explicit
> > test for this overriding behavior (t4203 'mailmap.blob overrides
> > .mailmap').
> 
> which is blamed to 08610900 (mailmap: support reading mailmap from
> blobs, 2012-12-12),
> cc'ing Jeff who may remember what he was doing back then, as the
> commit message doesn't discuss the implications on ordering.

I think it was mostly that I had to define _some_ order. This made sense
to me as similar to things like attributes or excludes, where we prefer
clone-specific data over in-history data (so .git/info/attributes takes
precedence over .gitattributes).

So any mailmap.* would take precedence over the in-tree .mailmap file.
And then between mailmap.file and mailmap.blob, the "blob" form is
more "in-tree" than the "file" form (especially because we turn it on by
default in bare repos, so it really is identical to the in-tree form
there).

I think the easiest way to think of it is the same as we do config. We
read the files in a particular order, least-important to most-important,
and apply "last one wins" (so more-important entries overwrite
less-important ones).

-Peff
