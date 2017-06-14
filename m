Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9BE820401
	for <e@80x24.org>; Wed, 14 Jun 2017 09:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751938AbdFNJXv (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 05:23:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:39845 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751919AbdFNJW7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 05:22:59 -0400
Received: (qmail 13339 invoked by uid 109); 14 Jun 2017 09:22:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jun 2017 09:22:59 +0000
Received: (qmail 9671 invoked by uid 111); 14 Jun 2017 09:23:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jun 2017 05:23:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Jun 2017 05:22:57 -0400
Date:   Wed, 14 Jun 2017 05:22:57 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?=C3=98yvind?= Holm <sunny@sunbase.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] for_each_bisect_ref(): don't trim refnames
Message-ID: <20170614092256.c3fmfcokuwbbcvbz@sigill.intra.peff.net>
References: <cover.1497430232.git.mhagger@alum.mit.edu>
 <3615deefe90bebe746618b04c055a466a442f85b.1497430232.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3615deefe90bebe746618b04c055a466a442f85b.1497430232.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 14, 2017 at 11:07:26AM +0200, Michael Haggerty wrote:

> `for_each_bisect_ref()` is called by `for_each_bad_bisect_ref()` with
> a term "bad". This used to make it call `for_each_ref_in_submodule()`
> with a prefix "refs/bisect/bad". But the latter is the name of the
> reference that is being sought, so the empty string was being passed
> to the callback as the trimmed refname. Moreover, this questionable
> practice was turned into an error by
> 
>     b9c8e7f2fb prefix_ref_iterator: don't trim too much, 2017-05-22
> 
> It makes more sense (and agrees better with the documentation of
> `--bisect`) for the callers to receive the full reference names. So
> 
> * Add a new function, `for_each_fullref_in_submodule()`, to the refs
>   API.

You might want to mention that this is really just a hole in the
existing API. We have for_each_ref_in_submodule() and
for_each_fullref_in(), but not the missing link.

I don't think that makes it any more or less correct, but I thought at
first you had to invent a new function totally.

> * Change `for_each_bad_bisect_ref()` to call the new function rather
>   than `for_each_ref_in_submodule()`.
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs.c     | 12 ++++++++++++
>  refs.h     |  5 ++++-
>  revision.c |  2 +-
>  3 files changed, 17 insertions(+), 2 deletions(-)

The change itself looks fine to me.

Since we obviously don't have even a single test for "--bisect", that
might be worth adding.

-Peff
