Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5B5320986
	for <e@80x24.org>; Tue, 27 Sep 2016 19:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933791AbcI0TT7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 15:19:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:49026 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933067AbcI0TT6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 15:19:58 -0400
Received: (qmail 3545 invoked by uid 109); 27 Sep 2016 19:19:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Sep 2016 19:19:57 +0000
Received: (qmail 19030 invoked by uid 111); 27 Sep 2016 19:20:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Sep 2016 15:20:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Sep 2016 15:19:55 -0400
Date:   Tue, 27 Sep 2016 15:19:55 -0400
From:   Jeff King <peff@peff.net>
To:     David Turner <novalis@novalis.org>
Cc:     git@vger.kernel.org, mhagger@alum.mit.edu,
        David Turner <dturner@twosigma.com>
Subject: thoughts on error passing, was Re: [PATCH 2/2] fsck: handle bad
 trees like other errors
Message-ID: <20160927191955.mympqgylrxhkp24n@sigill.intra.peff.net>
References: <1474918365-10937-1-git-send-email-novalis@novalis.org>
 <1474918365-10937-3-git-send-email-novalis@novalis.org>
 <20160927052754.bs4frcfy4y7fey62@sigill.intra.peff.net>
 <1474989574.26902.7.camel@frank>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1474989574.26902.7.camel@frank>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 27, 2016 at 11:19:34AM -0400, David Turner wrote:

> >   typedef void (*err_fn)(const char *, ...);
> > 
> >   static int decode_tree_entry(struct tree_desc *desc,
> >                                const char *buf, unsigned long size,
> > 			       err_fn err)
> >   {
> >          ...
> >          if (size < 23 || buf[size - 21]) {
> > 	        err("too-short tree object");
> > 		return -1;
> > 	 }
> >   }
> > 
> > I dunno. Maybe that is overengineering. I guess we only hit the strbufs
> > in the error path (which used to die!), so nobody really cares that much
> > about the extra allocation.
> 
> I don't really like err_fn because:
> (a) without a baton, it's somewhat less general (or less thread-safe)
> than the strbuf approach and
> (b) with a baton, it's two arguments instead of one.

I'm going to ramble for a minute, and I don't think it's worth exploring
for this patch series in particular, so feel free to ignore me.

I think this error concept could be extended fairly elegantly with
something like:

  typedef void (*err_fn)(void *, const char *fmt, va_list ap)
  struct error_context {
        err_fn fn;
        void *data;
  };

  int report_error(struct error_context *err, const char *fmt, ...)
  {
        if (err->fn) {
                va_list ap;
                va_start(ap, fmt);
                err->fn(err->data, fmt, ap);
                va_end(ap);
        }
        return -1;
  }

Then low-level functions just take a context and do:

  return report_error(&err, "some error: %s", foo);

And then the callers would pick one of a few generic error contexts:

  - passing NULL silences the errors

  - a global for chaining to error, like:

       struct error_context print_errors = {
          error, /* actually a wrapper to handle va_list and NULL data */
          NULL
       };

   - a context that collects errors in a strbuf (or list, etc)

       struct strbuf err_buf = STRBUF_INIT;
       struct error_context = STRBUF_ERR_CONTEXT(&err_buf);

And that error_context can be passed around like a baton through several
functions.

I remember having a big discussion about error-passing patterns around
the ref refactoring, but I don't remember this particular thing coming
up. 

Anyway, this is all way outside the scope of what we should consider for
your current series. If we were to do something like this, it would make
sense to start using it consistently. This discussion just made me think
of it.

-Peff
