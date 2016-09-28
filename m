Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36805207EC
	for <e@80x24.org>; Wed, 28 Sep 2016 08:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752029AbcI1I6p (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 04:58:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:49329 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751003AbcI1I6p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 04:58:45 -0400
Received: (qmail 21655 invoked by uid 109); 28 Sep 2016 08:58:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 28 Sep 2016 08:58:43 +0000
Received: (qmail 23185 invoked by uid 111); 28 Sep 2016 08:58:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 28 Sep 2016 04:58:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Sep 2016 04:58:41 -0400
Date:   Wed, 28 Sep 2016 04:58:41 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     David Turner <novalis@novalis.org>, git@vger.kernel.org,
        David Turner <dturner@twosigma.com>
Subject: Re: thoughts on error passing, was Re: [PATCH 2/2] fsck: handle bad
 trees like other errors
Message-ID: <20160928085841.aoisson3fnuke47q@sigill.intra.peff.net>
References: <1474918365-10937-1-git-send-email-novalis@novalis.org>
 <1474918365-10937-3-git-send-email-novalis@novalis.org>
 <20160927052754.bs4frcfy4y7fey62@sigill.intra.peff.net>
 <1474989574.26902.7.camel@frank>
 <20160927191955.mympqgylrxhkp24n@sigill.intra.peff.net>
 <06b1a3bc-18dc-bd9e-4200-a2eedbec7b97@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <06b1a3bc-18dc-bd9e-4200-a2eedbec7b97@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 28, 2016 at 07:01:38AM +0200, Michael Haggerty wrote:

> >   - a global for chaining to error, like:
> > 
> >        struct error_context print_errors = {
> >           error, /* actually a wrapper to handle va_list and NULL data */
> >           NULL
> >        };
> 
> There could also be a global for chaining to `warn()` or `die()`.

I played around a little with this. The latter actually makes a lot of
code cleaner, because we can rely on the functions not returning at all.
So for example, you get:

diff --git a/branch.c b/branch.c
index a5a8dcb..53404b8 100644
--- a/branch.c
+++ b/branch.c
@@ -303,17 +303,13 @@ void create_branch(const char *head,
 
 	if (!dont_change_ref) {
 		struct ref_transaction *transaction;
-		struct strbuf err = STRBUF_INIT;
-
-		transaction = ref_transaction_begin(&err);
-		if (!transaction ||
-		    ref_transaction_update(transaction, ref.buf,
-					   sha1, forcing ? NULL : null_sha1,
-					   0, msg, &err) ||
-		    ref_transaction_commit(transaction, &err))
-			die("%s", err.buf);
+
+		transaction = ref_transaction_begin(&error_die);
+		ref_transaction_update(transaction, ref.buf,
+				       sha1, forcing ? NULL : null_sha1,
+				       0, msg, &error_die);
+		ref_transaction_commit(transaction, &error_die);
 		ref_transaction_free(transaction);
-		strbuf_release(&err);
 	}
 
 	if (real_ref && track)

which is much shorter and to the point (it does rely on the called
functions always calling report_error() and never just returning NULL or
"-1", but that should be the already. If it isn't, we'd be printing
"fatal: " with no message).

Cases that call:

  error("%s", err.buf);

can drop the strbuf handling, but of course still need to retain their
conditionals. So they're better, but not as much. I did a half-hearted
conversion of some of the ref code that uses strbufs, and it seems like
it would save a few hundred lines of boilerplate.

There are some cases that are _worse_, because they want to prefix the
error. E.g., in init-db, we have:

  struct strbuf err = STRBUF_INIT;
  ...
  if (refs_init_db(&err))
	die("failed to set up refs db: %s", err.buf);

which is fairly clean. Using an error_context adds slightly to the
boilerplate:

  struct strbuf err_buf = STRBUF_INIT;
  struct error_context err = STRBUF_ERR(&err_buf);
  ...
  if (refs_init_db(&err))
	die("failed to set up refs db: %s", err_buf.buf);

Though if we wanted to get really magical, the err_buf/err pattern could
be its own single-line macro.

You could solve this more generally with something like:

  struct error_prefix_data err;

  error_prefix(&err, &error_die, "failed to set up refs db");
  refs_init_db(&err.err);

where error_prefix() basically sets us up to call back a function which
concatenates the prefix to the real error, then chains to error_die.
But to cover all cases, error_prefix() would actually have to format the
prefix string. Because some callers would be more like:

  error_prefix(&err, &error_print, "unable to frob %s", foo);
  do_frob(foo, &err);

We can't just save the va_list passed to error_prefix(), because it's
not valid after we return. So you have to format the prefix into a
buffer, even though in most cases we won't see an error at all (and
doing it completely correctly would involve using a strbuf, which means
there needs to be a cleanup step; yuck).

-Peff
