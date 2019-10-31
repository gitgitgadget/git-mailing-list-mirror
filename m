Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 673DA1F4C0
	for <e@80x24.org>; Thu, 31 Oct 2019 18:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbfJaSGe (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 14:06:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:35196 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726602AbfJaSGd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 14:06:33 -0400
Received: (qmail 18710 invoked by uid 109); 31 Oct 2019 18:06:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 31 Oct 2019 18:06:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4053 invoked by uid 111); 31 Oct 2019 18:09:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Oct 2019 14:09:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 31 Oct 2019 14:06:32 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: git branch --edit-description a custom file
Message-ID: <20191031180632.GB2133@sigill.intra.peff.net>
References: <20191030183950.GA21277@generichostname>
 <20191030202835.GB29013@sigill.intra.peff.net>
 <20191030224328.GB44961@generichostname>
 <20191031061832.GA20830@sigill.intra.peff.net>
 <20191031173507.GA70819@generichostname>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191031173507.GA70819@generichostname>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 31, 2019 at 10:35:07AM -0700, Denton Liu wrote:

> > You could also have "refs/meta/descriptions" to point to a _single_ blob
> > with all of the descriptions. It could even be in the existing config
> > format. And then you could include it with "[include] blob = ...". That
> > doesn't exist yet, but it would be easy to add (it was something I had
> > always considered when writing the config-include code, but there was
> > never really a good use; and you do have to be careful about pointing to
> > untrusted blobs). That's a convoluted way to get where you want, but I
> > wonder if integrating to the existing config system would have any
> > benefits. I haven't really thought it through.
> 
> I like the ability to include blobs for several reasons:
> 
> Main one is that it handles the versioned branch description problem.
> But it goes further than that, there are a lot of config properties that
> teams might want to share amongst each other. For example, whenever a
> project has a custom smudge filter, usually they include some sort of
> config in the project's README or some sort of setup script. With some
> way to include a shared version of some config, this might be simpler.

There are some past discussions on sharing config, and the security
issues around it. The crux of it is that you probably ought to be
vetting config you get from elsewhere (because it can execute arbitrary
code). At which point being able to refer to a blob isn't all _that_
useful, because these two processes are not all that different:

  git show origin/meta:shared-config
  # ok, looks good; _don't_ just include it by that name, though,
  # because it may be updated by a fetch
  git branch -f meta origin/meta
  git config include.blob meta:shared-config

  git show origin/meta:shared-config
  # ok, looks good
  git cat-file blob origin/meta:shared-config >.git/shared-config
  git config include.path shared-config

There's a specific discussion I'm thinking of which goes into this line
of thinking, but I'm having trouble finding it in the archive. But IIRC,
the conclusion was negative towards directly including the blob because
it doesn't make life better for careful users, and it makes it very easy
to be unsafe for non-careful users.

There's also some (negative) discussion in this much older subthread:

  https://public-inbox.org/git/20120126074208.GD30474@sigill.intra.peff.net/

-Peff
