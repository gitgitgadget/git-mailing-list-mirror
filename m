Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21B9C1FD09
	for <e@80x24.org>; Wed, 31 May 2017 21:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751083AbdEaV3W (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 17:29:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:60806 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751004AbdEaV3V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 17:29:21 -0400
Received: (qmail 16398 invoked by uid 109); 31 May 2017 21:29:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 May 2017 21:29:21 +0000
Received: (qmail 8859 invoked by uid 111); 31 May 2017 21:29:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 May 2017 17:29:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 May 2017 17:29:20 -0400
Date:   Wed, 31 May 2017 17:29:20 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 30/33] tree-diff: convert diff_tree_paths to struct
 object_id
Message-ID: <20170531212920.yy3swp732rjfnzge@sigill.intra.peff.net>
References: <20170530173109.54904-1-bmwill@google.com>
 <20170530173109.54904-31-bmwill@google.com>
 <CAGZ79kZjVvk8GoUFMnR7XJMDyvjkKPhw_7kUYPFq_ShcW50pVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZjVvk8GoUFMnR7XJMDyvjkKPhw_7kUYPFq_ShcW50pVQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 31, 2017 at 11:24:33AM -0700, Stefan Beller wrote:

> On Tue, May 30, 2017 at 10:31 AM, Brandon Williams <bmwill@google.com> wrote:
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  combine-diff.c | 10 +++++-----
> >  diff.h         |  4 ++--
> >  tree-diff.c    | 63 +++++++++++++++++++++++++++++-----------------------------
> >  3 files changed, 39 insertions(+), 38 deletions(-)
> >
> > diff --git a/combine-diff.c b/combine-diff.c
> > index 04c4ae856..ec9d93044 100644
> > --- a/combine-diff.c
> > +++ b/combine-diff.c
> > @@ -1364,22 +1364,22 @@ static struct combine_diff_path *find_paths_multitree(
> >         struct diff_options *opt)
> >  {
> >         int i, nparent = parents->nr;
> > -       const unsigned char **parents_sha1;
> > +       const struct object_id **parents_oid;
> >         struct combine_diff_path paths_head;
> >         struct strbuf base;
> >
> > -       ALLOC_ARRAY(parents_sha1, nparent);
> > +       ALLOC_ARRAY(parents_oid, nparent);
> >         for (i = 0; i < nparent; i++)
> > -               parents_sha1[i] = parents->oid[i].hash;
> > +               parents_oid[i] = &parents->oid[i];
> 
> I have the impression that we could get away with one layer less
> of indirection. Previously we had a heap allocated array (*) of (char*),
> now we'd have a an array (*) of pointers(*) of the oid struct, that
> is a (char[]) essentially. Maybe I am just confused?

I don't think so. We always could have allocated the original as an
array of 20-byte chunks. It's syntactically less awkward in C when that
20-byte chunk is wrapped in a struct like object_id. But fundamentally
I think we don't need to be making a copy of the oid. We're pointing to
the existing copy in the "parents" array.

Or did you mean that diff_tree_paths() could now take an actual
array-of-struct rather than an array-of-pointer-to-struct? That would
drop the "parents_oid" array entirely. I think that's actually
orthogonal to this change (the same could have been done with the
original sha1 array), but would be a nice cleanup on top.

-Peff
