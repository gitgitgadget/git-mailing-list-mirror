Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1033A1FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 19:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759945AbcLATf7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 14:35:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:50041 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754848AbcLATf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 14:35:59 -0500
Received: (qmail 11517 invoked by uid 109); 1 Dec 2016 19:35:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 19:35:58 +0000
Received: (qmail 2413 invoked by uid 111); 1 Dec 2016 19:36:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 14:36:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Dec 2016 14:35:56 -0500
Date:   Thu, 1 Dec 2016 14:35:56 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/3] compat: add qsort_s()
Message-ID: <20161201193556.j2odwy3sepaxxq5a@sigill.intra.peff.net>
References: <3083fbf7-d67e-77e4-e05f-94a7e7e15eba@web.de>
 <fc602a66-a06c-203e-b50b-55fd7b258b54@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc602a66-a06c-203e-b50b-55fd7b258b54@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 01, 2016 at 05:26:43PM +0100, René Scharfe wrote:

> The function qsort_s() was introduced with C11 Annex K; it provides the
> ability to pass a context pointer to the comparison function, supports
> the convention of using a NULL pointer for an empty array and performs a
> few safety checks.
> 
> Add an implementation based on compat/qsort.c for platforms that lack a
> native standards-compliant qsort_s() (i.e. basically everyone).  It
> doesn't perform the full range of possible checks: It uses size_t
> instead of rsize_t and doesn't check nmemb and size against RSIZE_MAX
> because we probably don't have the restricted size type defined.  For
> the same reason it returns int instead of errno_t.

Hmm. So it sounds like qsort_r(), but with the NULL-is-empty magic. But
we already are OK without the latter (and can emulate it easily). Would
it make sense to do:

  #if defined(HAVE_QSORT_S)
  /* huzzah, use the system-native qsort_s */

  #elif defined(HAVE_QSORT_R)
  int git_qsort_s(void *b, size_t n, size_t s,
		   int (*cmp)(const void *, const void *, void *), void *ctx)
  {
	if (!n)
		return 0;
	if (!b || !cmp)
		return -1;
	qsort_r(b, n, s, cmp, ctx);
	return 0;
  }

  #else
  /* fallback implementation as your patch does */
  #endif

To make matters more fun, apparently[1] there are multiple variants of
qsort_r with different argument orders. _And_ apparently Microsoft
defines qsort_s, but it's not quite the same thing. But all of that can
be dealt with by having more specific flags (HAVE_GNU_QSORT_R, etc).

It just seems like we should be able to do a better job of using the
system qsort in many cases.

-Peff

[1] https://stackoverflow.com/questions/39560773/different-declarations-of-qsort-r-on-mac-and-linux/39561369
