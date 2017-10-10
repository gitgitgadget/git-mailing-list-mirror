Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFBD42036B
	for <e@80x24.org>; Tue, 10 Oct 2017 12:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755349AbdJJMgh (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 08:36:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:48194 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755245AbdJJMgh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 08:36:37 -0400
Received: (qmail 9788 invoked by uid 109); 10 Oct 2017 12:36:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Oct 2017 12:36:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25794 invoked by uid 111); 10 Oct 2017 12:36:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Oct 2017 08:36:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Oct 2017 08:36:34 -0400
Date:   Tue, 10 Oct 2017 08:36:34 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        gitster@pobox.com, ramsay@ramsayjones.plus.com, sbeller@google.com
Subject: Re: [PATCH v4 4/4] sha1_name: minimize OID comparisons during
 disambiguation
Message-ID: <20171010123634.3hdqxpo6mbl6jhbx@sigill.intra.peff.net>
References: <20171008184942.69444-1-dstolee@microsoft.com>
 <20171008184942.69444-5-dstolee@microsoft.com>
 <20171009134933.vmba67adelqbkx4y@sigill.intra.peff.net>
 <338aab6a-1181-d740-1bf2-2ac86749a6b2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <338aab6a-1181-d740-1bf2-2ac86749a6b2@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 10, 2017 at 08:16:27AM -0400, Derrick Stolee wrote:

> > > +	mad->init_len = 0;
> > > +	if (!match) {
> > > +		nth_packed_object_oid(&oid, p, first);
> > > +		extend_abbrev_len(&oid, mad);
> > If we have zero objects in the pack, what would nth_packed_object_oid()
> > be returning here?
> > 
> > So I actually think we do want an early return, not just when
> > open_packed_index() fails, but also when p->num_objects is zero.
> > 
> > -Peff
> 
> Sorry about this. I caught this while I was writing my cover letter and
> amended my last commit to include the following:
> 
>     if (open_pack_index(p))
>         return;
> 
> After I amended the commit, I forgot to 'format-patch' again. I can send a
> diff between the commits after review has calmed.

OK, I think that makes more sense. But note the p->num_objects thing I
mentioned. If I do:

  git pack-objects .git/objects/pack/pack </dev/null

then I have a pack with zero objects, which I think we'd similarly want
to return early from. I.e., I think we need:

  if (p->num_objects)
	return;

Technically that also covers open_pack_index() failure, too, but that's
a subtlety I don't think we should rely on.

-Peff
