Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B1BB2036B
	for <e@80x24.org>; Thu,  5 Oct 2017 09:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751323AbdJEJNi (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 05:13:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:33236 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751272AbdJEJNg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 05:13:36 -0400
Received: (qmail 14484 invoked by uid 109); 5 Oct 2017 09:13:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Oct 2017 09:13:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25559 invoked by uid 111); 5 Oct 2017 09:13:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Oct 2017 05:13:36 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Oct 2017 05:13:34 -0400
Date:   Thu, 5 Oct 2017 05:13:34 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        stolee@gmail.com, git@jeffhostetler.com, sbeller@google.com
Subject: Re: [PATCH v3 3/5] sha1_name: Unroll len loop in find_unique_abbrev_r
Message-ID: <20171005091334.7oyjaco432l5p6ft@sigill.intra.peff.net>
References: <20170925095452.66833-1-dstolee@microsoft.com>
 <20171002145651.204984-4-dstolee@microsoft.com>
 <xmqqtvzfcuoy.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtvzfcuoy.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 04, 2017 at 03:07:25PM +0900, Junio C Hamano wrote:

> > -	exists = has_sha1_file(sha1);
> > -	while (len < GIT_SHA1_HEXSZ) {
> > -		struct object_id oid_ret;
> > -		status = get_short_oid(hex, len, &oid_ret, GET_OID_QUIETLY);
> > -		if (exists
> > -		    ? !status
> > -		    : status == SHORT_NAME_NOT_FOUND) {
> > -			hex[len] = 0;
> > -			return len;
> > -		}
> > -		len++;
> > -	}
> > -	return len;
> 
> The "always_call_fn" thing is a big sledgehammer that overrides
> everything else in update_candidates().  It bypasses the careful
> machinery set up to avoid having to open ambiguous object to learn
> their types as much as possible.  One narrow exception when it is OK
> to use is if we never limit our candidates with type.
> 
> And it might appear that the conversion is safe (if only because we
> do not see any type limitation in the get_short_oid() call above),
> but I think there is one case where this patch changes the
> behaviour: what happens if core.disambiguate was set to anything
> other than "none"?  The new code does not know anything about type
> based filtering, so it can end up reporting longer abbreviation than
> it was asked to produce.  It may not be a problem in practice, though.
> 
> I am not sure if setting core.disambiguate is generally a good idea
> in the first place, and if it is OK to break find_unique_abbrev()
> with respect to the configuration variable like this patch does.
> 
> I'd feel safe if we get extra input from Peff, who introduced the
> feature in 5b33cb1f ("get_short_sha1: make default disambiguation
> configurable", 2016-09-27).

Regarding core.disambiguate, I _do_ think it's reasonable to set it to
"commit" or "committish". And in fact I have meant to revisit the idea
of doing so by default (the reason it was made into config at all was to
let people play around with it and gain experience).

That said, I think it's entirely reasonable for find_unique_abbrev() to
ignore type-based disambiguation entirely.

The type disambiguation is really a property of the context in which we
do a lookup. And that context is not necessarily known to the generating
side. Even core.disambiguate is not universal, as command-specific
context overrides it.

So I think on the generating side we are better off creating a slightly
longer abbreviation that is unambiguous no matter what context it is
used in. I.e., I'd argue that it's actually more _correct_ to ignore
the disambiguation code entirely on the generating side.

And it should also be faster, because it turns the abbreviation search
into a purely textual one that never has to look at extra objects. And
that speed matters a lot more on the generating side, where we tend to
output long lists of abbreviated sha1s in commands like "git log" (as
opposed to the lookup side, where we're asked to find some particular
item of interest).

-Peff
