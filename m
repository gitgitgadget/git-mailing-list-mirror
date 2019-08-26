Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 197051F461
	for <e@80x24.org>; Mon, 26 Aug 2019 18:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387776AbfHZSS0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 14:18:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:56138 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2387768AbfHZSS0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 14:18:26 -0400
Received: (qmail 6417 invoked by uid 109); 26 Aug 2019 18:18:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 26 Aug 2019 18:18:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22356 invoked by uid 111); 26 Aug 2019 18:19:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 26 Aug 2019 14:19:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 26 Aug 2019 14:18:24 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Sperling <stsp@stsp.name>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] fix segv with corrupt tag object
Message-ID: <20190826181824.GA22960@sigill.intra.peff.net>
References: <20190824230944.GA14132@jessup.stsp.name>
 <bcc29199-a4ac-6bdc-6715-9807737253d8@web.de>
 <20190826115715.GB71935@jessup.stsp.name>
 <xmqqo90bhmi3.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo90bhmi3.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 26, 2019 at 10:20:20AM -0700, Junio C Hamano wrote:

> Stefan Sperling <stsp@stsp.name> writes:
> 
> > The root cause of this bug seems to be that the valid assumption
> > that obj->parsed implies a successfully parsed object is broken by
> > parse_tag_buffer() because this function sets the 'parsed' flag even
> > if errors occur during parsing.
> 
> I am mildly negative about that approach.  obj->parsed is about
> "we've done all we need to do to attempt parsing this object" (so
> that next person who gets hold of the object knows that fact---one
> of the reasons why may be that the caller who wants to ensure that
> the fields are ready to be accessed does not have to spend extra
> cycles, but that is not the only one).  Those that want to look at
> various fields in the object (e.g. the tagged object of a tag, the
> tagger identity of a tag, etc.) should be prepared to see and react
> to NULL in there so that they can gracefully handle "slightly"
> corrupt objects.

It seems like the right place to notice "we did not parse correctly" is
an error return from parse_tag_buffer(). We're not calling it ourselves
in this instance, but it looks like it does get propagated from
parse_object(), which would yield NULL.

I wonder if some earlier caller in checkout/archive is ignoring a parse
failure, and continuing to work with the object anyway.

Avoiding setting the parse flag is a cheap way to make sure that the
later calls re-attempt the parse and notice the error themselves. That
wastes some work in the case of a bogus tag, but callers who want to
view the corrupted state aren't really any worse off.

That said, the error condition touched by Stefan's updated patch is not
sufficient to guarantee that tag->tagged is non-NULL (whether we detect
the error case by return code or by lack of "parsed" flag). The code
does this:

          if (!strcmp(type, blob_type)) {
                  item->tagged = (struct object *)lookup_blob(r, &oid);
          } else if (!strcmp(type, tree_type)) {
                  item->tagged = (struct object *)lookup_tree(r, &oid);
          } else if (!strcmp(type, commit_type)) {
                  item->tagged = (struct object *)lookup_commit(r, &oid);
          } else if (!strcmp(type, tag_type)) {
                  item->tagged = (struct object *)lookup_tag(r, &oid);
          } else {
                  error("Unknown type %s", type);
                  item->tagged = NULL;
          }

Any of those lookup_* functions may also return. It's relatively rare,
since we don't actually confirm the type against the object database at
that time. But it can happen if the same program already saw that
particular oid as another type. This is tricky to trigger for
checkout/archive because they generally parse the tag first (but not
impossible; e.g., some config like mailmap.blob may read objects early).
But anything using the revision parser is happy to read multiple
objects.

If we want to cover all cases, probably something like:

  if (!item->tagged)
	ret = -1;

would be simplest.

-Peff
