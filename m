Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04F0520372
	for <e@80x24.org>; Thu, 12 Oct 2017 13:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756721AbdJLNgj (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 09:36:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:50922 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753248AbdJLNgj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 09:36:39 -0400
Received: (qmail 15574 invoked by uid 109); 12 Oct 2017 13:36:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Oct 2017 13:36:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15713 invoked by uid 111); 12 Oct 2017 13:36:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Oct 2017 09:36:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Oct 2017 09:36:37 -0400
Date:   Thu, 12 Oct 2017 09:36:37 -0400
From:   Jeff King <peff@peff.net>
To:     Andreas Krey <a.krey@gmx.de>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: git repack leaks disk space on ENOSPC
Message-ID: <20171012133636.isvg5typrputvxmm@sigill.intra.peff.net>
References: <20171011150546.GC32090@inner.h.apk.li>
 <20171012031702.GB155740@aiede.mtv.corp.google.com>
 <20171012093439.GD32090@inner.h.apk.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171012093439.GD32090@inner.h.apk.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 12, 2017 at 11:34:39AM +0200, Andreas Krey wrote:

> > Does using create_tempfile there seem like a good path forward to you?
> > Would you be interested in working on it (either writing a patch with
> > such a fix or a test in t/ to make sure it keeps working)?
> 
> I will look into creating a patch (thanks for the pointers),
> but I don't see how to make a testcase for this - pre-filling the
> disk doesn't sound like a good idea. Most people probably won't run in
> this situation, and then won't have tmp_packs with a dozen GBytes each
> lying around.

It may be easier to trigger a case which rejects the pack for other
reasons. For an incoming index-pack, turning on transfer.fsckObjects is
an easy one. For a repack, perhaps corrupting a loose object
to-be-packed would work.

E.g.:

  git init
  echo content >file
  git add file
  git commit -m foo

  # corrupt the blob in a subtle way
  obj=.git/objects/$(git rev-parse HEAD:file | sed 's,..,&/,')
  chmod +w $obj
  echo cruft >>$obj

After that, I get:

  $ git repack -ad
  Counting objects: 3, done.
  error: garbage at end of loose object 'd95f3ad14dee633a758d2e331151e950dd13e4ed'
  fatal: loose object d95f3ad14dee633a758d2e331151e950dd13e4ed (stored in .git/objects/d9/5f3ad14dee633a758d2e331151e950dd13e4ed) is corrupt

  $ find -type f .git/objects/pack
  .git/objects/pack/tmp_pack_0GaXwk

-Peff
