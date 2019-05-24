Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B10731F462
	for <e@80x24.org>; Fri, 24 May 2019 08:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389300AbfEXIbo (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 04:31:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:37696 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2389238AbfEXIbo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 04:31:44 -0400
Received: (qmail 26507 invoked by uid 109); 24 May 2019 08:31:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 24 May 2019 08:31:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7815 invoked by uid 111); 24 May 2019 08:32:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 24 May 2019 04:32:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 May 2019 04:31:42 -0400
Date:   Fri, 24 May 2019 04:31:42 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, git <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Matthew DeVore <matvore@google.com>
Subject: Re: how does "clone --filter=sparse:path" work?
Message-ID: <20190524083142.GC9082@sigill.intra.peff.net>
References: <20181108050755.GA32158@sigill.intra.peff.net>
 <79b06312-75ca-5a50-c337-dc6715305edb@jeffhostetler.com>
 <20181122173931.GA22123@sigill.intra.peff.net>
 <CAP8UFD0XbOUj70pt4X=HDvGBoLaG9qBv9SWGnM6N8FG3t-57rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD0XbOUj70pt4X=HDvGBoLaG9qBv9SWGnM6N8FG3t-57rg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 24, 2019 at 10:05:45AM +0200, Christian Couder wrote:

> (Sorry for the late reply to this.)

No problem. I've been meaning to pick it up again, and somehow it's been
6 months. ;)

> > > But mainly I was thinking of a use case on the client of the form:
> > >
> > >     git rev-list
> > >         --objects
> > >         --filter=spec:path=.git/sparse-checkout
> 
> Do you mean "sparse:path" instead of "spec:path"?

Yes, I think so.

> > > and get a list of the blobs that you don't have and would need before
> > > you could checkout <commit> using the current sparse-checkout definition.
> > > You could then have a pre-checkout hook that would bulk
> > > fetch them before starting the actual checkout.  Since that would be
> > > more efficient than demand-loading blobs individually during the
> > > checkout.  There's more work to do in this area, but that was the idea.
> > >
> > > But back to your point, yes, I think we should restrict this over the
> > > wire.
> >
> > Thanks for your thorough response, and sorry for the slow reply. I had
> > meant to reply with a patch adding in the restriction, but I haven't
> > quite gotten to it. :)
> 
> The way I see it could be restricted is by adding a config option on
> the server, maybe called "uploadpack.sparsePathFilter", to tell which
> filenames can be accessed using "--filter=sparse:path=".
> 
> For example with uploadpack.sparsePathFilter set to
> "/home/user/git/sparse/*" and "--filter=sparse:path=foo" then
> "/home/user/git/sparse/foo" on the server would be used if it exists.
> (Of course care should be taken that things like
> "--filter=sparse:path=bar/../../foo" are rejected.)
> 
> If uploadpack.sparsePathFilter is unset or set to "false", then
> "--filter=sparse:path=<stuff>" would always error out.
> 
> Is this what you had in mind?

My plan had been to disallow it entirely, and allow some mechanism by
which the client could specify the actual set of sparse paths itself
(which it might get from a local file, or communicated in some
out-of-band way to the user cloning, etc).

If we just want a mechanism for the server to provide a pre-made sparse
list, then I think pointing people at sparse:oid=<blob> is simpler
there. I.e., your "foo" becomes "refs/sparse/foo" or even "HEAD:.sparse"
or similar, and the server admin just sticks the content into the repo
instead of dealing with exposing filesystem paths to the client.

-Peff
