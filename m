Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD41AC433E0
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 09:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D49C23107
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 09:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732748AbhALJmg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 04:42:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:53192 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbhALJmg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 04:42:36 -0500
Received: (qmail 7468 invoked by uid 109); 12 Jan 2021 09:41:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Jan 2021 09:41:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11431 invoked by uid 111); 12 Jan 2021 09:41:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Jan 2021 04:41:57 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Jan 2021 04:41:55 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH 01/20] pack-revindex: introduce a new API
Message-ID: <X/1u46v1dhu0Aj8G@coredump.intra.peff.net>
References: <cover.1610129796.git.me@ttaylorr.com>
 <fa6b8309088fd04410ca7276c5cf14db0fb82fb2.1610129796.git.me@ttaylorr.com>
 <X/1guCOGWybOzIS7@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X/1guCOGWybOzIS7@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 12, 2021 at 03:41:28AM -0500, Jeff King wrote:

> > +int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos)
> > +{
> > +	int ret;
> > +
> > +	if (load_pack_revindex(p) < 0)
> > +		return -1;
> 
> This one lazy-loads the revindex for us, which seems handy...
> 
> > +uint32_t pack_pos_to_index(struct packed_git *p, uint32_t pos)
> > +{
> > +	if (!p->revindex)
> > +		BUG("pack_pos_to_index: reverse index not yet loaded");
> > +	if (pos >= p->num_objects)
> > +		BUG("pack_pos_to_index: out-of-bounds object at %"PRIu32, pos);
> > +	return p->revindex[pos].nr;
> > +}
> 
> But these ones don't. I'm glad we at least catch it with a BUG(), but it
> makes the API a little funny. Returning an error here would require a
> similarly awkward out-parameter, I guess.

Having now looked at the callers through the series, I think adding an
error return to pack_pos_to_index() would be really awkward (since it
cannot currently fail).

We _could_ insist that callers of offset_to_pack_pos() also make sure
the revindex is loaded themselves. But it would be annoying and
error-prone to check the existing callers. So I'm OK with leaving this
asymmetry in the API.

-Peff
