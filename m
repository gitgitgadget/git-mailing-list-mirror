Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 373DE207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 18:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933479AbcI3SKA (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 14:10:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:50550 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933150AbcI3SJ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 14:09:59 -0400
Received: (qmail 25530 invoked by uid 109); 30 Sep 2016 18:09:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Sep 2016 18:09:59 +0000
Received: (qmail 12772 invoked by uid 111); 30 Sep 2016 18:10:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Sep 2016 14:10:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Sep 2016 14:09:57 -0400
Date:   Fri, 30 Sep 2016 14:09:57 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] diff_unique_abbrev(): document its assumtion and
 limitation
Message-ID: <20160930180957.xj4jqoslbtevhqpb@sigill.intra.peff.net>
References: <xmqqvaxd9ssy.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqvaxd9ssy.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 30, 2016 at 10:54:53AM -0700, Junio C Hamano wrote:

> This function is used to add "..." to displayed object names in
> "diff --raw --abbrev[=<n>]" output.  It bases its behaviour on an
> untold assumption that the abbreviation length requested by the
> caller is "reasonble", i.e. most of the objects will abbreviate
> within the requested length and the resulting length would never
> exceed it by more than a few hexdigits (otherwise the resulting
> columns would not align).  Explain that in a comment.

Heh, I have actually have a similar patch that renames it to
diff_aligned_abbrev(). Because I wanted to add another function:

  static const char *diff_abbrev_oid(const struct object_id *oid,
                                     int abbrev)
  {
        if (startup_info->have-repository)
                return find_unique_abbrev(oid->hash, abbrev);
        else {
                char *hex = oid_to_hex(oid);
                if (abbrev < 0) || abbrev > GIT_SHA1_HEXSZ)
                        die("BUG: oid abbreviation out of range: %d", abbrev);
                hex[abbrev] = '\0';
                return hex;
        }
  }

and I didn't want people to confuse the two. Now that function _would_
want to be updated as a result of the other conversation (it would need
to do something sensible with "-1", like turning it into "7", or
whatever else is deemed reasonable outside of a repository).

Anyway. I just wonder if you want to give it a better name while you are
at it.

-Peff
