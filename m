Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6C50202A0
	for <e@80x24.org>; Sun,  5 Nov 2017 02:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752035AbdKECQ0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Nov 2017 22:16:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:46666 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751508AbdKECQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Nov 2017 22:16:25 -0400
Received: (qmail 14506 invoked by uid 109); 5 Nov 2017 02:16:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 05 Nov 2017 02:16:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11406 invoked by uid 111); 5 Nov 2017 02:16:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sat, 04 Nov 2017 22:16:35 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Nov 2017 22:16:23 -0400
Date:   Sat, 4 Nov 2017 22:16:23 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
        <dilyan.palauzov@aegee.org>
Cc:     git@vger.kernel.org
Subject: Re: git grep -P fatal: pcre_exec failed with error code -8
Message-ID: <20171105021623.yi46w2awwy7p3q6e@sigill.intra.peff.net>
References: <635a9bd4-2aa9-4415-2756-b82370c55798@aegee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <635a9bd4-2aa9-4415-2756-b82370c55798@aegee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 05, 2017 at 01:06:21AM +0100, Дилян Палаузов wrote:

> with git 2.14.3 linked with libpcre.so.1.2.9 when I do:
>   git clone https://github.com/django/django
>   cd django
>   git grep -P "if.*([^\s])+\s+and\s+\1"
> django/contrib/admin/static/admin/js/vendor/select2/select2.full.min.js
> the output is:
>   fatal: pcre_exec failed with error code -8

Code -8 is PCRE_ERROR_MATCHLIMIT. And "man pcreapi" has this to say:

  The match_limit field provides a means of preventing PCRE from
  using up a vast amount of resources when running patterns that
  are not going to match, but which have a very large number of
  possibilities in their search trees. The classic example is a
  pattern that uses nested unlimited repeats.

  Internally, pcre_exec() uses a function called match(), which
  it calls repeatedly (sometimes recursively). The limit set by
  match_limit is imposed on the number of times this function is
  called during a match, which has the effect of limiting the
  amount of backtracking that can take place. For patterns that
  are not anchored, the count restarts from zero for each posi‐
  tion in the subject string.

  When pcre_exec() is called with a pattern that was successfully
  studied with a JIT option, the way that the matching is exe‐
  cuted is entirely different. However, there is still the pos‐
  sibility of runaway matching that goes on for a very long time,
  and so the match_limit value is also used in this case (but in
  a different way) to limit how long the matching can continue.

  The default value for the limit can be set when PCRE is built;
  the default default is 10 million, which handles all but the
  most extreme cases. You can override the default by suppling
  pcre_exec() with a pcre_extra block in which match_limit is
  set, and PCRE_EXTRA_MATCH_LIMIT is set in the flags field. If
  the limit is exceeded, pcre_exec() returns PCRE_ERROR_MATCH‐
  LIMIT.

So your pattern is just really expensive and is running afoul of pcre's
backtracking limits (and it's not helped by the fact that the file is
basically one giant line).

There's no way to ask Git to specify a larger match_limit to pcre, but
you might be able to construct your pattern in a way that involves less
backtracking. It looks like you're trying to find things like "if foo
and foo"?

Should the captured term actually be "([^\s]+)" (with the "+" on the
_inside_ of the capture? Or maybe I'm just misunderstanding your goal.

-Peff
