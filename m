Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 542A520A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 10:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbeLKKIo (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 05:08:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:37866 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726104AbeLKKIn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 05:08:43 -0500
Received: (qmail 13050 invoked by uid 109); 11 Dec 2018 10:08:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Dec 2018 10:08:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3735 invoked by uid 111); 11 Dec 2018 10:07:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 11 Dec 2018 05:07:51 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Dec 2018 05:08:19 -0500
Date:   Tue, 11 Dec 2018 05:08:19 -0500
From:   Jeff King <peff@peff.net>
To:     Owen Ofiesh <oofiesh@maxlinear.com>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: Git clone fails with fatal: the remote end hung up unexpectedly
Message-ID: <20181211100819.GD31588@sigill.intra.peff.net>
References: <CY4PR19MB1526704FC790724C2DC68465ADA60@CY4PR19MB1526.namprd19.prod.outlook.com>
 <CAGyf7-HHnwJyEu8G4p4A0RxJELJkEaJGMVj5nNznhWthAgS19g@mail.gmail.com>
 <CY4PR19MB152668FA1C3E592CA123E3E5ADA60@CY4PR19MB1526.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CY4PR19MB152668FA1C3E592CA123E3E5ADA60@CY4PR19MB1526.namprd19.prod.outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 11, 2018 at 02:25:41AM +0000, Owen Ofiesh wrote:

> > On Mon, Dec 10, 2018 at 4:55 PM Owen Ofiesh <mailto:oofiesh@maxlinear.com> wrote:
> > >
> > > We are seeing an issue where git clone in Linux Ubuntu 14.04.5 LTS fails
> > > with the following error using the HTTP protocol.
> > >
> > > The error on the client is:
> > > fatal: the remote end hung up unexpectedly
> > > fatal: early EOF
> > > fatal: index-pack failed
> > >
> > > The client is writing to an NFS volume.
> > 
> > A further detail on this (Owen correct me if I'm wrong), but the same
> > clone performed to a local disk, rather than NFS, succeeds.
> 
> Correct. The clone to local disk succeeds.

That's weird. The messages imply that the server has started sending the
packfile, at which point we should be pumping data from git-remote-https
to fetch-pack, and from there into an index-pack process. And the
messages imply that the client saw a hangup of the network connection,
at which point index-pack complained of the truncated packfile (and then
we complained that index-pack complained).

But what's weird is that none of that should really be relevant to the
choice of local filesystem. Is it possible that using NFS stresses the
network to the point that the HTTP connection may be killed?

It's also possible there's something racy in Git's handling of the data,
and NFS is slower to write. What version of Git is this?

> One more data point. I tried this with SSH just now, and the behavior
> is somewhat improved in that I am only seeing the failure on the NFS
> volume so far with 1 in 6 clone attempts (5 successful). Whereas with
> HTTP, we see the failure every time.

If you use ssh's verbose mode, what does a failing case look like? If
you have Git v2.10 or later, you can just do:

  GIT_SSH_COMMAND='ssh -v' git clone ...

If it's older, the simplest thing is probably to put:

  Host yourserver...
  LogLevel Verbose

into your ~/.ssh/config.

I know the problem is more common with HTTP, but I suspect ssh's logging
may be better than ours. ;) You can also try:

  GIT_CURL_VERBOSE=1 git clone ...

or if you have recent enough (Git v2.10 again, I think), you can use:

  GIT_TRACE_CURL=1 git clone ...

which has a few more details.

-Peff
