Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40BB120986
	for <e@80x24.org>; Wed, 19 Oct 2016 20:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S943400AbcJSUgD (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 16:36:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:59631 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S942470AbcJSUfX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 16:35:23 -0400
Received: (qmail 16605 invoked by uid 109); 19 Oct 2016 20:35:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Oct 2016 20:35:22 +0000
Received: (qmail 17343 invoked by uid 111); 19 Oct 2016 20:35:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Oct 2016 16:35:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Oct 2016 16:35:20 -0400
Date:   Wed, 19 Oct 2016 16:35:20 -0400
From:   Jeff King <peff@peff.net>
To:     Santiago Torres <santiago@nyu.edu>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        walters@verbum.org, Lukas Puehringer <luk.puehringer@gmail.com>
Subject: Re: [PATCH v4 2/7] ref-filter: add function to print single
 ref_array_item
Message-ID: <20161019203520.zevkb75at2nrogdm@sigill.intra.peff.net>
References: <20161007210721.20437-1-santiago@nyu.edu>
 <20161007210721.20437-3-santiago@nyu.edu>
 <20161019085543.om7v7eowfaushags@sigill.intra.peff.net>
 <20161019091641.vcv3snlg5xr3yazs@sigill.intra.peff.net>
 <20161019170733.ey3d53miykn5t5cq@LykOS.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161019170733.ey3d53miykn5t5cq@LykOS.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 19, 2016 at 01:07:34PM -0400, Santiago Torres wrote:

> > I guess that may complicate things for the caller you add in this
> > series, which may not have a fully-qualified refname (which is obviously
> > how filter_ref_kind() figures it out). I'd argue that is a bug, though,
> > as things like "%(refname)" are generally expected to print out the
> > fully refname ("git tag --format=%(refname)" does so, and you can use
> > "%(refname:short)" if you want the shorter part).
> 
> Hmm, I hadn't actually noticed that. Do you have any suggestions in how to
> address this?
> 
> In general this feels like a consequence of disambiguating .git/tags/*
> within builtin/tag.c rather than letting ref-filter figure it out.

The partial solution would look like something below. It's not too bad
because git-tag always knows that it's working a ref in the refs/tags
namespace (and we don't even have to qualify it ourselves,
for_each_tag_name already does it for us).

But verify-tag feeds arbitrary sha1 expressions. See the notes in the
second patch.

  [1/2]: ref-filter: split ref_kind_from_filter
  [2/2]: tag: send fully qualified refnames to verify_tag_and_format

 builtin/tag.c |  2 +-
 ref-filter.c  | 21 +++++++++++++--------
 ref-filter.h  |  6 +++++-
 tag.c         |  2 +-
 4 files changed, 20 insertions(+), 11 deletions(-)

-Peff
