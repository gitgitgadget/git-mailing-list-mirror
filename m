Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2A641F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 19:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752897AbcJETEs (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 15:04:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:53012 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752257AbcJETEs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 15:04:48 -0400
Received: (qmail 8230 invoked by uid 109); 5 Oct 2016 19:04:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 05 Oct 2016 19:04:47 +0000
Received: (qmail 20900 invoked by uid 111); 5 Oct 2016 19:05:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 05 Oct 2016 15:05:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Oct 2016 15:04:45 -0400
Date:   Wed, 5 Oct 2016 15:04:45 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 07/18] link_alt_odb_entry: handle normalize_path errors
Message-ID: <20161005190445.4kxc2sqbbpfrnsjf@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
 <20161003203417.izcgwt4yz3yspdnm@sigill.intra.peff.net>
 <40d3920f-2267-f76d-a5e0-6868fb9f9be2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40d3920f-2267-f76d-a5e0-6868fb9f9be2@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 05, 2016 at 08:47:29PM +0200, René Scharfe wrote:

> > Instead, let's provide a strbuf helper that does an in-place
> > normalize, but restores the original contents on error. This
> > uses a second buffer under the hood, which is slightly less
> > efficient, but this is not a performance-critical code path.
> 
> Hmm, in-place functions are quite rare in the strbuf collection.  It looks
> like a good fit for the two callers and makes sense in general, though.

Yeah, I almost wrote "strbuf_add_normalized_path()" instead. But then
the callers end up having to do the allocate-and-swap thing themselves.
And I think we're still set in the future to add that if somebody wants
it (and we can then implement the in-place version in terms of it).

Another alternative is to observe that the strbuf is generally used in
the first place to make the path absolute. So another interface is
perhaps something like:

  strbuf_add_path(struct strbuf *sb, const char *path,
                  const char *relative_base)
  {
        struct strbuf scratch = STRBUF_INIT;
        int ret;

        if (is_absolute_path(path))
                strbuf_grow(sb, strlen(path));
        else {
                if (relative_path)
                        strbuf_addstr(&scratch, path);
                else {
                        if (strbuf_getcwd(&scratch))
                                return -1;
                }
                strbuf_addch(&scratch, '/');
                strbuf_addstr(&scratch, path);

                strbuf_grow(sb, scratch.len);
                path = scratch.buf;
        }

        ret = normalize_path_copy(sb.buf + sb.len, path);
        strbuf_release(&scratch);
        return ret;
  }

I don't think its worth the complexity of interface for the spots in
this series, but maybe there are other places that could use it. I'll
leave that to somebody else to explore if the ywant to.

-Peff
