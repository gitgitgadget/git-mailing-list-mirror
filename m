Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9EC81F462
	for <e@80x24.org>; Thu,  6 Jun 2019 22:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfFFWdq (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 18:33:46 -0400
Received: from resqmta-ch2-03v.sys.comcast.net ([69.252.207.35]:50792 "EHLO
        resqmta-ch2-03v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725267AbfFFWdq (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 6 Jun 2019 18:33:46 -0400
Received: from resomta-ch2-04v.sys.comcast.net ([69.252.207.100])
        by resqmta-ch2-03v.sys.comcast.net with ESMTP
        id YtCfhdog2hSS1Z0x7hmq5e; Thu, 06 Jun 2019 22:33:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1559860425;
        bh=878LynNf35eCPgUw8+JYQHAHU6l210DfasKtflQEtgY=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=m9E/2NduCtxZ8eDY/5eE1QZOT7p3oWKc+ejqBPPN2WEbFtar/cf2qz1BC6Wy9T22/
         Sss0DtxemR3Vc7vos3fBJrmexgJw9HBCox1xU94RuVIhbD4WDvsuKQ583CyPMdWPYy
         1QAagXuDcLIfSLwu9X9T1HjVwnLW2wTRgIDq0rHObNUWCR7ikT9XrhNXeSilOlyoBa
         ifPBqGD2ZoKVKS/p1In1qJIdBN9ZUla8EswtgGnp6tjkoxU1kYYOS7zEZH7FWHPvrz
         Z6NxETp0CzJ6ox1NJVnqe8vt84W8vSYGAzcbAdWHD69IfRyMT7fEm0zEVks4oH6QC7
         wXMYYDAWOnIGA==
Received: from comcast.net ([IPv6:2620:15c:2ce:200:fd28:a9c3:fb88:6b87])
        by resomta-ch2-04v.sys.comcast.net with ESMTPSA
        id Z0wFh0QqYXrm0Z0wghHDFE; Thu, 06 Jun 2019 22:33:43 +0000
X-Xfinity-VMeta: sc=0;st=legit
Date:   Thu, 6 Jun 2019 15:32:51 -0700
From:   Matthew DeVore <matvore@comcast.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Matthew DeVore <matvore@google.com>, git@vger.kernel.org,
        jonathantanmy@google.com, jrn@google.com, dstolee@microsoft.com,
        jeffhost@microsoft.com, jrnieder@gmail.com, pclouds@gmail.com,
        emilyshaffer@google.com, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/9] list-objects-filter: implement composite filters
Message-ID: <20190606223251.GA7246@comcast.net>
References: <20190601003603.90794-1-matvore@google.com>
 <20190601003603.90794-5-matvore@google.com>
 <0005347e-ceed-ac9e-ad0d-b7b11bc55d38@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0005347e-ceed-ac9e-ad0d-b7b11bc55d38@jeffhostetler.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 03, 2019 at 05:51:28PM -0400, Jeff Hostetler wrote:
> Since we are assuming 'compose' is an AND operation, there may be an
> opportunity to short-cut some of this loop for blobs.  That is, if the
> object is a blob and any filter rejects it, it is omitted, so we don't
> need to keep looping for that object.  (Tree objects cannot be short-cut
> this way because a tree may appear at different depths or in different
> sparse "cones" and may have to be reconsidered.)

Blobs are also treated almost the same way as tree objects in tree:<depth>
filters - they can be included by tree:<depth> - so they also need to be
reconsidered when found at different depths.

But I agree it's always true that if some prior filter has excluded a blob, the
later filters don't even need to be *called at all* for that blob, unless
perhaps it's found under a different tree later. I also think it may be too
early to implement this optimization, since filter in a later release may just
want to "know" about a blob even if it must be excluded in the final result.

Does the optimization apply to trees as well? Does a tree:<depth> filter still
want to consider children of tree X if tree X has already been excluded by
another filter? If it doesn't want to consider, we can short-circuit the checks
very aggressively. If it does want to consider, we want the short-circuiting to
be customizable at least for trees.

A minor point - I don't think that short-circuiting the for loop (breaking out
early) is important, since it will be very rare that a combine: filter has more
than 4 or so sub-filters anyway. Calling the filter_fn implementation and
letting that do internal short-circuiting (informed by the previous filters'
results) can, however, skip a lot of computation.

> So you could add an "affects blobs only" bit to the per-filter data
> and try this out.  For example a "compose:blob:none+sparse:foo" should
> perform better than "compose:sparse:foo+blob:none" but give the same
> results.

Does "affects blobs only" mean the filter includes all non-blob objects?
