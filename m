Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 024B91F406
	for <e@80x24.org>; Wed, 17 Jan 2018 22:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753639AbeAQW1K (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 17:27:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:47190 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753112AbeAQW1J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 17:27:09 -0500
Received: (qmail 21741 invoked by uid 109); 17 Jan 2018 22:27:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 17 Jan 2018 22:27:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6372 invoked by uid 111); 17 Jan 2018 22:27:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 17 Jan 2018 17:27:45 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Jan 2018 17:27:07 -0500
Date:   Wed, 17 Jan 2018 17:27:07 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Christian Couder <christian.couder@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>, Kevin Daudt <me@ikke.info>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 2/2] sha1_file: improve sha1_file_name() perfs
Message-ID: <20180117222707.GA16031@sigill.intra.peff.net>
References: <20180117175455.9316-1-chriscool@tuxfamily.org>
 <20180117175455.9316-2-chriscool@tuxfamily.org>
 <3cbace45-61df-3074-a48c-66c68c96d542@jeffhostetler.com>
 <xmqq4lnkryt2.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4lnkryt2.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 17, 2018 at 12:54:33PM -0800, Junio C Hamano wrote:

> Jeff Hostetler <git@jeffhostetler.com> writes:
> 
> >>     void sha1_file_name(struct strbuf *buf, const unsigned char
> >> *sha1)
> >>   {
> >> -	strbuf_addf(buf, "%s/", get_object_directory());
> >> +	const char *obj_dir = get_object_directory();
> >> +	size_t extra = strlen(obj_dir) + 1 + GIT_MAX_HEXSZ;
> >
> > Very minor nit.  Should this be "+3" rather than "+1"?
> > One for the slash after obj_dir, one for the slash between
> > "xx/y[38]", and one for the trailing NUL.
> >
> >>   +	if (extra > strbuf_avail(buf))
> >> +		strbuf_grow(buf, extra);
> 
> The callers who care use static strbuf with 1/2, which lets them
> grow it to an appropriate size after they make their first call.
> 
> On the other hand, the ones to which performance does not matter by
> definition do not care.
> 
> I actually think this whole "extra -> grow" business should be
> discarded.  With a miscomputed "extra" like this, it does not help
> anybody---everybody may pay cost for one extra realloc due to the
> miscalculation, and the ones that do care also do during their first
> call.

Let me second that. The diffstat here, along with the magic numbers, is
not really encouraging unless we have a demonstrable speedup. In which
case we can then measure and compare other approaches, like pushing a
static strbuf farther up the stack. But without that, it feels like
stumbling around in the dark.

-Peff
